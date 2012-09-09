Return-Path: <khali@linux-fr.org>
Date: Sun, 9 Sep 2012 13:28:38 +0200
From: Jean Delvare <khali@linux-fr.org>
Message-ID: <20120909132838.51b6c434@endymion.delvare>
In-Reply-To: <201209091249.04279.PeterHuewe@gmx.de>
References: <201209022245.20413.PeterHuewe@gmx.de>
	<201209090308.08766.PeterHuewe@gmx.de>
	<CAMuHMdVOwx9hmRQzFj02uL0xuCca76QzfJWH9rOBj4is7gcFpQ@mail.gmail.com>
	<201209091249.04279.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: Peter =?ISO-8859-1?B?SPx3ZQ==?= <PeterHuewe@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi all,

Thanks for the info. I thought UML was no longer used with all the
virtualization solutions available, but apparently I was wrong.

On Sun, 9 Sep 2012 12:49:03 +0200, Peter H=FCwe wrote:
> > That's because they rely on the HAS_IOMEM dependency for the whole
> > subsystem. In fact, I'm surprised you didn't have to add HAS_IOMEM
> > dependencies to more drivers.
> I changed only the ones which are available in UML.
> I now rewrote the patch to remove the global dependency and move it to al=
l the=20
> drivers that really rely on HAS_IOMEM - see below.

My bet is that all I2C bus drivers do use I/O or memory mapped
operations directly or indirectly, except i2c-stub. So it would
probably make more sense, and be a less intrusive change, to move the
HAS_IOMEM dependency to drivers/i2c/busses, and move (logically or for
real) i2c-stub out of it.

Or are there really other I2C bus drivers which make sense to enable
under UML?

Are there other subsystems where the HAS_IOMEM dependency is at the
individual driver level?

--=20
Jean Delvare

