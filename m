Return-Path: <PeterHuewe@gmx.de>
From: Peter =?iso-8859-15?q?H=FCwe?= <PeterHuewe@gmx.de>
Date: Sun, 9 Sep 2012 15:11:32 +0200
References: <201209022245.20413.PeterHuewe@gmx.de> <201209091452.19700.PeterHuewe@gmx.de> <504C9227.1020700@nod.at>
In-Reply-To: <504C9227.1020700@nod.at>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201209091511.32970.PeterHuewe@gmx.de>
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: Richard Weinberger <richard@nod.at>
Cc: Jean Delvare <khali@linux-fr.org>, Geert Uytterhoeven <geert@linux-m68k.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

> >> Maybe some parts of the I2C sub-system can also just depend on
> >> GENERIC_IO instead of HAS_IOMEM.
> >> An arch has GENERIC_IO=y if it supports everything defined in
> >> generic-asm/io.h which is more than enough for most stub drivers.
> > 
> > The only thing which seems to be missing on UML is the ioremap function
> > family ;/
> 
> Why do you need ioremap() in a stub driver?
> This sounds strange.


This was a misunderstanding - the main part of the I2C subsystem doesn't 
depend at all on HAS_IOMEM, only the main part of the i2c/busses section.
And almost all of those drivers use ioremap.

For my stub driver I don't need any of that, I'd be fine with the move of 
HAS_IOMEM as proposed by Jean.


Peter

