Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1acZng-0008Lv-R7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Mar 2016 14:36:52 +0000
Received: from mout.gmx.net ([212.227.15.18])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1acZnf-0001eq-Og for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Mar 2016 14:36:52 +0000
From: Eli Cooper <elicooper@gmx.com>
Date: Sun,  6 Mar 2016 22:36:25 +0800
Message-Id: <1457274987-20078-2-git-send-email-elicooper@gmx.com>
In-Reply-To: <1457274987-20078-1-git-send-email-elicooper@gmx.com>
References: <1457274987-20078-1-git-send-email-elicooper@gmx.com>
Subject: [uml-devel] [PATCH 1/3] um: extend _fpstate to _xstate
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
Due to increased frame size, compilers might emit some warnings.

Signed-off-by: Eli Cooper <elicooper@gmx.com>
---
 arch/x86/um/signal.c       | 26 +++++++++++++-------------
 arch/x86/um/user-offsets.c |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 14fcd01..e66bb06 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -225,10 +225,10 @@ static int copy_sc_from_user(struct pt_regs *regs,
 	} else
 #endif
 	{
-		struct user_i387_struct fp;
+		struct _xstate fp;
 
 		err = copy_from_user(&fp, (void *)sc.fpstate,
-				     sizeof(struct user_i387_struct));
+				     sizeof(struct _xstate));
 		if (err)
 			return 1;
 
@@ -244,7 +244,7 @@ static int copy_sc_from_user(struct pt_regs *regs,
 }
 
 static int copy_sc_to_user(struct sigcontext __user *to,
-			   struct _fpstate __user *to_fp, struct pt_regs *regs,
+			   struct _xstate __user *to_fp, struct pt_regs *regs,
 			   unsigned long mask)
 {
 	struct sigcontext sc;
@@ -310,25 +310,25 @@ static int copy_sc_to_user(struct sigcontext __user *to,
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
+		struct _xstate fp;
 
 		err = save_fp_registers(pid, (unsigned long *) &fp);
-		if (copy_to_user(to_fp, &fp, sizeof(struct user_i387_struct)))
+		if (copy_to_user(to_fp, &fp, sizeof(struct _xstate)))
 			return 1;
 	}
 
@@ -337,7 +337,7 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 
 #ifdef CONFIG_X86_32
 static int copy_ucontext_to_user(struct ucontext __user *uc,
-				 struct _fpstate __user *fp, sigset_t *set,
+				 struct _xstate __user *fp, sigset_t *set,
 				 unsigned long sp)
 {
 	int err = 0;
@@ -353,7 +353,7 @@ struct sigframe
 	char __user *pretcode;
 	int sig;
 	struct sigcontext sc;
-	struct _fpstate fpstate;
+	struct _xstate fpstate;
 	unsigned long extramask[_NSIG_WORDS-1];
 	char retcode[8];
 };
@@ -366,7 +366,7 @@ struct rt_sigframe
 	void __user *puc;
 	struct siginfo info;
 	struct ucontext uc;
-	struct _fpstate fpstate;
+	struct _xstate fpstate;
 	char retcode[8];
 };
 
@@ -495,7 +495,7 @@ struct rt_sigframe
 	char __user *pretcode;
 	struct ucontext uc;
 	struct siginfo info;
-	struct _fpstate fpstate;
+	struct _xstate fpstate;
 };
 
 int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index ce7e360..bab4362 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -52,7 +52,7 @@ void foo(void)
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
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

