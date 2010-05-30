Return-Path: <bp@alien8.de>
Date: Sun, 30 May 2010 22:17:38 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86, hweight: Fix UML boot crash
Message-ID: <20100530201738.GB2498@liondog.tnic>
References: <201005271944.09541.toralf.foerster@gmx.de>
 <AANLkTimKwxYxM_PExplIDK1WPTQ9e_-CHn5SnIvfjfUg@mail.gmail.com>
 <20100530150214.GA1565@liondog.tnic>
 <201005301728.25976.toralf.foerster@gmx.de>
 <20100530170346.GC1565@liondog.tnic>
 <4C02B020.2040103@zytor.com>
 <20100530193956.GA2498@liondog.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20100530193956.GA2498@liondog.tnic>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Borislav Petkov <borislav.petkov@amd.com>, Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

> > This bothers me, because it really feels like something is fundamentally
> > broken in UML tryingto track the upstream architecture, and this is just
> > a bandage.
>=20
> First of all, scratch that patch. It is indeed dumb idea to sprinkle UML
> special cases in x86 just because they include it.
>=20
> Which begs the question why _is_ UML sucking in x86 stuff and can anyone
> provide us with some sensible reasons? Because if there aren't any, it
> is their includes that should be fixed. Let me see what I can do to
> redirect hweight stuff properly...

Ok, AFAICT UML is sucking in the includes of the sub-architecture the
UML "guest" is running on. See below=C2=B9 for the whole gcc string make
executes. Among the switches is

"-I/home/boris/kernel/linux-2.6/arch/x86/include"

so there will be no untangling today. Instead, we could do another
bandaid which is confined to UML include space only and redirect
arch_hweight.h includes to the generic ones. Check this out, it seems to
work here:

--
=46rom: Borislav Petkov <bp@alien8.de>
Date: Sun, 30 May 2010 22:11:32 +0200
Subject: [PATCH] um, hweight: Fix UML boot crash

Obviously UML cannot stomach callee reg-saving trickery
introduced with d61931d89be506372d01a90d1755f6d0a9fafe2d
(x86: Add optimized popcnt variants) and oopses during boot:
http://marc.info/?l=3Dlinux-kernel&m=3D127522065202435&w=3D2

Redirect arch_hweight.h include from the x86 portion to the generic
arch_hweight.h which is a fallback to the software hweight routines.

LKML-Reference: <201005271944.09541.toralf.foerster@gmx.de>
Signed-off-by: Borislav Petkov <bp@alien8.de>
---
 arch/um/include/asm/arch_hweight.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)
 create mode 100644 arch/um/include/asm/arch_hweight.h

diff --git a/arch/um/include/asm/arch_hweight.h b/arch/um/include/asm/arch_=
hweight.h
new file mode 100644
index 0000000..c656cf4
--- /dev/null
+++ b/arch/um/include/asm/arch_hweight.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_UM_HWEIGHT_H
+#define _ASM_UM_HWEIGHT_H
+
+#include <asm-generic/bitops/arch_hweight.h>
+
+#endif
--=20
1.7.1









=C2=B9 gcc -Wp,-MD,arch/um/sys-x86_64/.delay.o.d  -nostdinc -isystem /usr/l=
ib/gcc/x86_64-linux-gnu/4.4.4/include -I/home/boris/kernel/linux-2.6/arch/u=
m/include -Iinclude  -include include/generated/autoconf.h -D__KERNEL__ -I/=
home/boris/kernel/linux-2.6/arch/um/sys-x86_64 -m64 -I/home/boris/kernel/li=
nux-2.6/arch/x86/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -=
fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-=
format-security -fno-delete-null-pointer-checks -Os -D__arch_um__ -DSUBARCH=
=3D\"x86_64\" -I/home/boris/kernel/linux-2.6/arch/um/include/shared -I/home=
/boris/kernel/linux-2.6/arch/um/sys-x86_64/shared -I/home/boris/kernel/linu=
x-2.6/arch/um/include/shared/skas -Dvmap=3Dkernel_vmap -Din6addr_loopback=
=3Dkernel_in6addr_loopback -Din6addr_any=3Dkernel_in6addr_any -fno-builtin =
-m64 -funit-at-a-time -D_LARGEFILE64_SOURCE -Derrno=3Dkernel_errno -Dsigpro=
cmask=3Dkernel_sigprocmask -Dmktime=3Dkernel_mktime -Wframe-larger-than=3D2=
048 -fno-stack-protector -fno-omit-frame-pointer -fno-optimize-sibling-call=
s -g -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -=
fno-dwarf2-cfi-asm -fconserve-stack   -D"KBUILD_STR(s)=3D\#s" -D"KBUILD_BAS=
ENAME=3DKBUILD_STR(delay)"  -D"KBUILD_MODNAME=3DKBUILD_STR(delay)"  -c -o a=
rch/um/sys-x86_64/delay.o arch/um/sys-x86_64/delay.c


--=20
Regards/Gruss,
    Boris.

