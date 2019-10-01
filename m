Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFCvl-0008CK-4N
 for linux-um@lists.infradead.org; Tue, 01 Oct 2019 07:50:46 +0000
Message-ID: <89e6fd612acc081accd278287f96afc8efbcc16c.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Loadable BPF "Firmware" for vector drivers
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 01 Oct 2019 09:50:39 +0200
In-Reply-To: <20190930131939.29354-1-anton.ivanov@cambridgegreys.com>
References: <20190930131939.29354-1-anton.ivanov@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: rrs@debian.org, richard@nod.at, 938962@bugs.debian.org

On Mon, 2019-09-30 at 14:19 +0100, Anton Ivanov wrote:
> All vector drivers now allow a BPF program to be loaded and
> associated with the RX socket in the host kernel.
> 
> 1. The program can be loaded as an extra kernel command line
> option to any of the drivers.
> 
> 2. The program can also be loaded as "firmware", using the
> ethtool flash option. It is possible to turn this facility
> on or off using a command line option.
> 
> A simplistic wrapper for generating the BPF firmware for the raw
> socket driver out of a tcpdump/libpcap filter expression can be
> found at: https://github.com/kot-begemot-uk/uml_vector_utilities/

That's kinda cool.

Why just BPF though, not eBPF with all that brings?

Or is that because the BPF filter is actually attached to the socket in
the host, if I'm reading this correctly?


Couple of style nits below:

> +static bool get_bpf_flash(struct arglist *def)
> +{
> +	return uml_vector_fetch_arg(def, "bpfflash") != NULL;
> +}
> +
> +

Needs just one blank line?

> @@ -1125,6 +1142,7 @@ static int vector_net_close(struct net_device *dev)
>  	netif_stop_queue(dev);
>  	del_timer(&vp->tl);
>  
> +
>  	if (vp->fds == NULL)
>  		return 0;

not needed
 
> @@ -1139,6 +1157,8 @@ static int vector_net_close(struct net_device *dev)
>  	}
>  	tasklet_kill(&vp->tx_poll);
>  	if (vp->fds->rx_fd > 0) {
> +		if (vp->bpf)
> +			uml_vector_detach_bpf(vp->fds->rx_fd, vp->bpf);
>  		os_close_file(vp->fds->rx_fd);
>  		vp->fds->rx_fd = -1;
>  	}

I guess you moved some code here or something and the blank line was
left?

> +/*
> + * We cannot use the firmware.c loader API here because this is not a module
> + *  and we do not have a proper device structure to pass to it as required
> + *  by the firmware API
> + */

You just have to make up a platform device, see e.g. net/wireless/reg.c.
IMHO better than open-coding all this.

> @@ -1528,8 +1618,9 @@ static void vector_eth_configure(
>  		.in_write_poll		= false,
>  		.coalesce		= 2,
>  		.req_size		= get_req_size(def),
> -		.in_error		= false
> -		});
> +		.in_error		= false,
> +		.bpf			= NULL
> +	});

That's not really needed, but I guess you have everything here anyway.

> +int uml_vector_detach_bpf(int fd, void *bpf)
> +{
> +	struct sock_fprog *prog = bpf;
> +
> +	int err = setsockopt(fd, SOL_SOCKET, SO_DETACH_FILTER, bpf, sizeof(struct sock_fprog));

Spurious blank line, line too long.
 
> -void *uml_vector_default_bpf(int fd, void *mac)
> +	if (err < 0)
> +		printk(KERN_ERR BPF_DETACH_FAIL, prog->len, prog->filter, fd, -errno);

also looks pretty long

> +	return err;
> +}
> +void *uml_vector_default_bpf(void *mac)
>  {
>  	struct sock_filter *bpf;
>  	uint32_t *mac1 = (uint32_t *)(mac + 2);
>  	uint16_t *mac2 = (uint16_t *) mac;
> -	struct sock_fprog bpf_prog = {
> -		.len = 6,
> -		.filter = NULL,
> -	};
> +	struct sock_fprog *bpf_prog;
>  
> +	bpf_prog = uml_kmalloc(sizeof(struct sock_fprog), UM_GFP_KERNEL);
> +	if (bpf_prog != NULL) {

generally, kernel coding style prefers to remove " != NULL" (per
checkpatch, anyway)

> +		bpf_prog->len = DEFAULT_BPF_LEN;
> +		bpf_prog->filter = NULL;
> +	} else
> +		return NULL;

and braces on all branches of if statements

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

