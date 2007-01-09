Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H46SN-0006ef-5m for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jan 2007 18:11:19 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H46SL-0001M7-Iq
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jan 2007 18:11:19 -0800
Message-Id: <200701090205.l0925mRk024401@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 08 Jan 2007 21:05:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/7] UML - const a variable
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

kstack_depth_to_print can be made const.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/sysrq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-mm/arch/um/kernel/sysrq.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/sysrq.c	2006-12-29 12:20:14.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/sysrq.c	2007-01-08 16:45:45.000000000 -0500
@@ -50,7 +50,7 @@ void dump_stack(void)
 EXPORT_SYMBOL(dump_stack);
 
 /*Stolen from arch/i386/kernel/traps.c */
-static int kstack_depth_to_print = 24;
+static const int kstack_depth_to_print = 24;
 
 /* This recently started being used in arch-independent code too, as in
  * kernel/sched.c.*/


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
