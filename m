Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1ag78Q-0003mF-7l
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 08:48:54 +0000
Received: from mout.gmx.net ([212.227.15.19])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ag78P-0004Rr-4j for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 08:48:54 +0000
From: Eli Cooper <elicooper@gmx.com>
Date: Wed, 16 Mar 2016 16:48:27 +0800
Message-Id: <1458118109-3178-2-git-send-email-elicooper@gmx.com>
In-Reply-To: <1458118109-3178-1-git-send-email-elicooper@gmx.com>
References: <1458118109-3178-1-git-send-email-elicooper@gmx.com>
Subject: [uml-devel] [PATCH v2 1/3] um: extend _fpstate to _xstate
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>

Extends _fpstate to _xstate, in order to hold AVX/YMM registers.

To avoid oversized stack frame, the following functions has been
refactored by using (k)malloc.
 - copy_sc_to_user
 - copy_sc_from_user
 - sig_handler_common
 - timer_real_alarm_handler

Signed-off-by: Eli Cooper <elicooper@gmx.com>
---
 arch/um/os-Linux/signal.c  | 28 ++++++++++++++++-------
 arch/x86/um/signal.c       | 57 ++++++++++++++++++++++++++++++----------------
 arch/x86/um/user-offsets.c |  2 +-
 3 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 7801666..8acaf4e 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -29,23 +29,29 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 {
-	struct uml_pt_regs r;
+	struct uml_pt_regs *r;
 	int save_errno = errno;
 
-	r.is_user = 0;
+	r = malloc(sizeof(struct uml_pt_regs));
+	if (!r)
+		panic("out of memory");
+
+	r->is_user = 0;
 	if (sig == SIGSEGV) {
 		/* For segfaults, we want the data from the sigcontext. */
-		get_regs_from_mc(&r, mc);
-		GET_FAULTINFO_FROM_MC(r.faultinfo, mc);
+		get_regs_from_mc(r, mc);
+		GET_FAULTINFO_FROM_MC(r->faultinfo, mc);
 	}
 
 	/* enable signals if sig isn't IRQ signal */
 	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGALRM))
 		unblock_signals();
 
-	(*sig_info[sig])(sig, si, &r);
+	(*sig_info[sig])(sig, si, r);
 
 	errno = save_errno;
+
+	free(r);
 }
 
 /*
@@ -83,11 +89,17 @@ void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 
 static void timer_real_alarm_handler(mcontext_t *mc)
 {
-	struct uml_pt_regs regs;
+	struct uml_pt_regs *regs;
+
+	regs = malloc(sizeof(struct uml_pt_regs));
+	if (!regs)
+		panic("out of memory");
 
 	if (mc != NULL)
-		get_regs_from_mc(&regs, mc);
-	timer_handler(SIGALRM, NULL, &regs);
+		get_regs_from_mc(regs, mc);
+	timer_handler(SIGALRM, NULL, regs);
+
+	free(regs);
 }
 
 void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 14fcd01..a350535 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -8,6 +8,7 @@
 #include <linux/personality.h>
 #include <linux/ptrace.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <asm/unistd.h>
 #include <asm/uaccess.h>
 #include <asm/ucontext.h>
@@ -155,6 +156,7 @@ static int copy_sc_from_user(struct pt_regs *regs,
 {
 	struct sigcontext sc;
 	int err, pid;
+	struct _xstate *fp;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
@@ -225,30 +227,39 @@ static int copy_sc_from_user(struct pt_regs *regs,
 	} else
 #endif
 	{
-		struct user_i387_struct fp;
+		fp = kmalloc(sizeof(struct _xstate), GFP_ATOMIC);
+		if (!fp)
+			return 1;
 
-		err = copy_from_user(&fp, (void *)sc.fpstate,
-				     sizeof(struct user_i387_struct));
+		err = copy_from_user(fp, (void *)sc.fpstate,
+				     sizeof(struct _xstate));
 		if (err)
-			return 1;
+			goto err;
 
-		err = restore_fp_registers(pid, (unsigned long *) &fp);
+		err = restore_fp_registers(pid, (unsigned long *) fp);
 		if (err < 0) {
 			printk(KERN_ERR "copy_sc_from_user - "
 			       "restore_fp_registers failed, errno = %d\n",
 			       -err);
-			return 1;
+			goto err;
 		}
+
+		kfree(fp);
 	}
 	return 0;
+
+err:
+	kfree(fp);
+	return 1;
 }
 
 static int copy_sc_to_user(struct sigcontext __user *to,
-			   struct _fpstate __user *to_fp, struct pt_regs *regs,
+			   struct _xstate __user *to_fp, struct pt_regs *regs,
 			   unsigned long mask)
 {
 	struct sigcontext sc;
 	struct faultinfo * fi = &current->thread.arch.faultinfo;
+	struct _xstate *fp;
 	int err, pid;
 	memset(&sc, 0, sizeof(struct sigcontext));
 
@@ -310,34 +321,42 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 			return 1;
 		}
 
-		err = convert_fxsr_to_user(to_fp, &fpx);
+		err = convert_fxsr_to_user(&to_fp->fpstate, &fpx);
 		if (err)
 			return 1;
 
-		err |= __put_user(fpx.swd, &to_fp->status);
-		err |= __put_user(X86_FXSR_MAGIC, &to_fp->magic);
+		err |= __put_user(fpx.swd, &to_fp->fpstate.status);
+		err |= __put_user(X86_FXSR_MAGIC, &to_fp->fpstate.magic);
 		if (err)
 			return 1;
 
-		if (copy_to_user(&to_fp->_fxsr_env[0], &fpx,
+		if (copy_to_user(&to_fp->fpstate._fxsr_env[0], &fpx,
 				 sizeof(struct user_fxsr_struct)))
 			return 1;
 	} else
 #endif
 	{
-		struct user_i387_struct fp;
-
-		err = save_fp_registers(pid, (unsigned long *) &fp);
-		if (copy_to_user(to_fp, &fp, sizeof(struct user_i387_struct)))
+		fp = kmalloc(sizeof(struct _xstate), GFP_ATOMIC);
+		if (!fp)
 			return 1;
+
+		err = save_fp_registers(pid, (unsigned long *) fp);
+		if (copy_to_user(to_fp, fp, sizeof(struct _xstate)))
+			goto err;
+
+		kfree(fp);
 	}
 
 	return 0;
+
+err:
+	kfree(fp);
+	return 1;
 }
 
 #ifdef CONFIG_X86_32
 static int copy_ucontext_to_user(struct ucontext __user *uc,
-				 struct _fpstate __user *fp, sigset_t *set,
+				 struct _xstate __user *fp, sigset_t *set,
 				 unsigned long sp)
 {
 	int err = 0;
@@ -353,7 +372,7 @@ struct sigframe
 	char __user *pretcode;
 	int sig;
 	struct sigcontext sc;
-	struct _fpstate fpstate;
+	struct _xstate fpstate;
 	unsigned long extramask[_NSIG_WORDS-1];
 	char retcode[8];
 };
@@ -366,7 +385,7 @@ struct rt_sigframe
 	void __user *puc;
 	struct siginfo info;
 	struct ucontext uc;
-	struct _fpstate fpstate;
+	struct _xstate fpstate;
 	char retcode[8];
 };
 
@@ -495,7 +514,7 @@ struct rt_sigframe
 	char __user *pretcode;
 	struct ucontext uc;
 	struct siginfo info;
-	struct _fpstate fpstate;
+	struct _xstate fpstate;
 };
 
 int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index 470564b..cb3c223 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -50,7 +50,7 @@ void foo(void)
 	DEFINE(HOST_GS, GS);
 	DEFINE(HOST_ORIG_AX, ORIG_EAX);
 #else
-	DEFINE(HOST_FP_SIZE, sizeof(struct _fpstate) / sizeof(unsigned long));
+	DEFINE(HOST_FP_SIZE, sizeof(struct _xstate) / sizeof(unsigned long));
 	DEFINE_LONGS(HOST_BX, RBX);
 	DEFINE_LONGS(HOST_CX, RCX);
 	DEFINE_LONGS(HOST_DI, RDI);
-- 
2.7.2


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

