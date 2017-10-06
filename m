Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1e0NAE-0006Qh-BC for user-mode-linux-devel@lists.sourceforge.net;
 Fri, 06 Oct 2017 07:35:18 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1e0NA9-0002Lo-2G
 for user-mode-linux-devel@lists.sourceforge.net;
 Fri, 06 Oct 2017 07:35:18 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Fri,  6 Oct 2017 08:34:56 +0100
Message-Id: <20171006073457.15448-3-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20171006073457.15448-1-anton.ivanov@kot-begemot.co.uk>
References: <20171006073457.15448-1-anton.ivanov@kot-begemot.co.uk>
Subject: [uml-devel] [PATCH v5 2/3] High Performance Vector Network Driver
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

1. Provides infrastructure for vector IO using recvmmsg/sendmmsg.
1.1. Multi-message read.
1.2. Multi-message write.
1.3. Optimized queue support for multi-packet enqueue/dequeue.
1.4. BQL/DQL support.
2. Implements transports for several transports as well support
for direct wiring of PWEs to NIC. Allows direct connection of VMs
to host, other VMs and network devices with no switch in use.
2.1. Raw socket >4 times faster than existing pcap based transport
2.2. Tap transport using socket RX and tap xmit. >3 times faster
RX than existing tap, 10+ times faster on TX.
2.3. GRE transport - direct wiring to GRE PWE, >3 times faster RX
than any existing transport.
2.4. L2TPv3 transport - direct wiring to L2TPv3 PWE, > 3 times
faster RX than any existing transport.
2.5. TX in all cases shows only minor improvement, but consumes
significantly less CPU under load.
3. Tuning and performance related information via ethtool.
4. Rudimentary BPF support - used in tap only to avoid software
looping
5. Scatter Gather support.
6. VNET and checksum offload support for raw socket transport.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/Kconfig.net                 |   11 +
 arch/um/drivers/Makefile            |    4 +-
 arch/um/drivers/net_kern.c          |    4 +-
 arch/um/drivers/vector_kern.c       | 1531 +++++++++++++++++++++++++++++++++++
 arch/um/drivers/vector_kern.h       |  128 +++
 arch/um/drivers/vector_transports.c |  430 ++++++++++
 arch/um/drivers/vector_user.c       |  528 ++++++++++++
 arch/um/drivers/vector_user.h       |   90 ++
 arch/um/include/asm/irq.h           |   12 +
 arch/um/include/shared/net_kern.h   |    2 +
 10 files changed, 2737 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/drivers/vector_kern.c
 create mode 100644 arch/um/drivers/vector_kern.h
 create mode 100644 arch/um/drivers/vector_transports.c
 create mode 100644 arch/um/drivers/vector_user.c
 create mode 100644 arch/um/drivers/vector_user.h

diff --git a/arch/um/Kconfig.net b/arch/um/Kconfig.net
index 820a56f00332..0516dc76e6aa 100644
--- a/arch/um/Kconfig.net
+++ b/arch/um/Kconfig.net
@@ -108,6 +108,17 @@ config UML_NET_DAEMON
         more than one without conflict.  If you don't need UML networking,
         say N.
 
+config UML_NET_VECTOR
+	bool "Vector I/O high performance network devices"
+	depends on UML_NET
+	help
+	This User-Mode Linux network driver uses multi-message send
+	and receive functions. The host running the UML guest must have
+	a linux kernel version above 3.0 and a libc version > 2.13.
+	This driver provides tap, raw, gre and l2tpv3 network transports
+	with up to 4 times higher network throughput than the UML network
+	drivers.
+
 config UML_NET_VDE
 	bool "VDE transport"
 	depends on UML_NET
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index e7582e1d248c..16b3cebddafb 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -9,6 +9,7 @@
 slip-objs := slip_kern.o slip_user.o
 slirp-objs := slirp_kern.o slirp_user.o
 daemon-objs := daemon_kern.o daemon_user.o
+vector-objs := vector_kern.o vector_user.o vector_transports.o
 umcast-objs := umcast_kern.o umcast_user.o
 net-objs := net_kern.o net_user.o
 mconsole-objs := mconsole_kern.o mconsole_user.o
@@ -43,6 +44,7 @@ obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
 obj-$(CONFIG_UML_NET_SLIP) += slip.o slip_common.o
 obj-$(CONFIG_UML_NET_SLIRP) += slirp.o slip_common.o
 obj-$(CONFIG_UML_NET_DAEMON) += daemon.o 
+obj-$(CONFIG_UML_NET_VECTOR) += vector.o
 obj-$(CONFIG_UML_NET_VDE) += vde.o
 obj-$(CONFIG_UML_NET_MCAST) += umcast.o
 obj-$(CONFIG_UML_NET_PCAP) += pcap.o
@@ -61,7 +63,7 @@ obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
 obj-$(CONFIG_UML_RANDOM) += random.o
 
 # pcap_user.o must be added explicitly.
-USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o pcap_user.o vde_user.o
+USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o pcap_user.o vde_user.o vector_user.o
 CFLAGS_null.o = -DDEV_NULL=$(DEV_NULL_PATH)
 
 include arch/um/scripts/Makefile.rules
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 1669240c7a25..03cc5857a3b6 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -288,7 +288,7 @@ static void uml_net_user_timer_expire(unsigned long _conn)
 #endif
 }
 
-static void setup_etheraddr(struct net_device *dev, char *str)
+void uml_net_setup_etheraddr(struct net_device *dev, char *str)
 {
 	unsigned char *addr = dev->dev_addr;
 	char *end;
@@ -412,7 +412,7 @@ static void eth_configure(int n, void *init, char *mac,
 	 */
 	snprintf(dev->name, sizeof(dev->name), "eth%d", n);
 
-	setup_etheraddr(dev, mac);
+	uml_net_setup_etheraddr(dev, mac);
 
 	printk(KERN_INFO "Netdevice %d (%pM) : ", n, dev->dev_addr);
 
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
new file mode 100644
index 000000000000..f0ea7f98b86c
--- /dev/null
+++ b/arch/um/drivers/vector_kern.c
@@ -0,0 +1,1531 @@
+/*
+ * Copyright (C) 2017 - Cambridge Greys Limited
+ * Copyright (C) 2011 - 2014 Cisco Systems Inc
+ * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
+ * James Leu (jleu@mindspring.net).
+ * Copyright (C) 2001 by various other people who didn't put their name here.
+ * Licensed under the GPL.
+ */
+
+#include <linux/version.h>
+#include <linux/bootmem.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/inetdevice.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/rtnetlink.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <init.h>
+#include <irq_kern.h>
+#include <irq_user.h>
+#include <net_kern.h>
+#include <os.h>
+#include "mconsole_kern.h"
+#include "vector_user.h"
+#include "vector_kern.h"
+
+/*
+ * Adapted from network devices with the following major changes:
+ * All transports are static - simplifies the code significantly
+ * Multiple FDs/IRQs per device
+ * Vector IO optionally used for read/write, falling back to legacy
+ * based on configuration and/or availability
+ * Configuration is no longer positional - L2TPv3 and GRE require up to
+ * 10 parameters, passing this as positional is not fit for purpose.
+ * Only socket transports are supported
+ */
+
+
+#define DRIVER_NAME "uml-vector"
+#define DRIVER_VERSION "01"
+struct vector_cmd_line_arg {
+	struct list_head list;
+	int unit;
+	char *arguments;
+};
+
+struct vector_device {
+	struct list_head list;
+	struct net_device *dev;
+	struct platform_device pdev;
+	int unit;
+	int opened;
+};
+
+static LIST_HEAD(vec_cmd_line);
+
+static DEFINE_SPINLOCK(vector_devices_lock);
+static LIST_HEAD(vector_devices);
+
+static int driver_registered;
+
+static void vector_eth_configure(int n, struct arglist *def);
+
+/* Argument accessors to set variables (and/or set default values)
+ * mtu, buffer sizing, default headroom, etc
+ */
+
+#define DEFAULT_HEADROOM 2
+#define SAFETY_MARGIN 32
+#define DEFAULT_VECTOR_SIZE 64
+#define TX_SMALL_PACKET 128
+#define MAX_IOV_SIZE 8
+
+static const struct {
+	const char string[ETH_GSTRING_LEN];
+} ethtool_stats_keys[] = {
+	{ "rx_queue_max" },
+	{ "rx_queue_running_average" },
+	{ "tx_queue_max" },
+	{ "tx_queue_running_average" },
+	{ "rx_encaps_errors" },
+	{ "tx_timeout_count" },
+	{ "tx_restart_queue" },
+	{ "tx_kicks" },
+	{ "tx_flow_control_xon" },
+	{ "tx_flow_control_xoff" },
+	{ "rx_csum_offload_good" },
+	{ "rx_csum_offload_errors"},
+	{ "sg_ok"},
+	{ "sg_linearized"},
+};
+
+#define VECTOR_NUM_STATS	ARRAY_SIZE(ethtool_stats_keys)
+
+/* Used in the 4.4 OpenWRT backport */
+
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(4, 7, 0)
+static inline void netif_trans_update(struct net_device *dev)
+{
+	struct netdev_queue *txq = netdev_get_tx_queue(dev, 0);
+
+	if (txq->trans_start != jiffies)
+		txq->trans_start = jiffies;
+}
+#endif
+
+static void vector_reset_stats(struct vector_private *vp)
+{
+	vp->estats.rx_queue_max = 0;
+	vp->estats.rx_queue_running_average = 0;
+	vp->estats.tx_queue_max = 0;
+	vp->estats.tx_queue_running_average = 0;
+	vp->estats.rx_encaps_errors = 0;
+	vp->estats.tx_timeout_count = 0;
+	vp->estats.tx_restart_queue = 0;
+	vp->estats.tx_kicks = 0;
+	vp->estats.tx_flow_control_xon = 0;
+	vp->estats.tx_flow_control_xoff = 0;
+	vp->estats.sg_ok = 0;
+	vp->estats.sg_linearized = 0;
+}
+
+static int get_mtu(struct arglist *def)
+{
+	char *mtu = uml_vector_fetch_arg(def, "mtu");
+	long result;
+
+	if (mtu != NULL) {
+		if (kstrtoul(mtu, 10, &result) == 0)
+			return result;
+	}
+	return ETH_MAX_PACKET;
+}
+
+static int get_depth(struct arglist *def)
+{
+	char *mtu = uml_vector_fetch_arg(def, "depth");
+	long result;
+
+	if (mtu != NULL) {
+		if (kstrtoul(mtu, 10, &result) == 0)
+			return result;
+	}
+	return DEFAULT_VECTOR_SIZE;
+}
+
+static int get_headroom(struct arglist *def)
+{
+	char *mtu = uml_vector_fetch_arg(def, "headroom");
+	long result;
+
+	if (mtu != NULL) {
+		if (kstrtoul(mtu, 10, &result) == 0)
+			return result;
+	}
+	return DEFAULT_HEADROOM;
+}
+
+static int get_transport_options(struct arglist *def)
+{
+	char *transport = uml_vector_fetch_arg(def, "transport");
+
+	if (strncmp(transport, TRANS_TAP, TRANS_TAP_LEN) == 0)
+		return (VECTOR_RX | VECTOR_BPF);
+	if (strncmp(transport, TRANS_RAW, TRANS_RAW_LEN) == 0)
+		return (VECTOR_TX | VECTOR_RX | VECTOR_BPF);
+	return (VECTOR_TX | VECTOR_RX);
+}
+
+
+/* A mini-buffer for packet drop read
+ * All of our supported transports are datagram oriented and we always
+ * read using recvmsg or recvmmsg. If we pass a buffer which is smaller
+ * than the packet size it still counts as full packet read and will
+ * clean the incoming stream to keep sigio/epoll happy
+ */
+
+#define DROP_BUFFER_SIZE 32
+
+static char *drop_buffer;
+
+/* Array backed queues optimized for bulk enqueue/dequeue and
+ * 1:N (small values of N) or 1:1 enqueuer/dequeuer ratios.
+ * For more details and full design rationale see
+ * http://foswiki.cambridgegreys.com/Main/EatYourTailAndEnjoyIt
+ */
+
+
+/*
+ * Advance the mmsg queue head by n = advance. Resets the queue to
+ * maximum enqueue/dequeue-at-once capacity if possible. Called by
+ * dequeuers. Caller must hold the head_lock!
+ */
+
+static int vector_advancehead(struct vector_queue *qi, int advance)
+{
+	int queue_depth;
+
+	qi->head =
+		(qi->head + advance)
+			% qi->max_depth;
+
+
+	spin_lock(&qi->tail_lock);
+	qi->queue_depth -= advance;
+
+	/* we are at 0, use this to
+	 * reset head and tail so we can use max size vectors
+	 */
+
+	if (qi->queue_depth == 0) {
+		qi->head = 0;
+		qi->tail = 0;
+	}
+	queue_depth = qi->queue_depth;
+	spin_unlock(&qi->tail_lock);
+	return queue_depth;
+}
+
+/*	Advance the queue tail by n = advance.
+ *	This is called by enqueuers which should hold the
+ *	head lock already
+ */
+
+static int vector_advancetail(struct vector_queue *qi, int advance)
+{
+	int queue_depth;
+
+	qi->tail =
+		(qi->tail + advance)
+			% qi->max_depth;
+	spin_lock(&qi->head_lock);
+	qi->queue_depth += advance;
+	queue_depth = qi->queue_depth;
+	spin_unlock(&qi->head_lock);
+	return queue_depth;
+}
+
+static int prep_msg(struct vector_private *vp, struct sk_buff *skb, struct iovec *iov)
+{
+	int iov_index = 0;
+	int nr_frags, frag;
+	skb_frag_t *skb_frag;
+
+	nr_frags = skb_shinfo(skb)->nr_frags;
+	if (nr_frags > MAX_IOV_SIZE) {
+		if (skb_linearize(skb) != 0)
+			goto drop;
+	}
+	if (vp->header_size > 0) {
+		iov[iov_index].iov_len = vp->header_size;
+		vp->form_header(iov[iov_index].iov_base, skb, vp);
+		iov_index++;
+	}
+	iov[iov_index].iov_base = skb->data;
+	if (nr_frags > 0) {
+		iov[iov_index].iov_len = skb->len - skb->data_len;
+		vp->estats.sg_ok++;
+	} else
+		iov[iov_index].iov_len = skb->len;
+	iov_index++;
+	for (frag = 0; frag < nr_frags; frag++) {
+		skb_frag = &skb_shinfo(skb)->frags[frag];
+		iov[iov_index].iov_base = skb_frag_address_safe(skb_frag);
+		iov[iov_index].iov_len = skb_frag_size(skb_frag);
+		iov_index++;
+	}
+	return iov_index;
+drop:
+	return -1;
+}
+/*
+ * Generic vector enqueue with support for forming headers using transport
+ * specific callback. Allows GRE, L2TPv3, RAW and other transports
+ * to use a common enqueue procedure in vector mode
+ */
+
+static int vector_enqueue(struct vector_queue *qi, struct sk_buff *skb)
+{
+	struct vector_private *vp = netdev_priv(qi->dev);
+	int queue_depth;
+	int packet_len;
+	struct mmsghdr *mmsg_vector = qi->mmsg_vector;
+	int iov_count;
+
+	spin_lock(&qi->tail_lock);
+	spin_lock(&qi->head_lock);
+	queue_depth = qi->queue_depth;
+	spin_unlock(&qi->head_lock);
+
+	if (skb)
+		packet_len = skb->len;
+
+	if (queue_depth < qi->max_depth) {
+
+		*(qi->skbuff_vector + qi->tail) = skb;
+		mmsg_vector += qi->tail;
+		iov_count = prep_msg(
+			vp,
+			skb,
+			mmsg_vector->msg_hdr.msg_iov
+		);
+		if (iov_count < 1)
+			goto drop; 
+		mmsg_vector->msg_hdr.msg_iovlen = iov_count;
+		mmsg_vector->msg_hdr.msg_name = vp->fds->remote_addr;
+		mmsg_vector->msg_hdr.msg_namelen = vp->fds->remote_addr_size;
+		queue_depth = vector_advancetail(qi, 1);
+	} else
+		goto drop;
+	spin_unlock(&qi->tail_lock);
+	return queue_depth;
+drop:
+	qi->dev->stats.tx_dropped++;
+	if (skb != NULL) {
+		packet_len = skb->len;
+		dev_consume_skb_any(skb);
+		netdev_completed_queue(qi->dev, 1, packet_len);
+	}
+	spin_unlock(&qi->tail_lock);
+	return queue_depth;
+}
+
+static int consume_vector_skbs(struct vector_queue *qi, int count)
+{
+	struct sk_buff *skb;
+	int skb_index;
+	int bytes_compl = 0;
+
+	for (skb_index = qi->head; skb_index < qi->head + count; skb_index++) {
+		skb = *(qi->skbuff_vector + skb_index);
+		/* mark as empty to ensure correct destruction if
+		 * needed
+		 */
+		bytes_compl += skb->len;
+		*(qi->skbuff_vector + skb_index) = NULL;
+		dev_consume_skb_any(skb);
+	}
+	qi->dev->stats.tx_bytes += bytes_compl;
+	qi->dev->stats.tx_packets += count;
+	netdev_completed_queue(qi->dev, count, bytes_compl);
+	return vector_advancehead(qi, count);
+}
+
+/*
+ * Generic vector deque via sendmmsg with support for forming headers
+ * using transport specific callback. Allows GRE, L2TPv3, RAW and
+ * other transports to use a common dequeue procedure in vector mode
+ */
+
+
+static int vector_send(struct vector_queue *qi)
+{
+	struct vector_private *vp = netdev_priv(qi->dev);
+	struct mmsghdr *send_from;
+	int result = 0, send_len, queue_depth = qi->max_depth;
+
+	if (spin_trylock(&qi->head_lock)) {
+		if (spin_trylock(&qi->tail_lock)) {
+			/* update queue_depth to current value */
+			queue_depth = qi->queue_depth;
+			spin_unlock(&qi->tail_lock);
+			while (queue_depth > 0) {
+				/* Calculate the start of the vector */
+				send_len = queue_depth;
+				send_from = qi->mmsg_vector;
+				send_from += qi->head;
+				/* Adjust vector size if wraparound */
+				if (send_len + qi->head > qi->max_depth)
+					send_len = qi->max_depth - qi->head;
+				/* Try to TX as many packets as possible */
+				if (send_len > 0) {
+					result = uml_vector_sendmmsg(
+						 vp->fds->tx_fd,
+						 send_from,
+						 send_len,
+						 0
+					);
+					vp->in_write_poll = (result != send_len);
+				}
+				/* For some of the sendmmsg error scenarios
+				 * we may end being unsure in the TX success
+				 * for all packets. It is safer to declare
+				 * them all TX-ed and blame the network.
+				 */
+				if (result < 0) {
+					printk(KERN_ERR "sendmmsg err=%i\n",
+						result);
+					result = send_len;
+				}
+				if (result > 0) {
+					queue_depth = consume_vector_skbs(qi, result);
+					/* This is equivalent to an TX IRQ.
+					 * Restart the upper layers to feed us
+					 * more packets.
+					 */
+					if (result > vp->estats.tx_queue_max)
+						vp->estats.tx_queue_max = result;
+					vp->estats.tx_queue_running_average =
+						(vp->estats.tx_queue_running_average + result) >> 1;
+				}
+				netif_trans_update(qi->dev);
+				netif_wake_queue(qi->dev);
+				/* if TX is busy, break out of the send loop, poll
+				 * write IRQ will reschedule xmit for us
+				 */
+				if (result != send_len) {
+					vp->estats.tx_restart_queue++;
+					break;
+				}
+			}
+		}
+		spin_unlock(&qi->head_lock);
+	} else {
+		tasklet_schedule(&vp->tx_poll);
+	}
+	return queue_depth;
+}
+
+/* Queue destructor. Deliberately stateless so we can use
+ * it in queue cleanup if initialization fails.
+ */
+
+static void destroy_queue(struct vector_queue *qi)
+{
+	int i;
+	struct iovec *iov;
+	struct vector_private *vp = netdev_priv(qi->dev);
+	struct mmsghdr *mmsg_vector;
+
+	if (qi == NULL)
+		return;
+	/* deallocate any skbuffs - we rely on any unused to be
+	 * set to NULL.
+	 */
+	if (qi->skbuff_vector != NULL) {
+		for (i = 0; i < qi->max_depth; i++) {
+			if (*(qi->skbuff_vector + i) != NULL)
+				dev_kfree_skb_any(*(qi->skbuff_vector + i));
+		}
+		kfree(qi->skbuff_vector);
+	}
+	/* deallocate matching IOV structures including header buffs */
+	if (qi->mmsg_vector != NULL) {
+		mmsg_vector = qi->mmsg_vector;
+		for (i = 0; i < qi->max_depth; i++) {
+			iov = mmsg_vector->msg_hdr.msg_iov;
+			if (iov != NULL) {
+				if ((vp->header_size > 0) &&
+					(iov->iov_base != NULL))
+					kfree(iov->iov_base);
+				kfree(iov);
+			}
+			mmsg_vector++;
+		}
+		kfree(qi->mmsg_vector);
+	}
+	kfree(qi);
+}
+
+/*
+ * Queue constructor. Create a queue with a given side.
+ */
+static struct vector_queue *create_queue(
+	struct vector_private *vp,
+	int max_size,
+	int header_size,
+	int num_extra_frags)
+{
+	struct vector_queue *result;
+	int i;
+	struct iovec *iov;
+	struct mmsghdr *mmsg_vector;
+
+	result = kmalloc(sizeof(struct vector_queue), GFP_KERNEL);
+	if (result == NULL)
+		goto out_fail;
+	result->max_depth = max_size;
+	result->dev = vp->dev;
+	result->mmsg_vector = kmalloc(
+		(sizeof(struct mmsghdr) * max_size), GFP_KERNEL);
+	result->skbuff_vector = kmalloc(
+		(sizeof(void *) * max_size), GFP_KERNEL);
+	if (result->mmsg_vector == NULL || result->skbuff_vector == NULL)
+		goto out_fail;
+
+	mmsg_vector = result->mmsg_vector;
+	for (i = 0; i < max_size; i++) {
+		/* Clear all pointers - we use non-NULL as marking on
+		 * what to free on destruction
+		 */
+		*(result->skbuff_vector + i) = NULL;
+		mmsg_vector->msg_hdr.msg_iov = NULL;
+		mmsg_vector++;
+	}
+	mmsg_vector = result->mmsg_vector;
+	result->max_iov_frags = num_extra_frags;
+	for (i = 0; i < max_size; i++) {
+		if (vp->header_size > 0)
+			iov = kmalloc(sizeof(struct iovec) * (3 + num_extra_frags), GFP_KERNEL);
+		else
+			iov = kmalloc(sizeof(struct iovec) * (2 + num_extra_frags), GFP_KERNEL);
+		if (iov == NULL)
+			goto out_fail;
+		mmsg_vector->msg_hdr.msg_iov = iov;
+		mmsg_vector->msg_hdr.msg_iovlen = 1;
+		mmsg_vector->msg_hdr.msg_control = NULL;
+		mmsg_vector->msg_hdr.msg_controllen = 0;
+		mmsg_vector->msg_hdr.msg_flags = MSG_DONTWAIT;
+		mmsg_vector->msg_hdr.msg_name = NULL;
+		mmsg_vector->msg_hdr.msg_namelen = 0;
+		if (vp->header_size > 0) {
+			iov->iov_base = kmalloc(header_size, GFP_KERNEL);
+			if (iov->iov_base == NULL)
+				goto out_fail;
+			iov->iov_len = header_size;
+			mmsg_vector->msg_hdr.msg_iovlen = 2;
+			iov++;
+		}
+		iov->iov_base = NULL;
+		iov->iov_len = 0;
+		mmsg_vector++;
+	}
+	spin_lock_init(&result->head_lock);
+	spin_lock_init(&result->tail_lock);
+	result->queue_depth = 0;
+	result->head = 0;
+	result->tail = 0;
+	return result;
+out_fail:
+	destroy_queue(result);
+	return NULL;
+}
+
+/*
+ * We do not use the RX queue as a proper wraparound queue for now
+ * This is not necessary because the consumption via netif_rx()
+ * happens in-line. While we can try using the return code of
+ * netif_rx() for flow control there are no drivers doing this today.
+ * For this RX specific use we ignore the tail/head locks and
+ * just read into a prepared queue filled with skbuffs.
+ */
+
+/* Prepare queue for recvmmsg one-shot rx - fill with fresh sk_buffs*/
+
+static void prep_queue_for_rx(struct vector_queue *qi)
+{
+	struct vector_private *vp = netdev_priv(qi->dev);
+	struct sk_buff *skb;
+	struct iovec *iov;
+	struct mmsghdr *mmsg_vector = qi->mmsg_vector;
+	void **skbuff_vector = qi->skbuff_vector;
+	int i;
+
+	if (qi->queue_depth == 0)
+		return;
+	for (i = 0; i < qi->queue_depth; i++) {
+		/* it is OK if allocation fails - recvmmsg with NULL data in
+		 * iov argument still performs an RX, just drops the packet
+		 * This allows us stop faffing around with a "drop buffer"
+		 */
+
+		skb = netdev_alloc_skb(
+			vp->dev,
+			vp->max_packet + vp->headroom + SAFETY_MARGIN);
+		iov = mmsg_vector->msg_hdr.msg_iov;
+		mmsg_vector->msg_len = 0;
+		if (vp->header_size > 0)
+			iov++;
+		if (skb != NULL) {
+			skb_reserve(skb, vp->headroom);
+			skb->dev = qi->dev;
+			skb_put(skb, vp->max_packet);
+			skb_reset_mac_header(skb);
+			skb->ip_summed = CHECKSUM_NONE;
+			iov->iov_base = skb->data;
+			iov->iov_len = vp->max_packet;
+		} else {
+			iov->iov_base = NULL;
+			iov->iov_len = 0;
+		}
+		*skbuff_vector = skb;
+		skbuff_vector++;
+		mmsg_vector++;
+	}
+	qi->queue_depth = 0;
+}
+
+static struct vector_device *find_device(int n)
+{
+	struct vector_device *device;
+	struct list_head *ele;
+
+	spin_lock(&vector_devices_lock);
+	list_for_each(ele, &vector_devices) {
+		device = list_entry(ele, struct vector_device, list);
+		if (device->unit == n)
+			goto out;
+	}
+	device = NULL;
+ out:
+	spin_unlock(&vector_devices_lock);
+	return device;
+}
+
+static int vector_parse(char *str, int *index_out, char **str_out,
+			char **error_out)
+{
+	int n, len, err = -EINVAL;
+	char *start = str;
+
+	len = strlen(str);
+
+	while ((*str != ':') && (strlen(str) > 1))
+		str++;
+	if (*str != ':') {
+		*error_out = "Expected ':' after device number";
+		return err;
+	} else
+		*str = '\0';
+
+	err = kstrtouint(start, 0, &n);
+	if (err < 0) {
+		*error_out = "Bad device number";
+		return err;
+	}
+
+	str++;
+	if (find_device(n)) {
+		*error_out = "Device already configured";
+		return err;
+	}
+
+	*index_out = n;
+	*str_out = str;
+	return 0;
+}
+
+static int vector_config(char *str, char **error_out)
+{
+	int err, n;
+	char *params;
+	struct arglist *parsed;
+
+	err = vector_parse(str, &n, &params, error_out);
+	if (err != 0)
+		return err;
+
+	/* This string is broken up and the pieces used by the underlying
+	 * driver. We should copy it to make sure things do not go wrong
+	 * later.
+	 */
+
+	params = kstrdup(params, GFP_KERNEL);
+	if (str == NULL) {
+		*error_out = "vector_config failed to strdup string";
+		return -ENOMEM;
+	}
+
+	parsed = uml_parse_vector_ifspec(params);
+
+	if (parsed == NULL) {
+		*error_out = "vector_config failed to parse parameters";
+		return -EINVAL;
+	}
+
+	vector_eth_configure(n, parsed);
+	return 0;
+}
+
+static int vector_id(char **str, int *start_out, int *end_out)
+{
+	char *end;
+	int n;
+
+	n = simple_strtoul(*str, &end, 0);
+	if ((*end != '\0') || (end == *str))
+		return -1;
+
+	*start_out = n;
+	*end_out = n;
+	*str = end;
+	return n;
+}
+
+static int vector_remove(int n, char **error_out)
+{
+	struct vector_device *vec_d;
+	struct net_device *dev;
+	struct vector_private *vp;
+
+	vec_d = find_device(n);
+	if (vec_d == NULL)
+		return -ENODEV;
+	dev = vec_d->dev;
+	vp = netdev_priv(dev);
+	if (vp->fds != NULL)
+		return -EBUSY;
+	unregister_netdev(dev);
+	platform_device_unregister(&vec_d->pdev);
+	return 0;
+}
+
+/*
+ * There is no shared per-transport initialization code, so
+ * we will just initialize each interface one by one and
+ * add them to a list
+ */
+
+static struct platform_driver uml_net_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+	},
+};
+
+
+static void vector_device_release(struct device *dev)
+{
+	struct vector_device *device = dev_get_drvdata(dev);
+	struct net_device *netdev = device->dev;
+
+	list_del(&device->list);
+	kfree(device);
+	free_netdev(netdev);
+}
+
+/* Bog standard recv using recvmsg - not used normally unless the user
+ * explicitly specifies not to use recvmmsg vector RX.
+ */
+
+static int vector_legacy_rx(struct vector_private *vp)
+{
+	int pkt_len;
+	struct user_msghdr hdr;
+	struct iovec iov[2]; /* header + data use case only */
+	int iovpos = 0;
+	struct sk_buff *skb;
+	int header_check;
+
+	hdr.msg_name = NULL;
+	hdr.msg_namelen = 0;
+	hdr.msg_iov = (struct iovec *) &iov;
+	hdr.msg_iovlen = 1;
+	hdr.msg_control = NULL;
+	hdr.msg_controllen = 0;
+	hdr.msg_flags = 0;
+
+	if (vp->header_size > 0) {
+		iov[iovpos].iov_base = vp->header_rxbuffer;
+		iov[iovpos].iov_len = vp->rx_header_size;
+		hdr.msg_iovlen++;
+		iovpos++;
+	}
+
+	skb = netdev_alloc_skb(vp->dev,
+			vp->max_packet + vp->headroom + SAFETY_MARGIN);
+	if (skb == NULL) {
+		/* Read a packet into drop_buffer and don't do
+		 * anything with it.
+		 */
+		iov[iovpos].iov_base = drop_buffer;
+		iov[iovpos].iov_len = DROP_BUFFER_SIZE;
+		vp->dev->stats.rx_dropped++;
+	} else {
+		skb_reserve(skb, vp->headroom);
+		skb->dev = vp->dev;
+		skb_put(skb, vp->max_packet);
+		skb_reset_mac_header(skb);
+		iov[iovpos].iov_base = skb->data;
+		iov[iovpos].iov_len = vp->max_packet;
+	}
+
+	pkt_len = uml_vector_recvmsg(vp->fds->rx_fd, &hdr, 0);
+
+	if (skb != NULL) {
+		if (pkt_len > vp->header_size) {
+			if (vp->header_size > 0) {
+				header_check = vp->verify_header(
+					vp->header_rxbuffer, skb, vp);
+				if (header_check < 0) {
+					dev_kfree_skb_irq(skb);
+					vp->dev->stats.rx_dropped++;
+					vp->estats.rx_encaps_errors++;
+					return 0;
+				}
+				if (header_check > 0) {
+					vp->estats.rx_csum_offload_good++;
+					skb->ip_summed = CHECKSUM_UNNECESSARY;
+				}
+			}
+			skb_trim(skb, pkt_len - vp->rx_header_size);
+			skb->protocol = eth_type_trans(skb, skb->dev);
+			vp->dev->stats.rx_bytes += skb->len;
+			vp->dev->stats.rx_packets++;
+			netif_rx(skb);
+		} else {
+			dev_kfree_skb_irq(skb);
+		}
+	}
+	return pkt_len;
+}
+
+/*
+ * Packet at a time TX which falls back to vector TX if the
+ * underlying transport is busy.
+ */
+
+
+
+static int writev_tx(struct vector_private *vp, struct sk_buff *skb)
+{
+	struct iovec iov[3 + MAX_IOV_SIZE];
+	int iov_count, pkt_len = 0;
+
+	iov[0].iov_base = vp->header_txbuffer;
+	iov_count = prep_msg(vp, skb, (struct iovec *) &iov);
+
+	if (iov_count < 1)
+		goto drop;
+	pkt_len = uml_vector_writev(vp->fds->tx_fd, (struct iovec *) &iov, iov_count);
+
+	netif_trans_update(vp->dev);
+	netif_wake_queue(vp->dev);
+
+	if (pkt_len > 0) {
+		vp->dev->stats.tx_bytes += skb->len;
+		vp->dev->stats.tx_packets++;
+	} else {
+		vp->dev->stats.tx_dropped++;
+	}
+	consume_skb(skb);
+	return pkt_len;
+drop:
+	vp->dev->stats.tx_dropped++;
+	consume_skb(skb);
+	return pkt_len;
+}
+
+/*
+ * Receive as many messages as we can in one call using the special
+ * mmsg vector matched to an skb vector which we prepared earlier.
+ */
+
+static int vector_mmsg_rx(struct vector_private *vp)
+{
+	int packet_count, i;
+	struct vector_queue *qi = vp->rx_queue;
+	struct sk_buff *skb;
+	struct mmsghdr *mmsg_vector = qi->mmsg_vector;
+	void **skbuff_vector = qi->skbuff_vector;
+	int header_check;
+
+	/* Refresh the vector and make sure it is with new skbs and the
+	 * iovs are updated to point to them.
+	 */
+
+	prep_queue_for_rx(qi);
+
+	/* Fire the Lazy Gun - get as many packets as we can in one go. */
+
+	packet_count = uml_vector_recvmmsg(
+		vp->fds->rx_fd, qi->mmsg_vector, qi->max_depth, 0);
+
+	if (packet_count <= 0)
+		return packet_count;
+
+	/* We treat packet processing as enqueue, buffer refresh as dequeue
+	 * The queue_depth tells us how many buffers have been used and how
+	 * many do we need to prep the next time prep_queue_for_rx() is called.
+	 */
+
+	qi->queue_depth = packet_count;
+
+	for (i = 0; i < packet_count; i++) {
+		skb = (*skbuff_vector);
+		if (mmsg_vector->msg_len > vp->header_size) {
+			if (vp->header_size > 0) {
+				header_check = vp->verify_header(
+					mmsg_vector->msg_hdr.msg_iov->iov_base, skb, vp);
+				if (header_check < 0) {
+				/* Overlay header failed to verify - discard.
+				 * We can actually keep this skb and reuse it,
+				 * but that will make the prep logic too
+				 * complex.
+				 */
+					dev_kfree_skb_irq(skb);
+					vp->estats.rx_encaps_errors++;
+					continue;
+				}
+				if (header_check > 0) {
+					vp->estats.rx_csum_offload_good++;
+					skb->ip_summed = CHECKSUM_UNNECESSARY;
+				}
+			}
+			skb_trim(skb,
+				mmsg_vector->msg_len - vp->rx_header_size);
+			skb->protocol = eth_type_trans(skb, skb->dev);
+			/*
+			 * We do not need to lock on updating stats here
+			 * The interrupt loop is non-reentrant.
+			 */
+			vp->dev->stats.rx_bytes += skb->len;
+			vp->dev->stats.rx_packets++;
+			netif_rx(skb);
+		} else {
+			/* Overlay header too short to do anything - discard.
+			 * We can actually keep this skb and reuse it,
+			 * but that will make the prep logic too complex.
+			 */
+			if (skb != NULL)
+				dev_kfree_skb_irq(skb);
+		}
+		(*skbuff_vector) = NULL;
+		/* Move to the next buffer element */
+		mmsg_vector++;
+		skbuff_vector++;
+	}
+	if (packet_count > 0) {
+		if (vp->estats.rx_queue_max < packet_count)
+			vp->estats.rx_queue_max = packet_count;
+		vp->estats.rx_queue_running_average =
+			(vp->estats.rx_queue_running_average + packet_count) >> 1;
+	}
+	return packet_count;
+}
+
+static void vector_rx(struct vector_private *vp)
+{
+	int err;
+
+	if ((vp->options & VECTOR_RX) > 0)
+		while ((err = vector_mmsg_rx(vp)) > 0)
+			;
+	else
+		while ((err = vector_legacy_rx(vp)) > 0)
+			;
+	if (err != 0)
+		printk(KERN_ERR "vector_rx: error(%d)\n", err);
+}
+
+static int vector_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct vector_private *vp = netdev_priv(dev);
+	int queue_depth = 0;
+
+	if ((vp->options & VECTOR_TX) == 0) {
+		writev_tx(vp, skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* We do BQL only in the vector path, no point doing it in
+	 * packet at a time mode as there is no device queue
+	 */
+
+	netdev_sent_queue(vp->dev, skb->len);
+	queue_depth = vector_enqueue(vp->tx_queue, skb);
+
+	/* if the device queue is full, stop the upper layers and
+	 * flush it.
+	 */
+
+	if (queue_depth >= vp->tx_queue->max_depth - 1) {
+		vp->estats.tx_kicks++;
+		netif_stop_queue(dev);
+		vector_send(vp->tx_queue);
+		return NETDEV_TX_OK;
+	}
+	if (skb->xmit_more) {
+		mod_timer(&vp->tl, vp->coalesce);
+		return NETDEV_TX_OK;
+	}
+	if (skb->len < TX_SMALL_PACKET) {
+		vp->estats.tx_kicks++;
+		vector_send(vp->tx_queue);
+	} else
+		tasklet_schedule(&vp->tx_poll);
+	return NETDEV_TX_OK;
+}
+
+static irqreturn_t vector_rx_interrupt(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct vector_private *vp = netdev_priv(dev);
+
+	if (!netif_running(dev))
+		return IRQ_NONE;
+	vector_rx(vp);
+	return IRQ_HANDLED;
+
+}
+
+static irqreturn_t vector_tx_interrupt(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct vector_private *vp = netdev_priv(dev);
+
+	if (!netif_running(dev))
+		return IRQ_NONE;
+	/* We need to pay attention to it only if we got
+	 * -EAGAIN or -ENOBUFFS from sendmmsg. Otherwise
+	 * we ignore it. In the future, it may be worth
+	 * it to improve the IRQ controller a bit to make
+	 * tweaking the IRQ mask less costly
+	 */
+
+	if (vp->in_write_poll) {
+		tasklet_schedule(&vp->tx_poll);
+	}
+	return IRQ_HANDLED;
+
+}
+
+static int irq_rr;
+
+static int vector_net_close(struct net_device *dev)
+{
+	struct vector_private *vp = netdev_priv(dev);
+	unsigned long flags;
+
+	netif_stop_queue(dev);
+	del_timer(&vp->tl);
+
+	if (vp->fds == NULL)
+		return 0;
+
+	/* Disable and free all IRQS */
+	if (vp->rx_irq > 0) {
+		um_free_irq(vp->rx_irq, dev);
+		vp->rx_irq = 0;
+	}
+	if (vp->tx_irq > 0) {
+		um_free_irq(vp->tx_irq, dev);
+		vp->tx_irq = 0;
+	}
+	tasklet_kill(&vp->tx_poll);
+	if (vp->fds->rx_fd > 0) {
+		os_close_file(vp->fds->rx_fd);
+		vp->fds->rx_fd = -1;
+	}
+	if (vp->fds->tx_fd > 0) {
+		os_close_file(vp->fds->tx_fd);
+		vp->fds->tx_fd = -1;
+	}
+	if (vp->bpf != NULL)
+		kfree(vp->bpf);
+	if (vp->fds->remote_addr != NULL)
+		kfree(vp->fds->remote_addr);
+	if (vp->transport_data != NULL)
+		kfree(vp->transport_data);
+	if (vp->header_rxbuffer != NULL)
+		kfree(vp->header_rxbuffer);
+	if (vp->header_txbuffer != NULL)
+		kfree(vp->header_txbuffer);
+	if (vp->rx_queue != NULL)
+		destroy_queue(vp->rx_queue);
+	if (vp->tx_queue != NULL)
+		destroy_queue(vp->tx_queue);
+	kfree(vp->fds);
+	vp->fds = NULL;
+	spin_lock_irqsave(&vp->lock, flags);
+	vp->opened = false;
+	spin_unlock_irqrestore(&vp->lock, flags);
+	return 0;
+}
+
+/* TX tasklet */
+
+static void vector_tx_poll(unsigned long data)
+{
+	struct vector_private *vp = (struct vector_private *)data;
+
+	vp->estats.tx_kicks++;
+	vector_send(vp->tx_queue);
+}
+static void vector_reset_tx(struct work_struct *work)
+{
+	struct vector_private *vp =
+		container_of(work, struct vector_private, reset_tx);
+	netdev_reset_queue(vp->dev);
+	netif_start_queue(vp->dev);
+	netif_wake_queue(vp->dev);
+}
+static int vector_net_open(struct net_device *dev)
+{
+	struct vector_private *vp = netdev_priv(dev);
+	unsigned long flags;
+	int err = -EINVAL;
+	struct vector_device *vdevice;
+
+	spin_lock_irqsave(&vp->lock, flags);
+	if (vp->opened)
+		return -ENXIO;
+	vp->opened = true;
+	spin_unlock_irqrestore(&vp->lock, flags);
+
+	vp->fds = uml_vector_user_open(vp->unit, vp->parsed);
+
+	if (vp->fds == NULL)
+		goto out_close;
+
+	if (build_transport_data(vp) < 0)
+		goto out_close;
+
+	if ((vp->options & VECTOR_RX) > 0) {
+		vp->rx_queue = create_queue(
+			vp, get_depth(vp->parsed), vp->rx_header_size, 0);
+		vp->rx_queue->queue_depth = get_depth(vp->parsed);
+	} else {
+		vp->header_rxbuffer = kmalloc(vp->rx_header_size, GFP_KERNEL);
+		if (vp->header_rxbuffer == NULL)
+			goto out_close;
+	}
+	if ((vp->options & VECTOR_TX) > 0) {
+		vp->tx_queue = create_queue(
+			vp, get_depth(vp->parsed), vp->header_size, MAX_IOV_SIZE);
+	} else {
+		vp->header_txbuffer = kmalloc(vp->header_size, GFP_KERNEL);
+		if (vp->header_txbuffer == NULL)
+			goto out_close;
+	}
+
+	/* READ IRQ */
+	err = um_request_irq(
+		irq_rr + VECTOR_BASE_IRQ, vp->fds->rx_fd,
+			IRQ_READ, vector_rx_interrupt,
+			IRQF_SHARED, dev->name, dev);
+	if (err != 0) {
+		printk(KERN_ERR "vector_open: failed to get rx irq(%d)\n", err);
+		err = -ENETUNREACH;
+		goto out_close;
+	}
+	vp->rx_irq = irq_rr + VECTOR_BASE_IRQ;
+	dev->irq = irq_rr + VECTOR_BASE_IRQ;
+	irq_rr = (irq_rr + 1) % VECTOR_IRQ_SPACE;
+
+	/* WRITE IRQ - we need it only if we have vector TX */
+	if ((vp->options & VECTOR_TX) > 0) {
+		err = um_request_irq(
+			irq_rr + VECTOR_BASE_IRQ, vp->fds->tx_fd,
+				IRQ_WRITE, vector_tx_interrupt,
+				IRQF_SHARED, dev->name, dev);
+		if (err != 0) {
+			printk(KERN_ERR
+				"vector_open: failed to get tx irq(%d)\n", err);
+			err = -ENETUNREACH;
+			goto out_close;
+		}
+		vp->tx_irq = irq_rr + VECTOR_BASE_IRQ;
+		irq_rr = (irq_rr + 1) % VECTOR_IRQ_SPACE;
+	}
+
+	if ((vp->options & VECTOR_BPF) != 0) {
+		vp->bpf = uml_vector_default_bpf(vp->fds->rx_fd, dev->dev_addr);
+	}
+
+
+	/* Write Timeout Timer */
+
+	vp->tl.data = (unsigned long) vp;
+	netif_start_queue(dev);
+
+	/* clear buffer - it can happen that the host side of the interface
+	 * is full when we get here. In this case, new data is never queued,
+	 * SIGIOs never arrive, and the net never works.
+	 */
+
+	vector_rx(vp);
+
+	vector_reset_stats(vp);
+	vdevice = find_device(vp->unit);
+	vdevice->opened = 1;
+
+	if ((vp->options & VECTOR_TX) != 0) {
+		add_timer(&vp->tl);
+	}
+	return 0;
+out_close:
+	vector_net_close(dev);
+	return err;
+}
+
+
+static void vector_net_set_multicast_list(struct net_device *dev)
+{
+	/* TODO: - we can do some BPF games here */
+	return;
+}
+
+static void vector_net_tx_timeout(struct net_device *dev)
+{
+	struct vector_private *vp = netdev_priv(dev);
+	vp->estats.tx_timeout_count++;
+	netif_trans_update(dev);
+	schedule_work(&vp->reset_tx);
+}
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void vector_net_poll_controller(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	uml_net_interrupt(dev->irq, dev);
+	enable_irq(dev->irq);
+}
+#endif
+
+static void vector_net_get_drvinfo(struct net_device *dev,
+				struct ethtool_drvinfo *info)
+{
+	strlcpy(info->driver, DRIVER_NAME, sizeof(info->driver));
+	strlcpy(info->version, DRIVER_VERSION, sizeof(info->version));
+}
+
+static void vector_get_ringparam(struct net_device *netdev,
+				struct ethtool_ringparam *ring)
+{
+	struct vector_private *vp = netdev_priv(netdev);
+
+	ring->rx_max_pending = vp->rx_queue->max_depth;
+	ring->tx_max_pending = vp->tx_queue->max_depth;
+	ring->rx_pending = vp->rx_queue->max_depth;
+	ring->tx_pending = vp->tx_queue->max_depth;
+}
+
+static void vector_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
+{
+	switch (stringset) {
+	case ETH_SS_TEST:
+		*buf = '\0';
+		break;
+	case ETH_SS_STATS:
+		memcpy(buf, &ethtool_stats_keys, sizeof(ethtool_stats_keys));
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+}
+
+static int vector_get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_TEST:
+		return 0;
+	case ETH_SS_STATS:
+		return VECTOR_NUM_STATS;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void vector_get_ethtool_stats(struct net_device *dev,
+					struct ethtool_stats *estats, u64 *tmp_stats)
+{
+	struct vector_private *vp = netdev_priv(dev);
+
+	memcpy(tmp_stats, &vp->estats, sizeof(struct vector_estats));
+}
+
+static int vector_get_coalesce(struct net_device *netdev,
+					struct ethtool_coalesce *ec)
+{
+	struct vector_private *vp = netdev_priv(netdev);
+
+	ec->tx_coalesce_usecs = (vp->coalesce * 1000000) / HZ;
+	return 0;
+}
+
+static int vector_set_coalesce(struct net_device *netdev,
+					struct ethtool_coalesce *ec)
+{
+	struct vector_private *vp = netdev_priv(netdev);
+
+	vp->coalesce = (ec->tx_coalesce_usecs * HZ) / 1000000;
+	if (vp->coalesce == 0)
+		vp->coalesce = 1;
+	return 0;
+}
+
+static const struct ethtool_ops vector_net_ethtool_ops = {
+	.get_drvinfo	= vector_net_get_drvinfo,
+	.get_link	= ethtool_op_get_link,
+	.get_ts_info	= ethtool_op_get_ts_info,
+	.get_ringparam	= vector_get_ringparam,
+	.get_strings	= vector_get_strings,
+	.get_sset_count	= vector_get_sset_count,
+	.get_ethtool_stats = vector_get_ethtool_stats,
+	.get_coalesce	= vector_get_coalesce,
+	.set_coalesce	= vector_set_coalesce,
+};
+
+
+static const struct net_device_ops vector_netdev_ops = {
+	.ndo_open		= vector_net_open,
+	.ndo_stop		= vector_net_close,
+	.ndo_start_xmit		= vector_net_start_xmit,
+	.ndo_set_rx_mode	= vector_net_set_multicast_list,
+	.ndo_tx_timeout		= vector_net_tx_timeout,
+	.ndo_set_mac_address	= eth_mac_addr,
+	.ndo_validate_addr	= eth_validate_addr,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller = vector_net_poll_controller,
+#endif
+};
+
+
+static void vector_timer_expire(unsigned long _conn)
+{
+	struct vector_private *vp = (struct vector_private *)_conn;
+	vp->estats.tx_kicks++;
+	vector_send(vp->tx_queue);
+}
+
+static void vector_eth_configure(
+		int n,
+		struct arglist *def
+	)
+{
+	struct vector_device *device;
+	struct net_device *dev;
+	struct vector_private *vp;
+	int err;
+
+	printk(KERN_INFO "Vector Netdevice %d\n", n);
+
+	device = kzalloc(sizeof(*device), GFP_KERNEL);
+	if (device == NULL) {
+		printk(KERN_ERR "eth_configure failed to allocate struct "
+				 "vector_device\n");
+		return;
+	}
+	printk(KERN_INFO "vector etherdevice start %d\n", n);
+	dev = alloc_etherdev(sizeof(struct vector_private));
+	if (dev == NULL) {
+		printk(KERN_ERR "eth_configure: failed to allocate struct "
+				 "net_device for vec%d\n", n);
+		goto out_free_device;
+	}
+
+	dev->mtu = get_mtu(def);
+
+	INIT_LIST_HEAD(&device->list);
+	device->unit = n;
+
+	/* If this name ends up conflicting with an existing registered
+	 * netdevice, that is OK, register_netdev{,ice}() will notice this
+	 * and fail.
+	 */
+	snprintf(dev->name, sizeof(dev->name), "vec%d", n);
+	uml_net_setup_etheraddr(dev, uml_vector_fetch_arg(def, "mac"));
+	vp = netdev_priv(dev);
+
+	/* sysfs register */
+	if (!driver_registered) {
+		platform_driver_register(&uml_net_driver);
+		driver_registered = 1;
+	}
+	device->pdev.id = n;
+	device->pdev.name = DRIVER_NAME;
+	device->pdev.dev.release = vector_device_release;
+	dev_set_drvdata(&device->pdev.dev, device);
+	if (platform_device_register(&device->pdev))
+		goto out_free_netdev;
+	SET_NETDEV_DEV(dev, &device->pdev.dev);
+
+	device->dev = dev;
+
+	*vp = ((struct vector_private)
+		{
+		.list			= LIST_HEAD_INIT(vp->list),
+		.dev			= dev,
+		.unit			= n,
+		.options		= get_transport_options(def),
+		.rx_irq			= 0,
+		.tx_irq			= 0,
+		.parsed			= def,
+		.max_packet		= get_mtu(def) + ETH_HEADER_OTHER,
+		/* TODO - we need to calculate headroom so that ip header
+		 * is 16 byte aligned all the time
+		 */
+		.headroom		= get_headroom(def),
+		.form_header		= NULL,
+		.verify_header		= NULL,
+		.header_rxbuffer	= NULL,
+		.header_txbuffer	= NULL,
+		.header_size		= 0,
+		.rx_header_size		= 0,
+		.rexmit_scheduled	= false,
+		.opened			= false,
+		.transport_data		= NULL,
+		.in_write_poll		= false,
+		.coalesce		= 2
+		});
+
+	dev->features = NETIF_F_SG;
+	tasklet_init(&vp->tx_poll, vector_tx_poll, (unsigned long)vp);
+	INIT_WORK(&vp->reset_tx, vector_reset_tx);
+
+	init_timer(&vp->tl);
+	spin_lock_init(&vp->lock);
+	vp->tl.function = vector_timer_expire;
+
+	/* FIXME */
+	dev->netdev_ops = &vector_netdev_ops;
+	dev->ethtool_ops = &vector_net_ethtool_ops;
+	dev->watchdog_timeo = (HZ >> 1);
+	/* primary IRQ - fixme */
+	dev->irq = 0; /* we will adjust this once opened */
+
+	rtnl_lock();
+	err = register_netdevice(dev);
+	rtnl_unlock();
+	if (err)
+		goto out_undo_user_init;
+
+	spin_lock(&vector_devices_lock);
+	list_add(&device->list, &vector_devices);
+	spin_unlock(&vector_devices_lock);
+
+	return;
+
+out_undo_user_init:
+	return;
+out_free_netdev:
+	free_netdev(dev);
+out_free_device:
+	kfree(device);
+}
+
+
+
+
+/*
+ * Invoked late in the init
+ */
+
+static int __init vector_init(void)
+{
+	struct list_head *ele;
+	struct vector_cmd_line_arg *def;
+	struct arglist *parsed;
+
+	list_for_each(ele, &vec_cmd_line) {
+		def = list_entry(ele, struct vector_cmd_line_arg, list);
+		parsed = uml_parse_vector_ifspec(def->arguments);
+		if (parsed != NULL)
+			vector_eth_configure(def->unit, parsed);
+	}
+	return 0;
+}
+
+
+/* Invoked at initial argument parsing, only stores
+ * arguments until a proper vector_init is called
+ * later
+ */
+
+static int __init vector_setup(char *str)
+{
+	char *error;
+	int n, err;
+	struct vector_cmd_line_arg *new;
+
+	err = vector_parse(str, &n, &str, &error);
+	if (err) {
+		printk(KERN_ERR "vector_setup - Couldn't parse '%s' : %s\n",
+				 str, error);
+		return 1;
+	}
+	new = alloc_bootmem(sizeof(*new));
+	INIT_LIST_HEAD(&new->list);
+	new->unit = n;
+	new->arguments = str;
+	list_add_tail(&new->list, &vec_cmd_line);
+	return 1;
+}
+
+__setup("vec", vector_setup);
+__uml_help(vector_setup,
+"vec[0-9]+:<option>=<value>,<option>=<value>\n"
+"	 Configure a vector io network device.\n\n"
+);
+
+late_initcall(vector_init);
+
+static struct mc_device vector_mc = {
+	.list		= LIST_HEAD_INIT(vector_mc.list),
+	.name		= "vec",
+	.config		= vector_config,
+	.get_config	= NULL,
+	.id		= vector_id,
+	.remove		= vector_remove,
+};
+
+#ifdef CONFIG_INET
+static int vector_inetaddr_event(struct notifier_block *this, unsigned long event,
+					void *ptr)
+{
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block vector_inetaddr_notifier = {
+	.notifier_call		= vector_inetaddr_event,
+};
+
+static void inet_register(void)
+{
+	register_inetaddr_notifier(&vector_inetaddr_notifier);
+}
+#else
+static inline void inet_register(void)
+{
+}
+#endif
+
+static int vector_net_init(void)
+{
+	mconsole_register_dev(&vector_mc);
+	inet_register();
+	return 0;
+}
+
+__initcall(vector_net_init);
+
+
+
diff --git a/arch/um/drivers/vector_kern.h b/arch/um/drivers/vector_kern.h
new file mode 100644
index 000000000000..a9ade0851fda
--- /dev/null
+++ b/arch/um/drivers/vector_kern.h
@@ -0,0 +1,128 @@
+/*
+ * Copyright (C) 2002 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __UM_VECTOR_KERN_H
+#define __UM_VECTOR_KERN_H
+
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/skbuff.h>
+#include <linux/socket.h>
+#include <linux/list.h>
+#include <linux/ctype.h>
+#include <linux/workqueue.h>
+#include <linux/interrupt.h>
+#include "vector_user.h"
+
+/* Queue structure specially adapted for multiple enqueue/dequeue
+ * in a mmsgrecv/mmsgsend context
+ */
+
+/* Dequeue method */
+
+#define QUEUE_SENDMSG 0
+#define QUEUE_SENDMMSG 1
+
+#define VECTOR_RX 1
+#define VECTOR_TX (1 << 1)
+#define VECTOR_BPF (1 << 2)
+
+#define ETH_MAX_PACKET 1500
+#define ETH_HEADER_OTHER 32 /* just in case someone decides to go mad on QnQ */
+
+struct vector_queue {
+	struct mmsghdr *mmsg_vector;
+	void **skbuff_vector;
+	 /* backlink to device which owns us */
+	struct net_device *dev;
+	spinlock_t head_lock;
+	spinlock_t tail_lock;
+	int queue_depth, head, tail, max_depth, max_iov_frags;
+	short options;
+};
+
+struct vector_estats {
+	uint64_t rx_queue_max;
+	uint64_t rx_queue_running_average;
+	uint64_t tx_queue_max;
+	uint64_t tx_queue_running_average;
+	uint64_t rx_encaps_errors;
+	uint64_t tx_timeout_count;
+	uint64_t tx_restart_queue;
+	uint64_t tx_kicks;
+	uint64_t tx_flow_control_xon;
+	uint64_t tx_flow_control_xoff;
+	uint64_t rx_csum_offload_good;
+	uint64_t rx_csum_offload_errors;
+	uint64_t sg_ok;
+	uint64_t sg_linearized;
+};
+
+#define VERIFY_HEADER_NOK -1
+#define VERIFY_HEADER_OK 0
+#define VERIFY_CSUM_OK 1
+
+struct vector_private {
+	struct list_head list;
+	spinlock_t lock;
+	struct net_device *dev;
+
+	int unit;
+
+	/* Timeout timer in TX */
+
+	struct timer_list tl;
+
+	/* Scheduled "remove device" work */
+	struct work_struct reset_tx;
+	struct vector_fds *fds;
+
+	struct vector_queue *rx_queue;
+	struct vector_queue *tx_queue;
+
+	int rx_irq;
+	int tx_irq;
+
+	struct arglist *parsed;
+
+	void *transport_data; /* transport specific params if needed */
+
+	int max_packet;
+	int headroom;
+
+	int options;
+
+	/* remote address if any - some transports will leave this as null */
+
+	int header_size;
+	int rx_header_size;
+	int coalesce;
+
+	void *header_rxbuffer;
+	void *header_txbuffer;
+
+	int (*form_header)(uint8_t *header,
+		struct sk_buff *skb, struct vector_private *vp);
+	int (*verify_header)(uint8_t *header,
+		struct sk_buff *skb, struct vector_private *vp);
+
+	spinlock_t stats_lock;
+
+	struct tasklet_struct tx_poll;
+	bool rexmit_scheduled;
+	bool opened;
+	bool in_write_poll;
+
+	/* ethtool stats */
+
+	struct vector_estats estats;
+	void *bpf;
+
+	char user[0];
+};
+
+extern int build_transport_data(struct vector_private *vp);
+
+#endif
diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
new file mode 100644
index 000000000000..9f07d585f71b
--- /dev/null
+++ b/arch/um/drivers/vector_transports.c
@@ -0,0 +1,430 @@
+/*
+ * Copyright (C) 2017 - Cambridge Greys Limited
+ * Copyright (C) 2011 - 2014 Cisco Systems Inc
+ * Licensed under the GPL.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <asm/byteorder.h>
+#include <uapi/linux/ip.h>
+#include <uapi/linux/virtio_net.h>
+#include <linux/virtio_net.h>
+#include <linux/virtio_byteorder.h>
+#include <linux/netdev_features.h>
+#include "vector_user.h"
+#include "vector_kern.h"
+
+#define GOOD_LINEAR 512
+
+struct gre_minimal_header {
+	uint16_t header;
+	uint16_t arptype;
+};
+
+
+struct uml_gre_data {
+	uint32_t rx_key;
+	uint32_t tx_key;
+	uint32_t sequence;
+
+	bool ipv6;
+	bool has_sequence;
+	bool pin_sequence;
+	bool checksum;
+	bool key;
+	struct gre_minimal_header expected_header;
+
+	uint32_t checksum_offset;
+	uint32_t key_offset;
+	uint32_t sequence_offset;
+
+};
+
+struct uml_l2tpv3_data {
+	uint64_t rx_cookie;
+	uint64_t tx_cookie;
+	uint64_t rx_session;
+	uint64_t tx_session;
+	uint32_t counter;
+
+	bool udp;
+	bool ipv6;
+	bool has_counter;
+	bool pin_counter;
+	bool cookie;
+	bool cookie_is_64;
+
+	uint32_t cookie_offset;
+	uint32_t session_offset;
+	uint32_t counter_offset;
+};
+
+static int l2tpv3_form_header(uint8_t *header,
+	struct sk_buff *skb, struct vector_private *vp)
+{
+	struct uml_l2tpv3_data *td = vp->transport_data;
+	uint32_t *counter;
+
+	if (td->udp)
+		*(uint32_t *) header = cpu_to_be32(L2TPV3_DATA_PACKET);
+	(*(uint32_t *) (header + td->session_offset)) = td->tx_session;
+
+	if (td->cookie) {
+		if (td->cookie_is_64)
+			(*(uint64_t *)(header + td->cookie_offset)) =
+				td->tx_cookie;
+		else
+			(*(uint32_t *)(header + td->cookie_offset)) =
+				td->tx_cookie;
+	}
+	if (td->has_counter) {
+		counter = (uint32_t *)(header + td->counter_offset);
+		if (td->pin_counter) {
+			*counter = 0;
+		} else {
+			td->counter++;
+			*counter = cpu_to_be32(td->counter);
+		}
+	}
+	return 0;
+}
+
+static int gre_form_header(uint8_t *header,
+		struct sk_buff *skb, struct vector_private *vp)
+{
+	struct uml_gre_data *td = vp->transport_data;
+	uint32_t *sequence;
+	*((uint32_t *) header) = *((uint32_t *) &td->expected_header);
+	if (td->key)
+		(*(uint32_t *) (header + td->key_offset)) = td->tx_key;
+	if (td->has_sequence) {
+		sequence = (uint32_t *)(header + td->sequence_offset);
+		if (td->pin_sequence)
+			*sequence = 0;
+		else
+			*sequence = cpu_to_be32(++td->sequence);
+	}
+	return 0;
+}
+
+static int raw_form_header(uint8_t *header,
+		struct sk_buff *skb, struct vector_private *vp)
+{
+	struct virtio_net_hdr *vheader = (struct virtio_net_hdr *) header;
+
+	virtio_net_hdr_from_skb(skb, vheader, virtio_legacy_is_little_endian(), false);
+
+	return 0;
+}
+
+static int l2tpv3_verify_header(
+	uint8_t *header, struct sk_buff *skb, struct vector_private *vp)
+{
+	struct uml_l2tpv3_data *td = vp->transport_data;
+	uint32_t *session;
+	uint64_t cookie;
+
+	if ((!td->udp) && (!td->ipv6))
+		header += sizeof(struct iphdr) /* fix for ipv4 raw */;
+
+	/* we do not do a strict check for "data" packets as per
+	 * the RFC spec because the pure IP spec does not have
+	 * that anyway.
+	 */
+
+	if (td->cookie) {
+		if (td->cookie_is_64)
+			cookie = *(uint64_t *)(header + td->cookie_offset);
+		else
+			cookie = *(uint32_t *)(header + td->cookie_offset);
+		if (cookie != td->rx_cookie) {
+			printk(KERN_ERR "uml_l2tpv3: unknown cookie id");
+			return -1;
+		}
+	}
+	session = (uint32_t *) (header + td->session_offset);
+	if (*session != td->rx_session) {
+		printk(KERN_ERR "uml_l2tpv3: session mismatch");
+		return -1;
+	}
+	return 0;
+}
+
+static int gre_verify_header(
+	uint8_t *header, struct sk_buff *skb, struct vector_private *vp)
+{
+
+	uint32_t key;
+	struct uml_gre_data *td = vp->transport_data;
+
+	if (!td->ipv6)
+		header += sizeof(struct iphdr) /* fix for ipv4 raw */;
+
+	if (*((uint32_t *) header) != *((uint32_t *) &td->expected_header)) {
+		printk(KERN_ERR "header type disagreement, expecting %0x, got %0x",
+			*((uint32_t *) &td->expected_header),
+			*((uint32_t *) header)
+		);
+		return -1;
+	}
+
+	if (td->key) {
+		key = (*(uint32_t *)(header + td->key_offset));
+		if (key != td->rx_key) {
+			printk(KERN_ERR "unknown key id %0x, expecting %0x",
+					key, td->rx_key);
+			return -1;
+		}
+	}
+	return 0;
+}
+
+static int raw_verify_header (
+	uint8_t *header, struct sk_buff *skb, struct vector_private *vp)
+{
+	struct virtio_net_hdr *vheader = (struct virtio_net_hdr *) header;
+
+	if (vheader->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
+		printk(KERN_ERR "raw: GSO enabled on interface, please turn off");
+		return -1;	/* GSO, we cannot process this */
+	}
+	if ((vheader->flags & VIRTIO_NET_HDR_F_DATA_VALID) > 0)
+		return 1;
+	else
+		virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
+	return 0;
+}
+
+static bool get_uint_param(
+	struct arglist *def, char *param, unsigned int *result)
+{
+	char *arg = uml_vector_fetch_arg(def, param);
+
+	if (arg != NULL) {
+		if (kstrtoint(arg, 0, result) == 0)
+			return true;
+	}
+	return false;
+}
+
+static bool get_ulong_param(
+	struct arglist *def, char *param, unsigned long *result)
+{
+	char *arg = uml_vector_fetch_arg(def, param);
+
+	if (arg != NULL) {
+		if (kstrtoul(arg, 0, result) == 0)
+			return true;
+		return true;
+	}
+	return false;
+}
+
+static int build_gre_transport_data(struct vector_private *vp)
+{
+	struct uml_gre_data *td;
+	int temp_int;
+	int temp_rx;
+	int temp_tx;
+
+	vp->transport_data = kmalloc(sizeof(struct uml_gre_data), GFP_KERNEL);
+	if (vp->transport_data == NULL)
+		return -ENOMEM;
+	td = vp->transport_data;
+	td->sequence = 0;
+
+	td->expected_header.arptype = GRE_IRB;
+	td->expected_header.header = 0;
+
+	vp->form_header = &gre_form_header;
+	vp->verify_header = &gre_verify_header;
+	vp->header_size = 4;
+	td->key_offset = 4;
+	td->sequence_offset = 4;
+	td->checksum_offset = 4;
+
+	td->ipv6 = false;
+	if (get_uint_param(vp->parsed, "v6", &temp_int)) {
+		if (temp_int > 0)
+			td->ipv6 = true;
+	}
+	td->key = false;
+	if (get_uint_param(vp->parsed, "rx_key", &temp_rx)) {
+		if (get_uint_param(vp->parsed, "tx_key", &temp_tx)) {
+			td->key = true;
+			td->expected_header.header |= GRE_MODE_KEY;
+			td->rx_key = cpu_to_be32(temp_rx);
+			td->tx_key = cpu_to_be32(temp_tx);
+			vp->header_size += 4;
+			td->sequence_offset += 4;
+		} else {
+			return -EINVAL;
+		}
+	}
+
+	td->sequence = false;
+	if (get_uint_param(vp->parsed, "sequence", &temp_int)) {
+		if (temp_int > 0) {
+			vp->header_size += 4;
+			td->has_sequence = true;
+			td->expected_header.header |= GRE_MODE_SEQUENCE;
+			if (get_uint_param(
+				vp->parsed, "pin_sequence", &temp_int)) {
+				if (temp_int > 0)
+					td->pin_sequence = true;
+			}
+		}
+	}
+	vp->rx_header_size = vp->header_size;
+	if (!td->ipv6)
+		vp->rx_header_size += sizeof(struct iphdr);
+	return 0;
+}
+
+static int build_l2tpv3_transport_data(struct vector_private *vp)
+{
+
+	struct uml_l2tpv3_data *td;
+	int temp_int, temp_rxs, temp_txs;
+	unsigned long temp_rx;
+	unsigned long temp_tx;
+
+	vp->transport_data = kmalloc(
+		sizeof(struct uml_l2tpv3_data), GFP_KERNEL);
+
+	if (vp->transport_data == NULL)
+		return -ENOMEM;
+
+	td = vp->transport_data;
+
+	vp->form_header = &l2tpv3_form_header;
+	vp->verify_header = &l2tpv3_verify_header;
+	td->counter = 0;
+
+	vp->header_size = 4;
+	td->session_offset = 0;
+	td->cookie_offset = 4;
+	td->counter_offset = 4;
+
+
+	td->ipv6 = false;
+	if (get_uint_param(vp->parsed, "v6", &temp_int)) {
+		if (temp_int > 0)
+			td->ipv6 = true;
+	}
+
+	if (get_uint_param(vp->parsed, "rx_session", &temp_rxs)) {
+		if (get_uint_param(vp->parsed, "tx_session", &temp_txs)) {
+			td->tx_session = cpu_to_be32(temp_txs);
+			td->rx_session = cpu_to_be32(temp_rxs);
+		} else {
+			return -EINVAL;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	td->cookie_is_64  = false;
+	if (get_uint_param(vp->parsed, "cookie64", &temp_int)) {
+		if (temp_int > 0)
+			td->cookie_is_64  = true;
+	}
+	td->cookie = false;
+	if (get_ulong_param(vp->parsed, "rx_cookie", &temp_rx)) {
+		if (get_ulong_param(vp->parsed, "tx_cookie", &temp_tx)) {
+			td->cookie = true;
+			if (td->cookie_is_64) {
+				td->rx_cookie = cpu_to_be64(temp_rx);
+				td->tx_cookie = cpu_to_be64(temp_tx);
+				vp->header_size += 8;
+				td->counter_offset += 8;
+			} else {
+				td->rx_cookie = cpu_to_be32(temp_rx);
+				td->tx_cookie = cpu_to_be32(temp_tx);
+				vp->header_size += 4;
+				td->counter_offset += 4;
+			}
+		} else {
+			return -EINVAL;
+		}
+	}
+
+	td->has_counter = false;
+	if (get_uint_param(vp->parsed, "counter", &temp_int)) {
+		if (temp_int > 0) {
+			td->has_counter = true;
+			vp->header_size += 4;
+			if (get_uint_param(
+				vp->parsed, "pin_counter", &temp_int)) {
+				if (temp_int > 0)
+					td->pin_counter = true;
+			}
+		}
+	}
+
+	if (get_uint_param(vp->parsed, "udp", &temp_int)) {
+		if (temp_int > 0) {
+			td->udp = true;
+			vp->header_size += 4;
+			td->counter_offset += 4;
+			td->session_offset += 4;
+			td->cookie_offset += 4;
+		}
+	}
+
+	vp->rx_header_size = vp->header_size;
+	if ((!td->ipv6) && (!td->udp))
+		vp->rx_header_size += sizeof(struct iphdr);
+
+	return 0;
+}
+
+static int build_raw_transport_data(struct vector_private *vp)
+{
+	if (uml_raw_enable_vnet_headers(vp->fds->rx_fd)) {
+		vp->form_header = &raw_form_header;
+		vp->verify_header = &raw_verify_header;
+		vp->header_size = sizeof(struct virtio_net_hdr);
+		vp->rx_header_size = sizeof(struct virtio_net_hdr);
+		vp->dev->features |= NETIF_F_HW_CSUM; /* TSO does not work on RAW */
+		printk(KERN_INFO "raw: using vnet headers to offload checksum");
+	}
+	return 0;
+}
+
+static int build_tap_transport_data(struct vector_private *vp)
+{
+	if (uml_raw_enable_vnet_headers(vp->fds->rx_fd)) {
+		vp->form_header = &raw_form_header;
+		vp->verify_header = &raw_verify_header;
+		vp->header_size = sizeof(struct virtio_net_hdr);
+		vp->rx_header_size = sizeof(struct virtio_net_hdr);
+		vp->dev->features |= (NETIF_F_HW_CSUM | NETIF_F_TSO);
+		printk(KERN_INFO "tap/raw: using vnet headers for tso and tx/rx checksum");
+	} else {
+		return 0; /* do not try to enable tap too if raw failed */
+	}
+	if (uml_tap_enable_vnet_headers(vp->fds->tx_fd)) {
+		return 0;
+	}
+	return -1;
+}
+
+int build_transport_data(struct vector_private *vp)
+{
+	char *transport = uml_vector_fetch_arg(vp->parsed, "transport");
+
+	if (strncmp(transport, TRANS_GRE, TRANS_GRE_LEN) == 0)
+		return build_gre_transport_data(vp);
+	if (strncmp(transport, TRANS_L2TPV3, TRANS_L2TPV3_LEN) == 0)
+		return build_l2tpv3_transport_data(vp);
+	if (strncmp(transport, TRANS_RAW, TRANS_RAW_LEN) == 0)
+		return build_raw_transport_data(vp);
+	if (strncmp(transport, TRANS_TAP, TRANS_TAP_LEN) == 0)
+		return build_tap_transport_data(vp);
+	return 0;
+}
+
diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
new file mode 100644
index 000000000000..9210bf2db569
--- /dev/null
+++ b/arch/um/drivers/vector_user.c
@@ -0,0 +1,528 @@
+/*
+ * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Licensed under the GPL
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdarg.h>
+#include <errno.h>
+#include <stddef.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <net/if.h>
+#include <linux/if_tun.h>
+#include <arpa/inet.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <net/ethernet.h>
+#include <netinet/ip.h>
+#include <netinet/ether.h>
+#include <linux/if_ether.h>
+#include <linux/if_packet.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <linux/virtio_net.h>
+#include <netdb.h>
+#include <stdlib.h>
+#include <os.h>
+#include <um_malloc.h>
+#include "vector_user.h"
+
+#define ID_GRE 0
+#define ID_L2TPV3 1
+#define ID_MAX 1
+
+#define TOKEN_IFNAME "ifname"
+
+#define TRANS_RAW "raw"
+#define TRANS_RAW_LEN strlen(TRANS_RAW)
+
+/* This is very ugly and brute force lookup, but it is done
+ * only once at initialization so not worth doing hashes or
+ * anything more intelligent
+ */
+
+char *uml_vector_fetch_arg(struct arglist *ifspec, char *token)
+{
+	int i;
+
+	for (i = 0; i < ifspec->numargs; i++) {
+		if (strcmp(ifspec->tokens[i], token) == 0)
+			return ifspec->values[i];
+	}
+	return NULL;
+
+}
+
+struct arglist *uml_parse_vector_ifspec(char *arg)
+{
+	struct arglist *result;
+	int pos, len;
+	bool parsing_token = true, next_starts = true;
+
+	if (arg == NULL)
+		return NULL;
+	result = uml_kmalloc(sizeof(struct arglist), UM_GFP_KERNEL);
+	if (result == NULL)
+		return NULL;
+	result->numargs = 0;
+	len = strlen(arg);
+	for (pos = 0; pos < len; pos++) {
+		if (next_starts) {
+			if (parsing_token) {
+				result->tokens[result->numargs] = arg + pos;
+			} else {
+				result->values[result->numargs] = arg + pos;
+				result->numargs++;
+			}
+			next_starts = false;
+		}
+		if (*(arg + pos) == '=') {
+			if (parsing_token)
+				parsing_token = false;
+			else
+				goto cleanup;
+			next_starts = true;
+			(*(arg + pos)) = '\0';
+		}
+		if (*(arg + pos) == ',') {
+			parsing_token = true;
+			next_starts = true;
+			(*(arg + pos)) = '\0';
+		}
+	}
+	return result;
+cleanup:
+	printk(UM_KERN_ERR "vector_setup - Couldn't parse '%s'\n", arg);
+	kfree(result);
+	return NULL;
+}
+
+/*
+ * Socket/FD configuration functions. These return an structure
+ * of rx and tx descriptors to cover cases where these are not
+ * the same (f.e. read via raw socket and write via tap).
+ */
+
+#define PATH_NET_TUN "/dev/net/tun"
+
+static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
+{
+	struct ifreq ifr;
+	int fd = -1;
+	struct sockaddr_ll sock;
+	int err = -ENOMEM;
+	char *iface;
+	struct vector_fds *result = NULL;
+
+	iface = uml_vector_fetch_arg(ifspec, TOKEN_IFNAME);
+	if (iface == NULL) {
+		printk(UM_KERN_ERR "uml_tap: failed to parse interface spec\n");
+		goto tap_cleanup;
+	}
+
+	result = uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
+	if (result == NULL) {
+		printk(UM_KERN_ERR "uml_tap: failed to allocate file descriptors\n");
+		goto tap_cleanup;
+	}
+	result->rx_fd = -1;
+	result->tx_fd = -1;
+	result->remote_addr = NULL;
+	result->remote_addr_size = 0;
+
+	/* TAP */
+
+	fd = open(PATH_NET_TUN, O_RDWR);
+	if (fd < 0) {
+		printk(UM_KERN_ERR "uml_tap: failed to open tun device\n");
+		goto tap_cleanup;
+	}
+	result->tx_fd = fd;
+	memset(&ifr, 0, sizeof(ifr));
+	ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
+	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
+
+	err = ioctl(fd, TUNSETIFF, (void *) &ifr);
+	if (err != 0) {
+		printk(UM_KERN_ERR "uml_tap: failed to select tap interface\n");
+		goto tap_cleanup;
+	}
+
+	/* RAW */
+
+	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	if (fd == -1) {
+		printk(UM_KERN_ERR
+			"uml_tap: failed to create socket: %i\n", -errno);
+		goto tap_cleanup;
+	}
+	result->rx_fd = fd;
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
+	if (ioctl(fd, SIOCGIFINDEX, (void *) &ifr) < 0) {
+		printk(UM_KERN_ERR
+			"uml_tap: failed to set interface: %i\n", -errno);
+		goto tap_cleanup;
+	}
+
+	sock.sll_family = AF_PACKET;
+	sock.sll_protocol = htons(ETH_P_ALL);
+	sock.sll_ifindex = ifr.ifr_ifindex;
+
+	if (bind(fd, (struct sockaddr *) &sock, sizeof(struct sockaddr_ll)) < 0) {
+		printk(UM_KERN_ERR
+			"user_init_tap: failed to bind raw pair, err %d\n",
+				-errno);
+		goto tap_cleanup;
+	}
+	return result;
+tap_cleanup:
+	printk(UM_KERN_ERR "user_init_tap: init failed, error %d", err);
+	if (result != NULL) {
+		if (result->rx_fd >= 0)
+			os_close_file(result->rx_fd);
+		if (result->tx_fd >= 0)
+			os_close_file(result->tx_fd);
+		kfree(result);
+	}
+	return NULL;
+}
+
+
+static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
+{
+	struct ifreq ifr;
+	int fd = -1;
+	struct sockaddr_ll sock;
+	int err = -ENOMEM;
+	char *iface;
+	struct vector_fds *result = NULL;
+	int optval = 1;
+
+
+	iface = uml_vector_fetch_arg(ifspec, TOKEN_IFNAME);
+	if (iface == NULL)
+		goto cleanup;
+
+	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	if (fd == -1) {
+		err = -errno;
+		goto cleanup;
+	}
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
+	if (ioctl(fd, SIOCGIFINDEX, (void *) &ifr) < 0) {
+		err = -errno;
+		goto cleanup;
+	}
+
+	sock.sll_family = AF_PACKET;
+	sock.sll_protocol = htons(ETH_P_ALL);
+	sock.sll_ifindex = ifr.ifr_ifindex;
+
+	if (bind(fd, (struct sockaddr *) &sock, sizeof(struct sockaddr_ll)) < 0) {
+		err = -errno;
+		goto cleanup;
+	}
+
+	if (setsockopt(fd, SOL_PACKET, PACKET_QDISC_BYPASS, &optval, sizeof(optval)) != 0) {
+		printk(UM_KERN_INFO "user_init_raw: could not disable qdisc on inteface");
+	}
+
+	result = uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
+	if (result != NULL) {
+		result->rx_fd = fd;
+		result->tx_fd = fd;
+		result->remote_addr = NULL;
+		result->remote_addr_size = 0;
+	}
+	return result;
+cleanup:
+	printk(UM_KERN_ERR "user_init_raw: init failed, error %d", err);
+	if (fd >= 0)
+		os_close_file(fd);
+	if (result != NULL)
+		kfree(result);
+	return NULL;
+}
+
+bool uml_raw_enable_vnet_headers(int fd)
+{
+	int optval = 1;
+	if (setsockopt(fd, SOL_PACKET, PACKET_VNET_HDR, &optval, sizeof(optval)) != 0) {
+		printk(UM_KERN_INFO "could not disable vnet headers on fd %d", fd);
+		return false;
+	}
+	return true;
+}
+bool uml_tap_enable_vnet_headers(int fd)
+{
+	unsigned int features;
+	int len = sizeof(struct virtio_net_hdr);
+	if (ioctl(fd, TUNGETFEATURES, &features) == -1) {
+		printk(UM_KERN_INFO "tapraw: TUNGETFEATURES failed: %s", strerror(errno));
+		return false;
+	}
+	if ((features & IFF_VNET_HDR) == 0) {
+		printk(UM_KERN_INFO "tapraw: No VNET HEADER support");
+		return false;
+	}
+	ioctl(fd, TUNSETVNETHDRSZ, &len);
+	return true;
+}
+
+static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
+{
+	int err = -ENOMEM;
+	int fd = -1, gairet;
+	struct addrinfo srchints;
+	struct addrinfo dsthints;
+	bool v6, udp;
+	char *value;
+	char *src, *dst, *srcport, *dstport;
+	struct addrinfo *gairesult = NULL;
+	struct vector_fds *result = NULL;
+
+
+	value = uml_vector_fetch_arg(ifspec, "v6");
+	v6 = false;
+	udp = false;
+	if (value != NULL) {
+		if (strtol((const char *) value, NULL, 10) > 0)
+			v6 = true;
+	}
+
+	value = uml_vector_fetch_arg(ifspec, "udp");
+	if (value != NULL) {
+		if (strtol((const char *) value, NULL, 10) > 0)
+			udp = true;
+	}
+	src = uml_vector_fetch_arg(ifspec, "src");
+	dst = uml_vector_fetch_arg(ifspec, "dst");
+	srcport = uml_vector_fetch_arg(ifspec, "srcport");
+	dstport = uml_vector_fetch_arg(ifspec, "dstport");
+
+	memset(&dsthints, 0, sizeof(dsthints));
+
+	if (v6)
+		dsthints.ai_family = AF_INET6;
+	else
+		dsthints.ai_family = AF_INET;
+
+	switch (id) {
+	case ID_GRE:
+		dsthints.ai_socktype = SOCK_RAW;
+		dsthints.ai_protocol = IPPROTO_GRE;
+		break;
+	case ID_L2TPV3:
+		if (udp) {
+			dsthints.ai_socktype = SOCK_DGRAM;
+			dsthints.ai_protocol = 0;
+		} else {
+			dsthints.ai_socktype = SOCK_RAW;
+			dsthints.ai_protocol = IPPROTO_L2TP;
+		}
+		break;
+	default:
+		printk(KERN_ERR "Unsupported socket type\n");
+		return NULL;
+	}
+	memcpy(&srchints, &dsthints, sizeof(struct addrinfo));
+
+	gairet = getaddrinfo(src, srcport, &dsthints, &gairesult);
+	if ((gairet != 0) || (gairesult == NULL)) {
+		printk(UM_KERN_ERR
+			"socket_open : could not resolve src, error = %s",
+			gai_strerror(gairet)
+		);
+		return NULL;
+	}
+	fd = socket(gairesult->ai_family,
+		gairesult->ai_socktype, gairesult->ai_protocol);
+	if (fd == -1) {
+		printk(UM_KERN_ERR
+			"socket_open : could not open socket, error = %d", -errno
+		);
+		goto cleanup;
+	}
+	if (bind(fd, (struct sockaddr *) gairesult->ai_addr, gairesult->ai_addrlen)) {
+		printk(UM_KERN_ERR "l2tpv3_open :  could not bind socket err=%i", errno);
+		goto cleanup;
+	}
+
+	if (gairesult != NULL)
+		freeaddrinfo(gairesult);
+
+	gairesult = NULL;
+
+	gairet = getaddrinfo(dst, dstport, &dsthints, &gairesult);
+	if ((gairet != 0) || (gairesult == NULL)) {
+		printk(UM_KERN_ERR
+			"socket_open : could not resolve dst, error = %s",
+			gai_strerror(gairet)
+		);
+		return NULL;
+	}
+
+	result = uml_kmalloc(sizeof(struct vector_fds), UM_GFP_KERNEL);
+	if (result != NULL) {
+		result->rx_fd = fd;
+		result->tx_fd = fd;
+		result->remote_addr = uml_kmalloc(gairesult->ai_addrlen, UM_GFP_KERNEL);
+		if (result->remote_addr == NULL)
+			goto cleanup;
+		result->remote_addr_size = gairesult->ai_addrlen;
+		memcpy(result->remote_addr, gairesult->ai_addr, gairesult->ai_addrlen);
+	}
+	freeaddrinfo(gairesult);
+	return result;
+cleanup:
+	if (gairesult != NULL)
+		freeaddrinfo(gairesult);
+	printk(UM_KERN_ERR "user_init_socket: init failed, error %d", err);
+	if (fd >= 0)
+		os_close_file(fd);
+	if (result != NULL) {
+		if (result->remote_addr != NULL)
+			kfree(result->remote_addr);
+		kfree(result);
+	}
+	return NULL;
+}
+
+struct vector_fds *uml_vector_user_open(
+	int unit,
+	struct arglist *parsed
+)
+{
+	char *transport;
+
+	if (parsed == NULL) {
+		printk(UM_KERN_ERR "no parsed config for unit %d\n", unit);
+		return NULL;
+	}
+	transport = uml_vector_fetch_arg(parsed, "transport");
+	if (transport == NULL) {
+		printk(UM_KERN_ERR "missing transport for unit %d\n", unit);
+		return NULL;
+	}
+	if (strncmp(transport, TRANS_RAW, TRANS_RAW_LEN) == 0)
+		return user_init_raw_fds(parsed);
+	if (strncmp(transport, TRANS_TAP, TRANS_TAP_LEN) == 0)
+		return user_init_tap_fds(parsed);
+	if (strncmp(transport, TRANS_GRE, TRANS_GRE_LEN) == 0)
+		return user_init_socket_fds(parsed, ID_GRE);
+	if (strncmp(transport, TRANS_L2TPV3, TRANS_L2TPV3_LEN) == 0)
+		return user_init_socket_fds(parsed, ID_L2TPV3);
+	return NULL;
+}
+
+
+int uml_vector_sendmsg(int fd, void *hdr, int flags)
+{
+	int n;
+
+	CATCH_EINTR(n = sendmsg(fd, (struct msghdr *) hdr,  flags));
+	/* some sockets return ENOBUFS instead of eagain */
+	if ((n < 0) && ((errno == EAGAIN) || (errno == ENOBUFS)))
+		return 0;
+	if (n >= 0)
+		return n;
+	else
+		return -errno;
+}
+
+int uml_vector_recvmsg(int fd, void *hdr, int flags)
+{
+	int n;
+
+	CATCH_EINTR(n = recvmsg(fd, (struct msghdr *) hdr,  flags));
+	if ((n < 0) && (errno == EAGAIN))
+		return 0;
+	if (n >= 0)
+		return n;
+	else
+		return -errno;
+}
+
+int uml_vector_writev(int fd, void *hdr, int iovcount)
+{
+	int n;
+
+	CATCH_EINTR(n = writev(fd, (struct iovec *) hdr,  iovcount));
+	if ((n < 0) && (errno == EAGAIN))
+		return 0;
+	if (n >= 0)
+		return n;
+	else
+		return -errno;
+}
+int uml_vector_sendmmsg(int fd, void *msgvec, unsigned int vlen, unsigned int flags)
+{
+	int n;
+
+	CATCH_EINTR(n = sendmmsg(fd, (struct mmsghdr *) msgvec, vlen, flags));
+	/* some sockets return ENOBUFS instead of eagain */
+	if ((n < 0) && (errno == EAGAIN || errno == ENOBUFS))
+		return 0;
+	if (n >= 0)
+		return n;
+	else
+		return -errno;
+}
+
+int uml_vector_recvmmsg(int fd, void *msgvec, unsigned int vlen, unsigned int flags)
+{
+	int n;
+
+	CATCH_EINTR(n = recvmmsg(fd, (struct mmsghdr *) msgvec, vlen, flags, 0));
+	if ((n < 0) && (errno == EAGAIN))
+		return 0;
+	if (n >= 0)
+		return n;
+	else
+		return -errno;
+}
+int uml_vector_attach_bpf(int fd, void *bpf, int bpf_len)
+{
+	int err = setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, bpf, bpf_len);
+	if (err < 0)
+		printk(KERN_ERR "Failed to attach filter size %d to %d, err %d\n", bpf_len, fd, -errno);
+	return err;
+}
+
+#define DEFAULT_BPF_LEN 6
+
+void *uml_vector_default_bpf(int fd, void *mac)
+{
+	struct sock_filter *bpf;
+	uint32_t *mac1 = (uint32_t *)(mac + 2);
+	uint16_t *mac2 = (uint16_t *) mac ;
+	struct sock_fprog bpf_prog = {
+		.len = 6,
+		.filter = NULL,
+	};
+
+	bpf = uml_kmalloc(sizeof(struct sock_filter) * DEFAULT_BPF_LEN, UM_GFP_KERNEL);
+	if (bpf != NULL) {
+		bpf_prog.filter = bpf;
+		bpf[0] = (struct sock_filter){ 0x20, 0, 0, 0x00000008 }; /* ld	[8] */
+		bpf[1] = (struct sock_filter){ 0x15, 0, 3, ntohl(*mac1)};/* jeq	#0xMAC[2-6] jt 2 jf 5*/
+		bpf[2] = (struct sock_filter){ 0x28, 0, 0, 0x00000006 };/* ldh	[6] */
+		bpf[3] = (struct sock_filter){ 0x15, 0, 1, ntohs(*mac2)};/* jeq	#0xMAC[0-1] jt 4 jf 5 */
+		bpf[4] = (struct sock_filter){ 0x6, 0, 0, 0x00000000 };	/* ret	#0 */
+		bpf[5] = (struct sock_filter){ 0x6, 0, 0, 0x00040000 }; /* ret	#0x40000 */
+		if (uml_vector_attach_bpf(
+			fd, &bpf_prog, sizeof(struct sock_fprog)) < 0) {
+			kfree(bpf);
+			bpf = NULL;
+		}
+	}
+	return bpf;
+}
+
diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
new file mode 100644
index 000000000000..06dd643d5356
--- /dev/null
+++ b/arch/um/drivers/vector_user.h
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2002 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __UM_VECTOR_USER_H
+#define __UM_VECTOR_USER_H
+
+#define MAXVARGS	20
+
+#define TOKEN_IFNAME "ifname"
+
+#define TRANS_RAW "raw"
+#define TRANS_RAW_LEN strlen(TRANS_RAW)
+
+#define TRANS_TAP "tap"
+#define TRANS_TAP_LEN strlen(TRANS_TAP)
+
+
+#define TRANS_GRE "gre"
+#define TRANS_GRE_LEN strlen(TRANS_RAW)
+
+#define TRANS_L2TPV3 "l2tpv3"
+#define TRANS_L2TPV3_LEN strlen(TRANS_L2TPV3)
+
+#ifndef IPPROTO_GRE
+#define IPPROTO_GRE 0x2F
+#endif
+
+#define GRE_MODE_CHECKSUM	cpu_to_be16(8 << 12)	/* checksum */
+#define GRE_MODE_RESERVED	cpu_to_be16(4 << 12)	/* unused */
+#define GRE_MODE_KEY		cpu_to_be16(2 << 12)	/* KEY present */
+#define GRE_MODE_SEQUENCE	cpu_to_be16(1 << 12)	/* sequence */
+
+#define GRE_IRB cpu_to_be16(0x6558)
+
+#define L2TPV3_DATA_PACKET 0x30000
+
+/* IANA-assigned IP protocol ID for L2TPv3 */
+
+#ifndef IPPROTO_L2TP
+#define IPPROTO_L2TP 0x73
+#endif
+
+struct arglist {
+	int	numargs;
+	char	*tokens[MAXVARGS];
+	char	*values[MAXVARGS];
+};
+
+/* Separating read and write FDs allows us to have different
+ * rx and tx method. Example - read tap via raw socket using
+ * recvmmsg, write using legacy tap write calls
+ */
+
+struct vector_fds {
+	int rx_fd;
+	int tx_fd;
+	void *remote_addr;
+	int remote_addr_size;
+};
+
+#define VECTOR_READ	1
+#define VECTOR_WRITE	(1 < 1)
+#define VECTOR_HEADERS	(1 < 2)
+
+extern struct arglist *uml_parse_vector_ifspec(char *arg);
+
+extern struct vector_fds *uml_vector_user_open(
+	int unit,
+	struct arglist *parsed
+);
+
+extern char *uml_vector_fetch_arg(
+	struct arglist *ifspec,
+	char *token
+);
+
+extern int uml_vector_recvmsg(int fd, void *hdr, int flags);
+extern int uml_vector_sendmsg(int fd, void *hdr, int flags);
+extern int uml_vector_writev(int fd, void *hdr, int iovcount);
+extern int uml_vector_sendmmsg(int fd, void *msgvec, unsigned int vlen, unsigned int flags);
+extern int uml_vector_recvmmsg(int fd, void *msgvec, unsigned int vlen, unsigned int flags);
+extern void *uml_vector_default_bpf(int fd, void *mac);
+extern int uml_vector_attach_bpf(int fd, void *bpf, int bpf_len);
+extern bool uml_raw_enable_vnet_headers(int fd);
+extern bool uml_tap_enable_vnet_headers(int fd);
+
+
+#endif
diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
index 4a2037f8204b..ceb9ab274961 100644
--- a/arch/um/include/asm/irq.h
+++ b/arch/um/include/asm/irq.h
@@ -17,7 +17,19 @@
 #define XTERM_IRQ 		13
 #define RANDOM_IRQ 		14
 
+#ifdef CONFIG_UML_NET_VECTOR
+
+#define VECTOR_BASE_IRQ		15
+#define VECTOR_IRQ_SPACE	8
+
+#define LAST_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ)
+
+#else
+
 #define LAST_IRQ RANDOM_IRQ
+
+#endif
+
 #define NR_IRQS (LAST_IRQ + 1)
 
 #endif
diff --git a/arch/um/include/shared/net_kern.h b/arch/um/include/shared/net_kern.h
index 012ac87d4900..40442b98b173 100644
--- a/arch/um/include/shared/net_kern.h
+++ b/arch/um/include/shared/net_kern.h
@@ -65,5 +65,7 @@ extern int tap_setup_common(char *str, char *type, char **dev_name,
 			    char **mac_out, char **gate_addr);
 extern void register_transport(struct transport *new);
 extern unsigned short eth_protocol(struct sk_buff *skb);
+extern void uml_net_setup_etheraddr(struct net_device *dev, char *str);
+
 
 #endif
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

