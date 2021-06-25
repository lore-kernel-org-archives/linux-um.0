Return-Path: <dmaengine-owner@vger.kernel.org>
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] dmaengine: idxd: depends on !UML
Date: Fri, 25 Jun 2021 10:38:10 +0200
Message-Id: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: dmaengine@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>, kernel test robot <lkp@intel.com>
List-ID: <linux-um.lists.infradead.org>

From: Johannes Berg <johannes.berg@intel.com>

Now that UML has PCI support, this driver must depend also on
!UML since it pokes at X86_64 architecture internals that don't
exist on ARCH=um.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6ab9d9a488a6..1f3c0e2ea4d9 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -278,7 +278,7 @@ config INTEL_IDMA64
 
 config INTEL_IDXD
 	tristate "Intel Data Accelerators support"
-	depends on PCI && X86_64
+	depends on PCI && X86_64 && !UML
 	depends on PCI_MSI
 	depends on SBITMAP
 	select DMA_ENGINE
-- 
2.31.1


