Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XPcGv-000565-1u
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2014 19:00:41 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XPcGt-0002Hq-Fs
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2014 19:00:41 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Thu,  4 Sep 2014 20:00:23 +0100
Message-Id: <1409857227-717756-7-git-send-email-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <1409857227-717756-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
References: <1409857227-717756-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
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
Subject: [uml-devel] [PATCH v3 06/10] RAW Ethernet transport for UML
To: user-mode-linux-devel@lists.sourceforge.net

From: Anton Ivanov <antivano@cisco.com>

This is an alternative to the well known pcap transport.

In the absense of special hardware support pcap is slow,
guaranteed to be slow and with significant penalties on
NUMA/SMP systems due to the timestamping of every packet.

This transport does not incur any of these timestamping
penalties. It reads and writes packets directly using
recvmmsg and sendmmsg calls.

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---
 arch/um/Kconfig.net            |   12 +++
 arch/um/drivers/Makefile       |    2 +
 arch/um/drivers/uml_raw.h      |   52 +++++++++
 arch/um/drivers/uml_raw_kern.c |  232 ++++++++++++++++++++++++++++++++++++++++
 arch/um/drivers/uml_raw_user.c |  167 +++++++++++++++++++++++++++++
 5 files changed, 465 insertions(+)
 create mode 100644 arch/um/drivers/uml_raw.h
 create mode 100644 arch/um/drivers/uml_raw_kern.c
 create mode 100644 arch/um/drivers/uml_raw_user.c

diff --git a/arch/um/Kconfig.net b/arch/um/Kconfig.net
index e372c06..112df79 100644
--- a/arch/um/Kconfig.net
+++ b/arch/um/Kconfig.net
@@ -114,6 +114,18 @@ config UML_NET_GRE
         the applicable RFCs. The driver supports Soft GRE (wait for connect)
         as used in Cable systems, etc.
 
+config UML_NET_RAW
+	bool "RAW transport"
+	depends on UML_NET
+	help
+        This User-Mode Linux network transport allows UML to bind a raw
+        Ethernet interface using a high-performance non-capture oriented
+        method to read and write traffic. The difference between this driver
+        and any form of PCAP is that this driver does not incur the cost
+        of getting the timestamp for every packet read. This allows it to
+        reach higher performance levels (in the Gigabit range).
+
+
 config UML_NET_DAEMON
 	bool "Daemon transport"
 	depends on UML_NET
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index c5427e1..b1c0ab0 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -11,6 +11,7 @@ slirp-objs := slirp_kern.o slirp_user.o
 daemon-objs := daemon_kern.o daemon_user.o
 uml_l2tpv3-objs := uml_l2tpv3_kern.o uml_l2tpv3_user.o
 uml_gre-objs := uml_gre_kern.o uml_gre_user.o
+uml_raw-objs := uml_raw_kern.o uml_raw_user.o
 umcast-objs := umcast_kern.o umcast_user.o
 net-objs := net_kern.o net_user.o net_extra_user.o net_extra_kern.o
 mconsole-objs := mconsole_kern.o mconsole_user.o
@@ -47,6 +48,7 @@ obj-$(CONFIG_UML_NET_SLIRP) += slirp.o slip_common.o
 obj-$(CONFIG_UML_NET_DAEMON) += daemon.o 
 obj-$(CONFIG_UML_NET_L2TPV3) += uml_l2tpv3.o
 obj-$(CONFIG_UML_NET_GRE) += uml_gre.o
+obj-$(CONFIG_UML_NET_RAW) += uml_raw.o
 obj-$(CONFIG_UML_NET_VDE) += vde.o
 obj-$(CONFIG_UML_NET_MCAST) += umcast.o
 obj-$(CONFIG_UML_NET_PCAP) += pcap.o
diff --git a/arch/um/drivers/uml_raw.h b/arch/um/drivers/uml_raw.h
new file mode 100644
index 0000000..f85e599
--- /dev/null
+++ b/arch/um/drivers/uml_raw.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) 2012 - 2014 Cisco Systems
+ * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __UML_RAW_H__
+#define __UML_RAW_H__
+
+#include "net_user.h"
+
+struct uml_raw_data {
+	char *host_iface;
+	int fd;
+	void *dev;
+        uint32_t uml_raw_flags;
+
+	/* multi-rx read */
+
+	void ** skb_recv_vector;
+	void * mmsg_recv_vector;
+
+	void ** skb_send_vector;
+	void * mmsg_send_vector;
+	void * send_queue_info;
+
+	uint32_t vector_len;
+	uint32_t recv_index;
+	uint32_t recv_enqueued;
+
+
+};
+
+extern const struct net_user_info uml_raw_user_info;
+
+extern int uml_raw_user_write(int fd, void *buf, int len,
+			     struct uml_raw_data *pri);
+
+extern void raw_complete_init(void * dev_id, int max_depth);
+extern void raw_kern_destroy(struct uml_raw_data *pri);
+
+#define UML_RAW_FLAG_TX_CHECKSUMS                0x00000001
+#define UML_RAW_FLAG_RX_CHECKSUMS                0x00000002
+
+
+#define UML_RAW_TP_BLOCK_SIZE 4096
+#define UML_RAW_TP_FRAME_SIZE 2048
+#define UML_RAW_TP_BLOCK_NR 32
+#define UML_RAW_TP_FRAME_NR 64
+
+
+#endif
diff --git a/arch/um/drivers/uml_raw_kern.c b/arch/um/drivers/uml_raw_kern.c
new file mode 100644
index 0000000..700ff01
--- /dev/null
+++ b/arch/um/drivers/uml_raw_kern.c
@@ -0,0 +1,232 @@
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
+#include <linux/if_packet.h>
+#include "net_kern.h"
+#include "uml_raw.h"
+#include "linux/mutex.h"
+
+#define DRIVER_NAME "uml-raw"
+
+
+struct uml_raw_init {
+	char *host_iface;
+};
+
+static void uml_raw_get_drvinfo(struct net_device *dev,
+				struct ethtool_drvinfo *info)
+{
+	strcpy(info->driver, DRIVER_NAME);
+	strcpy(info->version, "42");
+}
+
+
+static const struct ethtool_ops uml_raw_ethtool_ops = {
+	.get_drvinfo			  = uml_raw_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+};
+
+
+static void uml_raw_init(struct net_device *dev, void *data)
+{
+	struct uml_net_private *pri;
+	struct uml_raw_data *dpri;
+	struct uml_raw_init *init = data;
+
+	pri = netdev_priv(dev);
+	dpri = (struct uml_raw_data *) pri->user;
+	dpri->host_iface = init->host_iface;
+	dpri->fd = -1;
+	dpri->dev = dev;
+
+	/* We will free this pointer. If it contains crap we're burned. */
+
+	printk("raw backend - host iface: %s",  dpri->host_iface);
+	printk("\n");
+	printk("enabling ethtool support\n");
+	dpri->uml_raw_flags = 0; /* we have everything turned off initially */
+	SET_ETHTOOL_OPS(dev, &uml_raw_ethtool_ops);
+
+}
+
+static int uml_raw_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
+{
+	int result;
+	struct uml_raw_data *dpri;
+	dpri = (struct uml_raw_data *) lp->user;
+
+	result = net_read(fd, skb_mac_header(skb),
+		skb->dev->mtu + ETH_HEADER_OTHER);
+
+	return result;
+}
+
+static struct sk_buff * uml_raw_multiread (struct uml_net_private * lp) {
+	struct uml_raw_data *dpri = (struct uml_raw_data *) &lp->user;
+	void ** skb_vector = dpri->skb_recv_vector;
+	struct mmsghdr * mmsg_vector = (struct mmsghdr *) dpri->mmsg_recv_vector;
+	struct sk_buff * result = NULL;
+	struct iovec * iov;
+	int ret;
+
+	if (dpri->recv_index >= dpri->recv_enqueued) {
+		dpri->recv_index = 0;
+		if (dpri->recv_enqueued) {
+			 rebuild_skbuf_vector(skb_vector, dpri->recv_enqueued, lp->dev);
+			 add_skbuffs(mmsg_vector, skb_vector, dpri->recv_enqueued, lp->max_packet, 0);
+		}
+		ret = net_recvmmsg(
+			 dpri->fd, dpri->mmsg_recv_vector, dpri->vector_len, 0, NULL);
+		if (ret >= 0) {
+			 dpri->recv_enqueued = ret;
+		} else {
+			 dpri->recv_enqueued = 0;
+			 return NULL;
+		}
+	}
+	skb_vector += dpri->recv_index;
+	mmsg_vector += dpri->recv_index;
+	while (dpri->recv_index < dpri->recv_enqueued) {
+		dpri->recv_index ++;
+		iov = mmsg_vector->msg_hdr.msg_iov;
+		if ((mmsg_vector->msg_len) && (iov)) {
+			result = (struct sk_buff *)(* skb_vector);
+			if (result) {
+				skb_trim(result, mmsg_vector->msg_len);
+				result->protocol = (*lp->protocol)(result);
+				return result;
+			} else {
+				printk("encountered failed atomic allocation, skipping to next\n");
+			}
+		} else {
+			uml_net_destroy_skb(* skb_vector ) ; /* otherwise we leak it */
+			result = NULL;
+		}
+		mmsg_vector++;
+		skb_vector++;
+	}
+	return result;
+}
+
+void raw_complete_init(void * dev_id, int max_depth) {
+
+	struct net_device *dev = dev_id;
+	struct uml_net_private *lp = netdev_priv(dev);
+	struct uml_raw_data *pri = (struct uml_raw_data *) &lp->user;
+	struct mmsg_queue_info * queue_info ;
+	int err;
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
+
+void raw_kern_destroy(struct uml_raw_data *pri) {
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
+static int uml_raw_multiwrite(int fd, struct sk_buff *skb, struct uml_net_private *lp)
+{
+	struct uml_raw_data *pri = (struct uml_raw_data *) &lp->user;
+	int queue_depth;
+
+	queue_depth = uml_net_enqueue (
+		(struct mmsg_queue_info *) pri->send_queue_info,
+		skb,
+		lp,
+		NULL,
+		NULL,
+		0
+	);
+
+	uml_net_flush_mmsg_queue(
+		(struct mmsg_queue_info *) pri->send_queue_info,
+		queue_depth
+	);
+	return skb->len; /* not particularly correct */
+}
+
+static int uml_raw_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
+{
+	return uml_raw_user_write(fd, skb->data, skb->len,
+				 (struct uml_raw_data *) &lp->user);
+}
+
+static int uml_raw_setup(char *str, char **mac_out, void *data)
+{
+	struct uml_raw_init *init = data;
+	char *remain;
+
+	*init = (
+		(struct uml_raw_init)
+			{ .host_iface = "eth0"}
+	);
+
+	remain = split_if_spec(str, mac_out, &init->host_iface, NULL);
+	if (remain != NULL)
+		printk(KERN_WARNING " Strange interface spec \n");
+
+	return 1;
+}
+
+
+static const struct net_kern_info uml_raw_kern_info = {
+	.options		= UML_NET_USE_SKB_READ,
+	.init			= uml_raw_init,
+	.protocol		= eth_protocol,
+	.read			= uml_raw_read,
+	.skb_read		= uml_raw_multiread,
+#ifdef CONFIG_UML_NET_VECTOR_TX
+	.write			= uml_raw_multiwrite,
+#else
+	.write			= uml_raw_write,
+#endif
+
+};
+
+static struct transport uml_raw_transport = {
+	.list 		= LIST_HEAD_INIT(uml_raw_transport.list),
+	.name 		= "raw",
+	.setup  	= uml_raw_setup,
+	.user 		= &uml_raw_user_info,
+	.kern 		= &uml_raw_kern_info,
+	.private_size 	= sizeof(struct uml_raw_data),
+	.setup_size 	= sizeof(struct uml_raw_init),
+};
+
+static int register_uml_raw(void)
+{
+	register_transport(&uml_raw_transport);
+	return 0;
+}
+
+late_initcall(register_uml_raw);
diff --git a/arch/um/drivers/uml_raw_user.c b/arch/um/drivers/uml_raw_user.c
new file mode 100644
index 0000000..084d875
--- /dev/null
+++ b/arch/um/drivers/uml_raw_user.c
@@ -0,0 +1,167 @@
+/*
+ * Copyright (C) 2012 - 2014 Cisco Systems
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
+#include <sys/ioctl.h>
+#include <net/if.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <net/ethernet.h>
+#include <netinet/ip.h>
+#include <netinet/ether.h>
+#include <linux/if_ether.h>
+#include <linux/if_packet.h>
+#include <sys/mman.h>
+
+
+#include "uml_raw.h"
+#include "net_user.h"
+#include "os.h"
+#include "um_malloc.h"
+#include "user.h"
+
+#define VECTOR_SIZE 32
+
+static void uml_raw_remove(void *data)
+{
+	struct uml_raw_data *pri = data;
+
+	raw_kern_destroy(pri);
+
+	if (pri->fd > 0) {
+		close(pri->fd);
+	}
+	pri->fd = -1;
+
+	if (pri->skb_send_vector) {
+		/* this one should be empty - we flushed it so we just free it */
+		kfree(pri->skb_send_vector);
+		pri->skb_send_vector = NULL;
+	}
+	if (pri->mmsg_send_vector) {
+		destroy_mmsg_vector(pri->mmsg_send_vector, VECTOR_SIZE, 0);
+		pri->mmsg_send_vector = NULL;
+	}
+
+	if (pri->skb_recv_vector) {
+		destroy_skb_vector(pri->skb_recv_vector, VECTOR_SIZE);
+		pri->skb_recv_vector = NULL;
+	}
+	if (pri->mmsg_recv_vector) {
+		destroy_mmsg_vector(pri->mmsg_recv_vector, VECTOR_SIZE, 0);
+		pri->mmsg_recv_vector = NULL;
+	}
+}
+
+static int uml_raw_user_init(void *data, void *dev)
+{
+	struct uml_raw_data *pri = data;
+	struct ifreq ifr;
+	int fd;
+	struct sockaddr_ll sock;
+	int err;
+
+	if ((fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL))) == -1) {
+		 err = -errno;
+		 printk(UM_KERN_ERR "uml_raw_open : raw socket creation failed, "
+				 "errno = %d\n", -err);
+		 return err;
+	}
+
+	pri->fd = fd;
+	pri->vector_len = VECTOR_SIZE;
+	pri->recv_index = 0;
+	pri->recv_enqueued = 0;
+	pri->skb_recv_vector = build_skbuf_vector(VECTOR_SIZE, dev);
+	if (! pri->skb_recv_vector) {
+		uml_raw_remove(pri);
+		return -1;
+	}
+	pri->mmsg_recv_vector = build_mmsg_vector(VECTOR_SIZE, 1);
+	if (! pri->mmsg_recv_vector) {
+		uml_raw_remove(pri);
+		return -1;
+	}
+	add_skbuffs(
+		 pri->mmsg_recv_vector,
+		 pri->skb_recv_vector,
+		 VECTOR_SIZE, ETH_MAX_PACKET + ETH_HEADER_OTHER,
+		 0
+	);
+
+	pri->skb_send_vector = uml_kmalloc(VECTOR_SIZE * sizeof(void *), UM_GFP_KERNEL);
+	if (pri->skb_send_vector) {
+		memset(pri->skb_send_vector, 0, sizeof(void *) * VECTOR_SIZE);
+	} else {
+		uml_raw_remove(pri);
+		return -1;
+	}
+	pri->mmsg_send_vector = build_mmsg_vector(VECTOR_SIZE, 1);
+	if (! pri->mmsg_send_vector) {
+		uml_raw_remove(pri);
+		return -1;
+	}
+
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(&ifr.ifr_name, pri->host_iface, sizeof(ifr.ifr_name) - 1);
+	if(ioctl(fd, SIOCGIFINDEX, (void *) &ifr) < 0) {
+		err = -errno;
+		printk(UM_KERN_ERR "SIOCGIFINDEX, failed to get raw interface index for %s", pri->host_iface);
+		uml_raw_remove(pri);
+		return(-1);
+	}
+
+	sock.sll_family = AF_PACKET;
+	sock.sll_protocol = htons(ETH_P_ALL);
+	sock.sll_ifindex = ifr.ifr_ifindex;
+
+	printk(UM_KERN_INFO "uml_raw: binding raw on interface index: %i\n", ifr.ifr_ifindex);
+	if (bind(fd, (struct sockaddr *) &sock, sizeof(struct sockaddr_ll)) < 0) {
+		printk(UM_KERN_ERR "uml_raw: failed to bind raw socket");
+		uml_raw_remove(pri);
+		return(-1);
+	}
+
+	pri->dev = dev;
+
+	raw_complete_init(dev, VECTOR_SIZE); /* we really need error checking here */
+
+	if (pri->fd < 0) {
+		return pri->fd;
+	}
+
+	return 0;
+}
+
+static int uml_raw_open(void *data)
+{
+	struct uml_raw_data *pri = data;
+	return pri->fd;
+}
+
+
+int uml_raw_user_write(int fd, void *buf, int len, struct uml_raw_data *pri)
+{
+	return net_write(fd, buf, len);
+}
+
+const struct net_user_info uml_raw_user_info = {
+	.init		= uml_raw_user_init,
+	.open		= uml_raw_open,
+	.close	 	= NULL,
+	.remove	 	= uml_raw_remove,
+	.add_address	= NULL,
+	.delete_address = NULL,
+	.mtu		= ETH_MAX_PACKET,
+	.max_packet	= ETH_MAX_PACKET + ETH_HEADER_OTHER,
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

