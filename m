Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7E81-00071m-Fx
 for linux-um@lists.infradead.org; Mon, 09 Sep 2019 07:30:26 +0000
Message-ID: <3d9298b447ca662da4475169896e767ad89b5146.camel@sipsolutions.net>
Subject: Re: [RFC] um: have real DMA barriers with virtio
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 09 Sep 2019 09:30:23 +0200
In-Reply-To: <58f4cdd7-6601-f0e1-2d0b-58b62cbc1020@kot-begemot.co.uk>
References: <1567807353-Ieca0b50a173f8a587d412db861c7ae4d6bae97c4@changeid>
 <a5415671bfe700f197a72e25351d13207f86641e.camel@sipsolutions.net>
 <02eb6880-1e7b-1921-2057-008737ee8d48@kot-begemot.co.uk>
 <300774e43e0a755a9e57c587ece7bb44537f1d22.camel@sipsolutions.net>
 <58f4cdd7-6601-f0e1-2d0b-58b62cbc1020@kot-begemot.co.uk>
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

On Mon, 2019-09-09 at 08:27 +0100, Anton Ivanov wrote:

> I would like at some point to convert the "helper thread" semantics of 
> ubd, etc to look like DMA and use DMA barrier as well as have the 
> relevant DMA infrastructure.

Right, I got that part, makes sense.

> At present they work only because the IPC forces the host kernel to 
> invoke a barrier. If I remember correctly, the actual place where the 
> barrier is invoked is the IPC socket enqueue/dequeue in the host kernel.
> 
> If, for some reason the host kernel does not invoke the barrier (f.e., 
> if someone optimizes the queue operations so there is no need) they will 
> break.

Sure, also makes sense.

> IMHO adding DMA emulation will have benefits for both existing and 
> future drivers.

Well, in a sense virtio is emulating DMA. We could even just add another
virtio transport (not the vhost-user backed one we have now) and just
rely on virtio-blk, and implement just the device side like qemu already
would. I suppose it might be easy to even copy that.

But anyway - sorry for being dense, maybe it's too early morning :-) But
I still don't understand what that means for this patch...

> > That said, I did find a few other issues still, so I'll be reposting.
> > I'll also try to open /proc/self/mem as the file descriptor to pass to
> > the virtio device instead of using physmem_fd, because our .bss isn't
> > actually part of physmem_fd, and that cost me a few hours debugging
> > already ;-)
> 
> I will retest vs BESS/DPDK when it is ready.

Thanks. I'll repost in the next couple of days, want to experiment with
the /proc/self/mem first, and if that works better use it.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

