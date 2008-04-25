Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpSA1-0003kp-HI for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:37 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JpS9v-0005OP-Jr
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:37 -0700
Date: Fri, 25 Apr 2008 13:56:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080425175610.GA11188@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 9/19] UML - Tidy ptrace interface
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Tidy the ptrace interface code.  Removed a bunch of unused macros.
Started converting register sets from arrays of longs to structures.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/sysdep-i386/ptrace_user.h   |   30 ----------------------------
 arch/um/include/sysdep-x86_64/ptrace_user.h |   17 +++------------
 arch/um/os-Linux/sys-i386/registers.c       |    5 ++--
 arch/um/sys-i386/ptrace.c                   |   30 +++++++++++++---------------
 arch/um/sys-i386/user-offsets.c             |    2 -
 arch/um/sys-x86_64/user-offsets.c           |    1 
 6 files changed, 23 insertions(+), 62 deletions(-)

Index: linux-2.6-git/arch/um/include/sysdep-i386/ptrace_user.h
===================================================================
--- linux-2.6-git.orig/arch/um/include/sysdep-i386/ptrace_user.h	2008-02-12 13:05:07.000000000 -0500
+++ linux-2.6-git/arch/um/include/sysdep-i386/ptrace_user.h	2008-02-12 13:09:44.000000000 -0500
@@ -41,38 +41,10 @@
 #define PT_SP_OFFSET PT_OFFSET(UESP)
 #define PT_SP(regs) ((regs)[UESP])
 
-#define FP_SIZE ((HOST_XFP_SIZE > HOST_FP_SIZE) ? HOST_XFP_SIZE : HOST_FP_SIZE)
+#define FP_SIZE ((HOST_FPX_SIZE > HOST_FP_SIZE) ? HOST_FPX_SIZE : HOST_FP_SIZE)
 
 #ifndef FRAME_SIZE
 #define FRAME_SIZE (17)
 #endif
-#define FRAME_SIZE_OFFSET (FRAME_SIZE * sizeof(unsigned long))
-
-#define FP_FRAME_SIZE (27)
-#define FPX_FRAME_SIZE (128)
-
-#ifdef PTRACE_GETREGS
-#define UM_HAVE_GETREGS
-#endif
-
-#ifdef PTRACE_SETREGS
-#define UM_HAVE_SETREGS
-#endif
-
-#ifdef PTRACE_GETFPREGS
-#define UM_HAVE_GETFPREGS
-#endif
-
-#ifdef PTRACE_SETFPREGS
-#define UM_HAVE_SETFPREGS
-#endif
-
-#ifdef PTRACE_GETFPXREGS
-#define UM_HAVE_GETFPXREGS
-#endif
-
-#ifdef PTRACE_SETFPXREGS
-#define UM_HAVE_SETFPXREGS
-#endif
 
 #endif
Index: linux-2.6-git/arch/um/include/sysdep-x86_64/ptrace_user.h
===================================================================
--- linux-2.6-git.orig/arch/um/include/sysdep-x86_64/ptrace_user.h	2008-02-12 13:05:07.000000000 -0500
+++ linux-2.6-git/arch/um/include/sysdep-x86_64/ptrace_user.h	2008-02-12 13:09:44.000000000 -0500
@@ -48,7 +48,8 @@
 #define PT_ORIG_RAX_OFFSET (ORIG_RAX)
 #define PT_ORIG_RAX(regs) ((regs)[PT_INDEX(ORIG_RAX)])
 
-/* x86_64 FC3 doesn't define this in /usr/include/linux/ptrace.h even though
+/*
+ * x86_64 FC3 doesn't define this in /usr/include/linux/ptrace.h even though
  * it's defined in the kernel's include/linux/ptrace.h. Additionally, use the
  * 2.4 name and value for 2.4 host compatibility.
  */
@@ -56,7 +57,8 @@
 #define PTRACE_OLDSETOPTIONS 21
 #endif
 
-/* These are before the system call, so the system call number is RAX
+/*
+ * These are before the system call, so the system call number is RAX
  * rather than ORIG_RAX, and arg4 is R10 rather than RCX
  */
 #define REGS_SYSCALL_NR PT_INDEX(RAX)
@@ -73,14 +75,3 @@
 #define FP_SIZE (HOST_FP_SIZE)
 
 #endif
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
Index: linux-2.6-git/arch/um/sys-i386/ptrace.c
===================================================================
--- linux-2.6-git.orig/arch/um/sys-i386/ptrace.c	2008-02-12 12:44:44.000000000 -0500
+++ linux-2.6-git/arch/um/sys-i386/ptrace.c	2008-02-12 13:16:14.000000000 -0500
@@ -148,14 +148,13 @@ int peek_user(struct task_struct *child,
 int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
 {
 	int err, n, cpu = ((struct thread_info *) child->stack)->cpu;
-	long fpregs[HOST_FP_SIZE];
+	struct user_i387_struct fpregs;
 
-	BUG_ON(sizeof(*buf) != sizeof(fpregs));
-	err = save_fp_registers(userspace_pid[cpu], fpregs);
+	err = save_fp_registers(userspace_pid[cpu], (unsigned long *) &fpregs);
 	if (err)
 		return err;
 
-	n = copy_to_user(buf, fpregs, sizeof(fpregs));
+	n = copy_to_user(buf, &fpregs, sizeof(fpregs));
 	if(n > 0)
 		return -EFAULT;
 
@@ -165,27 +164,26 @@ int get_fpregs(struct user_i387_struct _
 int set_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
 {
 	int n, cpu = ((struct thread_info *) child->stack)->cpu;
-	long fpregs[HOST_FP_SIZE];
+	struct user_i387_struct fpregs;
 
-	BUG_ON(sizeof(*buf) != sizeof(fpregs));
-	n = copy_from_user(fpregs, buf, sizeof(fpregs));
+	n = copy_from_user(&fpregs, buf, sizeof(fpregs));
 	if (n > 0)
 		return -EFAULT;
 
-	return restore_fp_registers(userspace_pid[cpu], fpregs);
+	return restore_fp_registers(userspace_pid[cpu],
+				    (unsigned long *) &fpregs);
 }
 
 int get_fpxregs(struct user_fxsr_struct __user *buf, struct task_struct *child)
 {
 	int err, n, cpu = ((struct thread_info *) child->stack)->cpu;
-	long fpregs[HOST_XFP_SIZE];
+	struct user_fxsr_struct fpregs;
 
-	BUG_ON(sizeof(*buf) != sizeof(fpregs));
-	err = save_fpx_registers(userspace_pid[cpu], fpregs);
+	err = save_fpx_registers(userspace_pid[cpu], (unsigned long *) &fpregs);
 	if (err)
 		return err;
 
-	n = copy_to_user(buf, fpregs, sizeof(fpregs));
+	n = copy_to_user(buf, &fpregs, sizeof(fpregs));
 	if(n > 0)
 		return -EFAULT;
 
@@ -195,14 +193,14 @@ int get_fpxregs(struct user_fxsr_struct 
 int set_fpxregs(struct user_fxsr_struct __user *buf, struct task_struct *child)
 {
 	int n, cpu = ((struct thread_info *) child->stack)->cpu;
-	long fpregs[HOST_XFP_SIZE];
+	struct user_fxsr_struct fpregs;
 
-	BUG_ON(sizeof(*buf) != sizeof(fpregs));
-	n = copy_from_user(fpregs, buf, sizeof(fpregs));
+	n = copy_from_user(&fpregs, buf, sizeof(fpregs));
 	if (n > 0)
 		return -EFAULT;
 
-	return restore_fpx_registers(userspace_pid[cpu], fpregs);
+	return restore_fpx_registers(userspace_pid[cpu],
+				     (unsigned long *) &fpregs);
 }
 
 long subarch_ptrace(struct task_struct *child, long request, long addr,
Index: linux-2.6-git/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6-git.orig/arch/um/os-Linux/sys-i386/registers.c	2008-02-12 13:05:07.000000000 -0500
+++ linux-2.6-git/arch/um/os-Linux/sys-i386/registers.c	2008-02-12 13:10:44.000000000 -0500
@@ -5,6 +5,7 @@
  */
 
 #include <errno.h>
+#include <asm/user.h>
 #include "kern_constants.h"
 #include "longjmp.h"
 #include "user.h"
@@ -74,10 +75,10 @@ int put_fp_registers(int pid, unsigned l
 
 void arch_init_registers(int pid)
 {
-	unsigned long fpx_regs[HOST_XFP_SIZE];
+	struct user_fxsr_struct fpx_regs;
 	int err;
 
-	err = ptrace(PTRACE_GETFPXREGS, pid, 0, fpx_regs);
+	err = ptrace(PTRACE_GETFPXREGS, pid, 0, &fpx_regs);
 	if (!err)
 		return;
 
Index: linux-2.6-git/arch/um/sys-i386/user-offsets.c
===================================================================
--- linux-2.6-git.orig/arch/um/sys-i386/user-offsets.c	2008-02-12 13:00:01.000000000 -0500
+++ linux-2.6-git/arch/um/sys-i386/user-offsets.c	2008-02-12 13:09:44.000000000 -0500
@@ -22,7 +22,7 @@ void foo(void)
 	OFFSET(HOST_SC_CR2, sigcontext, cr2);
 
 	DEFINE_LONGS(HOST_FP_SIZE, sizeof(struct user_fpregs_struct));
-	DEFINE_LONGS(HOST_XFP_SIZE, sizeof(struct user_fpxregs_struct));
+	DEFINE_LONGS(HOST_FPX_SIZE, sizeof(struct user_fpxregs_struct));
 
 	DEFINE(HOST_IP, EIP);
 	DEFINE(HOST_SP, UESP);
Index: linux-2.6-git/arch/um/sys-x86_64/user-offsets.c
===================================================================
--- linux-2.6-git.orig/arch/um/sys-x86_64/user-offsets.c	2008-02-12 13:00:01.000000000 -0500
+++ linux-2.6-git/arch/um/sys-x86_64/user-offsets.c	2008-02-12 13:09:44.000000000 -0500
@@ -24,7 +24,6 @@ void foo(void)
 	OFFSET(HOST_SC_TRAPNO, sigcontext, trapno);
 
 	DEFINE(HOST_FP_SIZE, sizeof(struct _fpstate) / sizeof(unsigned long));
-	DEFINE(HOST_XFP_SIZE, 0);
 	DEFINE_LONGS(HOST_RBX, RBX);
 	DEFINE_LONGS(HOST_RCX, RCX);
 	DEFINE_LONGS(HOST_RDI, RDI);

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
