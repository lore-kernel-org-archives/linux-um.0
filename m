Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ih9nA-0002Xa-PL
 for linux-um@lists.infradead.org; Tue, 17 Dec 2019 10:09:27 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v4 3/9] um: Migrate socket transport to Vector backend
Date: Tue, 17 Dec 2019 10:09:07 +0000
Message-Id: <20191217100913.3422-3-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20191217100913.3422-1-anton.ivanov@cambridgegreys.com>
References: <20191217100913.3422-1-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, brendanhiggins@google.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Moves legacy socket transport to the vector IO backend

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/Makefile      |   2 -
 arch/um/drivers/net_kern.c    |   4 +-
 arch/um/drivers/umcast.h      |  27 -----
 arch/um/drivers/umcast_kern.c | 188 ----------------------------------
 arch/um/drivers/umcast_user.c | 184 ---------------------------------
 arch/um/drivers/vector_kern.c |  31 ++++++
 6 files changed, 33 insertions(+), 403 deletions(-)
 delete mode 100644 arch/um/drivers/umcast.h
 delete mode 100644 arch/um/drivers/umcast_kern.c
 delete mode 100644 arch/um/drivers/umcast_user.c

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index ea449dc72236..a283b395b4da 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -10,7 +10,6 @@ slip-objs := slip_kern.o slip_user.o
 slirp-objs := slirp_kern.o slirp_user.o
 daemon-objs := daemon_kern.o daemon_user.o
 vector-objs := vector_kern.o vector_user.o vector_transports.o
-umcast-objs := umcast_kern.o umcast_user.o
 net-objs := net_kern.o net_user.o
 mconsole-objs := mconsole_kern.o mconsole_user.o
 hostaudio-objs := hostaudio_kern.o
@@ -46,7 +45,6 @@ obj-$(CONFIG_UML_NET_SLIRP) += slirp.o slip_common.o
 obj-$(CONFIG_UML_NET_DAEMON) += daemon.o 
 obj-$(CONFIG_UML_NET_VECTOR) += vector.o
 obj-$(CONFIG_UML_NET_VDE) += vde.o
-obj-$(CONFIG_UML_NET_MCAST) += umcast.o
 obj-$(CONFIG_UML_NET_PCAP) += pcap.o
 obj-$(CONFIG_UML_NET) += net.o 
 obj-$(CONFIG_MCONSOLE) += mconsole.o
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 821107c75582..597c38d517fc 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -42,8 +42,8 @@ static DEFINE_SPINLOCK(drop_lock);
 static struct sk_buff *drop_skb;
 static int drop_max;
 
-static const char *migrated_to_vector[] = {"pcap"};
-#define MAX_MIGRATED 1
+static const char *migrated_to_vector[] = {"pcap", "ucast", "mcast"};
+#define MAX_MIGRATED 3
 
 static int update_drop_skb(int max)
 {
diff --git a/arch/um/drivers/umcast.h b/arch/um/drivers/umcast.h
deleted file mode 100644
index fe39bee1e3bd..000000000000
--- a/arch/um/drivers/umcast.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- */
-
-#ifndef __DRIVERS_UMCAST_H
-#define __DRIVERS_UMCAST_H
-
-#include <net_user.h>
-
-struct umcast_data {
-	char *addr;
-	unsigned short lport;
-	unsigned short rport;
-	void *listen_addr;
-	void *remote_addr;
-	int ttl;
-	int unicast;
-	void *dev;
-};
-
-extern const struct net_user_info umcast_user_info;
-
-extern int umcast_user_write(int fd, void *buf, int len,
-			     struct umcast_data *pri);
-
-#endif
diff --git a/arch/um/drivers/umcast_kern.c b/arch/um/drivers/umcast_kern.c
deleted file mode 100644
index 595a54f2b9c6..000000000000
--- a/arch/um/drivers/umcast_kern.c
+++ /dev/null
@@ -1,188 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * user-mode-linux networking multicast transport
- * Copyright (C) 2001 by Harald Welte <laforge@gnumonks.org>
- * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- *
- * based on the existing uml-networking code, which is
- * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
- * James Leu (jleu@mindspring.net).
- * Copyright (C) 2001 by various other people who didn't put their name here.
- *
- */
-
-#include <linux/init.h>
-#include <linux/netdevice.h>
-#include "umcast.h"
-#include <net_kern.h>
-
-struct umcast_init {
-	char *addr;
-	int lport;
-	int rport;
-	int ttl;
-	bool unicast;
-};
-
-static void umcast_init(struct net_device *dev, void *data)
-{
-	struct uml_net_private *pri;
-	struct umcast_data *dpri;
-	struct umcast_init *init = data;
-
-	pri = netdev_priv(dev);
-	dpri = (struct umcast_data *) pri->user;
-	dpri->addr = init->addr;
-	dpri->lport = init->lport;
-	dpri->rport = init->rport;
-	dpri->unicast = init->unicast;
-	dpri->ttl = init->ttl;
-	dpri->dev = dev;
-
-	if (dpri->unicast) {
-		printk(KERN_INFO "ucast backend address: %s:%u listen port: "
-		       "%u\n", dpri->addr, dpri->rport, dpri->lport);
-	} else {
-		printk(KERN_INFO "mcast backend multicast address: %s:%u, "
-		       "TTL:%u\n", dpri->addr, dpri->lport, dpri->ttl);
-	}
-}
-
-static int umcast_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
-{
-	return net_recvfrom(fd, skb_mac_header(skb),
-			    skb->dev->mtu + ETH_HEADER_OTHER);
-}
-
-static int umcast_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
-{
-	return umcast_user_write(fd, skb->data, skb->len,
-				(struct umcast_data *) &lp->user);
-}
-
-static const struct net_kern_info umcast_kern_info = {
-	.init			= umcast_init,
-	.protocol		= eth_protocol,
-	.read			= umcast_read,
-	.write			= umcast_write,
-};
-
-static int mcast_setup(char *str, char **mac_out, void *data)
-{
-	struct umcast_init *init = data;
-	char *port_str = NULL, *ttl_str = NULL, *remain;
-	char *last;
-
-	*init = ((struct umcast_init)
-		{ .addr	= "239.192.168.1",
-		  .lport	= 1102,
-		  .ttl	= 1 });
-
-	remain = split_if_spec(str, mac_out, &init->addr, &port_str, &ttl_str,
-			       NULL);
-	if (remain != NULL) {
-		printk(KERN_ERR "mcast_setup - Extra garbage on "
-		       "specification : '%s'\n", remain);
-		return 0;
-	}
-
-	if (port_str != NULL) {
-		init->lport = simple_strtoul(port_str, &last, 10);
-		if ((*last != '\0') || (last == port_str)) {
-			printk(KERN_ERR "mcast_setup - Bad port : '%s'\n",
-			       port_str);
-			return 0;
-		}
-	}
-
-	if (ttl_str != NULL) {
-		init->ttl = simple_strtoul(ttl_str, &last, 10);
-		if ((*last != '\0') || (last == ttl_str)) {
-			printk(KERN_ERR "mcast_setup - Bad ttl : '%s'\n",
-			       ttl_str);
-			return 0;
-		}
-	}
-
-	init->unicast = false;
-	init->rport = init->lport;
-
-	printk(KERN_INFO "Configured mcast device: %s:%u-%u\n", init->addr,
-	       init->lport, init->ttl);
-
-	return 1;
-}
-
-static int ucast_setup(char *str, char **mac_out, void *data)
-{
-	struct umcast_init *init = data;
-	char *lport_str = NULL, *rport_str = NULL, *remain;
-	char *last;
-
-	*init = ((struct umcast_init)
-		{ .addr		= "",
-		  .lport	= 1102,
-		  .rport	= 1102 });
-
-	remain = split_if_spec(str, mac_out, &init->addr,
-			       &lport_str, &rport_str, NULL);
-	if (remain != NULL) {
-		printk(KERN_ERR "ucast_setup - Extra garbage on "
-		       "specification : '%s'\n", remain);
-		return 0;
-	}
-
-	if (lport_str != NULL) {
-		init->lport = simple_strtoul(lport_str, &last, 10);
-		if ((*last != '\0') || (last == lport_str)) {
-			printk(KERN_ERR "ucast_setup - Bad listen port : "
-			       "'%s'\n", lport_str);
-			return 0;
-		}
-	}
-
-	if (rport_str != NULL) {
-		init->rport = simple_strtoul(rport_str, &last, 10);
-		if ((*last != '\0') || (last == rport_str)) {
-			printk(KERN_ERR "ucast_setup - Bad remote port : "
-			       "'%s'\n", rport_str);
-			return 0;
-		}
-	}
-
-	init->unicast = true;
-
-	printk(KERN_INFO "Configured ucast device: :%u -> %s:%u\n",
-	       init->lport, init->addr, init->rport);
-
-	return 1;
-}
-
-static struct transport mcast_transport = {
-	.list	= LIST_HEAD_INIT(mcast_transport.list),
-	.name	= "mcast",
-	.setup	= mcast_setup,
-	.user	= &umcast_user_info,
-	.kern	= &umcast_kern_info,
-	.private_size	= sizeof(struct umcast_data),
-	.setup_size	= sizeof(struct umcast_init),
-};
-
-static struct transport ucast_transport = {
-	.list	= LIST_HEAD_INIT(ucast_transport.list),
-	.name	= "ucast",
-	.setup	= ucast_setup,
-	.user	= &umcast_user_info,
-	.kern	= &umcast_kern_info,
-	.private_size	= sizeof(struct umcast_data),
-	.setup_size	= sizeof(struct umcast_init),
-};
-
-static int register_umcast(void)
-{
-	register_transport(&mcast_transport);
-	register_transport(&ucast_transport);
-	return 0;
-}
-
-late_initcall(register_umcast);
diff --git a/arch/um/drivers/umcast_user.c b/arch/um/drivers/umcast_user.c
deleted file mode 100644
index b50b13cff04e..000000000000
--- a/arch/um/drivers/umcast_user.c
+++ /dev/null
@@ -1,184 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * user-mode-linux networking multicast transport
- * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Copyright (C) 2001 by Harald Welte <laforge@gnumonks.org>
- *
- * based on the existing uml-networking code, which is
- * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
- * James Leu (jleu@mindspring.net).
- * Copyright (C) 2001 by various other people who didn't put their name here.
- *
- *
- */
-
-#include <unistd.h>
-#include <errno.h>
-#include <netinet/in.h>
-#include "umcast.h"
-#include <net_user.h>
-#include <um_malloc.h>
-
-static struct sockaddr_in *new_addr(char *addr, unsigned short port)
-{
-	struct sockaddr_in *sin;
-
-	sin = uml_kmalloc(sizeof(struct sockaddr_in), UM_GFP_KERNEL);
-	if (sin == NULL) {
-		printk(UM_KERN_ERR "new_addr: allocation of sockaddr_in "
-		       "failed\n");
-		return NULL;
-	}
-	sin->sin_family = AF_INET;
-	if (addr)
-		sin->sin_addr.s_addr = in_aton(addr);
-	else
-		sin->sin_addr.s_addr = INADDR_ANY;
-	sin->sin_port = htons(port);
-	return sin;
-}
-
-static int umcast_user_init(void *data, void *dev)
-{
-	struct umcast_data *pri = data;
-
-	pri->remote_addr = new_addr(pri->addr, pri->rport);
-	if (pri->unicast)
-		pri->listen_addr = new_addr(NULL, pri->lport);
-	else
-		pri->listen_addr = pri->remote_addr;
-	pri->dev = dev;
-	return 0;
-}
-
-static void umcast_remove(void *data)
-{
-	struct umcast_data *pri = data;
-
-	kfree(pri->listen_addr);
-	if (pri->unicast)
-		kfree(pri->remote_addr);
-	pri->listen_addr = pri->remote_addr = NULL;
-}
-
-static int umcast_open(void *data)
-{
-	struct umcast_data *pri = data;
-	struct sockaddr_in *lsin = pri->listen_addr;
-	struct sockaddr_in *rsin = pri->remote_addr;
-	struct ip_mreq mreq;
-	int fd, yes = 1, err = -EINVAL;
-
-
-	if ((!pri->unicast && lsin->sin_addr.s_addr == 0) ||
-	    (rsin->sin_addr.s_addr == 0) ||
-	    (lsin->sin_port == 0) || (rsin->sin_port == 0))
-		goto out;
-
-	fd = socket(AF_INET, SOCK_DGRAM, 0);
-
-	if (fd < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "umcast_open : data socket failed, "
-		       "errno = %d\n", errno);
-		goto out;
-	}
-
-	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes)) < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "umcast_open: SO_REUSEADDR failed, "
-		       "errno = %d\n", errno);
-		goto out_close;
-	}
-
-	if (!pri->unicast) {
-		/* set ttl according to config */
-		if (setsockopt(fd, SOL_IP, IP_MULTICAST_TTL, &pri->ttl,
-			       sizeof(pri->ttl)) < 0) {
-			err = -errno;
-			printk(UM_KERN_ERR "umcast_open: IP_MULTICAST_TTL "
-			       "failed, error = %d\n", errno);
-			goto out_close;
-		}
-
-		/* set LOOP, so data does get fed back to local sockets */
-		if (setsockopt(fd, SOL_IP, IP_MULTICAST_LOOP,
-			       &yes, sizeof(yes)) < 0) {
-			err = -errno;
-			printk(UM_KERN_ERR "umcast_open: IP_MULTICAST_LOOP "
-			       "failed, error = %d\n", errno);
-			goto out_close;
-		}
-	}
-
-	/* bind socket to the address */
-	if (bind(fd, (struct sockaddr *) lsin, sizeof(*lsin)) < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "umcast_open : data bind failed, "
-		       "errno = %d\n", errno);
-		goto out_close;
-	}
-
-	if (!pri->unicast) {
-		/* subscribe to the multicast group */
-		mreq.imr_multiaddr.s_addr = lsin->sin_addr.s_addr;
-		mreq.imr_interface.s_addr = 0;
-		if (setsockopt(fd, SOL_IP, IP_ADD_MEMBERSHIP,
-			       &mreq, sizeof(mreq)) < 0) {
-			err = -errno;
-			printk(UM_KERN_ERR "umcast_open: IP_ADD_MEMBERSHIP "
-			       "failed, error = %d\n", errno);
-			printk(UM_KERN_ERR "There appears not to be a "
-			       "multicast-capable network interface on the "
-			       "host.\n");
-			printk(UM_KERN_ERR "eth0 should be configured in order "
-			       "to use the multicast transport.\n");
-			goto out_close;
-		}
-	}
-
-	return fd;
-
- out_close:
-	close(fd);
- out:
-	return err;
-}
-
-static void umcast_close(int fd, void *data)
-{
-	struct umcast_data *pri = data;
-
-	if (!pri->unicast) {
-		struct ip_mreq mreq;
-		struct sockaddr_in *lsin = pri->listen_addr;
-
-		mreq.imr_multiaddr.s_addr = lsin->sin_addr.s_addr;
-		mreq.imr_interface.s_addr = 0;
-		if (setsockopt(fd, SOL_IP, IP_DROP_MEMBERSHIP,
-			       &mreq, sizeof(mreq)) < 0) {
-			printk(UM_KERN_ERR "umcast_close: IP_DROP_MEMBERSHIP "
-			       "failed, error = %d\n", errno);
-		}
-	}
-
-	close(fd);
-}
-
-int umcast_user_write(int fd, void *buf, int len, struct umcast_data *pri)
-{
-	struct sockaddr_in *data_addr = pri->remote_addr;
-
-	return net_sendto(fd, buf, len, data_addr, sizeof(*data_addr));
-}
-
-const struct net_user_info umcast_user_info = {
-	.init	= umcast_user_init,
-	.open	= umcast_open,
-	.close	= umcast_close,
-	.remove	= umcast_remove,
-	.add_address	= NULL,
-	.delete_address = NULL,
-	.mtu	= ETH_MAX_PACKET,
-	.max_packet	= ETH_MAX_PACKET + ETH_HEADER_OTHER,
-};
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 1388f09e09ea..234081ad4f02 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1740,6 +1740,37 @@ int vector_compat_eth_configure(char *str, int index)
 
 	}
 #endif
+#ifdef CONFIG_UM_NET_MCAST
+	if ((strncmp(str, "ucast", strlen("ucast")) == 0) || (strncmp(str, "mcast", strlen("mcast")) == 0)) {
+		char *src, *addr = NULL, *transport = NULL, *mac = NULL, *srcport = NULL, *dstport = NULL;
+
+		if (strncmp(str, "ucast", strlen("ucast")) == 0)
+			src = "0.0.0.0";
+		else
+			src = addr;
+
+		remain = split_if_spec(str, &transport, &addr, &srcport, &dstport, &mac, NULL);
+
+		if (!srcport)
+			srcport = "1102";
+
+		if (!dstport)
+			dstport = "1102";
+
+		if ((mac != NULL) && strlen(mac) > 0)
+			snprintf(tempargs, MAX_COMPAT_ARG, "transport=%s,src=%s,dst=%s,srcport=%s,dstport=%s,mac=%s",
+					transport, src, addr, srcport, dstport, mac);
+		else
+			snprintf(tempargs, MAX_COMPAT_ARG, "transport=%s,src=%s,dst=%s,srcport=%s,dstrport=%s",
+					transport, src, addr, srcport, dstport);
+
+		strcpy(newargs, tempargs);
+
+
+		do_compat = 1;
+
+	}
+#endif
 	if (do_compat) {
 		parsed = uml_parse_vector_ifspec(newargs);
 		vector_eth_configure(index, parsed, true);
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

