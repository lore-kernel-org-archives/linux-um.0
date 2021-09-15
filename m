Return-Path: <johannes@sipsolutions.net>
Message-ID: <0a1b7c85c1bc022d22a7cddc4991b5c9c3326117.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/3] um: virt-pci: fix 32-bit compile
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 15 Sep 2021 21:06:51 +0200
In-Reply-To: <CAMuHMdVykBS3CU7OaxuUxiW=UGL06AX+OO91ntZ8SPj=882qSw@mail.gmail.com>
References: 
	<20210915203021.1454bd968b28.I160cb938058758bba3cb1968419314dbeb9dc004@changeid>
	 <CAMuHMdVykBS3CU7OaxuUxiW=UGL06AX+OO91ntZ8SPj=882qSw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-um <linux-um@lists.infradead.org>, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <linux-um.lists.infradead.org>

On Wed, 2021-09-15 at 20:42 +0200, Geert Uytterhoeven wrote:
> 
> > -       unsigned long ret = ~0ULL;
> > +       unsigned long ret = ULONG_MAX;
> 
> Why not just drop the last "L"? ;-)
> 
> > 
> >         if (!dev)
> > -               return ~0ULL;
> > +               return ULONG_MAX;
> 
> The first change is not needed.

True, but it seemed inconsistent without that.


> > -       memset(data, 0xff, sizeof(data));
> > +       memset(buf->data, 0xff, sizeof(buf->data));

> The second change is a genuine bug fix, also on 64-bit, which should be
> submitted separately, and backported to stable.

It's kind of a bug, I agree. However:

On 64-bit platforms, the pointer size is 8 bytes, and thus all the data
is memset to 0xff as needed.

On 32-bit platforms, we cannot do 64-bit reads (there's no ioread64 on
32-bit), and thus we can only ever need four 0xff bytes (for a failing
32-bit read), matching the pointer size, so it ends up being correct as
well.

johannes


