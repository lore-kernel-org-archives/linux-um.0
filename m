Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1e0aFu-0005J6-2g for user-mode-linux-devel@lists.sourceforge.net;
 Fri, 06 Oct 2017 21:34:02 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1e0aFs-0002mA-Ia
 for user-mode-linux-devel@lists.sourceforge.net;
 Fri, 06 Oct 2017 21:34:02 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Fri,  6 Oct 2017 22:33:39 +0100
Message-Id: <20171006213339.78822-4-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20171006213339.78822-1-anton.ivanov@kot-begemot.co.uk>
References: <20171006213339.78822-1-anton.ivanov@kot-begemot.co.uk>
Subject: [uml-devel] [PATCH v5-redo 3/3] TSO/GSO Support for Vector Network
 drivers
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard.weinberger@gmail.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

1. TSO/GSO support where applicable or available
RX - raw and tapraw
TX - tap only (raw appears to be hitting a bug in the
af_packet family in the kernel resulting in it being
stuck in a -ENOBUFS loop.

This results in TX/RX TCP performance ~ 2-3 times higher
than qemu on same hardware (measured with iperf).

2. Cleanup and unification of the RX/TX code to use the
same skb and msg prep routines.

Adds two new transport arguments applicable to all transports

gro - enable/disable GRO in driver
vec - enable/disable multi-message vector IO

3. Adds change/set device features support. Gro,gso,gso,sg,etc
can now be adjusted via ethtool.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/vector_kern.c       | 167 ++++++++++++++++++++++++++----------
 arch/um/drivers/vector_kern.h       |   1 +
 arch/um/drivers/vector_transports.c |  15 ++--
 arch/um/drivers/vector_user.c       |   5 +-
 4 files changed, 135 insertions(+), 53 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index f0ea7f98b86c..268862d8f915 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -75,7 +75,7 @@ static void vector_eth_configure(int n, struct arglist *def);
 #define SAFETY_MARGIN 32
 #define DEFAULT_VECTOR_SIZE 64
 #define TX_SMALL_PACKET 128
-#define MAX_IOV_SIZE 8
+#define MAX_IOV_SIZE (MAX_SKB_FRAGS + 1)
 
 static const struct {
 	const char string[ETH_GSTRING_LEN];
@@ -162,15 +162,45 @@ static int get_headroom(struct arglist *def)
 	return DEFAULT_HEADROOM;
 }
 
+static int get_req_size(struct arglist *def)
+{
+	char *gro = uml_vector_fetch_arg(def, "gro");
+	long result;
+
+	if (gro != NULL) {
+		if (kstrtoul(gro, 10, &result) == 0) {
+			if (result > 0)
+				return 65536;
+		}
+	}
+	return get_mtu(def) + ETH_HEADER_OTHER + get_headroom(def) + SAFETY_MARGIN;
+}
+
+
 static int get_transport_options(struct arglist *def)
 {
 	char *transport = uml_vector_fetch_arg(def, "transport");
+	char *vector = uml_vector_fetch_arg(def, "vec");
+
+	int vec_rx = VECTOR_RX;
+	int vec_tx = VECTOR_TX;
+	long parsed;
+
+	if (vector != NULL) {
+		if (kstrtoul(vector, 10, &parsed) == 0) {
+			if (parsed == 0) {
+				vec_rx = 0;
+				vec_tx = 0;
+			}
+		}
+	}
+
 
 	if (strncmp(transport, TRANS_TAP, TRANS_TAP_LEN) == 0)
-		return (VECTOR_RX | VECTOR_BPF);
+		return (vec_rx | VECTOR_BPF);
 	if (strncmp(transport, TRANS_RAW, TRANS_RAW_LEN) == 0)
-		return (VECTOR_TX | VECTOR_RX | VECTOR_BPF);
-	return (VECTOR_TX | VECTOR_RX);
+		return (vec_rx | vec_tx | VECTOR_BPF);
+	return (vec_rx | vec_tx);
 }
 
 
@@ -547,13 +577,59 @@ static struct vector_queue *create_queue(
  * just read into a prepared queue filled with skbuffs.
  */
 
+static struct sk_buff *prep_skb(struct vector_private *vp, struct user_msghdr *msg)
+{
+	int linear = vp->max_packet + vp->headroom + SAFETY_MARGIN;
+	struct sk_buff *result;
+	int iov_index = 0, len;
+	struct iovec *iov = msg->msg_iov;
+	int err, nr_frags, frag;
+	skb_frag_t *skb_frag;
+
+	if (vp->req_size <= linear)
+		len = linear;
+	else
+		len = vp->req_size;
+	result = alloc_skb_with_frags(linear, len - vp->max_packet, 3, &err, GFP_ATOMIC);
+	if (vp->header_size > 0)
+		iov_index++;
+	if (result == NULL) {
+		iov[iov_index].iov_base = NULL;
+		iov[iov_index].iov_len = 0;
+		goto done;
+	}
+	skb_reserve(result, vp->headroom);
+	result->dev = vp->dev;
+	skb_put(result, vp->max_packet);
+	result->data_len = len - vp->max_packet;
+	result->len += len - vp->max_packet;
+	skb_reset_mac_header(result);
+	result->ip_summed = CHECKSUM_NONE;
+	iov[iov_index].iov_base = result->data;
+	iov[iov_index].iov_len = vp->max_packet;
+	iov_index++;
+
+	nr_frags = skb_shinfo(result)->nr_frags;
+	for (frag = 0; frag < nr_frags; frag++) {
+		skb_frag = &skb_shinfo(result)->frags[frag];
+		iov[iov_index].iov_base = skb_frag_address_safe(skb_frag);
+		if (iov[iov_index].iov_base != NULL)
+			iov[iov_index].iov_len = skb_frag_size(skb_frag);
+		else
+			iov[iov_index].iov_len = 0;
+		iov_index++;
+	}
+done:
+	msg->msg_iovlen = iov_index;
+	return result;
+}
+
+
 /* Prepare queue for recvmmsg one-shot rx - fill with fresh sk_buffs*/
 
 static void prep_queue_for_rx(struct vector_queue *qi)
 {
 	struct vector_private *vp = netdev_priv(qi->dev);
-	struct sk_buff *skb;
-	struct iovec *iov;
 	struct mmsghdr *mmsg_vector = qi->mmsg_vector;
 	void **skbuff_vector = qi->skbuff_vector;
 	int i;
@@ -566,26 +642,7 @@ static void prep_queue_for_rx(struct vector_queue *qi)
 		 * This allows us stop faffing around with a "drop buffer"
 		 */
 
-		skb = netdev_alloc_skb(
-			vp->dev,
-			vp->max_packet + vp->headroom + SAFETY_MARGIN);
-		iov = mmsg_vector->msg_hdr.msg_iov;
-		mmsg_vector->msg_len = 0;
-		if (vp->header_size > 0)
-			iov++;
-		if (skb != NULL) {
-			skb_reserve(skb, vp->headroom);
-			skb->dev = qi->dev;
-			skb_put(skb, vp->max_packet);
-			skb_reset_mac_header(skb);
-			skb->ip_summed = CHECKSUM_NONE;
-			iov->iov_base = skb->data;
-			iov->iov_len = vp->max_packet;
-		} else {
-			iov->iov_base = NULL;
-			iov->iov_len = 0;
-		}
-		*skbuff_vector = skb;
+		*skbuff_vector = prep_skb(vp, &mmsg_vector->msg_hdr);
 		skbuff_vector++;
 		mmsg_vector++;
 	}
@@ -738,7 +795,7 @@ static int vector_legacy_rx(struct vector_private *vp)
 {
 	int pkt_len;
 	struct user_msghdr hdr;
-	struct iovec iov[2]; /* header + data use case only */
+	struct iovec iov[2 + MAX_IOV_SIZE]; /* header + data use case only */
 	int iovpos = 0;
 	struct sk_buff *skb;
 	int header_check;
@@ -746,34 +803,25 @@ static int vector_legacy_rx(struct vector_private *vp)
 	hdr.msg_name = NULL;
 	hdr.msg_namelen = 0;
 	hdr.msg_iov = (struct iovec *) &iov;
-	hdr.msg_iovlen = 1;
 	hdr.msg_control = NULL;
 	hdr.msg_controllen = 0;
 	hdr.msg_flags = 0;
 
 	if (vp->header_size > 0) {
-		iov[iovpos].iov_base = vp->header_rxbuffer;
-		iov[iovpos].iov_len = vp->rx_header_size;
-		hdr.msg_iovlen++;
-		iovpos++;
+		iov[0].iov_base = vp->header_rxbuffer;
+		iov[0].iov_len = vp->header_size;
 	}
 
-	skb = netdev_alloc_skb(vp->dev,
-			vp->max_packet + vp->headroom + SAFETY_MARGIN);
+	skb = prep_skb(vp, &hdr);
+
 	if (skb == NULL) {
 		/* Read a packet into drop_buffer and don't do
 		 * anything with it.
 		 */
 		iov[iovpos].iov_base = drop_buffer;
 		iov[iovpos].iov_len = DROP_BUFFER_SIZE;
+		hdr.msg_iovlen = 1;
 		vp->dev->stats.rx_dropped++;
-	} else {
-		skb_reserve(skb, vp->headroom);
-		skb->dev = vp->dev;
-		skb_put(skb, vp->max_packet);
-		skb_reset_mac_header(skb);
-		iov[iovpos].iov_base = skb->data;
-		iov[iovpos].iov_len = vp->max_packet;
 	}
 
 	pkt_len = uml_vector_recvmsg(vp->fds->rx_fd, &hdr, 0);
@@ -794,7 +842,7 @@ static int vector_legacy_rx(struct vector_private *vp)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			skb_trim(skb, pkt_len - vp->rx_header_size);
+			pskb_trim(skb, pkt_len - vp->rx_header_size);
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			vp->dev->stats.rx_bytes += skb->len;
 			vp->dev->stats.rx_packets++;
@@ -898,7 +946,7 @@ static int vector_mmsg_rx(struct vector_private *vp)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			skb_trim(skb,
+			pskb_trim(skb,
 				mmsg_vector->msg_len - vp->rx_header_size);
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			/*
@@ -1109,7 +1157,7 @@ static int vector_net_open(struct net_device *dev)
 
 	if ((vp->options & VECTOR_RX) > 0) {
 		vp->rx_queue = create_queue(
-			vp, get_depth(vp->parsed), vp->rx_header_size, 0);
+			vp, get_depth(vp->parsed), vp->rx_header_size, MAX_IOV_SIZE);
 		vp->rx_queue->queue_depth = get_depth(vp->parsed);
 	} else {
 		vp->header_rxbuffer = kmalloc(vp->rx_header_size, GFP_KERNEL);
@@ -1200,6 +1248,30 @@ static void vector_net_tx_timeout(struct net_device *dev)
 	schedule_work(&vp->reset_tx);
 }
 
+static netdev_features_t vector_fix_features(struct net_device *dev,
+	netdev_features_t features)
+{
+	features &= ~(NETIF_F_IP_CSUM|NETIF_F_IPV6_CSUM);
+	return features;
+}
+
+static int vector_set_features(struct net_device *dev,
+	netdev_features_t features)
+{
+	struct vector_private *vp = netdev_priv(dev);
+	/* Adjust buffer sizes for GSO/GRO. Unfortunately, there is
+	* no way to negotiate it on raw sockets, so we can change
+	* only our side.
+	*/
+	if (features & NETIF_F_GRO)
+		/* All new frame buffers will be GRO-sized */
+		vp->req_size = 65536;
+	else
+		/* All new frame buffers will be normal sized */
+		vp->req_size = vp->max_packet + vp->headroom + SAFETY_MARGIN;
+	return 0;
+}
+
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void vector_net_poll_controller(struct net_device *dev)
 {
@@ -1303,6 +1375,8 @@ static const struct net_device_ops vector_netdev_ops = {
 	.ndo_tx_timeout		= vector_net_tx_timeout,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_fix_features	= vector_fix_features,
+	.ndo_set_features	= vector_set_features,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller = vector_net_poll_controller,
 #endif
@@ -1394,10 +1468,11 @@ static void vector_eth_configure(
 		.opened			= false,
 		.transport_data		= NULL,
 		.in_write_poll		= false,
-		.coalesce		= 2
+		.coalesce		= 2,
+		.req_size		= get_req_size(def)
 		});
 
-	dev->features = NETIF_F_SG;
+	dev->features = dev->hw_features = (NETIF_F_SG | NETIF_F_FRAGLIST);
 	tasklet_init(&vp->tx_poll, vector_tx_poll, (unsigned long)vp);
 	INIT_WORK(&vp->reset_tx, vector_reset_tx);
 
diff --git a/arch/um/drivers/vector_kern.h b/arch/um/drivers/vector_kern.h
index a9ade0851fda..699696deb396 100644
--- a/arch/um/drivers/vector_kern.h
+++ b/arch/um/drivers/vector_kern.h
@@ -90,6 +90,7 @@ struct vector_private {
 	void *transport_data; /* transport specific params if needed */
 
 	int max_packet;
+	int req_size; /* different from max packet - used for TSO */
 	int headroom;
 
 	int options;
diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
index 9f07d585f71b..57aa9cb5434c 100644
--- a/arch/um/drivers/vector_transports.c
+++ b/arch/um/drivers/vector_transports.c
@@ -187,9 +187,8 @@ static int raw_verify_header (
 {
 	struct virtio_net_hdr *vheader = (struct virtio_net_hdr *) header;
 
-	if (vheader->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
-		printk(KERN_ERR "raw: GSO enabled on interface, please turn off");
-		return -1;	/* GSO, we cannot process this */
+	if ((vheader->gso_type != VIRTIO_NET_HDR_GSO_NONE) && (vp->req_size != 65536)) {
+		printk(KERN_INFO "Incoming GSO frames and GRO disabled on the interface");
 	}
 	if ((vheader->flags & VIRTIO_NET_HDR_F_DATA_VALID) > 0)
 		return 1;
@@ -389,8 +388,9 @@ static int build_raw_transport_data(struct vector_private *vp)
 		vp->verify_header = &raw_verify_header;
 		vp->header_size = sizeof(struct virtio_net_hdr);
 		vp->rx_header_size = sizeof(struct virtio_net_hdr);
-		vp->dev->features |= NETIF_F_HW_CSUM; /* TSO does not work on RAW */
-		printk(KERN_INFO "raw: using vnet headers to offload checksum");
+		vp->dev->hw_features |= (NETIF_F_GRO); /* TSO does not work on RAW */
+		vp->dev->features |= (NETIF_F_RXCSUM | NETIF_F_HW_CSUM | NETIF_F_GRO);
+		printk(KERN_INFO "raw: using vnet headers for tso and tx/rx checksum");
 	}
 	return 0;
 }
@@ -402,7 +402,10 @@ static int build_tap_transport_data(struct vector_private *vp)
 		vp->verify_header = &raw_verify_header;
 		vp->header_size = sizeof(struct virtio_net_hdr);
 		vp->rx_header_size = sizeof(struct virtio_net_hdr);
-		vp->dev->features |= (NETIF_F_HW_CSUM | NETIF_F_TSO);
+		vp->dev->hw_features |= (NETIF_F_TSO | NETIF_F_GSO | NETIF_F_GRO);
+		vp->dev->features |=
+			(NETIF_F_RXCSUM | NETIF_F_HW_CSUM |
+				NETIF_F_TSO | NETIF_F_GSO | NETIF_F_GRO_BIT);
 		printk(KERN_INFO "tap/raw: using vnet headers for tso and tx/rx checksum");
 	} else {
 		return 0; /* do not try to enable tap too if raw failed */
diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 9210bf2db569..259c3c639eab 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -115,7 +115,7 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 	struct ifreq ifr;
 	int fd = -1;
 	struct sockaddr_ll sock;
-	int err = -ENOMEM;
+	int err = -ENOMEM, offload;
 	char *iface;
 	struct vector_fds *result = NULL;
 
@@ -153,6 +153,9 @@ static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 		goto tap_cleanup;
 	}
 
+	offload = TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6;
+	ioctl(fd, TUNSETOFFLOAD, offload);
+
 	/* RAW */
 
 	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

