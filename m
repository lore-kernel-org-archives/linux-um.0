Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1a38MU-00057R-4E
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Nov 2015 20:14:18 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a38MD-00061z-Oo for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Nov 2015 20:14:03 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 29 Nov 2015 21:13:50 +0100
Message-Id: <1448828030-6490-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH] um: Fix fpstate handling
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>

The x86 FPU cleanup changed fpstate to a plain integer.
UML on x86 has to deal with that too.

Signed-off-by: Richard Weinberger <richard@nod.at>

diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 06934a8..e5f854c 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -211,7 +211,7 @@ static int copy_sc_from_user(struct pt_regs *regs,
 		if (err)
 			return 1;
 
-		err = convert_fxsr_from_user(&fpx, sc.fpstate);
+		err = convert_fxsr_from_user(&fpx, (void *)sc.fpstate);
 		if (err)
 			return 1;
 
@@ -227,7 +227,7 @@ static int copy_sc_from_user(struct pt_regs *regs,
 	{
 		struct user_i387_struct fp;
 
-		err = copy_from_user(&fp, sc.fpstate,
+		err = copy_from_user(&fp, (void *)sc.fpstate,
 				     sizeof(struct user_i387_struct));
 		if (err)
 			return 1;
@@ -291,7 +291,7 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 #endif
 #undef PUTREG
 	sc.oldmask = mask;
-	sc.fpstate = to_fp;
+	sc.fpstate = (unsigned long)to_fp;
 
 	err = copy_to_user(to, &sc, sizeof(struct sigcontext));
 	if (err)
@@ -468,12 +468,10 @@ long sys_sigreturn(void)
 	struct sigframe __user *frame = (struct sigframe __user *)(sp - 8);
 	sigset_t set;
 	struct sigcontext __user *sc = &frame->sc;
-	unsigned long __user *oldmask = &sc->oldmask;
-	unsigned long __user *extramask = frame->extramask;
 	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
 
-	if (copy_from_user(&set.sig[0], oldmask, sizeof(set.sig[0])) ||
-	    copy_from_user(&set.sig[1], extramask, sig_size))
+	if (copy_from_user(&set.sig[0], (void *)sc->oldmask, sizeof(set.sig[0])) ||
+	    copy_from_user(&set.sig[1], frame->extramask, sig_size))
 		goto segfault;
 
 	set_current_blocked(&set);
@@ -505,6 +503,7 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 {
 	struct rt_sigframe __user *frame;
 	int err = 0, sig = ksig->sig;
+	unsigned long fp_to;
 
 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16);
@@ -526,7 +525,10 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 	err |= __save_altstack(&frame->uc.uc_stack, PT_REGS_SP(regs));
 	err |= copy_sc_to_user(&frame->uc.uc_mcontext, &frame->fpstate, regs,
 			       set->sig[0]);
-	err |= __put_user(&frame->fpstate, &frame->uc.uc_mcontext.fpstate);
+
+	fp_to = (unsigned long)&frame->fpstate;
+
+	err |= __put_user(fp_to, &frame->uc.uc_mcontext.fpstate);
 	if (sizeof(*set) == 16) {
 		err |= __put_user(set->sig[0], &frame->uc.uc_sigmask.sig[0]);
 		err |= __put_user(set->sig[1], &frame->uc.uc_sigmask.sig[1]);
-- 
1.8.4.5


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

