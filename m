Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G8MrN-0003n0-0l for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Aug 2006 12:58:29 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G8MrJ-0008EC-JP
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Aug 2006 12:58:29 -0700
Message-Id: <200608021958.k72JwJUo005992@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 02 Aug 2006 15:58:19 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/4] UML - Move signal handlers to arch code
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Have most signals go through an arch-provided handler which recovers
the sigcontext and then calls a generic handler.  This replaces the
ARCH_GET_SIGCONTEXT macro, which was somewhat fragile.  On x86_64,
recovering %rdx (which holds the sigcontext pointer) must be the first
thing that happens.  sig_handler duly invokes that first, but there is
no guarantee that I can see that instructions won't be reordered such
that %rdx is used before that.  Having the arch provide the handler
seems much more robust.

Some signals in some parts of UML require their own handlers - these
places don't call set_handler any more.  They call sigaction or signal
themselves.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-rc2-mm1/arch/um/include/sysdep-i386/signal.h
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/include/sysdep-i386/signal.h	2006-08-02 15:53:33.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,27 +0,0 @@
-/*
- * Copyright (C) 2004 PathScale, Inc
- * Licensed under the GPL
- */
-
-#ifndef __I386_SIGNAL_H_
-#define __I386_SIGNAL_H_
-
-#include <signal.h>
-
-#define ARCH_SIGHDLR_PARAM int sig
-
-#define ARCH_GET_SIGCONTEXT(sc, sig) \
-	do sc = (struct sigcontext *) (&sig + 1); while(0)
-
-#endif
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
Index: linux-2.6.18-rc2-mm1/arch/um/include/sysdep-x86_64/signal.h
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/include/sysdep-x86_64/signal.h	2006-08-02 15:53:33.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,29 +0,0 @@
-/*
- * Copyright (C) 2004 PathScale, Inc
- * Licensed under the GPL
- */
-
-#ifndef __X86_64_SIGNAL_H_
-#define __X86_64_SIGNAL_H_
-
-#define ARCH_SIGHDLR_PARAM int sig
-
-#define ARCH_GET_SIGCONTEXT(sc, sig_addr) \
-	do { \
-		struct ucontext *__uc; \
-		asm("movq %%rdx, %0" : "=r" (__uc)); \
-		sc = (struct sigcontext *) &__uc->uc_mcontext; \
-	} while(0)
-
-#endif
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
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/sys-i386/signal.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/sys-i386/signal.c	2006-08-02 15:53:39.000000000 -0400
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) 2006 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#include <signal.h>
+
+extern void (*handlers[])(int sig, struct sigcontext *sc);
+
+void hard_handler(int sig)
+{
+	struct sigcontext *sc = (struct sigcontext *) (&sig + 1);
+
+	(*handlers[sig])(sig, sc);
+}
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/sys-x86_64/signal.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/sys-x86_64/signal.c	2006-08-02 15:53:39.000000000 -0400
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2006 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#include <signal.h>
+
+extern void (*handlers[])(int sig, struct sigcontext *sc);
+
+void hard_handler(int sig)
+{
+	struct ucontext *uc;
+	asm("movq %%rdx, %0" : "=r" (uc));
+
+	(*handlers[sig])(sig, (struct sigcontext *) &uc->uc_mcontext);
+}
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/signal.c	2006-08-02 15:53:33.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/signal.c	2006-08-02 15:53:39.000000000 -0400
@@ -15,7 +15,6 @@
 #include "user.h"
 #include "signal_kern.h"
 #include "sysdep/sigcontext.h"
-#include "sysdep/signal.h"
 #include "sigcontext.h"
 #include "mode.h"
 #include "os.h"
@@ -38,18 +37,10 @@
 static int signals_enabled = 1;
 static int pending = 0;
 
-void sig_handler(ARCH_SIGHDLR_PARAM)
+void sig_handler(int sig, struct sigcontext *sc)
 {
-	struct sigcontext *sc;
 	int enabled;
 
-	/* Must be the first thing that this handler does - x86_64 stores
-	 * the sigcontext in %rdx, and we need to save it before it has a
-	 * chance to get trashed.
-	 */
-
-	ARCH_GET_SIGCONTEXT(sc, sig);
-
 	enabled = signals_enabled;
 	if(!enabled && (sig == SIGIO)){
 		pending |= SIGIO_MASK;
@@ -84,13 +75,10 @@ static void real_alarm_handler(int sig, 
 
 }
 
-void alarm_handler(ARCH_SIGHDLR_PARAM)
+void alarm_handler(int sig, struct sigcontext *sc)
 {
-	struct sigcontext *sc;
 	int enabled;
 
-	ARCH_GET_SIGCONTEXT(sc, sig);
-
 	enabled = signals_enabled;
 	if(!signals_enabled){
 		if(sig == SIGVTALRM)
@@ -126,6 +114,10 @@ void remove_sigstack(void)
 		panic("disabling signal stack failed, errno = %d\n", errno);
 }
 
+void (*handlers[_NSIG])(int sig, struct sigcontext *sc);
+
+extern void hard_handler(int sig);
+
 void set_handler(int sig, void (*handler)(int), int flags, ...)
 {
 	struct sigaction action;
@@ -133,13 +125,15 @@ void set_handler(int sig, void (*handler
 	sigset_t sig_mask;
 	int mask;
 
-	va_start(ap, flags);
 	action.sa_handler = handler;
+
 	sigemptyset(&action.sa_mask);
-	while((mask = va_arg(ap, int)) != -1){
+
+	va_start(ap, flags);
+	while((mask = va_arg(ap, int)) != -1)
 		sigaddset(&action.sa_mask, mask);
-	}
 	va_end(ap);
+
 	action.sa_flags = flags;
 	action.sa_restorer = NULL;
 	if(sigaction(sig, &action, NULL) < 0)
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/process.c	2006-08-02 15:53:33.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/process.c	2006-08-02 15:53:39.000000000 -0400
@@ -246,7 +246,17 @@ void init_new_thread_stack(void *sig_sta
 		set_sigstack(sig_stack, pages * page_size());
 		flags = SA_ONSTACK;
 	}
-	if(usr1_handler) set_handler(SIGUSR1, usr1_handler, flags, -1);
+	if(usr1_handler){
+		struct sigaction sa;
+
+		sa.sa_handler = usr1_handler;
+		sigemptyset(&sa.sa_mask);
+		sa.sa_flags = flags;
+		sa.sa_restorer = NULL;
+		if(sigaction(SIGUSR1, &sa, NULL) < 0)
+			panic("init_new_thread_stack - sigaction failed - "
+			      "errno = %d\n", errno);
+	}
 }
 
 void init_new_thread_signals(void)
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/time.c	2006-08-02 15:53:33.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/time.c	2006-08-02 15:53:39.000000000 -0400
@@ -40,8 +40,8 @@ void disable_timer(void)
 		printk("disnable_timer - setitimer failed, errno = %d\n",
 		       errno);
 	/* If there are signals already queued, after unblocking ignore them */
-	set_handler(SIGALRM, SIG_IGN, 0, -1);
-	set_handler(SIGVTALRM, SIG_IGN, 0, -1);
+	signal(SIGALRM, SIG_IGN);
+	signal(SIGVTALRM, SIG_IGN);
 }
 
 void switch_timers(int to_real)
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/irq.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/irq.c	2006-08-02 15:53:33.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/irq.c	2006-08-02 15:53:39.000000000 -0400
@@ -132,7 +132,7 @@ void os_set_pollfd(int i, int fd)
 
 void os_set_ioignore(void)
 {
-	set_handler(SIGIO, SIG_IGN, 0, -1);
+	signal(SIGIO, SIG_IGN);
 }
 
 void init_irq_signals(int on_sigstack)
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/main.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/main.c	2006-08-02 15:53:33.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/main.c	2006-08-02 15:53:39.000000000 -0400
@@ -67,13 +67,32 @@ static __init void do_uml_initcalls(void
 
 static void last_ditch_exit(int sig)
 {
-	signal(SIGINT, SIG_DFL);
-	signal(SIGTERM, SIG_DFL);
-	signal(SIGHUP, SIG_DFL);
 	uml_cleanup();
 	exit(1);
 }
 
+static void install_fatal_handler(int sig)
+{
+	struct sigaction action;
+
+	/* All signals are enabled in this handler ... */
+	sigemptyset(&action.sa_mask);
+
+	/* ... including the signal being handled, plus we want the
+	 * handler reset to the default behavior, so that if an exit
+	 * handler is hanging for some reason, the UML will just die
+	 * after this signal is sent a second time.
+	 */
+	action.sa_flags = SA_RESETHAND | SA_NODEFER;
+	action.sa_restorer = NULL;
+	action.sa_handler = last_ditch_exit;
+	if(sigaction(sig, &action, NULL) < 0){
+		printf("failed to install handler for signal %d - errno = %d\n",
+		       errno);
+		exit(1);
+	}
+}
+
 #define UML_LIB_PATH	":/usr/lib/uml"
 
 static void setup_env_path(void)
@@ -158,9 +177,12 @@ int main(int argc, char **argv, char **e
 	}
 	new_argv[argc] = NULL;
 
-	set_handler(SIGINT, last_ditch_exit, SA_ONESHOT | SA_NODEFER, -1);
-	set_handler(SIGTERM, last_ditch_exit, SA_ONESHOT | SA_NODEFER, -1);
-	set_handler(SIGHUP, last_ditch_exit, SA_ONESHOT | SA_NODEFER, -1);
+	/* Allow these signals to bring down a UML if all other
+	 * methods of control fail.
+	 */
+	install_fatal_handler(SIGINT);
+	install_fatal_handler(SIGTERM);
+	install_fatal_handler(SIGHUP);
 
 	scan_elf_aux( envp);
 
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/skas/process.c	2006-08-02 15:53:33.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/skas/process.c	2006-08-02 15:53:39.000000000 -0400
@@ -189,14 +189,25 @@ static int userspace_tramp(void *stack)
 		}
 	}
 	if(!ptrace_faultinfo && (stack != NULL)){
+		struct sigaction sa;
+
 		unsigned long v = UML_CONFIG_STUB_CODE +
 				  (unsigned long) stub_segv_handler -
 				  (unsigned long) &__syscall_stub_start;
 
 		set_sigstack((void *) UML_CONFIG_STUB_DATA, page_size());
-		set_handler(SIGSEGV, (void *) v, SA_ONSTACK,
-			    SIGIO, SIGWINCH, SIGALRM, SIGVTALRM,
-			    SIGUSR1, -1);
+		sigemptyset(&sa.sa_mask);
+		sigaddset(&sa.sa_mask, SIGIO);
+		sigaddset(&sa.sa_mask, SIGWINCH);
+		sigaddset(&sa.sa_mask, SIGALRM);
+		sigaddset(&sa.sa_mask, SIGVTALRM);
+		sigaddset(&sa.sa_mask, SIGUSR1);
+		sa.sa_flags = SA_ONSTACK;
+		sa.sa_handler = (void *) v;
+		sa.sa_restorer = NULL;
+		if(sigaction(SIGSEGV, &sa, NULL) < 0)
+			panic("userspace_tramp - setting SIGSEGV handler "
+			      "failed - errno = %d\n", errno);
 	}
 
 	os_stop_process(os_getpid());
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/sys-i386/Makefile
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/sys-i386/Makefile	2006-08-02 15:53:33.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/sys-i386/Makefile	2006-08-02 15:53:39.000000000 -0400
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-obj-$(CONFIG_MODE_SKAS) = registers.o tls.o
+obj-$(CONFIG_MODE_SKAS) = registers.o signal.o tls.o
 
 USER_OBJS := $(obj-y)
 
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/sys-x86_64/Makefile
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/sys-x86_64/Makefile	2006-08-02 15:53:33.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/sys-x86_64/Makefile	2006-08-02 15:53:39.000000000 -0400
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-obj-$(CONFIG_MODE_SKAS) = registers.o
+obj-$(CONFIG_MODE_SKAS) = registers.o signal.o
 
 USER_OBJS := $(obj-y)
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
