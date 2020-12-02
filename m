Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkQnl-0008OS-HI
 for linux-um@lists.infradead.org; Wed, 02 Dec 2020 12:00:08 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 6/7] um: remove IRQ_NONE type
Date: Wed,  2 Dec 2020 12:59:55 +0100
Message-Id: <20201202125915.c5309340fc3e.Id467f02803b7fb8edf0255d7588e63a01ca9c1e8@changeid>
In-Reply-To: <20201202115956.42963-1-johannes@sipsolutions.net>
References: <20201202115956.42963-1-johannes@sipsolutions.net>
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
Cc: Johannes Berg <johannes.berg@intel.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Johannes Berg <johannes.berg@intel.com>

We don't actually use this in um_request_irq(), so it can
never be assigned. It's also not clear what that would be
useful for, so just remove it.

This results in quite a number of cleanups, all the way to
removing the "SIGIO on close" startup check, since the data
it assigns (pty_close_sigio) is not used anymore.

While at it, also make this an enum so we get a minimum of
type checking, and remove the IRQ_NONE hack in virtio since
we now no longer have the name twice.

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/random.c          |  2 +-
 arch/um/drivers/virtio_uml.c      |  5 -----
 arch/um/include/shared/irq_kern.h |  7 ++++---
 arch/um/include/shared/irq_user.h |  9 +++++----
 arch/um/include/shared/os.h       |  6 +++---
 arch/um/kernel/irq.c              | 15 +++++++--------
 arch/um/os-Linux/irq.c            |  2 +-
 arch/um/os-Linux/sigio.c          | 25 +++++--------------------
 8 files changed, 26 insertions(+), 45 deletions(-)

diff --git a/arch/um/drivers/random.c b/arch/um/drivers/random.c
index 385cb08d7ec2..efbf88ec48ac 100644
--- a/arch/um/drivers/random.c
+++ b/arch/um/drivers/random.c
@@ -132,7 +132,7 @@ static int __init rng_init (void)
 	if (err < 0)
 		goto err_out_cleanup_hw;
 
-	sigio_broken(random_fd, 1);
+	sigio_broken(random_fd);
 
 	err = misc_register (&rng_miscdev);
 	if (err) {
diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 94b112749d5b..27e92d3881ff 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -33,11 +33,6 @@
 #include <os.h>
 #include "vhost_user.h"
 
-/* Workaround due to a conflict between irq_user.h and irqreturn.h */
-#ifdef IRQ_NONE
-#undef IRQ_NONE
-#endif
-
 #define MAX_SUPPORTED_QUEUE_SIZE	256
 
 #define to_virtio_uml_device(_vdev) \
diff --git a/arch/um/include/shared/irq_kern.h b/arch/um/include/shared/irq_kern.h
index 7c04a0fd3a27..7807de593bda 100644
--- a/arch/um/include/shared/irq_kern.h
+++ b/arch/um/include/shared/irq_kern.h
@@ -8,11 +8,12 @@
 
 #include <linux/interrupt.h>
 #include <asm/ptrace.h>
+#include "irq_user.h"
 
 #define UM_IRQ_ALLOC	-1
 
-int um_request_irq(int irq, int fd, int type, irq_handler_t handler,
-		   unsigned long irqflags,  const char * devname,
-		   void *dev_id);
+int um_request_irq(int irq, int fd, enum um_irq_type type,
+		   irq_handler_t handler, unsigned long irqflags,
+		   const char *devname, void *dev_id);
 void um_free_irq(int irq, void *dev_id);
 #endif
diff --git a/arch/um/include/shared/irq_user.h b/arch/um/include/shared/irq_user.h
index 5e975a9e8354..07239e801a5b 100644
--- a/arch/um/include/shared/irq_user.h
+++ b/arch/um/include/shared/irq_user.h
@@ -9,10 +9,11 @@
 #include <sysdep/ptrace.h>
 #include <stdbool.h>
 
-#define IRQ_READ  0
-#define IRQ_WRITE 1
-#define IRQ_NONE 2
-#define NUM_IRQ_TYPES (IRQ_NONE + 1)
+enum um_irq_type {
+	IRQ_READ,
+	IRQ_WRITE,
+	NUM_IRQ_TYPES,
+};
 
 struct siginfo;
 extern void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index f467d28fc0b4..e2bb7e488d59 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -299,7 +299,7 @@ extern void reboot_skas(void);
 extern int os_waiting_for_events_epoll(void);
 extern void *os_epoll_get_data_pointer(int index);
 extern int os_epoll_triggered(int index, int events);
-extern int os_event_mask(int irq_type);
+extern int os_event_mask(enum um_irq_type irq_type);
 extern int os_setup_epoll(void);
 extern int os_add_epoll_fd(int events, int fd, void *data);
 extern int os_mod_epoll_fd(int events, int fd, void *data);
@@ -310,8 +310,8 @@ extern void os_close_epoll_fd(void);
 /* sigio.c */
 extern int add_sigio_fd(int fd);
 extern int ignore_sigio_fd(int fd);
-extern void maybe_sigio_broken(int fd, int read);
-extern void sigio_broken(int fd, int read);
+extern void maybe_sigio_broken(int fd);
+extern void sigio_broken(int fd);
 
 /* prctl.c */
 extern int os_arch_prctl(int pid, int option, unsigned long *arg2);
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 93eb742ecafe..9e8f776bb43a 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -32,7 +32,7 @@ extern void free_irqs(void);
 
 struct irq_reg {
 	void *id;
-	int type;
+	enum um_irq_type type;
 	int irq;
 	int events;
 	bool active;
@@ -96,7 +96,7 @@ void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 		}
 
 		for (i = 0; i < n ; i++) {
-			/* Epoll back reference is the entry with 3 irq_reg
+			/* Epoll back reference is the entry with 2 irq_reg
 			 * leaves - one for each irq type.
 			 */
 			irq_entry = (struct irq_entry *)
@@ -139,7 +139,7 @@ static int assign_epoll_events_to_irq(struct irq_entry *irq_entry)
 
 
 
-static int activate_fd(int irq, int fd, int type, void *dev_id)
+static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id)
 {
 	struct irq_reg *new_fd;
 	struct irq_entry *irq_entry;
@@ -217,7 +217,7 @@ static int activate_fd(int irq, int fd, int type, void *dev_id)
 	/* Turn back IO on with the correct (new) IO event mask */
 	assign_epoll_events_to_irq(irq_entry);
 	spin_unlock_irqrestore(&irq_lock, flags);
-	maybe_sigio_broken(fd, (type != IRQ_NONE));
+	maybe_sigio_broken(fd);
 
 	return 0;
 out_unlock:
@@ -444,10 +444,9 @@ void um_free_irq(int irq, void *dev)
 }
 EXPORT_SYMBOL(um_free_irq);
 
-int um_request_irq(int irq, int fd, int type,
-		   irq_handler_t handler,
-		   unsigned long irqflags, const char * devname,
-		   void *dev_id)
+int um_request_irq(int irq, int fd, enum um_irq_type type,
+		   irq_handler_t handler, unsigned long irqflags,
+		   const char *devname, void *dev_id)
 {
 	int err;
 
diff --git a/arch/um/os-Linux/irq.c b/arch/um/os-Linux/irq.c
index d508310ee5e1..aa90a05b3d78 100644
--- a/arch/um/os-Linux/irq.c
+++ b/arch/um/os-Linux/irq.c
@@ -45,7 +45,7 @@ int os_epoll_triggered(int index, int events)
  * access to the right includes/defines for EPOLL constants.
  */
 
-int os_event_mask(int irq_type)
+int os_event_mask(enum um_irq_type irq_type)
 {
 	if (irq_type == IRQ_READ)
 		return EPOLLIN | EPOLLPRI;
diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 75558080d0bf..233b2b2212f1 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -336,7 +336,7 @@ static void write_sigio_workaround(void)
 	close(l_write_sigio_fds[1]);
 }
 
-void sigio_broken(int fd, int read)
+void sigio_broken(int fd)
 {
 	int err;
 
@@ -352,7 +352,7 @@ void sigio_broken(int fd, int read)
 
 	all_sigio_fds.poll[all_sigio_fds.used++] =
 		((struct pollfd) { .fd  	= fd,
-				   .events 	= read ? POLLIN : POLLOUT,
+				   .events 	= POLLIN,
 				   .revents 	= 0 });
 out:
 	sigio_unlock();
@@ -360,17 +360,16 @@ void sigio_broken(int fd, int read)
 
 /* Changed during early boot */
 static int pty_output_sigio;
-static int pty_close_sigio;
 
-void maybe_sigio_broken(int fd, int read)
+void maybe_sigio_broken(int fd)
 {
 	if (!isatty(fd))
 		return;
 
-	if ((read || pty_output_sigio) && (!read || pty_close_sigio))
+	if (pty_output_sigio)
 		return;
 
-	sigio_broken(fd, read);
+	sigio_broken(fd);
 }
 
 static void sigio_cleanup(void)
@@ -514,19 +513,6 @@ static void tty_output(int master, int slave)
 		printk(UM_KERN_CONT "tty_output : read failed, err = %d\n", n);
 }
 
-static void tty_close(int master, int slave)
-{
-	printk(UM_KERN_INFO "Checking that host ptys support SIGIO on "
-	       "close...");
-
-	close(slave);
-	if (got_sigio) {
-		printk(UM_KERN_CONT "Yes\n");
-		pty_close_sigio = 1;
-	} else
-		printk(UM_KERN_CONT "No, enabling workaround\n");
-}
-
 static void __init check_sigio(void)
 {
 	if ((access("/dev/ptmx", R_OK) < 0) &&
@@ -536,7 +522,6 @@ static void __init check_sigio(void)
 		return;
 	}
 	check_one_sigio(tty_output);
-	check_one_sigio(tty_close);
 }
 
 /* Here because it only does the SIGIO testing for now */
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

