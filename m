Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i74Kt-0007Mi-IQ
 for linux-um@lists.infradead.org; Sun, 08 Sep 2019 21:03:05 +0000
Subject: Re: [RFC] um: have real DMA barriers with virtio
References: <1567807353-Ieca0b50a173f8a587d412db861c7ae4d6bae97c4@changeid>
 <a5415671bfe700f197a72e25351d13207f86641e.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <02eb6880-1e7b-1921-2057-008737ee8d48@kot-begemot.co.uk>
Date: Sun, 8 Sep 2019 21:23:52 +0100
MIME-Version: 1.0
In-Reply-To: <a5415671bfe700f197a72e25351d13207f86641e.camel@sipsolutions.net>
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

On 07/09/2019 20:32, Johannes Berg wrote:
> On Sat, 2019-09-07 at 00:02 +0200, Johannes Berg wrote:
>>
>> Make the override to compiler barriers depend on !virtio.
> 
>   
>> +#if !IS_ENABLED(CONFIG_VIRTIO_UML)
>> +/*
>> + * We can afford to just have compiler barriers here - unless
>> + * virtio is enabled, because then we communicate with another
>> + * process and (despite being UP internally) cannot assume we
>> + * run on a UP system.
>> + */
>>   #define dma_rmb()	barrier()
>>   #define dma_wmb()	barrier()
>> +#endif
> 
> I suppose the [RFC] question is: should we even keep this at all? It
> seems to me that we'd only encounter dma_rmb()/dma_wmb() in a driver
> that's for some kind of DMA device, which is only possible with virtio,
> so there's no gain in overriding them to just barrier() since the non-
> driver part of the kernel will never use them?

Disk IO at present is for all practical purposes DMA and is abusing 
artefacts from the IPC to work.

The IO itself happens in another thread which may be on a different CPU. 
It does not use any barriers or anything to ensure that the buffered 
data is synchronized and relies on the fact that the IPC which uses a 
socketpair somewhere in the guts of the kernel will invoke a barrier 
while pushing the data along.

I have looked a couple of times at expressing this and other helper 
threads as proper DMA, but never got around to do it.

If it is done for virtio this will make life easier elsewhere to finish 
the other bits.

> 
> IOW - is the ifdef worth it, vs. just removing it completely? I suspect
> not.
> 
> johannes

While at it - the WARN_ in the virtio driver should really become more 
informative so it is clear who and what caused them.


> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 


-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

