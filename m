Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJWb7-00BtIQ-19
 for linux-um@lists.infradead.org; Fri, 27 Aug 2021 07:48:25 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH net-next] um: vector: adjust to coalesce API changes
Date: Fri, 27 Aug 2021 09:48:04 +0200
Message-Id: <20210827094759.f3ab06684bd0.I985181cc00fe017cfe6413d9e1bb720cbe852e6d@changeid>
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
To: netdev@vger.kernel.org
Cc: linux-um@lists.infradead.org, Yufeng Mo <moyufeng@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>, Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

The API changes were propagated to most drivers, but clearly
arch/um/drivers/ was missed, perhaps due to looking only at
the drivers/ folder. Fix that.

Fixes: f3ccfda19319 ("ethtool: extend coalesce setting uAPI with CQE mode")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/vector_kern.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index d27a2a9faf3e..cde6db184c26 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1488,7 +1488,9 @@ static void vector_get_ethtool_stats(struct net_device *dev,
 }
 
 static int vector_get_coalesce(struct net_device *netdev,
-					struct ethtool_coalesce *ec)
+			       struct ethtool_coalesce *ec,
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack)
 {
 	struct vector_private *vp = netdev_priv(netdev);
 
@@ -1497,7 +1499,9 @@ static int vector_get_coalesce(struct net_device *netdev,
 }
 
 static int vector_set_coalesce(struct net_device *netdev,
-					struct ethtool_coalesce *ec)
+			       struct ethtool_coalesce *ec,
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack)
 {
 	struct vector_private *vp = netdev_priv(netdev);
 
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

