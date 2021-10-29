Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgHvG-009b6H-F8
 for linux-um@lists.infradead.org; Fri, 29 Oct 2021 02:47:15 +0000
From: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] net: um: use eth_hw_addr_set()
Date: Thu, 28 Oct 2021 19:47:06 -0700
Message-Id: <20211029024707.316066-3-kuba@kernel.org>
In-Reply-To: <20211029024707.316066-1-kuba@kernel.org>
References: <20211029024707.316066-1-kuba@kernel.org>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes.berg@intel.com, linux-um@lists.infradead.org

Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
of VLANs...") introduced a rbtree for faster Ethernet address look
up. To maintain netdev->dev_addr in this tree we need to make all
the writes to it go through appropriate helpers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jdike@addtoit.com
CC: richard@nod.at
CC: anton.ivanov@cambridgegreys.com
CC: johannes.berg@intel.com
CC: linux-um@lists.infradead.org
---
 arch/um/drivers/net_kern.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 2fc0b038ff8a..59331384c2d3 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -276,7 +276,7 @@ static const struct ethtool_ops uml_net_ethtool_ops = {
 
 void uml_net_setup_etheraddr(struct net_device *dev, char *str)
 {
-	unsigned char *addr = dev->dev_addr;
+	u8 addr[ETH_ALEN];
 	char *end;
 	int i;
 
@@ -316,6 +316,7 @@ void uml_net_setup_etheraddr(struct net_device *dev, char *str)
 		       addr[0] | 0x02, addr[1], addr[2], addr[3], addr[4],
 		       addr[5]);
 	}
+	eth_hw_addr_set(dev, addr);
 	return;
 
 random:
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

