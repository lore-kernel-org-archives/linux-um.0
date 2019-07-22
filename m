Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hpSmK-0003Ms-TP
 for linux-um@lists.infradead.org; Mon, 22 Jul 2019 07:30:39 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCHv3 1/5] um: Add legacy tap support and rename existing vector
 to hybrid
Date: Mon, 22 Jul 2019 08:30:21 +0100
Message-Id: <20190722073025.20844-1-anton.ivanov@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

1. Adds legacy tap support
2. Renames tap+raw as hybrid

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/vector_kern.c       |   2 +
 arch/um/drivers/vector_transports.c |  29 +++++-
 arch/um/drivers/vector_user.c       | 203 +++++++++++++++++++++---------------
 arch/um/drivers/vector_user.h       |   4 +-
 4 files changed, 151 insertions(+), 87 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 046fa9ea0ccc..e314a60cdc98 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -186,6 +186,8 @@ static int get_transport_options(struct arglist *def)
 
 
 	if (strncmp(transport, TRANS_TAP, TRANS_TAP_LEN) == 0)
+		return 0;
+	if (strncmp(transport, TRANS_HYBRID, TRANS_HYBRID_LEN) == 0)
 		return (vec_rx | VECTOR_BPF);
 	if (strncmp(transport, TRANS_RAW, TRANS_RAW_LEN) == 0)
 		return (vec_rx | vec_tx | VECTOR_QDISC_BYPASS);
diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
index 77e4ebc206ae..2999f3bd1781 100644
--- a/arch/um/drivers/vector_transports.c
+++ b/arch/um/drivers/vector_transports.c
@@ -418,7 +418,7 @@ static int build_raw_transport_data(struct vector_private *vp)
 	return 0;
 }
 
-static int build_tap_transport_data(struct vector_private *vp)
+static int build_hybrid_transport_data(struct vector_private *vp)
 {
 	if (uml_raw_enable_vnet_headers(vp->fds->rx_fd)) {
 		vp->form_header = &raw_form_header;
@@ -432,7 +432,7 @@ static int build_tap_transport_data(struct vector_private *vp)
 				NETIF_F_TSO | NETIF_F_GSO | NETIF_F_GRO);
 		netdev_info(
 			vp->dev,
-			"tap/raw: using vnet headers for tso and tx/rx checksum"
+			"tap/raw hybrid: using vnet headers for tso and tx/rx checksum"
 		);
 	} else {
 		return 0; /* do not try to enable tap too if raw failed */
@@ -442,6 +442,29 @@ static int build_tap_transport_data(struct vector_private *vp)
 	return -1;
 }
 
+static int build_tap_transport_data(struct vector_private *vp)
+{
+	/* "Pure" tap uses the same fd for rx and tx */
+	if (uml_tap_enable_vnet_headers(vp->fds->tx_fd)) {
+		vp->form_header = &raw_form_header;
+		vp->verify_header = &raw_verify_header;
+		vp->header_size = sizeof(struct virtio_net_hdr);
+		vp->rx_header_size = sizeof(struct virtio_net_hdr);
+		vp->dev->hw_features |=
+			(NETIF_F_TSO | NETIF_F_GSO | NETIF_F_GRO);
+		vp->dev->features |=
+			(NETIF_F_RXCSUM | NETIF_F_HW_CSUM |
+				NETIF_F_TSO | NETIF_F_GSO | NETIF_F_GRO);
+		netdev_info(
+			vp->dev,
+			"tap: using vnet headers for tso and tx/rx checksum"
+		);
+		return 0;
+	}
+	return -1;
+}
+
+
 int build_transport_data(struct vector_private *vp)
 {
 	char *transport = uml_vector_fetch_arg(vp->parsed, "transport");
@@ -454,6 +477,8 @@ int build_transport_data(struct vector_private *vp)
 		return build_raw_transport_data(vp);
 	if (strncmp(transport, TRANS_TAP, TRANS_TAP_LEN) == 0)
 		return build_tap_transport_data(vp);
+	if (strncmp(transport, TRANS_HYBRID, TRANS_HYBRID_LEN) == 0)
+		return build_hybrid_transport_data(vp);
 	return 0;
 }
 
diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 3d8cdbdb4e66..af1a1da432ca 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -115,12 +115,76 @@ struct arglist *uml_parse_vector_ifspec(char *arg)
 
 #define PATH_NET_TUN "/dev/net/tun"
 
-static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
+
+static int create_tap_fd(char *iface)
 {
 	struct ifreq ifr;
 	int fd = -1;
-	struct sockaddr_ll sock;
 	int err = -ENOMEM, offload;
+
+	fd = open(PATH_NET_TUN, O_RDWR);
+	if (fd < 0) {
+		printk(UM_KERN_ERR "uml_tap: failed to open tun device\n");
+		goto tap_fd_cleanup;
+	}
+	memset(&ifr, 0, sizeof(ifr));
+	ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
+	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
+
+	err = ioctl(fd, TUNSETIFF, (void *) &ifr);
+	if (err != 0) {
+		printk(UM_KERN_ERR "uml_tap: failed to select tap interface\n");
+		goto tap_fd_cleanup;
+	}
+
+	offload = TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6;
+	ioctl(fd, TUNSETOFFLOAD, offload);
+	return fd;
+tap_fd_cleanup:
+	if (fd >= 0)
+		os_close_file(fd);
+	return err;
+}
+
+static int create_raw_fd(char *iface, int flags, int proto)
+{
+	struct ifreq ifr;
+	int fd = -1;
+	struct sockaddr_ll sock;
+	int err = -ENOMEM;
+
+	fd = socket(AF_PACKET, SOCK_RAW, flags);
+	if (fd == -1) {
+		err = -errno;
+		goto raw_fd_cleanup;
+	}
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
+	if (ioctl(fd, SIOCGIFINDEX, (void *) &ifr) < 0) {
+		err = -errno;
+		goto raw_fd_cleanup;
+	}
+
+	sock.sll_family = AF_PACKET;
+	sock.sll_protocol = htons(proto);
+	sock.sll_ifindex = ifr.ifr_ifindex;
+
+	if (bind(fd,
+		(struct sockaddr *) &sock, sizeof(struct sockaddr_ll)) < 0) {
+		err = -errno;
+		goto raw_fd_cleanup;
+	}
+	return fd;
+raw_fd_cleanup:
+	printk(UM_KERN_ERR "user_init_raw: init failed, error %d", err);
+	if (fd >= 0)
+		os_close_file(fd);
+	return err;
+}
+
+static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
+{
+	int fd = -1;
 	char *iface;
 	struct vector_fds *result = NULL;
 
@@ -142,117 +206,88 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 
 	/* TAP */
 
-	fd = open(PATH_NET_TUN, O_RDWR);
+	fd = create_tap_fd(iface);
 	if (fd < 0) {
-		printk(UM_KERN_ERR "uml_tap: failed to open tun device\n");
+		printk(UM_KERN_ERR "uml_tap: failed to create tun interface\n");
 		goto tap_cleanup;
 	}
 	result->tx_fd = fd;
-	memset(&ifr, 0, sizeof(ifr));
-	ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
-	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
+	result->rx_fd = fd;
+	return result;
+tap_cleanup:
+	printk(UM_KERN_ERR "user_init_tap: init failed, error %d", fd);
+	if (result != NULL)
+		kfree(result);
+	return NULL;
+}
 
-	err = ioctl(fd, TUNSETIFF, (void *) &ifr);
-	if (err != 0) {
-		printk(UM_KERN_ERR "uml_tap: failed to select tap interface\n");
-		goto tap_cleanup;
+static struct vector_fds *user_init_hybrid_fds(struct arglist *ifspec)
+{
+	char *iface;
+	struct vector_fds *result = NULL;
+
+	iface = uml_vector_fetch_arg(ifspec, TOKEN_IFNAME);
+	if (iface == NULL) {
+		printk(UM_KERN_ERR "uml_tap: failed to parse interface spec\n");
+		goto hybrid_cleanup;
 	}
 
-	offload = TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6;
-	ioctl(fd, TUNSETOFFLOAD, offload);
+	result = uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
+	if (result == NULL) {
+		printk(UM_KERN_ERR "uml_tap: failed to allocate file descriptors\n");
+		goto hybrid_cleanup;
+	}
+	result->rx_fd = -1;
+	result->tx_fd = -1;
+	result->remote_addr = NULL;
+	result->remote_addr_size = 0;
 
-	/* RAW */
+	/* TAP */
 
-	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
-	if (fd == -1) {
-		printk(UM_KERN_ERR
-			"uml_tap: failed to create socket: %i\n", -errno);
-		goto tap_cleanup;
-	}
-	result->rx_fd = fd;
-	memset(&ifr, 0, sizeof(ifr));
-	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
-	if (ioctl(fd, SIOCGIFINDEX, (void *) &ifr) < 0) {
-		printk(UM_KERN_ERR
-			"uml_tap: failed to set interface: %i\n", -errno);
-		goto tap_cleanup;
+	result->tx_fd = create_tap_fd(iface);
+	if (result->tx_fd < 0) {
+		printk(UM_KERN_ERR "uml_tap: failed to create tun interface: %i\n", result->tx_fd);
+		goto hybrid_cleanup;
 	}
 
-	sock.sll_family = AF_PACKET;
-	sock.sll_protocol = htons(ETH_P_ALL);
-	sock.sll_ifindex = ifr.ifr_ifindex;
+	/* RAW */
 
-	if (bind(fd,
-		(struct sockaddr *) &sock, sizeof(struct sockaddr_ll)) < 0) {
+	result->rx_fd = create_raw_fd(iface, ETH_P_ALL, ETH_P_ALL);
+	if (result->rx_fd == -1) {
 		printk(UM_KERN_ERR
-			"user_init_tap: failed to bind raw pair, err %d\n",
-				-errno);
-		goto tap_cleanup;
+			"uml_tap: failed to create paired raw socket: %i\n", result->rx_fd);
+		goto hybrid_cleanup;
 	}
 	return result;
-tap_cleanup:
-	printk(UM_KERN_ERR "user_init_tap: init failed, error %d", err);
-	if (result != NULL) {
-		if (result->rx_fd >= 0)
-			os_close_file(result->rx_fd);
-		if (result->tx_fd >= 0)
-			os_close_file(result->tx_fd);
+hybrid_cleanup:
+	printk(UM_KERN_ERR "user_init_hybrid: init failed");
+	if (result != NULL)
 		kfree(result);
-	}
 	return NULL;
 }
 
 
 static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 {
-	struct ifreq ifr;
 	int rxfd = -1, txfd = -1;
-	struct sockaddr_ll sock;
 	int err = -ENOMEM;
 	char *iface;
 	struct vector_fds *result = NULL;
 
 	iface = uml_vector_fetch_arg(ifspec, TOKEN_IFNAME);
 	if (iface == NULL)
-		goto cleanup;
+		goto raw_cleanup;
 
-	rxfd = socket(AF_PACKET, SOCK_RAW, ETH_P_ALL);
+	rxfd = create_raw_fd(iface, ETH_P_ALL, ETH_P_ALL);
 	if (rxfd == -1) {
 		err = -errno;
-		goto cleanup;
+		goto raw_cleanup;
 	}
-	txfd = socket(AF_PACKET, SOCK_RAW, 0); /* Turn off RX on this fd */
+	txfd = create_raw_fd(iface, 0, ETH_P_IP); /* Turn off RX on this fd */
 	if (txfd == -1) {
 		err = -errno;
-		goto cleanup;
-	}
-	memset(&ifr, 0, sizeof(ifr));
-	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
-	if (ioctl(rxfd, SIOCGIFINDEX, (void *) &ifr) < 0) {
-		err = -errno;
-		goto cleanup;
-	}
-
-	sock.sll_family = AF_PACKET;
-	sock.sll_protocol = htons(ETH_P_ALL);
-	sock.sll_ifindex = ifr.ifr_ifindex;
-
-	if (bind(rxfd,
-		(struct sockaddr *) &sock, sizeof(struct sockaddr_ll)) < 0) {
-		err = -errno;
-		goto cleanup;
+		goto raw_cleanup;
 	}
-
-	sock.sll_family = AF_PACKET;
-	sock.sll_protocol = htons(ETH_P_IP);
-	sock.sll_ifindex = ifr.ifr_ifindex;
-
-	if (bind(txfd,
-		(struct sockaddr *) &sock, sizeof(struct sockaddr_ll)) < 0) {
-		err = -errno;
-		goto cleanup;
-	}
-
 	result = uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
 	if (result != NULL) {
 		result->rx_fd = rxfd;
@@ -261,13 +296,10 @@ static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 		result->remote_addr_size = 0;
 	}
 	return result;
-cleanup:
+raw_cleanup:
 	printk(UM_KERN_ERR "user_init_raw: init failed, error %d", err);
-	if (rxfd >= 0)
-		os_close_file(rxfd);
-	if (txfd >= 0)
-		os_close_file(txfd);
-	kfree(result);
+	if (result != NULL)
+		kfree(result);
 	return NULL;
 }
 
@@ -457,6 +489,8 @@ struct vector_fds *uml_vector_user_open(
 	}
 	if (strncmp(transport, TRANS_RAW, TRANS_RAW_LEN) == 0)
 		return user_init_raw_fds(parsed);
+	if (strncmp(transport, TRANS_HYBRID, TRANS_HYBRID_LEN) == 0)
+		return user_init_hybrid_fds(parsed);
 	if (strncmp(transport, TRANS_TAP, TRANS_TAP_LEN) == 0)
 		return user_init_tap_fds(parsed);
 	if (strncmp(transport, TRANS_GRE, TRANS_GRE_LEN) == 0)
@@ -483,8 +517,9 @@ int uml_vector_sendmsg(int fd, void *hdr, int flags)
 int uml_vector_recvmsg(int fd, void *hdr, int flags)
 {
 	int n;
+	struct msghdr *msg = (struct msghdr *) hdr;
 
-	CATCH_EINTR(n = recvmsg(fd, (struct msghdr *) hdr,  flags));
+	CATCH_EINTR(n = readv(fd, msg->msg_iov, msg->msg_iovlen));
 	if ((n < 0) && (errno == EAGAIN))
 		return 0;
 	if (n >= 0)
diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
index d7cbff73b7ff..6bf50cf78ad0 100644
--- a/arch/um/drivers/vector_user.h
+++ b/arch/um/drivers/vector_user.h
@@ -16,13 +16,15 @@
 #define TRANS_TAP "tap"
 #define TRANS_TAP_LEN strlen(TRANS_TAP)
 
-
 #define TRANS_GRE "gre"
 #define TRANS_GRE_LEN strlen(TRANS_RAW)
 
 #define TRANS_L2TPV3 "l2tpv3"
 #define TRANS_L2TPV3_LEN strlen(TRANS_L2TPV3)
 
+#define TRANS_HYBRID "hybrid"
+#define TRANS_HYBRID_LEN strlen(TRANS_HYBRID)
+
 #ifndef IPPROTO_GRE
 #define IPPROTO_GRE 0x2F
 #endif
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

