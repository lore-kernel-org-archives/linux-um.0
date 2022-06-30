Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6ozH-00FqXp-G7
	for linux-um@lists.infradead.org; Thu, 30 Jun 2022 07:53:21 +0000
Received: by mail-wr1-x42f.google.com with SMTP id v9so10385272wrp.7
        for <linux-um@lists.infradead.org>; Thu, 30 Jun 2022 00:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220527185600.1236769-1-davidgow@google.com> <20220527185600.1236769-2-davidgow@google.com>
 <de38a6b852d31cbe123d033965dbd9b662d29a76.camel@sipsolutions.net>
In-Reply-To: <de38a6b852d31cbe123d033965dbd9b662d29a76.camel@sipsolutions.net>
From: David Gow <davidgow@google.com>
Date: Thu, 30 Jun 2022 15:53:02 +0800
Message-ID: <CABVgOSkNqTAeJa=Z4pNYO=ati0qVsLe2uGUfn7yO_D2QfAzHyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] UML: add support for KASAN under x86_64
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
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Dmitry Vyukov <dvyukov@google.com>, Brendan Higgins <brendanhiggins@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-um <linux-um@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Latypov <dlatypov@google.com>, Linux Memory Management List <linux-mm@kvack.org>

On Sat, May 28, 2022 at 4:14 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Fri, 2022-05-27 at 11:56 -0700, David Gow wrote:
> >
> > This is v2 of the KASAN/UML port. It should be ready to go.
>
> Nice, thanks a lot! :)
>

Thanks for looking at this: I've finally had the time to go through
this in detail again, and have sent out v3:
https://lore.kernel.org/lkml/20220630074757.2739000-2-davidgow@google.com/

> > It does benefit significantly from the following patches:
> > - Bugfix for memory corruption, needed for KASAN_STACK support:
> > https://lore.kernel.org/lkml/20220523140403.2361040-1-vincent.whitchurch@axis.com/
>
> Btw, oddly enough, I don't seem to actually see this (tried gcc 10.3 and
> 11.3 so far) - is there anything you know about compiler versions
> related to this perhaps? Or clang only?
>
> The kasan_stack_oob test passes though, and generally 45 tests pass and
> 10 are skipped.
>

Given this patch has already been accepted, I dropped this comment
from v3.  As you note, the issue didn't reproduce totally
consistently.

> > +# Kernel config options are not included in USER_CFLAGS, but the
> > option for KASAN
> > +# should be included if the KASAN config option was set.
> > +ifdef CONFIG_KASAN
> > +     USER_CFLAGS+=-DCONFIG_KASAN=y
> > +endif
> >
>
> I'm not sure that's (still?) necessary - you don't #ifdef on it anywhere
> in the user code; perhaps the original intent had been to #ifdef
> kasan_map_memory()?
>

I've got rid of this for v3, thanks.

> > +++ b/arch/um/os-Linux/user_syms.c
> > @@ -27,10 +27,10 @@ EXPORT_SYMBOL(strstr);
> >  #ifndef __x86_64__
> >  extern void *memcpy(void *, const void *, size_t);
> >  EXPORT_SYMBOL(memcpy);
> > -#endif
> > -
> >  EXPORT_SYMBOL(memmove);
> >  EXPORT_SYMBOL(memset);
> > +#endif
> > +
> >  EXPORT_SYMBOL(printf);
> >
> >  /* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
> > diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> > index ba5789c35809..f778e37494ba 100644
> > --- a/arch/x86/um/Makefile
> > +++ b/arch/x86/um/Makefile
> > @@ -28,7 +28,8 @@ else
> >
> >  obj-y += syscalls_64.o vdso/
> >
> > -subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
> > +subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o \
> > +     ../lib/memmove_64.o ../lib/memset_64.o
>
> I wonder if we should make these two changes contingent on KASAN too, I
> seem to remember that we had some patches from Anton flying around at
> some point to use glibc string routines, since they can be even more
> optimised (we're in user space, after all).
>
> But I suppose for now this doesn't really matter, and even if we did use
> them, they'd come from libasan anyway?

I had a quick look into this, and think it's probably best left as-is.
I think it's better to have the same implementation of these
functions, regardless of whether KASAN is enabled. And given that we
need the explicit, separate instrumented and uninstrumented versions,
we'd need some way of having one copy which came from libasan and one
which was totally uninstrumented.

But if the performance difference is really significant, we could
always revisit it.


>
> Anyway, looks good to me, not sure the little not above about the user
> cflags matters.
>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
>

Cheers,
-- David

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

