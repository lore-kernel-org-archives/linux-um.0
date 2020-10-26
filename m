Return-Path: <johannes@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: include compiler_attributes.h where used
Date: Mon, 26 Oct 2020 12:47:03 +0100
Message-Id: <20201026124702.874c23068ecc.I4c3cbf992dc2c038117a01c2cd9a4c406b89ec94@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Johannes Berg <johannes.berg@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Christopher Obbard <chris.obbard@collabora.com>
List-ID: <linux-um.lists.infradead.org>

From: Johannes Berg <johannes.berg@intel.com>

Joe's commit didn't only convert uses of __section(...) to add
the quotes, but _also_ converted 'raw' uses of __attribute__(())
for setting the section to use __section, but didn't update the
includes where necessary. Add them now.

Fixes: 33def8498fdd ("treewide: Convert macro and uses of __section(foo) to __section("foo")")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cause-identified-by: Christopher Obbard <chris.obbard@collabora.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/skas/clone.c | 1 +
 arch/x86/um/stub_segv.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index 95c355181dcd..dfd81d4d0f5f 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include <linux/compiler_attributes.h>
 #include <signal.h>
 #include <sched.h>
 #include <asm/unistd.h>
diff --git a/arch/x86/um/stub_segv.c b/arch/x86/um/stub_segv.c
index fdcd58af707a..95110ad4f313 100644
--- a/arch/x86/um/stub_segv.c
+++ b/arch/x86/um/stub_segv.c
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include <linux/compiler_attributes.h>
 #include <sysdep/stub.h>
 #include <sysdep/faultinfo.h>
 #include <sysdep/mcontext.h>
-- 
2.26.2


