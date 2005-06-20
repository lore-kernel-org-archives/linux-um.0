Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkRSc-0000sg-KR	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 11:57:30 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DkRSb-0000W4-4M	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 11:57:30 -0700
Message-Id: <200506201851.j5KIpMmj008504@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/8] UML - Time initialization tidying
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
Date: Mon, 20 Jun 2005 14:51:22 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

user_time_init_skas and user_time_init_tt were essentially the same.  So,
this merges them, deleting the mode-specific functions and declarations.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/include/time_user.h
===================================================================
--- linux-2.6.12.orig/arch/um/include/time_user.h	2005-06-20 10:38:57.000000000 -0400
+++ linux-2.6.12/arch/um/include/time_user.h	2005-06-20 10:42:47.000000000 -0400
@@ -8,11 +8,11 @@
 
 extern void timer(void);
 extern void switch_timers(int to_real);
-extern void set_interval(int timer_type);
 extern void idle_sleep(int secs);
 extern void enable_timer(void);
 extern void disable_timer(void);
 extern unsigned long time_lock(void);
 extern void time_unlock(unsigned long);
+extern void user_time_init(void);
 
 #endif
Index: linux-2.6.12/arch/um/kernel/skas/Makefile
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/Makefile	2005-06-20 10:38:57.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/Makefile	2005-06-20 10:42:47.000000000 -0400
@@ -4,10 +4,10 @@
 #
 
 obj-y := exec_kern.o mem.o mem_user.o mmu.o process.o process_kern.o \
-	syscall_kern.o syscall_user.o time.o tlb.o trap_user.o uaccess.o \
+	syscall_kern.o syscall_user.o tlb.o trap_user.o uaccess.o \
 
 subdir- := util
 
-USER_OBJS := process.o time.o
+USER_OBJS := process.o
 
 include arch/um/scripts/Makefile.rules
Index: linux-2.6.12/arch/um/kernel/skas/include/mode-skas.h
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/include/mode-skas.h	2005-06-20 10:38:57.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/include/mode-skas.h	2005-06-20 10:42:47.000000000 -0400
@@ -13,7 +13,6 @@ extern unsigned long exec_fp_regs[];
 extern unsigned long exec_fpx_regs[];
 extern int have_fpx_regs;
 
-extern void user_time_init_skas(void);
 extern void sig_handler_common_skas(int sig, void *sc_ptr);
 extern void halt_skas(void);
 extern void reboot_skas(void);
Index: linux-2.6.12/arch/um/kernel/skas/time.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/time.c	2005-06-20 10:38:57.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/time.c	2005-06-20 06:00:12.985374968 -0400
@@ -1,30 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <sys/signal.h>
-#include <sys/time.h>
-#include "time_user.h"
-#include "process.h"
-#include "user.h"
-
-void user_time_init_skas(void)
-{
-        if(signal(SIGALRM, (__sighandler_t) alarm_handler) == SIG_ERR)
-                panic("Couldn't set SIGALRM handler");
- 	if(signal(SIGVTALRM, (__sighandler_t) alarm_handler) == SIG_ERR)
- 		panic("Couldn't set SIGVTALRM handler");
-	set_interval(ITIMER_VIRTUAL);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.12/arch/um/kernel/time.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/time.c	2005-06-20 10:38:57.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/time.c	2005-06-20 10:42:47.000000000 -0400
@@ -33,7 +33,7 @@ void timer(void)
 	timeradd(&xtime, &local_offset, &xtime);
 }
 
-void set_interval(int timer_type)
+static void set_interval(int timer_type)
 {
 	int usec = 1000000/hz();
 	struct itimerval interval = ((struct itimerval) { { 0, usec },
@@ -45,12 +45,7 @@ void set_interval(int timer_type)
 
 void enable_timer(void)
 {
-	int usec = 1000000/hz();
-	struct itimerval enable = ((struct itimerval) { { 0, usec },
-							{ 0, usec }});
-	if(setitimer(ITIMER_VIRTUAL, &enable, NULL))
-		printk("enable_timer - setitimer failed, errno = %d\n",
-		       errno);
+	set_interval(ITIMER_VIRTUAL);
 }
 
 void disable_timer(void)
@@ -155,13 +150,15 @@ void idle_sleep(int secs)
 	nanosleep(&ts, NULL);
 }
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
+/* XXX This partly duplicates init_irq_signals */
+
+void user_time_init(void)
+{
+	set_handler(SIGVTALRM, (__sighandler_t) alarm_handler, 
+		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, 
+		    SIGALRM, SIGUSR2, -1);
+	set_handler(SIGALRM, (__sighandler_t) alarm_handler, 
+		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, 
+		    SIGVTALRM, SIGUSR2, -1);
+	set_interval(ITIMER_VIRTUAL);
+}
Index: linux-2.6.12/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/time_kern.c	2005-06-20 10:38:57.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/time_kern.c	2005-06-20 10:42:47.000000000 -0400
@@ -162,7 +162,7 @@ int __init timer_init(void)
 {
 	int err;
 
-	CHOOSE_MODE(user_time_init_tt(), user_time_init_skas());
+	user_time_init();
 	err = request_irq(TIMER_IRQ, um_timer, SA_INTERRUPT, "timer", NULL);
 	if(err != 0)
 		printk(KERN_ERR "timer_init : request_irq failed - "
Index: linux-2.6.12/arch/um/kernel/tt/Makefile
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/tt/Makefile	2005-06-20 10:40:40.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/tt/Makefile	2005-06-20 10:42:47.000000000 -0400
@@ -4,11 +4,11 @@
 #
 
 obj-y = exec_kern.o exec_user.o gdb.o ksyms.o mem.o mem_user.o process_kern.o \
-	syscall_kern.o syscall_user.o time.o tlb.o tracer.o trap_user.o \
+	syscall_kern.o syscall_user.o tlb.o tracer.o trap_user.o \
 	uaccess.o uaccess_user.o
 
 obj-$(CONFIG_PT_PROXY) += gdb_kern.o ptproxy/
 
-USER_OBJS := gdb.o time.o tracer.o
+USER_OBJS := gdb.o tracer.o
 
 include arch/um/scripts/Makefile.rules
Index: linux-2.6.12/arch/um/kernel/tt/include/mode-tt.h
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/tt/include/mode-tt.h	2005-06-20 10:38:57.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/tt/include/mode-tt.h	2005-06-20 10:42:47.000000000 -0400
@@ -13,7 +13,6 @@ enum { OP_NONE, OP_EXEC, OP_FORK, OP_TRA
 extern int tracing_pid;
 
 extern int tracer(int (*init_proc)(void *), void *sp);
-extern void user_time_init_tt(void);
 extern void sig_handler_common_tt(int sig, void *sc);
 extern void syscall_handler_tt(int sig, union uml_pt_regs *regs);
 extern void reboot_tt(void);
Index: linux-2.6.12/arch/um/kernel/tt/time.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/tt/time.c	2005-06-20 10:38:57.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/tt/time.c	2005-06-20 06:00:12.985374968 -0400
@@ -1,28 +0,0 @@
-/* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <signal.h>
-#include <sys/time.h>
-#include <time_user.h>
-#include "process.h"
-#include "user.h"
-
-void user_time_init_tt(void)
-{
-	if(signal(SIGVTALRM, (__sighandler_t) alarm_handler) == SIG_ERR)
-		panic("Couldn't set SIGVTALRM handler");
-	set_interval(ITIMER_VIRTUAL);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
