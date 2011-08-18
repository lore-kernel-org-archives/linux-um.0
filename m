Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7st-0007oh-Cz
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:04:07 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7ss-0002L5-JU
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:04:07 +0000
Date: Thu, 18 Aug 2011 20:03:59 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7sl-0007e0-FX@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 30/91] um: kill includes of
 sysdep/sigcontext.h from stuff built with kernel headers
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/kernel/signal.c                       |    1 -
 arch/um/kernel/trap.c                         |    1 -
 arch/um/sys-x86/shared/sysdep/faultinfo_32.h  |    6 ++++++
 arch/um/sys-x86/shared/sysdep/faultinfo_64.h  |    6 ++++++
 arch/um/sys-x86/shared/sysdep/ptrace_32.h     |    1 +
 arch/um/sys-x86/shared/sysdep/ptrace_64.h     |    5 +----
 arch/um/sys-x86/shared/sysdep/sigcontext_32.h |    8 --------
 arch/um/sys-x86/shared/sysdep/sigcontext_64.h |    8 --------
 8 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
index b5c094c..e8b889d 100644
--- a/arch/um/kernel/signal.c
+++ b/arch/um/kernel/signal.c
@@ -11,7 +11,6 @@
 #include <asm/unistd.h>
 #include "frame_kern.h"
 #include "kern_util.h"
-#include <sysdep/sigcontext.h>
 
 EXPORT_SYMBOL(block_signals);
 EXPORT_SYMBOL(unblock_signals);
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 8c7b882..f2a2036 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -14,7 +14,6 @@
 #include "kern_util.h"
 #include "os.h"
 #include "skas.h"
-#include "sysdep/sigcontext.h"
 
 /*
  * Note this is constrained to return 0, -EFAULT, -EACCESS, -ENOMEM by
diff --git a/arch/um/sys-x86/shared/sysdep/faultinfo_32.h b/arch/um/sys-x86/shared/sysdep/faultinfo_32.h
index db437cc..a26086b 100644
--- a/arch/um/sys-x86/shared/sysdep/faultinfo_32.h
+++ b/arch/um/sys-x86/shared/sysdep/faultinfo_32.h
@@ -24,6 +24,12 @@ struct faultinfo {
 #define FAULT_WRITE(fi) ((fi).error_code & 2)
 #define FAULT_ADDRESS(fi) ((fi).cr2)
 
+/* This is Page Fault */
+#define SEGV_IS_FIXABLE(fi)	((fi)->trap_no == 14)
+
+/* SKAS3 has no trap_no on i386, but get_skas_faultinfo() sets it to 0. */
+#define SEGV_MAYBE_FIXABLE(fi)	((fi)->trap_no == 0 && ptrace_faultinfo)
+
 #define PTRACE_FULL_FAULTINFO 0
 
 #endif
diff --git a/arch/um/sys-x86/shared/sysdep/faultinfo_64.h b/arch/um/sys-x86/shared/sysdep/faultinfo_64.h
index cb917b0..f811cbe 100644
--- a/arch/um/sys-x86/shared/sysdep/faultinfo_64.h
+++ b/arch/um/sys-x86/shared/sysdep/faultinfo_64.h
@@ -24,6 +24,12 @@ struct faultinfo {
 #define FAULT_WRITE(fi) ((fi).error_code & 2)
 #define FAULT_ADDRESS(fi) ((fi).cr2)
 
+/* This is Page Fault */
+#define SEGV_IS_FIXABLE(fi)	((fi)->trap_no == 14)
+
+/* No broken SKAS API, which doesn't pass trap_no, here. */
+#define SEGV_MAYBE_FIXABLE(fi)	0
+
 #define PTRACE_FULL_FAULTINFO 1
 
 #endif
diff --git a/arch/um/sys-x86/shared/sysdep/ptrace_32.h b/arch/um/sys-x86/shared/sysdep/ptrace_32.h
index 8e721ed8..487aaae 100644
--- a/arch/um/sys-x86/shared/sysdep/ptrace_32.h
+++ b/arch/um/sys-x86/shared/sysdep/ptrace_32.h
@@ -43,6 +43,7 @@ extern int sysemu_supported;
 
 #define REGS_SET_SYSCALL_RETURN(r, res) REGS_EAX(r) = (res)
 
+#define IP_RESTART_SYSCALL(ip) ((ip) -= 2)
 #define REGS_RESTART_SYSCALL(r) IP_RESTART_SYSCALL(REGS_IP(r))
 
 #ifndef PTRACE_SYSEMU_SINGLESTEP
diff --git a/arch/um/sys-x86/shared/sysdep/ptrace_64.h b/arch/um/sys-x86/shared/sysdep/ptrace_64.h
index 2d4b223..787d834 100644
--- a/arch/um/sys-x86/shared/sysdep/ptrace_64.h
+++ b/arch/um/sys-x86/shared/sysdep/ptrace_64.h
@@ -69,10 +69,9 @@
 
 #define REGS_SET_SYSCALL_RETURN(r, res) REGS_RAX(r) = (res)
 
+#define IP_RESTART_SYSCALL(ip) ((ip) -= 2)
 #define REGS_RESTART_SYSCALL(r) IP_RESTART_SYSCALL(REGS_IP(r))
 
-#define REGS_SEGV_IS_FIXABLE(r) SEGV_IS_FIXABLE((r)->trap_type)
-
 #define REGS_FAULT_ADDR(r) ((r)->fault_addr)
 
 #define REGS_FAULT_WRITE(r) FAULT_WRITE((r)->fault_type)
@@ -151,8 +150,6 @@ struct syscall_args {
 
 #define UPT_RESTART_SYSCALL(r) REGS_RESTART_SYSCALL((r)->gp)
 
-#define UPT_SEGV_IS_FIXABLE(r) REGS_SEGV_IS_FIXABLE(&r->skas)
-
 #define UPT_FAULTINFO(r) (&(r)->faultinfo)
 
 static inline void arch_init_registers(int pid)
diff --git a/arch/um/sys-x86/shared/sysdep/sigcontext_32.h b/arch/um/sys-x86/shared/sysdep/sigcontext_32.h
index 3827864..aebc2dd 100644
--- a/arch/um/sys-x86/shared/sysdep/sigcontext_32.h
+++ b/arch/um/sys-x86/shared/sysdep/sigcontext_32.h
@@ -8,8 +8,6 @@
 
 #include <generated/user_constants.h>
 
-#define IP_RESTART_SYSCALL(ip) ((ip) -= 2)
-
 #define SC_OFFSET(sc, field) \
 	*((unsigned long *) &(((char *) (sc))[HOST_##field]))
 
@@ -24,10 +22,4 @@
 		(fi).trap_no = SC_TRAPNO(sc); \
 	}
 
-/* This is Page Fault */
-#define SEGV_IS_FIXABLE(fi)	((fi)->trap_no == 14)
-
-/* SKAS3 has no trap_no on i386, but get_skas_faultinfo() sets it to 0. */
-#define SEGV_MAYBE_FIXABLE(fi)	((fi)->trap_no == 0 && ptrace_faultinfo)
-
 #endif
diff --git a/arch/um/sys-x86/shared/sysdep/sigcontext_64.h b/arch/um/sys-x86/shared/sysdep/sigcontext_64.h
index 9fb5277..60d89a2 100644
--- a/arch/um/sys-x86/shared/sysdep/sigcontext_64.h
+++ b/arch/um/sys-x86/shared/sysdep/sigcontext_64.h
@@ -15,8 +15,6 @@
 #define SC_ERR(sc) SC_OFFSET(sc, SC_ERR)
 #define SC_TRAPNO(sc) SC_OFFSET(sc, SC_TRAPNO)
 
-#define IP_RESTART_SYSCALL(ip) ((ip) -= 2)
-
 #define GET_FAULTINFO_FROM_SC(fi, sc) \
 	{ \
 		(fi).cr2 = SC_CR2(sc); \
@@ -24,10 +22,4 @@
 		(fi).trap_no = SC_TRAPNO(sc); \
 	}
 
-/* This is Page Fault */
-#define SEGV_IS_FIXABLE(fi)	((fi)->trap_no == 14)
-
-/* No broken SKAS API, which doesn't pass trap_no, here. */
-#define SEGV_MAYBE_FIXABLE(fi)	0
-
 #endif
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

