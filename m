Return-Path: <richard.weinberger@gmail.com>
MIME-Version: 1.0
References: <20191210212108.222514-1-brendanhiggins@google.com> <CAMuHMdVyjjZAoO3Q-Vr88fUGFwrn4EoiSxBmG_FV+o87BuBmwQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVyjjZAoO3Q-Vr88fUGFwrn4EoiSxBmG_FV+o87BuBmwQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 19 Jan 2020 22:40:11 +0100
Message-ID: <CAFLxGvzMf1Fni4va1EM1ta_o7zDjkM8iAr=j+t74+G79wq=XOA@mail.gmail.com>
Subject: Re: [PATCH v1] uml: make CONFIG_STATIC_LINK actually static
Content-Type: text/plain; charset="UTF-8"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Brendan Higgins <brendanhiggins@google.com>, Johannes Berg <johannes.berg@intel.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davidgow@google.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>
List-ID: <linux-um.lists.infradead.org>

On Wed, Dec 11, 2019 at 9:40 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Brendan,
>
> On Tue, Dec 10, 2019 at 10:21 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> > Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
> > be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
> > UML_NET_PCAP; this is because glibc tries to load NSS which does not
> > support being statically linked. So make CONFIG_STATIC_LINK depend on
> > !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.
> >
> > Link: https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com/#t
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  arch/um/Kconfig | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> > index 2a6d04fcb3e91..1ddc8745123f2 100644
> > --- a/arch/um/Kconfig
> > +++ b/arch/um/Kconfig
> > @@ -63,6 +63,7 @@ source "arch/$(HEADER_ARCH)/um/Kconfig"
> >
> >  config STATIC_LINK
> >         bool "Force a static link"
> > +       depends on !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP
>
> "depends on !FORBID_STATIC_LINK"?
>
> Then all the drivers that are incompatible with static linking can just
> select FORBID_STATIC_LINK in their own Kconfig block.

Makes sense!

-- 
Thanks,
//richard

