Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
Date: Mon, 27 Jan 2020 15:53:52 -0800
In-Reply-To: <20200127235356.122031-1-brendanhiggins@google.com>
Message-Id: <20200127235356.122031-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200127235356.122031-1-brendanhiggins@google.com>
Subject: [PATCH v1 1/5] net: axienet: add unspecified HAS_IOMEM dependency
From: Brendan Higgins <brendanhiggins@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, "David S . Miller" <davem@davemloft.net>, Michal Simek <michal.simek@xilinx.com>, Andrew Lunn <andrew@lunn.ch>, Robert Hancock <hancock@sedsystems.ca>, Esben Haabendal <esben@geanix.com>, Thomas Gleixner <tglx@linutronix.de>, Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc: heidifahim@google.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, davidgow@google.com, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

Currently CONFIG_XILINX_AXI_EMAC=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

/usr/bin/ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.o: in function `axienet_probe':
drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1680: undefined reference to `devm_ioremap_resource'
/usr/bin/ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1779: undefined reference to `devm_ioremap_resource'
/usr/bin/ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1789: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/net/ethernet/xilinx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 6304ebd8b5c69..b1a285e693756 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -25,6 +25,7 @@ config XILINX_EMACLITE
 
 config XILINX_AXI_EMAC
 	tristate "Xilinx 10/100/1000 AXI Ethernet support"
+	depends on HAS_IOMEM
 	select PHYLINK
 	---help---
 	  This driver supports the 10/100/1000 Ethernet from Xilinx for the
-- 
2.25.0.341.g760bfbb309-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

