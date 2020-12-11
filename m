Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knmUu-0008JG-MF
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 17:46:29 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v4 7/7] um: borrow bitops from the x86 tree
Date: Fri, 11 Dec 2020 17:45:59 +0000
Message-Id: <20201211174559.26010-8-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
References: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
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
 arch/um/include/asm/bitops-x86.h | 1 +
 arch/um/include/asm/bitops.h     | 7 +++++++
 2 files changed, 8 insertions(+)
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
index 000000000000..a0cd978c6aaa
--- /dev/null
+++ b/arch/um/include/asm/bitops.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UM_BITOPS_H
+#define _ASM_UM_BITOPS_H
+
+#include <asm/bitops-x86.h>
+
+#endif
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

