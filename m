Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knf9q-0002QG-VL
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 09:56:15 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v9 1/2] um: irq/sigio: support suspend/resume handling of
 workaround IRQs
Date: Fri, 11 Dec 2020 10:56:07 +0100
Message-Id: <20201211105608.360ad4134981.I8977ac4a1a8c221ec8974574a4f9e2b7586dd943@changeid>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

If the sigio workaround needed to be applied to a file descriptor,
set_irq_wake() wouldn't work for it since it would get polled by
the thread instead of causing SIGIO, and thus could never really
cause a wakeup, since the thread notification FD wasn't marked as
being able to wake up the system.

Fix this by marking the thread's notification FD explicitly as a
wake source FD, i.e. not suppressing SIGIO for it in suspend. In
order to not cause spurious wakeups, we then need to remove all
FDs that shouldn't wake up the system from the polling thread. In
order to do this, add unlocked versions of ignore_sigio_fd() and
add_sigio_fd() (nothing else is happening in suspend, so this is
fine), and also modify ignore_sigio_fd() to return -ENOENT if the
FD wasn't originally in there. This doesn't matter because nothing
else currently checks the return value, but the irq code needs to
know which ones to restore the workaround for.

All told, this lets us use a timerfd for the RTC clock in the next
patch, which doesn't send SIGIO.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/os.h |  8 +++++++
 arch/um/kernel/irq.c        | 17 +++++++++++++-
 arch/um/os-Linux/sigio.c    | 47 +++++++++++++++++++++++++------------
 3 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index cd750d4edfb5..bc25c960f7e0 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -316,6 +316,14 @@ extern int add_sigio_fd(int fd);
 extern int ignore_sigio_fd(int fd);
 extern void maybe_sigio_broken(int fd);
 extern void sigio_broken(int fd);
+/*
+ * unlocked versions for IRQ controller code.
+ *
+ * This is safe because it's used at suspend/resume and nothing
+ * else is running.
+ */
+extern int __add_sigio_fd(int fd);
+extern int __ignore_sigio_fd(int fd);
 
 /* prctl.c */
 extern int os_arch_prctl(int pid, int option, unsigned long *arg2);
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index ea43312cbfd3..3741d2380060 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -45,6 +45,7 @@ struct irq_entry {
 	int fd;
 	struct irq_reg reg[NUM_IRQ_TYPES];
 	bool suspended;
+	bool sigio_workaround;
 };
 
 static DEFINE_SPINLOCK(irq_lock);
@@ -392,7 +393,14 @@ void um_irqs_suspend(void)
 			if (!entry->reg[t].events)
 				continue;
 
-			if (entry->reg[t].wakeup) {
+			/*
+			 * For the SIGIO_WRITE_IRQ, which is used to handle the
+			 * SIGIO workaround thread, we need special handling:
+			 * enable wake for it itself, but below we tell it about
+			 * any FDs that should be suspended.
+			 */
+			if (entry->reg[t].wakeup ||
+			    entry->reg[t].irq == SIGIO_WRITE_IRQ) {
 				wake = true;
 				break;
 			}
@@ -401,6 +409,8 @@ void um_irqs_suspend(void)
 		if (!wake) {
 			entry->suspended = true;
 			os_clear_fd_async(entry->fd);
+			entry->sigio_workaround =
+				!__ignore_sigio_fd(entry->fd);
 		}
 	}
 	spin_unlock_irqrestore(&irq_lock, flags);
@@ -418,6 +428,11 @@ void um_irqs_resume(void)
 
 			WARN(err < 0, "os_set_fd_async returned %d\n", err);
 			entry->suspended = false;
+
+			if (entry->sigio_workaround) {
+				err = __add_sigio_fd(entry->fd);
+				WARN(err < 0, "add_sigio_returned %d\n", err);
+			}
 		}
 	}
 	spin_unlock_irqrestore(&irq_lock, flags);
diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 79cd6d6d6211..6597ea1986ff 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -164,47 +164,55 @@ static void update_thread(void)
 	set_signals_trace(flags);
 }
 
-int add_sigio_fd(int fd)
+int __add_sigio_fd(int fd)
 {
 	struct pollfd *p;
 	int err, i, n;
 
-	sigio_lock();
 	for (i = 0; i < all_sigio_fds.used; i++) {
 		if (all_sigio_fds.poll[i].fd == fd)
 			break;
 	}
-	if (i == all_sigio_fds.used) {
-		err = -ENOSPC;
-		goto out;
-	}
+	if (i == all_sigio_fds.used)
+		return -ENOSPC;
 
 	p = &all_sigio_fds.poll[i];
 
 	for (i = 0; i < current_poll.used; i++) {
 		if (current_poll.poll[i].fd == fd)
-			goto out;
+			return 0;
 	}
 
 	n = current_poll.used;
 	err = need_poll(&next_poll, n + 1);
 	if (err)
-		goto out;
+		return err;
 
 	memcpy(next_poll.poll, current_poll.poll,
 	       current_poll.used * sizeof(struct pollfd));
 	next_poll.poll[n] = *p;
 	next_poll.used = n + 1;
 	update_thread();
- out:
+
+	return 0;
+}
+
+
+int add_sigio_fd(int fd)
+{
+	int err;
+
+	sigio_lock();
+	err = __add_sigio_fd(fd);
 	sigio_unlock();
+
 	return err;
 }
 
-int ignore_sigio_fd(int fd)
+int __ignore_sigio_fd(int fd)
 {
 	struct pollfd *p;
-	int err = 0, i, n = 0;
+	int err, i, n = 0;
 
 	/*
 	 * This is called from exitcalls elsewhere in UML - if
@@ -214,17 +222,16 @@ int ignore_sigio_fd(int fd)
 	if (write_sigio_pid == -1)
 		return -EIO;
 
-	sigio_lock();
 	for (i = 0; i < current_poll.used; i++) {
 		if (current_poll.poll[i].fd == fd)
 			break;
 	}
 	if (i == current_poll.used)
-		goto out;
+		return -ENOENT;
 
 	err = need_poll(&next_poll, current_poll.used - 1);
 	if (err)
-		goto out;
+		return err;
 
 	for (i = 0; i < current_poll.used; i++) {
 		p = &current_poll.poll[i];
@@ -234,8 +241,18 @@ int ignore_sigio_fd(int fd)
 	next_poll.used = current_poll.used - 1;
 
 	update_thread();
- out:
+
+	return 0;
+}
+
+int ignore_sigio_fd(int fd)
+{
+	int err;
+
+	sigio_lock();
+	err = __ignore_sigio_fd(fd);
 	sigio_unlock();
+
 	return err;
 }
 
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

