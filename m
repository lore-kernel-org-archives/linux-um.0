Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZON5U-00075L-Sr
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Aug 2015 09:40:16 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZON5T-0008Ss-8j
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Aug 2015 09:40:16 +0000
From: Richard Weinberger <richard@nod.at>
Message-ID: <55C71FF5.1020902@nod.at>
Date: Sun, 9 Aug 2015 11:40:05 +0200
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] unmet direct dependencies in -next
To: linux-next@vger.kernel.org
Cc: sameo@linux.intel.com, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>, linux-kbuild <linux-kbuild@vger.kernel.org>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, lee.jones@linaro.org, yann.morin.1998@free.fr

Hi!

-next faces some build issues on UML because of unmet direct dependencies.
Mostly due to HAS_IOMEM and I2C.

warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_IIO) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM)
warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP &&
PINCTRL_DOVE && POWER_RESET_KEYSTONE && POWER_RESET_SYSCON && POWER_RESET_SYSCON_POWEROFF && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && RTC_DRV_AT91SAM9 && VIDEO_OMAP4 &&
HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_IIO) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM)
warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP &&
PINCTRL_DOVE && POWER_RESET_KEYSTONE && POWER_RESET_SYSCON && POWER_RESET_SYSCON_POWEROFF && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && RTC_DRV_AT91SAM9 && VIDEO_OMAP4 &&
HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)

For example MFD_SYSCON cannot build on UML as it depends on HAS_IOMEM.
While the symbol MFD_SYSCON has correct dependencies some users of MFD_SYSCON
just issue a "select MFD_SYSCON" and bypass the HAS_IOMEM dependency and causing the build to fail.

This brings me to a question on kconfig itself, wouldn't it be better to just disable a symbol if it has
unmet direct dependencies?

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

