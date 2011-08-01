Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 1 Aug 2011 15:25:22 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-ID: <20110801142522.GC19079@n2100.arm.linux.org.uk>
References: <1312042478-26012-1-git-send-email-zdevai@gmail.com> <20110801083614.GC15578@n2100.arm.linux.org.uk> <CAGVye5Nh2E4L3Ox=OKvG09v4hO6BjGmLUGZ5=Ha2QzbXar+deA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <CAGVye5Nh2E4L3Ox=OKvG09v4hO6BjGmLUGZ5=Ha2QzbXar+deA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] Remove remaining references of CONFIG_GENERIC_TIME
To: Zoltan Devai <zdevai@gmail.com>
Cc: linux-kernel@vger.kernel.org, chris@zankel.net, linux-am33-list@redhat.com, trivial@kernel.org, user-mode-linux-devel@lists.sourceforge.net, cmetcalf@tilera.com, linux-arm-kernel@lists.infradead.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Aug 01, 2011 at 01:41:32PM +0200, Zoltan Devai wrote:
> 2011/8/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Sat, Jul 30, 2011 at 06:14:38PM +0200, Zoltan Devai wrote:
> >> Commit 592913ecb87a9e06f98ddb55b298f1a66bf94c6b has killed off any
> >> use of this config option long ago.
> >
> > I don't see the point of this - we were free of GENERIC_TIME on ARM
> > shortly after it was originally killed off. =A0The problem is you c=
an't
> > stop people introducing new uses of this - because it existed once =
and
> > there's nothing which errors out on its presence, people are going =
to
> > continue submitting patches with it in. =A0And it's going to contin=
ue
> > being missed at the review stage.
> >
> > I've a similar problem with folk on ARM including mach/gpio.h as th=
eir
> > sole gpio header file rather than linux/gpio.h - I've been trying f=
or
> > the last 1-2 years to educate people to use linux/ in preference. =A0=
You
> > can't do it, and I'm still just about the only one who picks up on =
that.
> > (SoC maintainers don't care.) =A0They will end up caring when I pus=
h a
> > change during the next merge window though, so I'll eventually stop
> > mach/gpio.h being included. =A0(Instead, it'll be asm/gpio.h).
> >
> > GENERIC_TIME though... I don't think you'll ever stop new uses of i=
t
> > creeping in unless you can arrange for something to error out.
>=20
> Sure, but the patch at least reduces the chances of copy-pasting it,
> and makes it obvious by a simple grep that there's no use of it at al=
l,
> so I still think it's wort merging.

That argument doesn't work - as can be seen from my first paragraph.
The fact that we have new references to it in arch/arm/Kconfig is
proof of that.
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

