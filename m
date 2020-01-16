Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1is1My-0005qb-OM
 for linux-um@lists.infradead.org; Thu, 16 Jan 2020 09:23:21 +0000
Received: by mail-qk1-x744.google.com with SMTP id d71so18504877qkc.0
 for <linux-um@lists.infradead.org>; Thu, 16 Jan 2020 01:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
 <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
 <4f382794416c023b6711ed2ca645abe4fb17d6da.camel@sipsolutions.net>
 <b55720804de8e56febf48c7c3c11b578d06a8c9f.camel@sipsolutions.net>
 <CACT4Y+brqD-o-u3Vt=C-PBiS2Wz+wXN3Q3RqBhf3XyRYaRoZJw@mail.gmail.com>
 <2092169e6dd1f8d15f1db4b3787cc9fe596097b7.camel@sipsolutions.net>
In-Reply-To: <2092169e6dd1f8d15f1db4b3787cc9fe596097b7.camel@sipsolutions.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 16 Jan 2020 10:23:04 +0100
Message-ID: <CACT4Y+b6C+y9sDfMYPDy-nh=WTt5+u2kLcWx2LQmHc1A5L7y0A@mail.gmail.com>
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
Cc: Patricia Alfonso <trishalfonso@google.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, anton.ivanov@cambridgegreys.com

On Thu, Jan 16, 2020 at 10:20 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Thu, 2020-01-16 at 10:18 +0100, Dmitry Vyukov wrote:
> >
> > Looking at this problem and at the number of KASAN_SANITIZE := n in
> > Makefiles (some of which are pretty sad, e.g. ignoring string.c,
> > kstrtox.c, vsprintf.c -- that's where the bugs are!), I think we
> > initialize KASAN too late. I think we need to do roughly what we do in
> > user-space asan (because it is user-space asan!). Constructors run
> > before main and it's really good, we need to initialize KASAN from
> > these constructors. Or if that's not enough in all cases, also add own
> > constructor/.preinit array entry to initialize as early as possible.
>
> We even control the linker in this case, so we can put something into
> the .preinit array *first*.

Even better! If we can reliably put something before constructors, we
don't even need lazy init in constructors.

> > All we need to do is to call mmap syscall, there is really no
> > dependencies on anything kernel-related.
>
> OK. I wasn't really familiar with those details.
>
> > This should resolve the problem with constructors (after they
> > initialize KASAN, they can proceed to do anything they need) and it
> > should get rid of most KASAN_SANITIZE (in particular, all of
> > lib/Makefile and kernel/Makefile) and should fix stack instrumentation
> > (in case it does not work now). The only tiny bit we should not
> > instrument is the path from constructor up to mmap call.
>
> That'd be great :)
>
> johannes
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/2092169e6dd1f8d15f1db4b3787cc9fe596097b7.camel%40sipsolutions.net.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

