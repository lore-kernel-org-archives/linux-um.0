Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgG7I-00088r-7E
 for linux-um@lists.infradead.org; Fri, 20 Nov 2020 23:47:01 +0000
Received: by mail-yb1-xb49.google.com with SMTP id o5so13753508ybe.12
 for <linux-um@lists.infradead.org>; Fri, 20 Nov 2020 15:46:57 -0800 (PST)
Date: Fri, 20 Nov 2020 15:46:48 -0800
Message-Id: <20201120234648.4050910-1-davidgow@google.com>
Mime-Version: 1.0
Subject: [PATCH v2] drivers: fpga: Specify HAS_IOMEM dependency for FPGA_DFL
From: David Gow <davidgow@google.com>
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
To: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, linux-fpga@vger.kernel.org, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Gow <davidgow@google.com>

Because dfl.c uses the 'devm_ioremap', 'devm_iounmap',
'devm_ioremap_resource', and 'devm_platform_ioremap_resource'
functions, it should depend on HAS_IOMEM.

This fixes make allyesconfig under UML (ARCH=um), which doesn't provide
HAS_IOMEM.

Fixes: 89eb35e810a8 ("fpga: dfl: map feature mmio resources in their own feature drivers")
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
( https://lore.kernel.org/linux-fpga/20201119082209.3598354-1-davidgow@google.com/ )
- Add Fixes tag

 drivers/fpga/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 7cd5a29fc437..5645226ca3ce 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -142,6 +142,7 @@ config FPGA_DFL
 	tristate "FPGA Device Feature List (DFL) support"
 	select FPGA_BRIDGE
 	select FPGA_REGION
+	depends on HAS_IOMEM
 	help
 	  Device Feature List (DFL) defines a feature list structure that
 	  creates a linked list of feature headers within the MMIO space
-- 
2.29.2.454.gaff20da3a2-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

