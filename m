Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x74a.google.com ([2607:f8b0:4864:20::74a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxl5x-0005Iz-8k
 for linux-um@lists.infradead.org; Tue, 21 Jul 2020 05:45:42 +0000
Received: by mail-qk1-x74a.google.com with SMTP id k16so13034246qkh.12
 for <linux-um@lists.infradead.org>; Mon, 20 Jul 2020 22:45:38 -0700 (PDT)
Date: Mon, 20 Jul 2020 22:45:28 -0700
Message-Id: <20200721054528.2556267-1-davidgow@google.com>
Mime-Version: 1.0
Subject: [RFC PATCH] platform: ioremap: Build iomap functions even without
 HAS_IOMEM
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeff Dike <jdike@addtoit.com>, rafael@kernel.org, Logan Gunthorpe <logang@deltatee.com>, Richard Weinberger <richard@nod.at>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-um <linux-um@lists.infradead.org>, Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>, kunit-dev@googlegroups.com

A number of drivers use devm_platform_ioremap_resource(), but do not (or
did not) explicitly depend on IOMEM[1,2]. Given that the only platform
without HAS_IOMEM seems to be UML, and it has sufficient stubs for
devm_platform_ioremap_resource() and its dependencies to build, we can
remove the HAS_IOMEM requirement here, rather than playing whack-a-mole
with different drivers which don't try to build against ARCH=um.

The reason this works at the moment is that stub ioremap and iounmap
functions were added to UML to support this sort-of thing[3]. This
particular change doesn't require adding any additional stubs, but there
is possibly room in the future to stub out the remaining iomem functions
(or to provide mock implementations for testing), and get rid of
HAS_IOMEM entirely.

[1]: https://lkml.org/lkml/2020/6/30/176
[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1e7468bd9d30a21e059af477106dc5588ae52dff
[3]:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1405627.html

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/base/platform.c | 2 --
 lib/Makefile            | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index c0d0a5490ac6..628dde6675cf 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -61,7 +61,6 @@ struct resource *platform_get_resource(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
-#ifdef CONFIG_HAS_IOMEM
 /**
  * devm_platform_get_and_ioremap_resource - call devm_ioremap_resource() for a
  *					    platform device and get resource
@@ -135,7 +134,6 @@ devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 	return devm_ioremap_resource(&pdev->dev, res);
 }
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
-#endif /* CONFIG_HAS_IOMEM */
 
 /**
  * platform_get_irq_optional - get an optional IRQ for a device
diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b..35c21af33b93 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -115,7 +115,7 @@ obj-y += math/ crypto/
 
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_GENERIC_PCI_IOMAP) += pci_iomap.o
-obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
+obj-y += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

