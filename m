Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIpzX-00067q-Is
 for linux-um@lists.infradead.org; Mon, 30 Mar 2020 08:41:56 +0000
Message-ID: <a51643dbff58e16cc91f33273dbc95dded57d3e6.camel@sipsolutions.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 30 Mar 2020 10:41:43 +0200
In-Reply-To: <CACT4Y+YhwJK+F7Y7NaNpAwwWR-yZMfNevNp_gcBoZ+uMJRgsSA@mail.gmail.com>
 (sfid-20200330_103904_296794_2F7C15A1)
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
 <674ad16d7de34db7b562a08b971bdde179158902.camel@sipsolutions.net>
 <CACT4Y+bdxmRmr57JO_k0whhnT2BqcSA=Jwa5M6=9wdyOryv6Ug@mail.gmail.com>
 <ded22d68e623d2663c96a0e1c81d660b9da747bc.camel@sipsolutions.net>
 <CACT4Y+YzM5bwvJ=yryrz1_y=uh=NX+2PNu4pLFaqQ2BMS39Fdg@mail.gmail.com>
 <2cee72779294550a3ad143146283745b5cccb5fc.camel@sipsolutions.net>
 <CACT4Y+YhwJK+F7Y7NaNpAwwWR-yZMfNevNp_gcBoZ+uMJRgsSA@mail.gmail.com>
 (sfid-20200330_103904_296794_2F7C15A1)
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
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Patricia Alfonso <trishalfonso@google.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, anton.ivanov@cambridgegreys.com

On Mon, 2020-03-30 at 10:38 +0200, Dmitry Vyukov wrote:
> On Mon, Mar 30, 2020 at 9:44 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> > On Fri, 2020-03-20 at 16:18 +0100, Dmitry Vyukov wrote:
> > > > Wait ... Now you say 0x7fbfffc000, but that is almost fine? I think you
> > > > confused the values - because I see, on userspace, the following:
> > > 
> > > Oh, sorry, I copy-pasted wrong number. I meant 0x7fff8000.
> > 
> > Right, ok.
> > 
> > > Then I would expect 0x1000 0000 0000 to work, but you say it doesn't...
> > 
> > So it just occurred to me - as I was mentioning this whole thing to
> > Richard - that there's probably somewhere some check about whether some
> > space is userspace or not.
> > 
> > I'm beginning to think that we shouldn't just map this outside of the
> > kernel memory system, but properly treat it as part of the memory that's
> > inside. And also use KASAN_VMALLOC.
> > 
> > We can probably still have it at 0x7fff8000, just need to make sure we
> > actually map it? I tried with vm_area_add_early() but it didn't really
> > work once you have vmalloc() stuff...
> 
> But we do mmap it, no? See kasan_init() -> kasan_map_memory() -> mmap.

Of course. But I meant inside the UML PTE system. We end up *unmapping*
it when loading modules, because it overlaps vmalloc space, and then we
vfree() something again, and unmap it ... because of the overlap.

And if it's *not* in the vmalloc area, then the kernel doesn't consider
it valid, and we seem to often just fault when trying to determine
whether it's valid kernel memory or not ... Though I'm not really sure I
understand the failure part of this case well yet.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

