Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B81gE-0001Oz-9S for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Mar 2004 10:40:14 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1B81gC-00053i-KN
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Mar 2004 10:40:12 -0800
Received: from hirsch.in-berlin.de (localhost [127.0.0.1])
	by hirsch.in-berlin.de (8.12.11/8.12.11/Debian-3) with ESMTP id
	i2TIe2DZ010158 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 Mar 2004 20:40:06 +0200
Received: (from uucp@localhost)
	by hirsch.in-berlin.de (8.12.11/8.12.11/Debian-3) with UUCP id
	i2TIU3tw009210 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Mar 2004 20:30:03 +0200
Received: from bytesex.org (kraxel@localhost [127.0.0.1])
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) with ESMTP id i2TIc2Zm008377
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 Mar 2004 20:38:02 +0200
Received: (from kraxel@localhost)
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) id i2TIc2Qh008376
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Mar 2004 20:38:02 +0200
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20040329183802.GA8281@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] fix for "make O=..."
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
Date: Mon, 29 Mar 2004 20:38:02 +0200
To: uml devel <user-mode-linux-devel@lists.sourceforge.net>

  Hi,

uml needs the patch below to build with separated source and object
trees.

  Gerd

------------------------------------------------------------------
--- linux-2.6.4.orig/arch/um/Makefile
+++ linux-2.6.4/arch/um/Makefile
@@ -42,11 +42,11 @@
 MAKEFILE-$(CONFIG_MODE_SKAS) += Makefile-skas
 
 ifneq ($(MAKEFILE-y),)
-  include $(addprefix $(ARCH_DIR)/,$(MAKEFILE-y))
+  include $(addprefix $(srctree)/$(ARCH_DIR)/,$(MAKEFILE-y))
 endif
 
-include $(ARCH_DIR)/Makefile-$(SUBARCH)
-include $(ARCH_DIR)/Makefile-os-$(OS)
+include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
+include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
 #EXTRAVERSION := $(EXTRAVERSION)-1um
 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
