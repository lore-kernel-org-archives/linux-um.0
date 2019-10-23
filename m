Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8QJ-0001n7-5n
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 04:39:08 +0000
Received: by mail-pl1-x644.google.com with SMTP id y8so940429plk.0
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 21:39:03 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 16/47] lkl tools: host lib: memory mapped I/O helpers
Date: Wed, 23 Oct 2019 13:37:50 +0900
Message-Id: <e96533a0d331dba6dd4a97f11b13d7d4c9f3cead.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
MIME-Version: 1.0
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
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>

From: Octavian Purdila <tavi.purdila@gmail.com>

This patch adds helpers for implementing the memory mapped I/O host
operations that can be used by code that implements host
devices. Generic host operations for lkl_ioremap and lkl_iomem_access
are provided that allows multiplexing multiple I/O memory mapped
regions.

The host device code can create a new memory mapped I/O region with
register_iomem(). Read and write access functions need to be provided
by the caller.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 tools/lkl/lib/iomem.c | 88 +++++++++++++++++++++++++++++++++++++++++++
 tools/lkl/lib/iomem.h | 15 ++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 tools/lkl/lib/iomem.c
 create mode 100644 tools/lkl/lib/iomem.h

diff --git a/tools/lkl/lib/iomem.c b/tools/lkl/lib/iomem.c
new file mode 100644
index 000000000000..2301fe4e5ad5
--- /dev/null
+++ b/tools/lkl/lib/iomem.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include <stdint.h>
+#include <lkl_host.h>
+
+#include "iomem.h"
+
+#define IOMEM_OFFSET_BITS		24
+#define MAX_IOMEM_REGIONS		256
+
+#define IOMEM_ADDR_TO_INDEX(addr) \
+	(((uintptr_t)addr) >> IOMEM_OFFSET_BITS)
+#define IOMEM_ADDR_TO_OFFSET(addr) \
+	(((uintptr_t)addr) & ((1 << IOMEM_OFFSET_BITS) - 1))
+#define IOMEM_INDEX_TO_ADDR(i) \
+	(void *)(uintptr_t)(i << IOMEM_OFFSET_BITS)
+
+static struct iomem_region {
+	void *data;
+	int size;
+	const struct lkl_iomem_ops *ops;
+} iomem_regions[MAX_IOMEM_REGIONS];
+
+void *register_iomem(void *data, int size, const struct lkl_iomem_ops *ops)
+{
+	int i;
+
+	if (size > (1 << IOMEM_OFFSET_BITS) - 1)
+		return NULL;
+
+	for (i = 1; i < MAX_IOMEM_REGIONS; i++)
+		if (!iomem_regions[i].ops)
+			break;
+
+	if (i >= MAX_IOMEM_REGIONS)
+		return NULL;
+
+	iomem_regions[i].data = data;
+	iomem_regions[i].size = size;
+	iomem_regions[i].ops = ops;
+	return IOMEM_INDEX_TO_ADDR(i);
+}
+
+void unregister_iomem(void *base)
+{
+	unsigned int index = IOMEM_ADDR_TO_INDEX(base);
+
+	if (index >= MAX_IOMEM_REGIONS) {
+		lkl_printf("%s: invalid iomem_addr %p\n", __func__, base);
+		return;
+	}
+
+	iomem_regions[index].size = 0;
+	iomem_regions[index].ops = NULL;
+}
+
+void *lkl_ioremap(long addr, int size)
+{
+	int index = IOMEM_ADDR_TO_INDEX(addr);
+	struct iomem_region *iomem = &iomem_regions[index];
+
+	if (index >= MAX_IOMEM_REGIONS)
+		return NULL;
+
+	if (iomem->ops && size <= iomem->size)
+		return IOMEM_INDEX_TO_ADDR(index);
+
+	return NULL;
+}
+
+int lkl_iomem_access(const volatile void *addr, void *res, int size, int write)
+{
+	int index = IOMEM_ADDR_TO_INDEX(addr);
+	struct iomem_region *iomem = &iomem_regions[index];
+	int offset = IOMEM_ADDR_TO_OFFSET(addr);
+	int ret;
+
+	if (index > MAX_IOMEM_REGIONS || !iomem_regions[index].ops ||
+	    offset + size > iomem_regions[index].size)
+		return -1;
+
+	if (write)
+		ret = iomem->ops->write(iomem->data, offset, res, size);
+	else
+		ret = iomem->ops->read(iomem->data, offset, res, size);
+
+	return ret;
+}
diff --git a/tools/lkl/lib/iomem.h b/tools/lkl/lib/iomem.h
new file mode 100644
index 000000000000..0ad80ccc2626
--- /dev/null
+++ b/tools/lkl/lib/iomem.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_LIB_IOMEM_H
+#define _LKL_LIB_IOMEM_H
+
+struct lkl_iomem_ops {
+	int (*read)(void *data, int offset, void *res, int size);
+	int (*write)(void *data, int offset, void *value, int size);
+};
+
+void *register_iomem(void *data, int size, const struct lkl_iomem_ops *ops);
+void unregister_iomem(void *iomem_base);
+void *lkl_ioremap(long addr, int size);
+int lkl_iomem_access(const volatile void *addr, void *res, int size, int write);
+
+#endif /* _LKL_LIB_IOMEM_H */
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

