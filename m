Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8MdQ-0007KG-DA for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 10:07:16 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8MdO-0001tt-Dl for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 10:07:16 -0800
Message-Id: <200503072037.j27KbGbc003947@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/16] UML - Update defconfig
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
Date: Mon, 07 Mar 2005 15:37:16 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/defconfig
===================================================================
--- linux-2.6.11.orig/arch/um/defconfig	2005-03-04 15:38:37.000000000 -0500
+++ linux-2.6.11/arch/um/defconfig	2005-03-04 15:39:48.000000000 -0500
@@ -1,13 +1,11 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2-mm4
-# Wed Dec  1 13:45:40 2004
+# Linux kernel version: 2.6.11
+# Fri Mar  4 15:38:53 2005
 #
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_USERMODE=y
 CONFIG_MMU=y
-# CONFIG_64_BIT is not set
-CONFIG_TOP_ADDR=0xc0000000
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
@@ -17,17 +15,22 @@
 #
 CONFIG_MODE_TT=y
 CONFIG_MODE_SKAS=y
+# CONFIG_64_BIT is not set
+CONFIG_TOP_ADDR=0xc0000000
 # CONFIG_3_LEVEL_PGTABLES is not set
+CONFIG_ARCH_HAS_SC_SIGNALS=y
+CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA=y
+CONFIG_LD_SCRIPT_STATIC=y
 CONFIG_NET=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=m
 CONFIG_HOSTFS=y
 CONFIG_MCONSOLE=y
+# CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_HOST_2G_2G is not set
 # CONFIG_SMP is not set
 CONFIG_NEST_LEVEL=0
 CONFIG_KERNEL_HALF_GIGS=1
-# CONFIG_HIGHMEM is not set
 CONFIG_KERNEL_STACK_ORDER=2
 CONFIG_UML_REAL_TIME_CLOCK=y
 
@@ -75,7 +78,6 @@
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 CONFIG_OBSOLETE_MODPARM=y
-# CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 
@@ -84,6 +86,7 @@
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
 # CONFIG_DEBUG_DRIVER is not set
 
 #
@@ -97,7 +100,7 @@
 CONFIG_PTY_CHAN=y
 CONFIG_TTY_CHAN=y
 CONFIG_XTERM_CHAN=y
-CONFIG_NOCONFIG_CHAN=y
+# CONFIG_NOCONFIG_CHAN is not set
 CONFIG_CON_ZERO_CHAN="fd:0,fd:1"
 CONFIG_CON_CHAN="xterm"
 CONFIG_SSL_CHAN="pty"
@@ -110,15 +113,18 @@
 CONFIG_HOSTAUDIO=m
 
 #
-# Block Devices
+# Block devices
 #
 CONFIG_BLK_DEV_UBD=y
 CONFIG_BLK_DEV_UBD_SYNC=y
 CONFIG_BLK_DEV_COW_COMMON=y
 CONFIG_BLK_DEV_LOOP=m
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=m
 # CONFIG_BLK_DEV_RAM is not set
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_LBD is not set
 
 #
 # IO Schedulers
@@ -127,6 +133,7 @@
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 CONFIG_NETDEVICES=y
 
 #
@@ -196,10 +203,7 @@
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
-# CONFIG_KGDBOE is not set
 # CONFIG_NETPOLL is not set
-# CONFIG_NETPOLL_RX is not set
-# CONFIG_NETPOLL_TRAP is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
@@ -232,6 +236,11 @@
 # CONFIG_NET_RADIO is not set
 
 #
+# PCMCIA network device support
+#
+# CONFIG_NET_PCMCIA is not set
+
+#
 # Wan interfaces
 #
 # CONFIG_WAN is not set
@@ -259,12 +268,15 @@
 # CONFIG_EXT3_FS_XATTR is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
-# CONFIG_REISER4_FS is not set
 CONFIG_REISERFS_FS=y
 # CONFIG_REISERFS_CHECK is not set
 # CONFIG_REISERFS_PROC_INFO is not set
 # CONFIG_REISERFS_FS_XATTR is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -277,11 +289,6 @@
 CONFIG_AUTOFS4_FS=m
 
 #
-# Caches
-#
-# CONFIG_FSCACHE is not set
-
-#
 # CD-ROM/DVD Filesystems
 #
 CONFIG_ISO9660_FS=m
@@ -331,7 +338,6 @@
 #
 # CONFIG_NFS_FS is not set
 # CONFIG_NFSD is not set
-# CONFIG_EXPORTFS is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
@@ -400,10 +406,14 @@
 # CONFIG_CRYPTO is not set
 
 #
+# Hardware crypto devices
+#
+
+#
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
-# CONFIG_CRC32 is not set
+CONFIG_CRC32=m
 # CONFIG_LIBCRC32C is not set
 
 #
@@ -416,13 +426,13 @@
 # Kernel hacking
 #
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_FS is not set
 CONFIG_FRAME_POINTER=y
 CONFIG_PT_PROXY=y
 # CONFIG_GPROF is not set



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
