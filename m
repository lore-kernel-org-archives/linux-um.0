Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FnR4h-0008DU-I5 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 19:13:43 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FmyAe-0001jt-NL for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Jun 2006 12:21:56 -0700
Received: from host10-37.pool8261.interbusiness.it ([82.61.37.10]
	helo=memento.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fmy9g-0003jk-DF for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Jun 2006 12:20:58 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sun, 04 Jun 2006 20:52:12 +0200
Message-Id: <20060604185212.28436.74951.stgit@memento.home.lan>
Subject: [uml-devel] [PATCH] uml: fix signal code x86-64 [for 2.6.15]
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The problems in this area came to light while fixing a compile failure with
GCC 4, in commit bcb01b8a67476e6f748086e626df8424cc27036d. I went comparing this
code with x86_64 frame construction (which we should ABI compatible with) and
resync'ed the code a bit.

It isn't yet perfect, because we don't yet save floating point context. But that
will come later. Additionally, there's a potential problem since RED zones will
alternate stacks are used, unlike x86_64, so more stack space (128 bytes more)
is used. But this shouldn't be a problem.
Instead, having no red zone (like x86_64) will cause problems when a new signal
is delivered on the same alternate stack as one which is being handled, (since
GCC will follow the ABI and place data in the red zone in the handler for the
first delivered signal).

Please give a critical eye, even because things currently have no reported
misbehaviour, and this code is complex enough.

CC: Andi Kleen <ak@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/sys-x86_64/signal.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/um/sys-x86_64/signal.c b/arch/um/sys-x86_64/signal.c
index a4c46a8..7e3952a 100644
--- a/arch/um/sys-x86_64/signal.c
+++ b/arch/um/sys-x86_64/signal.c
@@ -176,6 +176,7 @@ struct rt_sigframe
 
 #define round_down(m, n) (((m) / (n)) * (n))
 
+/* Taken from arch/x86_64/kernel/signal.c:setup_rt_frame(). */
 int setup_signal_stack_si(unsigned long stack_top, int sig,
 			  struct k_sigaction *ka, struct pt_regs * regs,
 			  siginfo_t *info, sigset_t *set)
@@ -186,9 +187,21 @@ int setup_signal_stack_si(unsigned long 
 	int err = 0;
 	struct task_struct *me = current;
 
-	frame = (struct rt_sigframe __user *)
-		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
-        frame = (struct rt_sigframe *) ((unsigned long) frame - 128);
+	/* Leave space on the stack for the Red Zone, and for saving FP
+	 * registers, even if this doesn't happen. We don't have a way to test
+	 * used_math(), so we do that inconditionally.
+	 *
+	 * XXX: RED-PEN: currently, we're using a Red Zone also for any
+	 * alternate stack set up by sigaltstack(), which x86-64 doesn't do
+	 * (because there shouldn't be any code executing there). This could
+	 * cause failures if user setup a too little alternate stack.*/
+
+        fp = (struct _fpstate *) round_down(stack_top - 128 -
+				sizeof(struct _fpstate), 16);
+
+	/* Now leave the space for the rest of signal frame. */
+	frame = (void __user *) round_down((unsigned long) fp -
+			sizeof(struct rt_sigframe), 16) - 8;
 
 	if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate)))
 		goto out;


_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
