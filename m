Return-Path: <PeterHuewe@gmx.de>
From: Peter =?iso-8859-15?q?H=FCwe?= <PeterHuewe@gmx.de>
Date: Sun, 9 Sep 2012 14:52:19 +0200
References: <201209022245.20413.PeterHuewe@gmx.de> <201209091415.02460.PeterHuewe@gmx.de> <504C8A2A.2060802@nod.at>
In-Reply-To: <504C8A2A.2060802@nod.at>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201209091452.19700.PeterHuewe@gmx.de>
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: Richard Weinberger <richard@nod.at>
Cc: Jean Delvare <khali@linux-fr.org>, Geert Uytterhoeven <geert@linux-m68k.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Sonntag, 9. September 2012, 14:23:06 schrieb Richard Weinberger: 
> UML does not have IO_MEM but some sub-systems have "depend HAS_IOMEM" which
> is often too coarse grained.
> To deal with that I've introduced GENERIC_IO some time ago to support MTD
> (and nandsim) on UML.
> Maybe some parts of the I2C sub-system can also just depend on GENERIC_IO
> instead of HAS_IOMEM.
> An arch has GENERIC_IO=y if it supports everything defined in
> generic-asm/io.h which is more than enough for most stub drivers.

The only thing which seems to be missing on UML is the ioremap function family 
;/


Peter


