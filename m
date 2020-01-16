Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1is0S9-00047P-AH
 for linux-um@lists.infradead.org; Thu, 16 Jan 2020 08:24:39 +0000
Received: by mail-qt1-x844.google.com with SMTP id w8so3794246qts.11
 for <linux-um@lists.infradead.org>; Thu, 16 Jan 2020 00:24:32 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
 <dce24e66d89940c8998ccc2916e57877ccc9f6ae.camel@sipsolutions.net>
 <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
In-Reply-To: <CAKFsvU+sUdGC9TXK6vkg5ZM9=f7ePe7+rh29DO+kHDzFXacx2w@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 16 Jan 2020 09:24:20 +0100
Message-ID: <CACT4Y+ZDRtFrm5jfD+a9X=frGM=WKpoeJJZ6MRhZsATbG8aDTA@mail.gmail.com>
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
To: Patricia Alfonso <trishalfonso@google.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, David Gow <davidgow@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Johannes Berg <johannes@sipsolutions.net>, anton.ivanov@cambridgegreys.com

On Wed, Jan 15, 2020 at 11:56 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
> > > +++ b/kernel/Makefile
> > > @@ -32,6 +32,12 @@ KCOV_INSTRUMENT_kcov.o := n
> > >  KASAN_SANITIZE_kcov.o := n
> > >  CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
> > >
> > > +ifdef CONFIG_UML
> > > +# Do not istrument kasan on panic because it can be called before KASAN
> >
> > typo there - 'instrument'
> >
>
> Thanks for catching that!

Hi Patricia,

Very cool indeed! And will be a kunit killer feature!

I can't parse this sentence (even with fixed), what is "kasan on panic"?
Did you want to say "Do not instrument panic because it can be called
before KASAN is initialized"?
Or  "Do not KASAN-instrument panic because it can be called before
KASAN is initialized"? Though, "KASAN-instrument" looks somewhat
redundant in this context.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

