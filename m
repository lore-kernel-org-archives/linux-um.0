Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XNGxC-0006mV-MF
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2014 07:50:38 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XNGxA-0006lQ-5A
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2014 07:50:38 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Fri, 29 Aug 2014 08:05:10 +0100
Message-Id: <1409295915-130538-5-git-send-email-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <1409295915-130538-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
References: <1409295915-130538-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
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
Subject: [uml-devel] [PATCH 05/10] GRE transport for UML
To: user-mode-linux-devel@lists.sourceforge.net

From: Anton Ivanov <antivano@cisco.com>

This transport allows a UML to connect to another UML local
or remote, the Linux host or any other network device running
the industry standard Ethernet over GRE protocol. The transport
supports all features of RFC 2784.

The transport supports a common set of features with the kernel
implementation. Checksum offload is supported on RX, TODO on TX.

Additionally, the transport supports the so called "soft"
termination where it can listen for an incoming connection
which does not require the remote endpoint to be specified
at configuration time.

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---
 arch/um/Kconfig.net            |   11 +
 arch/um/drivers/Makefile       |    2 +
 arch/um/drivers/uml_gre.h      |   85 ++++++++
 arch/um/drivers/uml_gre_kern.c |  446 ++++++++++++++++++++++++++++++++++++++++
 arch/um/drivers/uml_gre_user.c |  355 ++++++++++++++++++++++++++++++++
 5 files changed, 899 insertions(+)
 create mode 100644 arch/um/drivers/uml_gre.h
 create mode 100644 arch/um/drivers/uml_gre_kern.c
 create mode 100644 arch/um/drivers/uml_gre_user.c

diff --git a/arch/um/Kconfig.net b/arch/um/Kconfig.net
index 9a98aa5..7c8ba68 100644
--- a/arch/um/Kconfig.net
+++ b/arch/um/Kconfig.net
@@ -94,6 +94,17 @@ config UML_NET_L2TPV3
         the industry standard Ethernet over L2TPv3 protocol as described in
         the applicable RFCs
 
+config UML_NET_GRE
+	bool "GRE transport"
+	depends on UML_NET
+	help
+        This User-Mode Linux network transport allows one or more running
+        UMLs on single or multiple hosts to communicate with each other,
+        the host as well as other remote or local network devices supporting
+        the industry standard Ethernet over GRE protocol as described in
+        the applicable RFCs. The driver supports Soft GRE (wait for connect)
+        as used in Cable systems, etc.
+
 config UML_NET_DAEMON
 	bool "Daemon transport"
 	depends on UML_NET
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index f54c279..66127ee 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -10,6 +10,7 @@ slip-objs := slip_kern.o slip_user.o
 slirp-objs := slirp_kern.o slirp_user.o
 daemon-objs := daemon_kern.o daemon_user.o
 uml_l2tpv3-objs := uml_l2tpv3_kern.o uml_l2tpv3_user.o
+uml_gre-objs := uml_gre_kern.o uml_gre_user.o
 umcast-objs := umcast_kern.o umcast_user.o
 net-objs := net_kern.o net_user.o net_extra_user.o net_extra_kern.o
 mconsole-objs := mconsole_kern.o mconsole_user.o
@@ -45,6 +46,7 @@ obj-$(CONFIG_UML_NET_SLIP) += slip.o slip_common.o
 obj-$(CONFIG_UML_NET_SLIRP) += slirp.o slip_common.o
 obj-$(CONFIG_UML_NET_DAEMON) += daemon.o 
 obj-$(CONFIG_UML_NET_L2TPV3) += uml_l2tpv3.o 
+obj-$(CONFIG_UML_NET_GRE) += uml_gre.o 
 obj-$(CONFIG_UML_NET_VDE) += vde.o
 obj-$(CONFIG_UML_NET_MCAST) += umcast.o
 obj-$(CONFIG_UML_NET_PCAP) += pcap.o
diff --git a/arch/um/drivers/uml_gre.h b/arch/um/drivers/uml_gre.h
new file mode 100644
index 0000000..353306a
--- /dev/null
+++ b/arch/um/drivers/uml_gre.h
@@ -0,0 +1,85 @@
+/*
+ * Copyright (C) 2012 - 2014 Cisco Systems
+ * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __UML_GRE_H__
+#define __UML_GRE_H__
+
+#include "net_user.h"
+
+
+#define GRE_MODE_CHECKSUM     8 	          /* checksum - todo*/
+#define GRE_MODE_RESERVED     4 		  /* unused */
+#define GRE_MODE_KEY	      2		  /* KEY present */
+#define GRE_MODE_SEQUENCE     1	  /* no sequence */
+
+#define GRE_MODE_IP_VERSION   16	  /* on for v6, off for v4 */
+
+
+/* legacy modes */
+
+
+#define MAX_GRE_HEADER 16
+
+
+struct uml_gre_data {
+        void *remote_addr;
+        int  remote_addr_size;
+        char *remote_addr_string;
+        char *local_addr_string;
+        char *rx_key_string;
+        char *tx_key_string;
+        uint32_t rx_key;
+        uint32_t tx_key;
+        uint8_t *network_buffer;
+	int fd;
+	void *dev;
+        uint32_t mode; /* listening, sending, etc */
+        uint32_t sequence;
+   
+	/*  Precomputed offsets */
+	 
+        uint32_t offset;   /* main offset == header offset */
+        uint32_t protocol_offset;
+        uint32_t checksum_offset;
+        uint32_t key_offset;
+        uint32_t sequence_offset;
+
+	void ** skb_recv_vector;
+	void * mmsg_recv_vector;
+
+	void ** skb_send_vector;
+	void * mmsg_send_vector;
+
+	uint32_t vector_len;
+	uint32_t recv_index;
+	uint32_t recv_enqueued;
+	/* normally same as offset, add size of struct ipv4 header in ipv4 raw - API stupiditities */
+	uint32_t header_size; 
+
+	void * send_queue_info;
+
+};
+
+struct gre_minimal_header {
+   uint16_t header;
+   uint16_t arptype;
+};
+
+
+extern const struct net_user_info uml_gre_user_info;
+
+
+extern int uml_gre_user_sendmsg(int fd, void *header, int headerlen, void *data, int datalen, struct uml_gre_data *pri);
+
+extern int uml_gre_user_recvmsg(int fd, void *header, int headerlen, void *data, int datalen, struct uml_gre_data *pri);
+
+
+extern void gre_complete_init(void * dev_id, int max_depth);
+extern void gre_kern_destroy(struct uml_gre_data *pri);
+
+
+
+#endif
diff --git a/arch/um/drivers/uml_gre_kern.c b/arch/um/drivers/uml_gre_kern.c
new file mode 100644
index 0000000..5956db7
--- /dev/null
+++ b/arch/um/drivers/uml_gre_kern.c
@@ -0,0 +1,446 @@
+/*
+ * Copyright (C) 2012 - 2014 Cisco Systems
+ * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
+ * James Leu (jleu@mindspring.net).
+ * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Copyright (C) 2001 by various other people who didn't put their name here.
+ * Licensed under the GPL.
+ */
+
+#include "linux/init.h"
+#include <linux/netdevice.h>
+#include <linux/ethtool.h>
+#include <linux/ip.h>
+#include "net_kern.h"
+#include "uml_gre.h"
+
+#define DRIVER_NAME "uml-gre"
+
+#define GRE_IRB htons(0x6558)
+#define ETHER_HEADER_SIZE 14 
+
+struct uml_gre_init {
+	char *local_addr_string;
+	char *remote_addr_string;
+	char *rx_key_string;
+	char *tx_key_string;
+	char *mode_string;
+};
+
+static void uml_gre_get_drvinfo(struct net_device *dev,
+				struct ethtool_drvinfo *info)
+{
+	strcpy(info->driver, DRIVER_NAME);
+	strcpy(info->version, "42");
+}
+
+
+
+static const struct ethtool_ops uml_gre_ethtool_ops = 
+{
+	.get_drvinfo			= uml_gre_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+};
+
+
+
+static void uml_gre_init(struct net_device *dev, void *data)
+{
+	struct uml_net_private *pri;
+	struct uml_gre_data *dpri;
+	struct uml_gre_init *init = data;
+
+	pri = netdev_priv(dev);
+	dpri = (struct uml_gre_data *) pri->user;
+
+		/* 
+		these are as is, we keep them for future reference
+		and parse them in userspace
+
+	*/
+
+	dpri->local_addr_string = init->local_addr_string;
+	dpri->remote_addr_string = init->remote_addr_string;
+	dpri->rx_key_string = init->rx_key_string;
+	dpri->tx_key_string = init->tx_key_string;
+
+	if (init->mode_string != NULL) {
+	   sscanf(init->mode_string, "%x", &dpri->mode);
+	} else {
+	   dpri->mode = 0;
+	}
+	dpri->fd = -1;
+	dpri->dev = dev;
+	printk("gre backend - %s<->%s, rx_key: %s tx_key: %s, mode %i\n",  
+		dpri->local_addr_string, 
+		dpri->remote_addr_string, 
+		dpri->rx_key_string, 
+		dpri->tx_key_string,
+		dpri->mode
+		);
+	SET_ETHTOOL_OPS(dev, &uml_gre_ethtool_ops);
+}
+
+static int uml_gre_verify_header(uint8_t *header_buffer, 
+		struct sk_buff *skb, 
+		struct uml_gre_data *dpri)
+{
+	struct gre_minimal_header * header;
+	uint16_t old_checksum;
+       	uint32_t data_sum;
+       	uint32_t and_ether_sum;
+
+	/* this is never called with a NULL SKB, the SKB must be trimmed
+	   to correct size prior to calling */
+
+	if (!(dpri->mode & GRE_MODE_IP_VERSION)) {
+		header_buffer += sizeof(struct iphdr) /* fix for ipv4 raw */;
+	} 
+	
+	header = (struct gre_minimal_header *) header_buffer;
+	      
+      	if (
+		(header->header == htons((dpri->mode & 0xF) << 12)) && 
+		(header->arptype == GRE_IRB)
+	   ) {
+	 	/* header bits and type match, check key if present */
+		if (dpri->mode &  GRE_MODE_KEY) {
+			if (*((uint32_t *)(header_buffer + dpri->key_offset)) != dpri->rx_key) {
+				/* key mismatch, drop frame */ 
+				skb->dev->stats.rx_dropped++;
+				return 0;
+			}
+		}
+		/* 
+		 We compute the checksum if there is GRE checksum 
+		 and supply it to the kernel as "checksum offload" in a
+		 CHECKSUM_COMPLETE form so it can be used for any protocol 
+		 */
+
+		if (dpri->mode & GRE_MODE_CHECKSUM) {
+			old_checksum = 	* ((uint16_t *) (header_buffer + dpri->checksum_offset));
+			* ((uint32_t *) (header_buffer + dpri->checksum_offset)) = 0;
+
+			/* this will break with VLAN tags */
+
+			data_sum = csum_partial(skb->data + ETHER_HEADER_SIZE, skb->len - ETHER_HEADER_SIZE, 0); 
+			and_ether_sum = csum_partial(skb->data, ETHER_HEADER_SIZE, data_sum);
+
+			if (old_checksum !=  csum_fold(csum_partial(header_buffer, dpri->offset, and_ether_sum))) {
+				skb->dev->stats.rx_dropped++;
+				return 0;
+			} else {
+				skb->csum=data_sum;
+				skb->ip_summed = CHECKSUM_COMPLETE;
+			}
+		}
+		return 1;
+	} else {
+		skb->dev->stats.rx_dropped++;
+	}
+	return 0;
+}
+
+static struct sk_buff * uml_gre_multiread (struct uml_net_private * lp) {
+	struct uml_gre_data *dpri = (struct uml_gre_data *) &lp->user;
+	void ** skb_recv_vector = dpri->skb_recv_vector;
+	struct mmsghdr * mmsg_recv_vector = (struct mmsghdr *) dpri->mmsg_recv_vector;
+	struct sk_buff * result;
+	struct iovec * iov;
+	int ret;
+	
+	
+	/* Are we done processing the enqueued buffers */
+
+
+	if (dpri->recv_index >= dpri->recv_enqueued) {
+		ret = net_recvmmsg(
+			dpri->fd, mmsg_recv_vector, dpri->vector_len, 0,NULL);
+		if (ret >= 0) {
+			dpri->recv_enqueued = ret;
+		} else {
+			printk("Error in multi-packet receive %d\n", ret);
+			return NULL;
+		}
+		dpri->recv_index = 0;
+	}
+
+	/* check if we are done processing the enqueued buffers */
+
+	skb_recv_vector += dpri->recv_index;
+	mmsg_recv_vector += dpri->recv_index;
+	while (dpri->recv_index < dpri->recv_enqueued) {
+		dpri->recv_index ++;
+		iov = mmsg_recv_vector->msg_hdr.msg_iov;
+		if (
+			(iov) &&
+			(mmsg_recv_vector->msg_len > dpri->header_size) && 
+			(uml_gre_verify_header(iov->iov_base, result, dpri))
+		) {
+			if (!dpri->remote_addr) {
+				if (mmsg_recv_vector->msg_hdr.msg_name) {
+					dpri->remote_addr = mmsg_recv_vector->msg_hdr.msg_name;
+					dpri->remote_addr_size = 
+						mmsg_recv_vector->msg_hdr.msg_namelen;
+					mmsg_recv_vector->msg_hdr.msg_namelen =  sizeof (struct sockaddr_storage);
+				}
+			}
+			result = (struct sk_buff *)(* skb_recv_vector);
+			if (result) {
+				skb_trim(result, mmsg_recv_vector->msg_len - dpri->header_size);
+				result->protocol = (*lp->protocol)(result);
+				/* replace the buffer we just (ab)used */
+				(* skb_recv_vector) = uml_net_build_skb(lp->dev);
+				add_skbuffs(mmsg_recv_vector, skb_recv_vector, 1, lp->max_packet, 1);
+				return result;
+			} else {
+				printk("encountered failed atomic allocation @%i, skipping to next\n", dpri->recv_index);
+			}
+		} else {
+			if (mmsg_recv_vector->msg_hdr.msg_name) {
+				/* reset size */
+				mmsg_recv_vector->msg_hdr.msg_namelen =
+					sizeof (struct sockaddr_storage);
+			}
+			result = NULL;
+		}
+		skb_recv_vector ++;
+		mmsg_recv_vector ++;
+	}
+	return result;
+}
+
+static int uml_gre_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
+{
+	int result;
+	struct uml_gre_data *dpri = (struct uml_gre_data *) &lp->user;
+	uint8_t  *buffer ;
+
+
+	int offset = dpri->offset;
+	
+	buffer = dpri->network_buffer;
+
+	if (dpri->mode & GRE_MODE_IP_VERSION)
+	{
+		/* IPv4 RAW mode: Account for the IP header that will be received */
+		offset += sizeof(struct iphdr);
+	}
+
+	result = uml_gre_user_recvmsg(
+			fd, 
+			buffer, offset,
+			skb->data, skb->dev->mtu + ETH_HEADER_OTHER,
+			dpri
+		);
+	if (result <= 0) {
+		return result;
+	} 
+	if (!(dpri->mode & GRE_MODE_IP_VERSION)) {
+	/* IPv4 RAW mode: Ignore the IP header */
+		buffer += sizeof(struct iphdr);
+	}
+
+	if ((result > offset) && (uml_gre_verify_header(buffer, skb, dpri))) {
+		return result - offset;
+	} else {
+		return 0;
+	}
+}
+
+static void uml_gre_form_header(uint8_t * header_buffer, 
+		struct sk_buff* skb, 
+		struct uml_gre_data *pri) 
+{
+	struct gre_minimal_header *header;
+
+	__wsum partial_sum;
+
+	if (!header_buffer) {
+		return;
+	}	
+
+	header = (struct gre_minimal_header *) header_buffer;
+
+	header->header = htons((pri->mode & 0xF)<<12); 
+	header->arptype = GRE_IRB; 
+
+	if (pri->mode & GRE_MODE_SEQUENCE) {
+		* ((uint32_t *)(header_buffer + pri->sequence_offset)) = htonl(++pri->sequence);
+	}
+
+	if (pri->mode & GRE_MODE_KEY) {
+		* ((uint32_t *)(header_buffer + pri->key_offset)) = pri->tx_key; /* we will keep 'em htonled */
+	}
+
+	/* TODO: The methodology here should be:
+	   	1. Report the driver as NETIF_F_HW_CSUM
+		2. We will get a start csum and an end csum and where to put it
+		3. Compute the csum, stash it
+		4. Write where we are told
+		5. Determine what else do we need to csum on either side of the HW_CSUM instructions
+		6. Adjust for the fact that we may have modified the packet as part of csum computation
+		7. Store the newly computed gre csum
+		
+		In the meantime we are just doing brute force on xmit
+	*/
+
+	if (pri->mode & GRE_MODE_CHECKSUM) {
+		* ((uint32_t *) (header_buffer + pri->checksum_offset)) = 0;
+		partial_sum = csum_partial(skb->data,skb->len, 0);
+ 		partial_sum = csum_partial(header_buffer, pri->offset, partial_sum);
+		* ((uint16_t *) (header_buffer + pri->checksum_offset)) 
+			=  csum_fold(partial_sum);
+	}
+}
+
+
+void gre_complete_init(void * dev_id, int max_depth) {
+
+	struct net_device *dev = dev_id;
+	struct uml_net_private *lp = netdev_priv(dev);
+	struct uml_gre_data *pri = (struct uml_gre_data *) &lp->user;
+	struct mmsg_queue_info * queue_info ; 
+
+	queue_info =  
+		kmalloc(sizeof(struct mmsg_queue_info), GFP_KERNEL);
+	if (queue_info) {
+		queue_info->fd = pri->fd;
+		queue_info->mmsg_send_vector = pri->mmsg_send_vector;
+		queue_info->skb_send_vector = pri->skb_send_vector;
+		queue_info->head = 0;
+		queue_info->tail = 0;
+		queue_info->queue_depth = 0;
+		queue_info->max_depth = max_depth;
+		spin_lock_init(&queue_info->head_lock); 
+		spin_lock_init(&queue_info->tail_lock); 
+	}
+	pri->send_queue_info = queue_info;
+}
+
+void gre_kern_destroy(struct uml_gre_data *pri) {
+
+	int ret = -1;
+	struct mmsg_queue_info * queue_info = pri->send_queue_info;
+	/* flush queue */
+	do {
+		ret = uml_net_flush_mmsg_queue(queue_info, -1);
+	} while (ret != 0);
+	pri->send_queue_info = NULL;
+	kfree(queue_info);
+}
+
+static int uml_gre_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
+{
+	struct uml_gre_data *pri = (struct uml_gre_data *) &lp->user;
+	int result, queue_depth;
+	struct mmsghdr * mmsg_send_vector;
+	struct iovec * iov;
+	struct mmsg_queue_info * send_queue_info; 
+	struct sk_buff * mmsg_clone;
+	void ** skb_send_vector;
+	
+	send_queue_info = (struct mmsg_queue_info *) pri->send_queue_info;
+
+	spin_lock(&send_queue_info->tail_lock);
+
+	spin_lock(&send_queue_info->head_lock);
+	queue_depth = send_queue_info->queue_depth;
+	spin_unlock(&send_queue_info->head_lock);
+	
+	if (pri->remote_addr && (queue_depth < send_queue_info->max_depth)) {
+		mmsg_clone = skb_clone(skb, GFP_ATOMIC);
+		if (mmsg_clone) {
+
+			skb_send_vector = pri->skb_send_vector;
+			skb_send_vector +=  send_queue_info->tail;
+			(* skb_send_vector) = mmsg_clone;
+
+			mmsg_send_vector = pri->mmsg_send_vector;
+			mmsg_send_vector += send_queue_info->tail;
+			mmsg_send_vector->msg_hdr.msg_name = pri->remote_addr;
+			mmsg_send_vector->msg_hdr.msg_namelen = pri->remote_addr_size;
+
+			iov = mmsg_send_vector->msg_hdr.msg_iov;
+
+			if (iov) {
+
+				uml_gre_form_header(iov->iov_base, skb, pri);
+				
+				iov++;
+				
+				iov->iov_base = skb->data;
+				iov->iov_len = skb->len;
+
+				queue_depth = uml_net_advance_tail(send_queue_info, 1);
+			} else {
+				printk("no iov, cannot enqueue\n");
+			}
+		} else {
+			printk("cloning failed\n");
+		}
+	} 
+		
+	spin_unlock(&send_queue_info->tail_lock);
+
+	if (queue_depth > 0) {
+		result = uml_net_flush_mmsg_queue(
+			send_queue_info, queue_depth
+		); 
+	} 
+	return skb->len; /* not particularly correct */
+}
+
+static const struct net_kern_info uml_gre_kern_info = {
+	.options		= UML_NET_USE_SKB_READ,
+	.init			= uml_gre_init,
+	.protocol		= eth_protocol,
+	.read			= uml_gre_read,
+	.skb_read		= uml_gre_multiread,
+	.write			= uml_gre_write,
+};
+
+static int uml_gre_setup(char *str, char **mac_out, void *data)
+{
+	struct uml_gre_init *init = data;
+	char *remain;
+
+	*init = (
+		(struct uml_gre_init)
+		   { 
+			 .local_addr_string = "::1",
+			 .mode_string = "0",
+		   }
+			);
+
+	remain = split_if_spec(str, 
+			mac_out, 
+			&init->local_addr_string, 
+			&init->remote_addr_string, 
+			&init->rx_key_string, 
+			&init->tx_key_string, 
+			&init->mode_string, 
+			NULL
+		);
+	if (remain != NULL)
+		printk(KERN_WARNING " Strange interface spec \n");
+	return 1;
+}
+
+static struct transport uml_gre_transport = {
+	.list 		= LIST_HEAD_INIT(uml_gre_transport.list),
+	.name 		= "gre",
+	.setup  	= uml_gre_setup,
+	.user 		= &uml_gre_user_info,
+	.kern 		= &uml_gre_kern_info,
+	.private_size 	= sizeof(struct uml_gre_data),
+	.setup_size 	= sizeof(struct uml_gre_init),
+};
+
+static int register_uml_gre(void)
+{
+	register_transport(&uml_gre_transport);
+	return 0;
+}
+
+late_initcall(register_uml_gre);
diff --git a/arch/um/drivers/uml_gre_user.c b/arch/um/drivers/uml_gre_user.c
new file mode 100644
index 0000000..ec4dd72
--- /dev/null
+++ b/arch/um/drivers/uml_gre_user.c
@@ -0,0 +1,355 @@
+/*
+ * Copyright (C) 2012-2014 Cisco Systems
+ * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
+ * James Leu (jleu@mindspring.net).
+ * Copyright (C) 2001 by various other people who didn't put their name here.
+ * Licensed under the GPL.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <net/if.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netdb.h>
+#include <net/ethernet.h>
+#include <netinet/ip.h>
+#include <netinet/ether.h>
+#include <linux/if_ether.h>
+#include <linux/if_packet.h>
+#include <arpa/inet.h>
+
+#include "uml_gre.h"
+#include "net_user.h"
+#include "os.h"
+#include "um_malloc.h"
+#include "user.h"
+
+#define VECTOR_SIZE 32
+#define PROTO_GRE 47
+
+static int gre_parse_key(char *src , void * dst) {
+	if ((src == NULL) || (sscanf(src, "%x", (unsigned int *) dst) != 1)) { 
+		printk(UM_KERN_ERR "cannot parse key!!!: %s\n", src);
+		return -1;
+	} 
+	* (( uint32_t *) dst) = htonl(* ((uint32_t* )dst));
+	return 0;
+}
+
+static void uml_gre_remove(void *data)
+{
+	struct uml_gre_data *pri = data;
+
+	gre_kern_destroy(pri); 
+	if (pri->fd > 0) {
+		close(pri->fd);
+	}
+	pri->fd = -1;
+	if (pri->skb_send_vector) {
+		/* this one should be empty - we flushed it so we just free it */
+		kfree(pri->skb_send_vector);
+		pri->skb_send_vector = NULL;
+	}
+	if (pri->mmsg_send_vector) {
+		destroy_mmsg_vector(pri->mmsg_send_vector, VECTOR_SIZE, 1);
+		pri->mmsg_send_vector = NULL;
+	}
+	if (pri->skb_recv_vector) {
+		destroy_skb_vector(pri->skb_recv_vector, VECTOR_SIZE);
+		pri->skb_recv_vector = NULL; 
+	}
+	if (pri->mmsg_recv_vector) {
+		destroy_mmsg_vector(pri->mmsg_recv_vector, VECTOR_SIZE, 1);
+		pri->mmsg_recv_vector = NULL; 
+	}
+	if (pri->network_buffer) {
+		kfree(pri->network_buffer);
+		pri->network_buffer = NULL; 
+	}
+}
+
+static int uml_gre_user_init(void *data, void *dev)
+{
+	struct uml_gre_data *pri = data;
+	int fd;
+
+	int sock_family;
+	int ret;
+	struct addrinfo hints;
+	struct addrinfo *result;
+	char service[NI_MAXSERV];
+	  
+	/* 
+	 
+	This may look ugly, but there is no way about it
+	  UML DIY threading is incompatible with getaddrinfo
+	  so all resolution has to be done using legacy functions
+	
+	  */
+	
+	struct mmsghdr * mmsghdr;
+
+	printk(UM_KERN_INFO "gre user init mode %i\n", pri->mode);
+
+	pri->offset = sizeof(struct gre_minimal_header);
+	pri->checksum_offset = pri->offset;
+	pri->key_offset = pri->offset;
+	pri->sequence_offset = pri->offset;
+
+	pri->fd = -1;
+
+	if (pri->mode & GRE_MODE_CHECKSUM) {
+		pri->offset += 4;
+		pri->key_offset += 4;
+		pri->sequence_offset += 4;
+	}
+
+	if (pri->mode & GRE_MODE_KEY) {
+		pri->offset += 4;
+		pri->sequence_offset +=4;
+		pri->tx_key = 0;
+		pri->rx_key = 0;
+		if (gre_parse_key(pri->tx_key_string,&pri->tx_key) !=0) {
+			return -1;
+		}
+		if (gre_parse_key(pri->rx_key_string,&pri->rx_key) !=0) {
+			return -1;
+		}
+	}
+
+	if (pri->mode & GRE_MODE_SEQUENCE) {
+		pri->offset += 4;
+	}
+
+	/* basic variable parsing */
+	
+	if (pri->remote_addr_string) {		
+		/* we now allocate it only if it we are not "listening" */
+		pri->remote_addr = uml_kmalloc(sizeof(struct sockaddr_storage), UM_GFP_KERNEL);
+	} else {
+		pri->remote_addr = NULL;
+	}
+
+	if (pri->mode & GRE_MODE_IP_VERSION) {
+		/* IPv6 */
+		sock_family = AF_INET6;
+	} else {
+		/* IPv4 */
+		sock_family = AF_INET;
+	}
+
+	printk(UM_KERN_ERR "uml_gre_user_init: preparing raw socket for mode %x\n ", pri->mode);
+
+	memset(&hints, 0, sizeof(hints));
+
+	hints.ai_flags = AI_PASSIVE;
+	hints.ai_family = sock_family;
+	hints.ai_socktype = SOCK_RAW;
+	hints.ai_protocol = PROTO_GRE;
+	
+	if ((fd = socket(hints.ai_family, hints.ai_socktype, hints.ai_protocol)) == -1) {
+		fd = -errno;
+		printk(UM_KERN_ERR "uml_gre_user_init: socket creation failed, "
+		 "errno = %d\n", -fd);
+		return fd;
+	}
+
+	pri->fd = fd;
+
+	memset(service, '\0', NI_MAXSERV);
+	ret = getaddrinfo(pri->local_addr_string, service, &hints, &result);
+	if ((ret != 0) || (result == NULL)) {
+		printk(UM_KERN_ERR "uml_gre_user_init: Unable to parse the local endpoint: %d\n", ret);
+		uml_gre_remove(pri);
+		return -1;
+	}
+	if (bind(fd, (struct sockaddr *)result->ai_addr, result->ai_addrlen)) {
+		printk("uml_gre_user_init:  could not bind socket: %d\n", errno);
+		freeaddrinfo(result);
+		uml_gre_remove(pri);
+		return -1;
+	}
+
+	printk("uml_gre_user_init: socket bound\n");
+	freeaddrinfo(result);
+
+	if (pri->remote_addr) {
+		memset(service, '\0', NI_MAXSERV);
+		memset(&hints, 0, sizeof(hints));
+
+		hints.ai_flags = AI_PASSIVE;
+		hints.ai_family = sock_family;
+		hints.ai_socktype = SOCK_RAW;
+		hints.ai_protocol = PROTO_GRE;
+
+		ret = getaddrinfo(pri->remote_addr_string, service, &hints, &result);
+
+		if ((ret != 0) || (result == NULL)) {
+			printk(UM_KERN_ERR "uml_gre_user_init: Unable to parse the remote endpoint: %d\n", ret);
+			uml_gre_remove(pri);
+			return -1;
+		}
+
+		memset(pri->remote_addr, '\0' , sizeof(struct sockaddr_storage));
+		memcpy(pri->remote_addr, result->ai_addr, result->ai_addrlen);
+		pri->remote_addr_size = result->ai_addrlen;
+		freeaddrinfo(result);
+	}
+		
+	/* vector IO init */
+
+	pri->vector_len = VECTOR_SIZE;
+	pri->recv_index = 0;
+	pri->recv_enqueued = 0;
+	pri->header_size = pri->offset /* fix for ipv4 raw */;
+
+	if (!(pri->mode & GRE_MODE_IP_VERSION)){
+		pri->header_size += sizeof(struct iphdr) /* fix for ipv4 raw */;
+	}
+
+	pri->skb_recv_vector = build_skbuf_vector(VECTOR_SIZE, dev);
+	if (! pri->skb_recv_vector) {
+		uml_gre_remove(pri);
+		return -1;
+	}
+	pri->mmsg_recv_vector = build_mmsg_vector(VECTOR_SIZE, 2);
+	if (! pri->mmsg_recv_vector) {
+		uml_gre_remove(pri);
+		return -1;
+	}
+	add_header_buffers(pri->mmsg_recv_vector, VECTOR_SIZE, pri->header_size); 
+	add_skbuffs(
+		pri->mmsg_recv_vector, 
+		pri->skb_recv_vector, 
+		VECTOR_SIZE, ETH_MAX_PACKET + ETH_HEADER_OTHER, 
+		1
+	);
+
+	pri->skb_send_vector = uml_kmalloc(VECTOR_SIZE * sizeof(void *), UM_GFP_KERNEL);
+	if (pri->skb_send_vector) {
+		memset(pri->skb_send_vector, 0, sizeof(void *) * VECTOR_SIZE);
+	} else {
+		uml_gre_remove(pri);
+		return -1;
+	}
+	pri->mmsg_send_vector = build_mmsg_vector(VECTOR_SIZE, 2);
+	if (! pri->mmsg_send_vector) {
+		uml_gre_remove(pri);
+		return -1;
+	}
+	add_header_buffers(pri->mmsg_send_vector, VECTOR_SIZE, pri->offset); 
+
+
+	pri->network_buffer = uml_kmalloc(pri->header_size, UM_GFP_KERNEL); /* enough for any header, regardless how stupid */
+
+	if (!pri->network_buffer) {
+		printk("uml_gre_user_init: could not allocate buffer\n");
+		close(fd);
+		return -1;
+	}
+
+	if (!pri->remote_addr) {
+		mmsghdr = (struct mmsghdr *) pri->mmsg_recv_vector;
+		mmsghdr->msg_hdr.msg_name = uml_kmalloc(sizeof(struct sockaddr_storage), UM_GFP_KERNEL);
+		if (mmsghdr->msg_hdr.msg_name) {
+			mmsghdr->msg_hdr.msg_namelen = sizeof(struct sockaddr_storage);
+		} else {
+			printk("uml_gre_user_init: Failed to allocate remote address name\n");
+		}
+	}
+	 
+	pri->dev = dev;
+
+	gre_complete_init(dev, VECTOR_SIZE); /* we really need error checking here */
+
+	if (pri->fd < 0) {
+		return pri->fd;
+	}
+
+	printk("uml_gre_user_init: init complete, fd %i\n", fd);
+ 
+	return 0;
+}
+
+static int uml_gre_open(void *data)
+{
+	struct uml_gre_data *pri = data;
+	return pri->fd;
+}
+
+
+int uml_gre_user_sendmsg(int fd, 
+			void *header, int headerlen, void *data, 
+			int datalen, struct uml_gre_data *pri)
+{
+	struct msghdr message;
+	struct iovec vec[2];
+	vec[0].iov_base = header;
+	vec[0].iov_len = headerlen;
+	vec[1].iov_base = data;
+	vec[1].iov_len = datalen;
+
+
+	message.msg_name = pri->remote_addr;
+	message.msg_namelen = pri->remote_addr_size;
+	message.msg_iov = (struct iovec *) &vec;
+	message.msg_iovlen = 2;
+	message.msg_control = NULL;
+	message.msg_controllen = 0;
+	message.msg_flags = MSG_DONTWAIT;
+
+
+	if (pri->remote_addr != NULL) {
+		return net_sendmessage(fd, &message, MSG_DONTWAIT);
+	} else {
+		return -1;
+	}
+}
+int uml_gre_user_recvmsg(int fd, void *header, int headerlen, void *data, int datalen, struct uml_gre_data *pri)
+{
+	struct msghdr message;
+	struct iovec vec[2];
+	vec[0].iov_base = header;
+	vec[0].iov_len = headerlen;
+	vec[1].iov_base = data;
+	vec[1].iov_len = datalen;
+
+	if (!pri->remote_addr) {
+		pri->remote_addr = uml_kmalloc(sizeof(struct sockaddr_storage), UM_GFP_KERNEL);
+		if (pri->remote_addr) {
+			message.msg_name = pri->remote_addr;
+			message.msg_namelen = pri->remote_addr_size;
+		} else {
+			message.msg_name = NULL;
+			message.msg_namelen = 0;
+		}
+	} else {
+			message.msg_name = NULL;
+			message.msg_namelen = 0;
+	}
+	
+	message.msg_iov = (struct iovec *) &vec;
+	message.msg_iovlen = 2;
+	message.msg_control = NULL;
+	message.msg_controllen = 0;
+	message.msg_flags = MSG_DONTWAIT;
+
+	return net_recvmessage(fd, &message, MSG_DONTWAIT);
+}
+const struct net_user_info uml_gre_user_info = {
+	.init		= uml_gre_user_init,
+	.open		= uml_gre_open,
+	.close	 	= NULL,
+	.remove	 	= uml_gre_remove,
+	.add_address	= NULL,
+	.delete_address = NULL,
+	.mtu		= ETH_MAX_PACKET,
+	.max_packet	= ETH_MAX_PACKET + ETH_HEADER_OTHER + MAX_GRE_HEADER,
+};
-- 
1.7.10.4


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

