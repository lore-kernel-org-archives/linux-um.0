Return-Path: <ukl@pengutronix.de>
Date: Mon, 1 Aug 2011 16:36:36 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Message-ID: <20110801143636.GE9250@pengutronix.de>
References: <1312042478-26012-1-git-send-email-zdevai@gmail.com>
 <20110801083614.GC15578@n2100.arm.linux.org.uk>
 <CAMuHMdUpTDSRP_JmWqcCBtYwzna0hwmaBshpiF8kgvqoNcqYZA@mail.gmail.com>
 <20110801101410.GE15578@n2100.arm.linux.org.uk>
 <CAMuHMdUiLjMVwOqKPF6tHLpPxROrx=rRf3ednfTLrwGuZ2VF7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdUiLjMVwOqKPF6tHLpPxROrx=rRf3ednfTLrwGuZ2VF7A@mail.gmail.com>
Subject: Re: [PATCH] Remove remaining references of CONFIG_GENERIC_TIME
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, chris@zankel.net, linux-am33-list@redhat.com, trivial@kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-kbuild <linux-kbuild@vger.kernel.org>, linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-arm-kernel@lists.infradead.org, Zoltan Devai <zdevai@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Aug 01, 2011 at 01:27:52PM +0200, Geert Uytterhoeven wrote:
> On Mon, Aug 1, 2011 at 12:14, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Aug 01, 2011 at 12:09:02PM +0200, Geert Uytterhoeven wrote:
> >> Doesn't kconf error out when trying to select a non-existent symbol?
> >
> > Nope.
>=20
> You're right. So that's a bug.
Not sure, this might have been done on purpose to make cross-tree series
easier!?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=EF=BF=BDnig      =
      |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

