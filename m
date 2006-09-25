Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRvIr-0004Ld-Fl for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 11:35:41 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GRvIq-0005xf-W6
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 11:35:41 -0700
Message-Id: <200609251834.k8PIYang005041@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 25 Sep 2006 14:34:36 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/8] UML - Use correct SIGBUS handler
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
Cc: Paolo Giarrusso <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

BB noticed that we had the wrong bus error handler.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/kernel/trap.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/trap.c	2006-09-22 09:19:50.000000000 -0400
+++ linux-2.6.18-mm/arch/um/kernel/trap.c	2006-09-22 09:24:03.000000000 -0400
@@ -139,14 +139,6 @@ void segv_handler(int sig, union uml_pt_
 	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
 }
 
-const struct kern_handlers handlinfo_kern = {
-	.relay_signal = relay_signal,
-	.winch = winch,
-	.bus_handler = relay_signal,
-	.page_fault = segv_handler,
-	.sigio_handler = sigio_handler,
-	.timer_handler = timer_handler
-};
 /*
  * We give a *copy* of the faultinfo in the regs to segv.
  * This must be done, since nesting SEGVs could overwrite
@@ -252,6 +244,15 @@ void winch(int sig, union uml_pt_regs *r
 	do_IRQ(WINCH_IRQ, regs);
 }
 
+const struct kern_handlers handlinfo_kern = {
+	.relay_signal = relay_signal,
+	.winch = winch,
+	.bus_handler = bus_handler,
+	.page_fault = segv_handler,
+	.sigio_handler = sigio_handler,
+	.timer_handler = timer_handler
+};
+
 void trap_init(void)
 {
 }


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
