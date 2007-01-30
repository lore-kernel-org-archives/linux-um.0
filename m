Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBwF2-0006m7-0R for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 08:53:56 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBwEw-00075z-RS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 08:53:52 -0800
Message-Id: <200701301646.l0UGkXd6005828@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 30 Jan 2007 11:46:32 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH] UML - Fix signal frame alignment
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
To: akpm@osdl.org, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This is both 2.6.20 and -stable material.

Use the same signal frame alignment calculations as the underlying
architecture.  x86_64 appeared to do this, but the "- 8" was really
subtracting 8 * sizeof(struct rt_sigframe) rather than 8 bytes.

UML/i386 might have been OK, but I changed the calculation to match
i386 just to be sure.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/sys-i386/signal.c   |    3 ++-
 arch/um/sys-x86_64/signal.c |    5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6.18-mm/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-x86_64/signal.c	2007-01-29 14:20:57.000000000 -0500
+++ linux-2.6.18-mm/arch/um/sys-x86_64/signal.c	2007-01-30 11:46:38.000000000 -0500
@@ -191,8 +191,9 @@ int setup_signal_stack_si(unsigned long 
 	struct task_struct *me = current;
 
 	frame = (struct rt_sigframe __user *)
-		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
-        frame = (struct rt_sigframe __user *) ((unsigned long) frame - 128);
+		round_down(stack_top - sizeof(struct rt_sigframe), 16);
+	/* Subtract 128 for a red zone and 8 for proper alignment */
+        frame = (struct rt_sigframe __user *) ((unsigned long) frame - 128 - 8);
 
 	if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate)))
 		goto out;
Index: linux-2.6.18-mm/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-i386/signal.c	2007-01-17 06:02:52.000000000 -0500
+++ linux-2.6.18-mm/arch/um/sys-i386/signal.c	2007-01-30 11:39:10.000000000 -0500
@@ -219,7 +219,8 @@ int setup_signal_stack_sc(unsigned long 
 	unsigned long save_sp = PT_REGS_SP(regs);
 	int err = 0;
 
-	stack_top &= -8UL;
+	/* This is the same calculation as i386 - ((sp + 4) & 15) == 0 */
+	stack_top = ((stack_top + 4) & -16UL) - 4;
 	frame = (struct sigframe __user *) stack_top - 1;
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		return 1;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
