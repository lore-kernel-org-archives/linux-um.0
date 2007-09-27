Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IawkB-0005Zp-Pg for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Sep 2007 10:01:43 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Iawk9-0006id-0e
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Sep 2007 10:01:43 -0700
Date: Thu, 27 Sep 2007 13:01:26 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070927170126.GA6542@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML - Correctly handle skb allocation failures
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Handle memory allocation failures when reading packets.

We have to read something from the host, even if we can't allocate any
memory.  If we don't, the host side of the device may fill up and stop
delivering interrupts because no new packets can be queued.

A single sk_buff is allocated whenever an MTU is seen which is larger
than any seen earlier.  This is used to read packets if there is a
memory allocation failure.

The large MTU check is done from eth_configure, which is called when a
interface is added to the system.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/net_kern.c |   46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

Index: linux-2.6.20/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.20.orig/arch/um/drivers/net_kern.c	2007-09-27 12:04:34.000000000 -0400
+++ linux-2.6.20/arch/um/drivers/net_kern.c	2007-09-27 12:57:42.000000000 -0400
@@ -34,6 +34,45 @@ static inline void set_ether_mac(struct 
 static DEFINE_SPINLOCK(opened_lock);
 static LIST_HEAD(opened);
 
+/*
+ * The drop_skb is used when we can't allocate an skb.  The
+ * packet is read into drop_skb in order to get the data off the
+ * connection to the host.
+ * It is reallocated whenever a maximum packet size is seen which is
+ * larger than any seen before.  update_drop_skb is called from
+ * eth_configure when a new interface is added.
+ */
+static DEFINE_SPINLOCK(drop_lock);
+static struct sk_buff *drop_skb;
+static int drop_max;
+
+static int update_drop_skb(int max)
+{
+	struct sk_buff *new;
+	int err = 0;
+
+	spin_lock(&drop_lock);
+
+	if (max <= drop_max)
+		goto out;
+
+	err = -ENOMEM;
+	new = dev_alloc_skb(max);
+	if (new == NULL)
+		goto out;
+
+	skb_put(new, max);
+
+	kfree_skb(drop_skb);
+	drop_skb = new;
+	drop_max = max;
+	err = 0;
+out:
+	spin_unlock(&drop_lock);
+
+	return err;
+}
+
 static int uml_net_rx(struct net_device *dev)
 {
 	struct uml_net_private *lp = dev->priv;
@@ -43,6 +82,9 @@ static int uml_net_rx(struct net_device 
 	/* If we can't allocate memory, try again next round. */
 	skb = dev_alloc_skb(lp->max_packet);
 	if (skb == NULL) {
+		drop_skb->dev = dev;
+		/* Read a packet into drop_skb and don't do anything with it. */
+		(*lp->read)(lp->fd, drop_skb, lp);
 		lp->stats.rx_dropped++;
 		return 0;
 	}
@@ -447,6 +489,10 @@ static void eth_configure(int n, void *i
 	dev->watchdog_timeo = (HZ >> 1);
 	dev->irq = UM_ETH_IRQ;
 
+	err = update_drop_skb(lp->max_packet);
+	if (err)
+		goto out_undo_user_init;
+
 	rtnl_lock();
 	err = register_netdevice(dev);
 	rtnl_unlock();

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
