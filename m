Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 25 May 2017 09:42:35 -0600
Message-Id: <1495726955-27497-1-git-send-email-logang@deltatee.com>
Subject: [PATCH v2] um: add dummy ioremap and iounmap functions
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Cc: Logan Gunthorpe <logang@deltatee.com>, Stephen Bates <sbates@raithlin.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Al Viro <viro@ZenIV.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

The user mode architecture does not provide ioremap or iounmap, and
because of this, the arch won't build when the functions are used in some
core libraries.

I have designs to use these functions in scatterlist.c where they'd
almost certainly never be called on the um architecture but it does need
to compile. Thus, if the function is ever hit it returns NULL.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Stephen Bates <sbates@raithlin.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
---

Changes for v2:

* Per feedback from Al Viro, the ioremap function was changed to
  fail if it ever actually gets used.

 arch/um/include/asm/io.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 arch/um/include/asm/io.h

diff --git a/arch/um/include/asm/io.h b/arch/um/include/asm/io.h
new file mode 100644
index 0000000..f734673
--- /dev/null
+++ b/arch/um/include/asm/io.h
@@ -0,0 +1,17 @@
+#ifndef _ASM_UM_IO_H
+#define _ASM_UM_IO_H
+
+#define ioremap ioremap
+static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
+{
+	return NULL;
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

