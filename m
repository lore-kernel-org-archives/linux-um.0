Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1irras-0007gM-Hr
 for linux-um@lists.infradead.org; Wed, 15 Jan 2020 22:56:59 +0000
Received: by mail-wm1-x342.google.com with SMTP id w5so5817732wmi.1
 for <linux-um@lists.infradead.org>; Wed, 15 Jan 2020 14:56:52 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
In-Reply-To: <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
From: Patricia Alfonso <trishalfonso@google.com>
Date: Wed, 15 Jan 2020 14:56:39 -0800
Message-ID: <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
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
Cc: richard@nod.at, jdike@addtoit.com, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, aryabinin@virtuozzo.com, dvyukov@google.com, anton.ivanov@cambridgegreys.com

On Wed, Jan 15, 2020 at 10:48 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
> Couple questions, if you don't mind.
>
> > +#ifdef CONFIG_X86_64
> > +#define KASAN_SHADOW_SIZE 0x100000000000UL
> > +#else
> > +#error "KASAN_SHADOW_SIZE is not defined in this sub-architecture"
> > +#endif
>
> Is it even possible today to compile ARCH=um on anything but x86_64? If
> yes, perhaps the above should be
>
>         select HAVE_ARCH_KASAN if X86_64
>
> or so? I assume KASAN itself has some dependencies though, but perhaps
> ARM 64-bit or POWERPC 64-bit could possibly run into this, if not X86
> 32-bit.
>

This seems like a good idea. I'll keep the #ifdef around
KASAN_SHADOW_SIZE, but add "select HAVE_ARCH_KASAN if X86_64" as well.
This will make extending it later easier.

> > +++ b/arch/um/kernel/skas/Makefile
> > @@ -5,6 +5,12 @@
> >
> >  obj-y := clone.o mmu.o process.o syscall.o uaccess.o
> >
> > +ifdef CONFIG_UML
> > +# Do not instrument until after start_uml() because KASAN is not
> > +# initialized yet
> > +KASAN_SANITIZE       := n
> > +endif
>
> Not sure I understand this, can anything in this file even get compiled
> without CONFIG_UML?
>

You are correct; this #ifdef was unnecessary. I will remove it. Thanks!

> > +++ b/kernel/Makefile
> > @@ -32,6 +32,12 @@ KCOV_INSTRUMENT_kcov.o := n
> >  KASAN_SANITIZE_kcov.o := n
> >  CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> >
> > +ifdef CONFIG_UML
> > +# Do not istrument kasan on panic because it can be called before KASAN
>
> typo there - 'instrument'
>

Thanks for catching that!

> > +++ b/lib/Makefile
> > @@ -17,6 +17,16 @@ KCOV_INSTRUMENT_list_debug.o := n
> >  KCOV_INSTRUMENT_debugobjects.o := n
> >  KCOV_INSTRUMENT_dynamic_debug.o := n
> >
> > +# Don't sanatize
>
> typo
>

Thanks for catching this, too!

> Very cool, I look forward to trying this out! :-)
>
> Thanks,
> johannes
>

Thank you so much for the comments!

Best,
Patricia


--

Patricia Alfonso
Software Engineer
trishalfonso@google.com

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

