Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIEJY-0007bV-Uf
 for linux-um@lists.infradead.org; Wed, 09 Oct 2019 15:55:50 +0000
Subject: Re: RFC - make it possible to add iomem at runtime.
References: <841ebee1-8ef3-b4d8-ba60-925461ad6ee9@cambridgegreys.com>
 <m2tv8i6jq3.wl-thehajime@gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <0633ee21-de74-accf-78aa-5b005da31572@cambridgegreys.com>
Date: Wed, 9 Oct 2019 16:55:39 +0100
MIME-Version: 1.0
In-Reply-To: <m2tv8i6jq3.wl-thehajime@gmail.com>
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org



On 09/10/2019 16:07, Hajime Tazaki wrote:
> 
> Hello,
> 
> On Wed, 09 Oct 2019 22:34:27 +0900,
> Anton Ivanov wrote:
>>
>> Hi all,
>>
>> I am looking at adding an af_xdp network transport. As a part of its
>> initialization it needs to allocate a memory area to be shared for
>> tx/rx buffers. I would like to do that without dipping into the
>> "normal" UML memory pool if possible.
>>
>> The only way to allocate this at present is to pass it as an iomem
>> "region". This, however, is a bit dated and limited - it assumes an
>> existing file on a block device which is added at boot and not changed
>> after that. I cannot for example allocate at runtime and map that as
>> iomem.
>>
>> I was wondering if we can relax the "on-boot" only requirement and
>> allow allocations to happen during runtime as the drivers get
>> initialized. This will make implementing af_xdp and/or tpacket as well
>> as various memifs as network transports much easier.
> 
> I'm quite not sure if this is relevant to what you proposed,
> but we're recently trying to integrate LKL (Linux Kernel
> Library) to UML.
> 
> Though the internals of LKL and UML are different, we could
> use devices created by LKL (host) and use it in UML via
> virtio-mmio driver (below).  This was done by a dynamically
> created iomem region, which I think it's relevant to your idea.
> 
> Here is nasty code which I have experimented.
> In this code we use __uml_setup() to create a region, but it
> should be possible to trigger via a command invoked by users.
> 
> https://github.com/thehajime/linux/commit/e7dca9fced709ad015b69bf0c49c2afee1db45be
> 
> Apologize if this is out of topic.

It's on topic. I have read that commit and it gave me some food for 
thought.

Specifically - I need to look again at the platform device interface and 
reservation of "resources" this way.

Best Regards and thanks,


> 
> # We still need more time to fit in a shape, but we wish to
>    propose another RFC on this integration later.
> 
> -- Hajime
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

