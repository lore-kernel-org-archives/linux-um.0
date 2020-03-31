Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJMwM-00062O-MX
 for linux-um@lists.infradead.org; Tue, 31 Mar 2020 19:52:52 +0000
Message-ID: <3fca96c19ca1e56fa36ee0c428c95ab82883a4fd.camel@sipsolutions.net>
Subject: Re: [RFC v4 23/25] um lkl: add UML network driver for lkl
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 31 Mar 2020 21:52:46 +0200
In-Reply-To: <m25zelxn8w.wl-thehajime@gmail.com>
 (sfid-20200331_043814_756678_0201C8CF)
References: <cover.1585579244.git.thehajime@gmail.com>
 <0f087b36ad579eeb8062b12e9e61566d9b5b18ac.1585579244.git.thehajime@gmail.com>
 <b2a730a4bcafb13cb1b29a637f8f8449cf3521d6.camel@sipsolutions.net>
 <m25zelxn8w.wl-thehajime@gmail.com> (sfid-20200331_043814_756678_0201C8CF)
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, retrage01@gmail.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org

On Tue, 2020-03-31 at 11:38 +0900, Hajime Tazaki wrote:
> Thanks for the comments, Johannes.
> 
> On Tue, 31 Mar 2020 06:31:15 +0900,
> Johannes Berg wrote:
> > 
> > > +++ b/arch/um/lkl/include/asm/irq.h
> > > @@ -2,6 +2,9 @@
> > >  #ifndef _ASM_LKL_IRQ_H
> > >  #define _ASM_LKL_IRQ_H
> > >  
> > > +/* pull UML's definitions */
> > > +#include "../../../include/asm/irq.h"
> > 
> > This is _really_ ugly.
> 
> Hmm, in previous patchset (until v3), I was using the worse approach
> (I thought) to avoid this include.
> 
> +KBUILD_CFLAGS  += -DTIMER_IRQ=0 -DUBD_IRQ=4 -DUM_ETH_IRQ=5 -DLAST_IRQ=15
> 
> And I thought the current way is better than before.

Yeah, ok, that's worse :)

But why is it even needed? It kinda seems to me that this means we're
not splitting the code well.

IMHO, if we even want to treat LKL/UML as sub-arches, then we should
still split the driver code off in a cleaner way, rather than linking
half here half there?

And maybe reorg the code... but I'll reply over in your other email
more.

> > > @@ -181,6 +196,11 @@ void init_IRQ(void)
> > >  	for (i = 0; i < NR_IRQS; i++)
> > >  		irq_set_chip_and_handler(i, &dummy_irq_chip, handle_simple_irq);
> > >  
> > > +#if defined(__linux) && (defined(__i386) || defined(__x86_64))
> > 
> > What's with all those ifdefs with this condition?
> 
> Same as above.
> but I agree that the ifdefs are cryptic; I'll try to make it more
> understandable if I use ifdefs.

I'm also generally not convinced that it's a good idea to sprinkle these
kinds of ifdefs over the place.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

