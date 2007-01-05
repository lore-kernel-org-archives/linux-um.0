Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H2u6M-0001Qn-N6 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 10:47:38 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H2u6M-0005hM-92
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 10:47:38 -0800
Message-Id: <200701051842.l05IgDPV004617@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Fri, 05 Jan 2007 13:42:13 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/9] UML - Locking commentary in the random driver
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

Comment the lack of locking.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/random.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.18-mm/arch/um/drivers/random.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/random.c	2006-12-29 12:20:14.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/random.c	2007-01-01 13:12:54.000000000 -0500
@@ -78,6 +78,7 @@ static const struct file_operations rng_
 	.read		= rng_dev_read,
 };
 
+/* rng_init shouldn't be called more than once at boot time */
 static struct miscdevice rng_miscdev = {
 	RNG_MISCDEV_MINOR,
 	RNG_MODULE_NAME,


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
