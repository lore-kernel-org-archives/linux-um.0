Return-Path: <johannes@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] PCI: vmd: depend on !UML
Date: Wed, 11 Aug 2021 16:25:30 +0200
Message-Id: <20210811162530.affe26231bc3.I131b3c1e67e3d2ead6e98addd256c835fbef9a3e@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-pci@vger.kernel.org
Cc: Jonathan Derrick <jonathan.derrick@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-um@lists.infradead.org, Randy Dunlap <rdunlap@infradead.org>, Johannes Berg <johannes.berg@intel.com>
List-ID: <linux-um.lists.infradead.org>

From: Johannes Berg <johannes.berg@intel.com>

With UML having enabled (simulated) PCI on UML, VMD breaks
allyesconfig/allmodconfig compilation because it assumes
it's running on X86_64 bare metal, and has hardcoded API
use of ARCH=x86. Make it depend on !UML to fix this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 64e2f5e379aa..297bbd86806a 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -257,7 +257,7 @@ config PCIE_TANGO_SMP8759
 	  config and MMIO accesses.
 
 config VMD
-	depends on PCI_MSI && X86_64 && SRCU
+	depends on PCI_MSI && X86_64 && SRCU && !UML
 	tristate "Intel Volume Management Device Driver"
 	help
 	  Adds support for the Intel Volume Management Device (VMD). VMD is a
-- 
2.31.1


