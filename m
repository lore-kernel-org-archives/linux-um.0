Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMqmt-0003Z7-CS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:27 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMqms-0005Yg-DW
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:27 -0800
Message-Id: <200603241814.k2OIEhZr005525@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/16] UML - Move SIGIO startup code to
	os-Linux/start_up.c
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 24 Mar 2006 13:14:43 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Gennady Sharapov <Gennady.V.Sharapov@intel.com>

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves all startup code from sigio_user.c file under os-Linux dir

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/include/os.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/os.h	2006-03-23 17:23:18.000000000 -0500
+++ linux-2.6.16/arch/um/include/os.h	2006-03-23 17:23:54.000000000 -0500
@@ -161,6 +161,7 @@ extern int os_lock_file(int fd, int excl
 /* start_up.c */
 extern void os_early_checks(void);
 extern int can_do_skas(void);
+extern void os_check_bugs(void);
 
 /* Make sure they are clear when running in TT mode. Required by
  * SEGV_MAYBE_FIXABLE */
Index: linux-2.6.16/arch/um/include/sigio.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/sigio.h	2006-03-23 17:23:18.000000000 -0500
+++ linux-2.6.16/arch/um/include/sigio.h	2006-03-23 17:23:54.000000000 -0500
@@ -8,7 +8,6 @@
 
 extern int write_sigio_irq(int fd);
 extern int register_sigio_fd(int fd);
-extern int read_sigio_fd(int fd);
 extern int add_sigio_fd(int fd, int read);
 extern int ignore_sigio_fd(int fd);
 extern void sigio_lock(void);
Index: linux-2.6.16/arch/um/kernel/sigio_kern.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/sigio_kern.c	2006-03-23 17:23:18.000000000 -0500
+++ linux-2.6.16/arch/um/kernel/sigio_kern.c	2006-03-23 17:23:54.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2002 - 2003 Jeff Dike (jdike@addtoit.com)
  * Licensed under the GPL
  */
@@ -12,13 +12,16 @@
 #include "sigio.h"
 #include "irq_user.h"
 #include "irq_kern.h"
+#include "os.h"
 
 /* Protected by sigio_lock() called from write_sigio_workaround */
 static int sigio_irq_fd = -1;
 
 static irqreturn_t sigio_interrupt(int irq, void *data, struct pt_regs *unused)
 {
-	read_sigio_fd(sigio_irq_fd);
+	char c;
+
+	os_read_file(sigio_irq_fd, &c, sizeof(c));
 	reactivate_fd(sigio_irq_fd, SIGIO_WRITE_IRQ);
 	return(IRQ_HANDLED);
 }
@@ -51,6 +54,9 @@ void sigio_unlock(void)
 	spin_unlock(&sigio_spinlock);
 }
 
+extern void sigio_cleanup(void);
+__uml_exitcall(sigio_cleanup);
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.16/arch/um/kernel/sigio_user.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/sigio_user.c	2006-03-23 17:23:18.000000000 -0500
+++ linux-2.6.16/arch/um/kernel/sigio_user.c	2006-03-23 17:25:36.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -20,127 +20,6 @@
 #include "sigio.h"
 #include "os.h"
 
-/* Changed during early boot */
-int pty_output_sigio = 0;
-int pty_close_sigio = 0;
-
-/* Used as a flag during SIGIO testing early in boot */
-static volatile int got_sigio = 0;
-
-void __init handler(int sig)
-{
-	got_sigio = 1;
-}
-
-struct openpty_arg {
-	int master;
-	int slave;
-	int err;
-};
-
-static void openpty_cb(void *arg)
-{
-	struct openpty_arg *info = arg;
-
-	info->err = 0;
-	if(openpty(&info->master, &info->slave, NULL, NULL, NULL))
-		info->err = -errno;
-}
-
-void __init check_one_sigio(void (*proc)(int, int))
-{
-	struct sigaction old, new;
-	struct openpty_arg pty = { .master = -1, .slave = -1 };
-	int master, slave, err;
-
-	initial_thread_cb(openpty_cb, &pty);
-	if(pty.err){
-		printk("openpty failed, errno = %d\n", -pty.err);
-		return;
-	}
-
-	master = pty.master;
-	slave = pty.slave;
-
-	if((master == -1) || (slave == -1)){
-		printk("openpty failed to allocate a pty\n");
-		return;
-	}
-
-	/* Not now, but complain so we now where we failed. */
-	err = raw(master);
-	if (err < 0)
-		panic("check_sigio : __raw failed, errno = %d\n", -err);
-
-	err = os_sigio_async(master, slave);
-	if(err < 0)
-		panic("tty_fds : sigio_async failed, err = %d\n", -err);
-
-	if(sigaction(SIGIO, NULL, &old) < 0)
-		panic("check_sigio : sigaction 1 failed, errno = %d\n", errno);
-	new = old;
-	new.sa_handler = handler;
-	if(sigaction(SIGIO, &new, NULL) < 0)
-		panic("check_sigio : sigaction 2 failed, errno = %d\n", errno);
-
-	got_sigio = 0;
-	(*proc)(master, slave);
-		
-	os_close_file(master);
-	os_close_file(slave);
-
-	if(sigaction(SIGIO, &old, NULL) < 0)
-		panic("check_sigio : sigaction 3 failed, errno = %d\n", errno);
-}
-
-static void tty_output(int master, int slave)
-{
-	int n;
-	char buf[512];
-
-	printk("Checking that host ptys support output SIGIO...");
-
-	memset(buf, 0, sizeof(buf));
-
-	while(os_write_file(master, buf, sizeof(buf)) > 0) ;
-	if(errno != EAGAIN)
-		panic("check_sigio : write failed, errno = %d\n", errno);
-	while(((n = os_read_file(slave, buf, sizeof(buf))) > 0) && !got_sigio) ;
-
-	if (got_sigio) {
-		printk("Yes\n");
-		pty_output_sigio = 1;
-	} else if (n == -EAGAIN) {
-		printk("No, enabling workaround\n");
-	} else {
-		panic("check_sigio : read failed, err = %d\n", n);
-	}
-}
-
-static void tty_close(int master, int slave)
-{
-	printk("Checking that host ptys support SIGIO on close...");
-
-	os_close_file(slave);
-	if(got_sigio){
-		printk("Yes\n");
-		pty_close_sigio = 1;
-	}
-	else printk("No, enabling workaround\n");
-}
-
-void __init check_sigio(void)
-{
-	if((os_access("/dev/ptmx", OS_ACC_R_OK) < 0) &&
-	   (os_access("/dev/ptyp0", OS_ACC_R_OK) < 0)){
-		printk("No pseudo-terminals available - skipping pty SIGIO "
-		       "check\n");
-		return;
-	}
-	check_one_sigio(tty_output);
-	check_one_sigio(tty_close);
-}
-
 /* Protected by sigio_lock(), also used by sigio_cleanup, which is an 
  * exitcall.
  */
@@ -267,10 +146,10 @@ static void update_thread(void)
 	if(write_sigio_pid != -1) 
 		os_kill_process(write_sigio_pid, 1);
 	write_sigio_pid = -1;
-	os_close_file(sigio_private[0]);
-	os_close_file(sigio_private[1]);
-	os_close_file(write_sigio_fds[0]);
-	os_close_file(write_sigio_fds[1]);
+	close(sigio_private[0]);
+	close(sigio_private[1]);
+	close(write_sigio_fds[0]);
+	close(write_sigio_fds[1]);
 	/* Critical section end */
 	set_signals(flags);
 }
@@ -428,39 +307,18 @@ void write_sigio_workaround(void)
  out_free:
 	kfree(p);
  out_close2:
-	os_close_file(l_sigio_private[0]);
-	os_close_file(l_sigio_private[1]);
+	close(l_sigio_private[0]);
+	close(l_sigio_private[1]);
  out_close1:
-	os_close_file(l_write_sigio_fds[0]);
-	os_close_file(l_write_sigio_fds[1]);
+	close(l_write_sigio_fds[0]);
+	close(l_write_sigio_fds[1]);
 	return;
 }
 
-int read_sigio_fd(int fd)
-{
-	int n;
-	char c;
-
-	n = os_read_file(fd, &c, sizeof(c));
-	if(n != sizeof(c)){
-		if(n < 0) {
-			printk("read_sigio_fd - read failed, err = %d\n", -n);
-			return(n);
-		}
-		else {
-			printk("read_sigio_fd - short read, bytes = %d\n", n);
-			return(-EIO);
-		}
-	}
-	return(n);
-}
-
-static void sigio_cleanup(void)
+void sigio_cleanup(void)
 {
 	if (write_sigio_pid != -1) {
 		os_kill_process(write_sigio_pid, 1);
 		write_sigio_pid = -1;
 	}
 }
-
-__uml_exitcall(sigio_cleanup);
Index: linux-2.6.16/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/um_arch.c	2006-03-23 17:23:18.000000000 -0500
+++ linux-2.6.16/arch/um/kernel/um_arch.c	2006-03-23 17:23:54.000000000 -0500
@@ -487,8 +487,7 @@ void __init setup_arch(char **cmdline_p)
 void __init check_bugs(void)
 {
 	arch_check_bugs();
-	check_sigio();
-	check_devanon();
+ 	os_check_bugs();
 }
 
 void apply_alternatives(void *start, void *end)
Index: linux-2.6.16/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/start_up.c	2006-03-23 17:23:18.000000000 -0500
+++ linux-2.6.16/arch/um/os-Linux/start_up.c	2006-03-23 17:23:54.000000000 -0500
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include <pty.h>
 #include <stdio.h>
 #include <stddef.h>
 #include <stdarg.h>
@@ -539,3 +540,130 @@ int __init parse_iomem(char *str, int *a
 	return(1);
 }
 
+
+/* Changed during early boot */
+int pty_output_sigio = 0;
+int pty_close_sigio = 0;
+
+/* Used as a flag during SIGIO testing early in boot */
+static volatile int got_sigio = 0;
+
+static void __init handler(int sig)
+{
+	got_sigio = 1;
+}
+
+struct openpty_arg {
+	int master;
+	int slave;
+	int err;
+};
+
+static void openpty_cb(void *arg)
+{
+	struct openpty_arg *info = arg;
+
+	info->err = 0;
+	if(openpty(&info->master, &info->slave, NULL, NULL, NULL))
+		info->err = -errno;
+}
+
+static void __init check_one_sigio(void (*proc)(int, int))
+{
+	struct sigaction old, new;
+	struct openpty_arg pty = { .master = -1, .slave = -1 };
+	int master, slave, err;
+
+	initial_thread_cb(openpty_cb, &pty);
+	if(pty.err){
+		printk("openpty failed, errno = %d\n", -pty.err);
+		return;
+	}
+
+	master = pty.master;
+	slave = pty.slave;
+
+	if((master == -1) || (slave == -1)){
+		printk("openpty failed to allocate a pty\n");
+		return;
+	}
+
+	/* Not now, but complain so we now where we failed. */
+	err = raw(master);
+	if (err < 0)
+		panic("check_sigio : __raw failed, errno = %d\n", -err);
+
+	err = os_sigio_async(master, slave);
+	if(err < 0)
+		panic("tty_fds : sigio_async failed, err = %d\n", -err);
+
+	if(sigaction(SIGIO, NULL, &old) < 0)
+		panic("check_sigio : sigaction 1 failed, errno = %d\n", errno);
+	new = old;
+	new.sa_handler = handler;
+	if(sigaction(SIGIO, &new, NULL) < 0)
+		panic("check_sigio : sigaction 2 failed, errno = %d\n", errno);
+
+	got_sigio = 0;
+	(*proc)(master, slave);
+
+	close(master);
+	close(slave);
+
+	if(sigaction(SIGIO, &old, NULL) < 0)
+		panic("check_sigio : sigaction 3 failed, errno = %d\n", errno);
+}
+
+static void tty_output(int master, int slave)
+{
+	int n;
+	char buf[512];
+
+	printk("Checking that host ptys support output SIGIO...");
+
+	memset(buf, 0, sizeof(buf));
+
+	while(os_write_file(master, buf, sizeof(buf)) > 0) ;
+	if(errno != EAGAIN)
+		panic("check_sigio : write failed, errno = %d\n", errno);
+	while(((n = os_read_file(slave, buf, sizeof(buf))) > 0) && !got_sigio) ;
+
+	if(got_sigio){
+		printk("Yes\n");
+		pty_output_sigio = 1;
+	}
+	else if(n == -EAGAIN) printk("No, enabling workaround\n");
+	else panic("check_sigio : read failed, err = %d\n", n);
+}
+
+static void tty_close(int master, int slave)
+{
+	printk("Checking that host ptys support SIGIO on close...");
+
+	close(slave);
+	if(got_sigio){
+		printk("Yes\n");
+		pty_close_sigio = 1;
+	}
+	else printk("No, enabling workaround\n");
+}
+
+void __init check_sigio(void)
+{
+	if((os_access("/dev/ptmx", OS_ACC_R_OK) < 0) &&
+	   (os_access("/dev/ptyp0", OS_ACC_R_OK) < 0)){
+		printk("No pseudo-terminals available - skipping pty SIGIO "
+		       "check\n");
+		return;
+	}
+	check_one_sigio(tty_output);
+	check_one_sigio(tty_close);
+}
+
+void os_check_bugs(void)
+{
+	check_ptrace();
+	check_sigio();
+	check_devanon();
+}
+



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
