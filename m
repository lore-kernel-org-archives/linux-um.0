Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FON9K-0005aW-3x for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:58:54 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FON9I-0001a0-Ub
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:58:54 -0800
Message-Id: <200603282300.k2SN0C7n022987@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/10] Sanitize net Kconfigs
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
Date: Tue, 28 Mar 2006 18:00:12 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk

From: Al Viro <viro@zeniv.linux.org.uk>
uml: kconfig sanitized around drivers/net
 
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

 arch/um/Kconfig               |    3 +++
 drivers/net/Kconfig           |    2 --
 drivers/net/tokenring/Kconfig |    2 +-
 drivers/net/wireless/Kconfig  |    2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6.16-mm/arch/um/Kconfig
===================================================================
--- linux-2.6.16-mm.orig/arch/um/Kconfig	2006-03-23 16:40:20.000000000 -0500
+++ linux-2.6.16-mm/arch/um/Kconfig	2006-03-28 09:34:46.000000000 -0500
@@ -22,6 +22,9 @@ config SBUS
 config PCI
 	bool
 
+config PCMCIA
+	bool
+
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
Index: linux-2.6.16-mm/drivers/net/Kconfig
===================================================================
--- linux-2.6.16-mm.orig/drivers/net/Kconfig	2006-03-28 09:30:43.000000000 -0500
+++ linux-2.6.16-mm/drivers/net/Kconfig	2006-03-28 09:34:46.000000000 -0500
@@ -2313,13 +2313,11 @@ config S2IO_NAPI
 
 endmenu
 
-if !UML
 source "drivers/net/tokenring/Kconfig"
 
 source "drivers/net/wireless/Kconfig"
 
 source "drivers/net/pcmcia/Kconfig"
-endif
 
 source "drivers/net/wan/Kconfig"
 
Index: linux-2.6.16-mm/drivers/net/tokenring/Kconfig
===================================================================
--- linux-2.6.16-mm.orig/drivers/net/tokenring/Kconfig	2006-03-28 09:30:43.000000000 -0500
+++ linux-2.6.16-mm/drivers/net/tokenring/Kconfig	2006-03-28 09:34:46.000000000 -0500
@@ -3,7 +3,7 @@
 #
 
 menu "Token Ring devices"
-	depends on NETDEVICES
+	depends on NETDEVICES && !UML
 
 # So far, we only have PCI, ISA, and MCA token ring devices
 config TR
Index: linux-2.6.16-mm/drivers/net/wireless/Kconfig
===================================================================
--- linux-2.6.16-mm.orig/drivers/net/wireless/Kconfig	2006-03-28 09:30:44.000000000 -0500
+++ linux-2.6.16-mm/drivers/net/wireless/Kconfig	2006-03-28 09:34:46.000000000 -0500
@@ -359,7 +359,7 @@ config PCI_HERMES
 
 config ATMEL
       tristate "Atmel at76c50x chipset  802.11b support"
-      depends on NET_RADIO
+      depends on NET_RADIO && (PCI || PCMCIA)
       select FW_LOADER
       select CRC32
        ---help---



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
