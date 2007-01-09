Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H46SN-0006ee-5F for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jan 2007 18:11:19 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H46SL-0000yz-Gj
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jan 2007 18:11:19 -0800
Message-Id: <200701090205.l0925kEv024376@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 08 Jan 2007 21:05:46 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/7] UML - Initialize a list head
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

We need to initialize lists properly.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/stdio_console.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.18-mm/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/stdio_console.c	2007-01-08 14:34:34.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/stdio_console.c	2007-01-08 17:12:30.000000000 -0500
@@ -69,6 +69,7 @@ static struct line_driver driver = {
 	.symlink_from 		= "ttys",
 	.symlink_to 		= "vc",
 	.mc  = {
+		.list		= LIST_HEAD_INIT(driver.mc.list),
 		.name  		= "con",
 		.config 	= con_config,
 		.get_config 	= con_get_config,


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
