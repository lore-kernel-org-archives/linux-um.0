Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbgpD-0001MF-2p for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 07:00:23 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CbgpB-0001H3-2t
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 07:00:23 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20041207143643.GA23597@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] uml: symbol export
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
Date: Tue, 7 Dec 2004 15:36:43 +0100
To: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, uml devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade_spam@yahoo.it>

export a missing symbol, IIRC xfs needs that one.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 arch/um/kernel/um_arch.c |    1 +
 1 files changed, 1 insertion(+)

Index: uml-2.6.9-rc2/arch/um/kernel/um_arch.c
===================================================================
--- uml-2.6.9-rc2.orig/arch/um/kernel/um_arch.c	2004-09-16 16:34:51.777620148 +0200
+++ uml-2.6.9-rc2/arch/um/kernel/um_arch.c	2004-09-16 16:44:39.249193721 +0200
@@ -301,6 +301,7 @@ static void __init uml_postsetup(void)
 /* Set during early boot */
 unsigned long brk_start;
 unsigned long end_iomem;
+EXPORT_SYMBOL(end_iomem);
 
 #define MIN_VMALLOC (32 * 1024 * 1024)
 

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
