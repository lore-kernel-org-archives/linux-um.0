Return-Path: <PeterHuewe@gmx.de>
From: Peter =?utf-8?q?H=C3=BCwe?= <PeterHuewe@gmx.de>
Date: Sun, 9 Sep 2012 12:49:03 +0200
References: <201209022245.20413.PeterHuewe@gmx.de> <201209090308.08766.PeterHuewe@gmx.de> <CAMuHMdVOwx9hmRQzFj02uL0xuCca76QzfJWH9rOBj4is7gcFpQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVOwx9hmRQzFj02uL0xuCca76QzfJWH9rOBj4is7gcFpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201209091249.04279.PeterHuewe@gmx.de>
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, Jean Delvare <khali@linux-fr.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Geert,

> That's because they rely on the HAS_IOMEM dependency for the whole
> subsystem. In fact, I'm surprised you didn't have to add HAS_IOMEM
> dependencies to more drivers.
I changed only the ones which are available in UML.
I now rewrote the patch to remove the global dependency and move it to all =
the=20
drivers that really rely on HAS_IOMEM - see below.


> > Do you think I should try to push this mainline via the i2c subsystem?
> As long as there are no "real" i2c drivers for UML, but only
> dummy/development ones,
> that is up to the i2c maintainer (in CC).
Nevertheless it would probably be a good starting point for developers - if=
 a=20
subsystem is available the probability that someone hacks on it is much hig=
her=20
;)

Thanks,
Peter

=2D--

=46rom 25268d4cdd4b1dd1e5d03c9b90c179758dd41e2e Mon Sep 17 00:00:00 2001
=46rom: Peter Huewe <peterhuewe@gmx.de>
Date: Sun, 9 Sep 2012 03:03:29 +0200
Subject: [PATCH] i2c: Fix/Change dependencies to make I2C available on UML

This patch removes the global dependency of the I2C subsystem on
HAS_IOMEM and moves the dependency to the drivers which really rely on
HAS_IOMEM.

The generic I2C part does not need to have HAS_IOMEM set and thus now
becomes available in UML so the I2C subsystem can now be used, e.g.
by the i2c-stub driver, for development of I2C device drivers.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
=2D--
 drivers/i2c/Kconfig        |    1 -
 drivers/i2c/busses/Kconfig |   60 ++++++++++++++++++++++++++--------------=
=2D--
 2 files changed, 36 insertions(+), 25 deletions(-)

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
index b4aaa1b..27d1d98 100644
=2D-- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -79,6 +79,7 @@ config I2C_AMD8111
 config I2C_I801
 	tristate "Intel 82801 (ICH/PCH)"
 	depends on PCI
+	depends on HAS_IOMEM
 	select CHECK_SIGNATURE if X86 && DMI
 	help
 	  If you say yes to this option, support will be included for the Intel
@@ -264,7 +265,7 @@ comment "Mac SMBus host controller drivers"
=20
 config I2C_HYDRA
 	tristate "CHRP Apple Hydra Mac I/O I2C interface"
=2D	depends on PCI && PPC_CHRP && EXPERIMENTAL
+	depends on PCI && PPC_CHRP && EXPERIMENTAL && HAS_IOMEM
 	select I2C_ALGOBIT
 	help
 	  This supports the use of the I2C interface in the Apple Hydra Mac
@@ -291,6 +292,7 @@ comment "I2C system bus drivers (mostly embedded / syst=
em-
on-chip)"
 config I2C_AT91
 	tristate "Atmel AT91 I2C Two-Wire interface (TWI)"
 	depends on ARCH_AT91 && EXPERIMENTAL && BROKEN
+	depends on HAS_IOMEM
 	help
 	  This supports the use of the I2C interface on Atmel AT91
 	  processors.
@@ -305,7 +307,7 @@ config I2C_AT91
=20
 config I2C_AU1550
 	tristate "Au1550/Au1200/Au1300 SMBus interface"
=2D	depends on MIPS_ALCHEMY
+	depends on MIPS_ALCHEMY && HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for the
 	  Au1550/Au1200/Au1300 SMBus interface.
@@ -315,7 +317,7 @@ config I2C_AU1550
=20
 config I2C_BLACKFIN_TWI
 	tristate "Blackfin TWI I2C support"
=2D	depends on BLACKFIN
+	depends on BLACKFIN && HAS_IOMEM
 	depends on !BF561 && !BF531 && !BF532 && !BF533
 	help
 	  This is the I2C bus driver for Blackfin on-chip TWI interface.
@@ -343,7 +345,7 @@ config I2C_CPM
=20
 config I2C_DAVINCI
 	tristate "DaVinci I2C driver"
=2D	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI && HAS_IOMEM
 	help
 	  Support for TI DaVinci I2C controller driver.
=20
@@ -356,7 +358,7 @@ config I2C_DAVINCI
=20
 config I2C_DESIGNWARE_PLATFORM
 	tristate "Synopsys DesignWare Platform"
=2D	depends on HAVE_CLK
+	depends on HAVE_CLK && HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for the
 	  Synopsys DesignWare I2C adapter. Only master mode is supported.
@@ -366,7 +368,7 @@ config I2C_DESIGNWARE_PLATFORM
=20
 config I2C_DESIGNWARE_PCI
 	tristate "Synopsys DesignWare PCI"
=2D	depends on PCI
+	depends on PCI && HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for the
 	  Synopsys DesignWare I2C adapter. Only master mode is supported.
@@ -399,7 +401,7 @@ config I2C_GPIO
=20
 config I2C_HIGHLANDER
 	tristate "Highlander FPGA SMBus interface"
=2D	depends on SH_HIGHLANDER
+	depends on SH_HIGHLANDER && HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for
 	  the SMBus interface located in the FPGA on various Highlander
@@ -421,7 +423,7 @@ config I2C_IBM_IIC
=20
 config I2C_IMX
 	tristate "IMX I2C interface"
=2D	depends on ARCH_MXC
+	depends on ARCH_MXC && HAS_IOMEM
 	help
 	  Say Y here if you want to use the IIC bus controller on
 	  the Freescale i.MX/MXC processors.
@@ -431,7 +433,7 @@ config I2C_IMX
=20
 config I2C_INTEL_MID
 	tristate "Intel Moorestown/Medfield Platform I2C controller"
=2D	depends on PCI
+	depends on PCI && HAS_IOMEM
 	help
 	  Say Y here if you have an Intel Moorestown/Medfield platform I2C
 	  controller.
@@ -442,6 +444,7 @@ config I2C_INTEL_MID
 config I2C_IOP3XX
 	tristate "Intel IOPx3xx and IXP4xx on-chip I2C interface"
 	depends on ARCH_IOP32X || ARCH_IOP33X || ARCH_IXP4XX || ARCH_IOP13XX
+	depends on HAS_IOMEM
 	help
 	  Say Y here if you want to use the IIC bus controller on
 	  the Intel IOPx3xx I/O Processors or IXP4xx Network Processors.
@@ -451,7 +454,7 @@ config I2C_IOP3XX
=20
 config I2C_MPC
 	tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
=2D	depends on PPC
+	depends on PPC && HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the MPC107, Tsi107, MPC512x, MPC52xx,
@@ -463,6 +466,7 @@ config I2C_MPC
 config I2C_MV64XXX
 	tristate "Marvell mv64xxx I2C Controller"
 	depends on (MV64X60 || PLAT_ORION)
+	depends on HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Marvell 64xxx line of host bridges.
@@ -473,6 +477,7 @@ config I2C_MV64XXX
 config I2C_MXS
 	tristate "Freescale i.MX28 I2C interface"
 	depends on SOC_IMX28
+	depends on HAS_IOMEM
 	select STMP_DEVICE
 	help
 	  Say Y here if you want to use the I2C bus controller on
@@ -483,7 +488,7 @@ config I2C_MXS
=20
 config I2C_NOMADIK
 	tristate "ST-Ericsson Nomadik/Ux500 I2C Controller"
=2D	depends on ARM_AMBA
+	depends on ARM_AMBA && HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for the
 	  I2C interface from ST-Ericsson's Nomadik and Ux500 architectures,
@@ -491,14 +496,14 @@ config I2C_NOMADIK
=20
 config I2C_NUC900
 	tristate "NUC900 I2C Driver"
=2D	depends on ARCH_W90X900
+	depends on ARCH_W90X900 && HAS_IOMEM
 	help
 	  Say Y here to include support for I2C controller in the
 	  Winbond/Nuvoton NUC900 based System-on-Chip devices.
=20
 config I2C_OCORES
 	tristate "OpenCores I2C Controller"
=2D	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for the
 	  OpenCores I2C controller. For details see
@@ -509,7 +514,7 @@ config I2C_OCORES
=20
 config I2C_OMAP
 	tristate "OMAP I2C adapter"
=2D	depends on ARCH_OMAP
+	depends on ARCH_OMAP && HAS_IOMEM
 	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
 	help
 	  If you say yes to this option, support will be included for the
@@ -525,6 +530,7 @@ config I2C_PASEMI
=20
 config I2C_PCA_PLATFORM
 	tristate "PCA9564/PCA9665 as platform device"
+	depends on HAS_IOMEM
 	select I2C_ALGOPCA
 	default n
 	help
@@ -536,7 +542,7 @@ config I2C_PCA_PLATFORM
=20
 config I2C_PMCMSP
 	tristate "PMC MSP I2C TWI Controller"
=2D	depends on PMC_MSP
+	depends on PMC_MSP && HAS_IOMEM
 	help
 	  This driver supports the PMC TWI controller on MSP devices.
=20
@@ -546,6 +552,7 @@ config I2C_PMCMSP
 config I2C_PNX
 	tristate "I2C bus support for Philips PNX and NXP LPC targets"
 	depends on ARCH_PNX4008 || ARCH_LPC32XX
+	depends on HAS_IOMEM
 	help
 	  This driver supports the Philips IP3204 I2C IP block master and/or
 	  slave controller
@@ -567,6 +574,7 @@ config I2C_PUV3
 config I2C_PXA
 	tristate "Intel PXA2XX I2C adapter"
 	depends on ARCH_PXA || ARCH_MMP || (X86_32 && PCI && OF)
+	depends on HAS_IOMEM
 	help
 	  If you have devices in the PXA I2C bus, say yes to this option.
 	  This driver can also be built as a module.  If so, the module
@@ -592,14 +600,14 @@ config HAVE_S3C2410_I2C
=20
 config I2C_S3C2410
 	tristate "S3C2410 I2C Driver"
=2D	depends on HAVE_S3C2410_I2C
+	depends on HAVE_S3C2410_I2C && HAS_IOMEM
 	help
 	  Say Y here to include support for I2C controller in the
 	  Samsung SoCs.
=20
 config I2C_S6000
 	tristate "S6000 I2C support"
=2D	depends on XTENSA_VARIANT_S6000
+	depends on XTENSA_VARIANT_S6000 && HAS_IOMEM
 	help
 	  This driver supports the on chip I2C device on the
 	  S6000 xtensa processor family.
@@ -610,6 +618,7 @@ config I2C_S6000
 config I2C_SH7760
 	tristate "Renesas SH7760 I2C Controller"
 	depends on CPU_SUBTYPE_SH7760
+	depends on HAS_IOMEM
 	help
 	  This driver supports the 2 I2C interfaces on the Renesas SH7760.
=20
@@ -619,6 +628,7 @@ config I2C_SH7760
 config I2C_SH_MOBILE
 	tristate "SuperH Mobile I2C Controller"
 	depends on SUPERH || ARCH_SHMOBILE
+	depends on HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Renesas SH-Mobile processor.
@@ -628,6 +638,7 @@ config I2C_SH_MOBILE
=20
 config I2C_SIMTEC
 	tristate "Simtec Generic I2C interface"
+	depends on HAS_IOMEM
 	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for
@@ -640,7 +651,7 @@ config I2C_SIMTEC
=20
 config I2C_SIRF
 	tristate "CSR SiRFprimaII I2C interface"
=2D	depends on ARCH_PRIMA2
+	depends on ARCH_PRIMA2 && HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for the
 	  CSR SiRFprimaII I2C interface.
@@ -650,7 +661,7 @@ config I2C_SIRF
=20
 config I2C_STU300
 	tristate "ST Microelectronics DDC I2C interface"
=2D	depends on MACH_U300
+	depends on MACH_U300 && HAS_IOMEM
 	default y if MACH_U300
 	help
 	  If you say yes to this option, support will be included for the
@@ -663,7 +674,7 @@ config I2C_STU300
=20
 config I2C_TEGRA
 	tristate "NVIDIA Tegra internal I2C controller"
=2D	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA && HAS_IOMEM
 	help
 	  If you say yes to this option, support will be included for the
 	  I2C controller embedded in NVIDIA Tegra SOCs
@@ -671,6 +682,7 @@ config I2C_TEGRA
 config I2C_VERSATILE
 	tristate "ARM Versatile/Realview I2C bus support"
 	depends on ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS
+	depends on HAS_IOMEM
 	select I2C_ALGOBIT
 	help
 	  Say yes if you want to support the I2C serial bus on ARMs Versatile
@@ -681,7 +693,7 @@ config I2C_VERSATILE
=20
 config I2C_OCTEON
 	tristate "Cavium OCTEON I2C bus support"
=2D	depends on CPU_CAVIUM_OCTEON
+	depends on CPU_CAVIUM_OCTEON && HAS_IOMEM
 	help
 	  Say yes if you want to support the I2C serial bus on Cavium
 	  OCTEON SOC.
@@ -701,7 +713,7 @@ config I2C_XILINX
=20
 config I2C_XLR
 	tristate "XLR I2C support"
=2D	depends on CPU_XLR
+	depends on CPU_XLR && HAS_IOMEM
 	help
 	  This driver enables support for the on-chip I2C interface of
 	  the Netlogic XLR/XLS MIPS processors.
@@ -772,7 +784,7 @@ config I2C_PARPORT_LIGHT
=20
 config I2C_TAOS_EVM
 	tristate "TAOS evaluation module"
=2D	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && HAS_IOMEM
 	select SERIO
 	select SERIO_SERPORT
 	default n
@@ -811,7 +823,7 @@ config I2C_ACORN
=20
 config I2C_ELEKTOR
 	tristate "Elektor ISA card"
=2D	depends on ISA && HAS_IOPORT && BROKEN_ON_SMP
+	depends on ISA && HAS_IOPORT && BROKEN_ON_SMP && HAS_IOMEM
 	select I2C_ALGOPCF
 	help
 	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
=2D-=20
1.7.8.6


