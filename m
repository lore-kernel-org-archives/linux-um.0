Return-Path: <rob@landley.net>
Date: Thu, 22 Aug 2013 15:41:09 -0500
From: Rob Landley <rob@landley.net>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
	<CAMuHMdWk-EPTNmPB1O1+F7YVQLjhQsFJznYwA3t6UCGUU1T9PQ@mail.gmail.com>
	<20130821195157.GA18191@merkur.ravnborg.org>
	<CAMuHMdWqwQxxky7UDnh-oxN13C-sxfnxKVBuBz1GU_RtJvbf3A@mail.gmail.com>
In-Reply-To: <CAMuHMdWqwQxxky7UDnh-oxN13C-sxfnxKVBuBz1GU_RtJvbf3A@mail.gmail.com>
	(from geert@linux-m68k.org on Thu Aug 22 07:58:26 2013)
Message-Id: <1377204069.2737.108@driftwood>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC] Get rid of SUBARCH
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Richard Weinberger <richard@nod.at>, Linux-Arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.cz>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 08/22/2013 07:58:26 AM, Geert Uytterhoeven wrote:
> On Wed, Aug 21, 2013 at 9:51 PM, Sam Ravnborg <sam@ravnborg.org> =20
> wrote:
> >> > The series touches also m68k, sh, mips and unicore32.
> >> > These architectures magically select a cross compiler if ARCH !=3D =20
> SUBARCH.
> >> > Do really need that behavior?
> >>
> >> This does remove functionality.
> >> It allows to build a kernel using e.g. "make ARCH=3Dm68k".
> >>
> >> Perhaps this can be moved to generic code? Most (not all!) =20
> cross-toolchains
> >> are called $ARCH-{unknown-,}linux{,-gnu}.
> >> Exceptions are e.g. am33_2.0-linux and bfin-uclinux.
> >
> > Today you can specify CROSS_COMPILE in Kconfig.
> > With this we should be able to remove these hacks.
>=20
> The correct CROSS_COMPILE value depends on the host environment, not
> on the target configuration.

Actually it depends on _both_.

Rob=

