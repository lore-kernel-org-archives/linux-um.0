Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ih9nL-0002dY-La
 for linux-um@lists.infradead.org; Tue, 17 Dec 2019 10:09:37 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v4 9/9] um: migrate daemon to vector backend
Date: Tue, 17 Dec 2019 10:09:13 +0000
Message-Id: <20191217100913.3422-9-anton.ivanov@cambridgegreys.com>
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

Removes old daemon packet-a-time code and migrates it to
vector backend

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/Makefile      |   2 -
 arch/um/drivers/daemon.h      |  29 -----
 arch/um/drivers/daemon_kern.c |  95 -----------------
 arch/um/drivers/daemon_user.c | 193 ----------------------------------
 arch/um/drivers/net_kern.c    |   4 +-
 arch/um/drivers/vector_kern.c |  21 ++++
 6 files changed, 23 insertions(+), 321 deletions(-)
 delete mode 100644 arch/um/drivers/daemon.h
 delete mode 100644 arch/um/drivers/daemon_kern.c
 delete mode 100644 arch/um/drivers/daemon_user.c

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index a283b395b4da..06448073dce6 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -8,7 +8,6 @@
 
 slip-objs := slip_kern.o slip_user.o
 slirp-objs := slirp_kern.o slirp_user.o
-daemon-objs := daemon_kern.o daemon_user.o
 vector-objs := vector_kern.o vector_user.o vector_transports.o
 net-objs := net_kern.o net_user.o
 mconsole-objs := mconsole_kern.o mconsole_user.o
@@ -42,7 +41,6 @@ obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
 
 obj-$(CONFIG_UML_NET_SLIP) += slip.o slip_common.o
 obj-$(CONFIG_UML_NET_SLIRP) += slirp.o slip_common.o
-obj-$(CONFIG_UML_NET_DAEMON) += daemon.o 
 obj-$(CONFIG_UML_NET_VECTOR) += vector.o
 obj-$(CONFIG_UML_NET_VDE) += vde.o
 obj-$(CONFIG_UML_NET_PCAP) += pcap.o
diff --git a/arch/um/drivers/daemon.h b/arch/um/drivers/daemon.h
deleted file mode 100644
index 1509cc7eb907..000000000000
--- a/arch/um/drivers/daemon.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- */
-
-#ifndef __DAEMON_H__
-#define __DAEMON_H__
-
-#include <net_user.h>
-
-#define SWITCH_VERSION 3
-
-struct daemon_data {
-	char *sock_type;
-	char *ctl_sock;
-	void *ctl_addr;
-	void *data_addr;
-	void *local_addr;
-	int fd;
-	int control;
-	void *dev;
-};
-
-extern const struct net_user_info daemon_user_info;
-
-extern int daemon_user_write(int fd, void *buf, int len,
-			     struct daemon_data *pri);
-
-#endif
diff --git a/arch/um/drivers/daemon_kern.c b/arch/um/drivers/daemon_kern.c
deleted file mode 100644
index fd2402669c49..000000000000
--- a/arch/um/drivers/daemon_kern.c
+++ /dev/null
@@ -1,95 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
- * James Leu (jleu@mindspring.net).
- * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Copyright (C) 2001 by various other people who didn't put their name here.
- */
-
-#include <linux/init.h>
-#include <linux/netdevice.h>
-#include <net_kern.h>
-#include "daemon.h"
-
-struct daemon_init {
-	char *sock_type;
-	char *ctl_sock;
-};
-
-static void daemon_init(struct net_device *dev, void *data)
-{
-	struct uml_net_private *pri;
-	struct daemon_data *dpri;
-	struct daemon_init *init = data;
-
-	pri = netdev_priv(dev);
-	dpri = (struct daemon_data *) pri->user;
-	dpri->sock_type = init->sock_type;
-	dpri->ctl_sock = init->ctl_sock;
-	dpri->fd = -1;
-	dpri->control = -1;
-	dpri->dev = dev;
-	/* We will free this pointer. If it contains crap we're burned. */
-	dpri->ctl_addr = NULL;
-	dpri->data_addr = NULL;
-	dpri->local_addr = NULL;
-
-	printk("daemon backend (uml_switch version %d) - %s:%s",
-	       SWITCH_VERSION, dpri->sock_type, dpri->ctl_sock);
-	printk("\n");
-}
-
-static int daemon_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
-{
-	return net_recvfrom(fd, skb_mac_header(skb),
-			    skb->dev->mtu + ETH_HEADER_OTHER);
-}
-
-static int daemon_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
-{
-	return daemon_user_write(fd, skb->data, skb->len,
-				 (struct daemon_data *) &lp->user);
-}
-
-static const struct net_kern_info daemon_kern_info = {
-	.init			= daemon_init,
-	.protocol		= eth_protocol,
-	.read			= daemon_read,
-	.write			= daemon_write,
-};
-
-static int daemon_setup(char *str, char **mac_out, void *data)
-{
-	struct daemon_init *init = data;
-	char *remain;
-
-	*init = ((struct daemon_init)
-		{ .sock_type 		= "unix",
-		  .ctl_sock 		= "/tmp/uml.ctl" });
-
-	remain = split_if_spec(str, mac_out, &init->sock_type, &init->ctl_sock,
-			       NULL);
-	if (remain != NULL)
-		printk(KERN_WARNING "daemon_setup : Ignoring data socket "
-		       "specification\n");
-
-	return 1;
-}
-
-static struct transport daemon_transport = {
-	.list 		= LIST_HEAD_INIT(daemon_transport.list),
-	.name 		= "daemon",
-	.setup  	= daemon_setup,
-	.user 		= &daemon_user_info,
-	.kern 		= &daemon_kern_info,
-	.private_size 	= sizeof(struct daemon_data),
-	.setup_size 	= sizeof(struct daemon_init),
-};
-
-static int register_daemon(void)
-{
-	register_transport(&daemon_transport);
-	return 0;
-}
-
-late_initcall(register_daemon);
diff --git a/arch/um/drivers/daemon_user.c b/arch/um/drivers/daemon_user.c
deleted file mode 100644
index 3695821d06a2..000000000000
--- a/arch/um/drivers/daemon_user.c
+++ /dev/null
@@ -1,193 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
- * James Leu (jleu@mindspring.net).
- * Copyright (C) 2001 by various other people who didn't put their name here.
- */
-
-#include <stdint.h>
-#include <unistd.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/time.h>
-#include <sys/un.h>
-#include "daemon.h"
-#include <net_user.h>
-#include <os.h>
-#include <um_malloc.h>
-
-enum request_type { REQ_NEW_CONTROL };
-
-#define SWITCH_MAGIC 0xfeedface
-
-struct request_v3 {
-	uint32_t magic;
-	uint32_t version;
-	enum request_type type;
-	struct sockaddr_un sock;
-};
-
-static struct sockaddr_un *new_addr(void *name, int len)
-{
-	struct sockaddr_un *sun;
-
-	sun = uml_kmalloc(sizeof(struct sockaddr_un), UM_GFP_KERNEL);
-	if (sun == NULL) {
-		printk(UM_KERN_ERR "new_addr: allocation of sockaddr_un "
-		       "failed\n");
-		return NULL;
-	}
-	sun->sun_family = AF_UNIX;
-	memcpy(sun->sun_path, name, len);
-	return sun;
-}
-
-static int connect_to_switch(struct daemon_data *pri)
-{
-	struct sockaddr_un *ctl_addr = pri->ctl_addr;
-	struct sockaddr_un *local_addr = pri->local_addr;
-	struct sockaddr_un *sun;
-	struct request_v3 req;
-	int fd, n, err;
-
-	pri->control = socket(AF_UNIX, SOCK_STREAM, 0);
-	if (pri->control < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "daemon_open : control socket failed, "
-		       "errno = %d\n", -err);
-		return err;
-	}
-
-	if (connect(pri->control, (struct sockaddr *) ctl_addr,
-		   sizeof(*ctl_addr)) < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "daemon_open : control connect failed, "
-		       "errno = %d\n", -err);
-		goto out;
-	}
-
-	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
-	if (fd < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "daemon_open : data socket failed, "
-		       "errno = %d\n", -err);
-		goto out;
-	}
-	if (bind(fd, (struct sockaddr *) local_addr, sizeof(*local_addr)) < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "daemon_open : data bind failed, "
-		       "errno = %d\n", -err);
-		goto out_close;
-	}
-
-	sun = uml_kmalloc(sizeof(struct sockaddr_un), UM_GFP_KERNEL);
-	if (sun == NULL) {
-		printk(UM_KERN_ERR "new_addr: allocation of sockaddr_un "
-		       "failed\n");
-		err = -ENOMEM;
-		goto out_close;
-	}
-
-	req.magic = SWITCH_MAGIC;
-	req.version = SWITCH_VERSION;
-	req.type = REQ_NEW_CONTROL;
-	req.sock = *local_addr;
-	n = write(pri->control, &req, sizeof(req));
-	if (n != sizeof(req)) {
-		printk(UM_KERN_ERR "daemon_open : control setup request "
-		       "failed, err = %d\n", -errno);
-		err = -ENOTCONN;
-		goto out_free;
-	}
-
-	n = read(pri->control, sun, sizeof(*sun));
-	if (n != sizeof(*sun)) {
-		printk(UM_KERN_ERR "daemon_open : read of data socket failed, "
-		       "err = %d\n", -errno);
-		err = -ENOTCONN;
-		goto out_free;
-	}
-
-	pri->data_addr = sun;
-	return fd;
-
- out_free:
-	kfree(sun);
- out_close:
-	close(fd);
- out:
-	close(pri->control);
-	return err;
-}
-
-static int daemon_user_init(void *data, void *dev)
-{
-	struct daemon_data *pri = data;
-	struct timeval tv;
-	struct {
-		char zero;
-		int pid;
-		int usecs;
-	} name;
-
-	if (!strcmp(pri->sock_type, "unix"))
-		pri->ctl_addr = new_addr(pri->ctl_sock,
-					 strlen(pri->ctl_sock) + 1);
-	name.zero = 0;
-	name.pid = os_getpid();
-	gettimeofday(&tv, NULL);
-	name.usecs = tv.tv_usec;
-	pri->local_addr = new_addr(&name, sizeof(name));
-	pri->dev = dev;
-	pri->fd = connect_to_switch(pri);
-	if (pri->fd < 0) {
-		kfree(pri->local_addr);
-		pri->local_addr = NULL;
-		return pri->fd;
-	}
-
-	return 0;
-}
-
-static int daemon_open(void *data)
-{
-	struct daemon_data *pri = data;
-	return pri->fd;
-}
-
-static void daemon_remove(void *data)
-{
-	struct daemon_data *pri = data;
-
-	close(pri->fd);
-	pri->fd = -1;
-	close(pri->control);
-	pri->control = -1;
-
-	kfree(pri->data_addr);
-	pri->data_addr = NULL;
-	kfree(pri->ctl_addr);
-	pri->ctl_addr = NULL;
-	kfree(pri->local_addr);
-	pri->local_addr = NULL;
-}
-
-int daemon_user_write(int fd, void *buf, int len, struct daemon_data *pri)
-{
-	struct sockaddr_un *data_addr = pri->data_addr;
-
-	return net_sendto(fd, buf, len, data_addr, sizeof(*data_addr));
-}
-
-const struct net_user_info daemon_user_info = {
-	.init		= daemon_user_init,
-	.open		= daemon_open,
-	.close	 	= NULL,
-	.remove	 	= daemon_remove,
-	.add_address	= NULL,
-	.delete_address = NULL,
-	.mtu		= ETH_MAX_PACKET,
-	.max_packet	= ETH_MAX_PACKET + ETH_HEADER_OTHER,
-};
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 21de09942ea6..b5de5ad43547 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -42,8 +42,8 @@ static DEFINE_SPINLOCK(drop_lock);
 static struct sk_buff *drop_skb;
 static int drop_max;
 
-static const char *migrated_to_vector[] = {"pcap", "ucast", "mcast", "tuntap"};
-#define MAX_MIGRATED 4
+static const char *migrated_to_vector[] = {"pcap", "ucast", "mcast", "tuntap", "daemon"};
+#define MAX_MIGRATED 5
 
 static int update_drop_skb(int max)
 {
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index aba2dc634f44..fcd8465fe335 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1712,6 +1712,27 @@ int vector_compat_eth_configure(char *str, int index)
 		kfree(newargs);
 		return -ENOMEM;
 	}
+#ifdef CONFIG_UML_NET_DAEMON
+	if (strncmp(str, "daemon", strlen("daemon")) == 0) {
+		char *proto = NULL, *control = NULL, *transport = NULL, *mac = NULL;
+
+		remain = split_if_spec(str, &transport, &proto, &control, &mac, NULL);
+
+		if ((mac != NULL) && strlen(mac) > 0)
+			snprintf(tempargs, MAX_COMPAT_ARG, "transport=daemon,mac=%s", mac);
+		else
+			snprintf(tempargs, MAX_COMPAT_ARG, "transport=daemon");
+
+		strcpy(newargs, tempargs);
+
+		if (control != NULL) {
+			snprintf(tempargs, MAX_COMPAT_ARG, "%s,dst=%s", newargs, control);
+			strcpy(newargs, tempargs);
+		}
+
+		do_compat = 1;
+	}
+#endif
 #ifdef CONFIG_UML_NET_TUNTAP
 	if (strncmp(str, "tuntap", strlen("tuntap")) == 0) {
 		char *ifname = NULL, *script = NULL, *gateway = NULL, *transport = NULL, *mac = NULL;
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

