Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <menage@google.com>) id 1MGNV3-0005Vz-G0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 01:30:09 +0000
Received: from [216.239.45.13] (helo=smtp-out.google.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGNUi-0003Lq-UP
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 Jun 2009 01:29:50 +0000
From: Paul Menage <menage@google.com>
Date: Mon, 15 Jun 2009 17:17:50 -0700
Message-ID: <20090616001750.30398.32278.stgit@menage.mtv.corp.google.com>
In-Reply-To: <20090616001248.30398.84278.stgit@menage.mtv.corp.google.com>
References: <20090616001248.30398.84278.stgit@menage.mtv.corp.google.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 5/5] UML: Remove sigio_lock()/sigio_unlock()
	lockdep warnings
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: peterz@infradead.org, mingo@redhat.com, jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

UML: Remove sigio_lock()/sigio_unlock() lockdep warnings

When lockdep is enabled on UML, calls to sigio_lock() and
sigio_unlock() trigger a lockdep warning since this function is called
both from interrupt context and process context. This patch allows a
"flags" argument to be passed to sigio_lock() and sigio_unlock() to
allow them to use spin_lock_irqsave() and spin_unlock_irqrestore().

Signed-off-by: Paul Menage <menage@google.com>

---

 arch/um/include/shared/sigio.h |    4 +--
 arch/um/kernel/sigio.c         |    8 +++---
 arch/um/os-Linux/sigio.c       |   55 +++++++++++++++++++++-------------------
 3 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/arch/um/include/shared/sigio.h b/arch/um/include/shared/sigio.h
index 434f1a9..5b16047 100644
--- a/arch/um/include/shared/sigio.h
+++ b/arch/um/include/shared/sigio.h
@@ -8,7 +8,7 @@
 
 extern int write_sigio_irq(int fd);
 extern int register_sigio_fd(int fd);
-extern void sigio_lock(void);
-extern void sigio_unlock(void);
+extern void sigio_lock(unsigned long *flags);
+extern void sigio_unlock(unsigned long flags);
 
 #endif
diff --git a/arch/um/kernel/sigio.c b/arch/um/kernel/sigio.c
index 2b272b6..f258501 100644
--- a/arch/um/kernel/sigio.c
+++ b/arch/um/kernel/sigio.c
@@ -39,12 +39,12 @@ int write_sigio_irq(int fd)
 /* These are called from os-Linux/sigio.c to protect its pollfds arrays. */
 static DEFINE_SPINLOCK(sigio_spinlock);
 
-void sigio_lock(void)
+void sigio_lock(unsigned long *flags)
 {
-	spin_lock(&sigio_spinlock);
+	spin_lock_irqsave(&sigio_spinlock, *flags);
 }
 
-void sigio_unlock(void)
+void sigio_unlock(unsigned long flags)
 {
-	spin_unlock(&sigio_spinlock);
+	spin_unlock_irqrestore(&sigio_spinlock, flags);
 }
diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 63d299d..aa85a5c 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -24,6 +24,8 @@
  * Protected by sigio_lock(), also used by sigio_cleanup, which is an
  * exitcall.
  */
+
+/* -1 => uninitialized, -2 => initializing */
 static int write_sigio_pid = -1;
 static unsigned long write_sigio_stack;
 
@@ -171,8 +173,9 @@ int add_sigio_fd(int fd)
 {
 	struct pollfd *p;
 	int err = 0, i, n;
+	unsigned long flags;
 
-	sigio_lock();
+	sigio_lock(&flags);
 	for (i = 0; i < all_sigio_fds.used; i++) {
 		if (all_sigio_fds.poll[i].fd == fd)
 			break;
@@ -198,7 +201,7 @@ int add_sigio_fd(int fd)
 	next_poll.used = n + 1;
 	update_thread();
  out:
-	sigio_unlock();
+	sigio_unlock(flags);
 	return err;
 }
 
@@ -206,6 +209,7 @@ int ignore_sigio_fd(int fd)
 {
 	struct pollfd *p;
 	int err = 0, i, n = 0;
+	unsigned long flags;
 
 	/*
 	 * This is called from exitcalls elsewhere in UML - if
@@ -215,7 +219,7 @@ int ignore_sigio_fd(int fd)
 	if (write_sigio_pid == -1)
 		return -EIO;
 
-	sigio_lock();
+	sigio_lock(&flags);
 	for (i = 0; i < current_poll.used; i++) {
 		if (current_poll.poll[i].fd == fd)
 			break;
@@ -236,7 +240,7 @@ int ignore_sigio_fd(int fd)
 
 	update_thread();
  out:
-	sigio_unlock();
+	sigio_unlock(flags);
 	return err;
 }
 
@@ -262,15 +266,20 @@ static void write_sigio_workaround(void)
 	int err;
 	int l_write_sigio_fds[2];
 	int l_sigio_private[2];
-	int l_write_sigio_pid;
+	unsigned long flags;
 
 	/* We call this *tons* of times - and most ones we must just fail. */
-	sigio_lock();
-	l_write_sigio_pid = write_sigio_pid;
-	sigio_unlock();
-
-	if (l_write_sigio_pid != -1)
+ again:
+	sigio_lock(&flags);
+	if (write_sigio_pid >= 0) {
+		sigio_unlock(flags);
 		return;
+	} else if (write_sigio_pid == -2) {
+		sigio_unlock(flags);
+		goto again;
+	}
+	write_sigio_pid = -2;
+	sigio_unlock(flags);
 
 	err = os_pipe(l_write_sigio_fds, 1, 1);
 	if (err < 0) {
@@ -289,22 +298,16 @@ static void write_sigio_workaround(void)
 	if (!p)
 		goto out_close2;
 
-	sigio_lock();
-
-	/*
-	 * Did we race? Don't try to optimize this, please, it's not so likely
-	 * to happen, and no more than once at the boot.
-	 */
-	if (write_sigio_pid != -1)
-		goto out_free;
+	if (write_sigio_irq(l_write_sigio_fds[0])) {
+		sigio_lock(&flags);
+		goto out_clear_poll;
+	}
 
+	sigio_lock(&flags);
 	current_poll = ((struct pollfds) { .poll 	= p,
 					   .used 	= 1,
 					   .size 	= 1 });
 
-	if (write_sigio_irq(l_write_sigio_fds[0]))
-		goto out_clear_poll;
-
 	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
 	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
 
@@ -315,7 +318,7 @@ static void write_sigio_workaround(void)
 	if (write_sigio_pid < 0)
 		goto out_clear;
 
-	sigio_unlock();
+	sigio_unlock(flags);
 	return;
 
 out_clear:
@@ -328,9 +331,8 @@ out_clear_poll:
 	current_poll = ((struct pollfds) { .poll	= NULL,
 					   .size	= 0,
 					   .used	= 0 });
-out_free:
-	sigio_unlock();
 	kfree(p);
+	sigio_unlock(flags);
 out_close2:
 	close(l_sigio_private[0]);
 	close(l_sigio_private[1]);
@@ -342,10 +344,11 @@ out_close1:
 void sigio_broken(int fd, int read)
 {
 	int err;
+	unsigned long flags;
 
 	write_sigio_workaround();
 
-	sigio_lock();
+	sigio_lock(&flags);
 	err = need_poll(&all_sigio_fds, all_sigio_fds.used + 1);
 	if (err) {
 		printk(UM_KERN_ERR "maybe_sigio_broken - failed to add pollfd "
@@ -358,7 +361,7 @@ void sigio_broken(int fd, int read)
 				   .events 	= read ? POLLIN : POLLOUT,
 				   .revents 	= 0 });
 out:
-	sigio_unlock();
+	sigio_unlock(flags);
 }
 
 /* Changed during early boot */


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

