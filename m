MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <201209090308.08766.PeterHuewe@gmx.de>
References: <201209022245.20413.PeterHuewe@gmx.de>
	<5044A81B.4080209@nod.at>
	<201209090308.08766.PeterHuewe@gmx.de>
Date: Sun, 9 Sep 2012 10:13:42 +0200
Message-ID: <CAMuHMdVOwx9hmRQzFj02uL0xuCca76QzfJWH9rOBj4is7gcFpQ@mail.gmail.com>
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Peter_H=C3=BCwe?= <PeterHuewe@gmx.de>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, Jean Delvare <khali@linux-fr.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Peter,

On Sun, Sep 9, 2012 at 3:08 AM, Peter H=C3=BCwe <PeterHuewe@gmx.de> wrote:
>> > I'm curious if there have ever been any attempts to emulate i2c device=
s
>> > under uml in order to facilitate driver development by using stub
>> > drivers.
>> I know none.
>
>> If there is a use case, why not. :-)
> Thanks for your encouraging words ;)
>
> I had a look around and found the nice CONFIG_I2C_STUB driver,
> which is described in detail at
> http://www.kernel.org/doc/Documentation/i2c/i2c-stub
>
> """This module is a very simple fake I2C/SMBus driver.  It implements fiv=
e
> types of SMBus commands: write quick, (r/w) byte, (r/w) byte data, (r/w)
> word data, and (r/w) I2C block data."""
> which more or less exactly fits my need.
>
> The only thing that was missing was general support for I2C which is depe=
ndent
> on CONFIG_HAS_IOMEM which unfortunately isn't available on UML,
> but I simply added a || UML to the Kconfig and was now able to build the =
I2C
> Support, the i2c-dev module (for userspace access) and the i2c-stub drive=
r.

Yes, that's what you typically have to do to get such a thing working.

JFYI, on several occasions, I worked on Amiga Zorro bus probing under UML, =
using
fake Zorro devices and real but stubbed network and frame buffer drivers.

> If I  know load the i2c_stub module I have a emulated i2c device ;)
>
> I adapted the stub driver to my needs and was now able to create my own
> emulated i2c device and start with driver and tools development for it ;)
>
>
> I added the patch, in case you're interested.
>
> Unfortunately some I2C drivers fail to build if CONFIG_HAS_IOMEM =3D n, b=
ut
> don't have that dependency in Kconfig - I simply added it to prevent them=
 from
> inclusion.

That's because they rely on the HAS_IOMEM dependency for the whole subsyste=
m.
In fact, I'm surprised you didn't have to add HAS_IOMEM dependencies
to more drivers.

> Do you think I should try to push this mainline via the i2c subsystem?

As long as there are no "real" i2c drivers for UML, but only
dummy/development ones,
that is up to the i2c maintainer (in CC).

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

