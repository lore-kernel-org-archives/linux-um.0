Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6gS2-00030E-Iw
 for linux-um@lists.infradead.org; Sat, 07 Sep 2019 19:32:51 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1i6gRy-0006PL-7M
 for linux-um@lists.infradead.org; Sat, 07 Sep 2019 21:32:46 +0200
Message-ID: <a5415671bfe700f197a72e25351d13207f86641e.camel@sipsolutions.net>
Subject: Re: [RFC] um: have real DMA barriers with virtio
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sat, 07 Sep 2019 21:32:43 +0200
In-Reply-To: <1567807353-Ieca0b50a173f8a587d412db861c7ae4d6bae97c4@changeid>
References: <1567807353-Ieca0b50a173f8a587d412db861c7ae4d6bae97c4@changeid>
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

On Sat, 2019-09-07 at 00:02 +0200, Johannes Berg wrote:
> 
> Make the override to compiler barriers depend on !virtio.

 
> +#if !IS_ENABLED(CONFIG_VIRTIO_UML)
> +/*
> + * We can afford to just have compiler barriers here - unless
> + * virtio is enabled, because then we communicate with another
> + * process and (despite being UP internally) cannot assume we
> + * run on a UP system.
> + */
>  #define dma_rmb()	barrier()
>  #define dma_wmb()	barrier()
> +#endif

I suppose the [RFC] question is: should we even keep this at all? It
seems to me that we'd only encounter dma_rmb()/dma_wmb() in a driver
that's for some kind of DMA device, which is only possible with virtio,
so there's no gain in overriding them to just barrier() since the non-
driver part of the kernel will never use them?

IOW - is the ifdef worth it, vs. just removing it completely? I suspect
not.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

