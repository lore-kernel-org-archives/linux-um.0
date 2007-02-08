Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFHNd-0004uU-Dt for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 14:04:37 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HFHNa-0004wR-N8
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 14:04:37 -0800
Message-Id: <200702082157.l18LvVRo007607@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 08 Feb 2007 16:57:31 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/3] UML - x86_64 ptrace fixes
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
Cc: wstearns@pobox.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This patch fixes some missing ptrace bits on x86_64.
PTRACE_ARCH_PRCTL is hooked up and implemented.  This required
generalizing arch_prctl_skas slightly to take a task_struct to
modify.  Previously, it always operated on current.

Reading and writing the debug registers is also enabled by un-ifdefing
the code that implements that.  It turns out that x86_64 is identical
to i386, so the same code can be used.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/ptrace.c        |    7 +++++++
 arch/um/sys-x86_64/ptrace.c    |    5 -----
 arch/um/sys-x86_64/syscalls.c  |   14 ++++++++------
 include/asm-um/ptrace-x86_64.h |    3 +++
 4 files changed, 18 insertions(+), 11 deletions(-)

Index: linux-2.6.18-mm/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/ptrace.c	2007-02-08 15:48:46.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/ptrace.c	2007-02-08 15:50:04.000000000 -0500
@@ -18,6 +18,7 @@
 #include "kern_util.h"
 #include "skas_ptrace.h"
 #include "sysdep/ptrace.h"
+#include "os.h"
 
 static inline void set_singlestepping(struct task_struct *child, int on)
 {
@@ -241,6 +242,12 @@ long arch_ptrace(struct task_struct *chi
 		break;
 	}
 #endif
+#ifdef PTRACE_ARCH_PRCTL
+        case PTRACE_ARCH_PRCTL:
+                /* XXX Calls ptrace on the host - needs some SMP thinking */
+                ret = arch_prctl_skas(child, data, (void *) addr);
+                break;
+#endif
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;
Index: linux-2.6.18-mm/arch/um/sys-x86_64/ptrace.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-x86_64/ptrace.c	2007-02-08 15:48:46.000000000 -0500
+++ linux-2.6.18-mm/arch/um/sys-x86_64/ptrace.c	2007-02-08 15:50:04.000000000 -0500
@@ -71,8 +71,6 @@ int poke_user(struct task_struct *child,
 
         if (addr < MAX_REG_OFFSET)
                 return putreg(child, addr, data);
-
-#if 0 /* Need x86_64 debugregs handling */
         else if((addr >= offsetof(struct user, u_debugreg[0])) &&
                 (addr <= offsetof(struct user, u_debugreg[7]))){
                 addr -= offsetof(struct user, u_debugreg[0]);
@@ -81,7 +79,6 @@ int poke_user(struct task_struct *child,
                 child->thread.arch.debugregs[addr] = data;
                 return 0;
         }
-#endif
         return -EIO;
 }
 
@@ -119,14 +116,12 @@ int peek_user(struct task_struct *child,
         if(addr < MAX_REG_OFFSET){
                 tmp = getreg(child, addr);
         }
-#if 0 /* Need x86_64 debugregs handling */
         else if((addr >= offsetof(struct user, u_debugreg[0])) &&
                 (addr <= offsetof(struct user, u_debugreg[7]))){
                 addr -= offsetof(struct user, u_debugreg[0]);
                 addr = addr >> 2;
                 tmp = child->thread.arch.debugregs[addr];
         }
-#endif
         return put_user(tmp, (unsigned long *) data);
 }
 
Index: linux-2.6.18-mm/arch/um/sys-x86_64/syscalls.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-x86_64/syscalls.c	2007-02-08 15:49:53.000000000 -0500
+++ linux-2.6.18-mm/arch/um/sys-x86_64/syscalls.c	2007-02-08 15:50:04.000000000 -0500
@@ -59,18 +59,20 @@ static long arch_prctl_tt(int code, unsi
 
 #ifdef CONFIG_MODE_SKAS
 
-static long arch_prctl_skas(int code, unsigned long __user *addr)
+long arch_prctl_skas(struct task_struct *task, int code,
+                     unsigned long __user *addr)
 {
         unsigned long *ptr = addr, tmp;
 	long ret;
-        int pid = current->mm->context.skas.id.u.pid;
+	int pid = task->mm->context.skas.id.u.pid;
 
 	/*
 	 * With ARCH_SET_FS (and ARCH_SET_GS is treated similarly to
 	 * be safe), we need to call arch_prctl on the host because
 	 * setting %fs may result in something else happening (like a
-	 * GDT being set instead).  So, we let the host fiddle the
-	 * registers and restore them afterwards.
+	 * GDT or thread.fs being set instead).  So, we let the host
+	 * fiddle the registers and thread struct and restore the
+	 * registers afterwards.
 	 *
 	 * So, the saved registers are stored to the process (this
 	 * needed because a stub may have been the last thing to run),
@@ -118,7 +120,7 @@ static long arch_prctl_skas(int code, un
 
 long sys_arch_prctl(int code, unsigned long addr)
 {
-	return CHOOSE_MODE_PROC(arch_prctl_tt, arch_prctl_skas, code,
+	return CHOOSE_MODE_PROC(arch_prctl_tt, arch_prctl_skas, current, code,
                                 (unsigned long __user *) addr);
 }
 
@@ -141,6 +143,6 @@ void arch_switch_to_skas(struct task_str
         if(to->thread.arch.fs == 0)
                 return;
 
-        arch_prctl_skas(ARCH_SET_FS, (void __user *) to->thread.arch.fs);
+        arch_prctl_skas(to, ARCH_SET_FS, (void __user *) to->thread.arch.fs);
 }
 
Index: linux-2.6.18-mm/include/asm-um/ptrace-x86_64.h
===================================================================
--- linux-2.6.18-mm.orig/include/asm-um/ptrace-x86_64.h	2007-02-08 15:48:46.000000000 -0500
+++ linux-2.6.18-mm/include/asm-um/ptrace-x86_64.h	2007-02-08 15:50:04.000000000 -0500
@@ -84,4 +84,7 @@ static inline void arch_switch_to_tt(str
 extern void arch_switch_to_skas(struct task_struct *from,
 				struct task_struct *to);
 
+extern long arch_prctl_skas(struct task_struct *task, int code,
+			    unsigned long __user *addr);
+
 #endif


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
