Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hl9lj-0001dB-Ht for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 May 2007 13:25:15 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hl9li-0007aP-Uw
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 May 2007 13:25:15 -0700
Date: Mon, 7 May 2007 16:20:18 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070507202018.GA8508@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/5] UML - Turn on SCSI support
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
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>

From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Enable (i)SCSI on UML, dunno why SCSI was deemed broken, it works like a
charm. 

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/Kconfig      |   16 --------------
 arch/um/Kconfig.scsi |   58 ---------------------------------------------------
 2 files changed, 1 insertion(+), 73 deletions(-)

Index: linux-2.6.21-mm/arch/um/Kconfig
===================================================================
--- linux-2.6.21-mm.orig/arch/um/Kconfig	2007-05-02 11:33:20.000000000 -0400
+++ linux-2.6.21-mm/arch/um/Kconfig	2007-05-04 13:42:07.000000000 -0400
@@ -320,21 +320,7 @@ source "crypto/Kconfig"
 
 source "lib/Kconfig"
 
-menu "SCSI support"
-depends on BROKEN
-
-config SCSI
-	tristate "SCSI support"
-
-# This gives us free_dma, which scsi.c wants.
-config GENERIC_ISA_DMA
-	bool
-	depends on SCSI
-	default y
-
-source "arch/um/Kconfig.scsi"
-
-endmenu
+source "drivers/scsi/Kconfig"
 
 source "drivers/md/Kconfig"
 
Index: linux-2.6.21-mm/arch/um/Kconfig.scsi
===================================================================
--- linux-2.6.21-mm.orig/arch/um/Kconfig.scsi	2007-02-04 13:44:54.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,58 +0,0 @@
-comment "SCSI support type (disk, tape, CD-ROM)"
-	depends on SCSI
-
-config BLK_DEV_SD
-	tristate "SCSI disk support"
-	depends on SCSI
-
-config SD_EXTRA_DEVS
-	int "Maximum number of SCSI disks that can be loaded as modules"
-	depends on BLK_DEV_SD
-	default "40"
-
-config CHR_DEV_ST
-	tristate "SCSI tape support"
-	depends on SCSI
-
-config BLK_DEV_SR
-	tristate "SCSI CD-ROM support"
-	depends on SCSI
-
-config BLK_DEV_SR_VENDOR
-	bool "Enable vendor-specific extensions (for SCSI CDROM)"
-	depends on BLK_DEV_SR
-
-config SR_EXTRA_DEVS
-	int "Maximum number of CDROM devices that can be loaded as modules"
-	depends on BLK_DEV_SR
-	default "2"
-
-config CHR_DEV_SG
-	tristate "SCSI generic support"
-	depends on SCSI
-
-comment "Some SCSI devices (e.g. CD jukebox) support multiple LUNs"
-	depends on SCSI
-
-#if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-config SCSI_DEBUG_QUEUES
-	bool "Enable extra checks in new queueing code"
-	depends on SCSI
-
-#fi
-config SCSI_MULTI_LUN
-	bool "Probe all LUNs on each SCSI device"
-	depends on SCSI
-
-config SCSI_CONSTANTS
-	bool "Verbose SCSI error reporting (kernel size +=12K)"
-	depends on SCSI
-
-config SCSI_LOGGING
-	bool "SCSI logging facility"
-	depends on SCSI
-
-config SCSI_DEBUG
-	tristate "SCSI debugging host simulator (EXPERIMENTAL)"
-	depends on SCSI
-

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
