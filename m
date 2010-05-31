Return-Path: <Borislav.Petkov@amd.com>
Date: Mon, 31 May 2010 16:10:58 +0200
From: Borislav Petkov <borislav.petkov@amd.com>
Subject: Re: [PATCH] x86, hweight: Fix UML boot crash
Message-ID: <20100531141058.GB4915@aftab>
References: <201005271944.09541.toralf.foerster@gmx.de>
 <20100530193956.GA2498@liondog.tnic>
 <20100530201738.GB2498@liondog.tnic>
 <201005311555.56791.toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <201005311555.56791.toralf.foerster@gmx.de>
Content-Transfer-Encoding: quoted-printable
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Toralf F=F6rster <toralf.foerster@gmx.de>
Date: Mon, May 31, 2010 at 09:55:53AM -0400

> Borislav Petkov wrote at 22:17:38
> > LKML-Reference: <201005271944.09541.toralf.foerster@gmx.de>
> > Signed-off-by: Borislav Petkov <bp@alien8.de>
> > ---
> >  arch/um/include/asm/arch_hweight.h |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/um/include/asm/arch_hweight.h
> >=20
> > diff --git a/arch/um/include/asm/arch_hweight.h b/arch/um/include/asm=
/arch_hweight.h
> > new file mode 100644
> > index 0000000..c656cf4
> > --- /dev/null
> > +++ b/arch/um/include/asm/arch_hweight.h
> > @@ -0,0 +1,6 @@
> > +#ifndef _ASM_UM_HWEIGHT_H
> > +#define _ASM_UM_HWEIGHT_H
> > +
> > +#include <asm-generic/bitops/arch_hweight.h>
> > +
> > +#endif
> >=20
> This patch does not to solve the reported issue by me.

Did you do 'make mrproper' before rebuilding UML with it?

Also, can you do

grep -EriIn 'x86.*hweight\.h' arch/um/

after having applied the patch?

You shouldn't be getting any matches. If it still fails then, then it is
something else since with this patch, UML includes the standard hweight*
routines.

--=20
Regards/Gruss,
Boris.

Operating Systems Research Center
Advanced Micro Devices, Inc.


