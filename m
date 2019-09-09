Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7DUK-0008Lb-O5
 for linux-um@lists.infradead.org; Mon, 09 Sep 2019 06:49:26 +0000
Message-ID: <300774e43e0a755a9e57c587ece7bb44537f1d22.camel@sipsolutions.net>
Subject: Re: [RFC] um: have real DMA barriers with virtio
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 09 Sep 2019 08:49:18 +0200
In-Reply-To: <02eb6880-1e7b-1921-2057-008737ee8d48@kot-begemot.co.uk>
References: <1567807353-Ieca0b50a173f8a587d412db861c7ae4d6bae97c4@changeid>
 <a5415671bfe700f197a72e25351d13207f86641e.camel@sipsolutions.net>
 <02eb6880-1e7b-1921-2057-008737ee8d48@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org

On Sun, 2019-09-08 at 21:23 +0100, Anton Ivanov wrote:
> On 07/09/2019 20:32, Johannes Berg wrote:
> > On Sat, 2019-09-07 at 00:02 +0200, Johannes Berg wrote:
> > > Make the override to compiler barriers depend on !virtio.
> > 
> >   
> > > +#if !IS_ENABLED(CONFIG_VIRTIO_UML)
> > > +/*
> > > + * We can afford to just have compiler barriers here - unless
> > > + * virtio is enabled, because then we communicate with another
> > > + * process and (despite being UP internally) cannot assume we
> > > + * run on a UP system.
> > > + */
> > >   #define dma_rmb()	barrier()
> > >   #define dma_wmb()	barrier()
> > > +#endif
> > 
> > I suppose the [RFC] question is: should we even keep this at all? It
> > seems to me that we'd only encounter dma_rmb()/dma_wmb() in a driver
> > that's for some kind of DMA device, which is only possible with virtio,
> > so there's no gain in overriding them to just barrier() since the non-
> > driver part of the kernel will never use them?
> 
> Disk IO at present is for all practical purposes DMA and is abusing 
> artefacts from the IPC to work.

Hmm, good point.

> The IO itself happens in another thread which may be on a different CPU. 
> It does not use any barriers or anything to ensure that the buffered 
> data is synchronized and relies on the fact that the IPC which uses a 
> socketpair somewhere in the guts of the kernel will invoke a barrier 
> while pushing the data along.

Makes sense. However, the UBD code still doesn't contain any DMA
barriers, so what I said above still holds true I think - just removing
the dma_rmb/dma_wmb definitions shouldn't really affect much if
anything.

Not sure I understand you correctly, but I guess you're saying we should
remove the definitions in all cases, so we can use the DMA barriers
properly even in the non-virtio case?

> While at it - the WARN_ in the virtio driver should really become more 
> informative so it is clear who and what caused them.

I replaced most of them with just error logging, since the call stacks
weren't really useful anyway. There are now two left, but those are
internal (to UML) calculation issues, so not something that'd trigger in
a device-dependent way.

That said, I did find a few other issues still, so I'll be reposting.
I'll also try to open /proc/self/mem as the file descriptor to pass to
the virtio device instead of using physmem_fd, because our .bss isn't
actually part of physmem_fd, and that cost me a few hours debugging
already ;-)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

