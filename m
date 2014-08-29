Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XNH3F-0007nT-TZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2014 07:56:53 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XNH3D-0002l2-M4
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Aug 2014 07:56:53 +0000
From: anton.ivanov@kot-begemot.co.uk
Date: Fri, 29 Aug 2014 08:56:42 +0100
Message-Id: <1409299002-139263-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
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
Subject: [uml-devel] [PATCHv2 3/10] High performance networking subsystem
To: user-mode-linux-devel@lists.sourceforge.net

From: Anton Ivanov <antivano@cisco.com>

    Support for multi-packet vector IO - multiple packets
    read in one syscall and written in one syscall. Should work with
    legacy UML, thorough tested only for the epoll based IRQ controller

    Minimal host kernel version for RX - 2.6.32
    Minimal host kernel version for TX - 3.0

    Tested on Debian 7.0/Ubuntu 12.x LTS which have the relevant
    syscalls, but do not have the appropriate glibc routine for TX
    (this is why it is a direct syscall).

Signed-off-by: Anton Ivanov <antivano@cisco.com>
---

I have missed net_extra_* on the original submission, this is a resubmit.
Apologies.

 arch/um/drivers/Makefile          |    2 +-
 arch/um/drivers/net_extra_kern.c  |  218 +++++++++++++++++++++++++
 arch/um/drivers/net_extra_user.c  |  319 +++++++++++++++++++++++++++++++++++++
 arch/um/drivers/net_kern.c        |   63 +++++---
 arch/um/include/asm/irq.h         |   26 +--
 arch/um/include/shared/net_kern.h |   24 +++
 arch/um/include/shared/net_user.h |   24 +++
 arch/um/kernel/irq.c              |    3 +
 8 files changed, 646 insertions(+), 33 deletions(-)
 create mode 100644 arch/um/drivers/net_extra_kern.c
 create mode 100644 arch/um/drivers/net_extra_user.c

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index e7582e1..836baaf 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -10,7 +10,7 @@ slip-objs := slip_kern.o slip_user.o
 slirp-objs := slirp_kern.o slirp_user.o
 daemon-objs := daemon_kern.o daemon_user.o
 umcast-objs := umcast_kern.o umcast_user.o
-net-objs := net_kern.o net_user.o
+net-objs := net_kern.o net_user.o net_extra_user.o net_extra_kern.o
 mconsole-objs := mconsole_kern.o mconsole_user.o
 hostaudio-objs := hostaudio_kern.o
 ubd-objs := ubd_kern.o ubd_user.o
diff --git a/arch/um/drivers/net_extra_kern.c b/arch/um/drivers/net_extra_kern.c
new file mode 100644
index 0000000..b1d36d8
--- /dev/null
+++ b/arch/um/drivers/net_extra_kern.c
@@ -0,0 +1,218 @@
+/*
+ * Copyright (C) 2012 - 2014 Cisco Systems
+ * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
+ * James Leu (jleu@mindspring.net).
+ * Copyright (C) 2001 by various other people who didn't put their name here.
+ * Licensed under the GPL.
+ */
+
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
+#include <linux/spinlock.h>
+#include "init.h"
+#include "irq_kern.h"
+#include "irq_user.h"
+#include "mconsole_kern.h"
+#include "net_kern.h"
+#include "net_user.h"
+
+#define DRIVER_NAME "uml-netdev"
+
+/* 
+	These are wrappers around key kernel side functions so we can
+	invoke them from the user side of our Schizofreniac self
+
+*/
+
+extern spinlock_t uml_sigio_lock;
+extern int in_epoll_loop;
+
+static DEFINE_SPINLOCK(net_queue_list);
+
+static struct mmsg_queue_info * pending_queue = NULL;
+
+void uml_net_destroy_skb(void * skb)
+{
+	if (skb) {
+		kfree_skb((struct sk_buff *) skb);
+	}
+}
+
+void * uml_net_build_skb (void * dev)
+{
+	struct uml_net_private *lp = netdev_priv((struct net_device *) dev);
+	struct sk_buff * skb;
+
+	skb =  dev_alloc_skb(lp->max_packet + 32);
+	if (skb) {
+	/* add some tunneling space just in case, we usually do not need it as we use vector IO */
+		skb_reserve(skb,32);	
+		skb->dev = dev;
+		skb_put(skb, lp->max_packet);
+		skb_reset_mac_header(skb);
+		skb->ip_summed =  CHECKSUM_NONE;
+	} else {
+		printk("Failed Atomic SKB Allocation, will drop\n");
+	}
+	return skb;
+}
+
+void * uml_net_skb_data (void * skb) {
+	if (skb) {
+		return ((struct sk_buff *) skb)->data;
+	} else {
+		printk("hole in vector!!!\n");
+		return NULL;
+	}
+}
+
+
+int uml_net_advance_head( struct mmsg_queue_info * queue_info, int advance)
+{
+	int queue_depth;
+	queue_info->head = 
+		(queue_info->head + advance) 
+			% queue_info->max_depth;
+
+	/* caller is already holding the head_lock */
+
+	spin_lock(&queue_info->tail_lock);
+	queue_info->queue_depth -= advance;
+	queue_depth = queue_info->queue_depth;
+	spin_unlock(&queue_info->tail_lock);
+	return queue_depth;
+}
+
+/* 
+	This is called by enqueuers which should hold the
+	head lock already
+*/ 
+
+int uml_net_advance_tail( struct mmsg_queue_info * queue_info, int advance) 
+{
+	int queue_depth;
+	queue_info->tail = 
+		(queue_info->tail + advance) 
+			% queue_info->max_depth;
+	spin_lock(&queue_info->head_lock);
+	queue_info->queue_depth += advance;
+	queue_depth = queue_info->queue_depth;
+	spin_unlock(&queue_info->head_lock);
+	return queue_depth;
+}
+
+
+static int flush_mmsg_queue(struct mmsg_queue_info * queue_info, int queue_depth) 
+{
+	int fd = queue_info->fd;
+	struct mmsghdr * send_from;
+	void ** skb_send_vector;
+	int result = 0, send_len, skb_index, allowed_drop = 0;
+
+	if (! queue_info) {
+		/* someone passed a null queue, should not occur */
+		return 0;
+	}
+
+	if (spin_trylock(&queue_info->head_lock))   {
+		if (spin_trylock(&queue_info->tail_lock)) { 
+			/* update queue_depth */
+			queue_depth = queue_info->queue_depth;
+			spin_unlock(&queue_info->tail_lock); 
+			if (queue_depth > 0) {
+				do {
+					send_len = queue_depth;
+					send_from = queue_info->mmsg_send_vector;
+					send_from += queue_info->head;
+					if (send_len + queue_info->head > queue_info->max_depth) {
+						send_len = queue_info->max_depth - queue_info->head;
+					}
+					if (send_len > 0) {
+						result = net_sendmmsg(
+						    fd, send_from, send_len, 0
+						);
+						if (send_len == result) {
+							/* clear drop allowance */
+							allowed_drop = 0;
+						} else {
+							/* first time we just retry */
+							result = result + allowed_drop;
+							if (send_len - result < 0) {
+								result = send_len;
+							}
+							allowed_drop = (allowed_drop + 1) * 2;
+						}
+					}
+					if (result > 0) {
+						skb_send_vector = queue_info->skb_send_vector;
+						skb_send_vector += queue_info->head;
+						for (skb_index = 0; skb_index < result; skb_index++) {
+							uml_net_destroy_skb(* skb_send_vector);
+							(* skb_send_vector) = NULL; /* just in case */
+							skb_send_vector ++ ;
+						}
+						queue_depth = uml_net_advance_head(queue_info, result);
+					} 
+				} while (
+					(send_len == result)  && /* we sent whatever we tried */
+					(queue_depth > 0)
+					);
+			} 
+		} 
+		spin_unlock(&queue_info->head_lock);
+	} 
+	return queue_depth;
+}
+
+int uml_net_flush_mmsg_queue(
+    struct mmsg_queue_info * queue_info,
+    int queue_depth
+) {
+
+	if (queue_depth >= (queue_info->max_depth - 1)) {
+		return flush_mmsg_queue(pending_queue, queue_depth);
+	}
+	if (spin_trylock(&uml_sigio_lock)) {
+		/* unconditional flush - end of epoll loop */
+		if (!(in_epoll_loop)) {
+			queue_depth = flush_mmsg_queue(queue_info, queue_depth);
+		}
+		spin_unlock(&uml_sigio_lock);
+	} 
+	
+	spin_lock(&net_queue_list);
+	if ((pending_queue) && (pending_queue != queue_info)) {
+		flush_mmsg_queue(pending_queue, queue_depth);
+		/* we need a packet drop procedure here */
+	} else {
+		queue_depth = 0;
+	}
+	pending_queue = queue_info;
+	spin_unlock(&net_queue_list);
+
+	return queue_depth;
+}
+
+void flush_pending_netio(void) {
+	int result; 
+	spin_lock(&net_queue_list);
+	if (pending_queue) {
+		do {
+			result = flush_mmsg_queue(pending_queue, 1);
+		} while (result > 0);
+	}
+	pending_queue = NULL;
+	spin_unlock(&net_queue_list);
+}
+
+
diff --git a/arch/um/drivers/net_extra_user.c b/arch/um/drivers/net_extra_user.c
new file mode 100644
index 0000000..f6715d1
--- /dev/null
+++ b/arch/um/drivers/net_extra_user.c
@@ -0,0 +1,319 @@
+/*
+ * Copyright (C) 2012 - 2014 Cisco Systems
+ * Licensed under the GPL
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdarg.h>
+#include <errno.h>
+#include <stddef.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <asm/unistd.h>
+#include "net_user.h"
+#include "os.h"
+#include "um_malloc.h"
+
+/* 
+* Principles of operation:
+*
+* EVERYTHING here is built to tolerate a failed memory allocation. 
+* If either a header buffer or a data buffer (taken from skb->data) 
+* is NULL the read will fail and the packet will be dropped. This 
+* is the normal behaviour of recvmsg and recvmmsg functions - if a 
+* particular iov_base == NULL and its corresponding iov_baselen is 
+* 0 we truncate and/or drop the packet altogether.
+*
+* On the negative side this means that we have to do a few more 
+* checks for NULL here and there. On the positive side this means 
+* that the whole thing is more robust including under low
+* memory conditions.
+*
+* There is one special case which we need to handle as a result of 
+* this - any header verification functions should return "broken 
+* header" on hitting a NULL. This will in turn invoke the applicable
+* packet drop logic.
+* 
+* Any changes should follow this overall design.
+*
+* Side effect - none of these need to use the shared (and mutexed) 
+* drop skb. This is surplus to reqs, the normal recvm(m)msg drop 
+* mechanics will drop it.
+*/
+
+int net_readv(int fd, void *iov, int iovcnt)
+{
+	int n;
+
+	CATCH_EINTR(n = readv(fd,  iov,  iovcnt));
+	if ((n < 0) && (errno == EAGAIN))
+		return 0;
+	else if (n == 0)
+		return -ENOTCONN;
+	return n;
+}
+
+int net_recvfrom2(int fd, void *buf, int len, void *src_addr, int *addrlen)
+{
+	int n;
+
+	CATCH_EINTR(n = recvfrom(fd,  buf,  len, 0, src_addr, addrlen));
+	if (n < 0) {
+		if (errno == EAGAIN)
+			return 0;
+		return -errno;
+	}
+	else if (n == 0)
+		return -ENOTCONN;
+	return n;
+}
+
+int net_writev(int fd, void *iov, int iovcnt)
+{
+	int n;
+
+	CATCH_EINTR(n = writev(fd, iov, iovcnt));
+
+	if ((n < 0) && (errno == EAGAIN))
+		return 0;
+	else if (n == 0)
+		return -ENOTCONN;
+	return n;
+}
+
+int net_sendmessage(int fd, void *msg, int flags)
+{
+	int n;
+
+	CATCH_EINTR(n = sendmsg(fd, msg, flags));
+	if (n < 0) {
+		if (errno == EAGAIN)
+			return 0;
+		return -errno;
+	}
+	else if (n == 0)
+		return -ENOTCONN;
+	return n;
+}
+int net_recvmessage(int fd, void *msg, int flags)
+{
+	int n;
+
+	CATCH_EINTR(n = recvmsg(fd, msg, flags));
+	if (n < 0) {
+		if (errno == EAGAIN)
+			return 0;
+		return -errno;
+	}
+	else if (n == 0)
+		return -ENOTCONN;
+	return n;
+}
+
+int net_recvmmsg(int fd, void *msgvec, unsigned int vlen,
+		    unsigned int flags, struct timespec *timeout)
+{
+	int n;
+
+	CATCH_EINTR(n = recvmmsg(fd, msgvec, vlen, flags, timeout));
+	if (n < 0) {
+		if (errno == EAGAIN)
+			return 0;
+		return -errno;
+	}
+	else if (n == 0)
+		return -ENOTCONN;
+	return n;
+}
+
+int net_sendmmsg(int fd, void *msgvec, unsigned int vlen,
+		    unsigned int flags)
+{
+	int n;
+
+#ifdef HAS_SENDMMSG 
+
+    /* has proper sendmmsg */
+
+	CATCH_EINTR(n = sendmmsg(fd, msgvec, vlen, flags));
+#else
+
+    /* no glibc wrapper for sendmmsg - Ubuntu LTS 12.04, Debian 7.x */
+
+	CATCH_EINTR(n = syscall(__NR_sendmmsg, fd, msgvec, vlen, flags));
+#endif
+	if (n < 0) {
+		if (errno == EAGAIN)
+			return 0;
+		return -errno;
+	}
+	else if (n == 0)
+		return -ENOTCONN;
+	return n;
+}
+
+void destroy_skb_vector(void ** vector, int size)
+{
+	int i;
+	void ** tofree = vector;
+
+	for (i=0;i<size;i++) {
+		if ( * vector) {
+			uml_net_destroy_skb(* vector);
+		}
+	vector ++;
+	}
+	kfree(tofree);
+}
+
+void destroy_mmsg_vector(void * mmsgvector, int size, int free_iov_base)
+{
+	struct mmsghdr * vector = (struct mmsghdr *) mmsgvector;
+	struct iovec * iov;
+	int i;
+	if (vector) {
+		for (i = 0; i < size; i++) {
+			iov = vector->msg_hdr.msg_iov;
+			if (iov) {
+				if (free_iov_base) {
+					kfree(iov->iov_base);
+				}
+				kfree(iov);
+			}
+			vector ++;
+		}
+		kfree(mmsgvector);
+	} else {
+		printk("NULL mmsg vector in destroy, should not occur\n");
+	}
+}
+
+void * build_skbuf_vector(int size, void * dev)
+{
+	int i;
+	void **result, **vector;
+	result = uml_kmalloc(size * sizeof(void *), UM_GFP_KERNEL);
+	vector = result;
+	if (vector) {
+		for (i = 0; i < size; i++) {
+			* vector = uml_net_build_skb(dev);
+			vector++;
+		}
+	}
+	return result;
+}  
+
+void rebuild_skbuf_vector(void ** skbvec, int size, void * dev)
+{
+	int i;
+	if (skbvec) {
+		for (i = 0; i < size; i++) {
+			* skbvec = uml_net_build_skb(dev);
+			skbvec++;
+		}
+	}
+}  
+
+void repair_mmsg (void *vec, int iovsize, int header_size)
+{
+	struct mmsghdr * msgvec = (struct mmsghdr *) vec;
+	struct iovec * iov;
+	if (! msgvec->msg_hdr.msg_iov) {
+		msgvec->msg_hdr.msg_iov = uml_kmalloc(sizeof(struct iovec) * iovsize, UM_GFP_KERNEL);
+	}
+	iov = msgvec->msg_hdr.msg_iov;
+	if (iov) {
+		if (! iov->iov_base) {
+			iov->iov_base=uml_kmalloc(header_size, UM_GFP_KERNEL);
+		}
+		if (iov->iov_base) {
+			/* put correct header size just in case - we may have had a short frame */
+			iov->iov_len = header_size; 
+		} else {
+			printk("failed to allocate a header buffer, will cause a packet drop later\n");
+			iov->iov_len = 0;
+		}
+	}
+}
+
+void * build_mmsg_vector(int size, int iovsize)
+{
+	int i;
+	struct mmsghdr *msgvec, *result;
+	struct iovec * iov;
+
+	result = uml_kmalloc(sizeof(struct mmsghdr) * size, UM_GFP_KERNEL);
+	msgvec = result;
+	if (msgvec) {
+		memset(msgvec, '\0', sizeof(struct mmsghdr) * size); 
+		for ( i = 0; i < size; i++) {
+			iov = uml_kmalloc(sizeof(struct iovec) * iovsize, UM_GFP_KERNEL);
+			msgvec->msg_hdr.msg_iov=iov;
+			if (iov) {
+				memset(iov, '\0', sizeof(struct iovec) * iovsize); 
+				msgvec->msg_hdr.msg_iovlen=iovsize;
+			} else {
+				printk("failed to allocate iov\n");
+				msgvec->msg_hdr.msg_iovlen=0; /* silent drop on receive, no xmit */
+			}
+			msgvec++;
+		}
+	}
+	return result;
+}
+
+void add_header_buffers(void * msgvec, int size, int header_size)
+{
+	int i;
+	struct iovec * iov;
+	struct mmsghdr * mmsgvec = (struct mmsghdr *) msgvec;
+	for ( i = 0; i < size; i++) {
+		iov = mmsgvec->msg_hdr.msg_iov;
+		if (iov) {
+	    		iov->iov_base=uml_kmalloc(header_size, UM_GFP_KERNEL);
+			if (iov->iov_base) {
+				iov->iov_len = header_size;
+			} else {
+				printk("failed to allocate a header buffer, will cause a packet drop later\n");
+				iov->iov_len = 0;
+			}
+		} 
+	mmsgvec++;
+	}
+}
+
+/* NOTE - this is only for offset = 0 or 1, other cases are unhandled!!! */
+
+void add_skbuffs(void * msgvec, void ** skbvec, int size, int skb_size, int offset) {
+	int i;
+	struct iovec * iov;
+	struct mmsghdr * mmsgvec = (struct mmsghdr *) msgvec;
+	for ( i = 0; i < size; i++) {
+	/* 
+	    This heavily relies on all IOVs being present, if the initial allocation 
+	    fails it must clean up and switch to "normal" per-packet receive instead
+	    Later allocations of skbufs can fail - this will result in short reads
+	    and skips
+
+	 */
+		iov = mmsgvec->msg_hdr.msg_iov;
+		if (iov) {
+			iov += offset; 
+			iov->iov_base=uml_net_skb_data(* skbvec);
+			if (iov->iov_base) {
+				iov->iov_len = skb_size;
+			} else {
+				printk("NULL SKB will drop\n");
+				iov->iov_len = 0;
+			}
+		} else {
+			printk("NULL IOV will drop\n");
+		}
+		mmsgvec++;
+		skbvec++;
+	}
+}
+
+
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 64d8426..1d253fa 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012 - 2014 Cisco Systems
  * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
  * James Leu (jleu@mindspring.net).
@@ -29,6 +30,7 @@
 
 static DEFINE_SPINLOCK(opened_lock);
 static LIST_HEAD(opened);
+static int rr_counter = 0;
 
 /*
  * The drop_skb is used when we can't allocate an skb.  The
@@ -42,6 +44,7 @@ static DEFINE_SPINLOCK(drop_lock);
 static struct sk_buff *drop_skb;
 static int drop_max;
 
+
 static int update_drop_skb(int max)
 {
 	struct sk_buff *new;
@@ -77,24 +80,38 @@ static int uml_net_rx(struct net_device *dev)
 	struct sk_buff *skb;
 
 	/* If we can't allocate memory, try again next round. */
-	skb = dev_alloc_skb(lp->max_packet);
-	if (skb == NULL) {
-		drop_skb->dev = dev;
-		/* Read a packet into drop_skb and don't do anything with it. */
-		(*lp->read)(lp->fd, drop_skb, lp);
-		dev->stats.rx_dropped++;
+	if (lp->options & UML_NET_USE_SKB_READ) {
+	    /* we expect a full formed, well behaved skb from zero copy drivers here */
+	    skb = (*lp->skb_read)(lp);
+	    if (skb == NULL) {
 		return 0;
-	}
-
-	skb->dev = dev;
-	skb_put(skb, lp->max_packet);
-	skb_reset_mac_header(skb);
-	pkt_len = (*lp->read)(lp->fd, skb, lp);
-
-	if (pkt_len > 0) {
+	    }
+	    pkt_len = skb->len;
+	} else {
+	    skb = dev_alloc_skb(lp->max_packet + 32);
+	    if (skb == NULL) {
+		    drop_skb->dev = dev;
+		    /* Read a packet into drop_skb and don't do anything with it. */
+		    (*lp->read)(lp->fd, drop_skb, lp);
+		    dev->stats.rx_dropped++;
+		    return 0;
+	    }
+
+	    skb_reserve(skb,32);
+	    skb->dev = dev;
+	    skb_put(skb, lp->max_packet);
+	    skb_reset_mac_header(skb);
+
+	    // Mark that virtual devices cannot provide required checksum.
+	    skb->ip_summed = CHECKSUM_NONE;
+	    pkt_len = (*lp->read)(lp->fd, skb, lp);
+	    if (pkt_len > 0) {
 		skb_trim(skb, pkt_len);
 		skb->protocol = (*lp->protocol)(skb);
+	    }
+	}
 
+	if (pkt_len > 0) {
 		dev->stats.rx_bytes += skb->len;
 		dev->stats.rx_packets++;
 		netif_rx(skb);
@@ -192,8 +209,9 @@ static int uml_net_close(struct net_device *dev)
 	struct uml_net_private *lp = netdev_priv(dev);
 
 	netif_stop_queue(dev);
+	deactivate_fd(lp->fd, dev->irq);
 
-	um_free_irq(dev->irq, dev);
+	free_irq(dev->irq, dev);
 	if (lp->close != NULL)
 		(*lp->close)(lp->fd, &lp->user);
 	lp->fd = -1;
@@ -216,7 +234,6 @@ static int uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	spin_lock_irqsave(&lp->lock, flags);
 
 	len = (*lp->write)(lp->fd, skb, lp);
-	skb_tx_timestamp(skb);
 
 	if (len == skb->len) {
 		dev->stats.tx_packets++;
@@ -273,14 +290,13 @@ static void uml_net_poll_controller(struct net_device *dev)
 static void uml_net_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
 {
-	strlcpy(info->driver, DRIVER_NAME, sizeof(info->driver));
-	strlcpy(info->version, "42", sizeof(info->version));
+	strcpy(info->driver, DRIVER_NAME);
+	strcpy(info->version, "42");
 }
 
 static const struct ethtool_ops uml_net_ethtool_ops = {
 	.get_drvinfo	= uml_net_get_drvinfo,
 	.get_link	= ethtool_op_get_link,
-	.get_ts_info	= ethtool_op_get_ts_info,
 };
 
 static void uml_net_user_timer_expire(unsigned long _conn)
@@ -447,6 +463,7 @@ static void eth_configure(int n, void *init, char *mac,
 	 * These just fill in a data structure, so there's no failure
 	 * to be worried about.
 	 */
+	dev->ethtool_ops = &uml_net_ethtool_ops;
 	(*transport->kern->init)(dev, init);
 
 	*lp = ((struct uml_net_private)
@@ -459,7 +476,9 @@ static void eth_configure(int n, void *init, char *mac,
 		  .open 		= transport->user->open,
 		  .close 		= transport->user->close,
 		  .remove 		= transport->user->remove,
+		  .options 		= transport->kern->options,
 		  .read 		= transport->kern->read,
+		  .skb_read 		= transport->kern->skb_read,
 		  .write 		= transport->kern->write,
 		  .add_address 		= transport->user->add_address,
 		  .delete_address  	= transport->user->delete_address });
@@ -475,9 +494,9 @@ static void eth_configure(int n, void *init, char *mac,
 
 	dev->mtu = transport->user->mtu;
 	dev->netdev_ops = &uml_netdev_ops;
-	dev->ethtool_ops = &uml_net_ethtool_ops;
 	dev->watchdog_timeo = (HZ >> 1);
-	dev->irq = UM_ETH_IRQ;
+	dev->irq = UM_ETH_BASE_IRQ + (rr_counter % UM_ETH_IRQ_RR); 
+	rr_counter++;
 
 	err = update_drop_skb(lp->max_packet);
 	if (err)
@@ -829,7 +848,7 @@ static void close_devices(void)
 	spin_lock(&opened_lock);
 	list_for_each(ele, &opened) {
 		lp = list_entry(ele, struct uml_net_private, list);
-		um_free_irq(lp->dev->irq, lp->dev);
+		free_irq(lp->dev->irq, lp->dev);
 		if ((lp->close != NULL) && (lp->fd >= 0))
 			(*lp->close)(lp->fd, &lp->user);
 		if (lp->remove != NULL)
diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
index 4a2037f..be9128b 100644
--- a/arch/um/include/asm/irq.h
+++ b/arch/um/include/asm/irq.h
@@ -1,21 +1,27 @@
+
 #ifndef __UM_IRQ_H
 #define __UM_IRQ_H
 
+#define UM_ETH_IRQ_RR	        32
+
 #define TIMER_IRQ		0
 #define UMN_IRQ			1
 #define CONSOLE_IRQ		2
 #define CONSOLE_WRITE_IRQ	3
 #define UBD_IRQ			4
-#define UM_ETH_IRQ		5
-#define SSL_IRQ			6
-#define SSL_WRITE_IRQ		7
-#define ACCEPT_IRQ		8
-#define MCONSOLE_IRQ		9
-#define WINCH_IRQ		10
-#define SIGIO_WRITE_IRQ 	11
-#define TELNETD_IRQ 		12
-#define XTERM_IRQ 		13
-#define RANDOM_IRQ 		14
+#define UM_ETH_BASE_IRQ		5
+
+#define UM_END_ETH_IRQ	        UM_ETH_BASE_IRQ + UM_ETH_IRQ_RR
+
+#define SSL_IRQ			UM_END_ETH_IRQ + 1
+#define SSL_WRITE_IRQ		UM_END_ETH_IRQ + 2
+#define ACCEPT_IRQ		UM_END_ETH_IRQ + 3
+#define MCONSOLE_IRQ		UM_END_ETH_IRQ + 4
+#define WINCH_IRQ		UM_END_ETH_IRQ + 5
+#define SIGIO_WRITE_IRQ 	UM_END_ETH_IRQ + 6
+#define TELNETD_IRQ 		UM_END_ETH_IRQ + 7
+#define XTERM_IRQ 		UM_END_ETH_IRQ + 8
+#define RANDOM_IRQ 		UM_END_ETH_IRQ + 9
 
 #define LAST_IRQ RANDOM_IRQ
 #define NR_IRQS (LAST_IRQ + 1)
diff --git a/arch/um/include/shared/net_kern.h b/arch/um/include/shared/net_kern.h
index 012ac87..2229126 100644
--- a/arch/um/include/shared/net_kern.h
+++ b/arch/um/include/shared/net_kern.h
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012 - 2014 Cisco Systems
  * Copyright (C) 2002 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
@@ -13,6 +14,8 @@
 #include <linux/list.h>
 #include <linux/workqueue.h>
 
+#define UML_NET_USE_SKB_READ 1
+
 struct uml_net {
 	struct list_head list;
 	struct net_device *dev;
@@ -28,6 +31,7 @@ struct uml_net_private {
 
 	struct work_struct work;
 	int fd;
+	unsigned int options;
 	unsigned char mac[ETH_ALEN];
 	int max_packet;
 	unsigned short (*protocol)(struct sk_buff *);
@@ -36,6 +40,7 @@ struct uml_net_private {
 	void (*remove)(void *);
 	int (*read)(int, struct sk_buff *skb, struct uml_net_private *);
 	int (*write)(int, struct sk_buff *skb, struct uml_net_private *);
+	struct sk_buff * (*skb_read)(struct uml_net_private *);
 
 	void (*add_address)(unsigned char *, unsigned char *, void *);
 	void (*delete_address)(unsigned char *, unsigned char *, void *);
@@ -47,6 +52,8 @@ struct net_kern_info {
 	unsigned short (*protocol)(struct sk_buff *);
 	int (*read)(int, struct sk_buff *skb, struct uml_net_private *);
 	int (*write)(int, struct sk_buff *skb, struct uml_net_private *);
+	struct sk_buff * (*skb_read)(struct uml_net_private *);
+	unsigned int options;
 };
 
 struct transport {
@@ -59,11 +66,28 @@ struct transport {
 	const int setup_size;
 };
 
+struct mmsg_queue_info {
+	int fd;
+	struct mmsghdr * mmsg_send_vector; 
+	void ** skb_send_vector;
+	int queue_depth, head, tail, max_depth;
+	spinlock_t head_lock; 
+	spinlock_t tail_lock; 
+	unsigned int queue_fsm;
+};
+ 
 extern struct net_device *ether_init(int);
 extern unsigned short ether_protocol(struct sk_buff *);
 extern int tap_setup_common(char *str, char *type, char **dev_name,
 			    char **mac_out, char **gate_addr);
 extern void register_transport(struct transport *new);
 extern unsigned short eth_protocol(struct sk_buff *skb);
+extern struct sk_buff *my_build_skb(void * head, void *data, unsigned int frag_size);
+
+extern void flush_pending_netio(void);
+
+extern int uml_net_advance_tail( struct mmsg_queue_info * queue_info, int advance); 
+extern int uml_net_advance_head( struct mmsg_queue_info * queue_info, int advance); 
+extern int uml_net_flush_mmsg_queue(struct mmsg_queue_info * queue_info, int queue_depth);
 
 #endif
diff --git a/arch/um/include/shared/net_user.h b/arch/um/include/shared/net_user.h
index 3dabbe1..4b46f37 100644
--- a/arch/um/include/shared/net_user.h
+++ b/arch/um/include/shared/net_user.h
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2012 - 2014 Cisco Systems
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
@@ -38,10 +39,15 @@ extern void tap_check_ips(char *gate_addr, unsigned char *eth_addr);
 extern void read_output(int fd, char *output_out, int len);
 
 extern int net_read(int fd, void *buf, int len);
+extern int net_readv(int fd, void *iov, int iovcnt);
 extern int net_recvfrom(int fd, void *buf, int len);
+extern int net_recvfrom2(int fd, void *buf, int len, void *src_addr, int *addrlen);
 extern int net_write(int fd, void *buf, int len);
+extern int net_writev(int fd, void *iov, int iovcnt);
 extern int net_send(int fd, void *buf, int len);
 extern int net_sendto(int fd, void *buf, int len, void *to, int sock_len);
+extern int net_sendmessage(int fd, void *msg, int flags);
+extern int net_recvmessage(int fd, void *msg, int flags);
 
 extern void open_addr(unsigned char *addr, unsigned char *netmask, void *arg);
 extern void close_addr(unsigned char *addr, unsigned char *netmask, void *arg);
@@ -50,4 +56,22 @@ extern char *split_if_spec(char *str, ...);
 
 extern int dev_netmask(void *d, void *m);
 
+
+extern void uml_net_destroy_skb(void * skb);
+extern void * uml_net_build_skb (void * dev);
+extern void * uml_net_skb_data (void * skb);
+
+extern void add_skbuffs(void * msgvec, void ** skbvec, int size, int skb_size, int offset);
+extern void add_header_buffers(void * msgvec, int size, int header_size);
+extern void * build_mmsg_vector(int size, int iovsize);
+extern void rebuild_skbuf_vector(void ** skbvec, int size, void * dev);
+extern void * build_skbuf_vector(int size, void * dev);
+extern int net_recvmmsg(int fd, void *msgvec, unsigned int vlen,
+		unsigned int flags, struct timespec *timeout);
+extern int net_sendmmsg(int fd, void *msgvec, unsigned int vlen,
+		unsigned int flags);
+extern void repair_mmsg (void *msgvec, int iovsize, int header_size);
+extern void destroy_skb_vector(void ** vector, int size);
+extern void destroy_mmsg_vector(void * mmsgvector, int size, int free_iov_base);
+
 #endif
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 5d7ee49e..f4c6fb1 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -17,6 +17,7 @@
 #include <as-layout.h>
 #include <kern_util.h>
 #include <os.h>
+#include <net_kern.h>
 
 /*
 *	We are on the "kernel side" so we cannot pick up the sys/epoll.h 
@@ -136,6 +137,8 @@ void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 		spin_unlock_irqrestore(&uml_sigio_lock, flags);
 	}
 
+	flush_pending_netio();
+
 	/* This needs a better way - it slows down the event loop */
 
 	free_irqs();
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

