Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n3mOU-007PKe-2g
 for linux-um@lists.infradead.org; Sat, 01 Jan 2022 21:58:33 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/4] um: Run console exit code also upon kernel panic
Date: Sat,  1 Jan 2022 22:58:07 +0100
Message-Id: <20220101215810.13260-2-richard@nod.at>
In-Reply-To: <20220101215810.13260-1-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
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
Cc: linux-kernel@vger.kernel.org, johannes.berg@intel.com, anton.ivanov@cambridgegreys.com, Richard Weinberger <richard@nod.at>

Make sure that UML's console exit handler run also when the kernel
crashes.
That way settings and resources can get restored.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/stdio_console.c      |  4 ++--
 arch/um/include/shared/uml_console.h | 11 +++++++++++
 arch/um/kernel/um_arch.c             |  8 +++++---
 3 files changed, 18 insertions(+), 5 deletions(-)
 create mode 100644 arch/um/include/shared/uml_console.h

diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_console.c
index e8b762f4d8c2..06612c3b6240 100644
--- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -180,13 +180,13 @@ static int stdio_init(void)
 }
 late_initcall(stdio_init);
 
-static void console_exit(void)
+void uml_console_exit(void)
 {
 	if (!con_init_done)
 		return;
 	close_lines(vts, ARRAY_SIZE(vts));
 }
-__uml_exitcall(console_exit);
+__uml_exitcall(uml_console_exit);
 
 static int console_chan_setup(char *str)
 {
diff --git a/arch/um/include/shared/uml_console.h b/arch/um/include/shared/uml_console.h
new file mode 100644
index 000000000000..aa8d02fe5e90
--- /dev/null
+++ b/arch/um/include/shared/uml_console.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Richard Weinberger <richard@nod.at>
+ */
+
+#ifndef UML_CONSOLE_H
+#define UML_CONSOLE_H
+
+extern void uml_console_exit(void);
+
+#endif /* UML_CONSOLE_H */
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index abceeabe29b9..0bdae61929ef 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -17,17 +17,18 @@
 #include <linux/kmsg_dump.h>
 #include <linux/suspend.h>
 
-#include <asm/processor.h>
+#include <arch.h>
+#include <as-layout.h>
 #include <asm/cpufeature.h>
+#include <asm/processor.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
-#include <as-layout.h>
-#include <arch.h>
 #include <init.h>
 #include <kern.h>
 #include <kern_util.h>
 #include <mem_user.h>
 #include <os.h>
+#include <uml_console.h>
 
 #include "um_arch.h"
 
@@ -245,6 +246,7 @@ static int panic_exit(struct notifier_block *self, unsigned long unused1,
 	bust_spinlocks(1);
 	bust_spinlocks(0);
 	uml_exitcode = 1;
+	uml_console_exit();
 	os_dump_core();
 	return 0;
 }
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

