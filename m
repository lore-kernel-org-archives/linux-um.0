Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZLyn-0007Mo-GE
 for linux-um@lists.infradead.org; Mon, 25 Nov 2019 21:33:10 +0000
Received: by mail-wm1-x344.google.com with SMTP id f129so954209wmf.2
 for <linux-um@lists.infradead.org>; Mon, 25 Nov 2019 13:33:08 -0800 (PST)
MIME-Version: 1.0
References: <20191016141312.15684-1-anton.ivanov@cambridgegreys.com>
 <202276c5253b7a510f513925c201edf180e1886b.camel@debian.org>
In-Reply-To: <202276c5253b7a510f513925c201edf180e1886b.camel@debian.org>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 25 Nov 2019 22:32:55 +0100
Message-ID: <CAFLxGvy3ssM2xmp1W3-jdVwOw+oozP0eO9H-X5vcsdLg+ODGsA@mail.gmail.com>
Subject: Re: [PATCH] um: Add back support for extra userspace libraries
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
To: Ritesh Raj Sarraf <rrs@debian.org>
Cc: 938962@bugs.debian.org, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Thu, Oct 17, 2019 at 1:32 PM Ritesh Raj Sarraf <rrs@debian.org> wrote:
>
> Hello Anton,
>
> Thank you so much for working on this fix. I tested this patch and it
> works. Some comments below though.
>
> On Wed, 2019-10-16 at 15:13 +0100, Anton Ivanov wrote:
> > PCAP and VDE network transports require linking with userspace
> > libraries. The current build system has no means of passing these
> > as arguments.
> >
> > This patch adds a script to expand the library list for linking
> > for these transports as well as any future driver that needs to
> > rely on additional libraries on the userspace side.
> >
> > Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > ---
> >  arch/um/scripts/extra-libs.sh | 10 ++++++++++
> >  scripts/link-vmlinux.sh       |  4 +++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/um/scripts/extra-libs.sh
> >
> > diff --git a/arch/um/scripts/extra-libs.sh b/arch/um/scripts/extra-
> > libs.sh
> > new file mode 100644
> > index 000000000000..0592485e0675
> > --- /dev/null
> > +++ b/arch/um/scripts/extra-libs.sh
> > @@ -0,0 +1,10 @@
> > +#!/bin/sh
> > +
> > +# This file should be included from link-vmlinux, not executed!!!
> > +
> > +if [ "${CONFIG_UML_NET_VDE}" = "y" ] ; then
> > +     UML_EXTRA_LIBS="$UML_EXTRA_LIBS -lvde -lvdeplug"
> > +fi
> > +if [ "${CONFIG_UML_NET_PCAP}" = "y" ] ; then
> > +     UML_EXTRA_LIBS="$UML_EXTRA_LIBS -lpcap"
> > +fi
>
> -lvde is not understood. I added the build dependency to libvde-dev on
> Debian but that still did not help.
>
> So instead I dropped it to get the build going. And my tests about
> networking look fine.
>
> The revised patch that I'm using is attached with this email.
>
>
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index 06495379fcd8..15f9e5096da0 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -90,11 +90,13 @@ vmlinux_link()
> >                       -Wl,--end-group                         \
> >                       ${@}"
> >
> > +             . arch/um/scripts/extra-libs.sh
> > +
> >               ${CC} ${CFLAGS_vmlinux}                         \
> >                       -o ${output}                            \
> >                       -Wl,-T,${lds}                           \
> >                       ${objects}                              \
> > -                     -lutil -lrt -lpthread
> > +                     -lutil -lrt -lpthread ${UML_EXTRA_LIBS}
> >               rm -f linux
> >       fi
> >  }

I fear without an ACK from kbuild folks I'm unable to monkey this patch.
No need to worry, this one can be merged after -rc1.

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

