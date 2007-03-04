Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HNwAA-0001Pe-NC for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Mar 2007 11:14:30 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HNwA9-0002SR-4J
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Mar 2007 11:14:30 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 4 Mar 2007 20:13:39 +0100
References: <200702220054.04938.blaisorblade@yahoo.it>
	<20070222195956.GA6414@ccure.user-mode-linux.org>
In-Reply-To: <20070222195956.GA6414@ccure.user-mode-linux.org>
MIME-Version: 1.0
Message-Id: <200703042013.39584.blaisorblade@yahoo.it>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jpx6Fewmd087tHF"
Subject: Re: [uml-devel] When opening /tmp/uml.ctl fails, what do we get?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_jpx6Fewmd087tHF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 22 February 2007 20:59, Jeff Dike wrote:
> On Thu, Feb 22, 2007 at 12:54:04AM +0100, Blaisorblade wrote:
> > I started uml_daemon as root by mistake, so /tmp/uml.ctl even if
> > /dev/net/tun was world-readable. Ok, I did it. This is the result (after
> > trying many times to do 'ifconfig eth0 up' inside UML):
>
> I don't see your irq stuff here when I try that, but there were
> multiple problems, which I hope are fixed by the patch below:
> 	style violations - this made the patch much bigger, and needs
> to be split out

Indeed, sigh. However I'm now convinced that if this just causes delays in 
patch merging without review benefit, it's not a good thing. It should be 
easy to split this away, and I have the patch about errno and am going to 
merge it (I hope to give a flush to my patch queue tomorrow).

However you still add new ones:

+       if(platform_device_register(&device->pdev))
+               goto out_free_netdev;

> 	the user init routines now return success or failure

Good.

> 	some major cleaning of the failure paths through eth_configure
> 		device was never freed
> 		sysfs_unregister was never called, adding the same
> interface again successfully would result in nasty error messages
> 		device stuck in the devices list regardless, so adding
> the same interface again would fail
> 		the return from platform_device_register was not
> checked

> 		I moved the register_netdev call until almost the end
> of the function

Have you checked if other calls require that register_netdev was already 
called?

> Let me know what you think about this.
>
> And about your thought of merging the _init into _open, my excuse for
> keeping them separate deserves some scrutiny.  Every transport besides
> the switch does all of its work in _open, and the _init routine just
> initializes data.  So, I would say that if a transport has separate
> plug-it-in and bring-it-up operations, maybe they should be separated
> more than they are now.  If the switch is the odd one, maybe we should
> merge _init into _open.

Hmm, I'm really not sure about what to do about this. However I'd leave that 
for a future cleanup and just add a comment about this.
And the reason for which init now returns a value is that pcap_init _can_ 
fail, so the switch transport is not the only odd one.

Another note:
+       /*
+        * This overallocates by sizeof(int) since the last field in
+        * uml_net_private is used to access the transport-specific
+        * data, so that user field is the first 4 bytes of the
+        * transport data.
+        */
+       size = transport->private_size + sizeof(struct uml_net_private);

There is a simple and standard solution in Linux style:

struct uml_net_private {
-        int user[1];
+        char user[0];
};

With fgrep [0] include/linux/* I found quite a few examples (like in 
include/linux/ethtool.h) - even if it is not fully ISO C conforming it's gcc 
conforming.

A proof-of-concept (i.e. untested and applying on vanilla) patch for this is 
attached, with name remember-zero-array-net.diff.

Another note: before of this patch, you should please apply the attached two 
ones.

*) The first (net-mac-check-cleanup.diff) checks the validity of assigned MAC 
address, but to print a meaningful error message requires adding a local 
buffer.
*) The second (net_kern-eth_configure...) allows avoiding this local buffer by 
moving code around.

I think I'm excessively paranoid about these two patches and about not yet 
merging them, so please give a look and merge them.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_jpx6Fewmd087tHF
Content-Type: text/x-diff; charset="iso-8859-1";
	name="net-mac-check-cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="net-mac-check-cleanup.diff"

Subject: uml: improve unicast MAC checking and enforce use of private MACs

Improve checking and diagnostics for broadcast and multicast Ethernet MAC
addresses, and distinguish between those cases in output; also make sure the
device is assigned a MAC address valid only locally to avoid collisions.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.git.orig/arch/um/drivers/net_kern.c
+++ linux-2.6.git/arch/um/drivers/net_kern.c
@@ -284,7 +284,7 @@ void uml_net_user_timer_expire(unsigned 
 #endif
 }
 
-static void setup_etheraddr(char *str, unsigned char *addr)
+static void setup_etheraddr(char *str, unsigned char *addr, char *name)
 {
 	char *end;
 	int i;
@@ -303,15 +303,32 @@ static void setup_etheraddr(char *str, u
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
 
@@ -332,6 +349,7 @@ static int eth_configure(int n, void *in
 	struct net_device *dev;
 	struct uml_net_private *lp;
 	int save, err, size;
+	char name[sizeof(dev->name)];
 
 	size = transport->private_size + sizeof(struct uml_net_private) +
 		sizeof(((struct uml_net_private *) 0)->user);
@@ -349,7 +367,13 @@ static int eth_configure(int n, void *in
 	list_add(&device->list, &devices);
 	spin_unlock(&devices_lock);
 
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
@@ -379,11 +403,7 @@ static int eth_configure(int n, void *in
 	platform_device_register(&device->pdev);
 	SET_NETDEV_DEV(dev,&device->pdev.dev);
 
-	/* If this name ends up conflicting with an existing registered
-	 * netdevice, that is OK, register_netdev{,ice}() will notice this
-	 * and fail.
-	 */
-	snprintf(dev->name, sizeof(dev->name), "eth%d", n);
+	strcpy(dev->name, name);
 	device->dev = dev;
 
 	(*transport->kern->init)(dev, init);
Index: linux-2.6.git/include/linux/etherdevice.h
===================================================================
--- linux-2.6.git.orig/include/linux/etherdevice.h
+++ linux-2.6.git/include/linux/etherdevice.h
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

--Boundary-00=_jpx6Fewmd087tHF
Content-Type: text/x-diff; charset="iso-8859-1";
	name="net_kern-eth_configure-avoid-tmp-buf.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="net_kern-eth_configure-avoid-tmp-buf.diff"

Subject: uml net: revert introduction of private buffer

Avoid using the temporary buffer introduced by previous patch to hold the device name.
Btw, avoid leaking device on an error path. Other error paths may need cleanup.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.git.orig/arch/um/drivers/net_kern.c
+++ linux-2.6.git/arch/um/drivers/net_kern.c
@@ -349,15 +349,20 @@ static int eth_configure(int n, void *in
 	struct net_device *dev;
 	struct uml_net_private *lp;
 	int save, err, size;
-	char name[sizeof(dev->name)];
 
 	size = transport->private_size + sizeof(struct uml_net_private) +
 		sizeof(((struct uml_net_private *) 0)->user);
 
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (device == NULL) {
-		printk(KERN_ERR "eth_configure failed to allocate uml_net\n");
-		return(1);
+		printk(KERN_ERR "eth_configure failed to allocate struct uml_net\n");
+		return 1;
+	}
+
+	dev = alloc_etherdev(size);
+	if (dev == NULL) {
+		printk(KERN_ERR "eth_configure: failed to allocate struct net_device for eth%d\n", n);
+		return 1;
 	}
 
 	INIT_LIST_HEAD(&device->list);
@@ -371,9 +376,9 @@ static int eth_configure(int n, void *in
 	 * netdevice, that is OK, register_netdev{,ice}() will notice this
 	 * and fail.
 	 */
-	snprintf(name, sizeof(name), "eth%d", n);
+	snprintf(dev->name, sizeof(dev->name), "eth%d", n);
 
-	setup_etheraddr(mac, device->mac, name);
+	setup_etheraddr(mac, device->mac, dev->name);
 
 	printk(KERN_INFO "Netdevice %d ", n);
 	printk("(%02x:%02x:%02x:%02x:%02x:%02x) ",
@@ -381,11 +386,6 @@ static int eth_configure(int n, void *in
 	       device->mac[2], device->mac[3],
 	       device->mac[4], device->mac[5]);
 	printk(": ");
-	dev = alloc_etherdev(size);
-	if (dev == NULL) {
-		printk(KERN_ERR "eth_configure: failed to allocate device\n");
-		return 1;
-	}
 
 	lp = dev->priv;
 	/* This points to the transport private data. It's still clear, but we
@@ -403,7 +403,6 @@ static int eth_configure(int n, void *in
 	platform_device_register(&device->pdev);
 	SET_NETDEV_DEV(dev,&device->pdev.dev);
 
-	strcpy(dev->name, name);
 	device->dev = dev;
 
 	(*transport->kern->init)(dev, init);
@@ -426,8 +425,12 @@ static int eth_configure(int n, void *in
 	rtnl_unlock();
 	if (err) {
 		device->dev = NULL;
-		/* XXX: should we call ->remove() here? */
+		/* XXX: should we call ->remove() here?
+		 * IMHO no, kern->remove does
+		 * not exist because allocations are done here only, and
+		 * user->init has not been called yet.*/
 		free_netdev(dev);
+		kfree(device);
 		return 1;
 	}
 

--Boundary-00=_jpx6Fewmd087tHF
Content-Type: text/x-diff; charset="iso-8859-1";
	name="remember-zero-array-net.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="remember-zero-array-net.diff"

uml: Show how user can be converted to a zero-array.

To look at users I did:
$ find arch/um/ include/asm-um -name '*.[ch]'|xargs grep -r 'net_kern\.h' -l|xargs grep '\<user\>'

Most users just cast user to the appropriate pointer, the remaining ones are
fixed here. In net_kern.c, I'm almost sure that save trick is not needed
anymore, but I've not verified it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/um/include/net_kern.h
===================================================================
--- linux-2.6.git.orig/arch/um/include/net_kern.h
+++ linux-2.6.git/arch/um/include/net_kern.h
@@ -40,7 +40,7 @@ struct uml_net_private {
 	void (*add_address)(unsigned char *, unsigned char *, void *);
 	void (*delete_address)(unsigned char *, unsigned char *, void *);
 	int (*set_mtu)(int mtu, void *);
-	int user[1];
+	char user[0];
 };
 
 struct net_kern_info {
Index: linux-2.6.git/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.git.orig/arch/um/drivers/net_kern.c
+++ linux-2.6.git/arch/um/drivers/net_kern.c
@@ -331,10 +331,9 @@ static int eth_configure(int n, void *in
 	struct uml_net *device;
 	struct net_device *dev;
 	struct uml_net_private *lp;
-	int save, err, size;
+	int err, size;
 
-	size = transport->private_size + sizeof(struct uml_net_private) +
-		sizeof(((struct uml_net_private *) 0)->user);
+	size = transport->private_size + sizeof(struct uml_net_private);
 
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (device == NULL) {
@@ -411,12 +410,6 @@ static int eth_configure(int n, void *in
 		return 1;
 	}
 
-	/* lp.user is the first four bytes of the transport data, which
-	 * has already been initialized.  This structure assignment will
-	 * overwrite that, so we make sure that .user gets overwritten with
-	 * what it already has.
-	 */
-	save = lp->user[0];
 	*lp = ((struct uml_net_private)
 		{ .list  		= LIST_HEAD_INIT(lp->list),
 		  .dev 			= dev,
@@ -430,8 +423,7 @@ static int eth_configure(int n, void *in
 		  .write 		= transport->kern->write,
 		  .add_address 		= transport->user->add_address,
 		  .delete_address  	= transport->user->delete_address,
-		  .set_mtu 		= transport->user->set_mtu,
-		  .user  		= { save } });
+		  .set_mtu 		= transport->user->set_mtu });
 
 	init_timer(&lp->tl);
 	spin_lock_init(&lp->lock);

--Boundary-00=_jpx6Fewmd087tHF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_jpx6Fewmd087tHF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_jpx6Fewmd087tHF--
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

