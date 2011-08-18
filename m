Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7sZ-0007mq-4D
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:03:47 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7sY-00006T-9Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:03:47 +0000
Date: Thu, 18 Aug 2011 20:03:39 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7sR-0007cn-D8@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 28/91] um: merge hard_handler()
	instances, switch to use of SA_SIGINFO
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/os-Linux/signal.c            |   12 ++++++++----
 arch/um/os-Linux/sys-i386/Makefile   |    2 +-
 arch/um/os-Linux/sys-i386/signal.c   |   13 -------------
 arch/um/os-Linux/sys-x86_64/Makefile |    2 +-
 arch/um/os-Linux/sys-x86_64/signal.c |   16 ----------------
 5 files changed, 10 insertions(+), 35 deletions(-)
 delete mode 100644 arch/um/os-Linux/sys-i386/signal.c
 delete mode 100644 arch/um/os-Linux/sys-x86_64/signal.c

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 4fc3cd1..2dde9f6 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -127,7 +127,7 @@ void set_sigstack(void *sig_stack, int size)
 
 static void (*handlers[_NSIG])(int sig, struct sigcontext *sc);
 
-void handle_signal(int sig, struct sigcontext *sc)
+static void handle_signal(int sig, struct sigcontext *sc)
 {
 	unsigned long pending = 1UL << sig;
 
@@ -168,7 +168,11 @@ void handle_signal(int sig, struct sigcontext *sc)
 	} while (pending);
 }
 
-extern void hard_handler(int sig);
+static void hard_handler(int sig, siginfo_t *info, void *p)
+{
+	struct ucontext *uc = p;
+	handle_signal(sig, (struct sigcontext *) &uc->uc_mcontext);
+}
 
 void set_handler(int sig, void (*handler)(int), int flags, ...)
 {
@@ -178,7 +182,7 @@ void set_handler(int sig, void (*handler)(int), int flags, ...)
 	int mask;
 
 	handlers[sig] = (void (*)(int, struct sigcontext *)) handler;
-	action.sa_handler = hard_handler;
+	action.sa_sigaction = hard_handler;
 
 	sigemptyset(&action.sa_mask);
 
@@ -190,7 +194,7 @@ void set_handler(int sig, void (*handler)(int), int flags, ...)
 	if (sig == SIGSEGV)
 		flags |= SA_NODEFER;
 
-	action.sa_flags = flags;
+	action.sa_flags = flags | SA_SIGINFO;
 	action.sa_restorer = NULL;
 	if (sigaction(sig, &action, NULL) < 0)
 		panic("sigaction failed - errno = %d\n", errno);
diff --git a/arch/um/os-Linux/sys-i386/Makefile b/arch/um/os-Linux/sys-i386/Makefile
index b4bc6ac..d491754 100644
--- a/arch/um/os-Linux/sys-i386/Makefile
+++ b/arch/um/os-Linux/sys-i386/Makefile
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-obj-y = registers.o signal.o task_size.o tls.o
+obj-y = registers.o task_size.o tls.o
 
 USER_OBJS := $(obj-y)
 
diff --git a/arch/um/os-Linux/sys-i386/signal.c b/arch/um/os-Linux/sys-i386/signal.c
deleted file mode 100644
index f311609..0000000
--- a/arch/um/os-Linux/sys-i386/signal.c
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * Copyright (C) 2006 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
- */
-
-#include <signal.h>
-
-extern void handle_signal(int sig, struct sigcontext *sc);
-
-void hard_handler(int sig)
-{
-	handle_signal(sig, (struct sigcontext *) (&sig + 1));
-}
diff --git a/arch/um/os-Linux/sys-x86_64/Makefile b/arch/um/os-Linux/sys-x86_64/Makefile
index a44a47f..58f6e0a 100644
--- a/arch/um/os-Linux/sys-x86_64/Makefile
+++ b/arch/um/os-Linux/sys-x86_64/Makefile
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-obj-y = registers.o prctl.o signal.o task_size.o
+obj-y = registers.o prctl.o task_size.o
 
 USER_OBJS := $(obj-y)
 
diff --git a/arch/um/os-Linux/sys-x86_64/signal.c b/arch/um/os-Linux/sys-x86_64/signal.c
deleted file mode 100644
index 82a3888..0000000
--- a/arch/um/os-Linux/sys-x86_64/signal.c
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Copyright (C) 2006 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
- */
-
-#include <signal.h>
-
-extern void handle_signal(int sig, struct sigcontext *sc);
-
-void hard_handler(int sig)
-{
-	struct ucontext *uc;
-	asm("movq %%rdx, %0" : "=r" (uc));
-
-	handle_signal(sig, (struct sigcontext *) &uc->uc_mcontext);
-}
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

