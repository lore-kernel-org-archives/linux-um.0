Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jA1Ry-0008Mp-2S
 for linux-um@lists.infradead.org; Fri, 06 Mar 2020 01:06:52 +0000
From: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/7] RDMA/ipoib: reject unsupported coalescing params
Date: Thu,  5 Mar 2020 17:05:57 -0800
Message-Id: <20200306010602.1620354-3-kuba@kernel.org>
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

This driver did not previously reject unsupported parameters.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
index 63e4f9d15fd9..a10a0c2ca2da 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
@@ -213,6 +213,8 @@ static int ipoib_get_link_ksettings(struct net_device *netdev,
 }
 
 static const struct ethtool_ops ipoib_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
+				     ETHTOOL_COALESCE_RX_MAX_FRAMES,
 	.get_link_ksettings	= ipoib_get_link_ksettings,
 	.get_drvinfo		= ipoib_get_drvinfo,
 	.get_coalesce		= ipoib_get_coalesce,
-- 
2.24.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

