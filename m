Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jA1S1-0008Ov-Aj
 for linux-um@lists.infradead.org; Fri, 06 Mar 2020 01:06:54 +0000
From: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/7] vmxnet3: let core reject the unsupported
 coalescing parameters
Date: Thu,  5 Mar 2020 17:06:00 -0800
Message-Id: <20200306010602.1620354-6-kuba@kernel.org>
In-Reply-To: <20200306010602.1620354-1-kuba@kernel.org>
References: <20200306010602.1620354-1-kuba@kernel.org>
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
Cc: mkubecek@suse.cz, doshir@vmware.com, pv-drivers@vmware.com, jasowang@redhat.com, edumazet@google.com, anton.ivanov@cambridgegreys.com, merez@codeaurora.org, leon@kernel.org, linux-rdma@vger.kernel.org, richard@nod.at, jgg@ziepe.ca, dledford@redhat.com, Jakub Kicinski <kuba@kernel.org>, hayeswang@realtek.com, jdike@addtoit.com, linux-um@lists.infradead.org, kvalo@codeaurora.org, GR-Linux-NIC-Dev@marvell.com, manishc@marvell.com, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, gregkh@linuxfoundation.org

Set ethtool_ops->supported_coalesce_params to let
the core reject unsupported coalescing parameters.

This driver correctly rejects all unsupported parameters.
As a side effect of these changes the error code for
unsupported params changes from EINVAL to EOPNOTSUPP.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/vmxnet3/vmxnet3_ethtool.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
index 1e4b9ba70983..6528940ce5f3 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
@@ -780,27 +780,6 @@ vmxnet3_set_coalesce(struct net_device *netdev, struct ethtool_coalesce *ec)
 	if (!VMXNET3_VERSION_GE_3(adapter))
 		return -EOPNOTSUPP;
 
-	if (ec->rx_coalesce_usecs_irq ||
-	    ec->rx_max_coalesced_frames_irq ||
-	    ec->tx_coalesce_usecs ||
-	    ec->tx_coalesce_usecs_irq ||
-	    ec->tx_max_coalesced_frames_irq ||
-	    ec->stats_block_coalesce_usecs ||
-	    ec->use_adaptive_tx_coalesce ||
-	    ec->pkt_rate_low ||
-	    ec->rx_coalesce_usecs_low ||
-	    ec->rx_max_coalesced_frames_low ||
-	    ec->tx_coalesce_usecs_low ||
-	    ec->tx_max_coalesced_frames_low ||
-	    ec->pkt_rate_high ||
-	    ec->rx_coalesce_usecs_high ||
-	    ec->rx_max_coalesced_frames_high ||
-	    ec->tx_coalesce_usecs_high ||
-	    ec->tx_max_coalesced_frames_high ||
-	    ec->rate_sample_interval) {
-		return -EINVAL;
-	}
-
 	if ((ec->rx_coalesce_usecs == 0) &&
 	    (ec->use_adaptive_rx_coalesce == 0) &&
 	    (ec->tx_max_coalesced_frames == 0) &&
@@ -891,6 +870,9 @@ vmxnet3_set_coalesce(struct net_device *netdev, struct ethtool_coalesce *ec)
 }
 
 static const struct ethtool_ops vmxnet3_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
+				     ETHTOOL_COALESCE_MAX_FRAMES |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_drvinfo       = vmxnet3_get_drvinfo,
 	.get_regs_len      = vmxnet3_get_regs_len,
 	.get_regs          = vmxnet3_get_regs,
-- 
2.24.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

