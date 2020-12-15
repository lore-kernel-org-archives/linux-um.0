Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kp6sk-0004ZC-1S
 for linux-um@lists.infradead.org; Tue, 15 Dec 2020 09:44:35 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v6 2/4] um: enable the use of optimized xor routines in UML
Date: Tue, 15 Dec 2020 09:44:24 +0000
Message-Id: <20201215094426.1117-2-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20201215094426.1117-1-anton.ivanov@cambridgegreys.com>
References: <20201215094426.1117-1-anton.ivanov@cambridgegreys.com>
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

This patch enables the use of optimized xor routines from the x86
tree as well as the necessary fpu api shims so they can work on
UML.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/include/asm/fpu/api.h | 14 ++++++++++++++
 arch/um/include/asm/xor.h     | 17 ++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/include/asm/fpu/api.h

diff --git a/arch/um/include/asm/fpu/api.h b/arch/um/include/asm/fpu/api.h
new file mode 100644
index 000000000000..2873a6f0105d
--- /dev/null
+++ b/arch/um/include/asm/fpu/api.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ASM_UM_FPU_API_H
+#define _ASM_UM_FPU_API_H
+
+/* Copyright (c) 2020 Cambridge Greys Ltd
+ * Copyright (c) 2020 Red Hat Inc.
+ * A set of "dummy" defines to allow the direct inclusion
+ * of x86 optimized copy, xor, etc routines into the
+ * UML code tree. */
+
+#define kernel_fpu_begin() (void)0
+#define kernel_fpu_end() (void)0
+
+#endif
diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
index 36b33d62a35d..f512704a9ec7 100644
--- a/arch/um/include/asm/xor.h
+++ b/arch/um/include/asm/xor.h
@@ -1,7 +1,22 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include <asm-generic/xor.h>
+#ifndef _ASM_UM_XOR_H
+#define _ASM_UM_XOR_H
+
+#ifdef CONFIG_64BIT
+#undef CONFIG_X86_32
+#else
+#define CONFIG_X86_32 1
+#endif
+
+#include <asm/cpufeature.h>
+#include <../../x86/include/asm/xor.h>
 #include <linux/time-internal.h>
 
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+#undef XOR_SELECT_TEMPLATE
 /* pick an arbitrary one - measuring isn't possible with inf-cpu */
 #define XOR_SELECT_TEMPLATE(x)	\
 	(time_travel_mode == TT_MODE_INFCPU ? &xor_block_8regs : NULL)
+#endif
+
+#endif
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

