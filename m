Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWa7z-0005Jn-TE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 08:32:00 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HWa7x-0001Dp-3l
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 08:31:59 -0700
Date: Wed, 28 Mar 2007 11:28:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070328152847.GA6335@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/4] UML - improve checking and diagnostics of
	ethernet MACs
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Blaisorblade <blaisorblade@yahoo.it>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Improve checking and diagnostics for broadcast and multicast Ethernet MAC
addresses, and distinguish between those cases in output; also make sure the   
device is assigned a MAC address valid only locally to avoid collisions.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/net_kern.c  |   38 +++++++++++++++++++++++++++++---------
 include/linux/etherdevice.h |   12 ++++++++++++
 2 files changed, 41 insertions(+), 9 deletions(-)

Index: linux-2.6.21-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/net_kern.c	2007-03-21 13:43:12.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/net_kern.c	2007-03-21 13:43:42.000000000 -0400
@@ -283,7 +283,7 @@ void uml_net_user_timer_expire(unsigned 
 #endif
 }
 
-static void setup_etheraddr(char *str, unsigned char *addr)
+static void setup_etheraddr(char *str, unsigned char *addr, char *name)
 {
 	char *end;
 	int i;
@@ -302,15 +302,32 @@ static void setup_etheraddr(char *str, u
 		}
 		str = end + 1;
 	}
-	if(addr[0] & 1){
+	if (is_multicast_ether_addr(addr)) {
 		printk(KERN_ERR
-		       "Attempt to assign a broadcast ethernet address to a "
+		       "Attempt to assign a multicast ethernet address to a "
 		       "device disallowed\n");
 		goto random;
 	}
+	if (!is_valid_ether_addr(addr)) {
+		printk(KERN_ERR
+		       "Attempt to assign an invalid ethernet address to a "
+		       "device disallowed\n");
+		goto random;
+	}
+	if (!is_local_ether_addr(addr)) {
+		printk(KERN_WARNING
+		       "Warning: attempt to assign a globally valid ethernet address to a "
+		       "device\n");
+		printk(KERN_WARNING "You should better enable the 2nd rightmost bit "
+		      "in the first byte of the MAC, i.e. "
+		      "%02x:%02x:%02x:%02x:%02x:%02x\n",
+		      addr[0] | 0x02, addr[1], addr[2], addr[3], addr[4], addr[5]);
+	}
 	return;
 
 random:
+	printk(KERN_INFO
+	       "Choosing a random ethernet address for device %s\n", name);
 	random_ether_addr(addr);
 }
 
@@ -331,6 +348,7 @@ static void eth_configure(int n, void *i
 	struct net_device *dev;
 	struct uml_net_private *lp;
 	int save, err, size;
+	char name[sizeof(dev->name)];
 
 	size = transport->private_size + sizeof(struct uml_net_private) +
 		sizeof(((struct uml_net_private *) 0)->user);
@@ -344,7 +362,13 @@ static void eth_configure(int n, void *i
 	INIT_LIST_HEAD(&device->list);
 	device->index = n;
 
-	setup_etheraddr(mac, device->mac);
+	/* If this name ends up conflicting with an existing registered
+	 * netdevice, that is OK, register_netdev{,ice}() will notice this
+	 * and fail.
+	 */
+	snprintf(name, sizeof(name), "eth%d", n);
+
+	setup_etheraddr(mac, device->mac, name);
 
 	printk(KERN_INFO "Netdevice %d ", n);
 	printk("(%02x:%02x:%02x:%02x:%02x:%02x) ",
@@ -375,11 +399,7 @@ static void eth_configure(int n, void *i
 		goto out_free_netdev;
 	SET_NETDEV_DEV(dev,&device->pdev.dev);
 
-	/* If this name ends up conflicting with an existing registered
-	 * netdevice, that is OK, register_netdev{,ice}() will notice this
-	 * and fail.
-	 */
-	snprintf(dev->name, sizeof(dev->name), "eth%d", n);
+	strcpy(dev->name, name);
 	device->dev = dev;
 
 	/*
Index: linux-2.6.21-mm/include/linux/etherdevice.h
===================================================================
--- linux-2.6.21-mm.orig/include/linux/etherdevice.h	2007-03-20 15:41:35.000000000 -0400
+++ linux-2.6.21-mm/include/linux/etherdevice.h	2007-03-21 13:43:42.000000000 -0400
@@ -71,6 +71,18 @@ static inline int is_multicast_ether_add
 }
 
 /**
+ * is_local_ether_addr - Determine if the Ethernet address is locally-assigned
+ * one (IEEE 802).
+ * @addr: Pointer to a six-byte array containing the Ethernet address
+ *
+ * Return true if the address is a local address.
+ */
+static inline int is_local_ether_addr(const u8 *addr)
+{
+	return (0x02 & addr[0]);
+}
+
+/**
  * is_broadcast_ether_addr - Determine if the Ethernet address is broadcast
  * @addr: Pointer to a six-byte array containing the Ethernet address
  *

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
