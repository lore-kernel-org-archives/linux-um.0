Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4NrV-0000om-U8 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 11:05:05 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4NrV-00065o-6F for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 11:05:05 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20040906180033.7463E8D1E@zion.localdomain>
Subject: [uml-devel] [patch 1/1] uml-mark_broken_configs
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
Date: Mon, 06 Sep 2004 20:00:33 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Some configuration options are known not to compile. So then make them
depend on CONFIG_BROKEN.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/Kconfig       |   27 +++++++++++++++-----------
 uml-linux-2.6.8.1-paolo/arch/um/Kconfig_block |    1 
 uml-linux-2.6.8.1-paolo/arch/um/Kconfig_net   |    2 -
 3 files changed, 18 insertions(+), 12 deletions(-)

diff -puN arch/um/Kconfig~uml-mark_broken_configs arch/um/Kconfig
--- uml-linux-2.6.8.1/arch/um/Kconfig~uml-mark_broken_configs	2004-08-29 14:40:49.316714496 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/Kconfig	2004-08-29 14:40:49.320713888 +0200
@@ -155,6 +155,7 @@ config HOST_2G_2G
 
 config UML_SMP
 	bool "Symmetric multi-processing support"
+	depends on BROKEN
 	help
         This option enables UML SMP support.  UML implements virtual SMP by
         allowing as many processes to run simultaneously on the host as
@@ -203,6 +204,7 @@ config KERNEL_HALF_GIGS
 
 config HIGHMEM
 	bool "Highmem support"
+	depends on BROKEN
 
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
@@ -249,25 +251,28 @@ source "crypto/Kconfig"
 
 source "lib/Kconfig"
 
-menu "SCSI support"
+if BROKEN
+	menu "SCSI support"
 
-config SCSI
-	tristate "SCSI support"
+	config SCSI
+		tristate "SCSI support"
 
 # This gives us free_dma, which scsi.c wants.
-config GENERIC_ISA_DMA
-	bool
-	depends on SCSI
-	default y
+	config GENERIC_ISA_DMA
+		bool
+		depends on SCSI
+		default y
 
-source "arch/um/Kconfig_scsi"
+	source "arch/um/Kconfig_scsi"
 
-endmenu
+	endmenu
+endif
 
 source "drivers/md/Kconfig"
 
-source "drivers/mtd/Kconfig"
-
+if BROKEN
+	source "drivers/mtd/Kconfig"
+endif
 
 menu "Kernel hacking"
 
diff -puN arch/um/Kconfig_block~uml-mark_broken_configs arch/um/Kconfig_block
--- uml-linux-2.6.8.1/arch/um/Kconfig_block~uml-mark_broken_configs	2004-08-29 14:40:49.317714344 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/Kconfig_block	2004-08-29 14:40:49.320713888 +0200
@@ -64,6 +64,7 @@ config BLK_DEV_INITRD
 
 config MMAPPER
 	tristate "Example IO memory driver"
+	depends on BROKEN
 	help
         The User-Mode Linux port can provide support for IO Memory
         emulation with this option.  This allows a host file to be
diff -puN arch/um/Kconfig_net~uml-mark_broken_configs arch/um/Kconfig_net
--- uml-linux-2.6.8.1/arch/um/Kconfig_net~uml-mark_broken_configs	2004-08-29 14:40:49.318714192 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/Kconfig_net	2004-08-29 14:40:49.321713736 +0200
@@ -135,7 +135,7 @@ config UML_NET_MCAST
 
 config UML_NET_PCAP
 	bool "pcap transport"
-	depends on UML_NET
+	depends on UML_NET && BROKEN
 	help
 	The pcap transport makes a pcap packet stream on the host look
 	like an ethernet device inside UML.  This is useful for making 
_


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
