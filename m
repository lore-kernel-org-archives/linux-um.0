Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOM0H-0002Bv-8U for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:50:01 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOM0F-00015m-M0
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:50:01 -0800
Message-Id: <200703052241.l25MfK4h008430@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 05 Mar 2007 17:41:20 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/4] UML - Fix formatting violations in signal
	delivery code
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
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Fix a few formatting bugs in the signal code.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/signal.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: test/arch/um/kernel/signal.c
===================================================================
--- test.orig/arch/um/kernel/signal.c	2007-03-05 15:07:53.000000000 -0500
+++ test/arch/um/kernel/signal.c	2007-03-05 15:07:54.000000000 -0500
@@ -161,12 +161,12 @@ static int kern_do_signal(struct pt_regs
 		clear_thread_flag(TIF_RESTORE_SIGMASK);
 		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
 	}
-	return(handled_sig);
+	return handled_sig;
 }
 
 int do_signal(void)
 {
-	return(kern_do_signal(&current->thread.regs));
+	return kern_do_signal(&current->thread.regs);
 }
 
 /*
@@ -189,5 +189,5 @@ long sys_sigsuspend(int history0, int hi
 
 long sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss)
 {
-	return(do_sigaltstack(uss, uoss, PT_REGS_SP(&current->thread.regs)));
+	return do_sigaltstack(uss, uoss, PT_REGS_SP(&current->thread.regs));
 }


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
