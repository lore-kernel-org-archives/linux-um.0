Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1aNpZ8-0006eH-RA
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 22:24:54 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aNpZ8-00046Q-1g for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 22:24:54 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 25 Jan 2016 23:24:11 +0100
Message-Id: <1453760661-1444-13-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
Subject: [uml-devel] [PATCH 12/22] nvmem: Fix dependencies for !HAS_IOMEM
	archs
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Maxime Ripard <maxime.ripard@free-electrons.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, user-mode-linux-devel@lists.sourceforge.net

Not every arch has io memory.
So, unbreak the build by fixing the dependencies.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/nvmem/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index bc4ea58..c675ee9 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -28,6 +28,7 @@ config NVMEM_IMX_OCOTP
 config NVMEM_MXS_OCOTP
 	tristate "Freescale MXS On-Chip OTP Memory Support"
 	depends on ARCH_MXS || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  If you say Y here, you will get readonly access to the
 	  One Time Programmable memory pages that are stored
@@ -39,6 +40,7 @@ config NVMEM_MXS_OCOTP
 config QCOM_QFPROM
 	tristate "QCOM QFPROM Support"
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on HAS_IOMEM
 	select REGMAP_MMIO
 	help
 	  Say y here to enable QFPROM support. The QFPROM provides access
@@ -50,6 +52,7 @@ config QCOM_QFPROM
 config ROCKCHIP_EFUSE
 	tristate "Rockchip eFuse Support"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This is a simple drive to dump specified values of Rockchip SoC
 	  from eFuse, such as cpu-leakage.
@@ -71,6 +74,7 @@ config NVMEM_SUNXI_SID
 config NVMEM_VF610_OCOTP
 	tristate "VF610 SoC OCOTP support"
 	depends on SOC_VF610 || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This is a driver for the 'OCOTP' peripheral available on Vybrid
 	  devices like VF5xx and VF6xx.
-- 
1.8.4.5


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

