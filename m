Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgtBj-00Afoz-N6
 for linux-um@lists.infradead.org; Wed, 12 May 2021 18:02:29 +0000
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.11 13/35] um: Disable CONFIG_GCOV with MODULES
Date: Wed, 12 May 2021 14:01:43 -0400
Message-Id: <20210512180206.664536-13-sashal@kernel.org>
In-Reply-To: <20210512180206.664536-1-sashal@kernel.org>
References: <20210512180206.664536-1-sashal@kernel.org>
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
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>, Richard Weinberger <richard@nod.at>, Sasha Levin <sashal@kernel.org>, linux-um@lists.infradead.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit ad3d19911632debc886ef4a992d41d6de7927006 ]

CONFIG_GCOV doesn't work with modules, and for various reasons
it cannot work, see also
https://lore.kernel.org/r/d36ea54d8c0a8dd706826ba844a6f27691f45d55.camel@sipsolutions.net

Make CONFIG_GCOV depend on !MODULES to avoid anyone
running into issues there. This also means we need
not export the gcov symbols.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/Kconfig.debug      |  1 +
 arch/um/kernel/Makefile    |  1 -
 arch/um/kernel/gmon_syms.c | 16 ----------------
 3 files changed, 1 insertion(+), 17 deletions(-)
 delete mode 100644 arch/um/kernel/gmon_syms.c

diff --git a/arch/um/Kconfig.debug b/arch/um/Kconfig.debug
index 315d368e63ad..1dfb2959c73b 100644
--- a/arch/um/Kconfig.debug
+++ b/arch/um/Kconfig.debug
@@ -17,6 +17,7 @@ config GCOV
 	bool "Enable gcov support"
 	depends on DEBUG_INFO
 	depends on !KCOV
+	depends on !MODULES
 	help
 	  This option allows developers to retrieve coverage data from a UML
 	  session.
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 5aa882011e04..e698e0c7dbdc 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -21,7 +21,6 @@ obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
-obj-$(CONFIG_GCOV)	+= gmon_syms.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 
diff --git a/arch/um/kernel/gmon_syms.c b/arch/um/kernel/gmon_syms.c
deleted file mode 100644
index 9361a8eb9bf1..000000000000
--- a/arch/um/kernel/gmon_syms.c
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2001 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- */
-
-#include <linux/module.h>
-
-extern void __bb_init_func(void *)  __attribute__((weak));
-EXPORT_SYMBOL(__bb_init_func);
-
-extern void __gcov_init(void *)  __attribute__((weak));
-EXPORT_SYMBOL(__gcov_init);
-extern void __gcov_merge_add(void *, unsigned int)  __attribute__((weak));
-EXPORT_SYMBOL(__gcov_merge_add);
-extern void __gcov_exit(void)  __attribute__((weak));
-EXPORT_SYMBOL(__gcov_exit);
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

