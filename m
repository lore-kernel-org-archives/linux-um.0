Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QbK5q-0002Xk-T4
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Jun 2011 22:15:46 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QbK5p-0003XI-KK
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Jun 2011 22:15:46 +0000
From: Richard Weinberger <richard@nod.at>
Date: Tue, 28 Jun 2011 00:15:29 +0200
Message-Id: <1309212931-19772-2-git-send-email-richard@nod.at>
In-Reply-To: <1309212931-19772-1-git-send-email-richard@nod.at>
References: <1309212931-19772-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 2/4] um: Add netpoll support
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

To make netconsole usable on UML, it's ethernet driver
needs netpoll support.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/net_kern.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 47d0c37..22745b4 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -262,6 +262,15 @@ static int uml_net_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void uml_net_poll_controller(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	uml_net_interrupt(dev->irq, dev);
+	enable_irq(dev->irq);
+}
+#endif
+
 static void uml_net_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
 {
@@ -364,6 +373,9 @@ static const struct net_device_ops uml_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_change_mtu 	= uml_net_change_mtu,
 	.ndo_validate_addr	= eth_validate_addr,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller = uml_net_poll_controller,
+#endif
 };
 
 /*
-- 
1.7.5.4


------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

