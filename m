Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i19GU-0004qW-G0
 for linux-um@lists.infradead.org; Fri, 23 Aug 2019 13:06:03 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] arch: um: enable CONFIG_CONSTRUCTORS
Date: Fri, 23 Aug 2019 15:05:57 +0200
Message-Id: <20190823130557.15870-1-johannes@sipsolutions.net>
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
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

We do need to call the constructors for *modules*, even
if libc calls the ones for the kernel binary itself, so
allow enabling CONFIG_CONSTRUCTORS but skip the kernel.

Tested that it indeed doesn't work in modules, and does
work after the fixes in both, with a few functions with
__attribute__((constructor)) in both dynamic and static
builds.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 init/Kconfig        | 1 -
 init/main.c         | 2 +-
 kernel/gcov/Kconfig | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index bd7d650d4a99..81293d78a6ad 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -48,7 +48,6 @@ config CC_DISABLE_WARN_MAYBE_UNINITIALIZED
 
 config CONSTRUCTORS
 	bool
-	depends on !UML
 
 config IRQ_WORK
 	bool
diff --git a/init/main.c b/init/main.c
index 96f8d5af52d6..1e670be141c8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -788,7 +788,7 @@ asmlinkage __visible void __init start_kernel(void)
 /* Call all constructor functions linked into the kernel. */
 static void __init do_ctors(void)
 {
-#ifdef CONFIG_CONSTRUCTORS
+#if defined(CONFIG_CONSTRUCTORS) && !defined(CONFIG_UML)
 	ctor_fn_t *fn = (ctor_fn_t *) __ctors_start;
 
 	for (; fn < (ctor_fn_t *) __ctors_end; fn++)
diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 3941a9c48f83..060e8e726755 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -4,7 +4,7 @@ menu "GCOV-based kernel profiling"
 config GCOV_KERNEL
 	bool "Enable gcov-based kernel profiling"
 	depends on DEBUG_FS
-	select CONSTRUCTORS if !UML
+	select CONSTRUCTORS
 	default n
 	---help---
 	This option enables gcov-based code profiling (e.g. for code coverage
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

