Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwEDs-0007ki-Su
 for linux-um@lists.infradead.org; Mon, 27 Jan 2020 23:55:18 +0000
Received: by mail-pf1-x449.google.com with SMTP id k26so7459595pfp.20
 for <linux-um@lists.infradead.org>; Mon, 27 Jan 2020 15:55:15 -0800 (PST)
Date: Mon, 27 Jan 2020 15:53:56 -0800
In-Reply-To: <20200127235356.122031-1-brendanhiggins@google.com>
Message-Id: <20200127235356.122031-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200127235356.122031-1-brendanhiggins@google.com>
Subject: [PATCH v1 5/5] power: avs: qcom-cpr: add unspecified HAS_IOMEM
 dependency
From: Brendan Higgins <brendanhiggins@google.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, linux-um@lists.infradead.org, heidifahim@google.com, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, davidgow@google.com

Currently CONFIG_QCOM_CPR=y implicitly depends on CONFIG_HAS_IOMEM=y;
consequently, on architectures without IOMEM we get the following build
error:

/usr/bin/ld: drivers/power/avs/qcom-cpr.o: in function `cpr_probe':
drivers/power/avs/qcom-cpr.c:1690: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/power/avs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index b8fe166cd0d9f..cdb4237bfd02e 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -14,7 +14,7 @@ menuconfig POWER_AVS
 
 config QCOM_CPR
 	tristate "QCOM Core Power Reduction (CPR) support"
-	depends on POWER_AVS
+	depends on POWER_AVS && HAS_IOMEM
 	select PM_OPP
 	select REGMAP
 	help
-- 
2.25.0.341.g760bfbb309-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

