MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <201006141544.59500.toralf.foerster@gmx.de>
References: <201005271944.09541.toralf.foerster@gmx.de>
	<201006141149.24647.toralf.foerster@gmx.de>
	<20100614130039.GA4618@kryptos.osrc.amd.com>
	<201006141544.59500.toralf.foerster@gmx.de>
Date: Mon, 14 Jun 2010 16:39:00 +0200
Message-ID: <AANLkTik7aQPVl2OsOIhAtMzRHDNw6jkZYzcRNtfi7QSh@mail.gmail.com>
Subject: Re: [PATCH] x86, hweight: Fix UML boot crash
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: Borislav Petkov <bp@amd64.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2010/6/14 Toralf F=C3=B6rster <toralf.foerster@gmx.de>:
> Borislav Petkov wrote at 15:00:39
>
>> Linus' tree doesn't contain the fix yet - rather it is in -tip:
>> http://git.kernel.org/tip/055c47272b8f5679d08ccc57efea3cb4aaeb5fc6
>>
>> You can easily cherry-pick it from there and retest.
> Issue solved works with that patch.
>
> FWIW : This command sequence produced a linux executable which crashed to=
o:
>
> $> ~/devel/linux-2.6 $ patch -p1 < ../linux-2.6-
> tip.git-055c47272b8f5679d08ccc57efea3cb4aaeb5fc6.patch patching file
> arch/um/include/asm/arch_hweight.h
>
> $> ~/devel/linux-2.6 $ make ARCH=3Dum CC=3D"ccache gcc"
> make[1]: `arch/um/sys-i386/user-offsets.s' is up to date.
> =C2=A0CHK =C2=A0 =C2=A0 include/linux/version.h
> =C2=A0CHK =C2=A0 =C2=A0 include/generated/utsrelease.h
> =C2=A0CALL =C2=A0 =C2=A0scripts/checksyscalls.sh
> =C2=A0CHK =C2=A0 =C2=A0 include/generated/compile.h
> =C2=A0LINK linux
> $> start_uml.sh
> ...
>
> But after I compiled it w/o ccache
>
> $> ~/devel/linux-2.6 $ make ARCH=3Dum
>
> linux executable works (!?!)

I assume you did a `make clean' in between?
So could this just be the problem that new include files early in the
include path are
not detected by the dependency system, as they aren't in any *.d file?

BTW, I'm also using ccache. Always. Ever. All my (cross)compilers are symli=
nks
to ccache ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds

