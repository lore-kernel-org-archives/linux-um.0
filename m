Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2PFv-0004vA-5w
 for linux-um@lists.infradead.org; Fri, 14 Feb 2020 00:54:56 +0000
Received: by mail-wm1-x342.google.com with SMTP id m10so907424wmc.0
 for <linux-um@lists.infradead.org>; Thu, 13 Feb 2020 16:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20200210225806.249297-1-trishalfonso@google.com>
 <13b0ea0caff576e7944e4f9b91560bf46ac9caf0.camel@sipsolutions.net>
 <CAKFsvUKaixKXbUqvVvjzjkty26GS+Ckshg2t7-+erqiN2LVS-g@mail.gmail.com>
 <e8a45358b273f0d62c42f83d99c1b50a1608929d.camel@sipsolutions.net>
In-Reply-To: <e8a45358b273f0d62c42f83d99c1b50a1608929d.camel@sipsolutions.net>
From: Patricia Alfonso <trishalfonso@google.com>
Date: Thu, 13 Feb 2020 16:54:41 -0800
Message-ID: <CAKFsvULfrFC_t4CJN5evwu3EnbzbVF1UGs30uHc1Jad-Sd=s9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2] UML: add support for KASAN under x86_64
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

> Well I had two patches:
>  (1) the module constructors one - I guess we need to test it, but you
>      can include it here if you like. I'm kinda swamped with other
>      things right now, no promises I can actually test it soon, though I
>      really do want to because that's the case I need :)
>  (2) the [DEMO] patch - you should just take the few lines you need from
>      that (in the linker script) and stick it into this patch. Don't
>      even credit me for that, I only wrote it as a patch instead of a
>      normal text email reply because I couldn't figure out how to word
>      things in an understandable way...
>
> Then we end up with 2 patches again, the (1) and your KASAN one. There's
> no point in keeping the [DEMO] separate, and
>
Okay, so I'll rebase onto (1) and just add the lines I need from the
[DEMO]. Are you sure you don't want to be named as a co-developed-by
at least?

>
> > > > +     if (mmap(start,
> > > > +              len,
> > > > +              PROT_READ|PROT_WRITE,
> > > > +              MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE,
> > > > +              -1,
> > > > +              0) == MAP_FAILED)
> > > > +             os_info("Couldn't allocate shadow memory %s", strerror(errno));
> > >
> > > If that fails, can we even continue?
> > >
> > Probably not, but with this executing before main(), what is the best
> > way to have an error occur? Or maybe there's a way we can just
> > continue without KASAN enabled and print to the console that KASAN
> > failed to initialize?
>
> You can always "exit(17)" or something.
>
> I'm not sure you can continue without KASAN?
>
> Arguably it's better to fail loudly anyway if something as simple as the
> mmap() here fails - after all, that probably means the KASAN offset in
> Kconfig needs to be adjusted?
>
> johannes
>
Yeah, failing loudly does seem to be the best option here.

-- 
Patricia Alfonso

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

