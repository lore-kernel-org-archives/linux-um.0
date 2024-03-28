Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D47C54E67
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pFqT+MkKUMIYNsZr9dtLkg94pr7yAdoKWGCweN90pT8=; b=HmS5e1lPaJPr+WfPayEiuwhT4G
	tj7k90J+lAoxL7rVaE1KlqUL3Tz+AM38NZbJAgr/6Uq0sne7A/VAgvG6Jzg6t2C4jqp7EVv3dfP/r
	l7ieKkrdY0RBl8iea2dT7/Y7dJBzfnBgcNR+eWl/sv3b5WSQUKKUc0YDoNnLTjk9DXqVqJSI14K1F
	qmZzX+tQkTz6yBTuB4lTTWGYOiseQCb8YDcnGqhMDao8zZ27/6F33n5TzRHGrAofh3vKLj0VW2NTn
	l/IK4zATlXiLQTjN0J2u0JTgQEWmFItRhUFLp/c2XXiWh/ZugULQRZQeepVsMEgpNWo7kq8He0u5d
	9FTK1L2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpq9Y-0000000EBoH-0Ayt;
	Thu, 28 Mar 2024 13:50:48 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpq9U-0000000EBnr-2OJ5
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 13:50:46 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rppk6-00FZYw-UT; Thu, 28 Mar 2024 13:24:31 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1rppk2-005Aat-0G;
	Thu, 28 Mar 2024 13:24:28 +0000
From: anton.ivanov@cambridgegreys.com
To: linux-um@lists.infradead.org
Cc: richard@nod.at,
	johannes@sipsolutions.net,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH] um: Remove obsolete pcap driver
Date: Thu, 28 Mar 2024 13:24:24 +0000
Message-Id: <20240328132424.376456-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_065044_795650_E256876E 
X-CRM114-Status: GOOD (  20.09  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Remove the pcap driver in UML. It is obsolete. It does not build on
recent systems due to changes in libpcap and its dependencies.

The vector driver's raw transport in UML provides identical
functionality.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/Kconfig     |  20 ------
 arch/um/drivers/Makefile    |  10 +--
 arch/um/drivers/pcap_kern.c | 113 -----------------------------
 arch/um/drivers/pcap_user.c | 137 ------------------------------------
 arch/um/drivers/pcap_user.h |  21 ------
 5 files changed, 2 insertions(+), 299 deletions(-)
 delete mode 100644 arch/um/drivers/pcap_kern.c
 delete mode 100644 arch/um/drivers/pcap_user.c
 delete mode 100644 arch/um/drivers/pcap_user.h

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index b94b2618e7d8..ede40a160c5e 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -297,26 +297,6 @@ config UML_NET_MCAST
 
 	  If unsure, say N.
 
-config UML_NET_PCAP
-	bool "pcap transport (obsolete)"
-	depends on UML_NET
-	depends on !MODVERSIONS
-	select MAY_HAVE_RUNTIME_DEPS
-	help
-	  The pcap transport makes a pcap packet stream on the host look
-	  like an ethernet device inside UML.  This is useful for making
-	  UML act as a network monitor for the host.  You must have libcap
-	  installed in order to build the pcap transport into UML.
-
-	  For more information, see
-	  <http://user-mode-linux.sourceforge.net/old/networking.html>  That site
-	  has examples of the UML command line to use to enable this option.
-
-	  NOTE: THIS TRANSPORT IS DEPRECATED AND WILL BE REMOVED SOON!!! Please
-	  migrate to UML_NET_VECTOR.
-
-	  If unsure, say N.
-
 config UML_NET_SLIRP
 	bool "SLiRP transport (obsolete)"
 	depends on UML_NET
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 0e6af81096fd..57882e6bc215 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -20,14 +20,9 @@ harddog-objs := harddog_kern.o
 harddog-builtin-$(CONFIG_UML_WATCHDOG) := harddog_user.o harddog_user_exp.o
 rtc-objs := rtc_kern.o rtc_user.o
 
-LDFLAGS_pcap.o = $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
-
 LDFLAGS_vde.o = $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
 
-targets := pcap_kern.o pcap_user.o vde_kern.o vde_user.o
-
-$(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)/pcap_user.o
-	$(LD) -r -dp -o $@ $^ $(ld_flags)
+targets := vde_kern.o vde_user.o
 
 $(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
 	$(LD) -r -dp -o $@ $^ $(ld_flags)
@@ -49,7 +44,6 @@ obj-$(CONFIG_UML_NET_DAEMON) += daemon.o
 obj-$(CONFIG_UML_NET_VECTOR) += vector.o
 obj-$(CONFIG_UML_NET_VDE) += vde.o
 obj-$(CONFIG_UML_NET_MCAST) += umcast.o
-obj-$(CONFIG_UML_NET_PCAP) += pcap.o
 obj-$(CONFIG_UML_NET) += net.o 
 obj-$(CONFIG_MCONSOLE) += mconsole.o
 obj-$(CONFIG_MMAPPER) += mmapper_kern.o 
@@ -69,7 +63,7 @@ obj-$(CONFIG_UML_RTC) += rtc.o
 obj-$(CONFIG_UML_PCI_OVER_VIRTIO) += virt-pci.o
 
 # pcap_user.o must be added explicitly.
-USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o pcap_user.o vde_user.o vector_user.o
+USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o vde_user.o vector_user.o
 CFLAGS_null.o = -DDEV_NULL=$(DEV_NULL_PATH)
 
 CFLAGS_xterm.o += '-DCONFIG_XTERM_CHAN_DEFAULT_EMULATOR="$(CONFIG_XTERM_CHAN_DEFAULT_EMULATOR)"'
diff --git a/arch/um/drivers/pcap_kern.c b/arch/um/drivers/pcap_kern.c
deleted file mode 100644
index 25ee2c97ca21..000000000000
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
-void pcap_init_kern(struct net_device *dev, void *data)
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
-	.init			= pcap_init_kern,
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
deleted file mode 100644
index 52ddda3e3b10..000000000000
--- a/arch/um/drivers/pcap_user.c
+++ /dev/null
@@ -1,137 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- */
-
-#include <errno.h>
-#include <pcap.h>
-#include <string.h>
-#include <asm/types.h>
-#include <net_user.h>
-#include "pcap_user.h"
-#include <um_malloc.h>
-
-#define PCAP_FD(p) (*(int *)(p))
-
-static int pcap_user_init(void *data, void *dev)
-{
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
-
-	pri->dev = dev;
-	pri->pcap = p;
-	return 0;
-}
-
-static int pcap_user_open(void *data)
-{
-	struct pcap_data *pri = data;
-	__u32 netmask;
-	int err;
-
-	if (pri->pcap == NULL)
-		return -ENODEV;
-
-	if (pri->filter != NULL) {
-		err = dev_netmask(pri->dev, &netmask);
-		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_user_open : dev_netmask failed\n");
-			return -EIO;
-		}
-
-		pri->compiled = uml_kmalloc(sizeof(struct bpf_program),
-					UM_GFP_KERNEL);
-		if (pri->compiled == NULL) {
-			printk(UM_KERN_ERR "pcap_user_open : kmalloc failed\n");
-			return -ENOMEM;
-		}
-
-		err = pcap_compile(pri->pcap,
-				   (struct bpf_program *) pri->compiled,
-				   pri->filter, pri->optimize, netmask);
-		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_user_open : pcap_compile failed - "
-			       "'%s'\n", pcap_geterr(pri->pcap));
-			goto out;
-		}
-
-		err = pcap_setfilter(pri->pcap, pri->compiled);
-		if (err < 0) {
-			printk(UM_KERN_ERR "pcap_user_open : pcap_setfilter "
-			       "failed - '%s'\n", pcap_geterr(pri->pcap));
-			goto out;
-		}
-	}
-
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
-
-static void handler(u_char *data, const struct pcap_pkthdr *header,
-		    const u_char *packet)
-{
-	int len;
-
-	struct pcap_handler_data *hdata = (struct pcap_handler_data *) data;
-
-	len = hdata->len < header->caplen ? hdata->len : header->caplen;
-	memcpy(hdata->buffer, packet, len);
-	hdata->len = len;
-}
-
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
-
-const struct net_user_info pcap_user_info = {
-	.init		= pcap_user_init,
-	.open		= pcap_user_open,
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
-- 
2.39.2


