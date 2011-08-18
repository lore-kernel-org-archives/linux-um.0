Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7rl-0001JC-4l
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:02:57 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7rk-00004q-9Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:02:57 +0000
Date: Thu, 18 Aug 2011 20:02:49 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7rd-0007az-BQ@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 23/91] um: get rid of unused macros in
 ptrace_user.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/sys-i386/shared/sysdep/ptrace_user.h   |   24 --------------
 arch/um/sys-x86_64/shared/sysdep/ptrace_user.h |   39 ------------------------
 2 files changed, 0 insertions(+), 63 deletions(-)

diff --git a/arch/um/sys-i386/shared/sysdep/ptrace_user.h b/arch/um/sys-i386/shared/sysdep/ptrace_user.h
index e4398a3..9d88a79 100644
--- a/arch/um/sys-i386/shared/sysdep/ptrace_user.h
+++ b/arch/um/sys-i386/shared/sysdep/ptrace_user.h
@@ -16,35 +16,11 @@
 #define PT_SYSCALL_NR(regs) ((regs)[ORIG_EAX])
 #define PT_SYSCALL_NR_OFFSET PT_OFFSET(ORIG_EAX)
 
-#define PT_SYSCALL_ARG1_OFFSET PT_OFFSET(EBX)
-#define PT_SYSCALL_ARG2_OFFSET PT_OFFSET(ECX)
-#define PT_SYSCALL_ARG3_OFFSET PT_OFFSET(EDX)
-#define PT_SYSCALL_ARG4_OFFSET PT_OFFSET(ESI)
-#define PT_SYSCALL_ARG5_OFFSET PT_OFFSET(EDI)
-#define PT_SYSCALL_ARG6_OFFSET PT_OFFSET(EBP)
-
 #define PT_SYSCALL_RET_OFFSET PT_OFFSET(EAX)
 
-#define REGS_SYSCALL_NR EAX /* This is used before a system call */
-#define REGS_SYSCALL_ARG1 EBX
-#define REGS_SYSCALL_ARG2 ECX
-#define REGS_SYSCALL_ARG3 EDX
-#define REGS_SYSCALL_ARG4 ESI
-#define REGS_SYSCALL_ARG5 EDI
-#define REGS_SYSCALL_ARG6 EBP
-
 #define REGS_IP_INDEX EIP
 #define REGS_SP_INDEX UESP
 
-#define PT_IP_OFFSET PT_OFFSET(EIP)
-#define PT_IP(regs) ((regs)[EIP])
-#define PT_SP_OFFSET PT_OFFSET(UESP)
-#define PT_SP(regs) ((regs)[UESP])
-
 #define FP_SIZE ((HOST_FPX_SIZE > HOST_FP_SIZE) ? HOST_FPX_SIZE : HOST_FP_SIZE)
 
-#ifndef FRAME_SIZE
-#define FRAME_SIZE (17)
-#endif
-
 #endif
diff --git a/arch/um/sys-x86_64/shared/sysdep/ptrace_user.h b/arch/um/sys-x86_64/shared/sysdep/ptrace_user.h
index faf9cdd..2f1b6e3 100644
--- a/arch/um/sys-x86_64/shared/sysdep/ptrace_user.h
+++ b/arch/um/sys-x86_64/shared/sysdep/ptrace_user.h
@@ -19,35 +19,8 @@
 #define PT_SYSCALL_NR(regs) ((regs)[PT_INDEX(ORIG_RAX)])
 #define PT_SYSCALL_NR_OFFSET (ORIG_RAX)
 
-#define PT_SYSCALL_ARG1(regs) (((unsigned long *) (regs))[PT_INDEX(RDI)])
-#define PT_SYSCALL_ARG1_OFFSET (RDI)
-
-#define PT_SYSCALL_ARG2(regs) (((unsigned long *) (regs))[PT_INDEX(RSI)])
-#define PT_SYSCALL_ARG2_OFFSET (RSI)
-
-#define PT_SYSCALL_ARG3(regs) (((unsigned long *) (regs))[PT_INDEX(RDX)])
-#define PT_SYSCALL_ARG3_OFFSET (RDX)
-
-#define PT_SYSCALL_ARG4(regs) (((unsigned long *) (regs))[PT_INDEX(RCX)])
-#define PT_SYSCALL_ARG4_OFFSET (RCX)
-
-#define PT_SYSCALL_ARG5(regs) (((unsigned long *) (regs))[PT_INDEX(R8)])
-#define PT_SYSCALL_ARG5_OFFSET (R8)
-
-#define PT_SYSCALL_ARG6(regs) (((unsigned long *) (regs))[PT_INDEX(R9)])
-#define PT_SYSCALL_ARG6_OFFSET (R9)
-
 #define PT_SYSCALL_RET_OFFSET (RAX)
 
-#define PT_IP_OFFSET (RIP)
-#define PT_IP(regs) ((regs)[PT_INDEX(RIP)])
-
-#define PT_SP_OFFSET (RSP)
-#define PT_SP(regs) ((regs)[PT_INDEX(RSP)])
-
-#define PT_ORIG_RAX_OFFSET (ORIG_RAX)
-#define PT_ORIG_RAX(regs) ((regs)[PT_INDEX(ORIG_RAX)])
-
 /*
  * x86_64 FC3 doesn't define this in /usr/include/linux/ptrace.h even though
  * it's defined in the kernel's include/linux/ptrace.h. Additionally, use the
@@ -57,18 +30,6 @@
 #define PTRACE_OLDSETOPTIONS 21
 #endif
 
-/*
- * These are before the system call, so the system call number is RAX
- * rather than ORIG_RAX, and arg4 is R10 rather than RCX
- */
-#define REGS_SYSCALL_NR PT_INDEX(RAX)
-#define REGS_SYSCALL_ARG1 PT_INDEX(RDI)
-#define REGS_SYSCALL_ARG2 PT_INDEX(RSI)
-#define REGS_SYSCALL_ARG3 PT_INDEX(RDX)
-#define REGS_SYSCALL_ARG4 PT_INDEX(R10)
-#define REGS_SYSCALL_ARG5 PT_INDEX(R8)
-#define REGS_SYSCALL_ARG6 PT_INDEX(R9)
-
 #define REGS_IP_INDEX PT_INDEX(RIP)
 #define REGS_SP_INDEX PT_INDEX(RSP)
 
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

