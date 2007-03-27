Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWGx2-0006gm-Q3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 12:03:26 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HWGRU-00047u-UT
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 11:30:49 -0700
Date: Tue, 27 Mar 2007 14:27:48 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070327182748.GA8405@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/6] UML - Fix device unplug crash
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Fix a NULL dereference when unplugging a device.  The default value of
err_msg wants to be "" in case the driver doesn't modify it.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/mconsole_kern.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6.21-mm/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/mconsole_kern.c	2007-03-27 11:35:47.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/mconsole_kern.c	2007-03-27 11:46:28.000000000 -0400
@@ -614,6 +614,9 @@ void mconsole_remove(struct mc_request *
 	err_msg = NULL;
 	err = (*dev->remove)(n, &err_msg);
 	switch(err){
+	case 0:
+		err_msg = "";
+		break;
 	case -ENODEV:
 		if(err_msg == NULL)
 			err_msg = "Device doesn't exist";

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
