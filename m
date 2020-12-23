Return-Path: <richard.weinberger@gmail.com>
MIME-Version: 1.0
References: <20201217131556.6d1a5546bd43.I2fcd1dfac11d31e1a83a26488f396d97ba03ddda@changeid>
 <CAK8P3a3=orVNeUNermxzHBynoG4td+W07wfBb=yADBBZg6JndA@mail.gmail.com>
In-Reply-To: <CAK8P3a3=orVNeUNermxzHBynoG4td+W07wfBb=yADBBZg6JndA@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 23 Dec 2020 11:18:51 +0100
Message-ID: <CAFLxGvynJbz=6+Vn2VL7wiobeD=p03SGKieJ3rBSz8sonLzgbw@mail.gmail.com>
Subject: Re: [PATCH] um: return error from ioremap()
Content-Type: text/plain; charset="UTF-8"
To: Arnd Bergmann <arnd@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Logan Gunthorpe <logang@deltatee.com>, linux-um <linux-um@lists.infradead.org>, Johannes Berg <johannes.berg@intel.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <linux-um.lists.infradead.org>

On Thu, Dec 17, 2020 at 3:53 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Thu, Dec 17, 2020 at 1:15 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> >
> > From: Johannes Berg <johannes.berg@intel.com>
> >
> > Back a few years ago, ioremap() was added to UML so that we'd
> > not break the build for everything all the time. However, for
> > some reason, v1 of the patch got applied, rather than the v2
> > that returned NULL, which was discussed here:
> >
> > https://lore.kernel.org/lkml/1495726955-27497-1-git-send-email-logang@deltatee.com/
> >
> > Fix that now.

Thanks, applied.
I think marking this patch for stable is worth it.

> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um



-- 
Thanks,
//richard

