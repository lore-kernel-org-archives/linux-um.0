Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XNGxy-0007qF-Q5
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2014 07:51:26 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XNGxw-0002YM-Hx
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2014 07:51:26 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Fri, 29 Aug 2014 08:05:09 +0100
Message-Id: <1409295915-130538-4-git-send-email-anton.ivanov@kot-begemot.co.uk>
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
Subject: [uml-devel] [PATCH 04/10] L2TPv3 Transport Driver for UML
To: user-mode-linux-devel@lists.sourceforge.net

From: Anton Ivanov <antivano@cisco.com>

This transport allows a UML to connect to another UML local
or remote, the Linux host or any other network device running
the industry standard Ethernet over L2TPv3 protocol as per
RFC 3931 (and successors).

The transport supports a common set of features with the kernel
implementation as well as the Cisco contributed L2TPv3 transport
for QEMU/KVM. In all cases this is static tunnels only, no L2TPv3
control plane.

Additionally, the transport supports the so called "soft"
termination where it can listen for an incoming connection
which does not require the remote endpoint to be specified
at configuration time.

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---
 arch/um/Kconfig.net               |   10 +
 arch/um/drivers/Makefile          |    2 +
 arch/um/drivers/uml_l2tpv3.h      |  121 ++++++++++
 arch/um/drivers/uml_l2tpv3_kern.c |  442 +++++++++++++++++++++++++++++++++++++
 arch/um/drivers/uml_l2tpv3_user.c |  420 +++++++++++++++++++++++++++++++++++
 5 files changed, 995 insertions(+)
 create mode 100644 arch/um/drivers/uml_l2tpv3.h
 create mode 100644 arch/um/drivers/uml_l2tpv3_kern.c
 create mode 100644 arch/um/drivers/uml_l2tpv3_user.c

diff --git a/arch/um/Kconfig.net b/arch/um/Kconfig.net
index 820a56f..9a98aa5 100644
--- a/arch/um/Kconfig.net
+++ b/arch/um/Kconfig.net
@@ -84,6 +84,16 @@ config UML_NET_SLIP
         UMLs on a single host).  You may choose more than one without
         conflict.  If you don't need UML networking, say N.
 
+config UML_NET_L2TPV3
+	bool "L2TPV3 transport"
+	depends on UML_NET
+	help
+        This User-Mode Linux network transport allows one or more running
+        UMLs on single or multiple hosts to communicate with each other,
+        the host as well as other remote or local network devices supporting
+        the industry standard Ethernet over L2TPv3 protocol as described in
+        the applicable RFCs
+
 config UML_NET_DAEMON
 	bool "Daemon transport"
 	depends on UML_NET
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 836baaf..f54c279 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -9,6 +9,7 @@
 slip-objs := slip_kern.o slip_user.o
 slirp-objs := slirp_kern.o slirp_user.o
 daemon-objs := daemon_kern.o daemon_user.o
+uml_l2tpv3-objs := uml_l2tpv3_kern.o uml_l2tpv3_user.o
 umcast-objs := umcast_kern.o umcast_user.o
 net-objs := net_kern.o net_user.o net_extra_user.o net_extra_kern.o
 mconsole-objs := mconsole_kern.o mconsole_user.o
@@ -43,6 +44,7 @@ obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
 obj-$(CONFIG_UML_NET_SLIP) += slip.o slip_common.o
 obj-$(CONFIG_UML_NET_SLIRP) += slirp.o slip_common.o
 obj-$(CONFIG_UML_NET_DAEMON) += daemon.o 
+obj-$(CONFIG_UML_NET_L2TPV3) += uml_l2tpv3.o 
 obj-$(CONFIG_UML_NET_VDE) += vde.o
 obj-$(CONFIG_UML_NET_MCAST) += umcast.o
 obj-$(CONFIG_UML_NET_PCAP) += pcap.o
diff --git a/arch/um/drivers/uml_l2tpv3.h b/arch/um/drivers/uml_l2tpv3.h
new file mode 100644
index 0000000..5137bc7
--- /dev/null
+++ b/arch/um/drivers/uml_l2tpv3.h
@@ -0,0 +1,121 @@
+/*
+ * Copyright (C) 2012 - 2014 Cisco Systems
+ * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __UML_L2TPV3_H__
+#define __UML_L2TPV3_H__
+
+#include "net_user.h"
+
+
+#define NEW_MODE_IP_VERSION   1		  /* on for v6, off for v4 */
+#define NEW_MODE_UDP	      2		  /* on for udp, off for raw ip */
+#define NEW_MODE_COOKIE	      4		  /* cookie present */
+#define NEW_MODE_COOKIE_SIZE  8		  /* on for 64 bit */
+#define NEW_MODE_NO_COUNTER   16	  /* DT - no counter */
+
+/* legacy modes */
+
+/* mode 0 */
+
+#define LEGACY_UDP6_64_NO_COUNTER (NEW_MODE_IP_VERSION + NEW_MODE_UDP + NEW_MODE_COOKIE + NEW_MODE_COOKIE_SIZE + NEW_MODE_NO_COUNTER)
+
+#define LEGACY_MODE0 LEGACY_UDP6_64_NO_COUNTER
+
+/* mode 1 */
+
+#define LEGACY_IP6_64_NO_COUNTER (NEW_MODE_IP_VERSION + NEW_MODE_COOKIE + NEW_MODE_COOKIE_SIZE + NEW_MODE_NO_COUNTER)
+
+#define LEGACY_MODE1 LEGACY_IP6_64_NO_COUNTER
+
+/* mode 2 */
+
+#define LEGACY_UDP4_64_COUNTER (NEW_MODE_COOKIE + NEW_MODE_UDP + NEW_MODE_COOKIE_SIZE )
+
+#define LEGACY_MODE2 LEGACY_UDP4_64_COUNTER
+
+/* mode 3 */
+
+#define LEGACY_IP4_64_COUNTER (NEW_MODE_COOKIE + NEW_MODE_COOKIE_SIZE)
+
+#define LEGACY_MODE3 LEGACY_IP4_64_COUNTER
+
+
+#define L2TPV3_HEADER 16
+
+
+struct temphtonl {
+   uint32_t low; 
+   uint32_t high;
+};
+
+
+struct uml_l2tpv3_data {
+	void *remote_addr;
+	int  remote_addr_size;
+	char *remote_addr_string;
+	char *local_addr_string;
+	char *local_service;
+	char *remote_service;
+	char *local_session_string;
+	char *remote_session_string;
+	uint32_t local_session;
+	uint32_t remote_session;
+	char *rx_cookie_string;
+	char *tx_cookie_string;
+	uint64_t rx_cookie;
+	uint64_t tx_cookie;
+
+	/* this should be ifdef-ed to be used only in single packet */
+	uint8_t *network_buffer;
+	
+
+	int fd;
+	void *dev;
+
+	uint32_t uml_l2tpv3_flags;
+	uint32_t mode;
+	uint32_t new_mode; /* listening, sending, etc */
+	uint32_t counter;
+   
+	/*  Precomputed offsets */
+	 
+	uint32_t offset;   /* main offset == header offset */
+	uint32_t cookie_offset;
+	uint32_t counter_offset;
+	uint32_t session_offset;
+
+	/* high speed vector io data */
+    
+	void ** skb_recv_vector;
+	void ** skb_send_vector;
+	void * mmsg_recv_vector;
+	void * mmsg_send_vector;
+
+	uint32_t vector_len;
+	uint32_t recv_index;
+	uint32_t recv_enqueued;
+
+	/* normally same as offset, add size of 
+	 * struct ipv4 header in ipv4 raw - API stupiditities
+	 */
+	uint32_t header_size; 
+	void * send_queue_info;
+};  
+
+
+extern const struct net_user_info uml_l2tpv3_user_info;
+
+extern int uml_l2tpv3_user_sendmsg(int fd, void *header, int headerlen, void *data, int datalen, struct uml_l2tpv3_data *pri);
+
+extern int uml_l2tpv3_user_recvmsg(int fd, void *header, int headerlen, void *data, int datalen, struct uml_l2tpv3_data *pri);
+
+extern void l2tpv3_complete_init(void * dev_id, int max_depth);
+extern void l2tpv3_kern_destroy(struct uml_l2tpv3_data *pri);
+
+#define UML_L2TPV3_FLAG_TX_CHECKSUMS		0x00000001
+#define UML_L2TPV3_FLAG_RX_CHECKSUMS		0x00000002
+
+#endif
diff --git a/arch/um/drivers/uml_l2tpv3_kern.c b/arch/um/drivers/uml_l2tpv3_kern.c
new file mode 100644
index 0000000..228ff22
--- /dev/null
+++ b/arch/um/drivers/uml_l2tpv3_kern.c
@@ -0,0 +1,442 @@
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
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <net_kern.h>
+#include <irq_kern.h>
+#include <irq_user.h>
+#include "uml_l2tpv3.h"
+
+#define DRIVER_NAME "uml-l2tpv3"
+
+struct uml_l2tpv3_init {
+	char *local_addr_string;
+	char *remote_addr_string;
+	char *local_service;
+	char *remote_service;
+	char *rx_cookie_string;
+	char *tx_cookie_string;
+	char *local_session_string;
+	char *remote_session_string;
+	char *mode_string;
+};
+
+static void uml_l2tpv3_get_drvinfo(struct net_device *dev,
+				struct ethtool_drvinfo *info)
+{
+	strcpy(info->driver, DRIVER_NAME);
+	strcpy(info->version, "42");
+}
+
+
+static const struct ethtool_ops uml_l2tpv3_ethtool_ops = 
+{
+	.get_drvinfo			= uml_l2tpv3_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+};
+
+static void uml_l2tpv3_init(struct net_device *dev, void *data)
+{
+	struct uml_net_private *pri;
+	struct uml_l2tpv3_data *dpri;
+	struct uml_l2tpv3_init *init = data;
+
+	pri = netdev_priv(dev);
+	dpri = (struct uml_l2tpv3_data *) pri->user;
+
+	/* 
+	 *	these are as is, we keep them for future reference
+	 *	and parse them in userspace
+	 */
+
+	dpri->local_addr_string = init->local_addr_string;
+	dpri->remote_addr_string = init->remote_addr_string;
+	dpri->local_service = init->local_service;
+	dpri->remote_service = init->remote_service;
+	dpri->rx_cookie_string = init->rx_cookie_string;
+	dpri->tx_cookie_string = init->tx_cookie_string;
+	dpri->local_session_string = init->local_session_string;
+	dpri->remote_session_string = init->remote_session_string;
+
+	/* the only ones we pre-parse */
+
+	if (init->mode_string != NULL) {
+		sscanf(init->mode_string, "%x", &dpri->new_mode);
+	} else {
+		dpri->new_mode = 0;
+		printk("warning: failed to parse l2tpv3 mode %s\n", init->mode_string);
+	}
+		
+	printk("l2tpv3 mode %x\n", dpri->new_mode);
+	dpri->fd = -1;
+	dpri->dev = dev;
+	printk("l2tpv3 backend - %s:%s<->%s:%s, rxcookie: %s, txcookie:%s, local_session: %s, peer_session: %s\n",  
+		dpri->local_addr_string, 
+		dpri->local_service, 
+		dpri->remote_addr_string, 
+		dpri->remote_service, 
+		dpri->rx_cookie_string, 
+		dpri->tx_cookie_string, 
+		dpri->local_session_string, 
+		dpri->remote_session_string
+	);
+	dpri->uml_l2tpv3_flags = 0; /* we have everything turned off initially */
+	SET_ETHTOOL_OPS(dev, &uml_l2tpv3_ethtool_ops);
+}
+
+static int uml_l2tpv3_verify_header(uint8_t * buffer, struct uml_l2tpv3_data *dpri )
+{
+	uint64_t *cookie64;
+	uint32_t *cookie32;
+	uint32_t *session_id;
+	
+
+	if ((!(dpri->new_mode & NEW_MODE_IP_VERSION)) && (!(dpri->new_mode & NEW_MODE_UDP))){
+		buffer += sizeof(struct iphdr) /* fix for ipv4 raw */;
+	} 
+	
+	session_id = (uint32_t *)(buffer + dpri->session_offset);
+	if (*session_id != dpri->remote_session) {
+		printk("Unknown Sesion id\n");
+		return 0; 
+	}
+
+	if (dpri->new_mode & NEW_MODE_COOKIE) {
+		if (dpri->new_mode & NEW_MODE_COOKIE_SIZE) {
+	  	/* 64 bit cookie */
+	  		cookie64 = (uint64_t *)(buffer + dpri->cookie_offset);
+			if (*cookie64 != dpri->rx_cookie) {
+		 		printk("unknown cookie id\n");
+		 		return 0; 
+	  		}
+	   	} else {
+	  		cookie32 = (uint32_t *)(buffer + dpri->cookie_offset);
+	  		if (*cookie32 != * (uint32_t *) &dpri->rx_cookie) {
+		 		printk("unknown cookie id\n");
+		 		return 0; 
+	  		}
+	   	}
+	}
+	return 1;
+}
+
+static struct sk_buff * uml_l2tpv3_multiread (struct uml_net_private * lp) {
+	struct uml_l2tpv3_data *dpri = (struct uml_l2tpv3_data *) &lp->user;
+	void ** skb_recv_vector = dpri->skb_recv_vector;
+	struct mmsghdr * mmsg_recv_vector = (struct mmsghdr *) dpri->mmsg_recv_vector;
+	struct sk_buff * result = NULL;
+	struct iovec * iov;
+	int ret;
+	
+	
+	/* Are we done processing the enqueued buffers */
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
+			(uml_l2tpv3_verify_header(iov->iov_base, dpri))
+		) {
+			if (!dpri->remote_addr) {
+				if (mmsg_recv_vector->msg_hdr.msg_name) {
+					dpri->remote_addr = 
+						mmsg_recv_vector->msg_hdr.msg_name;
+					dpri->remote_addr_size = 
+						mmsg_recv_vector->msg_hdr.msg_namelen;
+					mmsg_recv_vector->msg_hdr.msg_namelen =  
+						sizeof (struct sockaddr_storage);
+				}
+			}
+			result = (struct sk_buff *)(* skb_recv_vector);
+			if (result) {
+				skb_trim(result, mmsg_recv_vector->msg_len - dpri->header_size);
+
+				result->protocol = (*lp->protocol)(result);
+
+				/* replace the buffer we just (ab)used */
+
+				(* skb_recv_vector) = uml_net_build_skb(lp->dev);
+
+				add_skbuffs(mmsg_recv_vector, 
+						skb_recv_vector, 1, lp->max_packet, 1);
+				return result;
+			} else {
+				printk("encountered failed atomic allocation @%i, skipping to next\n", 
+                        dpri->recv_index);
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
+static int uml_l2tpv3_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
+{
+	int result;
+	struct uml_l2tpv3_data *dpri = (struct uml_l2tpv3_data *) &lp->user;
+	uint8_t  *buffer ;
+
+
+	int offset = dpri->offset;
+	
+	buffer = dpri->network_buffer;
+
+	if (!(dpri->new_mode & NEW_MODE_UDP) && !(dpri->new_mode & NEW_MODE_IP_VERSION))
+	{
+		/* IPv4 RAW mode: Account for the IP header that will be received */
+		offset += sizeof(struct iphdr);
+	}
+	 
+
+	result = uml_l2tpv3_user_recvmsg(
+			fd, 
+			buffer, offset,
+			skb->data, skb->dev->mtu + ETH_HEADER_OTHER,
+			dpri
+		);
+	if (result <= 0) {
+		return result;
+	} 
+	if (
+		!(dpri->new_mode & NEW_MODE_UDP) && 
+		!(dpri->new_mode & NEW_MODE_IP_VERSION)
+	) {
+	/* IPv4 RAW mode: Ignore the IP header */
+		buffer += sizeof(struct iphdr);
+	}
+
+	if ((result > offset) && (uml_l2tpv3_verify_header(buffer, dpri))) {
+		if ((dpri->uml_l2tpv3_flags & UML_L2TPV3_FLAG_RX_CHECKSUMS) != 0) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		}
+		return result - offset;
+	} else {
+		return 0;
+	}
+}
+
+static void uml_l2tpv3_form_header(uint8_t * buffer, struct uml_l2tpv3_data *pri) {
+	uint32_t *header;
+	uint32_t *session;
+	uint64_t *cookie64;
+	uint32_t *cookie32;
+	uint32_t *counter;
+	if (pri->new_mode & NEW_MODE_UDP) {
+		header = (uint32_t *) buffer;
+		* header = htonl(0x30000);
+	}
+	session = (uint32_t *) (buffer + pri->session_offset);
+	*session = pri->local_session;
+
+	if (pri->new_mode & NEW_MODE_COOKIE) {
+		if (pri->new_mode & NEW_MODE_COOKIE_SIZE) {
+		   cookie64 = (uint64_t *)(buffer + pri->cookie_offset);
+		   * cookie64 = pri->tx_cookie;
+		} else {
+		   cookie32 = (uint32_t *) (buffer + pri->cookie_offset);
+		   * cookie32 = * ((uint32_t *) &pri->tx_cookie);
+		}
+	}
+
+	if (!(pri->new_mode & NEW_MODE_NO_COUNTER)) {
+		counter = (uint32_t *)(buffer + pri->counter_offset);
+		* counter = htonl(++pri->counter);
+	}
+}
+
+void l2tpv3_complete_init(void * dev_id, int max_depth) {
+
+	struct net_device *dev = dev_id;
+	struct uml_net_private *lp = netdev_priv(dev);
+	struct uml_l2tpv3_data *pri = (struct uml_l2tpv3_data *) &lp->user;
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
+void l2tpv3_kern_destroy(struct uml_l2tpv3_data *pri) {
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
+static int uml_l2tpv3_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
+{
+	struct uml_l2tpv3_data *pri = (struct uml_l2tpv3_data *) &lp->user;
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
+				uml_l2tpv3_form_header(iov->iov_base, pri);
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
+static const struct net_kern_info uml_l2tpv3_kern_info = {
+	.options		= UML_NET_USE_SKB_READ,
+	.init			= uml_l2tpv3_init,
+	.protocol		= eth_protocol,
+	.read			= uml_l2tpv3_read,
+	.skb_read		= uml_l2tpv3_multiread,
+	.write			= uml_l2tpv3_write,
+};
+
+static int uml_l2tpv3_setup(char *str, char **mac_out, void *data)
+{
+	struct uml_l2tpv3_init *init = data;
+	char *remain;
+
+	*init = (
+		(struct uml_l2tpv3_init)
+		   { 
+			 .local_addr_string = "::1",
+			 .local_service = "1701",
+			 .remote_service = "1702",
+			 .rx_cookie_string = "0xdeadbeefdeadbeef",
+			 .tx_cookie_string = "0xdeadbeefdeadbeef",
+			 .local_session_string = "0xFFFFFFFF",
+			 .remote_session_string = "0xFFFFFFFF",
+			 .mode_string = "0",	
+		   }
+			);
+
+	remain = split_if_spec(str, 
+			mac_out, 
+			&init->local_addr_string, 
+			&init->local_service, 
+			&init->remote_addr_string, 
+			&init->remote_service, 
+			&init->rx_cookie_string, 
+			&init->tx_cookie_string, 
+			&init->local_session_string, 
+			&init->remote_session_string, 
+			&init->mode_string, 
+			NULL
+		);
+	if (remain != NULL)
+		printk(KERN_WARNING " Strange interface spec \n");
+	return 1;
+}
+
+static struct transport uml_l2tpv3_transport = {
+	.list 		= LIST_HEAD_INIT(uml_l2tpv3_transport.list),
+	.name 		= "l2tpv3",
+	.setup  	= uml_l2tpv3_setup,
+	.user 		= &uml_l2tpv3_user_info,
+	.kern 		= &uml_l2tpv3_kern_info,
+	.private_size 	= sizeof(struct uml_l2tpv3_data),
+	.setup_size 	= sizeof(struct uml_l2tpv3_init),
+};
+
+static int register_uml_l2tpv3(void)
+{
+	register_transport(&uml_l2tpv3_transport);
+	return 0;
+}
+
+late_initcall(register_uml_l2tpv3);
diff --git a/arch/um/drivers/uml_l2tpv3_user.c b/arch/um/drivers/uml_l2tpv3_user.c
new file mode 100644
index 0000000..5a68151
--- /dev/null
+++ b/arch/um/drivers/uml_l2tpv3_user.c
@@ -0,0 +1,420 @@
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
+#include <net_user.h>
+#include <os.h>
+#include <um_malloc.h>
+#include <user.h>
+#include "uml_l2tpv3.h"
+
+#define VECTOR_SIZE 128
+
+int l2tpv3_parse_cookie32(char *src , void * dst) 
+{
+	if (
+		(src == NULL) || 
+		(sscanf(src, "%x", (unsigned int *) dst) != 1)
+	) { 
+		printk(UM_KERN_ERR "cannot parse cookie!!!: %s\n", src);
+		return -1;
+	} 
+	* (( uint32_t *) dst) = htonl(* ((uint32_t* )dst));
+	return 0;
+}
+
+int l2tpv3_parse_cookie64(char *src , void * dst)
+{
+	struct temphtonl temph;
+	uint32_t temp;
+	const int num = 42;
+	if (
+		(src == NULL) || 
+		(sscanf(src, "%llx", (long unsigned int *) &temph) != 1)
+	) { 
+		printk(UM_KERN_ERR "cannot parse cookie!!!: %s\n", src);
+		return -1;
+	} 
+	if(*(char *)&num == 42) {
+		// why oh why there is no htonll
+		temp = htonl(temph.high);
+		temph.high = htonl(temph.low);
+		temph.low = temp;
+	} else {
+		temph.low = htonl(temph.low); 
+		temph.high = htonl(temph.high);
+	}	
+	memcpy(dst, &temph, sizeof (uint64_t));
+	return 0;
+}
+
+static void uml_l2tpv3_remove(void *data)
+{
+	struct uml_l2tpv3_data *pri = data;
+
+	l2tpv3_kern_destroy(pri); 
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
+static int uml_l2tpv3_user_init(void *data, void *dev)
+{
+	struct uml_l2tpv3_data *pri = data;
+	int fd;
+	int sock_family, sock_type, sock_proto;
+	int ret;
+	struct addrinfo hints;
+	struct addrinfo *result;
+	char service[NI_MAXSERV];
+	struct mmsghdr * mmsghdr;
+
+	pri->offset = 4;
+	pri->session_offset = 0;
+	pri->cookie_offset = 4;
+	pri->counter_offset = 4;
+
+	pri->fd = -1;
+
+	
+
+	/* used only in single packet modes, should be obsoleted */
+	
+	pri->network_buffer = uml_kmalloc(pri->header_size, UM_GFP_KERNEL); 
+	if (!pri->network_buffer) {
+		printk("uml_l2tpv3_user_init: could not allocate buffer\n");
+		return -1;
+	}
+
+
+	/* basic variable parsing */
+	 
+	pri->local_session = 0;
+	if (l2tpv3_parse_cookie32(pri->local_session_string,&pri->local_session) !=0) {
+		uml_l2tpv3_remove(pri);
+		return -1;
+	}
+	pri->remote_session = 0;
+	if (l2tpv3_parse_cookie32(pri->remote_session_string,&pri->remote_session) !=0) {
+		uml_l2tpv3_remove(pri);
+		return -1;
+	}
+	if (pri->new_mode & NEW_MODE_COOKIE) {
+		if (pri->new_mode & NEW_MODE_COOKIE_SIZE) {
+		/* 64 bit cookie */
+			pri->offset += 8;
+			pri->counter_offset += 8;
+			if (l2tpv3_parse_cookie64(pri->tx_cookie_string,&pri->tx_cookie) !=0) {
+				uml_l2tpv3_remove(pri);
+				return -1;
+			}
+			if (l2tpv3_parse_cookie64(pri->rx_cookie_string,&pri->rx_cookie) !=0) {
+				uml_l2tpv3_remove(pri);
+				return -1;
+			}
+		} else {
+		/* 32 bit cookie */
+			pri->offset += 4;
+			pri->counter_offset +=4;
+			pri->tx_cookie = 0;
+			if (l2tpv3_parse_cookie32(pri->tx_cookie_string,&pri->tx_cookie) !=0) {
+				uml_l2tpv3_remove(pri);
+				return -1;
+			}
+			pri->rx_cookie = 0;
+			if (l2tpv3_parse_cookie32(pri->rx_cookie_string,&pri->rx_cookie) !=0) {
+				uml_l2tpv3_remove(pri);
+				return -1;
+			}
+		}
+	}
+	if (pri->remote_addr_string) {			
+	/* we now allocate it only if it we are not "listening" */
+		pri->remote_addr = uml_kmalloc(sizeof(struct sockaddr_storage), UM_GFP_KERNEL);
+	} else {
+		pri->remote_addr = NULL;
+	}
+
+	if (pri->new_mode & NEW_MODE_IP_VERSION) {
+	 /* IPv6 */
+		sock_family = AF_INET6;
+	} else {
+	 /* IPv4 */
+		sock_family = AF_INET;
+	}
+	if (pri->new_mode & NEW_MODE_UDP) {
+		printk(UM_KERN_ERR "uml_l2tpv3_user_init: preparing udp socket for mode %x\n ", pri->new_mode);
+		sock_type = SOCK_DGRAM;
+		sock_proto = 0;
+		/* space for header. In UDP mode, the 
+		* egress packet also includes the 
+		* 'Ver' and 'Reserved' fields.
+		*/
+
+		pri->offset += 4;
+		pri->counter_offset += 4;
+		pri->session_offset += 4;
+		pri->cookie_offset += 4;
+	} else {
+		printk(UM_KERN_ERR "uml_l2tpv3_user_init: preparing raw socket for mode %x\n ", pri->new_mode);
+		sock_type = SOCK_RAW;
+		sock_proto = 0x73;
+	}
+
+	if (!(pri->new_mode & NEW_MODE_NO_COUNTER)) {
+		pri->offset += 4;
+	}
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_flags = AI_PASSIVE;
+	hints.ai_family = sock_family;
+	hints.ai_socktype = sock_type;
+	hints.ai_protocol = sock_proto;
+
+	if ((fd = socket(hints.ai_family, hints.ai_socktype, hints.ai_protocol)) == -1) {
+		fd = -errno;
+		printk(UM_KERN_ERR "uml_l2tpv3_user_init: socket creation failed, "
+			"errno = %d\n", -fd);
+		uml_l2tpv3_remove(pri);
+		return fd;
+	} else {
+		pri->fd = fd;
+	}
+
+	/* Get the details of the local endpoint, and bind it. */
+	memset(service, '\0', NI_MAXSERV);
+	if (pri->new_mode & NEW_MODE_UDP) {
+		strncpy(service, pri->local_service, NI_MAXSERV - 1);
+		service[NI_MAXSERV - 1] = '\0';
+	}
+
+	ret = getaddrinfo(pri->local_addr_string, service, &hints, &result);
+
+	if ((ret != 0) || (result == NULL)) {
+		printk(UM_KERN_ERR "uml_l2tpv3_user_init: Unable to parse the local endpoint: %d\n", ret);
+		uml_l2tpv3_remove(pri);
+		return -1;
+	}
+	if (bind(fd, (struct sockaddr *)result->ai_addr, result->ai_addrlen)) {
+		printk("uml_l2tpv3_user_init:	could not bind socket: %d\n", errno);
+		freeaddrinfo(result);
+		uml_l2tpv3_remove(pri);
+		return -1;
+	}
+	printk("uml_l2tpv3_user_init: socket bound\n");
+	freeaddrinfo(result);
+
+	if (pri->remote_addr != NULL) {
+	/* Get the details of the remote endpoint. */
+		memset(service, '\0', NI_MAXSERV);
+		if (pri->new_mode & NEW_MODE_UDP) {
+			strncpy(service, pri->remote_service, NI_MAXSERV - 1);
+			service[NI_MAXSERV - 1] = '\0';
+		}
+		memset(&hints, 0, sizeof(hints));
+		hints.ai_flags = AI_PASSIVE;
+		hints.ai_family = sock_family;
+		hints.ai_socktype = sock_type;
+		hints.ai_protocol = sock_proto;
+		ret = getaddrinfo(pri->remote_addr_string, service, &hints, &result);
+		if ((ret != 0) || (result == NULL)) {
+			printk(UM_KERN_ERR "uml_l2tpv3_user_init: Unable to parse the remote endpoint: %d\n", ret);
+			uml_l2tpv3_remove(pri);
+			return -1;
+		}
+		memset(pri->remote_addr, '\0' , sizeof(struct sockaddr_storage));
+		memcpy(pri->remote_addr, result->ai_addr, result->ai_addrlen);
+		pri->remote_addr_size = result->ai_addrlen;
+		freeaddrinfo(result);
+	 }
+
+	/* vector IO init */
+
+	int queue_size = VECTOR_SIZE * 4096;
+	/* we do not care about the result, this is a tuning, not critical */
+	setsockopt(socket, SOL_SOCKET, SO_RCVBUF, &queue_size, sizeof(queue_size)); 
+
+
+	pri->vector_len = VECTOR_SIZE;
+	pri->recv_index = 0;
+	pri->recv_enqueued = 0;
+	pri->header_size = pri->offset /* fix for ipv4 raw */;
+
+	if ((!(pri->new_mode & NEW_MODE_IP_VERSION)) && (!(pri->new_mode & NEW_MODE_UDP))){
+		 pri->header_size += sizeof(struct iphdr) /* fix for ipv4 raw */;
+	}
+
+	pri->skb_recv_vector = build_skbuf_vector(VECTOR_SIZE, dev);
+	pri->mmsg_recv_vector = build_mmsg_vector(VECTOR_SIZE, 2);
+	add_header_buffers(pri->mmsg_recv_vector, VECTOR_SIZE, pri->header_size); 
+	add_skbuffs(
+		 pri->mmsg_recv_vector, 
+		 pri->skb_recv_vector, 
+		 VECTOR_SIZE, ETH_MAX_PACKET + ETH_HEADER_OTHER, 
+		 1
+	);
+
+	pri->skb_send_vector = uml_kmalloc(VECTOR_SIZE * sizeof(void *), UM_GFP_KERNEL);
+	if (pri->skb_send_vector) {
+		memset(pri->skb_send_vector, 0, sizeof(void *) * VECTOR_SIZE);
+	} else {
+		uml_l2tpv3_remove(pri);
+		return -1;
+	}
+	pri->mmsg_send_vector = build_mmsg_vector(VECTOR_SIZE, 2);
+	if (! pri->mmsg_send_vector) {
+		uml_l2tpv3_remove(pri);
+		return -1;
+	}
+	/* note - we do not need to do the ipv4 header size correction here */
+	add_header_buffers(pri->mmsg_send_vector, VECTOR_SIZE, pri->offset); 
+
+	if (!pri->remote_addr) {
+		mmsghdr = (struct mmsghdr *) pri->mmsg_recv_vector;
+		mmsghdr->msg_hdr.msg_name = uml_kmalloc(sizeof(struct sockaddr_storage), UM_GFP_KERNEL);
+		if (mmsghdr->msg_hdr.msg_name) {
+			mmsghdr->msg_hdr.msg_namelen = sizeof(struct sockaddr_storage);
+		} else {
+			printk("uml_l2tpv3_user_init: Failed to allocate remote address name\n");
+		}
+	}
+	pri->dev = dev;
+
+	/* init kernel side structures that are opaque to userspace - 
+	 *  locks, timers, state machine, etc 
+	 */ 
+ 
+
+	l2tpv3_complete_init(dev, VECTOR_SIZE); /* we really need error checking here */
+
+	if (!pri->send_queue_info) {
+		printk("uml_l2tpv3:queue control allocation failed\n");
+		uml_l2tpv3_remove(pri);
+		return -1;
+	}
+
+	if (pri->fd < 0) {
+		return pri->fd;
+	}
+	return 0;
+}
+
+static int uml_l2tpv3_open(void *data)
+{
+	struct uml_l2tpv3_data *pri = data;
+	return pri->fd;
+}
+
+
+int uml_l2tpv3_user_sendmsg(int fd, void *header, int headerlen, void *data, int datalen, struct uml_l2tpv3_data *pri)
+{
+	struct msghdr message;
+	struct iovec vec[2];
+
+	vec[0].iov_base = header;
+	vec[0].iov_len = headerlen;
+	vec[1].iov_base = data;
+	vec[1].iov_len = datalen;
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
+int uml_l2tpv3_user_recvmsg(int fd, void *header, int headerlen, void *data, int datalen, struct uml_l2tpv3_data *pri)
+{
+	struct msghdr message;
+	struct iovec vec[2];
+
+	vec[0].iov_base = header;
+	vec[0].iov_len = headerlen;
+	vec[1].iov_base = data;
+	vec[1].iov_len = datalen;
+
+	if (!pri->remote_addr) {
+		pri->remote_addr = uml_kmalloc(sizeof(struct sockaddr_storage), UM_GFP_ATOMIC);
+		if (pri->remote_addr) {
+			message.msg_name = pri->remote_addr;
+			message.msg_namelen = pri->remote_addr_size;
+		} else {
+			message.msg_name = NULL;
+			message.msg_namelen = 0;
+		}
+	} else {
+		message.msg_name = NULL;
+		message.msg_namelen = 0;
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
+const struct net_user_info uml_l2tpv3_user_info = {
+	.init		= uml_l2tpv3_user_init,
+	.open		= uml_l2tpv3_open,
+	.close	 	= NULL,
+	.remove	 	= uml_l2tpv3_remove,
+	.add_address	= NULL,
+	.delete_address = NULL,
+	.mtu		= ETH_MAX_PACKET,
+	.max_packet	= ETH_MAX_PACKET + ETH_HEADER_OTHER + L2TPV3_HEADER,
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

