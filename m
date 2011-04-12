Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <nolan@sigbus.net>) id 1Q9ndH-0006vH-0U
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Apr 2011 00:08:31 +0000
Received: from phong.sigbus.net ([64.62.173.8])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1Q9ndF-0007iJ-PP
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Apr 2011 00:08:30 +0000
From: Nolan Leake <nolan@cumulusnetworks.com>
Date: Tue, 12 Apr 2011 16:51:33 -0700
Message-ID: <1302652293.17952.33.camel@voxel>
Mime-Version: 1.0
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
Subject: [uml-devel] [PATCH] um: Add a "ucast" ethernet transport
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>

The "ucast" transport is similar to the mcast transport (and, in fact,
shares most of its code), only it uses UDP unicast to move packets.

Obviously this is only useful for point-to-point connections between
virtual ethernet devices.

Signed-off-by: Nolan Leake <nolan@cumulusnetworks.com>
---
 Documentation/uml/UserModeLinux-HOWTO.txt |   10 +++
 arch/um/drivers/mcast.h                   |    7 ++-
 arch/um/drivers/mcast_kern.c              |   82 +++++++++++++++++++--
 arch/um/drivers/mcast_user.c              |  113 +++++++++++++++++------------
 4 files changed, 157 insertions(+), 55 deletions(-)

diff --git a/Documentation/uml/UserModeLinux-HOWTO.txt b/Documentation/uml/UserModeLinux-HOWTO.txt
index 9b7e190..5d0fc8b 100644
--- a/Documentation/uml/UserModeLinux-HOWTO.txt
+++ b/Documentation/uml/UserModeLinux-HOWTO.txt
@@ -1182,6 +1182,16 @@
   forge.net/>  and explains these in detail, as well as
   some other issues.
 
+  There is also a related point-to-point only "ucast" transport.
+  This is useful when your network does not support multicast, and
+  all network connections are simple point to point links.
+
+  The full set of command line options for this transport are
+
+
+       ethn=ucast,ethernet address,remote address,listen port,remote port
+
+
 
 
   66..66..  TTUUNN//TTAAPP wwiitthh tthhee uummll__nneett hheellppeerr
diff --git a/arch/um/drivers/mcast.h b/arch/um/drivers/mcast.h
index 6fa282e..4510d6f 100644
--- a/arch/um/drivers/mcast.h
+++ b/arch/um/drivers/mcast.h
@@ -10,9 +10,12 @@
 
 struct mcast_data {
 	char *addr;
-	unsigned short port;
-	void *mcast_addr;
+	unsigned short lport;
+	unsigned short rport;
+	void *listen_addr;
+	void *remote_addr;
 	int ttl;
+	int unicast;
 	void *dev;
 };
 
diff --git a/arch/um/drivers/mcast_kern.c b/arch/um/drivers/mcast_kern.c
index ffc6416..5c5920c 100644
--- a/arch/um/drivers/mcast_kern.c
+++ b/arch/um/drivers/mcast_kern.c
@@ -18,8 +18,10 @@
 
 struct mcast_init {
 	char *addr;
-	int port;
+	int lport;
+	int rport;
 	int ttl;
+	bool unicast;
 };
 
 static void mcast_init(struct net_device *dev, void *data)
@@ -31,12 +33,19 @@ static void mcast_init(struct net_device *dev, void *data)
 	pri = netdev_priv(dev);
 	dpri = (struct mcast_data *) pri->user;
 	dpri->addr = init->addr;
-	dpri->port = init->port;
+	dpri->lport = init->lport;
+	dpri->rport = init->rport;
+	dpri->unicast = init->unicast;
 	dpri->ttl = init->ttl;
 	dpri->dev = dev;
 
-	printk("mcast backend multicast address: %s:%u, TTL:%u\n",
-	       dpri->addr, dpri->port, dpri->ttl);
+	if (dpri->unicast) {
+		printk(KERN_INFO "ucast backend address: %s:%u listen port: "
+		       "%u\n", dpri->addr, dpri->rport, dpri->lport);
+	} else {
+		printk(KERN_INFO "mcast backend multicast address: %s:%u, "
+		       "TTL:%u\n", dpri->addr, dpri->lport, dpri->ttl);
+	}
 }
 
 static int mcast_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
@@ -66,7 +75,7 @@ static int mcast_setup(char *str, char **mac_out, void *data)
 
 	*init = ((struct mcast_init)
 		{ .addr 	= "239.192.168.1",
-		  .port 	= 1102,
+		  .lport	= 1102,
 		  .ttl 		= 1 });
 
 	remain = split_if_spec(str, mac_out, &init->addr, &port_str, &ttl_str,
@@ -78,7 +87,7 @@ static int mcast_setup(char *str, char **mac_out, void *data)
 	}
 
 	if (port_str != NULL) {
-		init->port = simple_strtoul(port_str, &last, 10);
+		init->lport = simple_strtoul(port_str, &last, 10);
 		if ((*last != '\0') || (last == port_str)) {
 			printk(KERN_ERR "mcast_setup - Bad port : '%s'\n",
 			       port_str);
@@ -95,8 +104,56 @@ static int mcast_setup(char *str, char **mac_out, void *data)
 		}
 	}
 
+	init->unicast = false;
+	init->rport = init->lport;
+
 	printk(KERN_INFO "Configured mcast device: %s:%u-%u\n", init->addr,
-	       init->port, init->ttl);
+	       init->lport, init->ttl);
+
+	return 1;
+}
+
+static int ucast_setup(char *str, char **mac_out, void *data)
+{
+	struct mcast_init *init = data;
+	char *lport_str = NULL, *rport_str = NULL, *remain;
+	char *last;
+
+	*init = ((struct mcast_init)
+		{ .addr		= "",
+		  .lport	= 1102,
+		  .rport	= 1102 });
+
+	remain = split_if_spec(str, mac_out, &init->addr,
+			       &lport_str, &rport_str, NULL);
+	if (remain != NULL) {
+		printk(KERN_ERR "ucast_setup - Extra garbage on "
+		       "specification : '%s'\n", remain);
+		return 0;
+	}
+
+	if (lport_str != NULL) {
+		init->lport = simple_strtoul(lport_str, &last, 10);
+		if ((*last != '\0') || (last == lport_str)) {
+			printk(KERN_ERR "ucast_setup - Bad listen port : "
+			       "'%s'\n", lport_str);
+			return 0;
+		}
+	}
+
+	if (rport_str != NULL) {
+		init->rport = simple_strtoul(rport_str, &last, 10);
+		if ((*last != '\0') || (last == rport_str)) {
+			printk(KERN_ERR "ucast_setup - Bad remote port : "
+			       "'%s'\n", rport_str);
+			return 0;
+		}
+	}
+
+	init->unicast = true;
+
+	printk(KERN_INFO "Configured ucast device: :%u -> %s:%u\n",
+	       init->lport, init->addr, init->rport);
 
 	return 1;
 }
@@ -111,9 +168,20 @@ static struct transport mcast_transport = {
 	.setup_size 	= sizeof(struct mcast_init),
 };
 
+static struct transport ucast_transport = {
+	.list		= LIST_HEAD_INIT(ucast_transport.list),
+	.name		= "ucast",
+	.setup		= ucast_setup,
+	.user		= &mcast_user_info,
+	.kern		= &mcast_kern_info,
+	.private_size	= sizeof(struct mcast_data),
+	.setup_size	= sizeof(struct mcast_init),
+};
+
 static int register_mcast(void)
 {
 	register_transport(&mcast_transport);
+	register_transport(&ucast_transport);
 	return 0;
 }
 
diff --git a/arch/um/drivers/mcast_user.c b/arch/um/drivers/mcast_user.c
index ee19e91..dbb9d1f 100644
--- a/arch/um/drivers/mcast_user.c
+++ b/arch/um/drivers/mcast_user.c
@@ -32,7 +32,10 @@ static struct sockaddr_in *new_addr(char *addr, unsigned short port)
 		return NULL;
 	}
 	sin->sin_family = AF_INET;
-	sin->sin_addr.s_addr = in_aton(addr);
+	if (addr)
+		sin->sin_addr.s_addr = in_aton(addr);
+	else
+		sin->sin_addr.s_addr = INADDR_ANY;
 	sin->sin_port = htons(port);
 	return sin;
 }
@@ -41,7 +44,11 @@ static int mcast_user_init(void *data, void *dev)
 {
 	struct mcast_data *pri = data;
 
-	pri->mcast_addr = new_addr(pri->addr, pri->port);
+	pri->remote_addr = new_addr(pri->addr, pri->rport);
+	if (pri->unicast)
+		pri->listen_addr = new_addr(NULL, pri->lport);
+	else
+		pri->listen_addr = pri->remote_addr;
 	pri->dev = dev;
 	return 0;
 }
@@ -50,19 +57,24 @@ static void mcast_remove(void *data)
 {
 	struct mcast_data *pri = data;
 
-	kfree(pri->mcast_addr);
-	pri->mcast_addr = NULL;
+	kfree(pri->listen_addr);
+	if (pri->unicast)
+		kfree(pri->remote_addr);
+	pri->listen_addr = pri->remote_addr = NULL;
 }
 
 static int mcast_open(void *data)
 {
 	struct mcast_data *pri = data;
-	struct sockaddr_in *sin = pri->mcast_addr;
+	struct sockaddr_in *lsin = pri->listen_addr;
+	struct sockaddr_in *rsin = pri->remote_addr;
 	struct ip_mreq mreq;
 	int fd, yes = 1, err = -EINVAL;
 
 
-	if ((sin->sin_addr.s_addr == 0) || (sin->sin_port == 0))
+	if ((!pri->unicast && lsin->sin_addr.s_addr == 0) ||
+	    (rsin->sin_addr.s_addr == 0) ||
+	    (lsin->sin_port == 0) || (rsin->sin_port == 0))
 		goto out;
 
 	fd = socket(AF_INET, SOCK_DGRAM, 0);
@@ -81,44 +93,50 @@ static int mcast_open(void *data)
 		goto out_close;
 	}
 
-	/* set ttl according to config */
-	if (setsockopt(fd, SOL_IP, IP_MULTICAST_TTL, &pri->ttl,
-		       sizeof(pri->ttl)) < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "mcast_open: IP_MULTICAST_TTL failed, "
-		       "error = %d\n", errno);
-		goto out_close;
-	}
-
-	/* set LOOP, so data does get fed back to local sockets */
-	if (setsockopt(fd, SOL_IP, IP_MULTICAST_LOOP, &yes, sizeof(yes)) < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "mcast_open: IP_MULTICAST_LOOP failed, "
-		       "error = %d\n", errno);
-		goto out_close;
+	if (!pri->unicast) {
+		/* set ttl according to config */
+		if (setsockopt(fd, SOL_IP, IP_MULTICAST_TTL, &pri->ttl,
+			       sizeof(pri->ttl)) < 0) {
+			err = -errno;
+			printk(UM_KERN_ERR "mcast_open: IP_MULTICAST_TTL "
+			       "failed, error = %d\n", errno);
+			goto out_close;
+		}
+
+		/* set LOOP, so data does get fed back to local sockets */
+		if (setsockopt(fd, SOL_IP, IP_MULTICAST_LOOP,
+			       &yes, sizeof(yes)) < 0) {
+			err = -errno;
+			printk(UM_KERN_ERR "mcast_open: IP_MULTICAST_LOOP "
+			       "failed, error = %d\n", errno);
+			goto out_close;
+		}
 	}
 
-	/* bind socket to mcast address */
-	if (bind(fd, (struct sockaddr *) sin, sizeof(*sin)) < 0) {
+	/* bind socket to the address */
+	if (bind(fd, (struct sockaddr *) lsin, sizeof(*lsin)) < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "mcast_open : data bind failed, "
 		       "errno = %d\n", errno);
 		goto out_close;
 	}
 
-	/* subscribe to the multicast group */
-	mreq.imr_multiaddr.s_addr = sin->sin_addr.s_addr;
-	mreq.imr_interface.s_addr = 0;
-	if (setsockopt(fd, SOL_IP, IP_ADD_MEMBERSHIP,
-		       &mreq, sizeof(mreq)) < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "mcast_open: IP_ADD_MEMBERSHIP failed, "
-		       "error = %d\n", errno);
-		printk(UM_KERN_ERR "There appears not to be a multicast-"
-		       "capable network interface on the host.\n");
-		printk(UM_KERN_ERR "eth0 should be configured in order to use "
-		       "the multicast transport.\n");
-		goto out_close;
+	if (!pri->unicast) {
+		/* subscribe to the multicast group */
+		mreq.imr_multiaddr.s_addr = lsin->sin_addr.s_addr;
+		mreq.imr_interface.s_addr = 0;
+		if (setsockopt(fd, SOL_IP, IP_ADD_MEMBERSHIP,
+			       &mreq, sizeof(mreq)) < 0) {
+			err = -errno;
+			printk(UM_KERN_ERR "mcast_open: IP_ADD_MEMBERSHIP "
+			       "failed, error = %d\n", errno);
+			printk(UM_KERN_ERR "There appears not to be a "
+			       "multicast-capable network interface on the "
+			       "host.\n");
+			printk(UM_KERN_ERR "eth0 should be configured in order "
+			       "to use the multicast transport.\n");
+			goto out_close;
+		}
 	}
 
 	return fd;
@@ -131,16 +149,19 @@ static int mcast_open(void *data)
 
 static void mcast_close(int fd, void *data)
 {
-	struct ip_mreq mreq;
 	struct mcast_data *pri = data;
-	struct sockaddr_in *sin = pri->mcast_addr;
-
-	mreq.imr_multiaddr.s_addr = sin->sin_addr.s_addr;
-	mreq.imr_interface.s_addr = 0;
-	if (setsockopt(fd, SOL_IP, IP_DROP_MEMBERSHIP,
-		       &mreq, sizeof(mreq)) < 0) {
-		printk(UM_KERN_ERR "mcast_open: IP_DROP_MEMBERSHIP failed, "
-		       "error = %d\n", errno);
+
+	if (!pri->unicast) {
+		struct ip_mreq mreq;
+		struct sockaddr_in *lsin = pri->listen_addr;
+
+		mreq.imr_multiaddr.s_addr = lsin->sin_addr.s_addr;
+		mreq.imr_interface.s_addr = 0;
+		if (setsockopt(fd, SOL_IP, IP_DROP_MEMBERSHIP,
+			       &mreq, sizeof(mreq)) < 0) {
+			printk(UM_KERN_ERR "mcast_open: IP_DROP_MEMBERSHIP "
+			       "failed, error = %d\n", errno);
+		}
 	}
 
 	close(fd);
@@ -148,7 +169,7 @@ static void mcast_close(int fd, void *data)
 
 int mcast_user_write(int fd, void *buf, int len, struct mcast_data *pri)
 {
-	struct sockaddr_in *data_addr = pri->mcast_addr;
+	struct sockaddr_in *data_addr = pri->remote_addr;
 
 	return net_sendto(fd, buf, len, data_addr, sizeof(*data_addr));
 }


------------------------------------------------------------------------------
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

