Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1aNpYv-00077O-SP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 22:24:41 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aNpYu-00045x-Bn for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 22:24:41 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 25 Jan 2016 23:23:59 +0100
Message-Id: <1453760661-1444-1-git-send-email-richard@nod.at>
Subject: [uml-devel] (no subject)
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
Cc: user-mode-linux-devel@lists.sourceforge.net

Last few months I was very busy and now I have the mess,
UML allmod/yesconfig does not build at all.
This large and boring patch series fixes a lot of drivers which
cannot work/build on UML.
Fixes are grouped by subsystem such that maintainers can review/pickup them.

Thanks,
//richard

[PATCH 01/22] power: reset: Fix dependencies for !HAS_IOMEM archs
[PATCH 02/22] phy: Fix dependencies for !HAS_IOMEM archs
[PATCH 03/22] scsi: Fix dependencies for !HAS_IOMEM and !HAS_DMA
[PATCH 04/22] staging: iio: Fix dependencies for !HAS_IOMEM archs
[PATCH 05/22] hw_random: Fix dependencies for !HAS_IOMEM archs
[PATCH 06/22] iio: adc: Fix dependencies for !HAS_IOMEM archs
[PATCH 07/22] fpga: Fix dependencies for !HAS_IOMEM archs
[PATCH 08/22] hwtracing: Fix dependencies for !HAS_IOMEM archs
[PATCH 09/22] leds: Fix dependencies for !HAS_IOMEM archs
[PATCH 10/22] mailbox: Fix dependencies for !HAS_IOMEM archs
[PATCH 11/22] mtd: Fix dependencies for !HAS_IOMEM archs
[PATCH 12/22] nvmem: Fix dependencies for !HAS_IOMEM archs
[PATCH 13/22] net: Fix dependencies for !HAS_IOMEM archs
[PATCH 14/22] pwm: Fix dependencies for !HAS_IOMEM archs
[PATCH 15/22] watchdog: Fix dependencies for !HAS_IOMEM archs
[PATCH 16/22] iio: imu: Fix dependencies for !HAS_IOMEM archs
[PATCH 17/22] media: Fix dependencies for !HAS_IOMEM archs
[PATCH 18/22] irqchip: Fix dependencies for !HAS_IOMEM archs
[PATCH 19/22] thermal: Fix dependencies for !HAS_IOMEM archs
[PATCH 20/22] clocksource: Fix dependencies for !HAS_IOMEM archs
[PATCH 21/22] mtd: cs553x: Fix dependencies for !HAS_IOMEM archs
[PATCH 22/22] um: Export pm_power_off

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

