Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Mdy-0007MM-4t for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 10:07:50 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8Mdw-00024I-Hz for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 10:07:50 -0800
Message-Id: <200503072037.j27Kbrbc003972@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/16] UML - Fix a shutdown hang caused by a failed
	ifconfig
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 07 Mar 2005 15:37:53 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The network driver wasn't checking that the host side of an interface had
been successfully opened before trying to close it at shuwtdown.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/net_kern.c	2005-03-05 12:07:28.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/net_kern.c	2005-03-05 12:12:13.000000000 -0500
@@ -728,7 +728,8 @@
 
 	list_for_each(ele, &opened){
 		lp = list_entry(ele, struct uml_net_private, list);
-		if(lp->close != NULL) (*lp->close)(lp->fd, &lp->user);
+		if((lp->close != NULL) && (lp->fd >= 0))
+			(*lp->close)(lp->fd, &lp->user);
 		if(lp->remove != NULL) (*lp->remove)(&lp->user);
 	}
 }



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
