Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D77CD5BB0
	for <linux-um@archiver.kernel.org>; Fri, 22 May 2026 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iAR6XZ0NwmzxFQ6ob0tLdxPMuUoGCRZoWa9wBuuArgg=; b=mhQzUqLNcQ+a0qUK65veNBJ6JI
	aclu3+s2SMePhUuvzmhMlCYGVc2fLvq/CPpDOM6s3+h1Ge/0ql4MD6wL72ZWL2/HWbrBxoaXWlwu4
	jA1QzQjW07v6Padk6t6FkPxfDa0ZME+lAJ31x7G7QgRyUnykguSQDTZXnJJVHEJ7rcdRQNOOW5pkB
	YLxaDDYpNctVPj8/xnVKPoxDMgMWu4MFpQ3IqCyzESFV56HsNjhXtMidUZkkSGT1ArFOVQ8LCpRuR
	+pro2SITzpiLY1bSnhupF/O4vPHY57FRCA5AmehCOo5FuH5L7t4LkgnKZPCfbQYNTprc634NaKn0M
	bN6VF5fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQjm-0000000B6xO-44Xm;
	Fri, 22 May 2026 14:20:30 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQQjl-0000000B6wh-2K2U
	for linux-um@lists.infradead.org;
	Fri, 22 May 2026 14:20:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 98B7A60138;
	Fri, 22 May 2026 14:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBD11F00A3D;
	Fri, 22 May 2026 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459628;
	bh=iAR6XZ0NwmzxFQ6ob0tLdxPMuUoGCRZoWa9wBuuArgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JHUAIfg1fz0IVFsbHfUu3d1pJBVX9e+Tn997vZHtF45vXGmP9CezjC3H7MlSucT0F
	 /7q1+3VCqNyZRy6YwmLvZKFjSK/wV1RctZXGWeXpjvEMFmuluYLFaXeK9JBdMHUYdR
	 vXjBaraNzMlGj96GOq8DW70//OSW8WUm3qM4FfpGOQnd6MCTTPk65LyQNCB21U6YNQ
	 9Ja/XVsIkVB1zV+8D5dZzYYMfZBZYwS3N1FeOqn0kJlxs036ZztlFVmWsGfZV+1dPG
	 VMSz1CvWIQdPXKB7lv+w7Vwh+hBVXjLFI/3bwd5XZwAyEYP2seHCOsDOUPPfgpqApZ
	 1cTyqJiWn0htg==
From: Arnd Bergmann <arnd@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	"Savoir-faire Linux Inc." <kernel@savoirfairelinux.com>
Subject: [PATCH 1/8] x86: remove ts5500 platforms support
Date: Fri, 22 May 2026 16:19:52 +0200
Message-Id: <20260522141959.1071595-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260522141959.1071595-1-arnd@kernel.org>
References: <20260522141959.1071595-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Support for Élan was removed in 7.1, but the ts5500 platform
still depends on it. Remove this one as well, not that it
cannot be used any more.

Cc: "Savoir-faire Linux Inc." <kernel@savoirfairelinux.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../ABI/testing/sysfs-platform-ts5500         |  54 ---
 MAINTAINERS                                   |   5 -
 arch/x86/Kconfig                              |   9 -
 arch/x86/platform/Makefile                    |   1 -
 arch/x86/platform/ts5500/Makefile             |   2 -
 arch/x86/platform/ts5500/ts5500.c             | 341 ------------------
 6 files changed, 412 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-platform-ts5500
 delete mode 100644 arch/x86/platform/ts5500/Makefile
 delete mode 100644 arch/x86/platform/ts5500/ts5500.c

diff --git a/Documentation/ABI/testing/sysfs-platform-ts5500 b/Documentation/ABI/testing/sysfs-platform-ts5500
deleted file mode 100644
index e685957caa12..000000000000
--- a/Documentation/ABI/testing/sysfs-platform-ts5500
+++ /dev/null
@@ -1,54 +0,0 @@
-What:		/sys/devices/platform/ts5500/adc
-Date:		January 2013
-KernelVersion:	3.7
-Contact:	"Savoir-faire Linux Inc." <kernel@savoirfairelinux.com>
-Description:
-		Indicates the presence of an A/D Converter. If it is present,
-		it will display "1", otherwise "0".
-
-What:		/sys/devices/platform/ts5500/ereset
-Date:		January 2013
-KernelVersion:	3.7
-Contact:	"Savoir-faire Linux Inc." <kernel@savoirfairelinux.com>
-Description:
-		Indicates the presence of an external reset. If it is present,
-		it will display "1", otherwise "0".
-
-What:		/sys/devices/platform/ts5500/id
-Date:		January 2013
-KernelVersion:	3.7
-Contact:	"Savoir-faire Linux Inc." <kernel@savoirfairelinux.com>
-Description:
-		Product ID of the TS board. TS-5500 ID is 0x60.
-
-What:		/sys/devices/platform/ts5500/jumpers
-Date:		January 2013
-KernelVersion:	3.7
-Contact:	"Savoir-faire Linux Inc." <kernel@savoirfairelinux.com>
-Description:
-		Bitfield showing the jumpers' state. If a jumper is present,
-		the corresponding bit is set. For instance, 0x0e means jumpers
-		2, 3 and 4 are set.
-
-What:		/sys/devices/platform/ts5500/name
-Date:		July 2014
-KernelVersion:	3.16
-Contact:	"Savoir-faire Linux Inc." <kernel@savoirfairelinux.com>
-Description:
-		Model name of the TS board, e.g. "TS-5500".
-
-What:		/sys/devices/platform/ts5500/rs485
-Date:		January 2013
-KernelVersion:	3.7
-Contact:	"Savoir-faire Linux Inc." <kernel@savoirfairelinux.com>
-Description:
-		Indicates the presence of the RS485 option. If it is present,
-		it will display "1", otherwise "0".
-
-What:		/sys/devices/platform/ts5500/sram
-Date:		January 2013
-KernelVersion:	3.7
-Contact:	"Savoir-faire Linux Inc." <kernel@savoirfairelinux.com>
-Description:
-		Indicates the presence of the SRAM option. If it is present,
-		it will display "1", otherwise "0".
diff --git a/MAINTAINERS b/MAINTAINERS
index e706b468a53f..dd3fceaa78d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26402,11 +26402,6 @@ S:	Maintained
 F:	Documentation/process/contribution-maturity-model.rst
 F:	Documentation/process/researcher-guidelines.rst
 
-TECHNOLOGIC SYSTEMS TS-5500 PLATFORM SUPPORT
-M:	"Savoir-faire Linux Inc." <kernel@savoirfairelinux.com>
-S:	Maintained
-F:	arch/x86/platform/ts5500/
-
 TECHNOTREND USB IR RECEIVER
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f24810015234..a188ed90b1ca 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -3056,15 +3056,6 @@ config GEOS
 	help
 	  This option enables system support for the Traverse Technologies GEOS.
 
-config TS5500
-	bool "Technologic Systems TS-5500 platform support"
-	depends on MELAN
-	select CHECK_SIGNATURE
-	select NEW_LEDS
-	select LEDS_CLASS
-	help
-	  This option enables system support for the Technologic Systems TS-5500.
-
 endif # X86_32
 
 config AMD_NB
diff --git a/arch/x86/platform/Makefile b/arch/x86/platform/Makefile
index 3ed03a2552d0..727b92d0ca25 100644
--- a/arch/x86/platform/Makefile
+++ b/arch/x86/platform/Makefile
@@ -10,5 +10,4 @@ obj-y	+= intel-mid/
 obj-y	+= intel-quark/
 obj-y	+= olpc/
 obj-y	+= scx200/
-obj-y	+= ts5500/
 obj-y	+= uv/
diff --git a/arch/x86/platform/ts5500/Makefile b/arch/x86/platform/ts5500/Makefile
deleted file mode 100644
index 910fe9e3ffb4..000000000000
--- a/arch/x86/platform/ts5500/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_TS5500)	+= ts5500.o
diff --git a/arch/x86/platform/ts5500/ts5500.c b/arch/x86/platform/ts5500/ts5500.c
deleted file mode 100644
index 0b67da056fd9..000000000000
--- a/arch/x86/platform/ts5500/ts5500.c
+++ /dev/null
@@ -1,341 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Technologic Systems TS-5500 Single Board Computer support
- *
- * Copyright (C) 2013-2014 Savoir-faire Linux Inc.
- *	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
- *
- * This driver registers the Technologic Systems TS-5500 Single Board Computer
- * (SBC) and its devices, and exposes information to userspace such as jumpers'
- * state or available options. For further information about sysfs entries, see
- * Documentation/ABI/testing/sysfs-platform-ts5500.
- *
- * This code may be extended to support similar x86-based platforms.
- * Actually, the TS-5500 and TS-5400 are supported.
- */
-
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/leds.h>
-#include <linux/init.h>
-#include <linux/platform_data/max197.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-
-/* Product code register */
-#define TS5500_PRODUCT_CODE_ADDR	0x74
-#define TS5500_PRODUCT_CODE		0x60	/* TS-5500 product code */
-#define TS5400_PRODUCT_CODE		0x40	/* TS-5400 product code */
-
-/* SRAM/RS-485/ADC options, and RS-485 RTS/Automatic RS-485 flags register */
-#define TS5500_SRAM_RS485_ADC_ADDR	0x75
-#define TS5500_SRAM			BIT(0)	/* SRAM option */
-#define TS5500_RS485			BIT(1)	/* RS-485 option */
-#define TS5500_ADC			BIT(2)	/* A/D converter option */
-#define TS5500_RS485_RTS		BIT(6)	/* RTS for RS-485 */
-#define TS5500_RS485_AUTO		BIT(7)	/* Automatic RS-485 */
-
-/* External Reset/Industrial Temperature Range options register */
-#define TS5500_ERESET_ITR_ADDR		0x76
-#define TS5500_ERESET			BIT(0)	/* External Reset option */
-#define TS5500_ITR			BIT(1)	/* Indust. Temp. Range option */
-
-/* LED/Jumpers register */
-#define TS5500_LED_JP_ADDR		0x77
-#define TS5500_LED			BIT(0)	/* LED flag */
-#define TS5500_JP1			BIT(1)	/* Automatic CMOS */
-#define TS5500_JP2			BIT(2)	/* Enable Serial Console */
-#define TS5500_JP3			BIT(3)	/* Write Enable Drive A */
-#define TS5500_JP4			BIT(4)	/* Fast Console (115K baud) */
-#define TS5500_JP5			BIT(5)	/* User Jumper */
-#define TS5500_JP6			BIT(6)	/* Console on COM1 (req. JP2) */
-#define TS5500_JP7			BIT(7)	/* Undocumented (Unused) */
-
-/* A/D Converter registers */
-#define TS5500_ADC_CONV_BUSY_ADDR	0x195	/* Conversion state register */
-#define TS5500_ADC_CONV_BUSY		BIT(0)
-#define TS5500_ADC_CONV_INIT_LSB_ADDR	0x196	/* Start conv. / LSB register */
-#define TS5500_ADC_CONV_MSB_ADDR	0x197	/* MSB register */
-#define TS5500_ADC_CONV_DELAY		12	/* usec */
-
-/**
- * struct ts5500_sbc - TS-5500 board description
- * @name:	Board model name.
- * @id:		Board product ID.
- * @sram:	Flag for SRAM option.
- * @rs485:	Flag for RS-485 option.
- * @adc:	Flag for Analog/Digital converter option.
- * @ereset:	Flag for External Reset option.
- * @itr:	Flag for Industrial Temperature Range option.
- * @jumpers:	Bitfield for jumpers' state.
- */
-struct ts5500_sbc {
-	const char *name;
-	int	id;
-	bool	sram;
-	bool	rs485;
-	bool	adc;
-	bool	ereset;
-	bool	itr;
-	u8	jumpers;
-};
-
-/* Board signatures in BIOS shadow RAM */
-static const struct {
-	const char * const string;
-	const ssize_t offset;
-} ts5500_signatures[] __initconst = {
-	{ "TS-5x00 AMD Elan", 0xb14 },
-};
-
-static int __init ts5500_check_signature(void)
-{
-	void __iomem *bios;
-	int i, ret = -ENODEV;
-
-	bios = ioremap(0xf0000, 0x10000);
-	if (!bios)
-		return -ENOMEM;
-
-	for (i = 0; i < ARRAY_SIZE(ts5500_signatures); i++) {
-		if (check_signature(bios + ts5500_signatures[i].offset,
-				    ts5500_signatures[i].string,
-				    strlen(ts5500_signatures[i].string))) {
-			ret = 0;
-			break;
-		}
-	}
-
-	iounmap(bios);
-	return ret;
-}
-
-static int __init ts5500_detect_config(struct ts5500_sbc *sbc)
-{
-	u8 tmp;
-	int ret = 0;
-
-	if (!request_region(TS5500_PRODUCT_CODE_ADDR, 4, "ts5500"))
-		return -EBUSY;
-
-	sbc->id = inb(TS5500_PRODUCT_CODE_ADDR);
-	if (sbc->id == TS5500_PRODUCT_CODE) {
-		sbc->name = "TS-5500";
-	} else if (sbc->id == TS5400_PRODUCT_CODE) {
-		sbc->name = "TS-5400";
-	} else {
-		pr_err("ts5500: unknown product code 0x%x\n", sbc->id);
-		ret = -ENODEV;
-		goto cleanup;
-	}
-
-	tmp = inb(TS5500_SRAM_RS485_ADC_ADDR);
-	sbc->sram = tmp & TS5500_SRAM;
-	sbc->rs485 = tmp & TS5500_RS485;
-	sbc->adc = tmp & TS5500_ADC;
-
-	tmp = inb(TS5500_ERESET_ITR_ADDR);
-	sbc->ereset = tmp & TS5500_ERESET;
-	sbc->itr = tmp & TS5500_ITR;
-
-	tmp = inb(TS5500_LED_JP_ADDR);
-	sbc->jumpers = tmp & ~TS5500_LED;
-
-cleanup:
-	release_region(TS5500_PRODUCT_CODE_ADDR, 4);
-	return ret;
-}
-
-static ssize_t name_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct ts5500_sbc *sbc = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%s\n", sbc->name);
-}
-static DEVICE_ATTR_RO(name);
-
-static ssize_t id_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct ts5500_sbc *sbc = dev_get_drvdata(dev);
-
-	return sprintf(buf, "0x%.2x\n", sbc->id);
-}
-static DEVICE_ATTR_RO(id);
-
-static ssize_t jumpers_show(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct ts5500_sbc *sbc = dev_get_drvdata(dev);
-
-	return sprintf(buf, "0x%.2x\n", sbc->jumpers >> 1);
-}
-static DEVICE_ATTR_RO(jumpers);
-
-#define TS5500_ATTR_BOOL(_field)					\
-	static ssize_t _field##_show(struct device *dev,		\
-			struct device_attribute *attr, char *buf)	\
-	{								\
-		struct ts5500_sbc *sbc = dev_get_drvdata(dev);		\
-									\
-		return sprintf(buf, "%d\n", sbc->_field);		\
-	}								\
-	static DEVICE_ATTR_RO(_field)
-
-TS5500_ATTR_BOOL(sram);
-TS5500_ATTR_BOOL(rs485);
-TS5500_ATTR_BOOL(adc);
-TS5500_ATTR_BOOL(ereset);
-TS5500_ATTR_BOOL(itr);
-
-static struct attribute *ts5500_attributes[] = {
-	&dev_attr_id.attr,
-	&dev_attr_name.attr,
-	&dev_attr_jumpers.attr,
-	&dev_attr_sram.attr,
-	&dev_attr_rs485.attr,
-	&dev_attr_adc.attr,
-	&dev_attr_ereset.attr,
-	&dev_attr_itr.attr,
-	NULL
-};
-
-static const struct attribute_group ts5500_attr_group = {
-	.attrs = ts5500_attributes,
-};
-
-static struct resource ts5500_dio1_resource[] = {
-	DEFINE_RES_IRQ_NAMED(7, "DIO1 interrupt"),
-};
-
-static struct platform_device ts5500_dio1_pdev = {
-	.name = "ts5500-dio1",
-	.id = -1,
-	.resource = ts5500_dio1_resource,
-	.num_resources = 1,
-};
-
-static struct resource ts5500_dio2_resource[] = {
-	DEFINE_RES_IRQ_NAMED(6, "DIO2 interrupt"),
-};
-
-static struct platform_device ts5500_dio2_pdev = {
-	.name = "ts5500-dio2",
-	.id = -1,
-	.resource = ts5500_dio2_resource,
-	.num_resources = 1,
-};
-
-static void ts5500_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness brightness)
-{
-	outb(!!brightness, TS5500_LED_JP_ADDR);
-}
-
-static enum led_brightness ts5500_led_get(struct led_classdev *led_cdev)
-{
-	return (inb(TS5500_LED_JP_ADDR) & TS5500_LED) ? LED_FULL : LED_OFF;
-}
-
-static struct led_classdev ts5500_led_cdev = {
-	.name = "ts5500:green:",
-	.brightness_set = ts5500_led_set,
-	.brightness_get = ts5500_led_get,
-};
-
-static int ts5500_adc_convert(u8 ctrl)
-{
-	u8 lsb, msb;
-
-	/* Start conversion (ensure the 3 MSB are set to 0) */
-	outb(ctrl & 0x1f, TS5500_ADC_CONV_INIT_LSB_ADDR);
-
-	/*
-	 * The platform has CPLD logic driving the A/D converter.
-	 * The conversion must complete within 11 microseconds,
-	 * otherwise we have to re-initiate a conversion.
-	 */
-	udelay(TS5500_ADC_CONV_DELAY);
-	if (inb(TS5500_ADC_CONV_BUSY_ADDR) & TS5500_ADC_CONV_BUSY)
-		return -EBUSY;
-
-	/* Read the raw data */
-	lsb = inb(TS5500_ADC_CONV_INIT_LSB_ADDR);
-	msb = inb(TS5500_ADC_CONV_MSB_ADDR);
-
-	return (msb << 8) | lsb;
-}
-
-static struct max197_platform_data ts5500_adc_pdata = {
-	.convert = ts5500_adc_convert,
-};
-
-static struct platform_device ts5500_adc_pdev = {
-	.name = "max197",
-	.id = -1,
-	.dev = {
-		.platform_data = &ts5500_adc_pdata,
-	},
-};
-
-static int __init ts5500_init(void)
-{
-	struct platform_device *pdev;
-	struct ts5500_sbc *sbc;
-	int err;
-
-	/*
-	 * There is no DMI available or PCI bridge subvendor info,
-	 * only the BIOS provides a 16-bit identification call.
-	 * It is safer to find a signature in the BIOS shadow RAM.
-	 */
-	err = ts5500_check_signature();
-	if (err)
-		return err;
-
-	pdev = platform_device_register_simple("ts5500", -1, NULL, 0);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	sbc = devm_kzalloc(&pdev->dev, sizeof(struct ts5500_sbc), GFP_KERNEL);
-	if (!sbc) {
-		err = -ENOMEM;
-		goto error;
-	}
-
-	err = ts5500_detect_config(sbc);
-	if (err)
-		goto error;
-
-	platform_set_drvdata(pdev, sbc);
-
-	err = sysfs_create_group(&pdev->dev.kobj, &ts5500_attr_group);
-	if (err)
-		goto error;
-
-	if (sbc->id == TS5500_PRODUCT_CODE) {
-		ts5500_dio1_pdev.dev.parent = &pdev->dev;
-		if (platform_device_register(&ts5500_dio1_pdev))
-			dev_warn(&pdev->dev, "DIO1 block registration failed\n");
-		ts5500_dio2_pdev.dev.parent = &pdev->dev;
-		if (platform_device_register(&ts5500_dio2_pdev))
-			dev_warn(&pdev->dev, "DIO2 block registration failed\n");
-	}
-
-	if (led_classdev_register(&pdev->dev, &ts5500_led_cdev))
-		dev_warn(&pdev->dev, "LED registration failed\n");
-
-	if (sbc->adc) {
-		ts5500_adc_pdev.dev.parent = &pdev->dev;
-		if (platform_device_register(&ts5500_adc_pdev))
-			dev_warn(&pdev->dev, "ADC registration failed\n");
-	}
-
-	return 0;
-error:
-	platform_device_unregister(pdev);
-	return err;
-}
-device_initcall(ts5500_init);
-- 
2.39.5


