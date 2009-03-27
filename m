Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shemminger@suva.vyatta.com>) id 1Ln0mN-0003mT-9c
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Mar 2009 01:22:39 +0000
Received: from suva.vyatta.com ([76.74.103.44])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ln0mJ-0005YX-SM
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Mar 2009 01:22:39 +0000
Message-Id: <20090327011255.168951778@linux-foundation.org>
Date: Thu, 26 Mar 2009 18:11:17 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
References: <20090327011114.169107105@linux-foundation.org>
Content-Disposition: inline; filename=uml-netdev.patch
Subject: [uml-devel] [patch 03/30] uml: convert network device to netdevice
	ops
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
To: David Miller <davem@davemloft.net>, jdike@addtoit.com
Cc: netdev@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>


--- a/arch/um/drivers/net_kern.c	2009-03-22 21:11:51.000000000 -0700
+++ b/arch/um/drivers/net_kern.c	2009-03-22 21:17:17.920674346 -0700
@@ -371,6 +371,18 @@ static void net_device_release(struct de
 	free_netdev(netdev);
 }
 
+static const struct net_device_ops uml_netdev_ops = {
+	.ndo_open 		= uml_net_open,
+	.ndo_stop 		= uml_net_close,
+	.ndo_start_xmit 	= uml_net_start_xmit,
+	.ndo_set_multicast_list = uml_net_set_multicast_list,
+	.ndo_tx_timeout 	= uml_net_tx_timeout,
+	.ndo_set_mac_address	= uml_net_set_mac,
+	.ndo_change_mtu 	= uml_net_change_mtu,
+	.ndo_set_mac_address 	= eth_mac_addr,
+	.ndo_validate_addr	= eth_validate_addr,
+};
+
 /*
  * Ensures that platform_driver_register is called only once by
  * eth_configure.  Will be set in an initcall.
@@ -467,13 +479,7 @@ static void eth_configure(int n, void *i
 
 	set_ether_mac(dev, device->mac);
 	dev->mtu = transport->user->mtu;
-	dev->open = uml_net_open;
-	dev->hard_start_xmit = uml_net_start_xmit;
-	dev->stop = uml_net_close;
-	dev->set_multicast_list = uml_net_set_multicast_list;
-	dev->tx_timeout = uml_net_tx_timeout;
-	dev->set_mac_address = uml_net_set_mac;
-	dev->change_mtu = uml_net_change_mtu;
+	dev->netdev_ops = &uml_netdev_ops;
 	dev->ethtool_ops = &uml_net_ethtool_ops;
 	dev->watchdog_timeo = (HZ >> 1);
 	dev->irq = UM_ETH_IRQ;



------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

