Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1ahKDP-0002QK-9E
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2016 16:59:03 +0000
Received: from mout.gmx.net ([212.227.17.20])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ahKDO-0002fv-60
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2016 16:59:03 +0000
From: Eli Cooper <elicooper@gmx.com>
Date: Sun, 20 Mar 2016 00:58:40 +0800
Message-Id: <1458406721-7478-3-git-send-email-elicooper@gmx.com>
In-Reply-To: <1458406721-7478-1-git-send-email-elicooper@gmx.com>
References: <1458406721-7478-1-git-send-email-elicooper@gmx.com>
Subject: [uml-devel] [PATCH v3 2/3] um: extend fpstate to _xstate to support
	YMM registers
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

Extends fpstate to _xstate, in order to hold AVX/YMM registers.

To avoid oversized stack frame, the following functions have been
refactored by using malloc.
 - sig_handler_common
 - timer_real_alarm_handler

Signed-off-by: Eli Cooper <elicooper@gmx.com>
---
 arch/um/os-Linux/signal.c  | 28 ++++++++++++++++++++--------
 arch/x86/um/signal.c       | 23 +++++++++++------------
 arch/x86/um/user-offsets.c |  2 +-
 3 files changed, 32 insertions(+), 21 deletions(-)

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
index dac23ee..49e5036 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -226,7 +226,7 @@ static int copy_sc_from_user(struct pt_regs *regs,
 #endif
 	{
 		err = copy_from_user(regs->regs.fp, (void *)sc.fpstate,
-				     sizeof(struct user_i387_struct));
+				     sizeof(struct _xstate));
 		if (err)
 			return 1;
 	}
@@ -234,7 +234,7 @@ static int copy_sc_from_user(struct pt_regs *regs,
 }
 
 static int copy_sc_to_user(struct sigcontext __user *to,
-			   struct _fpstate __user *to_fp, struct pt_regs *regs,
+			   struct _xstate __user *to_fp, struct pt_regs *regs,
 			   unsigned long mask)
 {
 	struct sigcontext sc;
@@ -300,23 +300,22 @@ static int copy_sc_to_user(struct sigcontext __user *to,
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
-		if (copy_to_user(to_fp, regs->regs.fp,
-				 sizeof(struct user_i387_struct)))
+		if (copy_to_user(to_fp, regs->regs.fp, sizeof(struct _xstate)))
 			return 1;
 	}
 
@@ -325,7 +324,7 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 
 #ifdef CONFIG_X86_32
 static int copy_ucontext_to_user(struct ucontext __user *uc,
-				 struct _fpstate __user *fp, sigset_t *set,
+				 struct _xstate __user *fp, sigset_t *set,
 				 unsigned long sp)
 {
 	int err = 0;
@@ -341,7 +340,7 @@ struct sigframe
 	char __user *pretcode;
 	int sig;
 	struct sigcontext sc;
-	struct _fpstate fpstate;
+	struct _xstate fpstate;
 	unsigned long extramask[_NSIG_WORDS-1];
 	char retcode[8];
 };
@@ -354,7 +353,7 @@ struct rt_sigframe
 	void __user *puc;
 	struct siginfo info;
 	struct ucontext uc;
-	struct _fpstate fpstate;
+	struct _xstate fpstate;
 	char retcode[8];
 };
 
@@ -483,7 +482,7 @@ struct rt_sigframe
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

