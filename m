Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7t3-0007CX-6H
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:04:17 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7t2-00007Y-Do
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:04:17 +0000
Date: Thu, 18 Aug 2011 20:04:09 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7sv-0007fJ-En@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 31/91] um: switch stub_segv_handler to
	SA_SIGINFO variant, get rid of magic crap in there
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/os-Linux/skas/process.c                 |    4 ++--
 arch/um/sys-x86/Makefile                        |    2 +-
 arch/um/sys-x86/shared/sysdep/stub.h            |    9 +++++++++
 arch/um/sys-x86/shared/sysdep/stub_32.h         |    7 -------
 arch/um/sys-x86/shared/sysdep/stub_64.h         |    7 -------
 arch/um/sys-x86/{stub_segv_64.c => stub_segv.c} |    7 ++-----
 arch/um/sys-x86/stub_segv_32.c                  |   17 -----------------
 7 files changed, 14 insertions(+), 39 deletions(-)
 rename arch/um/sys-x86/{stub_segv_64.c => stub_segv.c} (70%)
 delete mode 100644 arch/um/sys-x86/stub_segv_32.c

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 913b5a5..896312d 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -255,8 +255,8 @@ static int userspace_tramp(void *stack)
 
 		set_sigstack((void *) STUB_DATA, UM_KERN_PAGE_SIZE);
 		sigemptyset(&sa.sa_mask);
-		sa.sa_flags = SA_ONSTACK | SA_NODEFER;
-		sa.sa_handler = (void *) v;
+		sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
+		sa.sa_sigaction = (void *) v;
 		sa.sa_restorer = NULL;
 		if (sigaction(SIGSEGV, &sa, NULL) < 0) {
 			printk(UM_KERN_ERR "userspace_tramp - setting SIGSEGV "
diff --git a/arch/um/sys-x86/Makefile b/arch/um/sys-x86/Makefile
index 671de0b..81ab348 100644
--- a/arch/um/sys-x86/Makefile
+++ b/arch/um/sys-x86/Makefile
@@ -10,7 +10,7 @@ endif
 
 obj-y = bug.o bugs_$(BITS).o delay_$(BITS).o fault.o ksyms.o ldt.o \
 	ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal_$(BITS).o \
-	stub_$(BITS).o stub_segv_$(BITS).o syscalls_$(BITS).o \
+	stub_$(BITS).o stub_segv.o syscalls_$(BITS).o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o mem_$(BITS).o
 
 ifeq ($(CONFIG_X86_32),y)
diff --git a/arch/um/sys-x86/shared/sysdep/stub.h b/arch/um/sys-x86/shared/sysdep/stub.h
index 13f523a..bd161e3 100644
--- a/arch/um/sys-x86/shared/sysdep/stub.h
+++ b/arch/um/sys-x86/shared/sysdep/stub.h
@@ -1,5 +1,14 @@
+#include <asm/unistd.h>
+#include <sys/mman.h>
+#include <signal.h>
+#include "as-layout.h"
+#include "stub-data.h"
+
 #ifdef __i386__
 #include "stub_32.h"
 #else
 #include "stub_64.h"
 #endif
+
+extern void stub_segv_handler(int, siginfo_t *, void *);
+extern void stub_clone_handler(void);
diff --git a/arch/um/sys-x86/shared/sysdep/stub_32.h b/arch/um/sys-x86/shared/sysdep/stub_32.h
index cca14d4..51fd256 100644
--- a/arch/um/sys-x86/shared/sysdep/stub_32.h
+++ b/arch/um/sys-x86/shared/sysdep/stub_32.h
@@ -6,14 +6,7 @@
 #ifndef __SYSDEP_STUB_H
 #define __SYSDEP_STUB_H
 
-#include <sys/mman.h>
 #include <asm/ptrace.h>
-#include <asm/unistd.h>
-#include "as-layout.h"
-#include "stub-data.h"
-
-extern void stub_segv_handler(int sig);
-extern void stub_clone_handler(void);
 
 #define STUB_SYSCALL_RET EAX
 #define STUB_MMAP_NR __NR_mmap2
diff --git a/arch/um/sys-x86/shared/sysdep/stub_64.h b/arch/um/sys-x86/shared/sysdep/stub_64.h
index 922a570..994df93 100644
--- a/arch/um/sys-x86/shared/sysdep/stub_64.h
+++ b/arch/um/sys-x86/shared/sysdep/stub_64.h
@@ -6,14 +6,7 @@
 #ifndef __SYSDEP_STUB_H
 #define __SYSDEP_STUB_H
 
-#include <sys/mman.h>
-#include <asm/unistd.h>
 #include <sysdep/ptrace_user.h>
-#include "as-layout.h"
-#include "stub-data.h"
-
-extern void stub_segv_handler(int sig);
-extern void stub_clone_handler(void);
 
 #define STUB_SYSCALL_RET PT_INDEX(RAX)
 #define STUB_MMAP_NR __NR_mmap
diff --git a/arch/um/sys-x86/stub_segv_64.c b/arch/um/sys-x86/stub_segv.c
similarity index 70%
rename from arch/um/sys-x86/stub_segv_64.c
rename to arch/um/sys-x86/stub_segv.c
index ced051a..f62771c 100644
--- a/arch/um/sys-x86/stub_segv_64.c
+++ b/arch/um/sys-x86/stub_segv.c
@@ -3,18 +3,15 @@
  * Licensed under the GPL
  */
 
-#include <signal.h>
-#include "as-layout.h"
 #include "sysdep/stub.h"
 #include "sysdep/faultinfo.h"
 #include "sysdep/sigcontext.h"
 
 void __attribute__ ((__section__ (".__syscall_stub")))
-stub_segv_handler(int sig)
+stub_segv_handler(int sig, siginfo_t *info, void *p)
 {
-	struct ucontext *uc;
+	struct ucontext *uc = p;
 
-	__asm__ __volatile__("movq %%rdx, %0" : "=g" (uc) :);
 	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) STUB_DATA),
 			      &uc->uc_mcontext);
 	trap_myself();
diff --git a/arch/um/sys-x86/stub_segv_32.c b/arch/um/sys-x86/stub_segv_32.c
deleted file mode 100644
index 28ccf73..0000000
--- a/arch/um/sys-x86/stub_segv_32.c
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Copyright (C) 2004 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
- */
-
-#include "sysdep/stub.h"
-#include "sysdep/sigcontext.h"
-
-void __attribute__ ((__section__ (".__syscall_stub")))
-stub_segv_handler(int sig)
-{
-	struct sigcontext *sc = (struct sigcontext *) (&sig + 1);
-
-	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) STUB_DATA), sc);
-
-	trap_myself();
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

