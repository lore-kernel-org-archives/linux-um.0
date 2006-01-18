Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez1As-0007Kd-He for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:42 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ez1Ar-0000v9-Vk
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 16:27:42 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060118001942.14622.99879.stgit@zion.home.lan>
In-Reply-To: <20060117235659.14622.18544.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 7/9] uml: arch Kconfig menu cleanups
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
Date: Wed, 18 Jan 2006 01:19:43 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


*) mark as "EXPERIMENTAL" various items that either aren't very stable or that
are actively crashing the setup of users which don't really need them (i.e.
HIGHMEM and 3-level pagetables on x86 - nobody needs either, everybody reports
"I'm using it and getting trouble").

*) move net/Kconfig near to the rest of network configurations, and
drivers/block/Kconfig near "Block layer" submenu.

*) it's useless and doesn't work well to force NETDEVICES on and to disable the
prompt like it's done. Better remove the attempt, and change that to a simple
"default y if UML".

*) drop the warning about "report problems about HPPFS" - it's redundant
anyway, as that's the usual procedure, and HPPFS users are especially technical
(i.e. they know reporting bugs is _good_).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig      |   27 ++++++++++++++-------------
 arch/um/Kconfig.i386 |    6 +++++-
 drivers/net/Kconfig  |    1 +
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 8ff3bcb..5982fe2 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -143,6 +143,7 @@ config HOSTFS
 
 config HPPFS
 	tristate "HoneyPot ProcFS (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	hppfs (HoneyPot ProcFS) is a filesystem which allows UML /proc
 	entries to be overridden, removed, or fabricated from the host.
@@ -155,10 +156,6 @@ config HPPFS
 	You only need this if you are setting up a UML honeypot.  Otherwise,
 	it is safe to say 'N' here.
 
-	If you are actively using it, please report any problems, since it's
-	getting fixed. In this moment, it is experimental on 2.6 (it works on
-	2.4).
-
 config MCONSOLE
 	bool "Management console"
 	default y
@@ -243,8 +240,16 @@ config NEST_LEVEL
         Only change this if you are running nested UMLs.
 
 config HIGHMEM
-	bool "Highmem support"
-	depends on !64BIT
+	bool "Highmem support (EXPERIMENTAL)"
+	depends on !64BIT && EXPERIMENTAL
+	default n
+	help
+	This was used to allow UML to run with big amounts of memory.
+	Currently it is unstable, so if unsure say N.
+
+	To use big amounts of memory, it is recommended to disable TT mode (i.e.
+	CONFIG_MODE_TT) and enable static linking (i.e. CONFIG_STATIC_LINK) -
+	this should allow the guest to use up to 2.75G of memory.
 
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
@@ -269,17 +274,13 @@ endmenu
 
 source "init/Kconfig"
 
-source "net/Kconfig"
-
-source "drivers/base/Kconfig"
+source "drivers/block/Kconfig"
 
 source "arch/um/Kconfig.char"
 
-source "drivers/block/Kconfig"
+source "drivers/base/Kconfig"
 
-config NETDEVICES
-	bool
-	default NET
+source "net/Kconfig"
 
 source "arch/um/Kconfig.net"
 
diff --git a/arch/um/Kconfig.i386 b/arch/um/Kconfig.i386
index c71b39a..ef79ed2 100644
--- a/arch/um/Kconfig.i386
+++ b/arch/um/Kconfig.i386
@@ -22,13 +22,17 @@ config TOP_ADDR
  	default 0x80000000 if HOST_2G_2G
 
 config 3_LEVEL_PGTABLES
-	bool "Three-level pagetables"
+	bool "Three-level pagetables (EXPERIMENTAL)"
 	default n
+	depends on EXPERIMENTAL
 	help
 	Three-level pagetables will let UML have more than 4G of physical
 	memory.  All the memory that can't be mapped directly will be treated
 	as high memory.
 
+	However, this it experimental on 32-bit architectures, so if unsure say
+	N (on x86-64 it's automatically enabled, instead, as it's safe there).
+
 config STUB_CODE
 	hex
 	default 0xbfffe000
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1421941..c0f9351 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -7,6 +7,7 @@ menu "Network device support"
 
 config NETDEVICES
 	depends on NET
+	default y if UML
 	bool "Network device support"
 	---help---
 	  You can say N here if you don't intend to connect your Linux box to



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
