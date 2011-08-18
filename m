Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7vd-0007iC-AU
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:06:57 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7vc-0002Qe-Hx
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:06:57 +0000
Date: Thu, 18 Aug 2011 20:06:49 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7vV-0007nR-MI@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 47/91] um: bury unused macros around
	ptrace.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/asm/ptrace-generic.h  |    4 ----
 arch/x86/um/shared/sysdep/ptrace_32.h |    3 ---
 arch/x86/um/shared/sysdep/ptrace_64.h |    3 ---
 3 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index d7c94e4..97c35f8 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -23,14 +23,10 @@ struct pt_regs {
 #define PT_REGS_IP(r) UPT_IP(&(r)->regs)
 #define PT_REGS_SP(r) UPT_SP(&(r)->regs)
 
-#define PT_REGS_SET_SYSCALL_RETURN(r, res) \
-	UPT_SET_SYSCALL_RETURN(&(r)->regs, res)
 #define PT_REGS_RESTART_SYSCALL(r) UPT_RESTART_SYSCALL(&(r)->regs)
 
 #define PT_REGS_SYSCALL_NR(r) UPT_SYSCALL_NR(&(r)->regs)
 
-#define PT_REGS_SC(r) UPT_SC(&(r)->regs)
-
 #define instruction_pointer(regs) PT_REGS_IP(regs)
 
 struct task_struct;
diff --git a/arch/x86/um/shared/sysdep/ptrace_32.h b/arch/x86/um/shared/sysdep/ptrace_32.h
index 487aaae..967b512 100644
--- a/arch/x86/um/shared/sysdep/ptrace_32.h
+++ b/arch/x86/um/shared/sysdep/ptrace_32.h
@@ -100,9 +100,6 @@ struct syscall_args {
 				     UPT_SYSCALL_ARG5(r),	\
 				     UPT_SYSCALL_ARG6(r) } } )
 
-#define UPT_SET_SYSCALL_RETURN(r, res) \
-	REGS_SET_SYSCALL_RETURN((r)->regs, (res))
-
 #define UPT_RESTART_SYSCALL(r) REGS_RESTART_SYSCALL((r)->gp)
 
 #define UPT_ORIG_SYSCALL(r) UPT_EAX(r)
diff --git a/arch/x86/um/shared/sysdep/ptrace_64.h b/arch/x86/um/shared/sysdep/ptrace_64.h
index 787d834..bd7b026 100644
--- a/arch/x86/um/shared/sysdep/ptrace_64.h
+++ b/arch/x86/um/shared/sysdep/ptrace_64.h
@@ -145,9 +145,6 @@ struct syscall_args {
 				     UPT_SYSCALL_ARG5(r),	 \
 				     UPT_SYSCALL_ARG6(r) } } )
 
-#define UPT_SET_SYSCALL_RETURN(r, res) \
-	REGS_SET_SYSCALL_RETURN((r)->regs, (res))
-
 #define UPT_RESTART_SYSCALL(r) REGS_RESTART_SYSCALL((r)->gp)
 
 #define UPT_FAULTINFO(r) (&(r)->faultinfo)
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

