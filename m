Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E265C3ABAA
	for <linux-um@archiver.kernel.org>; Sat,  3 May 2025 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HRQkrESn9EqR4ZjaKAvslK9/uyYQDSasrDBD/+Nu7oQ=; b=f7YAPDxJVBGPv/QugEN3LyDoGa
	GvWnaT5hq9fGP1WHOr4w/1FdbXdorHM0dG32pGphlp92eNHWRjLwqvWXHaqNkt1UEyN67+Ml4v1v/
	OacJPjnMZTOTLe1/sMqGO49SBCiC1zFSCAZfwya9cGl8BNZNACWCtJlrWnPcYNHojL8RmN25NQ0+G
	L6icO73nNeC2v3JRzMwmR6cgzWBc/R4JANslf+H9dU6W8sKcAW6/bNqV2X0ZhgNHxETyv3kquPUxX
	FUjiQBZz0z3H2d/fSLVBfmEGtjLawd+FMSqyApDpqUi9JmbCHrseGW0cgVLKjQJVVX8//D+1F08aM
	laLZQvOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBCtI-00000003v0q-0UrD;
	Sat, 03 May 2025 13:26:52 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBCtD-00000003uzf-3XG8
	for linux-um@lists.infradead.org;
	Sat, 03 May 2025 13:26:50 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1uBCt8-00AMt4-DM; Sat, 03 May 2025 13:26:43 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1uBCt4-003S7s-0w;
	Sat, 03 May 2025 14:26:42 +0100
Message-ID: <9fbfb8e6-6b51-470d-ac8c-79f476a0de90@cambridgegreys.com>
Date: Sat, 3 May 2025 14:26:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] um: Remove legacy network transport infrastructure
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at,
 johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org
References: <20250503051710.3286595-1-tiwei.btw@antgroup.com>
 <20250503051710.3286595-4-tiwei.btw@antgroup.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20250503051710.3286595-4-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250503_062648_214655_321D103C 
X-CRM114-Status: GOOD (  47.89  )
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

On 03/05/2025 06:17, Tiwei Bie wrote:
> All legacy network transports have been removed. Vector transports
> provide the same capabilities with significantly higher network
> throughput. There is no reason to keep the legacy network transport
> infrastructure anymore. Remove it to reduce the maintenance burden.
> 
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
>   .../virt/uml/user_mode_linux_howto_v2.rst     |  18 +-
>   arch/um/configs/i386_defconfig                |   1 -
>   arch/um/configs/x86_64_defconfig              |   1 -
>   arch/um/drivers/Kconfig                       |  27 +-
>   arch/um/drivers/Makefile                      |   2 -
>   arch/um/drivers/net_kern.c                    | 889 ------------------
>   arch/um/drivers/net_user.c                    | 271 ------
>   arch/um/include/shared/net_kern.h             |  69 --
>   arch/um/include/shared/net_user.h             |  52 -
>   9 files changed, 11 insertions(+), 1319 deletions(-)
>   delete mode 100644 arch/um/drivers/net_kern.c
>   delete mode 100644 arch/um/drivers/net_user.c
>   delete mode 100644 arch/um/include/shared/net_kern.h
>   delete mode 100644 arch/um/include/shared/net_user.h
> 
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index 60f35ed748b2..c37e8e594d12 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -147,18 +147,12 @@ The image hostname will be set to the same as the host on which you
>   are creating its image. It is a good idea to change that to avoid
>   "Oh, bummer, I rebooted the wrong machine".
>   
> -UML supports two classes of network devices - the older uml_net ones
> -which are scheduled for obsoletion. These are called ethX. It also
> -supports the newer vector IO devices which are significantly faster
> -and have support for some standard virtual network encapsulations like
> -Ethernet over GRE and Ethernet over L2TPv3. These are called vec0.
> -
> -Depending on which one is in use, ``/etc/network/interfaces`` will
> -need entries like::
> -
> -   # legacy UML network devices
> -   auto eth0
> -   iface eth0 inet dhcp
> +UML supports vector I/O high performance network devices which have
> +support for some standard virtual network encapsulations like
> +Ethernet over GRE and Ethernet over L2TPv3. These are called vecX.
> +
> +When vector network devices are in use, ``/etc/network/interfaces``
> +will need entries like::
>   
>      # vector UML network devices
>      auto vec0
> diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
> index 7c8999f18f2d..29d9666eceae 100644
> --- a/arch/um/configs/i386_defconfig
> +++ b/arch/um/configs/i386_defconfig
> @@ -52,7 +52,6 @@ CONFIG_PACKET=y
>   CONFIG_UNIX=y
>   CONFIG_INET=y
>   # CONFIG_IPV6 is not set
> -CONFIG_UML_NET=y
>   CONFIG_EXT4_FS=y
>   CONFIG_QUOTA=y
>   CONFIG_AUTOFS_FS=m
> diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
> index 9858d989777e..cf309c5406a2 100644
> --- a/arch/um/configs/x86_64_defconfig
> +++ b/arch/um/configs/x86_64_defconfig
> @@ -51,7 +51,6 @@ CONFIG_PACKET=y
>   CONFIG_UNIX=y
>   CONFIG_INET=y
>   # CONFIG_IPV6 is not set
> -CONFIG_UML_NET=y
>   CONFIG_EXT4_FS=y
>   CONFIG_QUOTA=y
>   CONFIG_AUTOFS_FS=m
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index 2067e37d6b63..b3c644d04fdc 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -124,25 +124,6 @@ endmenu
>   menu "UML Network Devices"
>   	depends on NET
>   
> -# UML virtual driver
> -config UML_NET
> -	bool "Virtual network device"
> -	help
> -	  While the User-Mode port cannot directly talk to any physical
> -	  hardware devices, this choice and the following transport options
> -	  provide one or more virtual network devices through which the UML
> -	  kernels can talk to each other, the host, and with the host's help,
> -	  machines on the outside world.
> -
> -	  For more information, including explanations of the networking and
> -	  sample configurations, see
> -	  <http://user-mode-linux.sourceforge.net/old/networking.html>.
> -
> -	  If you'd like to be able to enable networking in the User-Mode
> -	  linux environment, say Y; otherwise say N.  Note that you must
> -	  enable at least one of the following transport options to actually
> -	  make use of UML networking.
> -
>   config UML_NET_VECTOR
>   	bool "Vector I/O high performance network devices"
>   	select MAY_HAVE_RUNTIME_DEPS
> @@ -150,9 +131,11 @@ config UML_NET_VECTOR
>   	  This User-Mode Linux network driver uses multi-message send
>   	  and receive functions. The host running the UML guest must have
>   	  a linux kernel version above 3.0 and a libc version > 2.13.
> -	  This driver provides tap, raw, gre and l2tpv3 network transports
> -	  with up to 4 times higher network throughput than the UML network
> -	  drivers.
> +	  This driver provides tap, raw, gre and l2tpv3 network transports.
> +
> +	  For more information, including explanations of the networking
> +	  and sample configurations, see
> +	  <file:Documentation/virt/uml/user_mode_linux_howto_v2.rst>.
>   
>   endmenu
>   
> diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
> index d0608850833c..86dd06609a18 100644
> --- a/arch/um/drivers/Makefile
> +++ b/arch/um/drivers/Makefile
> @@ -7,7 +7,6 @@
>   # in to pcap.o
>   
>   vector-objs := vector_kern.o vector_user.o vector_transports.o
> -net-objs := net_kern.o net_user.o
>   mconsole-objs := mconsole_kern.o mconsole_user.o
>   hostaudio-objs := hostaudio_kern.o
>   ubd-objs := ubd_kern.o ubd_user.o
> @@ -28,7 +27,6 @@ obj-$(CONFIG_SSL) += ssl.o
>   obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
>   
>   obj-$(CONFIG_UML_NET_VECTOR) += vector.o
> -obj-$(CONFIG_UML_NET) += net.o
>   obj-$(CONFIG_MCONSOLE) += mconsole.o
>   obj-$(CONFIG_MMAPPER) += mmapper_kern.o
>   obj-$(CONFIG_BLK_DEV_UBD) += ubd.o
> diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
> deleted file mode 100644
> index d5a9c5aabaec..000000000000
> --- a/arch/um/drivers/net_kern.c
> +++ /dev/null
> @@ -1,889 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
> - * James Leu (jleu@mindspring.net).
> - * Copyright (C) 2001 by various other people who didn't put their name here.
> - */
> -
> -#include <linux/memblock.h>
> -#include <linux/etherdevice.h>
> -#include <linux/ethtool.h>
> -#include <linux/inetdevice.h>
> -#include <linux/init.h>
> -#include <linux/list.h>
> -#include <linux/netdevice.h>
> -#include <linux/platform_device.h>
> -#include <linux/rtnetlink.h>
> -#include <linux/skbuff.h>
> -#include <linux/slab.h>
> -#include <linux/spinlock.h>
> -#include <init.h>
> -#include <irq_kern.h>
> -#include <irq_user.h>
> -#include "mconsole_kern.h"
> -#include <net_kern.h>
> -#include <net_user.h>
> -
> -#define DRIVER_NAME "uml-netdev"
> -
> -static DEFINE_SPINLOCK(opened_lock);
> -static LIST_HEAD(opened);
> -
> -/*
> - * The drop_skb is used when we can't allocate an skb.  The
> - * packet is read into drop_skb in order to get the data off the
> - * connection to the host.
> - * It is reallocated whenever a maximum packet size is seen which is
> - * larger than any seen before.  update_drop_skb is called from
> - * eth_configure when a new interface is added.
> - */
> -static DEFINE_SPINLOCK(drop_lock);
> -static struct sk_buff *drop_skb;
> -static int drop_max;
> -
> -static int update_drop_skb(int max)
> -{
> -	struct sk_buff *new;
> -	unsigned long flags;
> -	int err = 0;
> -
> -	spin_lock_irqsave(&drop_lock, flags);
> -
> -	if (max <= drop_max)
> -		goto out;
> -
> -	err = -ENOMEM;
> -	new = dev_alloc_skb(max);
> -	if (new == NULL)
> -		goto out;
> -
> -	skb_put(new, max);
> -
> -	kfree_skb(drop_skb);
> -	drop_skb = new;
> -	drop_max = max;
> -	err = 0;
> -out:
> -	spin_unlock_irqrestore(&drop_lock, flags);
> -
> -	return err;
> -}
> -
> -static int uml_net_rx(struct net_device *dev)
> -{
> -	struct uml_net_private *lp = netdev_priv(dev);
> -	int pkt_len;
> -	struct sk_buff *skb;
> -
> -	/* If we can't allocate memory, try again next round. */
> -	skb = dev_alloc_skb(lp->max_packet);
> -	if (skb == NULL) {
> -		drop_skb->dev = dev;
> -		/* Read a packet into drop_skb and don't do anything with it. */
> -		(*lp->read)(lp->fd, drop_skb, lp);
> -		dev->stats.rx_dropped++;
> -		return 0;
> -	}
> -
> -	skb->dev = dev;
> -	skb_put(skb, lp->max_packet);
> -	skb_reset_mac_header(skb);
> -	pkt_len = (*lp->read)(lp->fd, skb, lp);
> -
> -	if (pkt_len > 0) {
> -		skb_trim(skb, pkt_len);
> -		skb->protocol = (*lp->protocol)(skb);
> -
> -		dev->stats.rx_bytes += skb->len;
> -		dev->stats.rx_packets++;
> -		netif_rx(skb);
> -		return pkt_len;
> -	}
> -
> -	kfree_skb(skb);
> -	return pkt_len;
> -}
> -
> -static void uml_dev_close(struct work_struct *work)
> -{
> -	struct uml_net_private *lp =
> -		container_of(work, struct uml_net_private, work);
> -	dev_close(lp->dev);
> -}
> -
> -static irqreturn_t uml_net_interrupt(int irq, void *dev_id)
> -{
> -	struct net_device *dev = dev_id;
> -	struct uml_net_private *lp = netdev_priv(dev);
> -	int err;
> -
> -	if (!netif_running(dev))
> -		return IRQ_NONE;
> -
> -	spin_lock(&lp->lock);
> -	while ((err = uml_net_rx(dev)) > 0) ;
> -	if (err < 0) {
> -		printk(KERN_ERR
> -		       "Device '%s' read returned %d, shutting it down\n",
> -		       dev->name, err);
> -		/* dev_close can't be called in interrupt context, and takes
> -		 * again lp->lock.
> -		 * And dev_close() can be safely called multiple times on the
> -		 * same device, since it tests for (dev->flags & IFF_UP). So
> -		 * there's no harm in delaying the device shutdown.
> -		 * Furthermore, the workqueue will not re-enqueue an already
> -		 * enqueued work item. */
> -		schedule_work(&lp->work);
> -		goto out;
> -	}
> -out:
> -	spin_unlock(&lp->lock);
> -	return IRQ_HANDLED;
> -}
> -
> -static int uml_net_open(struct net_device *dev)
> -{
> -	struct uml_net_private *lp = netdev_priv(dev);
> -	int err;
> -
> -	if (lp->fd >= 0) {
> -		err = -ENXIO;
> -		goto out;
> -	}
> -
> -	lp->fd = (*lp->open)(&lp->user);
> -	if (lp->fd < 0) {
> -		err = lp->fd;
> -		goto out;
> -	}
> -
> -	err = um_request_irq(dev->irq, lp->fd, IRQ_READ, uml_net_interrupt,
> -			     IRQF_SHARED, dev->name, dev);
> -	if (err < 0) {
> -		printk(KERN_ERR "uml_net_open: failed to get irq(%d)\n", err);
> -		err = -ENETUNREACH;
> -		goto out_close;
> -	}
> -
> -	netif_start_queue(dev);
> -
> -	/* clear buffer - it can happen that the host side of the interface
> -	 * is full when we get here.  In this case, new data is never queued,
> -	 * SIGIOs never arrive, and the net never works.
> -	 */
> -	while ((err = uml_net_rx(dev)) > 0) ;
> -
> -	spin_lock(&opened_lock);
> -	list_add(&lp->list, &opened);
> -	spin_unlock(&opened_lock);
> -
> -	return 0;
> -out_close:
> -	if (lp->close != NULL) (*lp->close)(lp->fd, &lp->user);
> -	lp->fd = -1;
> -out:
> -	return err;
> -}
> -
> -static int uml_net_close(struct net_device *dev)
> -{
> -	struct uml_net_private *lp = netdev_priv(dev);
> -
> -	netif_stop_queue(dev);
> -
> -	um_free_irq(dev->irq, dev);
> -	if (lp->close != NULL)
> -		(*lp->close)(lp->fd, &lp->user);
> -	lp->fd = -1;
> -
> -	spin_lock(&opened_lock);
> -	list_del(&lp->list);
> -	spin_unlock(&opened_lock);
> -
> -	return 0;
> -}
> -
> -static netdev_tx_t uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
> -{
> -	struct uml_net_private *lp = netdev_priv(dev);
> -	unsigned long flags;
> -	int len;
> -
> -	netif_stop_queue(dev);
> -
> -	spin_lock_irqsave(&lp->lock, flags);
> -
> -	len = (*lp->write)(lp->fd, skb, lp);
> -	skb_tx_timestamp(skb);
> -
> -	if (len == skb->len) {
> -		dev->stats.tx_packets++;
> -		dev->stats.tx_bytes += skb->len;
> -		netif_trans_update(dev);
> -		netif_start_queue(dev);
> -
> -		/* this is normally done in the interrupt when tx finishes */
> -		netif_wake_queue(dev);
> -	}
> -	else if (len == 0) {
> -		netif_start_queue(dev);
> -		dev->stats.tx_dropped++;
> -	}
> -	else {
> -		netif_start_queue(dev);
> -		printk(KERN_ERR "uml_net_start_xmit: failed(%d)\n", len);
> -	}
> -
> -	spin_unlock_irqrestore(&lp->lock, flags);
> -
> -	dev_consume_skb_any(skb);
> -
> -	return NETDEV_TX_OK;
> -}
> -
> -static void uml_net_set_multicast_list(struct net_device *dev)
> -{
> -	return;
> -}
> -
> -static void uml_net_tx_timeout(struct net_device *dev, unsigned int txqueue)
> -{
> -	netif_trans_update(dev);
> -	netif_wake_queue(dev);
> -}
> -
> -#ifdef CONFIG_NET_POLL_CONTROLLER
> -static void uml_net_poll_controller(struct net_device *dev)
> -{
> -	disable_irq(dev->irq);
> -	uml_net_interrupt(dev->irq, dev);
> -	enable_irq(dev->irq);
> -}
> -#endif
> -
> -static void uml_net_get_drvinfo(struct net_device *dev,
> -				struct ethtool_drvinfo *info)
> -{
> -	strscpy(info->driver, DRIVER_NAME);
> -}
> -
> -static const struct ethtool_ops uml_net_ethtool_ops = {
> -	.get_drvinfo	= uml_net_get_drvinfo,
> -	.get_link	= ethtool_op_get_link,
> -	.get_ts_info	= ethtool_op_get_ts_info,
> -};
> -
> -void uml_net_setup_etheraddr(struct net_device *dev, char *str)
> -{
> -	u8 addr[ETH_ALEN];
> -	char *end;
> -	int i;
> -
> -	if (str == NULL)
> -		goto random;
> -
> -	for (i = 0; i < 6; i++) {
> -		addr[i] = simple_strtoul(str, &end, 16);
> -		if ((end == str) ||
> -		   ((*end != ':') && (*end != ',') && (*end != '\0'))) {
> -			printk(KERN_ERR
> -			       "setup_etheraddr: failed to parse '%s' "
> -			       "as an ethernet address\n", str);
> -			goto random;
> -		}
> -		str = end + 1;
> -	}
> -	if (is_multicast_ether_addr(addr)) {
> -		printk(KERN_ERR
> -		       "Attempt to assign a multicast ethernet address to a "
> -		       "device disallowed\n");
> -		goto random;
> -	}
> -	if (!is_valid_ether_addr(addr)) {
> -		printk(KERN_ERR
> -		       "Attempt to assign an invalid ethernet address to a "
> -		       "device disallowed\n");
> -		goto random;
> -	}
> -	if (!is_local_ether_addr(addr)) {
> -		printk(KERN_WARNING
> -		       "Warning: Assigning a globally valid ethernet "
> -		       "address to a device\n");
> -		printk(KERN_WARNING "You should set the 2nd rightmost bit in "
> -		       "the first byte of the MAC,\n");
> -		printk(KERN_WARNING "i.e. %02x:%02x:%02x:%02x:%02x:%02x\n",
> -		       addr[0] | 0x02, addr[1], addr[2], addr[3], addr[4],
> -		       addr[5]);
> -	}
> -	eth_hw_addr_set(dev, addr);
> -	return;
> -
> -random:
> -	printk(KERN_INFO
> -	       "Choosing a random ethernet address for device %s\n", dev->name);
> -	eth_hw_addr_random(dev);
> -}
> -
> -static DEFINE_SPINLOCK(devices_lock);
> -static LIST_HEAD(devices);
> -
> -static struct platform_driver uml_net_driver = {
> -	.driver = {
> -		.name  = DRIVER_NAME,
> -	},
> -};
> -
> -static void net_device_release(struct device *dev)
> -{
> -	struct uml_net *device = container_of(dev, struct uml_net, pdev.dev);
> -	struct net_device *netdev = device->dev;
> -	struct uml_net_private *lp = netdev_priv(netdev);
> -
> -	if (lp->remove != NULL)
> -		(*lp->remove)(&lp->user);
> -	list_del(&device->list);
> -	kfree(device);
> -	free_netdev(netdev);
> -}
> -
> -static const struct net_device_ops uml_netdev_ops = {
> -	.ndo_open 		= uml_net_open,
> -	.ndo_stop 		= uml_net_close,
> -	.ndo_start_xmit 	= uml_net_start_xmit,
> -	.ndo_set_rx_mode	= uml_net_set_multicast_list,
> -	.ndo_tx_timeout 	= uml_net_tx_timeout,
> -	.ndo_set_mac_address	= eth_mac_addr,
> -	.ndo_validate_addr	= eth_validate_addr,
> -#ifdef CONFIG_NET_POLL_CONTROLLER
> -	.ndo_poll_controller = uml_net_poll_controller,
> -#endif
> -};
> -
> -/*
> - * Ensures that platform_driver_register is called only once by
> - * eth_configure.  Will be set in an initcall.
> - */
> -static int driver_registered;
> -
> -static void eth_configure(int n, void *init, char *mac,
> -			  struct transport *transport, gfp_t gfp_mask)
> -{
> -	struct uml_net *device;
> -	struct net_device *dev;
> -	struct uml_net_private *lp;
> -	int err, size;
> -
> -	size = transport->private_size + sizeof(struct uml_net_private);
> -
> -	device = kzalloc(sizeof(*device), gfp_mask);
> -	if (device == NULL) {
> -		printk(KERN_ERR "eth_configure failed to allocate struct "
> -		       "uml_net\n");
> -		return;
> -	}
> -
> -	dev = alloc_etherdev(size);
> -	if (dev == NULL) {
> -		printk(KERN_ERR "eth_configure: failed to allocate struct "
> -		       "net_device for eth%d\n", n);
> -		goto out_free_device;
> -	}
> -
> -	INIT_LIST_HEAD(&device->list);
> -	device->index = n;
> -
> -	/* If this name ends up conflicting with an existing registered
> -	 * netdevice, that is OK, register_netdev{,ice}() will notice this
> -	 * and fail.
> -	 */
> -	snprintf(dev->name, sizeof(dev->name), "eth%d", n);
> -
> -	uml_net_setup_etheraddr(dev, mac);
> -
> -	printk(KERN_INFO "Netdevice %d (%pM) : ", n, dev->dev_addr);
> -
> -	lp = netdev_priv(dev);
> -	/* This points to the transport private data. It's still clear, but we
> -	 * must memset it to 0 *now*. Let's help the drivers. */
> -	memset(lp, 0, size);
> -	INIT_WORK(&lp->work, uml_dev_close);
> -
> -	/* sysfs register */
> -	if (!driver_registered) {
> -		platform_driver_register(&uml_net_driver);
> -		driver_registered = 1;
> -	}
> -	device->pdev.id = n;
> -	device->pdev.name = DRIVER_NAME;
> -	device->pdev.dev.release = net_device_release;
> -	dev_set_drvdata(&device->pdev.dev, device);
> -	if (platform_device_register(&device->pdev))
> -		goto out_free_netdev;
> -	SET_NETDEV_DEV(dev,&device->pdev.dev);
> -
> -	device->dev = dev;
> -
> -	/*
> -	 * These just fill in a data structure, so there's no failure
> -	 * to be worried about.
> -	 */
> -	(*transport->kern->init)(dev, init);
> -
> -	*lp = ((struct uml_net_private)
> -		{ .list  		= LIST_HEAD_INIT(lp->list),
> -		  .dev 			= dev,
> -		  .fd 			= -1,
> -		  .mac 			= { 0xfe, 0xfd, 0x0, 0x0, 0x0, 0x0},
> -		  .max_packet		= transport->user->max_packet,
> -		  .protocol 		= transport->kern->protocol,
> -		  .open 		= transport->user->open,
> -		  .close 		= transport->user->close,
> -		  .remove 		= transport->user->remove,
> -		  .read 		= transport->kern->read,
> -		  .write 		= transport->kern->write,
> -		  .add_address 		= transport->user->add_address,
> -		  .delete_address  	= transport->user->delete_address });
> -
> -	spin_lock_init(&lp->lock);
> -	memcpy(lp->mac, dev->dev_addr, sizeof(lp->mac));
> -
> -	if ((transport->user->init != NULL) &&
> -	    ((*transport->user->init)(&lp->user, dev) != 0))
> -		goto out_unregister;
> -
> -	dev->mtu = transport->user->mtu;
> -	dev->netdev_ops = &uml_netdev_ops;
> -	dev->ethtool_ops = &uml_net_ethtool_ops;
> -	dev->watchdog_timeo = (HZ >> 1);
> -	dev->irq = UM_ETH_IRQ;
> -
> -	err = update_drop_skb(lp->max_packet);
> -	if (err)
> -		goto out_undo_user_init;
> -
> -	rtnl_lock();
> -	err = register_netdevice(dev);
> -	rtnl_unlock();
> -	if (err)
> -		goto out_undo_user_init;
> -
> -	spin_lock(&devices_lock);
> -	list_add(&device->list, &devices);
> -	spin_unlock(&devices_lock);
> -
> -	return;
> -
> -out_undo_user_init:
> -	if (transport->user->remove != NULL)
> -		(*transport->user->remove)(&lp->user);
> -out_unregister:
> -	platform_device_unregister(&device->pdev);
> -	return; /* platform_device_unregister frees dev and device */
> -out_free_netdev:
> -	free_netdev(dev);
> -out_free_device:
> -	kfree(device);
> -}
> -
> -static struct uml_net *find_device(int n)
> -{
> -	struct uml_net *device;
> -	struct list_head *ele;
> -
> -	spin_lock(&devices_lock);
> -	list_for_each(ele, &devices) {
> -		device = list_entry(ele, struct uml_net, list);
> -		if (device->index == n)
> -			goto out;
> -	}
> -	device = NULL;
> - out:
> -	spin_unlock(&devices_lock);
> -	return device;
> -}
> -
> -static int eth_parse(char *str, int *index_out, char **str_out,
> -		     char **error_out)
> -{
> -	char *end;
> -	int n, err = -EINVAL;
> -
> -	n = simple_strtoul(str, &end, 0);
> -	if (end == str) {
> -		*error_out = "Bad device number";
> -		return err;
> -	}
> -
> -	str = end;
> -	if (*str != '=') {
> -		*error_out = "Expected '=' after device number";
> -		return err;
> -	}
> -
> -	str++;
> -	if (find_device(n)) {
> -		*error_out = "Device already configured";
> -		return err;
> -	}
> -
> -	*index_out = n;
> -	*str_out = str;
> -	return 0;
> -}
> -
> -struct eth_init {
> -	struct list_head list;
> -	char *init;
> -	int index;
> -};
> -
> -static DEFINE_SPINLOCK(transports_lock);
> -static LIST_HEAD(transports);
> -
> -/* Filled in during early boot */
> -static LIST_HEAD(eth_cmd_line);
> -
> -static int check_transport(struct transport *transport, char *eth, int n,
> -			   void **init_out, char **mac_out, gfp_t gfp_mask)
> -{
> -	int len;
> -
> -	len = strlen(transport->name);
> -	if (strncmp(eth, transport->name, len))
> -		return 0;
> -
> -	eth += len;
> -	if (*eth == ',')
> -		eth++;
> -	else if (*eth != '\0')
> -		return 0;
> -
> -	*init_out = kmalloc(transport->setup_size, gfp_mask);
> -	if (*init_out == NULL)
> -		return 1;
> -
> -	if (!transport->setup(eth, mac_out, *init_out)) {
> -		kfree(*init_out);
> -		*init_out = NULL;
> -	}
> -	return 1;
> -}
> -
> -void register_transport(struct transport *new)
> -{
> -	struct list_head *ele, *next;
> -	struct eth_init *eth;
> -	void *init;
> -	char *mac = NULL;
> -	int match;
> -
> -	spin_lock(&transports_lock);
> -	BUG_ON(!list_empty(&new->list));
> -	list_add(&new->list, &transports);
> -	spin_unlock(&transports_lock);
> -
> -	list_for_each_safe(ele, next, &eth_cmd_line) {
> -		eth = list_entry(ele, struct eth_init, list);
> -		match = check_transport(new, eth->init, eth->index, &init,
> -					&mac, GFP_KERNEL);
> -		if (!match)
> -			continue;
> -		else if (init != NULL) {
> -			eth_configure(eth->index, init, mac, new, GFP_KERNEL);
> -			kfree(init);
> -		}
> -		list_del(&eth->list);
> -	}
> -}
> -
> -static int eth_setup_common(char *str, int index)
> -{
> -	struct list_head *ele;
> -	struct transport *transport;
> -	void *init;
> -	char *mac = NULL;
> -	int found = 0;
> -
> -	spin_lock(&transports_lock);
> -	list_for_each(ele, &transports) {
> -		transport = list_entry(ele, struct transport, list);
> -	        if (!check_transport(transport, str, index, &init,
> -					&mac, GFP_ATOMIC))
> -			continue;
> -		if (init != NULL) {
> -			eth_configure(index, init, mac, transport, GFP_ATOMIC);
> -			kfree(init);
> -		}
> -		found = 1;
> -		break;
> -	}
> -
> -	spin_unlock(&transports_lock);
> -	return found;
> -}
> -
> -static int __init eth_setup(char *str)
> -{
> -	struct eth_init *new;
> -	char *error;
> -	int n, err;
> -
> -	err = eth_parse(str, &n, &str, &error);
> -	if (err) {
> -		printk(KERN_ERR "eth_setup - Couldn't parse '%s' : %s\n",
> -		       str, error);
> -		return 1;
> -	}
> -
> -	new = memblock_alloc_or_panic(sizeof(*new), SMP_CACHE_BYTES);
> -
> -	INIT_LIST_HEAD(&new->list);
> -	new->index = n;
> -	new->init = str;
> -
> -	list_add_tail(&new->list, &eth_cmd_line);
> -	return 1;
> -}
> -
> -__setup("eth", eth_setup);
> -__uml_help(eth_setup,
> -"eth[0-9]+=<transport>,<options>\n"
> -"    Configure a network device.\n\n"
> -);
> -
> -static int net_config(char *str, char **error_out)
> -{
> -	int n, err;
> -
> -	err = eth_parse(str, &n, &str, error_out);
> -	if (err)
> -		return err;
> -
> -	/* This string is broken up and the pieces used by the underlying
> -	 * driver.  So, it is freed only if eth_setup_common fails.
> -	 */
> -	str = kstrdup(str, GFP_KERNEL);
> -	if (str == NULL) {
> -	        *error_out = "net_config failed to strdup string";
> -		return -ENOMEM;
> -	}
> -	err = !eth_setup_common(str, n);
> -	if (err)
> -		kfree(str);
> -	return err;
> -}
> -
> -static int net_id(char **str, int *start_out, int *end_out)
> -{
> -	char *end;
> -	int n;
> -
> -	n = simple_strtoul(*str, &end, 0);
> -	if ((*end != '\0') || (end == *str))
> -		return -1;
> -
> -	*start_out = n;
> -	*end_out = n;
> -	*str = end;
> -	return n;
> -}
> -
> -static int net_remove(int n, char **error_out)
> -{
> -	struct uml_net *device;
> -	struct net_device *dev;
> -	struct uml_net_private *lp;
> -
> -	device = find_device(n);
> -	if (device == NULL)
> -		return -ENODEV;
> -
> -	dev = device->dev;
> -	lp = netdev_priv(dev);
> -	if (lp->fd > 0)
> -		return -EBUSY;
> -	unregister_netdev(dev);
> -	platform_device_unregister(&device->pdev);
> -
> -	return 0;
> -}
> -
> -static struct mc_device net_mc = {
> -	.list		= LIST_HEAD_INIT(net_mc.list),
> -	.name		= "eth",
> -	.config		= net_config,
> -	.get_config	= NULL,
> -	.id		= net_id,
> -	.remove		= net_remove,
> -};
> -
> -#ifdef CONFIG_INET
> -static int uml_inetaddr_event(struct notifier_block *this, unsigned long event,
> -			      void *ptr)
> -{
> -	struct in_ifaddr *ifa = ptr;
> -	struct net_device *dev = ifa->ifa_dev->dev;
> -	struct uml_net_private *lp;
> -	void (*proc)(unsigned char *, unsigned char *, void *);
> -	unsigned char addr_buf[4], netmask_buf[4];
> -
> -	if (dev->netdev_ops->ndo_open != uml_net_open)
> -		return NOTIFY_DONE;
> -
> -	lp = netdev_priv(dev);
> -
> -	proc = NULL;
> -	switch (event) {
> -	case NETDEV_UP:
> -		proc = lp->add_address;
> -		break;
> -	case NETDEV_DOWN:
> -		proc = lp->delete_address;
> -		break;
> -	}
> -	if (proc != NULL) {
> -		memcpy(addr_buf, &ifa->ifa_address, sizeof(addr_buf));
> -		memcpy(netmask_buf, &ifa->ifa_mask, sizeof(netmask_buf));
> -		(*proc)(addr_buf, netmask_buf, &lp->user);
> -	}
> -	return NOTIFY_DONE;
> -}
> -
> -/* uml_net_init shouldn't be called twice on two CPUs at the same time */
> -static struct notifier_block uml_inetaddr_notifier = {
> -	.notifier_call		= uml_inetaddr_event,
> -};
> -
> -static void inet_register(void)
> -{
> -	struct list_head *ele;
> -	struct uml_net_private *lp;
> -	struct in_device *ip;
> -	struct in_ifaddr *in;
> -
> -	register_inetaddr_notifier(&uml_inetaddr_notifier);
> -
> -	/* Devices may have been opened already, so the uml_inetaddr_notifier
> -	 * didn't get a chance to run for them.  This fakes it so that
> -	 * addresses which have already been set up get handled properly.
> -	 */
> -	spin_lock(&opened_lock);
> -	list_for_each(ele, &opened) {
> -		lp = list_entry(ele, struct uml_net_private, list);
> -		ip = lp->dev->ip_ptr;
> -		if (ip == NULL)
> -			continue;
> -		in = ip->ifa_list;
> -		while (in != NULL) {
> -			uml_inetaddr_event(NULL, NETDEV_UP, in);
> -			in = in->ifa_next;
> -		}
> -	}
> -	spin_unlock(&opened_lock);
> -}
> -#else
> -static inline void inet_register(void)
> -{
> -}
> -#endif
> -
> -static int uml_net_init(void)
> -{
> -	mconsole_register_dev(&net_mc);
> -	inet_register();
> -	return 0;
> -}
> -
> -__initcall(uml_net_init);
> -
> -static void close_devices(void)
> -{
> -	struct list_head *ele;
> -	struct uml_net_private *lp;
> -
> -	spin_lock(&opened_lock);
> -	list_for_each(ele, &opened) {
> -		lp = list_entry(ele, struct uml_net_private, list);
> -		um_free_irq(lp->dev->irq, lp->dev);
> -		if ((lp->close != NULL) && (lp->fd >= 0))
> -			(*lp->close)(lp->fd, &lp->user);
> -		if (lp->remove != NULL)
> -			(*lp->remove)(&lp->user);
> -	}
> -	spin_unlock(&opened_lock);
> -}
> -
> -__uml_exitcall(close_devices);
> -
> -void iter_addresses(void *d, void (*cb)(unsigned char *, unsigned char *,
> -					void *),
> -		    void *arg)
> -{
> -	struct net_device *dev = d;
> -	struct in_device *ip = dev->ip_ptr;
> -	struct in_ifaddr *in;
> -	unsigned char address[4], netmask[4];
> -
> -	if (ip == NULL) return;
> -	in = ip->ifa_list;
> -	while (in != NULL) {
> -		memcpy(address, &in->ifa_address, sizeof(address));
> -		memcpy(netmask, &in->ifa_mask, sizeof(netmask));
> -		(*cb)(address, netmask, arg);
> -		in = in->ifa_next;
> -	}
> -}
> -
> -int dev_netmask(void *d, void *m)
> -{
> -	struct net_device *dev = d;
> -	struct in_device *ip = dev->ip_ptr;
> -	struct in_ifaddr *in;
> -	__be32 *mask_out = m;
> -
> -	if (ip == NULL)
> -		return 1;
> -
> -	in = ip->ifa_list;
> -	if (in == NULL)
> -		return 1;
> -
> -	*mask_out = in->ifa_mask;
> -	return 0;
> -}
> -
> -void *get_output_buffer(int *len_out)
> -{
> -	void *ret;
> -
> -	ret = (void *) __get_free_pages(GFP_KERNEL, 0);
> -	if (ret) *len_out = PAGE_SIZE;
> -	else *len_out = 0;
> -	return ret;
> -}
> -
> -void free_output_buffer(void *buffer)
> -{
> -	free_pages((unsigned long) buffer, 0);
> -}
> -
> -int tap_setup_common(char *str, char *type, char **dev_name, char **mac_out,
> -		     char **gate_addr)
> -{
> -	char *remain;
> -
> -	remain = split_if_spec(str, dev_name, mac_out, gate_addr, NULL);
> -	if (remain != NULL) {
> -		printk(KERN_ERR "tap_setup_common - Extra garbage on "
> -		       "specification : '%s'\n", remain);
> -		return 1;
> -	}
> -
> -	return 0;
> -}
> -
> -unsigned short eth_protocol(struct sk_buff *skb)
> -{
> -	return eth_type_trans(skb, skb->dev);
> -}
> diff --git a/arch/um/drivers/net_user.c b/arch/um/drivers/net_user.c
> deleted file mode 100644
> index 4c9576452ab0..000000000000
> --- a/arch/um/drivers/net_user.c
> +++ /dev/null
> @@ -1,271 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <stdarg.h>
> -#include <errno.h>
> -#include <stddef.h>
> -#include <string.h>
> -#include <sys/socket.h>
> -#include <sys/wait.h>
> -#include <net_user.h>
> -#include <os.h>
> -#include <um_malloc.h>
> -
> -int tap_open_common(void *dev, char *gate_addr)
> -{
> -	int tap_addr[4];
> -
> -	if (gate_addr == NULL)
> -		return 0;
> -	if (sscanf(gate_addr, "%d.%d.%d.%d", &tap_addr[0],
> -		  &tap_addr[1], &tap_addr[2], &tap_addr[3]) != 4) {
> -		printk(UM_KERN_ERR "Invalid tap IP address - '%s'\n",
> -		       gate_addr);
> -		return -EINVAL;
> -	}
> -	return 0;
> -}
> -
> -void tap_check_ips(char *gate_addr, unsigned char *eth_addr)
> -{
> -	int tap_addr[4];
> -
> -	if ((gate_addr != NULL) &&
> -	    (sscanf(gate_addr, "%d.%d.%d.%d", &tap_addr[0],
> -		    &tap_addr[1], &tap_addr[2], &tap_addr[3]) == 4) &&
> -	    (eth_addr[0] == tap_addr[0]) &&
> -	    (eth_addr[1] == tap_addr[1]) &&
> -	    (eth_addr[2] == tap_addr[2]) &&
> -	    (eth_addr[3] == tap_addr[3])) {
> -		printk(UM_KERN_ERR "The tap IP address and the UML eth IP "
> -		       "address must be different\n");
> -	}
> -}
> -
> -/* Do reliable error handling as this fails frequently enough. */
> -void read_output(int fd, char *output, int len)
> -{
> -	int remain, ret, expected;
> -	char c;
> -	char *str;
> -
> -	if (output == NULL) {
> -		output = &c;
> -		len = sizeof(c);
> -	}
> -
> -	*output = '\0';
> -	ret = read(fd, &remain, sizeof(remain));
> -
> -	if (ret != sizeof(remain)) {
> -		if (ret < 0)
> -			ret = -errno;
> -		expected = sizeof(remain);
> -		str = "length";
> -		goto err;
> -	}
> -
> -	while (remain != 0) {
> -		expected = (remain < len) ? remain : len;
> -		ret = read(fd, output, expected);
> -		if (ret != expected) {
> -			if (ret < 0)
> -				ret = -errno;
> -			str = "data";
> -			goto err;
> -		}
> -		remain -= ret;
> -	}
> -
> -	return;
> -
> -err:
> -	if (ret < 0)
> -		printk(UM_KERN_ERR "read_output - read of %s failed, "
> -		       "errno = %d\n", str, -ret);
> -	else
> -		printk(UM_KERN_ERR "read_output - read of %s failed, read only "
> -		       "%d of %d bytes\n", str, ret, expected);
> -}
> -
> -int net_read(int fd, void *buf, int len)
> -{
> -	int n;
> -
> -	n = read(fd,  buf,  len);
> -
> -	if ((n < 0) && (errno == EAGAIN))
> -		return 0;
> -	else if (n == 0)
> -		return -ENOTCONN;
> -	return n;
> -}
> -
> -int net_recvfrom(int fd, void *buf, int len)
> -{
> -	int n;
> -
> -	CATCH_EINTR(n = recvfrom(fd,  buf,  len, 0, NULL, NULL));
> -	if (n < 0) {
> -		if (errno == EAGAIN)
> -			return 0;
> -		return -errno;
> -	}
> -	else if (n == 0)
> -		return -ENOTCONN;
> -	return n;
> -}
> -
> -int net_write(int fd, void *buf, int len)
> -{
> -	int n;
> -
> -	n = write(fd, buf, len);
> -
> -	if ((n < 0) && (errno == EAGAIN))
> -		return 0;
> -	else if (n == 0)
> -		return -ENOTCONN;
> -	return n;
> -}
> -
> -int net_send(int fd, void *buf, int len)
> -{
> -	int n;
> -
> -	CATCH_EINTR(n = send(fd, buf, len, 0));
> -	if (n < 0) {
> -		if (errno == EAGAIN)
> -			return 0;
> -		return -errno;
> -	}
> -	else if (n == 0)
> -		return -ENOTCONN;
> -	return n;
> -}
> -
> -int net_sendto(int fd, void *buf, int len, void *to, int sock_len)
> -{
> -	int n;
> -
> -	CATCH_EINTR(n = sendto(fd, buf, len, 0, (struct sockaddr *) to,
> -			       sock_len));
> -	if (n < 0) {
> -		if (errno == EAGAIN)
> -			return 0;
> -		return -errno;
> -	}
> -	else if (n == 0)
> -		return -ENOTCONN;
> -	return n;
> -}
> -
> -struct change_pre_exec_data {
> -	int close_me;
> -	int stdout_fd;
> -};
> -
> -static void change_pre_exec(void *arg)
> -{
> -	struct change_pre_exec_data *data = arg;
> -
> -	close(data->close_me);
> -	dup2(data->stdout_fd, 1);
> -}
> -
> -static int change_tramp(char **argv, char *output, int output_len)
> -{
> -	int pid, fds[2], err;
> -	struct change_pre_exec_data pe_data;
> -
> -	err = os_pipe(fds, 1, 0);
> -	if (err < 0) {
> -		printk(UM_KERN_ERR "change_tramp - pipe failed, err = %d\n",
> -		       -err);
> -		return err;
> -	}
> -	pe_data.close_me = fds[0];
> -	pe_data.stdout_fd = fds[1];
> -	pid = run_helper(change_pre_exec, &pe_data, argv);
> -
> -	if (pid > 0)	/* Avoid hang as we won't get data in failure case. */
> -		read_output(fds[0], output, output_len);
> -
> -	close(fds[0]);
> -	close(fds[1]);
> -
> -	if (pid > 0)
> -		helper_wait(pid);
> -	return pid;
> -}
> -
> -static void change(char *dev, char *what, unsigned char *addr,
> -		   unsigned char *netmask)
> -{
> -	char addr_buf[sizeof("255.255.255.255\0")];
> -	char netmask_buf[sizeof("255.255.255.255\0")];
> -	char version[sizeof("nnnnn\0")];
> -	char *argv[] = { "uml_net", version, what, dev, addr_buf,
> -			 netmask_buf, NULL };
> -	char *output;
> -	int output_len, pid;
> -
> -	sprintf(version, "%d", UML_NET_VERSION);
> -	sprintf(addr_buf, "%d.%d.%d.%d", addr[0], addr[1], addr[2], addr[3]);
> -	sprintf(netmask_buf, "%d.%d.%d.%d", netmask[0], netmask[1],
> -		netmask[2], netmask[3]);
> -
> -	output_len = UM_KERN_PAGE_SIZE;
> -	output = uml_kmalloc(output_len, UM_GFP_KERNEL);
> -	if (output == NULL)
> -		printk(UM_KERN_ERR "change : failed to allocate output "
> -		       "buffer\n");
> -
> -	pid = change_tramp(argv, output, output_len);
> -	if (pid < 0) {
> -		kfree(output);
> -		return;
> -	}
> -
> -	if (output != NULL) {
> -		printk("%s", output);
> -		kfree(output);
> -	}
> -}
> -
> -void open_addr(unsigned char *addr, unsigned char *netmask, void *arg)
> -{
> -	change(arg, "add", addr, netmask);
> -}
> -
> -void close_addr(unsigned char *addr, unsigned char *netmask, void *arg)
> -{
> -	change(arg, "del", addr, netmask);
> -}
> -
> -char *split_if_spec(char *str, ...)
> -{
> -	char **arg, *end, *ret = NULL;
> -	va_list ap;
> -
> -	va_start(ap, str);
> -	while ((arg = va_arg(ap, char **)) != NULL) {
> -		if (*str == '\0')
> -			goto out;
> -		end = strchr(str, ',');
> -		if (end != str)
> -			*arg = str;
> -		if (end == NULL)
> -			goto out;
> -		*end++ = '\0';
> -		str = end;
> -	}
> -	ret = str;
> -out:
> -	va_end(ap);
> -	return ret;
> -}
> diff --git a/arch/um/include/shared/net_kern.h b/arch/um/include/shared/net_kern.h
> deleted file mode 100644
> index 67b2e9a1f2e5..000000000000
> --- a/arch/um/include/shared/net_kern.h
> +++ /dev/null
> @@ -1,69 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2002 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#ifndef __UM_NET_KERN_H
> -#define __UM_NET_KERN_H
> -
> -#include <linux/netdevice.h>
> -#include <linux/platform_device.h>
> -#include <linux/skbuff.h>
> -#include <linux/socket.h>
> -#include <linux/list.h>
> -#include <linux/workqueue.h>
> -
> -struct uml_net {
> -	struct list_head list;
> -	struct net_device *dev;
> -	struct platform_device pdev;
> -	int index;
> -};
> -
> -struct uml_net_private {
> -	struct list_head list;
> -	spinlock_t lock;
> -	struct net_device *dev;
> -	struct timer_list tl;
> -
> -	struct work_struct work;
> -	int fd;
> -	unsigned char mac[ETH_ALEN];
> -	int max_packet;
> -	unsigned short (*protocol)(struct sk_buff *);
> -	int (*open)(void *);
> -	void (*close)(int, void *);
> -	void (*remove)(void *);
> -	int (*read)(int, struct sk_buff *skb, struct uml_net_private *);
> -	int (*write)(int, struct sk_buff *skb, struct uml_net_private *);
> -
> -	void (*add_address)(unsigned char *, unsigned char *, void *);
> -	void (*delete_address)(unsigned char *, unsigned char *, void *);
> -	char user[];
> -};
> -
> -struct net_kern_info {
> -	void (*init)(struct net_device *, void *);
> -	unsigned short (*protocol)(struct sk_buff *);
> -	int (*read)(int, struct sk_buff *skb, struct uml_net_private *);
> -	int (*write)(int, struct sk_buff *skb, struct uml_net_private *);
> -};
> -
> -struct transport {
> -	struct list_head list;
> -	const char *name;
> -	int (* const setup)(char *, char **, void *);
> -	const struct net_user_info *user;
> -	const struct net_kern_info *kern;
> -	const int private_size;
> -	const int setup_size;
> -};
> -
> -extern int tap_setup_common(char *str, char *type, char **dev_name,
> -			    char **mac_out, char **gate_addr);
> -extern void register_transport(struct transport *new);
> -extern unsigned short eth_protocol(struct sk_buff *skb);
> -extern void uml_net_setup_etheraddr(struct net_device *dev, char *str);
> -
> -
> -#endif
> diff --git a/arch/um/include/shared/net_user.h b/arch/um/include/shared/net_user.h
> deleted file mode 100644
> index ba92a4d93531..000000000000
> --- a/arch/um/include/shared/net_user.h
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> - */
> -
> -#ifndef __UM_NET_USER_H__
> -#define __UM_NET_USER_H__
> -
> -#define ETH_ADDR_LEN (6)
> -#define ETH_HEADER_ETHERTAP (16)
> -#define ETH_HEADER_OTHER (26) /* 14 for ethernet + VLAN + MPLS for crazy people */
> -#define ETH_MAX_PACKET (1500)
> -
> -#define UML_NET_VERSION (4)
> -
> -struct net_user_info {
> -	int (*init)(void *, void *);
> -	int (*open)(void *);
> -	void (*close)(int, void *);
> -	void (*remove)(void *);
> -	void (*add_address)(unsigned char *, unsigned char *, void *);
> -	void (*delete_address)(unsigned char *, unsigned char *, void *);
> -	int max_packet;
> -	int mtu;
> -};
> -
> -extern void iter_addresses(void *d, void (*cb)(unsigned char *,
> -					       unsigned char *, void *),
> -			   void *arg);
> -
> -extern void *get_output_buffer(int *len_out);
> -extern void free_output_buffer(void *buffer);
> -
> -extern int tap_open_common(void *dev, char *gate_addr);
> -extern void tap_check_ips(char *gate_addr, unsigned char *eth_addr);
> -
> -extern void read_output(int fd, char *output_out, int len);
> -
> -extern int net_read(int fd, void *buf, int len);
> -extern int net_recvfrom(int fd, void *buf, int len);
> -extern int net_write(int fd, void *buf, int len);
> -extern int net_send(int fd, void *buf, int len);
> -extern int net_sendto(int fd, void *buf, int len, void *to, int sock_len);
> -
> -extern void open_addr(unsigned char *addr, unsigned char *netmask, void *arg);
> -extern void close_addr(unsigned char *addr, unsigned char *netmask, void *arg);
> -
> -extern char *split_if_spec(char *str, ...);
> -
> -extern int dev_netmask(void *d, void *m);
> -
> -#endif

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

I think it is time - it has been marked obsolete for 5 years.
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

