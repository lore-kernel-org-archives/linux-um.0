Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHANl-0002iI-MU for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:13 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CHANi-0007ZR-FK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:13 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041012001801.7FD428697@zion.localdomain>
Subject: [uml-devel] [patch 08/10] uml: mark broken configs
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
Date: Tue, 12 Oct 2004 02:18:01 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Some configuration options are known not to compile. So then make them
depend on CONFIG_BROKEN.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Kconfig       |   27 +++++++++++++-----------
 linux-2.6.9-current-paolo/arch/um/Kconfig_block |    1 
 linux-2.6.9-current-paolo/arch/um/Kconfig_net   |    2 -
 3 files changed, 17 insertions(+), 13 deletions(-)

diff -puN arch/um/Kconfig~uml-mark_broken_configs arch/um/Kconfig
--- linux-2.6.9-current/arch/um/Kconfig~uml-mark_broken_configs	2004-10-12 01:17:58.598244688 +0200
+++ linux-2.6.9-current-paolo/arch/um/Kconfig	2004-10-12 01:17:58.602244080 +0200
@@ -143,7 +143,6 @@ config SMP
         will appear to be running simultaneously.  If the host is a
         multiprocessor, then UML processes may run simultaneously, depending
         on the host scheduler.
-        CONFIG_SMP will be set to whatever this option is set to.
         It is safe to leave this unchanged.
 
 config NR_CPUS
@@ -179,6 +178,7 @@ config KERNEL_HALF_GIGS
 
 config HIGHMEM
 	bool "Highmem support"
+	depends on BROKEN
 
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
@@ -225,23 +225,26 @@ source "crypto/Kconfig"
 
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
 source "arch/um/Kconfig.debug"
diff -puN arch/um/Kconfig_block~uml-mark_broken_configs arch/um/Kconfig_block
--- linux-2.6.9-current/arch/um/Kconfig_block~uml-mark_broken_configs	2004-10-12 01:17:58.599244536 +0200
+++ linux-2.6.9-current-paolo/arch/um/Kconfig_block	2004-10-12 01:17:58.602244080 +0200
@@ -54,6 +54,7 @@ config BLK_DEV_INITRD
 
 config MMAPPER
 	tristate "Example IO memory driver"
+	depends on BROKEN
 	help
         The User-Mode Linux port can provide support for IO Memory
         emulation with this option.  This allows a host file to be
diff -puN arch/um/Kconfig_net~uml-mark_broken_configs arch/um/Kconfig_net
--- linux-2.6.9-current/arch/um/Kconfig_net~uml-mark_broken_configs	2004-10-12 01:17:58.600244384 +0200
+++ linux-2.6.9-current-paolo/arch/um/Kconfig_net	2004-10-12 01:17:58.603243928 +0200
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
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
