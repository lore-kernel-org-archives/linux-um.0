Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbgpC-0001M8-Df for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 07:00:22 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CbgpB-0001H5-3h
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 07:00:22 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20041207143541.GA23555@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] uml: ramdisk config fix
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
Date: Tue, 7 Dec 2004 15:35:41 +0100
To: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, uml devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade_spam@yahoo.it>

ObviouslyCorrect[tm] buildfix ;)
Should go into 2.6.10.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 arch/um/Kconfig_block |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux-2.6.10-rc3/arch/um/Kconfig_block
===================================================================
--- linux-2.6.10-rc3.orig/arch/um/Kconfig_block	2004-12-07 12:12:09.000000000 +0100
+++ linux-2.6.10-rc3/arch/um/Kconfig_block	2004-12-07 13:41:38.692103167 +0100
@@ -43,6 +43,10 @@ config BLK_DEV_NBD
 config BLK_DEV_RAM
 	tristate "RAM disk support"
 
+config BLK_DEV_RAM_COUNT
+	int "Default number of RAM disks" if BLK_DEV_RAM
+	default "16"
+
 config BLK_DEV_RAM_SIZE
 	int "Default RAM disk size"
 	depends on BLK_DEV_RAM

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
