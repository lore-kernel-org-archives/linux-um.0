Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7rb-0006vi-20
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:02:47 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7ra-0002Fy-91
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:02:47 +0000
Date: Thu, 18 Aug 2011 20:02:39 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7rT-0007ZX-A0@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 22/91] um: get rid of sysdep/sc.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


only sysdep/sigcontext.h uses it and very few definitions are
actually used.  The rest refers to symbols that don't even
exist anymore anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/sys-i386/shared/sysdep/sc.h           |   44 ------------------------
 arch/um/sys-i386/shared/sysdep/sigcontext.h   |    9 ++++-
 arch/um/sys-x86_64/shared/sysdep/sc.h         |   45 -------------------------
 arch/um/sys-x86_64/shared/sysdep/sigcontext.h |    8 ++++-
 4 files changed, 15 insertions(+), 91 deletions(-)
 delete mode 100644 arch/um/sys-i386/shared/sysdep/sc.h
 delete mode 100644 arch/um/sys-x86_64/shared/sysdep/sc.h

diff --git a/arch/um/sys-i386/shared/sysdep/sc.h b/arch/um/sys-i386/shared/sysdep/sc.h
deleted file mode 100644
index 7b89240..0000000
--- a/arch/um/sys-i386/shared/sysdep/sc.h
+++ /dev/null
@@ -1,44 +0,0 @@
-#ifndef __SYSDEP_I386_SC_H
-#define __SYSDEP_I386_SC_H
-
-#include <generated/user_constants.h>
-
-#define SC_OFFSET(sc, field) \
-	*((unsigned long *) &(((char *) (sc))[HOST_##field]))
-#define SC_FP_OFFSET(sc, field) \
-	*((unsigned long *) &(((char *) (SC_FPSTATE(sc)))[HOST_##field]))
-#define SC_FP_OFFSET_PTR(sc, field, type) \
-	((type *) &(((char *) (SC_FPSTATE(sc)))[HOST_##field]))
-
-#define SC_IP(sc) SC_OFFSET(sc, SC_IP)
-#define SC_SP(sc) SC_OFFSET(sc, SC_SP)
-#define SC_FS(sc) SC_OFFSET(sc, SC_FS)
-#define SC_GS(sc) SC_OFFSET(sc, SC_GS)
-#define SC_DS(sc) SC_OFFSET(sc, SC_DS)
-#define SC_ES(sc) SC_OFFSET(sc, SC_ES)
-#define SC_SS(sc) SC_OFFSET(sc, SC_SS)
-#define SC_CS(sc) SC_OFFSET(sc, SC_CS)
-#define SC_EFLAGS(sc) SC_OFFSET(sc, SC_EFLAGS)
-#define SC_EAX(sc) SC_OFFSET(sc, SC_EAX)
-#define SC_EBX(sc) SC_OFFSET(sc, SC_EBX)
-#define SC_ECX(sc) SC_OFFSET(sc, SC_ECX)
-#define SC_EDX(sc) SC_OFFSET(sc, SC_EDX)
-#define SC_EDI(sc) SC_OFFSET(sc, SC_EDI)
-#define SC_ESI(sc) SC_OFFSET(sc, SC_ESI)
-#define SC_EBP(sc) SC_OFFSET(sc, SC_EBP)
-#define SC_TRAPNO(sc) SC_OFFSET(sc, SC_TRAPNO)
-#define SC_ERR(sc) SC_OFFSET(sc, SC_ERR)
-#define SC_CR2(sc) SC_OFFSET(sc, SC_CR2)
-#define SC_FPSTATE(sc) SC_OFFSET(sc, SC_FPSTATE)
-#define SC_SIGMASK(sc) SC_OFFSET(sc, SC_SIGMASK)
-#define SC_FP_CW(sc) SC_FP_OFFSET(sc, SC_FP_CW)
-#define SC_FP_SW(sc) SC_FP_OFFSET(sc, SC_FP_SW)
-#define SC_FP_TAG(sc) SC_FP_OFFSET(sc, SC_FP_TAG)
-#define SC_FP_IPOFF(sc) SC_FP_OFFSET(sc, SC_FP_IPOFF)
-#define SC_FP_CSSEL(sc) SC_FP_OFFSET(sc, SC_FP_CSSEL)
-#define SC_FP_DATAOFF(sc) SC_FP_OFFSET(sc, SC_FP_DATAOFF)
-#define SC_FP_DATASEL(sc) SC_FP_OFFSET(sc, SC_FP_DATASEL)
-#define SC_FP_ST(sc) SC_FP_OFFSET_PTR(sc, SC_FP_ST, struct _fpstate)
-#define SC_FXSR_ENV(sc) SC_FP_OFFSET_PTR(sc, SC_FXSR_ENV, void)
-
-#endif
diff --git a/arch/um/sys-i386/shared/sysdep/sigcontext.h b/arch/um/sys-i386/shared/sysdep/sigcontext.h
index f583c87..3827864 100644
--- a/arch/um/sys-i386/shared/sysdep/sigcontext.h
+++ b/arch/um/sys-i386/shared/sysdep/sigcontext.h
@@ -6,10 +6,17 @@
 #ifndef __SYS_SIGCONTEXT_I386_H
 #define __SYS_SIGCONTEXT_I386_H
 
-#include "sysdep/sc.h"
+#include <generated/user_constants.h>
 
 #define IP_RESTART_SYSCALL(ip) ((ip) -= 2)
 
+#define SC_OFFSET(sc, field) \
+	*((unsigned long *) &(((char *) (sc))[HOST_##field]))
+
+#define SC_TRAPNO(sc) SC_OFFSET(sc, SC_TRAPNO)
+#define SC_ERR(sc) SC_OFFSET(sc, SC_ERR)
+#define SC_CR2(sc) SC_OFFSET(sc, SC_CR2)
+
 #define GET_FAULTINFO_FROM_SC(fi, sc) \
 	{ \
 		(fi).cr2 = SC_CR2(sc); \
diff --git a/arch/um/sys-x86_64/shared/sysdep/sc.h b/arch/um/sys-x86_64/shared/sysdep/sc.h
deleted file mode 100644
index 20313a2..0000000
--- a/arch/um/sys-x86_64/shared/sysdep/sc.h
+++ /dev/null
@@ -1,45 +0,0 @@
-#ifndef __SYSDEP_X86_64_SC_H
-#define __SYSDEP_X86_64_SC_H
-
-/* Copyright (C) 2003 - 2004 PathScale, Inc
- * Released under the GPL
- */
-
-#include <generated/user_constants.h>
-
-#define SC_OFFSET(sc, field) \
-	 *((unsigned long *) &(((char *) (sc))[HOST_##field]))
-
-#define SC_RBX(sc) SC_OFFSET(sc, SC_RBX)
-#define SC_RCX(sc) SC_OFFSET(sc, SC_RCX)
-#define SC_RDX(sc) SC_OFFSET(sc, SC_RDX)
-#define SC_RSI(sc) SC_OFFSET(sc, SC_RSI)
-#define SC_RDI(sc) SC_OFFSET(sc, SC_RDI)
-#define SC_RBP(sc) SC_OFFSET(sc, SC_RBP)
-#define SC_RAX(sc) SC_OFFSET(sc, SC_RAX)
-#define SC_R8(sc) SC_OFFSET(sc, SC_R8)
-#define SC_R9(sc) SC_OFFSET(sc, SC_R9)
-#define SC_R10(sc) SC_OFFSET(sc, SC_R10)
-#define SC_R11(sc) SC_OFFSET(sc, SC_R11)
-#define SC_R12(sc) SC_OFFSET(sc, SC_R12)
-#define SC_R13(sc) SC_OFFSET(sc, SC_R13)
-#define SC_R14(sc) SC_OFFSET(sc, SC_R14)
-#define SC_R15(sc) SC_OFFSET(sc, SC_R15)
-#define SC_IP(sc) SC_OFFSET(sc, SC_IP)
-#define SC_SP(sc) SC_OFFSET(sc, SC_SP)
-#define SC_CR2(sc) SC_OFFSET(sc, SC_CR2)
-#define SC_ERR(sc) SC_OFFSET(sc, SC_ERR)
-#define SC_TRAPNO(sc) SC_OFFSET(sc, SC_TRAPNO)
-#define SC_CS(sc) SC_OFFSET(sc, SC_CS)
-#define SC_FS(sc) SC_OFFSET(sc, SC_FS)
-#define SC_GS(sc) SC_OFFSET(sc, SC_GS)
-#define SC_EFLAGS(sc) SC_OFFSET(sc, SC_EFLAGS)
-#define SC_SIGMASK(sc) SC_OFFSET(sc, SC_SIGMASK)
-#define SC_SS(sc) SC_OFFSET(sc, SC_SS)
-#if 0
-#define SC_ORIG_RAX(sc) SC_OFFSET(sc, SC_ORIG_RAX)
-#define SC_DS(sc) SC_OFFSET(sc, SC_DS)
-#define SC_ES(sc) SC_OFFSET(sc, SC_ES)
-#endif
-
-#endif
diff --git a/arch/um/sys-x86_64/shared/sysdep/sigcontext.h b/arch/um/sys-x86_64/shared/sysdep/sigcontext.h
index 0155133..9fb5277 100644
--- a/arch/um/sys-x86_64/shared/sysdep/sigcontext.h
+++ b/arch/um/sys-x86_64/shared/sysdep/sigcontext.h
@@ -7,7 +7,13 @@
 #ifndef __SYSDEP_X86_64_SIGCONTEXT_H
 #define __SYSDEP_X86_64_SIGCONTEXT_H
 
-#include <sysdep/sc.h>
+#include <generated/user_constants.h>
+
+#define SC_OFFSET(sc, field) \
+	 *((unsigned long *) &(((char *) (sc))[HOST_##field]))
+#define SC_CR2(sc) SC_OFFSET(sc, SC_CR2)
+#define SC_ERR(sc) SC_OFFSET(sc, SC_ERR)
+#define SC_TRAPNO(sc) SC_OFFSET(sc, SC_TRAPNO)
 
 #define IP_RESTART_SYSCALL(ip) ((ip) -= 2)
 
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

