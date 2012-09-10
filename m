Return-Path: <khali@linux-fr.org>
Date: Mon, 10 Sep 2012 09:29:18 +0200
From: Jean Delvare <khali@linux-fr.org>
Message-ID: <20120910092918.6d53ef77@endymion.delvare>
In-Reply-To: <201209092117.20896.PeterHuewe@gmx.de>
References: <201209022245.20413.PeterHuewe@gmx.de>
	<201209091415.02460.PeterHuewe@gmx.de>
	<20120909204036.40f2217c@endymion.delvare>
	<201209092117.20896.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: Peter =?ISO-8859-1?B?SPx3ZQ==?= <PeterHuewe@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, 9 Sep 2012 21:17:20 +0200, Peter H=FCwe wrote:
> Hi Jean,
> Am Sonntag, 9. September 2012, 20:40:36 schrieb Jean Delvare:
> > There is a problem with the mux chip drivers, which then no longer
> > depend on HAS_IOMEM.
> The selectables on my x86 and UML machine build fine ;)
> But you're correct, we should exclude/guard them.
>=20
> > Also, I think it is about time to admit that
> > i2c-stub does not fit under "I2C Hardware Bus support". It is a driver
> > for development, not hardware support.
> >=20
> > So I propose the following instead:
> >=20
> >  drivers/i2c/Kconfig        |   14 +++++++++++++-
> >  drivers/i2c/busses/Kconfig |   14 +-------------
> >  drivers/i2c/muxes/Kconfig  |    2 +-
> >  3 files changed, 15 insertions(+), 15 deletions(-)
>=20
>=20
> I'm perfectly fine with this.
>=20
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

I slept over it and my approach makes little sense for multiplexing.
i2c-mux is useless without at least one multiplexer driver, and
with my patch, the user can't select any without CONFIG_IOMEM.

So either i2c-mux should depend on CONFIG_IOMEM too (in which case we
no longer need this dependency in drivers/i2c/muxes/Kconfig, as we will
get it by transitivity) or we should let i2c multiplexer drivers be
built even without CONFIG_IOMEM. After all, if they can be selected,
they will build, as they are all accessing the hardware indirectly
(through gpio or i2c layers.)

At the moment, it makes no sense to enable multiplexing without
CONFIG_IOMEM, as the only driver which can instantiate a root I2C
segment is i2c-stub and that driver wouldn't know how to deal with
multiplexing. So option #1 has my favors for now. If anyone ever
implements multiplexing emulation in i2c-stub then we can revisit and
let i2c-mux + the driver for the emulated mux chip be built
under !CONFIG_IOMEM. OK?

I also noticed that I2C_DEBUG_BUS has no effect under !CONFIG_IOMEM
with my previous patch, so we can hide it.

Leads me to:

From: Peter Huewe <peterhuewe@gmx.de>
Subject: i2c: Make I2C available on UML

Remove the global dependency of the I2C subsystem on HAS_IOMEM and
move the dependency to the i2c/busses submenu, with an exception for
i2c-stub.

The generic I2C part does not need to have HAS_IOMEM set and thus now
becomes available in UML, so the I2C subsystem can now be used, e.g.
by the i2c-stub driver, for development of I2C device drivers.

[JD: Some adjustments.]

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/Kconfig        |   16 +++++++++++++++-
 drivers/i2c/busses/Kconfig |   14 +-------------
 2 files changed, 16 insertions(+), 14 deletions(-)

--- linux-3.6-rc4.orig/drivers/i2c/Kconfig	2012-07-21 22:58:29.000000000 +0=
200
+++ linux-3.6-rc4/drivers/i2c/Kconfig	2012-09-10 09:19:06.485756611 +0200
@@ -4,7 +4,6 @@
=20
 menuconfig I2C
 	tristate "I2C support"
-	depends on HAS_IOMEM
 	select RT_MUTEXES
 	---help---
 	  I2C (pronounce: I-squared-C) is a slow serial bus protocol used in
@@ -49,6 +48,7 @@ config I2C_CHARDEV
=20
 config I2C_MUX
 	tristate "I2C bus multiplexing support"
+	depends on HAS_IOMEM
 	help
 	  Say Y here if you want the I2C core to support the ability to
 	  handle multiplexed I2C bus topologies, by presenting each
@@ -86,6 +86,19 @@ config I2C_SMBUS
 source drivers/i2c/algos/Kconfig
 source drivers/i2c/busses/Kconfig
=20
+config I2C_STUB
+	tristate "I2C/SMBus Test Stub"
+	depends on EXPERIMENTAL && m
+	default 'n'
+	help
+	  This module may be useful to developers of SMBus client drivers,
+	  especially for certain kinds of sensor chips.
+
+	  If you do build this module, be sure to read the notes and warnings
+	  in <file:Documentation/i2c/i2c-stub>.
+
+	  If you don't know what to do here, definitely say N.
+
 config I2C_DEBUG_CORE
 	bool "I2C Core debugging messages"
 	help
@@ -103,6 +116,7 @@ config I2C_DEBUG_ALGO
=20
 config I2C_DEBUG_BUS
 	bool "I2C Bus debugging messages"
+	depends on HAS_IOMEM
 	help
 	  Say Y here if you want the I2C bus drivers to produce a bunch of
 	  debug messages to the system log.  Select this if you are having
--- linux-3.6-rc4.orig/drivers/i2c/busses/Kconfig	2012-09-08 09:36:32.00000=
0000 +0200
+++ linux-3.6-rc4/drivers/i2c/busses/Kconfig	2012-09-09 18:33:58.598196535 =
+0200
@@ -3,6 +3,7 @@
 #
=20
 menu "I2C Hardware Bus support"
+	depends on HAS_IOMEM
=20
 comment "PC SMBus host controller drivers"
 	depends on PCI
@@ -850,19 +851,6 @@ config I2C_SIBYTE
 	help
 	  Supports the SiByte SOC on-chip I2C interfaces (2 channels).
=20
-config I2C_STUB
-	tristate "I2C/SMBus Test Stub"
-	depends on EXPERIMENTAL && m
-	default 'n'
-	help
-	  This module may be useful to developers of SMBus client drivers,
-	  especially for certain kinds of sensor chips.
-
-	  If you do build this module, be sure to read the notes and warnings
-	  in <file:Documentation/i2c/i2c-stub>.
-
-	  If you don't know what to do here, definitely say N.
-
 config SCx200_I2C
 	tristate "NatSemi SCx200 I2C using GPIO pins (DEPRECATED)"
 	depends on SCx200_GPIO


If everybody is happy with this, I'll queue it up for 3.7.

--=20
Jean Delvare

