Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 24 May 2017 16:00:52 -0600
Message-Id: <1495663252-22434-1-git-send-email-logang@deltatee.com>
Subject: [PATCH] um: add dummy ioremap and iounmap functions
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Cc: Logan Gunthorpe <logang@deltatee.com>, Stephen Bates <sbates@raithlin.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

The user mode architecture does not provide ioremap or iounmap, and
because of this, the arch won't build when the functions are used in some
core libraries.

I have designs to use these functions in scatterlist.c where they'd
almost certainly never be called on the um architecture but it does need
to compile.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Stephen Bates <sbates@raithlin.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/io.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 arch/um/include/asm/io.h

diff --git a/arch/um/include/asm/io.h b/arch/um/include/asm/io.h
new file mode 100644
index 0000000..8f35d57
--- /dev/null
+++ b/arch/um/include/asm/io.h
@@ -0,0 +1,17 @@
+#ifndef _ASM_UM_IO_H
+#define _ASM_UM_IO_H
+
+#define ioremap ioremap
+static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
+{
+	return (void __iomem *)(unsigned long)offset;
+}
+
+#define iounmap iounmap
+static inline void iounmap(void __iomem *addr)
+{
+}
+
+#include <asm-generic/io.h>
+
+#endif
-- 
2.1.4


