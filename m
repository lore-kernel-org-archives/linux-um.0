Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1aNpZ8-00052Z-5u
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 22:24:54 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aNpZ7-00046R-Aj for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Jan 2016 22:24:54 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 25 Jan 2016 23:24:08 +0100
Message-Id: <1453760661-1444-10-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
Subject: [uml-devel] [PATCH 09/22] leds: Fix dependencies for !HAS_IOMEM
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
Cc: linux-leds@vger.kernel.org, Richard Weinberger <richard@nod.at>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, user-mode-linux-devel@lists.sourceforge.net

Not every arch has io memory.
So, unbreak the build by fixing the dependencies.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/leds/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 7f940c2..e76a45c 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -54,6 +54,7 @@ config LEDS_BCM6328
 	depends on LEDS_CLASS
 	depends on HAS_IOMEM
 	depends on OF
+	depends on HAS_IOMEM
 	help
 	  This option enables support for LEDs connected to the BCM6328
 	  LED HW controller accessed via MMIO registers.
@@ -63,6 +64,7 @@ config LEDS_BCM6358
 	depends on LEDS_CLASS
 	depends on HAS_IOMEM
 	depends on OF
+	depends on HAS_IOMEM
 	help
 	  This option enables support for LEDs connected to the BCM6358
 	  LED HW controller accessed via MMIO registers.
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

