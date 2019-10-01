Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFDAv-0006JO-T0
 for linux-um@lists.infradead.org; Tue, 01 Oct 2019 08:06:27 +0000
Subject: Re: [PATCH] um: Loadable BPF "Firmware" for vector drivers
References: <20190930131939.29354-1-anton.ivanov@cambridgegreys.com>
 <89e6fd612acc081accd278287f96afc8efbcc16c.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <86099245-728c-a76e-e7e3-f08c764e1485@cambridgegreys.com>
Date: Tue, 1 Oct 2019 09:06:15 +0100
MIME-Version: 1.0
In-Reply-To: <89e6fd612acc081accd278287f96afc8efbcc16c.camel@sipsolutions.net>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: rrs@debian.org, richard@nod.at, 938962@bugs.debian.org



On 01/10/2019 08:50, Johannes Berg wrote:
> On Mon, 2019-09-30 at 14:19 +0100, Anton Ivanov wrote:
>> All vector drivers now allow a BPF program to be loaded and
>> associated with the RX socket in the host kernel.
>>
>> 1. The program can be loaded as an extra kernel command line
>> option to any of the drivers.
>>
>> 2. The program can also be loaded as "firmware", using the
>> ethtool flash option. It is possible to turn this facility
>> on or off using a command line option.
>>
>> A simplistic wrapper for generating the BPF firmware for the raw
>> socket driver out of a tcpdump/libpcap filter expression can be
>> found at: https://github.com/kot-begemot-uk/uml_vector_utilities/
> 
> That's kinda cool.
> 
> Why just BPF though, not eBPF with all that brings?

The filter language for the SOCKOPT is specified as BPF everywhere. I 
have not looked at what the sockopt does in the host kernel under the 
hood and if it takes eBPF.

Also, the intention is to provide backward compatible wrappers for the 
existing pcap functionality as per the Debian bug which is cc-ed and 
that generates/uses basic BPF out of a pcap expression. We can add those 
to the "uml-utilities" package present in Debian and other distros.

I will try to get around and write a wrapper which takes legacy UML 
network interface arguments and rewrites them as options for the new 
vector drivers.

> 
> Or is that because the BPF filter is actually attached to the socket in
> the host, if I'm reading this correctly?

Yes. The idea is to offload it from the guest to the host. I have had 
this idea as well as some PoC code to do that since like 2012. (e)BPF is 
an excellent way to represent "firmware" for vNICs, I am surprised it is 
not in active use :)

It should be possible to expand the concept for other stuff like AF_XDP, 
etc but I need to get around to implement that in the first place.

> 
> 
> Couple of style nits below:
> 
>> +static bool get_bpf_flash(struct arglist *def)
>> +{
>> +	return uml_vector_fetch_arg(def, "bpfflash") != NULL;
>> +}
>> +
>> +
> 
> Needs just one blank line?
> 
>> @@ -1125,6 +1142,7 @@ static int vector_net_close(struct net_device *dev)
>>   	netif_stop_queue(dev);
>>   	del_timer(&vp->tl);
>>   
>> +
>>   	if (vp->fds == NULL)
>>   		return 0;
> 
> not needed
>   
>> @@ -1139,6 +1157,8 @@ static int vector_net_close(struct net_device *dev)
>>   	}
>>   	tasklet_kill(&vp->tx_poll);
>>   	if (vp->fds->rx_fd > 0) {
>> +		if (vp->bpf)
>> +			uml_vector_detach_bpf(vp->fds->rx_fd, vp->bpf);
>>   		os_close_file(vp->fds->rx_fd);
>>   		vp->fds->rx_fd = -1;
>>   	}
> 
> I guess you moved some code here or something and the blank line was
> left?
> 
>> +/*
>> + * We cannot use the firmware.c loader API here because this is not a module
>> + *  and we do not have a proper device structure to pass to it as required
>> + *  by the firmware API
>> + */
> 
> You just have to make up a platform device, see e.g. net/wireless/reg.c.
> IMHO better than open-coding all this.

Good idea.

> 
>> @@ -1528,8 +1618,9 @@ static void vector_eth_configure(
>>   		.in_write_poll		= false,
>>   		.coalesce		= 2,
>>   		.req_size		= get_req_size(def),
>> -		.in_error		= false
>> -		});
>> +		.in_error		= false,
>> +		.bpf			= NULL
>> +	});
> 
> That's not really needed, but I guess you have everything here anyway.
> 
>> +int uml_vector_detach_bpf(int fd, void *bpf)
>> +{
>> +	struct sock_fprog *prog = bpf;
>> +
>> +	int err = setsockopt(fd, SOL_SOCKET, SO_DETACH_FILTER, bpf, sizeof(struct sock_fprog));
> 
> Spurious blank line, line too long.
>   
>> -void *uml_vector_default_bpf(int fd, void *mac)
>> +	if (err < 0)
>> +		printk(KERN_ERR BPF_DETACH_FAIL, prog->len, prog->filter, fd, -errno);
> 
> also looks pretty long
> 
>> +	return err;
>> +}
>> +void *uml_vector_default_bpf(void *mac)
>>   {
>>   	struct sock_filter *bpf;
>>   	uint32_t *mac1 = (uint32_t *)(mac + 2);
>>   	uint16_t *mac2 = (uint16_t *) mac;
>> -	struct sock_fprog bpf_prog = {
>> -		.len = 6,
>> -		.filter = NULL,
>> -	};
>> +	struct sock_fprog *bpf_prog;
>>   
>> +	bpf_prog = uml_kmalloc(sizeof(struct sock_fprog), UM_GFP_KERNEL);
>> +	if (bpf_prog != NULL) {
> 
> generally, kernel coding style prefers to remove " != NULL" (per
> checkpatch, anyway)
> 
>> +		bpf_prog->len = DEFAULT_BPF_LEN;
>> +		bpf_prog->filter = NULL;
>> +	} else
>> +		return NULL;
> 
> and braces on all branches of if statements
> 
> johannes
> 

Ack - I will look at the other bits, thanks for reviewing it.

> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

