Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcU1-00017y-Ld for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:09 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcU0-00014p-Ou
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:09 -0800
Date: Thu, 17 Jan 2008 16:40:50 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214050.GA6787@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 20/20] UML - defconfig tweaks
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
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

Tweak the UML defconfig -
      we probably don't need 256 old-style ptys - this slows down udev
noticably
      enable hostfs
      disable slab debugging - another noticable performance hit

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/defconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.22/arch/um/defconfig
===================================================================
--- linux-2.6.22.orig/arch/um/defconfig	2008-01-17 14:39:06.000000000 -0500
+++ linux-2.6.22/arch/um/defconfig	2008-01-17 14:40:07.000000000 -0500
@@ -75,7 +75,7 @@ CONFIG_LD_SCRIPT_DYN=y
 CONFIG_NET=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=m
-# CONFIG_HOSTFS is not set
+CONFIG_HOSTFS=y
 # CONFIG_HPPFS is not set
 CONFIG_MCONSOLE=y
 CONFIG_MAGIC_SYSRQ=y
@@ -185,7 +185,7 @@ CONFIG_CON_CHAN="xterm"
 CONFIG_SSL_CHAN="pts"
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
-CONFIG_LEGACY_PTY_COUNT=256
+CONFIG_LEGACY_PTY_COUNT=32
 # CONFIG_WATCHDOG is not set
 CONFIG_UML_SOUND=m
 CONFIG_SOUND=m
@@ -505,7 +505,7 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
-CONFIG_DEBUG_SLAB=y
+# CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SLAB_LEAK is not set
 # CONFIG_DEBUG_MUTEXES is not set
 # CONFIG_DEBUG_SPINLOCK is not set

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
