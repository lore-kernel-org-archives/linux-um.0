Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1TCs-0005oF-Ge for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 11:52:26 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H1TCr-0008U3-Ug
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 11:52:26 -0800
Message-Id: <200701011947.l01JlCcd020771@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 01 Jan 2007 14:47:12 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/8] UML - make two variables static
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

Make a couple of variables static.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/port_kern.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/port_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/port_kern.c	2007-01-01 11:32:22.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/port_kern.c	2007-01-01 12:03:54.000000000 -0500
@@ -129,8 +129,8 @@ static int port_accept(struct port_list 
 	return(ret);
 } 
 
-DECLARE_MUTEX(ports_sem);
-struct list_head ports = LIST_HEAD_INIT(ports);
+static DECLARE_MUTEX(ports_sem);
+static struct list_head ports = LIST_HEAD_INIT(ports);
 
 void port_work_proc(struct work_struct *unused)
 {


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
