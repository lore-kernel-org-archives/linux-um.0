MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <201209091415.02460.PeterHuewe@gmx.de>
References: <201209022245.20413.PeterHuewe@gmx.de>
	<201209091249.04279.PeterHuewe@gmx.de>
	<20120909132838.51b6c434@endymion.delvare>
	<201209091415.02460.PeterHuewe@gmx.de>
Date: Sun, 9 Sep 2012 14:21:22 +0200
Message-ID: <CAMuHMdVMq=9dbM+L3EtDcSg9im2qwWaGHj+xhzJrmvxsHoNnBQ@mail.gmail.com>
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Peter_H=C3=BCwe?= <PeterHuewe@gmx.de>
Cc: Jean Delvare <khali@linux-fr.org>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Sep 9, 2012 at 2:15 PM, Peter H=C3=BCwe <PeterHuewe@gmx.de> wrote:
>> My bet is that all I2C bus drivers do use I/O or memory mapped
>> operations directly or indirectly, except i2c-stub. So it would
>> probably make more sense, and be a less intrusive change, to move the
>> HAS_IOMEM dependency to drivers/i2c/busses, and move (logically or for
>> real) i2c-stub out of it.
>>
>> Or are there really other I2C bus drivers which make sense to enable
>> under UML?
> The only other available in UML which doesn't rely on HAS_IOMEM is the
> PARPORT_LIGHT which relies on direct io access - so I guess this one does=
n't
> make sense either.
>
> I created a patch for your proposed solution, I moved the stub driver to =
the
> end in order to have only one big if HAS_IOMEM.

I was just going to comment that adding "&& HAS_IOMEM" doesn't make much
sense for e.g. "depends on PPC", as we know PPC always has HAS_IOMEM.
Only s390, PCI-less tile, and UML don't have HAS_IOMEM.

Doing it in the submenu is indeed better.

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

