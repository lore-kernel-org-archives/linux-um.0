MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20100612163444.GC28572@liondog.tnic>
References: <20100530150214.GA1565@liondog.tnic>
	<201005301728.25976.toralf.foerster@gmx.de>
	<20100530170346.GC1565@liondog.tnic>
	<4C02B020.2040103@zytor.com>
	<20100530193956.GA2498@liondog.tnic>
	<20100530201738.GB2498@liondog.tnic>
	<4C02D408.1030306@zytor.com>
	<AANLkTimPSQ3K6ulqGV243w__IbMaJTG71VckB8gl701u@mail.gmail.com>
	<20100612141837.GA28572@liondog.tnic>
	<AANLkTimcocYzWrP_5Dv3PxwxMZMq-AtDLfDkYpayuPzG@mail.gmail.com>
	<20100612163444.GC28572@liondog.tnic>
Date: Sat, 12 Jun 2010 20:37:39 +0200
Message-ID: <AANLkTinMHWI0xGRW-clKm5O91c0QdMG5tDNf3jvUB8Ij@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] x86, hweight: Fix UML boot crash
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Borislav Petkov <bp@alien8.de>, Paolo Giarrusso <p.giarrusso@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Borislav Petkov <borislav.petkov@amd.com>, =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, Jun 12, 2010 at 18:34, Borislav Petkov <bp@alien8.de> wrote:
> From: Paolo Giarrusso <p.giarrusso@gmail.com>
> Date: Sat, Jun 12, 2010 at 06:01:44PM +0200
>
>> >> First, ARCH_HWEIGHT_CFLAGS should IMHO be shared with UML. I.e., moved
>> >> to arch/x86/Kconfig.cpu (which was born as Kconfig code shared with
>> >> UML), or copied in UML (it's not defined, as far as I can see).
>> >> Otherwise it just can't work. And I think that's it.
>>
>> Just to be sure: by "that's it" I meant "this is the problem".
>> You didn't answer here - did you see it? What do you think? Can you
>> try the one-line fix at some point?
>> Just to make it clear: I've not been actively developing UML (or
>> almost anything in kernel space) for ages (~4 years), so it's unlikely
>> that I'll try fixing this. It just happens that things on the UML
>> front stayed mostly the same, so I thought that my knowledge of the
>> code is still useful.
>
> Cool :). However, according to Geert, this doesn't fix it:
>
> http://marc.info/?l=linux-kernel&m=127522065202435&w=2
>
> It could be related to the -mregparm being broken on 32-bit UML since
> Geert's UML "guest" is 32-bit. However, even if we fix this, it won't

No, guest and host are both x86_64.

> be used since, as you said, UML doesn't do alternatives. Which means
> that it doesn't make sense fixing it until there are no alternatives -
> instead, we should simply fall back to the software hweight* stuff and
> be done with it.
>
>> > In that case, fixing this is either by rerouting the includes
>> > (easiest, already in -tip) or adding alternatives support (harder,
>> > needs volunteers :)).
>>
>> Well, even doing just nothing should work, if you fix the trivial
>> thing above (which at least for 64bit should work).
>
> See above.
>
>> >> A third note is that UML links with glibc, so it can have a different
>> >> calling convention from the kernel. Say, on x86 32bit regparm doesn't
>> >> work (in fact, -mregparm is set in arch/x86/Makefile and not in
>> >> arch/x86/Makefile_32.cpu). And since popcnt is supported on 32bit, it
>> >> might in theory make a difference for that case. But maybe those flags
>> >> are simply fine, I didn't recheck the possible calling conventions.
>>
>> > If this is also the case, the -fcall-saved-* stuff won't work on UML and
>> > yet another way of doing "call *func" from within asm("...") and making
>> > sure the callee doesn't clobber caller's regs will be needed for UML.
>>
>> Hmpf... anyway, 64bit should be fine since there's just one calling
>> convention, everywhere, and already regparm'ed.
>
> Right, as I said, this would leave 32-bit broken which doesn't cut it
> either for a subset of people using UML.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

