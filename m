Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Paul.Chavent@onera.fr>) id 1TgdNe-00063E-An
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2012 15:28:54 +0000
Received: from briaree.onecert.fr ([134.212.190.4])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TgdNa-0000C2-Pd for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2012 15:28:54 +0000
From: Paul Chavent <Paul.Chavent@onera.fr>
Date: Thu,  6 Dec 2012 16:25:05 +0100
Message-Id: <1354807505-21222-1-git-send-email-paul.chavent@onera.fr>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] net : enable tx time stamping in the vde driver.
To: jdike@addtoit.com, richard@nod.at, user-mode-linux-devel@lists.sourceforge.net, netdev@vger.kernel.org, richardcochran@gmail.com
Cc: Paul Chavent <Paul.Chavent@onera.fr>

This new version moves the skb_tx_timestamp in the main uml
driver. This should avoid the need to call this function in each
transport (vde, slirp, tuntap, ...). It also add support for ethtool
get_ts_info.

Signed-off-by: Paul Chavent <paul.chavent@onera.fr>
---
 arch/um/drivers/net_kern.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index b1314eb..5aa8696 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -218,6 +218,7 @@ static int uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	spin_lock_irqsave(&lp->lock, flags);
 
 	len = (*lp->write)(lp->fd, skb, lp);
+	skb_tx_timestampns(skb);
 
 	if (len == skb->len) {
 		dev->stats.tx_packets++;
@@ -281,6 +282,7 @@ static void uml_net_get_drvinfo(struct net_device *dev,
 static const struct ethtool_ops uml_net_ethtool_ops = {
 	.get_drvinfo	= uml_net_get_drvinfo,
 	.get_link	= ethtool_op_get_link,
+	.get_ts_info	= ethtool_op_get_ts_info,
 };
 
 static void uml_net_user_timer_expire(unsigned long _conn)
-- 
1.7.12.1


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

