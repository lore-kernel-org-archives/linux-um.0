Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1dVNhE-0001F5-Vk
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2017 19:53:16 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dVNhD-0004gA-Sk
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2017 19:53:16 +0000
References: <c99c3170-53a6-4038-9033-5a3680b1e5db@email.android.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <ce74d61d-8abe-e77d-f96a-d2a7651a5053@nod.at>
Date: Wed, 12 Jul 2017 21:53:07 +0200
MIME-Version: 1.0
In-Reply-To: <c99c3170-53a6-4038-9033-5a3680b1e5db@email.android.com>
Content-Language: en-US
Subject: Re: [uml-devel] [PATCH] um: v3: Fix FP register size for
 XSTATE/XSAVE
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

Thomas,

what about something like that? (untested)
Still not very pretty but IMHO better.

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
index cd1fa97776c3..c1d4b6fbc919 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -274,7 +274,7 @@ extern int protect(struct mm_id * mm_idp, unsigned long addr,
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
index 03b3c4cc7735..d92a0240dce4 100644
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

@@ -303,7 +302,7 @@ int start_userspace(unsigned long stub_stack)
 	return err;
 }

-void userspace(struct uml_pt_regs *regs)
+void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 {
 	int err, status, op, pid = userspace_pid[0];
 	/* To prevent races if using_sysemu changes under us.*/
@@ -372,11 +371,11 @@ void userspace(struct uml_pt_regs *regs)
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

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

