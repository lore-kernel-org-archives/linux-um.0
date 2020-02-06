Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izn0p-00011H-8u
 for linux-um@lists.infradead.org; Thu, 06 Feb 2020 19:40:32 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC PATCH] um: implement CONFIG_CONSTRUCTORS for modules
Date: Thu,  6 Feb 2020 20:40:19 +0100
Message-Id: <20200206204018.98f745aed1a1.I986f68ddedf1cb4ef59abf4fbcb5931ce99bc2e8@changeid>
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
Cc: Johannes Berg <johannes.berg@intel.com>, Patricia Alfonso <trishalfonso@google.com>

From: Johannes Berg <johannes.berg@intel.com>

My previous attempt at implementing CONFIG_CONSTRUCTORS failed,
in part because it was badly done, but also because we just need
the gcc/libc constructors to run really early for what is really
a relatively normal userspace program. For some more details, see
commit 87c9366e1725 ("Revert "um: Enable CONFIG_CONSTRUCTORS"").

On the other hand, we *do* need constructors for modules, if we
want GCOV_KERNEL (and eventually KASAN) to work there, since the
constructors that gcc emits will need to be run.

So here's another attempt to implement CONFIG_CONSTRUCTORS: don't
touch the ones in the main binary, and don't do anything in the
main init code (do_ctors()), but still allow enabling the symbol
and associated code for modules.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 init/Kconfig        | 1 -
 init/main.c         | 8 ++++++--
 kernel/gcov/Kconfig | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 47d40f399000..a34064a031a5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -54,7 +54,6 @@ config CC_DISABLE_WARN_MAYBE_UNINITIALIZED
 
 config CONSTRUCTORS
 	bool
-	depends on !UML
 
 config IRQ_WORK
 	bool
diff --git a/init/main.c b/init/main.c
index 2cd736059416..194d896ad651 100644
--- a/init/main.c
+++ b/init/main.c
@@ -784,10 +784,14 @@ asmlinkage __visible void __init start_kernel(void)
 	arch_call_rest_init();
 }
 
-/* Call all constructor functions linked into the kernel. */
+/*
+ * Call all constructor functions linked into the kernel, except for
+ * UML since that is a "normal" userspace program where they will be
+ * called automatically even before main().
+ */
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
2.24.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

