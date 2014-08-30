Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <antivano@cisco.com>) id 1XNdCZ-0008SI-Lm
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 07:35:59 +0000
Received: from alln-iport-5.cisco.com ([173.37.142.92])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XNdCX-0004nY-F6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 07:35:59 +0000
From: "Anton Ivanov (antivano)" <antivano@cisco.com>
Date: Sat, 30 Aug 2014 07:35:50 +0000
Message-ID: <54017ED4.1000408@cisco.com>
References: <1409295915-130538-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
	<1409295915-130538-3-git-send-email-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <1409295915-130538-3-git-send-email-anton.ivanov@kot-begemot.co.uk>
Content-Language: en-US
Content-ID: <36C56A07C3D73841BC987C89AB4171CC@emea.cisco.com>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 03/10] High performance networking subsystem
To: "anton.ivanov@kot-begemot.co.uk" <anton.ivanov@kot-begemot.co.uk>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Hi Richard, hi list,

some notes on this patchset: we have had the multipacket rx portion of 
this stable and in use for quite a while (nearly a year).

The tx portion is new and it looks like it has some issues which did not 
show up before I ported it to a more recent kernel (I would not be 
surprised if I introduced them when porting this from 3.3.y/OpenWRT to 
3.12.y/Stock).

If I do not figure out what exactly is going on with the tx by end of 
next week I am going to resubmit an older version of this patch (and its 
corresponding transports) which has only multi-packet rx (which is 
stable) and leave TX for a later incremental.

A.


On 29/08/14 08:05, anton.ivanov@kot-begemot.co.uk wrote:
> From: Anton Ivanov <antivano@cisco.com>
>
> Support for multi-packet vector IO - multiple packets
> read in one syscall and written in one syscall. Should work with
> legacy UML, thorough tested only for the epoll based IRQ controller
>
> Minimal host kernel version for RX - 2.6.32
> Minimal host kernel version for TX - 3.0
>
> Tested on Debian 7.0/Ubuntu 12.x LTS which have the relevant
> syscalls, but do not have the appropriate glibc routine for TX
> (this is why it is a direct syscall).
>
> Signed-off-by: Anton Ivanov <antivano@cisco.com>
> ---
>   arch/um/drivers/Makefile          |    2 +-
>   arch/um/drivers/net_kern.c        |   63 ++++++++++++++++++++++++-------------
>   arch/um/include/asm/irq.h         |   26 +++++++++------
>   arch/um/include/shared/net_kern.h |   24 ++++++++++++++
>   arch/um/include/shared/net_user.h |   24 ++++++++++++++
>   arch/um/kernel/irq.c              |    3 ++
>   6 files changed, 109 insertions(+), 33 deletions(-)
>
> diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
> index e7582e1..836baaf 100644
> --- a/arch/um/drivers/Makefile
> +++ b/arch/um/drivers/Makefile
> @@ -10,7 +10,7 @@ slip-objs := slip_kern.o slip_user.o
>   slirp-objs := slirp_kern.o slirp_user.o
>   daemon-objs := daemon_kern.o daemon_user.o
>   umcast-objs := umcast_kern.o umcast_user.o
> -net-objs := net_kern.o net_user.o
> +net-objs := net_kern.o net_user.o net_extra_user.o net_extra_kern.o
>   mconsole-objs := mconsole_kern.o mconsole_user.o
>   hostaudio-objs := hostaudio_kern.o
>   ubd-objs := ubd_kern.o ubd_user.o
> diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
> index 64d8426..1d253fa 100644
> --- a/arch/um/drivers/net_kern.c
> +++ b/arch/um/drivers/net_kern.c
> @@ -1,4 +1,5 @@
>   /*
> + * Copyright (C) 2012 - 2014 Cisco Systems
>    * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>    * Copyright (C) 2001 Lennert Buytenhek (buytenh@gnu.org) and
>    * James Leu (jleu@mindspring.net).
> @@ -29,6 +30,7 @@
>   
>   static DEFINE_SPINLOCK(opened_lock);
>   static LIST_HEAD(opened);
> +static int rr_counter = 0;
>   
>   /*
>    * The drop_skb is used when we can't allocate an skb.  The
> @@ -42,6 +44,7 @@ static DEFINE_SPINLOCK(drop_lock);
>   static struct sk_buff *drop_skb;
>   static int drop_max;
>   
> +
>   static int update_drop_skb(int max)
>   {
>   	struct sk_buff *new;
> @@ -77,24 +80,38 @@ static int uml_net_rx(struct net_device *dev)
>   	struct sk_buff *skb;
>   
>   	/* If we can't allocate memory, try again next round. */
> -	skb = dev_alloc_skb(lp->max_packet);
> -	if (skb == NULL) {
> -		drop_skb->dev = dev;
> -		/* Read a packet into drop_skb and don't do anything with it. */
> -		(*lp->read)(lp->fd, drop_skb, lp);
> -		dev->stats.rx_dropped++;
> +	if (lp->options & UML_NET_USE_SKB_READ) {
> +	    /* we expect a full formed, well behaved skb from zero copy drivers here */
> +	    skb = (*lp->skb_read)(lp);
> +	    if (skb == NULL) {
>   		return 0;
> -	}
> -
> -	skb->dev = dev;
> -	skb_put(skb, lp->max_packet);
> -	skb_reset_mac_header(skb);
> -	pkt_len = (*lp->read)(lp->fd, skb, lp);
> -
> -	if (pkt_len > 0) {
> +	    }
> +	    pkt_len = skb->len;
> +	} else {
> +	    skb = dev_alloc_skb(lp->max_packet + 32);
> +	    if (skb == NULL) {
> +		    drop_skb->dev = dev;
> +		    /* Read a packet into drop_skb and don't do anything with it. */
> +		    (*lp->read)(lp->fd, drop_skb, lp);
> +		    dev->stats.rx_dropped++;
> +		    return 0;
> +	    }
> +
> +	    skb_reserve(skb,32);
> +	    skb->dev = dev;
> +	    skb_put(skb, lp->max_packet);
> +	    skb_reset_mac_header(skb);
> +
> +	    // Mark that virtual devices cannot provide required checksum.
> +	    skb->ip_summed = CHECKSUM_NONE;
> +	    pkt_len = (*lp->read)(lp->fd, skb, lp);
> +	    if (pkt_len > 0) {
>   		skb_trim(skb, pkt_len);
>   		skb->protocol = (*lp->protocol)(skb);
> +	    }
> +	}
>   
> +	if (pkt_len > 0) {
>   		dev->stats.rx_bytes += skb->len;
>   		dev->stats.rx_packets++;
>   		netif_rx(skb);
> @@ -192,8 +209,9 @@ static int uml_net_close(struct net_device *dev)
>   	struct uml_net_private *lp = netdev_priv(dev);
>   
>   	netif_stop_queue(dev);
> +	deactivate_fd(lp->fd, dev->irq);
>   
> -	um_free_irq(dev->irq, dev);
> +	free_irq(dev->irq, dev);
>   	if (lp->close != NULL)
>   		(*lp->close)(lp->fd, &lp->user);
>   	lp->fd = -1;
> @@ -216,7 +234,6 @@ static int uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
>   	spin_lock_irqsave(&lp->lock, flags);
>   
>   	len = (*lp->write)(lp->fd, skb, lp);
> -	skb_tx_timestamp(skb);
>   
>   	if (len == skb->len) {
>   		dev->stats.tx_packets++;
> @@ -273,14 +290,13 @@ static void uml_net_poll_controller(struct net_device *dev)
>   static void uml_net_get_drvinfo(struct net_device *dev,
>   				struct ethtool_drvinfo *info)
>   {
> -	strlcpy(info->driver, DRIVER_NAME, sizeof(info->driver));
> -	strlcpy(info->version, "42", sizeof(info->version));
> +	strcpy(info->driver, DRIVER_NAME);
> +	strcpy(info->version, "42");
>   }
>   
>   static const struct ethtool_ops uml_net_ethtool_ops = {
>   	.get_drvinfo	= uml_net_get_drvinfo,
>   	.get_link	= ethtool_op_get_link,
> -	.get_ts_info	= ethtool_op_get_ts_info,
>   };
>   
>   static void uml_net_user_timer_expire(unsigned long _conn)
> @@ -447,6 +463,7 @@ static void eth_configure(int n, void *init, char *mac,
>   	 * These just fill in a data structure, so there's no failure
>   	 * to be worried about.
>   	 */
> +	dev->ethtool_ops = &uml_net_ethtool_ops;
>   	(*transport->kern->init)(dev, init);
>   
>   	*lp = ((struct uml_net_private)
> @@ -459,7 +476,9 @@ static void eth_configure(int n, void *init, char *mac,
>   		  .open 		= transport->user->open,
>   		  .close 		= transport->user->close,
>   		  .remove 		= transport->user->remove,
> +		  .options 		= transport->kern->options,
>   		  .read 		= transport->kern->read,
> +		  .skb_read 		= transport->kern->skb_read,
>   		  .write 		= transport->kern->write,
>   		  .add_address 		= transport->user->add_address,
>   		  .delete_address  	= transport->user->delete_address });
> @@ -475,9 +494,9 @@ static void eth_configure(int n, void *init, char *mac,
>   
>   	dev->mtu = transport->user->mtu;
>   	dev->netdev_ops = &uml_netdev_ops;
> -	dev->ethtool_ops = &uml_net_ethtool_ops;
>   	dev->watchdog_timeo = (HZ >> 1);
> -	dev->irq = UM_ETH_IRQ;
> +	dev->irq = UM_ETH_BASE_IRQ + (rr_counter % UM_ETH_IRQ_RR);
> +	rr_counter++;
>   
>   	err = update_drop_skb(lp->max_packet);
>   	if (err)
> @@ -829,7 +848,7 @@ static void close_devices(void)
>   	spin_lock(&opened_lock);
>   	list_for_each(ele, &opened) {
>   		lp = list_entry(ele, struct uml_net_private, list);
> -		um_free_irq(lp->dev->irq, lp->dev);
> +		free_irq(lp->dev->irq, lp->dev);
>   		if ((lp->close != NULL) && (lp->fd >= 0))
>   			(*lp->close)(lp->fd, &lp->user);
>   		if (lp->remove != NULL)
> diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
> index 4a2037f..be9128b 100644
> --- a/arch/um/include/asm/irq.h
> +++ b/arch/um/include/asm/irq.h
> @@ -1,21 +1,27 @@
> +
>   #ifndef __UM_IRQ_H
>   #define __UM_IRQ_H
>   
> +#define UM_ETH_IRQ_RR	        32
> +
>   #define TIMER_IRQ		0
>   #define UMN_IRQ			1
>   #define CONSOLE_IRQ		2
>   #define CONSOLE_WRITE_IRQ	3
>   #define UBD_IRQ			4
> -#define UM_ETH_IRQ		5
> -#define SSL_IRQ			6
> -#define SSL_WRITE_IRQ		7
> -#define ACCEPT_IRQ		8
> -#define MCONSOLE_IRQ		9
> -#define WINCH_IRQ		10
> -#define SIGIO_WRITE_IRQ 	11
> -#define TELNETD_IRQ 		12
> -#define XTERM_IRQ 		13
> -#define RANDOM_IRQ 		14
> +#define UM_ETH_BASE_IRQ		5
> +
> +#define UM_END_ETH_IRQ	        UM_ETH_BASE_IRQ + UM_ETH_IRQ_RR
> +
> +#define SSL_IRQ			UM_END_ETH_IRQ + 1
> +#define SSL_WRITE_IRQ		UM_END_ETH_IRQ + 2
> +#define ACCEPT_IRQ		UM_END_ETH_IRQ + 3
> +#define MCONSOLE_IRQ		UM_END_ETH_IRQ + 4
> +#define WINCH_IRQ		UM_END_ETH_IRQ + 5
> +#define SIGIO_WRITE_IRQ 	UM_END_ETH_IRQ + 6
> +#define TELNETD_IRQ 		UM_END_ETH_IRQ + 7
> +#define XTERM_IRQ 		UM_END_ETH_IRQ + 8
> +#define RANDOM_IRQ 		UM_END_ETH_IRQ + 9
>   
>   #define LAST_IRQ RANDOM_IRQ
>   #define NR_IRQS (LAST_IRQ + 1)
> diff --git a/arch/um/include/shared/net_kern.h b/arch/um/include/shared/net_kern.h
> index 012ac87..2229126 100644
> --- a/arch/um/include/shared/net_kern.h
> +++ b/arch/um/include/shared/net_kern.h
> @@ -1,4 +1,5 @@
>   /*
> + * Copyright (C) 2012 - 2014 Cisco Systems
>    * Copyright (C) 2002 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>    * Licensed under the GPL
>    */
> @@ -13,6 +14,8 @@
>   #include <linux/list.h>
>   #include <linux/workqueue.h>
>   
> +#define UML_NET_USE_SKB_READ 1
> +
>   struct uml_net {
>   	struct list_head list;
>   	struct net_device *dev;
> @@ -28,6 +31,7 @@ struct uml_net_private {
>   
>   	struct work_struct work;
>   	int fd;
> +	unsigned int options;
>   	unsigned char mac[ETH_ALEN];
>   	int max_packet;
>   	unsigned short (*protocol)(struct sk_buff *);
> @@ -36,6 +40,7 @@ struct uml_net_private {
>   	void (*remove)(void *);
>   	int (*read)(int, struct sk_buff *skb, struct uml_net_private *);
>   	int (*write)(int, struct sk_buff *skb, struct uml_net_private *);
> +	struct sk_buff * (*skb_read)(struct uml_net_private *);
>   
>   	void (*add_address)(unsigned char *, unsigned char *, void *);
>   	void (*delete_address)(unsigned char *, unsigned char *, void *);
> @@ -47,6 +52,8 @@ struct net_kern_info {
>   	unsigned short (*protocol)(struct sk_buff *);
>   	int (*read)(int, struct sk_buff *skb, struct uml_net_private *);
>   	int (*write)(int, struct sk_buff *skb, struct uml_net_private *);
> +	struct sk_buff * (*skb_read)(struct uml_net_private *);
> +	unsigned int options;
>   };
>   
>   struct transport {
> @@ -59,11 +66,28 @@ struct transport {
>   	const int setup_size;
>   };
>   
> +struct mmsg_queue_info {
> +	int fd;
> +	struct mmsghdr * mmsg_send_vector;
> +	void ** skb_send_vector;
> +	int queue_depth, head, tail, max_depth;
> +	spinlock_t head_lock;
> +	spinlock_t tail_lock;
> +	unsigned int queue_fsm;
> +};
> +
>   extern struct net_device *ether_init(int);
>   extern unsigned short ether_protocol(struct sk_buff *);
>   extern int tap_setup_common(char *str, char *type, char **dev_name,
>   			    char **mac_out, char **gate_addr);
>   extern void register_transport(struct transport *new);
>   extern unsigned short eth_protocol(struct sk_buff *skb);
> +extern struct sk_buff *my_build_skb(void * head, void *data, unsigned int frag_size);
> +
> +extern void flush_pending_netio(void);
> +
> +extern int uml_net_advance_tail( struct mmsg_queue_info * queue_info, int advance);
> +extern int uml_net_advance_head( struct mmsg_queue_info * queue_info, int advance);
> +extern int uml_net_flush_mmsg_queue(struct mmsg_queue_info * queue_info, int queue_depth);
>   
>   #endif
> diff --git a/arch/um/include/shared/net_user.h b/arch/um/include/shared/net_user.h
> index 3dabbe1..4b46f37 100644
> --- a/arch/um/include/shared/net_user.h
> +++ b/arch/um/include/shared/net_user.h
> @@ -1,4 +1,5 @@
>   /*
> + * Copyright (C) 2012 - 2014 Cisco Systems
>    * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
>    * Licensed under the GPL
>    */
> @@ -38,10 +39,15 @@ extern void tap_check_ips(char *gate_addr, unsigned char *eth_addr);
>   extern void read_output(int fd, char *output_out, int len);
>   
>   extern int net_read(int fd, void *buf, int len);
> +extern int net_readv(int fd, void *iov, int iovcnt);
>   extern int net_recvfrom(int fd, void *buf, int len);
> +extern int net_recvfrom2(int fd, void *buf, int len, void *src_addr, int *addrlen);
>   extern int net_write(int fd, void *buf, int len);
> +extern int net_writev(int fd, void *iov, int iovcnt);
>   extern int net_send(int fd, void *buf, int len);
>   extern int net_sendto(int fd, void *buf, int len, void *to, int sock_len);
> +extern int net_sendmessage(int fd, void *msg, int flags);
> +extern int net_recvmessage(int fd, void *msg, int flags);
>   
>   extern void open_addr(unsigned char *addr, unsigned char *netmask, void *arg);
>   extern void close_addr(unsigned char *addr, unsigned char *netmask, void *arg);
> @@ -50,4 +56,22 @@ extern char *split_if_spec(char *str, ...);
>   
>   extern int dev_netmask(void *d, void *m);
>   
> +
> +extern void uml_net_destroy_skb(void * skb);
> +extern void * uml_net_build_skb (void * dev);
> +extern void * uml_net_skb_data (void * skb);
> +
> +extern void add_skbuffs(void * msgvec, void ** skbvec, int size, int skb_size, int offset);
> +extern void add_header_buffers(void * msgvec, int size, int header_size);
> +extern void * build_mmsg_vector(int size, int iovsize);
> +extern void rebuild_skbuf_vector(void ** skbvec, int size, void * dev);
> +extern void * build_skbuf_vector(int size, void * dev);
> +extern int net_recvmmsg(int fd, void *msgvec, unsigned int vlen,
> +		unsigned int flags, struct timespec *timeout);
> +extern int net_sendmmsg(int fd, void *msgvec, unsigned int vlen,
> +		unsigned int flags);
> +extern void repair_mmsg (void *msgvec, int iovsize, int header_size);
> +extern void destroy_skb_vector(void ** vector, int size);
> +extern void destroy_mmsg_vector(void * mmsgvector, int size, int free_iov_base);
> +
>   #endif
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index 5d7ee49e..f4c6fb1 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -17,6 +17,7 @@
>   #include <as-layout.h>
>   #include <kern_util.h>
>   #include <os.h>
> +#include <net_kern.h>
>   
>   /*
>   *	We are on the "kernel side" so we cannot pick up the sys/epoll.h
> @@ -136,6 +137,8 @@ void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>   		spin_unlock_irqrestore(&uml_sigio_lock, flags);
>   	}
>   
> +	flush_pending_netio();
> +
>   	/* This needs a better way - it slows down the event loop */
>   
>   	free_irqs();

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

