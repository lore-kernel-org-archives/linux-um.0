Return-Path: <PeterHuewe@gmx.de>
From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
Date: Sun, 9 Sep 2012 14:15:02 +0200
References: <201209022245.20413.PeterHuewe@gmx.de> <201209091249.04279.PeterHuewe@gmx.de> <20120909132838.51b6c434@endymion.delvare>
In-Reply-To: <20120909132838.51b6c434@endymion.delvare>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201209091415.02460.PeterHuewe@gmx.de>
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: Jean Delvare <khali@linux-fr.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Sonntag, 9. September 2012, 13:28:38 schrieb Jean Delvare:
> Thanks for the info. I thought UML was no longer used with all the
> virtualization solutions available, but apparently I was wrong.
I guess it's mainly used for sandboxing, testing and development ;)


> My bet is that all I2C bus drivers do use I/O or memory mapped
> operations directly or indirectly, except i2c-stub. So it would
> probably make more sense, and be a less intrusive change, to move the
> HAS_IOMEM dependency to drivers/i2c/busses, and move (logically or for
> real) i2c-stub out of it.
>=20
> Or are there really other I2C bus drivers which make sense to enable
> under UML?
The only other available in UML which doesn't rely on HAS_IOMEM is the=20
PARPORT_LIGHT which relies on direct io access - so I guess this one doesn'=
t=20
make sense either.

I created a patch for your proposed solution, I moved the stub driver to th=
e=20
end in order to have only one big if HAS_IOMEM.


Thanks,
Peter

=2D--
=46rom 923bc2feac0a04ee35382e60bb523d08baf92d48 Mon Sep 17 00:00:00 2001
=46rom: Peter Huewe <peterhuewe@gmx.de>
Date: Sun, 9 Sep 2012 14:10:05 +0200
Subject: [PATCH] i2c: Move HAS_IOMEM dependency to i2c/busses to make I2C
 available on UML

This patch removes the global dependency of the I2C subsystem on
HAS_IOMEM and moves the dependency to the i2c/busses submenu, with an
exception for i2c-stub.

The generic I2C part does not need to have HAS_IOMEM set and thus now
becomes available in UML, so the I2C subsystem can now be used, e.g.
by the i2c-stub driver, for development of I2C device drivers.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
=2D--
 drivers/i2c/Kconfig        |    1 -
 drivers/i2c/busses/Kconfig |   28 +++++++++++++++-------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index 5a3bb3d..e4e02e2 100644
=2D-- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -4,7 +4,6 @@
=20
 menuconfig I2C
 	tristate "I2C support"
=2D	depends on HAS_IOMEM
 	select RT_MUTEXES
 	---help---
 	  I2C (pronounce: I-squared-C) is a slow serial bus protocol used in
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index b4aaa1b..84954de 100644
=2D-- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -4,6 +4,7 @@
=20
 menu "I2C Hardware Bus support"
=20
+if HAS_IOMEM
 comment "PC SMBus host controller drivers"
 	depends on PCI
=20
@@ -843,19 +844,6 @@ config I2C_SIBYTE
 	help
 	  Supports the SiByte SOC on-chip I2C interfaces (2 channels).
=20
=2Dconfig I2C_STUB
=2D	tristate "I2C/SMBus Test Stub"
=2D	depends on EXPERIMENTAL && m
=2D	default 'n'
=2D	help
=2D	  This module may be useful to developers of SMBus client drivers,
=2D	  especially for certain kinds of sensor chips.
=2D
=2D	  If you do build this module, be sure to read the notes and warnings
=2D	  in <file:Documentation/i2c/i2c-stub>.
=2D
=2D	  If you don't know what to do here, definitely say N.
=2D
 config SCx200_I2C
 	tristate "NatSemi SCx200 I2C using GPIO pins (DEPRECATED)"
 	depends on SCx200_GPIO
@@ -898,5 +886,19 @@ config SCx200_ACB
=20
 	  This support is also available as a module.  If so, the module
 	  will be called scx200_acb.
+endif
+
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
=20
 endmenu
=2D-=20
1.7.8.6



