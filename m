Return-Path: <rob@landley.net>
Date: Wed, 21 Aug 2013 12:25:11 -0500
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAMuHMdWk-EPTNmPB1O1+F7YVQLjhQsFJznYwA3t6UCGUU1T9PQ@mail.gmail.com>
	(from geert@linux-m68k.org on Wed Aug 21 07:07:33 2013)
Message-Id: <1377105911.2737.94@driftwood>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC] Get rid of SUBARCH
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, Linux-Arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.cz>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Jeff Dike <jdike@addtoit.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Linux-sh list <linux-sh@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 08/21/2013 07:07:33 AM, Geert Uytterhoeven wrote:
> On Wed, Aug 21, 2013 at 10:19 AM, Richard Weinberger <richard@nod.at> =20
> wrote:
> > This series is an attempt to remove the SUBARCH make parameter.
> > It as introduced at the times of Linux 2.5 for UML to tell the UML
> > build system what the real architecture is.
> >
> > But we actually don't need SUBARCH, we can store this information
> > in the .config file.
>=20
> Haha, now you have OS_ARCH (shouldn't that be called HOST_ARCH?) =20
> instead,
> which is available only for UM?
>=20
> > The series touches also m68k, sh, mips and unicore32.
> > These architectures magically select a cross compiler if ARCH !=3D =20
> SUBARCH.
> > Do really need that behavior?
>=20
> This does remove functionality.
> It allows to build a kernel using e.g. "make ARCH=3Dm68k".

   make ARCH=3Dm68k CROSS_COMPILE=3Dm68k-
   make ARCH=3Darm CROSS_COMPILE=3Darmv5l-
   make ARCH=3Dsparc CROSS_COMPILE=3Dsparc-
   make ARCH=3Dppc CROSS_COMPILE=3Dpowerpc-
   make ARCH=3Dsh CROSS_COMPILE=3Dsh4-
   make ARCH=3Dmips CROSS_COMPILE=3Dmipsel-
   make ARCH=3Dx86 CROSS_COMPILE=3Di686-
   make ARCH=3Dalpha CROSS_COMPILE=3Dalpha-

Works the same way on all the targets I've tried so far. You specify =20
the architecture, you specify the cross compiler prefix, you feed it a =20
config file, you build.

(If a target supplies its own default cross compiler prefix I just have =20
to override it with what mine's called anyway...)

> Perhaps this can be moved to generic code? Most (not all!) =20
> cross-toolchains
> are called $ARCH-{unknown-,}linux{,-gnu}.
> Exceptions are e.g. am33_2.0-linux and bfin-uclinux.

The linaro toolchain is arm-linux-gnueabihf- and the one on kernel.org =20
is arm-unknown-linux-gnueabi- and the one I build is armv5l- (because =20
the FSF's =20
$ARCH-unknown-gnu-format-tuple-all-hail-stallman-gnu-gnu-gnu-dammit-gcc =20
is just nuts: why would I say -linux- in a linux-to-linux toolchain? Do =20
windows toolchains say -windows-?)

Other toolchain sources use other prefixes (-unknown- is often =20
-$VENDORNAME-), and then of course there's llvm... which is why you =20
specify CROSS_COMPILE=3D on the make command line.

Rob=

