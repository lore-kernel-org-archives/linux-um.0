Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 13/22] net: Fix dependencies for !HAS_IOMEM archs
Date: Mon, 25 Jan 2016 23:24:12 +0100
Message-Id: <1453760661-1444-14-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Florian Fainelli <f.fainelli@gmail.com>, Tal Zilcer <talz@ezchip.com>, "David S. Miller" <davem@davemloft.net>, Alexey Brodkin <abrodkin@synopsys.com>, Noam Camus <noamc@ezchip.com>, netdev@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Not every arch has io memory.
So, unbreak the build by fixing the dependencies.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/net/ethernet/ezchip/Kconfig | 1 +
 drivers/net/phy/Kconfig             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ezchip/Kconfig b/drivers/net/ethernet/ezchip/Kconfig
index 48ecbc8..b423ad3 100644
--- a/drivers/net/ethernet/ezchip/Kconfig
+++ b/drivers/net/ethernet/ezchip/Kconfig
@@ -18,6 +18,7 @@ if NET_VENDOR_EZCHIP
 config EZCHIP_NPS_MANAGEMENT_ENET
 	tristate "EZchip NPS management enet support"
 	depends on OF_IRQ && OF_NET
+	depends on HAS_IOMEM
 	---help---
 	  Simple LAN device for debug or management purposes.
 	  Device supports interrupts for RX and TX(completion).
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 60994a8..f0a7702 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -186,6 +186,7 @@ config MDIO_GPIO
 config MDIO_OCTEON
 	tristate "Support for MDIO buses on Octeon and ThunderX SOCs"
 	depends on 64BIT
+	depends on HAS_IOMEM
 	help
 
 	  This module provides a driver for the Octeon and ThunderX MDIO
-- 
1.8.4.5


