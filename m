Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu81R-0000AG-T9
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:12:57 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu81R-0000PN-6Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:12:57 +0000
Date: Thu, 18 Aug 2011 20:12:50 +0100
MIME-Version: 1.0
Message-Id: <E1Qu81K-00085s-2q@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Subject: [PATCH 83/91] um: a couple of missing
	dependencies...
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/wireless/ath/Kconfig     |    2 +-
 drivers/net/wireless/rtlwifi/Kconfig |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/Kconfig b/drivers/net/wireless/ath/Kconfig
index d1b2306..47d0de8 100644
--- a/drivers/net/wireless/ath/Kconfig
+++ b/drivers/net/wireless/ath/Kconfig
@@ -1,6 +1,6 @@
 menuconfig ATH_COMMON
 	tristate "Atheros Wireless Cards"
-	depends on CFG80211
+	depends on CFG80211 && (!UML || BROKEN)
 	---help---
 	  This will enable the support for the Atheros wireless drivers.
 	  ath5k, ath9k, ath9k_htc and ar9170 drivers share some common code, this option
diff --git a/drivers/net/wireless/rtlwifi/Kconfig b/drivers/net/wireless/rtlwifi/Kconfig
index 45e1476..d6c42e6 100644
--- a/drivers/net/wireless/rtlwifi/Kconfig
+++ b/drivers/net/wireless/rtlwifi/Kconfig
@@ -12,7 +12,7 @@ config RTL8192CE
 
 config RTL8192SE
 	tristate "Realtek RTL8192SE/RTL8191SE PCIe Wireless Network Adapter"
-	depends on MAC80211 && EXPERIMENTAL
+	depends on MAC80211 && EXPERIMENTAL && PCI
 	select FW_LOADER
 	select RTLWIFI
 	---help---
@@ -23,7 +23,7 @@ config RTL8192SE
 
 config RTL8192DE
 	tristate "Realtek RTL8192DE/RTL8188DE PCIe Wireless Network Adapter"
-	depends on MAC80211 && EXPERIMENTAL
+	depends on MAC80211 && EXPERIMENTAL && PCI
 	select FW_LOADER
 	select RTLWIFI
 	---help---
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

