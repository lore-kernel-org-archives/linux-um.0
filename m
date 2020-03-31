Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJJvM-0003bs-7J
 for linux-um@lists.infradead.org; Tue, 31 Mar 2020 16:39:37 +0000
Received: by mail-wm1-x344.google.com with SMTP id a81so3548836wmf.5
 for <linux-um@lists.infradead.org>; Tue, 31 Mar 2020 09:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
 <674ad16d7de34db7b562a08b971bdde179158902.camel@sipsolutions.net>
 <CACT4Y+bdxmRmr57JO_k0whhnT2BqcSA=Jwa5M6=9wdyOryv6Ug@mail.gmail.com>
 <ded22d68e623d2663c96a0e1c81d660b9da747bc.camel@sipsolutions.net>
 <CACT4Y+YzM5bwvJ=yryrz1_y=uh=NX+2PNu4pLFaqQ2BMS39Fdg@mail.gmail.com>
 <2cee72779294550a3ad143146283745b5cccb5fc.camel@sipsolutions.net>
 <CACT4Y+YhwJK+F7Y7NaNpAwwWR-yZMfNevNp_gcBoZ+uMJRgsSA@mail.gmail.com>
 <a51643dbff58e16cc91f33273dbc95dded57d3e6.camel@sipsolutions.net>
In-Reply-To: <a51643dbff58e16cc91f33273dbc95dded57d3e6.camel@sipsolutions.net>
From: Patricia Alfonso <trishalfonso@google.com>
Date: Tue, 31 Mar 2020 09:39:21 -0700
Message-ID: <CAKFsvULjkQ7T6QhspHg87nnDpo-VW1qg2M3jJGB+NcwTQNeXGQ@mail.gmail.com>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>, anton.ivanov@cambridgegreys.com

On Mon, Mar 30, 2020 at 1:41 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Mon, 2020-03-30 at 10:38 +0200, Dmitry Vyukov wrote:
> > On Mon, Mar 30, 2020 at 9:44 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> > > On Fri, 2020-03-20 at 16:18 +0100, Dmitry Vyukov wrote:
> > > > > Wait ... Now you say 0x7fbfffc000, but that is almost fine? I think you
> > > > > confused the values - because I see, on userspace, the following:
> > > >
> > > > Oh, sorry, I copy-pasted wrong number. I meant 0x7fff8000.
> > >
> > > Right, ok.
> > >
> > > > Then I would expect 0x1000 0000 0000 to work, but you say it doesn't...
> > >
> > > So it just occurred to me - as I was mentioning this whole thing to
> > > Richard - that there's probably somewhere some check about whether some
> > > space is userspace or not.
> > >

Yeah, it seems the "Kernel panic - not syncing: Segfault with no mm",
"Kernel mode fault at addr...", and "Kernel tried to access user
memory at addr..." errors all come from segv() in
arch/um/kernel/trap.c due to what I think is this type of check
whether the address is
in userspace or not.

> > > I'm beginning to think that we shouldn't just map this outside of the
> > > kernel memory system, but properly treat it as part of the memory that's
> > > inside. And also use KASAN_VMALLOC.
> > >
> > > We can probably still have it at 0x7fff8000, just need to make sure we
> > > actually map it? I tried with vm_area_add_early() but it didn't really
> > > work once you have vmalloc() stuff...
> >

What x86 does when KASAN_VMALLOC is disabled is make all vmalloc
region accesses succeed by default
by using the early shadow memory to have completely unpoisoned and
unpoisonable read-only pages for all of vmalloc (which includes
modules). When KASAN_VMALLOC is enabled in x86, the shadow memory is not
allocated for the vmalloc region at startup. New chunks of shadow
memory are allocated and unpoisoned every time there's a vmalloc()
call. A similar thing might have to be done here by mprotect()ing
the vmalloc space as read only, unpoisoned without KASAN_VMALLOC. This
issue here is that
kasan_init runs so early in the process that the vmalloc region for
uml is not setup yet.


> > But we do mmap it, no? See kasan_init() -> kasan_map_memory() -> mmap.
>
> Of course. But I meant inside the UML PTE system. We end up *unmapping*
> it when loading modules, because it overlaps vmalloc space, and then we
> vfree() something again, and unmap it ... because of the overlap.
>
> And if it's *not* in the vmalloc area, then the kernel doesn't consider
> it valid, and we seem to often just fault when trying to determine
> whether it's valid kernel memory or not ... Though I'm not really sure I
> understand the failure part of this case well yet.
>

I have been testing this issue in a multitude of ways and have only
been getting more confused. It's still very unclear where exactly the
problem occurs, mostly because the errors I found most frequently were
reported in segv(), but the stack traces never contained segv.

Does anyone know if/how UML determines if memory being accessed is
kernel or user memory?

> johannes
>


--
Best,
Patricia

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

