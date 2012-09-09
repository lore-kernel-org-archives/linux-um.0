Return-Path: <khali@linux-fr.org>
Date: Sun, 9 Sep 2012 20:40:36 +0200
From: Jean Delvare <khali@linux-fr.org>
Message-ID: <20120909204036.40f2217c@endymion.delvare>
In-Reply-To: <201209091415.02460.PeterHuewe@gmx.de>
References: <201209022245.20413.PeterHuewe@gmx.de>
	<201209091249.04279.PeterHuewe@gmx.de>
	<20120909132838.51b6c434@endymion.delvare>
	<201209091415.02460.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: Peter =?ISO-8859-1?B?SPx3ZQ==?= <PeterHuewe@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hallo Petter,

On Sun, 9 Sep 2012 14:15:02 +0200, Peter H=FCwe wrote:
> I created a patch for your proposed solution, I moved the stub driver to =
the=20
> end in order to have only one big if HAS_IOMEM.

There is a problem with the mux chip drivers, which then no longer
depend on HAS_IOMEM. Also, I think it is about time to admit that
i2c-stub does not fit under "I2C Hardware Bus support". It is a driver
for development, not hardware support.

So I propose the following instead:

 drivers/i2c/Kconfig        |   14 +++++++++++++-
 drivers/i2c/busses/Kconfig |   14 +-------------
 drivers/i2c/muxes/Kconfig  |    2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

--- linux-3.6-rc4.orig/drivers/i2c/Kconfig	2012-07-21 22:58:29.000000000 +0=
200
+++ linux-3.6-rc4/drivers/i2c/Kconfig	2012-09-09 18:34:08.169196654 +0200
@@ -4,7 +4,6 @@
=20
 menuconfig I2C
 	tristate "I2C support"
-	depends on HAS_IOMEM
 	select RT_MUTEXES
 	---help---
 	  I2C (pronounce: I-squared-C) is a slow serial bus protocol used in
@@ -86,6 +85,19 @@ config I2C_SMBUS
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
--- linux-3.6-rc4.orig/drivers/i2c/busses/Kconfig	2012-09-08 09:36:32.08655=
3711 +0200
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
--- linux-3.6-rc4.orig/drivers/i2c/muxes/Kconfig	2012-07-21 22:58:29.000000=
000 +0200
+++ linux-3.6-rc4/drivers/i2c/muxes/Kconfig	2012-09-09 19:20:13.032141164 +=
0200
@@ -3,7 +3,7 @@
 #
=20
 menu "Multiplexer I2C Chip support"
-	depends on I2C_MUX
+	depends on HAS_IOMEM && I2C_MUX
=20
 config I2C_MUX_GPIO
 	tristate "GPIO-based I2C multiplexer"


--=20
Jean Delvare

