Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] um: Fix CONFIG_GCOV for modules.
Date: Sun, 13 Aug 2017 14:51:12 +0200
Message-Id: <20170813125112.15375-1-thomas@m3y3r.de>
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Thomas Meyer <thomas@m3y3r.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Explicitly export symbols so modpost doesn't complain.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/kernel/gmon_syms.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/um/kernel/gmon_syms.c b/arch/um/kernel/gmon_syms.c
index 1bf61266da8e..f138a4a0db99 100644
--- a/arch/um/kernel/gmon_syms.c
+++ b/arch/um/kernel/gmon_syms.c
@@ -7,3 +7,10 @@
 
 extern void __bb_init_func(void *)  __attribute__((weak));
 EXPORT_SYMBOL(__bb_init_func);
+
+extern void __gcov_init(void *)  __attribute__((weak));
+EXPORT_SYMBOL(__gcov_init);
+extern void __gcov_merge_add(void *, unsigned int)  __attribute__((weak));
+EXPORT_SYMBOL(__gcov_merge_add);
+extern void __gcov_exit(void)  __attribute__((weak));
+EXPORT_SYMBOL(__gcov_exit);
-- 
2.13.4


