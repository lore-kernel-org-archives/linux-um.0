Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knmUr-0008Hz-F7
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 17:46:26 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v4 5/7] um: "borrow" cmpxchg from x86 tree in UML
Date: Fri, 11 Dec 2020 17:45:57 +0000
Message-Id: <20201211174559.26010-6-anton.ivanov@cambridgegreys.com>
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

UML was falling back to asm-generic cmpxchg which emulates atomic
behaviour by turning irqs on/off. On UML this means turning
on/off signals for each cmpxchg which is expensive.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/include/asm/cmpxchg-x86.h | 1 +
 arch/um/include/asm/cmpxchg.h     | 7 +++++++
 arch/um/include/asm/cmpxchg_32.h  | 1 +
 arch/um/include/asm/cmpxchg_64.h  | 1 +
 4 files changed, 10 insertions(+)
 create mode 120000 arch/um/include/asm/cmpxchg-x86.h
 create mode 100644 arch/um/include/asm/cmpxchg.h
 create mode 120000 arch/um/include/asm/cmpxchg_32.h
 create mode 120000 arch/um/include/asm/cmpxchg_64.h

diff --git a/arch/um/include/asm/cmpxchg-x86.h b/arch/um/include/asm/cmpxchg-x86.h
new file mode 120000
index 000000000000..a5c607edde88
--- /dev/null
+++ b/arch/um/include/asm/cmpxchg-x86.h
@@ -0,0 +1 @@
+../../../x86/include/asm/cmpxchg.h
\ No newline at end of file
diff --git a/arch/um/include/asm/cmpxchg.h b/arch/um/include/asm/cmpxchg.h
new file mode 100644
index 000000000000..03e7a669eeef
--- /dev/null
+++ b/arch/um/include/asm/cmpxchg.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UM_CMPXCHG_H
+#define _ASM_UM_CMPXCHG_H
+
+#include <asm/cmpxchg-x86.h>
+
+#endif
diff --git a/arch/um/include/asm/cmpxchg_32.h b/arch/um/include/asm/cmpxchg_32.h
new file mode 120000
index 000000000000..1f360d0a9fa9
--- /dev/null
+++ b/arch/um/include/asm/cmpxchg_32.h
@@ -0,0 +1 @@
+../../../x86/include/asm/cmpxchg_32.h
\ No newline at end of file
diff --git a/arch/um/include/asm/cmpxchg_64.h b/arch/um/include/asm/cmpxchg_64.h
new file mode 120000
index 000000000000..bc09ae22b0cb
--- /dev/null
+++ b/arch/um/include/asm/cmpxchg_64.h
@@ -0,0 +1 @@
+../../../x86/include/asm/cmpxchg_64.h
\ No newline at end of file
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

