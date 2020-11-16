Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefk9-0001dV-Sx
 for linux-um@lists.infradead.org; Mon, 16 Nov 2020 14:44:34 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: borrow bitops from the x86 tree
Date: Mon, 16 Nov 2020 14:44:26 +0000
Message-Id: <20201116144426.8415-1-anton.ivanov@cambridgegreys.com>
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
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Using x86 bitops instead of the asm-generic allows to squeeze
a couple of percents improvement on fs IO in UML. It should
improve other areas as well.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/include/asm/bitops-x86.h |  1 +
 arch/um/include/asm/bitops.h     | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 120000 arch/um/include/asm/bitops-x86.h
 create mode 100644 arch/um/include/asm/bitops.h

diff --git a/arch/um/include/asm/bitops-x86.h b/arch/um/include/asm/bitops-x86.h
new file mode 120000
index 000000000000..15a96ff554b2
--- /dev/null
+++ b/arch/um/include/asm/bitops-x86.h
@@ -0,0 +1 @@
+../../../x86/include/asm/bitops.h
\ No newline at end of file
diff --git a/arch/um/include/asm/bitops.h b/arch/um/include/asm/bitops.h
new file mode 100644
index 000000000000..e578c628a6d5
--- /dev/null
+++ b/arch/um/include/asm/bitops.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UM_BITOPS_H
+#define _ASM_UM_BITOPS_H
+
+#ifdef CONFIG_64BIT
+
+#undef CONFIG_X86_32
+
+#ifndef CONFIG_X86_64
+#define CONFIG_X86_64
+#endif
+
+#else
+#define CONFIG_X86_32
+#endif
+
+#include <asm/bitops-x86.h>
+
+
+#endif
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

