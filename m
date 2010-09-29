Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bharrosh@panasas.com>) id 1P0s7Z-00032z-Ns
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Sep 2010 08:34:37 +0000
Received: from daytona.panasas.com ([67.152.220.89]
	helo=daytona.int.panasas.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P0s7Y-0001me-Os for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Sep 2010 08:34:37 +0000
Message-ID: <4CA2FA13.8050405@panasas.com>
Date: Wed, 29 Sep 2010 10:34:27 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <4CA09977.80506@panasas.com>
	<AANLkTim85sH_2o=xCiDuoQrHq_7ZL96Y91xQMGxUP5Fy@mail.gmail.com>
	<20100928134721.f79a5955.akpm@linux-foundation.org>
	<AANLkTi=E7+CpJZE3XC7O1LvJu6LWfmvSxonskH4CYg25@mail.gmail.com>
In-Reply-To: <AANLkTi=E7+CpJZE3XC7O1LvJu6LWfmvSxonskH4CYg25@mail.gmail.com>
Subject: [uml-devel] [PATCH] um: Proper Fix for f25c80a4: remove duplicate
 structure field initialization
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
To: Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, Julia Lawall <julia@diku.dk>, Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Stephen Hemminger <shemminger@vyatta.com>


uml_net_set_mac() was broken and luckily it was never used, before.
What it was trying to do is spin_lock before memcopy the mac address.
Linus attempted to fix it in assumption that someone decided the
lock was needed. But since it was never ever used at all, and was
just dead code, I think we can assume that it is not needed, after
all.

On the other hand patch [f25c80a4] was trying to use eth_mac_addr()
in eth_configure(), *which was the real fallout*. Because of state
checks done inside eth_mac_addr() the address was never set. I have
not reintroduced the memcpy wrapper, but I've put a comment for future
cats.

The code now is back to exactly as it was before [f25c80a4]. With
the cleanup applied. If the spin_lock is indeed needed then a contender
should supply a test case that fails, then fix it with the proper
locking, as a separate unrelated patch.

CC: Julia Lawall <julia@diku.dk>
CC: David S. Miller <davem@davemloft.net>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Al Viro <viro@ZenIV.linux.org.uk>
Tested-by: Boaz Harrosh <bharrosh@panasas.com>
Signed-off-by: Boaz Harrosh <bharrosh@panasas.com>
---
 arch/um/drivers/net_kern.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 2ab233b..47d0c37 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -255,18 +255,6 @@ static void uml_net_tx_timeout(struct net_device *dev)
 	netif_wake_queue(dev);
 }
 
-static int uml_net_set_mac(struct net_device *dev, void *addr)
-{
-	struct uml_net_private *lp = netdev_priv(dev);
-	struct sockaddr *hwaddr = addr;
-
-	spin_lock_irq(&lp->lock);
-	eth_mac_addr(dev, hwaddr->sa_data);
-	spin_unlock_irq(&lp->lock);
-
-	return 0;
-}
-
 static int uml_net_change_mtu(struct net_device *dev, int new_mtu)
 {
 	dev->mtu = new_mtu;
@@ -373,7 +361,7 @@ static const struct net_device_ops uml_netdev_ops = {
 	.ndo_start_xmit 	= uml_net_start_xmit,
 	.ndo_set_multicast_list = uml_net_set_multicast_list,
 	.ndo_tx_timeout 	= uml_net_tx_timeout,
-	.ndo_set_mac_address	= uml_net_set_mac,
+	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_change_mtu 	= uml_net_change_mtu,
 	.ndo_validate_addr	= eth_validate_addr,
 };
@@ -472,7 +460,8 @@ static void eth_configure(int n, void *init, char *mac,
 	    ((*transport->user->init)(&lp->user, dev) != 0))
 		goto out_unregister;
 
-	eth_mac_addr(dev, device->mac);
+	/* don't use eth_mac_addr, it will not work here */
+	memcpy(dev->dev_addr, device->mac, ETH_ALEN);
 	dev->mtu = transport->user->mtu;
 	dev->netdev_ops = &uml_netdev_ops;
 	dev->ethtool_ops = &uml_net_ethtool_ops;
-- 
1.7.2.3



------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

