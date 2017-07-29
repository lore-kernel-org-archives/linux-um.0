Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <thomas@m3y3r.de>) id 1dbTHI-0002jr-5a
 for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 29 Jul 2017 15:03:40 +0000
Received: from www17.your-server.de ([213.133.104.17])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dbTHE-00054q-67
 for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 29 Jul 2017 15:03:40 +0000
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sat, 29 Jul 2017 17:03:23 +0200
Message-Id: <20170729150323.3987-1-thomas@m3y3r.de>
In-Reply-To: <ce74d61d-8abe-e77d-f96a-d2a7651a5053@nod.at>
References: <ce74d61d-8abe-e77d-f96a-d2a7651a5053@nod.at>
Subject: [uml-devel] [PATCH] um: v4: Fix FP register size for XSTATE/XSAVE
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net

Hard code max size. Taken from
https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/common/x86-xstate.h

v3: use static fp_regs for get_skas_faultinfo
v4: better be safe, about concurrent action, e.g. timer. move fpregs into thread_info

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/include/asm/thread_info.h |  3 +++
 arch/um/include/shared/os.h       |  2 +-
 arch/um/kernel/process.c          |  4 ++--
 arch/um/os-Linux/skas/process.c   | 17 ++++++++---------
 arch/x86/um/os-Linux/registers.c  | 18 ++++++++++++------
 arch/x86/um/user-offsets.c        |  2 +-
 6 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index 053baff03674..9300f7630d2a 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -11,6 +11,7 @@
 #include <asm/types.h>
 #include <asm/page.h>
 #include <asm/segment.h>
+#include <sysdep/ptrace_user.h>
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
@@ -22,6 +23,8 @@ struct thread_info {
 					 	   0-0xBFFFFFFF for user
 						   0-0xFFFFFFFF for kernel */
 	struct thread_info	*real_thread;    /* Points to non-IRQ stack */
+	unsigned long aux_fp_regs[FP_SIZE];	/* auxiliary fp_regs to save/restore
+						   them out-of-band */
 };
 
 #define INIT_THREAD_INFO(tsk)			\
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 574e03fc7ba2..d8ddaf9790d2 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -278,7 +278,7 @@ extern int protect(struct mm_id * mm_idp, unsigned long addr,
 extern int is_skas_winch(int pid, int fd, void *data);
 extern int start_userspace(unsigned long stub_stack);
 extern int copy_context_skas0(unsigned long stack, int pid);
-extern void userspace(struct uml_pt_regs *regs);
+extern void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs);
 extern int map_stub_pages(int fd, unsigned long code, unsigned long data,
 			  unsigned long stack);
 extern void new_thread(void *stack, jmp_buf *buf, void (*handler)(void));
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 2c7f721eccbc..691b83b10649 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -131,7 +131,7 @@ void new_thread_handler(void)
 	 * callback returns only if the kernel thread execs a process
 	 */
 	n = fn(arg);
-	userspace(&current->thread.regs.regs);
+	userspace(&current->thread.regs.regs, current_thread_info()->aux_fp_regs);
 }
 
 /* Called magically, see new_thread_handler above */
@@ -150,7 +150,7 @@ void fork_handler(void)
 
 	current->thread.prev_sched = NULL;
 
-	userspace(&current->thread.regs.regs);
+	userspace(&current->thread.regs.regs, current_thread_info()->aux_fp_regs);
 }
 
 int copy_thread(unsigned long clone_flags, unsigned long sp,
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 819d68656673..c94c3bd70ccd 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -88,12 +88,11 @@ void wait_stub_done(int pid)
 
 extern unsigned long current_stub_stack(void);
 
-static void get_skas_faultinfo(int pid, struct faultinfo *fi)
+static void get_skas_faultinfo(int pid, struct faultinfo *fi, unsigned long *aux_fp_regs)
 {
 	int err;
-	unsigned long fpregs[FP_SIZE];
 
-	err = get_fp_registers(pid, fpregs);
+	err = get_fp_registers(pid, aux_fp_regs);
 	if (err < 0) {
 		printk(UM_KERN_ERR "save_fp_registers returned %d\n",
 		       err);
@@ -113,7 +112,7 @@ static void get_skas_faultinfo(int pid, struct faultinfo *fi)
 	 */
 	memcpy(fi, (void *)current_stub_stack(), sizeof(*fi));
 
-	err = put_fp_registers(pid, fpregs);
+	err = put_fp_registers(pid, aux_fp_regs);
 	if (err < 0) {
 		printk(UM_KERN_ERR "put_fp_registers returned %d\n",
 		       err);
@@ -121,9 +120,9 @@ static void get_skas_faultinfo(int pid, struct faultinfo *fi)
 	}
 }
 
-static void handle_segv(int pid, struct uml_pt_regs * regs)
+static void handle_segv(int pid, struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 {
-	get_skas_faultinfo(pid, &regs->faultinfo);
+	get_skas_faultinfo(pid, &regs->faultinfo, aux_fp_regs);
 	segv(regs->faultinfo, 0, 1, NULL);
 }
 
@@ -332,7 +331,7 @@ int start_userspace(unsigned long stub_stack)
 	return err;
 }
 
-void userspace(struct uml_pt_regs *regs)
+void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 {
 	int err, status, op, pid = userspace_pid[0];
 	/* To prevent races if using_sysemu changes under us.*/
@@ -407,11 +406,11 @@ void userspace(struct uml_pt_regs *regs)
 			case SIGSEGV:
 				if (PTRACE_FULL_FAULTINFO) {
 					get_skas_faultinfo(pid,
-							   &regs->faultinfo);
+							   &regs->faultinfo, aux_fp_regs);
 					(*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)&si,
 							     regs);
 				}
-				else handle_segv(pid, regs);
+				else handle_segv(pid, regs, aux_fp_regs);
 				break;
 			case SIGTRAP + 0x80:
 			        handle_trap(pid, regs, local_using_sysemu);
diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index 28775f55bde2..3c423dfcd78b 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -5,6 +5,7 @@
  */
 
 #include <errno.h>
+#include <stdlib.h>
 #include <sys/ptrace.h>
 #ifdef __i386__
 #include <sys/user.h>
@@ -31,7 +32,7 @@ int save_fp_registers(int pid, unsigned long *fp_regs)
 
 	if (have_xstate_support) {
 		iov.iov_base = fp_regs;
-		iov.iov_len = sizeof(struct _xstate);
+		iov.iov_len = FP_SIZE * sizeof(unsigned long);
 		if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
 			return -errno;
 		return 0;
@@ -51,10 +52,9 @@ int restore_fp_registers(int pid, unsigned long *fp_regs)
 {
 #ifdef PTRACE_SETREGSET
 	struct iovec iov;
-
 	if (have_xstate_support) {
 		iov.iov_base = fp_regs;
-		iov.iov_len = sizeof(struct _xstate);
+		iov.iov_len = FP_SIZE * sizeof(unsigned long);
 		if (ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
 			return -errno;
 		return 0;
@@ -125,13 +125,19 @@ int put_fp_registers(int pid, unsigned long *regs)
 void arch_init_registers(int pid)
 {
 #ifdef PTRACE_GETREGSET
-	struct _xstate fp_regs;
+	void * fp_regs;
 	struct iovec iov;
 
-	iov.iov_base = &fp_regs;
-	iov.iov_len = sizeof(struct _xstate);
+	fp_regs = malloc(FP_SIZE * sizeof(unsigned long));
+	if(fp_regs == NULL)
+		return;
+
+	iov.iov_base = fp_regs;
+	iov.iov_len = FP_SIZE * sizeof(unsigned long);
 	if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) == 0)
 		have_xstate_support = 1;
+
+	free(fp_regs);
 #endif
 }
 #endif
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index ae4cd58c0c7a..345016ecc1c0 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -51,7 +51,7 @@ void foo(void)
 	DEFINE(HOST_ORIG_AX, ORIG_EAX);
 #else
 #if defined(PTRACE_GETREGSET) && defined(PTRACE_SETREGSET)
-	DEFINE(HOST_FP_SIZE, sizeof(struct _xstate) / sizeof(unsigned long));
+	DEFINE_LONGS(HOST_FP_SIZE, 2696);
 #else
 	DEFINE(HOST_FP_SIZE, sizeof(struct _fpstate) / sizeof(unsigned long));
 #endif
-- 
2.13.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

