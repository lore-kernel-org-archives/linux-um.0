Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knmUn-0008G1-So
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 17:46:23 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v4 3/7] um: "borrow" atomics from x86 architecture
Date: Fri, 11 Dec 2020 17:45:55 +0000
Message-Id: <20201211174559.26010-4-anton.ivanov@cambridgegreys.com>
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

This moves UML on 64 bit from generic atomics to their x86
equivalents.

Generic atomics bracket most operations by interrupts off/interrupts
on. This is quite expensive on UML - it translates to changing
the signal mask and rerunning the signal loop every time.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/include/asm/atomic-x86.h  | 1 +
 arch/um/include/asm/atomic.h      | 7 +++++++
 arch/um/include/asm/atomic64_64.h | 1 +
 3 files changed, 9 insertions(+)
 create mode 120000 arch/um/include/asm/atomic-x86.h
 create mode 100644 arch/um/include/asm/atomic.h
 create mode 120000 arch/um/include/asm/atomic64_64.h

diff --git a/arch/um/include/asm/atomic-x86.h b/arch/um/include/asm/atomic-x86.h
new file mode 120000
index 000000000000..e71a389e112d
--- /dev/null
+++ b/arch/um/include/asm/atomic-x86.h
@@ -0,0 +1 @@
+../../../x86/include/asm/atomic.h
\ No newline at end of file
diff --git a/arch/um/include/asm/atomic.h b/arch/um/include/asm/atomic.h
new file mode 100644
index 000000000000..6ff22c587c10
--- /dev/null
+++ b/arch/um/include/asm/atomic.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ATOMIC_XOR_H
+#define _ASM_ATOMIC_XOR_H
+
+#include <asm/atomic-x86.h>
+
+#endif
diff --git a/arch/um/include/asm/atomic64_64.h b/arch/um/include/asm/atomic64_64.h
new file mode 120000
index 000000000000..f817a1478603
--- /dev/null
+++ b/arch/um/include/asm/atomic64_64.h
@@ -0,0 +1 @@
+../../../x86/include/asm/atomic64_64.h
\ No newline at end of file
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

