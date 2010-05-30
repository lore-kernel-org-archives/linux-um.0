MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20100530150214.GA1565@liondog.tnic>
References: <201005271944.09541.toralf.foerster@gmx.de>
	<AANLkTimYeMO_fc8C5MQedwF646_au4lvEbXkBPmQSxb9@mail.gmail.com>
	<AANLkTimKwxYxM_PExplIDK1WPTQ9e_-CHn5SnIvfjfUg@mail.gmail.com>
	<20100530150214.GA1565@liondog.tnic>
Date: Sun, 30 May 2010 17:18:21 +0200
Message-ID: <AANLkTimo-kuzlyQvraLnYBZKlGQHr23ZiMeWmTaj4Yea@mail.gmail.com>
Subject: Re: current git kernel crashes UML system during boot
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Borislav Petkov <bp@alien8.de>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>, Borislav Petkov <borislav.petkov@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, May 30, 2010 at 17:02, Borislav Petkov <bp@alien8.de> wrote:
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Date: Sun, May 30, 2010 at 01:57:05PM +0200
>
>> On Sun, May 30, 2010 at 13:39, Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
>> > 2010/5/27 Toralf F=C3=B6rster <toralf.foerster@gmx.de>:
>> >> I bisected it to this :
>>
>> > After fixing the missing/superfluous slab inclusion issues, I bisected
>> > it further to
>> >
>> > commit d61931d89be506372d01a90d1755f6d0a9fafe2d
>> > Author: Borislav Petkov <borislav.petkov@amd.com>
>> > Date: =C2=A0 Fri Mar 5 17:34:46 2010 +0100
>> >
>> > =C2=A0 =C2=A0x86: Add optimized popcnt variants
>> >
>> > =C2=A0 =C2=A0Add support for the hardware version of the Hamming weigh=
t function,
>> > =C2=A0 =C2=A0popcnt, present in CPUs which advertize it under CPUID, F=
unction
>> > =C2=A0 =C2=A00x0000_0001_ECX[23]. On CPUs which don't support it, we f=
allback to the
>> > =C2=A0 =C2=A0default lib/hweight.c sw versions.
>> >
>> > =C2=A0 =C2=A0A synthetic benchmark comparing popcnt with __sw_hweight6=
4 showed almost
>> > =C2=A0 =C2=A0a 3x speedup on a F10h machine.
>> >
>> > =C2=A0 =C2=A0Signed-off-by: Borislav Petkov <borislav.petkov@amd.com>
>> > =C2=A0 =C2=A0LKML-Reference: <20100318112015.GC11152@aftab>
>> > =C2=A0 =C2=A0Signed-off-by: H. Peter Anvin <hpa@zytor.com>
>> >
>> > I reverted that commit on top of current mainline (and fixed up the
>> > conflicts), and now
>> > it boots again.
>>
>> I tried adding
>>
>> config ARCH_HWEIGHT_CFLAGS
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 string
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 default "-fcall-saved-ecx -fcall-saved-edx" =
if !64_BIT
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 default "-fcall-saved-rdi -fcall-saved-rsi -=
fcall-saved-rdx
>> -fcall-saved-rcx -fcall-saved-r8 -fcall-saved-r9 -fcall-saved-r10
>> -fcall-saved-r11" if 64_BIT
>>
>> to arch/um/Kconfig.x86. Now it got a bit further, but it still crashes:
>
> Ok, this is a kinda stab in the dark but from what I could decypher
> from the include hell, one possible fix should be if UML didn't include
> <arch/x86/include/asm/arch_hweight.h> but use the software hweight
> version only.
>
> Can you guys check whether the following fixes the issue?

Works, thanks!

BTW, if you want to check yourself:

    make ARCH=3Dum defconfig
    make ACH=3Dum
    ./linux

If it panics because it cannot mount the root file system, it works.

> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.=
h
> index 545776e..c9dad12 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -444,7 +444,11 @@ static inline int fls(int x)
>
> =C2=A0#define ARCH_HAS_FAST_MULTIPLIER 1
>
> +#ifdef CONFIG_UML
> +#include <asm-generic/bitops/arch_hweight.h>
> +#else
> =C2=A0#include <asm/arch_hweight.h>
> +#endif
>
> =C2=A0#include <asm-generic/bitops/const_hweight.h>

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

