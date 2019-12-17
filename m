Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ih9n7-0002Wm-Ou
 for linux-um@lists.infradead.org; Tue, 17 Dec 2019 10:09:25 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v4 1/9] um: Migrate pcap to vector IO
Date: Tue, 17 Dec 2019 10:09:05 +0000
Message-Id: <20191217100913.3422-1-anton.ivanov@cambridgegreys.com>
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

Migrates UML PCAP driver to the new vector IO network backend.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/Makefile          |   4 +-
 arch/um/drivers/net_kern.c        |  33 ++++++-
 arch/um/drivers/pcap_kern.c       | 113 -----------------------
 arch/um/drivers/pcap_user.c       | 144 +++++++-----------------------
 arch/um/drivers/pcap_user.h       |  21 -----
 arch/um/drivers/vector_kern.c     | 100 +++++++++++++++++++--
 arch/um/drivers/vector_kern.h     |   3 -
 arch/um/drivers/vector_user.c     |  12 +++
 arch/um/drivers/vector_user.h     |   1 -
 arch/um/include/shared/net_kern.h |   2 +-
 arch/um/include/shared/net_user.h |   2 +
 11 files changed, 173 insertions(+), 262 deletions(-)
 delete mode 100644 arch/um/drivers/pcap_kern.c
 delete mode 100644 arch/um/drivers/pcap_user.h

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index a290821e355c..ea449dc72236 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -22,9 +22,9 @@ LDFLAGS_pcap.o := -r $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
 
 LDFLAGS_vde.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
 
-targets := pcap_kern.o pcap_user.o vde_kern.o vde_user.o
+targets := pcap_user.o vde_kern.o vde_user.o
 
-$(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)/pcap_user.o
+$(obj)/pcap.o: $(obj)/pcap_user.o
 	$(LD) -r -dp -o $@ $^ $(ld_flags)
 
 $(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 327b728f7244..821107c75582 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -42,6 +42,9 @@ static DEFINE_SPINLOCK(drop_lock);
 static struct sk_buff *drop_skb;
 static int drop_max;
 
+static const char *migrated_to_vector[] = {"pcap"};
+#define MAX_MIGRATED 1
+
 static int update_drop_skb(int max)
 {
 	struct sk_buff *new;
@@ -581,6 +584,26 @@ static int check_transport(struct transport *transport, char *eth, int n,
 	}
 	return 1;
 }
+static int register_compat(void)
+{
+	struct list_head *ele, *next;
+	struct eth_init *eth;
+	int compat;
+
+	list_for_each_safe(ele, next, &eth_cmd_line) {
+		eth = list_entry(ele, struct eth_init, list);
+		for (compat = 0; compat < MAX_MIGRATED; compat++) {
+			if (strncmp(eth->init, &migrated_to_vector[compat], strlen(&migrated_to_vector[compat])) == 0) {
+				vector_compat_eth_configure(eth->init, eth->index);
+				list_del(&eth->list);
+				continue;
+			}
+		}
+	}
+	return 0;
+}
+
+late_initcall(register_compat);
 
 void register_transport(struct transport *new)
 {
@@ -597,8 +620,9 @@ void register_transport(struct transport *new)
 
 	list_for_each_safe(ele, next, &eth_cmd_line) {
 		eth = list_entry(ele, struct eth_init, list);
+
 		match = check_transport(new, eth->init, eth->index, &init,
-					&mac, GFP_KERNEL);
+				&mac, GFP_KERNEL);
 		if (!match)
 			continue;
 		else if (init != NULL) {
@@ -615,7 +639,12 @@ static int eth_setup_common(char *str, int index)
 	struct transport *transport;
 	void *init;
 	char *mac = NULL;
-	int found = 0;
+	int found = 0, compat;
+
+	for (compat = 0; compat < MAX_MIGRATED; compat++) {
+		if (strncmp(str, &migrated_to_vector[compat], strlen(&migrated_to_vector[compat])) == 0)
+			return vector_compat_eth_configure(str, index);
+	}
 
 	spin_lock(&transports_lock);
 	list_for_each(ele, &transports) {
diff --git a/arch/um/drivers/pcap_kern.c b/arch/um/drivers/pcap_kern.c
deleted file mode 100644
index cfe4cb17694c..000000000000
--- a/arch/um/drivers/pcap_kern.c
+++ /dev/null
@@ -1,113 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- */
-
-#include <linux/init.h>
-#include <linux/netdevice.h>
-#include <net_kern.h>
-#include "pcap_user.h"
-
-struct pcap_init {
-	char *host_if;
-	int promisc;
-	int optimize;
-	char *filter;
-};
-
-void pcap_init(struct net_device *dev, void *data)
-{
-	struct uml_net_private *pri;
-	struct pcap_data *ppri;
-	struct pcap_init *init = data;
-
-	pri = netdev_priv(dev);
-	ppri = (struct pcap_data *) pri->user;
-	ppri->host_if = init->host_if;
-	ppri->promisc = init->promisc;
-	ppri->optimize = init->optimize;
-	ppri->filter = init->filter;
-
-	printk("pcap backend, host interface %s\n", ppri->host_if);
-}
-
-static int pcap_read(int fd, struct sk_buff *skb, struct uml_net_private *lp)
-{
-	return pcap_user_read(fd, skb_mac_header(skb),
-			      skb->dev->mtu + ETH_HEADER_OTHER,
-			      (struct pcap_data *) &lp->user);
-}
-
-static int pcap_write(int fd, struct sk_buff *skb, struct uml_net_private *lp)
-{
-	return -EPERM;
-}
-
-static const struct net_kern_info pcap_kern_info = {
-	.init			= pcap_init,
-	.protocol		= eth_protocol,
-	.read			= pcap_read,
-	.write			= pcap_write,
-};
-
-int pcap_setup(char *str, char **mac_out, void *data)
-{
-	struct pcap_init *init = data;
-	char *remain, *host_if = NULL, *options[2] = { NULL, NULL };
-	int i;
-
-	*init = ((struct pcap_init)
-		{ .host_if 	= "eth0",
-		  .promisc 	= 1,
-		  .optimize 	= 0,
-		  .filter 	= NULL });
-
-	remain = split_if_spec(str, &host_if, &init->filter,
-			       &options[0], &options[1], mac_out, NULL);
-	if (remain != NULL) {
-		printk(KERN_ERR "pcap_setup - Extra garbage on "
-		       "specification : '%s'\n", remain);
-		return 0;
-	}
-
-	if (host_if != NULL)
-		init->host_if = host_if;
-
-	for (i = 0; i < ARRAY_SIZE(options); i++) {
-		if (options[i] == NULL)
-			continue;
-		if (!strcmp(options[i], "promisc"))
-			init->promisc = 1;
-		else if (!strcmp(options[i], "nopromisc"))
-			init->promisc = 0;
-		else if (!strcmp(options[i], "optimize"))
-			init->optimize = 1;
-		else if (!strcmp(options[i], "nooptimize"))
-			init->optimize = 0;
-		else {
-			printk(KERN_ERR "pcap_setup : bad option - '%s'\n",
-			       options[i]);
-			return 0;
-		}
-	}
-
-	return 1;
-}
-
-static struct transport pcap_transport = {
-	.list 		= LIST_HEAD_INIT(pcap_transport.list),
-	.name 		= "pcap",
-	.setup  	= pcap_setup,
-	.user 		= &pcap_user_info,
-	.kern 		= &pcap_kern_info,
-	.private_size 	= sizeof(struct pcap_data),
-	.setup_size 	= sizeof(struct pcap_init),
-};
-
-static int register_pcap(void)
-{
-	register_transport(&pcap_transport);
-	return 0;
-}
-
-late_initcall(register_pcap);
diff --git a/arch/um/drivers/pcap_user.c b/arch/um/drivers/pcap_user.c
index bbd20638788a..0b49a2e76c9a 100644
--- a/arch/um/drivers/pcap_user.c
+++ b/arch/um/drivers/pcap_user.c
@@ -8,130 +8,50 @@
 #include <string.h>
 #include <asm/types.h>
 #include <net_user.h>
-#include "pcap_user.h"
+#include <sys/socket.h>
+#include <linux/filter.h>
 #include <um_malloc.h>
 
-#define PCAP_FD(p) (*(int *)(p))
-
-static int pcap_user_init(void *data, void *dev)
+void *uml_vector_compile_pcap(char *filter, int optimize)
 {
-	struct pcap_data *pri = data;
-	pcap_t *p;
-	char errors[PCAP_ERRBUF_SIZE];
-
-	p = pcap_open_live(pri->host_if, ETH_MAX_PACKET + ETH_HEADER_OTHER,
-			   pri->promisc, 0, errors);
-	if (p == NULL) {
-		printk(UM_KERN_ERR "pcap_user_init : pcap_open_live failed - "
-		       "'%s'\n", errors);
-		return -EINVAL;
-	}
+	struct sock_fprog *bpf_prog = NULL;
+	struct bpf_program *pcap_prog = NULL;
 
-	pri->dev = dev;
-	pri->pcap = p;
-	return 0;
-}
-
-static int pcap_open(void *data)
-{
-	struct pcap_data *pri = data;
-	__u32 netmask;
-	int err;
+	if (filter == NULL)
+		return NULL;
 
-	if (pri->pcap == NULL)
-		return -ENODEV;
+	pcap_prog = uml_kmalloc(sizeof(struct bpf_program), UM_GFP_KERNEL);
+	if (!pcap_prog)
+		goto pcap_failed;
 
-	if (pri->filter != NULL) {
-		err = dev_netmask(pri->dev, &netmask);
-		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_open : dev_netmask failed\n");
-			return -EIO;
-		}
+	bpf_prog = uml_kmalloc(sizeof(struct sock_fprog), UM_GFP_KERNEL);
+	if (!bpf_prog)
+		goto pcap_failed;
+	else
+		bpf_prog->filter = NULL;
 
-		pri->compiled = uml_kmalloc(sizeof(struct bpf_program),
-					UM_GFP_KERNEL);
-		if (pri->compiled == NULL) {
-			printk(UM_KERN_ERR "pcap_open : kmalloc failed\n");
-			return -ENOMEM;
-		}
-
-		err = pcap_compile(pri->pcap,
-				   (struct bpf_program *) pri->compiled,
-				   pri->filter, pri->optimize, netmask);
-		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_open : pcap_compile failed - "
-			       "'%s'\n", pcap_geterr(pri->pcap));
-			goto out;
-		}
-
-		err = pcap_setfilter(pri->pcap, pri->compiled);
-		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_open : pcap_setfilter "
-			       "failed - '%s'\n", pcap_geterr(pri->pcap));
-			goto out;
-		}
+	if (pcap_compile_nopcap((1 < 16) - 1, DLT_EN10MB, pcap_prog, filter, optimize, PCAP_NETMASK_UNKNOWN)) {
+		printk(KERN_ERR "Failed to compile filter");
+		goto pcap_failed;
 	}
 
-	return PCAP_FD(pri->pcap);
-
- out:
-	kfree(pri->compiled);
-	return -EIO;
-}
-
-static void pcap_remove(void *data)
-{
-	struct pcap_data *pri = data;
-
-	if (pri->compiled != NULL)
-		pcap_freecode(pri->compiled);
-
-	if (pri->pcap != NULL)
-		pcap_close(pri->pcap);
-}
-
-struct pcap_handler_data {
-	char *buffer;
-	int len;
-};
+	bpf_prog->filter = uml_kmalloc(pcap_prog->bf_len * sizeof(struct bpf_insn), UM_GFP_KERNEL);
 
-static void handler(u_char *data, const struct pcap_pkthdr *header,
-		    const u_char *packet)
-{
-	int len;
+	if (bpf_prog->filter == NULL) {
+		printk(KERN_ERR "Failed to allocate bpf buffer");
+		pcap_freecode(pcap_prog);
+		goto pcap_failed;
+	}
+	bpf_prog->len = pcap_prog->bf_len;
+	memcpy(bpf_prog->filter, pcap_prog->bf_insns, pcap_prog->bf_len * sizeof(struct bpf_insn));
 
-	struct pcap_handler_data *hdata = (struct pcap_handler_data *) data;
+	pcap_freecode(pcap_prog);
+	return bpf_prog;
 
-	len = hdata->len < header->caplen ? hdata->len : header->caplen;
-	memcpy(hdata->buffer, packet, len);
-	hdata->len = len;
+pcap_failed:
+	kfree(pcap_prog);
+	kfree(bpf_prog);
+	return NULL;
 }
 
-int pcap_user_read(int fd, void *buffer, int len, struct pcap_data *pri)
-{
-	struct pcap_handler_data hdata = ((struct pcap_handler_data)
-		                          { .buffer  	= buffer,
-					    .len 	= len });
-	int n;
-
-	n = pcap_dispatch(pri->pcap, 1, handler, (u_char *) &hdata);
-	if (n < 0) {
-		printk(UM_KERN_ERR "pcap_dispatch failed - %s\n",
-		       pcap_geterr(pri->pcap));
-		return -EIO;
-	}
-	else if (n == 0)
-		return 0;
-	return hdata.len;
-}
 
-const struct net_user_info pcap_user_info = {
-	.init		= pcap_user_init,
-	.open		= pcap_open,
-	.close	 	= NULL,
-	.remove	 	= pcap_remove,
-	.add_address	= NULL,
-	.delete_address = NULL,
-	.mtu		= ETH_MAX_PACKET,
-	.max_packet	= ETH_MAX_PACKET + ETH_HEADER_OTHER,
-};
diff --git a/arch/um/drivers/pcap_user.h b/arch/um/drivers/pcap_user.h
deleted file mode 100644
index 216246f5f09b..000000000000
--- a/arch/um/drivers/pcap_user.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- */
-
-#include <net_user.h>
-
-struct pcap_data {
-	char *host_if;
-	int promisc;
-	int optimize;
-	char *filter;
-	void *compiled;
-	void *pcap;
-	void *dev;
-};
-
-extern const struct net_user_info pcap_user_info;
-
-extern int pcap_user_read(int fd, void *buf, int len, struct pcap_data *pri);
-
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 92617e16829e..933adf2009dc 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -28,6 +28,7 @@
 #include <irq_kern.h>
 #include <irq_user.h>
 #include <net_kern.h>
+#include <net_user.h>
 #include <os.h>
 #include "mconsole_kern.h"
 #include "vector_user.h"
@@ -46,6 +47,7 @@
 
 
 #define DRIVER_NAME "uml-vector"
+#define DRIVER_CNAME "uml-vector-compat"
 #define DRIVER_VERSION "01"
 struct vector_cmd_line_arg {
 	struct list_head list;
@@ -68,7 +70,7 @@ static LIST_HEAD(vector_devices);
 
 static int driver_registered;
 
-static void vector_eth_configure(int n, struct arglist *def);
+static void vector_eth_configure(int n, struct arglist *def, bool compat);
 
 /* Argument accessors to set variables (and/or set default values)
  * mtu, buffer sizing, default headroom, etc
@@ -101,6 +103,7 @@ static const struct {
 };
 
 #define VECTOR_NUM_STATS	ARRAY_SIZE(ethtool_stats_keys)
+#define MAX_COMPAT_ARG 256
 
 static void vector_reset_stats(struct vector_private *vp)
 {
@@ -131,11 +134,28 @@ static int get_mtu(struct arglist *def)
 	return ETH_MAX_PACKET;
 }
 
+static int get_optimize(struct arglist *def)
+{
+	char *opt = uml_vector_fetch_arg(def, "optimize");
+	long result;
+
+	if (opt != NULL) {
+		if (kstrtoul(opt, 10, &result) == 0)
+			return result;
+	}
+	return 0;
+}
+
 static char *get_bpf_file(struct arglist *def)
 {
 	return uml_vector_fetch_arg(def, "bpffile");
 }
 
+static char *get_pcap_filter(struct arglist *def)
+{
+	return uml_vector_fetch_arg(def, "filter");
+}
+
 static bool get_bpf_flash(struct arglist *def)
 {
 	char *allow = uml_vector_fetch_arg(def, "bpfflash");
@@ -772,7 +792,7 @@ static int vector_config(char *str, char **error_out)
 		return -EINVAL;
 	}
 
-	vector_eth_configure(n, parsed);
+	vector_eth_configure(n, parsed, false);
 	return 0;
 }
 
@@ -1225,7 +1245,14 @@ static int vector_net_open(struct net_device *dev)
 	vp->opened = true;
 	spin_unlock_irqrestore(&vp->lock, flags);
 
-	vp->bpf = uml_vector_user_bpf(get_bpf_file(vp->parsed));
+#ifdef CONFIG_UML_NET_PCAP
+	vp->bpf = uml_vector_compile_pcap(get_pcap_filter(vp->parsed), get_optimize(vp->parsed));
+#else
+	vp->bpf = NULL;
+#endif
+
+	if (!vp->bpf)
+		vp->bpf = uml_vector_user_bpf(get_bpf_file(vp->parsed));
 
 	vp->fds = uml_vector_user_open(vp->unit, vp->parsed);
 
@@ -1547,7 +1574,8 @@ static void vector_timer_expire(struct timer_list *t)
 
 static void vector_eth_configure(
 		int n,
-		struct arglist *def
+		struct arglist *def,
+		bool compat
 	)
 {
 	struct vector_device *device;
@@ -1577,7 +1605,10 @@ static void vector_eth_configure(
 	 * netdevice, that is OK, register_netdev{,ice}() will notice this
 	 * and fail.
 	 */
-	snprintf(dev->name, sizeof(dev->name), "vec%d", n);
+	if (compat)
+		snprintf(dev->name, sizeof(dev->name), "eth%d", n);
+	else
+		snprintf(dev->name, sizeof(dev->name), "vec%d", n);
 	uml_net_setup_etheraddr(dev, uml_vector_fetch_arg(def, "mac"));
 	vp = netdev_priv(dev);
 
@@ -1587,7 +1618,10 @@ static void vector_eth_configure(
 		driver_registered = 1;
 	}
 	device->pdev.id = n;
-	device->pdev.name = DRIVER_NAME;
+	if (compat)
+		device->pdev.name = DRIVER_CNAME;
+	else
+		device->pdev.name = DRIVER_NAME;
 	device->pdev.dev.release = vector_device_release;
 	dev_set_drvdata(&device->pdev.dev, device);
 	if (platform_device_register(&device->pdev))
@@ -1660,7 +1694,59 @@ static void vector_eth_configure(
 	kfree(device);
 }
 
+int vector_compat_eth_configure(char *str, int index)
+{
+	char *newargs, *tempargs;
+	char *remain;
+	int do_compat = 0;
+	struct arglist *parsed;
+	newargs = kmalloc(GFP_KERNEL, MAX_COMPAT_ARG);
+	if (!newargs)
+		return -ENOMEM;
+	tempargs = kmalloc(GFP_KERNEL, MAX_COMPAT_ARG);
+	if (!tempargs) {
+		kfree(newargs);
+		return -ENOMEM;
+	}
+	if (strncmp(str, "pcap", strlen("pcap")) == 0) {
+		char *ifname = NULL, *filter = NULL, *transport = NULL, *mac = NULL;
+		char *options[2] = { NULL, NULL};
+
+		remain = split_if_spec(str, &transport, &ifname, &filter,
+			       &options[0], &options[1], &mac, NULL);
+
+		if ((mac != NULL) && strlen(mac) > 0)
+			snprintf(tempargs, MAX_COMPAT_ARG, "transport=raw,ifname=%s,mac=%s", ifname, mac);
+		else
+			snprintf(tempargs, MAX_COMPAT_ARG, "transport=raw,ifname=%s", ifname);
+
+		strcpy(newargs, tempargs);
+
+		if (filter != NULL) {
+			snprintf(tempargs, MAX_COMPAT_ARG, "%s,filter=%s", newargs, filter);
+			strcpy(newargs, tempargs);
+		}
 
+		if (options[0] != NULL) {
+			snprintf(tempargs, MAX_COMPAT_ARG, "%s,%s=1", newargs, options[0]);
+			strcpy(newargs, tempargs);
+		}
+		if (options[1] != NULL) {
+			snprintf(tempargs, MAX_COMPAT_ARG, "%s,%s=1", newargs, options[1]);
+			strcpy(newargs, tempargs);
+		}
+		do_compat = 1;
+
+	}
+	if (do_compat) {
+		parsed = uml_parse_vector_ifspec(newargs);
+		vector_eth_configure(index, parsed, true);
+	} else
+		kfree(newargs);
+
+	kfree(tempargs);
+	return 0;
+}
 
 
 /*
@@ -1677,7 +1763,7 @@ static int __init vector_init(void)
 		def = list_entry(ele, struct vector_cmd_line_arg, list);
 		parsed = uml_parse_vector_ifspec(def->arguments);
 		if (parsed != NULL)
-			vector_eth_configure(def->unit, parsed);
+			vector_eth_configure(def->unit, parsed, false);
 	}
 	return 0;
 }
diff --git a/arch/um/drivers/vector_kern.h b/arch/um/drivers/vector_kern.h
index d0159082faf0..e643423dfc2f 100644
--- a/arch/um/drivers/vector_kern.h
+++ b/arch/um/drivers/vector_kern.h
@@ -31,9 +31,6 @@
 #define VECTOR_QDISC_BYPASS (1 << 3)
 #define VECTOR_BPF_FLASH (1 << 4)
 
-#define ETH_MAX_PACKET 1500
-#define ETH_HEADER_OTHER 32 /* just in case someone decides to go mad on QnQ */
-
 #define MAX_FILTER_PROG (2 << 16)
 
 struct vector_queue {
diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index ddcd917be0af..c8a11df080d2 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -367,6 +367,17 @@ static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 		err = -errno;
 		goto raw_cleanup;
 	}
+
+	if (uml_vector_fetch_arg(ifspec, "promisc")) {
+		struct ifreq ifopts;
+
+		memset(&ifopts, 0, sizeof(struct ifreq));
+		strncpy(ifopts.ifr_name, iface, IFNAMSIZ-1);
+		ioctl(rxfd, SIOCGIFFLAGS, &ifopts);
+		ifopts.ifr_flags |= IFF_PROMISC;
+		ioctl(rxfd, SIOCSIFFLAGS, &ifopts);
+	}
+
 	txfd = create_raw_fd(iface, 0, ETH_P_IP); /* Turn off RX on this fd */
 	if (txfd == -1) {
 		err = -errno;
@@ -764,3 +775,4 @@ void *uml_vector_user_bpf(char *filename)
 	kfree(bpf_prog);
 	return NULL;
 }
+
diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
index 91f35b266aba..a4acfebd28d5 100644
--- a/arch/um/drivers/vector_user.h
+++ b/arch/um/drivers/vector_user.h
@@ -105,5 +105,4 @@ extern bool uml_raw_enable_qdisc_bypass(int fd);
 extern bool uml_raw_enable_vnet_headers(int fd);
 extern bool uml_tap_enable_vnet_headers(int fd);
 
-
 #endif
diff --git a/arch/um/include/shared/net_kern.h b/arch/um/include/shared/net_kern.h
index a87be13c5b87..f9389a2ec2d8 100644
--- a/arch/um/include/shared/net_kern.h
+++ b/arch/um/include/shared/net_kern.h
@@ -66,6 +66,6 @@ extern int tap_setup_common(char *str, char *type, char **dev_name,
 extern void register_transport(struct transport *new);
 extern unsigned short eth_protocol(struct sk_buff *skb);
 extern void uml_net_setup_etheraddr(struct net_device *dev, char *str);
-
+extern int vector_compat_eth_configure(char *str, int index);
 
 #endif
diff --git a/arch/um/include/shared/net_user.h b/arch/um/include/shared/net_user.h
index 1b0531769a5e..b523e469256c 100644
--- a/arch/um/include/shared/net_user.h
+++ b/arch/um/include/shared/net_user.h
@@ -50,4 +50,6 @@ extern char *split_if_spec(char *str, ...);
 
 extern int dev_netmask(void *d, void *m);
 
+extern void *uml_vector_compile_pcap(char *filter, int optimize);
+
 #endif
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

