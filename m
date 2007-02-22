Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKKET-0000Ot-46 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 12:08:01 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HKKEP-000616-GD
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 12:08:00 -0800
Date: Thu, 22 Feb 2007 14:59:56 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070222195956.GA6414@ccure.user-mode-linux.org>
References: <200702220054.04938.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200702220054.04938.blaisorblade@yahoo.it>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Feb 22, 2007 at 12:54:04AM +0100, Blaisorblade wrote:
> I started uml_daemon as root by mistake, so /tmp/uml.ctl even if /dev/net/tun
> was world-readable. Ok, I did it. This is the result (after trying many times
> to do 'ifconfig eth0 up' inside UML):

I don't see your irq stuff here when I try that, but there were
multiple problems, which I hope are fixed by the patch below:
	style violations - this made the patch much bigger, and needs
to be split out
	the user init routines now return success or failure
	some major cleaning of the failure paths through eth_configure
		device was never freed
		sysfs_unregister was never called, adding the same
interface again successfully would result in nasty error messages
		device stuck in the devices list regardless, so adding
the same interface again would fail
		the return from platform_device_register was not
checked
		I moved the register_netdev call until almost the end
of the function
	

Let me know what you think about this.

And about your thought of merging the _init into _open, my excuse for
keeping them separate deserves some scrutiny.  Every transport besides
the switch does all of its work in _open, and the _init routine just
initializes data.  So, I would say that if a transport has separate
plug-it-in and bring-it-up operations, maybe they should be separated
more than they are now.  If the switch is the odd one, maybe we should
merge _init into _open.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

Index: linux-2.6.18-mm/arch/um/drivers/daemon_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/daemon_user.c	2007-02-22 12:54:02.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/daemon_user.c	2007-02-22 13:44:09.000000000 -0500
@@ -39,7 +39,7 @@ static struct sockaddr_un *new_addr(void
 	sun = um_kmalloc(sizeof(struct sockaddr_un));
 	if(sun == NULL){
 		printk("new_addr: allocation of sockaddr_un failed\n");
-		return(NULL);
+		return NULL;
 	}
 	sun->sun_family = AF_UNIX;
 	memcpy(sun->sun_path, name, len);
@@ -122,7 +122,7 @@ static int connect_to_switch(struct daem
 	return err;
 }
 
-static void daemon_user_init(void *data, void *dev)
+static int daemon_user_init(void *data, void *dev)
 {
 	struct daemon_data *pri = data;
 	struct timeval tv;
@@ -145,13 +145,16 @@ static void daemon_user_init(void *data,
 	if(pri->fd < 0){
 		kfree(pri->local_addr);
 		pri->local_addr = NULL;
+		return pri->fd;
 	}
+
+	return 0;
 }
 
 static int daemon_open(void *data)
 {
 	struct daemon_data *pri = data;
-	return(pri->fd);
+	return pri->fd;
 }
 
 static void daemon_remove(void *data)
@@ -175,12 +178,12 @@ int daemon_user_write(int fd, void *buf,
 {
 	struct sockaddr_un *data_addr = pri->data_addr;
 
-	return(net_sendto(fd, buf, len, data_addr, sizeof(*data_addr)));
+	return net_sendto(fd, buf, len, data_addr, sizeof(*data_addr));
 }
 
 static int daemon_set_mtu(int mtu, void *data)
 {
-	return(mtu);
+	return mtu;
 }
 
 const struct net_user_info daemon_user_info = {
@@ -193,14 +196,3 @@ const struct net_user_info daemon_user_i
 	.delete_address = NULL,
 	.max_packet	= MAX_PACKET - ETH_HEADER_OTHER
 };
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.18-mm/arch/um/drivers/mcast_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mcast_user.c	2006-12-29 12:20:14.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/mcast_user.c	2007-02-22 13:45:00.000000000 -0500
@@ -39,15 +39,16 @@ static struct sockaddr_in *new_addr(char
 	sin->sin_family = AF_INET;
 	sin->sin_addr.s_addr = in_aton(addr);
 	sin->sin_port = htons(port);
-	return(sin);
+	return sin;
 }
 
-static void mcast_user_init(void *data, void *dev)
+static int mcast_user_init(void *data, void *dev)
 {
 	struct mcast_data *pri = data;
 
 	pri->mcast_addr = new_addr(pri->addr, pri->port);
 	pri->dev = dev;
+	return 0;
 }
 
 static int mcast_open(void *data)
@@ -145,12 +146,12 @@ int mcast_user_write(int fd, void *buf, 
 {
 	struct sockaddr_in *data_addr = pri->mcast_addr;
 
-	return(net_sendto(fd, buf, len, data_addr, sizeof(*data_addr)));
+	return net_sendto(fd, buf, len, data_addr, sizeof(*data_addr));
 }
 
 static int mcast_set_mtu(int mtu, void *data)
 {
-	return(mtu);
+	return mtu;
 }
 
 const struct net_user_info mcast_user_info = {
Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c	2007-02-19 11:52:41.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/net_kern.c	2007-02-22 14:53:00.000000000 -0500
@@ -325,30 +325,31 @@ static struct platform_driver uml_net_dr
 };
 static int driver_registered;
 
-static int eth_configure(int n, void *init, char *mac,
-			 struct transport *transport)
+static void eth_configure(int n, void *init, char *mac,
+			  struct transport *transport)
 {
 	struct uml_net *device;
 	struct net_device *dev;
 	struct uml_net_private *lp;
 	int save, err, size;
 
-	size = transport->private_size + sizeof(struct uml_net_private) +
-		sizeof(((struct uml_net_private *) 0)->user);
+	/*
+	 * This overallocates by sizeof(int) since the last field in
+	 * uml_net_private is used to access the transport-specific
+	 * data, so that user field is the first 4 bytes of the
+	 * transport data.
+	 */
+	size = transport->private_size + sizeof(struct uml_net_private);
 
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (device == NULL) {
 		printk(KERN_ERR "eth_configure failed to allocate uml_net\n");
-		return(1);
+		return;
 	}
 
 	INIT_LIST_HEAD(&device->list);
 	device->index = n;
 
-	spin_lock(&devices_lock);
-	list_add(&device->list, &devices);
-	spin_unlock(&devices_lock);
-
 	setup_etheraddr(mac, device->mac);
 
 	printk(KERN_INFO "Netdevice %d ", n);
@@ -360,7 +361,7 @@ static int eth_configure(int n, void *in
 	dev = alloc_etherdev(size);
 	if (dev == NULL) {
 		printk(KERN_ERR "eth_configure: failed to allocate device\n");
-		return 1;
+		goto out_free_device;
 	}
 
 	lp = dev->priv;
@@ -376,7 +377,8 @@ static int eth_configure(int n, void *in
 	}
 	device->pdev.id = n;
 	device->pdev.name = DRIVER_NAME;
-	platform_device_register(&device->pdev);
+	if(platform_device_register(&device->pdev))
+		goto out_free_netdev;
 	SET_NETDEV_DEV(dev,&device->pdev.dev);
 
 	/* If this name ends up conflicting with an existing registered
@@ -386,31 +388,11 @@ static int eth_configure(int n, void *in
 	snprintf(dev->name, sizeof(dev->name), "eth%d", n);
 	device->dev = dev;
 
+	/* These just fill in a data structure, so there's no failure
+	 * to be worried about.
+	 */
 	(*transport->kern->init)(dev, init);
 
-	dev->mtu = transport->user->max_packet;
-	dev->open = uml_net_open;
-	dev->hard_start_xmit = uml_net_start_xmit;
-	dev->stop = uml_net_close;
-	dev->get_stats = uml_net_get_stats;
-	dev->set_multicast_list = uml_net_set_multicast_list;
-	dev->tx_timeout = uml_net_tx_timeout;
-	dev->set_mac_address = uml_net_set_mac;
-	dev->change_mtu = uml_net_change_mtu;
-	dev->ethtool_ops = &uml_net_ethtool_ops;
-	dev->watchdog_timeo = (HZ >> 1);
-	dev->irq = UM_ETH_IRQ;
-
-	rtnl_lock();
-	err = register_netdevice(dev);
-	rtnl_unlock();
-	if (err) {
-		device->dev = NULL;
-		/* XXX: should we call ->remove() here? */
-		free_netdev(dev);
-		return 1;
-	}
-
 	/* lp.user is the first four bytes of the transport data, which
 	 * has already been initialized.  This structure assignment will
 	 * overwrite that, so we make sure that .user gets overwritten with
@@ -438,12 +420,45 @@ static int eth_configure(int n, void *in
 	lp->tl.function = uml_net_user_timer_expire;
 	memcpy(lp->mac, device->mac, sizeof(lp->mac));
 
-	if (transport->user->init)
-		(*transport->user->init)(&lp->user, dev);
+	if ((transport->user->init != NULL) &&
+	    ((*transport->user->init)(&lp->user, dev) != 0))
+		goto out_unregister;
 
 	set_ether_mac(dev, device->mac);
+	dev->mtu = transport->user->max_packet;
+	dev->open = uml_net_open;
+	dev->hard_start_xmit = uml_net_start_xmit;
+	dev->stop = uml_net_close;
+	dev->get_stats = uml_net_get_stats;
+	dev->set_multicast_list = uml_net_set_multicast_list;
+	dev->tx_timeout = uml_net_tx_timeout;
+	dev->set_mac_address = uml_net_set_mac;
+	dev->change_mtu = uml_net_change_mtu;
+	dev->ethtool_ops = &uml_net_ethtool_ops;
+	dev->watchdog_timeo = (HZ >> 1);
+	dev->irq = UM_ETH_IRQ;
 
-	return 0;
+	rtnl_lock();
+	err = register_netdevice(dev);
+	rtnl_unlock();
+	if (err)
+		goto out_undo_user_init;
+
+	spin_lock(&devices_lock);
+	list_add(&device->list, &devices);
+	spin_unlock(&devices_lock);
+
+	return;
+
+out_undo_user_init:
+	if (transport->user->init != NULL)
+		(*transport->user->remove)(&lp->user);
+out_unregister:
+	platform_device_unregister(&device->pdev);
+out_free_netdev:
+	free_netdev(dev);
+out_free_device: ;
+	kfree(device);
 }
 
 static struct uml_net *find_device(int n)
Index: linux-2.6.18-mm/arch/um/drivers/pcap_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/pcap_user.c	2007-02-20 16:12:28.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/pcap_user.c	2007-02-22 13:47:04.000000000 -0500
@@ -18,7 +18,7 @@
 
 #define PCAP_FD(p) (*(int *)(p))
 
-static void pcap_user_init(void *data, void *dev)
+static int pcap_user_init(void *data, void *dev)
 {
 	struct pcap_data *pri = data;
 	pcap_t *p;
@@ -28,11 +28,12 @@ static void pcap_user_init(void *data, v
 	if(p == NULL){
 		printk("pcap_user_init : pcap_open_live failed - '%s'\n", 
 		       errors);
-		return;
+		return -EINVAL;
 	}
 
 	pri->dev = dev;
 	pri->pcap = p;
+	return 0;
 }
 
 static int pcap_open(void *data)
@@ -42,19 +43,19 @@ static int pcap_open(void *data)
 	int err;
 
 	if(pri->pcap == NULL)
-		return(-ENODEV);
+		return -ENODEV;
 
 	if(pri->filter != NULL){
 		err = dev_netmask(pri->dev, &netmask);
 		if(err < 0){
 			printk("pcap_open : dev_netmask failed\n");
-			return(-EIO);
+			return -EIO;
 		}
 
 		pri->compiled = um_kmalloc(sizeof(struct bpf_program));
 		if(pri->compiled == NULL){
 			printk("pcap_open : kmalloc failed\n");
-			return(-ENOMEM);
+			return -ENOMEM;
 		}
 		
 		err = pcap_compile(pri->pcap, 
@@ -63,18 +64,18 @@ static int pcap_open(void *data)
 		if(err < 0){
 			printk("pcap_open : pcap_compile failed - '%s'\n", 
 			       pcap_geterr(pri->pcap));
-			return(-EIO);
+			return -EIO;
 		}
 
 		err = pcap_setfilter(pri->pcap, pri->compiled);
 		if(err < 0){
 			printk("pcap_open : pcap_setfilter failed - '%s'\n", 
 			       pcap_geterr(pri->pcap));
-			return(-EIO);
+			return -EIO;
 		}
 	}
 	
-	return(PCAP_FD(pri->pcap));
+	return PCAP_FD(pri->pcap);
 }
 
 static void pcap_remove(void *data)
@@ -114,11 +115,11 @@ int pcap_user_read(int fd, void *buffer,
 	n = pcap_dispatch(pri->pcap, 1, handler, (u_char *) &hdata);
 	if(n < 0){
 		printk("pcap_dispatch failed - %s\n", pcap_geterr(pri->pcap));
-		return(-EIO);
+		return -EIO;
 	}
 	else if(n == 0) 
-		return(0);
-	return(hdata.len);
+		return 0;
+	return hdata.len;
 }
 
 const struct net_user_info pcap_user_info = {
@@ -131,14 +132,3 @@ const struct net_user_info pcap_user_inf
 	.delete_address = NULL,
 	.max_packet	= MAX_PACKET - ETH_HEADER_OTHER
 };
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.18-mm/arch/um/drivers/slip_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/slip_user.c	2007-02-20 16:12:28.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/slip_user.c	2007-02-22 13:49:28.000000000 -0500
@@ -17,11 +17,12 @@
 #include "os.h"
 #include "um_malloc.h"
 
-void slip_user_init(void *data, void *dev)
+static int slip_user_init(void *data, void *dev)
 {
 	struct slip_data *pri = data;
 
 	pri->dev = dev;
+	return 0;
 }
 
 static int set_up_tty(int fd)
Index: linux-2.6.18-mm/arch/um/drivers/slirp_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/slirp_user.c	2007-02-20 16:12:28.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/slirp_user.c	2007-02-22 13:50:28.000000000 -0500
@@ -15,11 +15,12 @@
 #include "slip_common.h"
 #include "os.h"
 
-void slirp_user_init(void *data, void *dev)
+static int slirp_user_init(void *data, void *dev)
 {
 	struct slirp_data *pri = data;
 
 	pri->dev = dev;
+	return 0;
 }
 
 struct slirp_pre_exec_data {
Index: linux-2.6.18-mm/arch/um/include/net_user.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/net_user.h	2006-12-29 12:20:14.000000000 -0500
+++ linux-2.6.18-mm/arch/um/include/net_user.h	2007-02-22 13:51:11.000000000 -0500
@@ -14,7 +14,7 @@
 #define UML_NET_VERSION (4)
 
 struct net_user_info {
-	void (*init)(void *, void *);
+	int (*init)(void *, void *);
 	int (*open)(void *);
 	void (*close)(int, void *);
 	void (*remove)(void *);
Index: linux-2.6.18-mm/arch/um/os-Linux/drivers/ethertap_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/drivers/ethertap_user.c	2007-02-20 16:12:28.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/drivers/ethertap_user.c	2007-02-22 13:56:37.000000000 -0500
@@ -24,11 +24,12 @@
 
 #define MAX_PACKET ETH_MAX_PACKET
 
-void etap_user_init(void *data, void *dev)
+static int etap_user_init(void *data, void *dev)
 {
 	struct ethertap_data *pri = data;
 
 	pri->dev = dev;
+	return 0;
 }
 
 struct addr_change {
@@ -121,7 +122,7 @@ static int etap_tramp(char *dev, char *g
 	n = os_read_file(control_me, &c, sizeof(c));
 	if(n != sizeof(c)){
 		printk("etap_tramp : read of status failed, err = %d\n", -n);
-		return(-EINVAL);
+		return -EINVAL;
 	}
 	if(c != 1){
 		printk("etap_tramp : uml_net failed\n");
@@ -132,7 +133,7 @@ static int etap_tramp(char *dev, char *g
 		else if(!WIFEXITED(status) || (WEXITSTATUS(status) != 1))
 			printk("uml_net didn't exit with status 1\n");
 	}
-	return(err);
+	return err;
 }
 
 static int etap_open(void *data)
@@ -142,18 +143,19 @@ static int etap_open(void *data)
 	int data_fds[2], control_fds[2], err, output_len;
 
 	err = tap_open_common(pri->dev, pri->gate_addr);
-	if(err) return(err);
+	if(err)
+		return err;
 
 	err = os_pipe(data_fds, 0, 0);
 	if(err < 0){
 		printk("data os_pipe failed - err = %d\n", -err);
-		return(err);
+		return err;
 	}
 
 	err = os_pipe(control_fds, 1, 0);
 	if(err < 0){
 		printk("control os_pipe failed - err = %d\n", -err);
-		return(err);
+		return err;
 	}
 	
 	err = etap_tramp(pri->dev_name, pri->gate_addr, control_fds[0], 
@@ -171,13 +173,13 @@ static int etap_open(void *data)
 
 	if(err < 0){
 		printk("etap_tramp failed - err = %d\n", -err);
-		return(err);
+		return err;
 	}
 
 	pri->data_fd = data_fds[0];
 	pri->control_fd = control_fds[0];
 	iter_addresses(pri->dev, etap_open_addr, &pri->control_fd);
-	return(data_fds[0]);
+	return data_fds[0];
 }
 
 static void etap_close(int fd, void *data)
@@ -195,7 +197,7 @@ static void etap_close(int fd, void *dat
 
 static int etap_set_mtu(int mtu, void *data)
 {
-	return(mtu);
+	return mtu;
 }
 
 static void etap_add_addr(unsigned char *addr, unsigned char *netmask,
@@ -204,7 +206,8 @@ static void etap_add_addr(unsigned char 
 	struct ethertap_data *pri = data;
 
 	tap_check_ips(pri->gate_addr, addr);
-	if(pri->control_fd == -1) return;
+	if(pri->control_fd == -1)
+		return;
 	etap_open_addr(addr, netmask, &pri->control_fd);
 }
 
@@ -213,7 +216,8 @@ static void etap_del_addr(unsigned char 
 {
 	struct ethertap_data *pri = data;
 
-	if(pri->control_fd == -1) return;
+	if(pri->control_fd == -1)
+		return;
 	etap_close_addr(addr, netmask, &pri->control_fd);
 }
 
@@ -227,14 +231,3 @@ const struct net_user_info ethertap_user
 	.delete_address = etap_del_addr,
 	.max_packet	= MAX_PACKET - ETH_HEADER_ETHERTAP
 };
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.18-mm/arch/um/os-Linux/drivers/tuntap_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/drivers/tuntap_user.c	2007-02-20 16:12:28.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/drivers/tuntap_user.c	2007-02-22 13:55:28.000000000 -0500
@@ -24,11 +24,12 @@
 
 #define MAX_PACKET ETH_MAX_PACKET
 
-void tuntap_user_init(void *data, void *dev)
+static int tuntap_user_init(void *data, void *dev)
 {
 	struct tuntap_data *pri = data;
 
 	pri->dev = dev;
+	return 0;
 }
 
 static void tuntap_add_addr(unsigned char *addr, unsigned char *netmask,
@@ -37,7 +38,8 @@ static void tuntap_add_addr(unsigned cha
 	struct tuntap_data *pri = data;
 
 	tap_check_ips(pri->gate_addr, addr);
-	if((pri->fd == -1) || pri->fixed_config) return;
+	if((pri->fd == -1) || pri->fixed_config)
+		return;
 	open_addr(addr, netmask, pri->dev_name);
 }
 
@@ -46,7 +48,8 @@ static void tuntap_del_addr(unsigned cha
 {
 	struct tuntap_data *pri = data;
 
-	if((pri->fd == -1) || pri->fixed_config) return;
+	if((pri->fd == -1) || pri->fixed_config)
+		return;
 	close_addr(addr, netmask, pri->dev_name);
 }
 
@@ -83,7 +86,8 @@ static int tuntap_open_tramp(char *gate,
 
 	pid = run_helper(tuntap_pre_exec, &data, argv, NULL);
 
-	if(pid < 0) return(-pid);
+	if(pid < 0)
+		return -pid;
 
 	os_close_file(remote);
 
@@ -114,16 +118,16 @@ static int tuntap_open_tramp(char *gate,
 	cmsg = CMSG_FIRSTHDR(&msg);
 	if(cmsg == NULL){
 		printk("tuntap_open_tramp : didn't receive a message\n");
-		return(-EINVAL);
+		return -EINVAL;
 	}
 	if((cmsg->cmsg_level != SOL_SOCKET) || 
 	   (cmsg->cmsg_type != SCM_RIGHTS)){
 		printk("tuntap_open_tramp : didn't receive a descriptor\n");
-		return(-EINVAL);
+		return -EINVAL;
 	}
 	*fd_out = ((int *) CMSG_DATA(cmsg))[0];
 	os_set_exec_close(*fd_out, 1);
-	return(0);
+	return 0;
 }
 
 static int tuntap_open(void *data)
@@ -135,7 +139,7 @@ static int tuntap_open(void *data)
 
 	err = tap_open_common(pri->dev, pri->gate_addr);
 	if(err < 0)
-		return(err);
+		return err;
 
 	if(pri->fixed_config){
 		pri->fd = os_open_file("/dev/net/tun",
@@ -143,7 +147,7 @@ static int tuntap_open(void *data)
 		if(pri->fd < 0){
 			printk("Failed to open /dev/net/tun, err = %d\n",
 			       -pri->fd);
-			return(pri->fd);
+			return pri->fd;
 		}
 		memset(&ifr, 0, sizeof(ifr));
 		ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
@@ -160,7 +164,7 @@ static int tuntap_open(void *data)
 		if(err < 0){
 			printk("tuntap_open : os_pipe failed - err = %d\n",
 			       -err);
-			return(err);
+			return err;
 		}
 
 		buffer = get_output_buffer(&len);
@@ -175,7 +179,7 @@ static int tuntap_open(void *data)
 			printk("%s", output);
 			free_output_buffer(buffer);
 			printk("tuntap_open_tramp failed - err = %d\n", -err);
-			return(err);
+			return err;
 		}
 
 		pri->dev_name = uml_strdup(buffer);
@@ -187,7 +191,7 @@ static int tuntap_open(void *data)
 		iter_addresses(pri->dev, open_addr, pri->dev_name);
 	}
 
-	return(pri->fd);
+	return pri->fd;
 }
 
 static void tuntap_close(int fd, void *data)
@@ -202,7 +206,7 @@ static void tuntap_close(int fd, void *d
 
 static int tuntap_set_mtu(int mtu, void *data)
 {
-	return(mtu);
+	return mtu;
 }
 
 const struct net_user_info tuntap_user_info = {
@@ -215,14 +219,3 @@ const struct net_user_info tuntap_user_i
 	.delete_address = tuntap_del_addr,
 	.max_packet	= MAX_PACKET
 };
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
