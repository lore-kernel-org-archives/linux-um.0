Return-Path: <PeterHuewe@gmx.de>
From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
Date: Sun, 9 Sep 2012 21:17:20 +0200
References: <201209022245.20413.PeterHuewe@gmx.de> <201209091415.02460.PeterHuewe@gmx.de> <20120909204036.40f2217c@endymion.delvare>
In-Reply-To: <20120909204036.40f2217c@endymion.delvare>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201209092117.20896.PeterHuewe@gmx.de>
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: Jean Delvare <khali@linux-fr.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Jean,
Am Sonntag, 9. September 2012, 20:40:36 schrieb Jean Delvare:
> There is a problem with the mux chip drivers, which then no longer
> depend on HAS_IOMEM.
The selectables on my x86 and UML machine build fine ;)
But you're correct, we should exclude/guard them.

> Also, I think it is about time to admit that
> i2c-stub does not fit under "I2C Hardware Bus support". It is a driver
> for development, not hardware support.
> 
> So I propose the following instead:
> 
>  drivers/i2c/Kconfig        |   14 +++++++++++++-
>  drivers/i2c/busses/Kconfig |   14 +-------------
>  drivers/i2c/muxes/Kconfig  |    2 +-
>  3 files changed, 15 insertions(+), 15 deletions(-)


I'm perfectly fine with this.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>






