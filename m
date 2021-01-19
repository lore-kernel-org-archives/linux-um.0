Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1p2P-00039V-L5
 for linux-um@lists.infradead.org; Tue, 19 Jan 2021 11:19:06 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] init/module: split CONFIG_CONSTRUCTORS to fix module gcov on
 UML
Date: Tue, 19 Jan 2021 12:18:53 +0100
Message-Id: <20210119121853.4e22b2506c9a.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Johannes Berg <johannes.berg@intel.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

On ARCH=um, loading a module doesn't result in its constructors
getting called, which breaks module gcov since the debugfs files
are never registered. On the other hand, in-kernel constructors
have already been called by the dynamic linker, so we can't call
them again.

Get out of this conundrum by splitting CONFIG_CONSTRUCTORS into
CONFIG_CONSTRUCTORS_KERNEL and CONFIG_CONSTRUCTORS_MODULE, both
of which are enabled by default if CONFIG_CONSTRUCTORS is turned
on, but CONFIG_CONSTRUCTORS_KERNEL depends on !UML so that it's
not used on ARCH=um.

Also remove the "if !UML" from GCOV selecting CONSTRUCTORS now,
since we really do want CONSTRUCTORS, just not kernel binary
ones.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Tested with a kernel configured with CONFIG_GCOV_KERNEL, without
the patch nothing ever appears in /sys/kernel/debug/gcov/ (apart
from the reset file), and with it we get the files and they work.

I have no idea which tree this might go through, any suggestions?
---
 include/asm-generic/vmlinux.lds.h | 6 +++---
 include/linux/module.h            | 2 +-
 init/Kconfig                      | 9 ++++++++-
 init/main.c                       | 2 +-
 kernel/gcov/Kconfig               | 2 +-
 kernel/module.c                   | 4 ++--
 6 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2b3d81b1535..87b300471c54 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -698,7 +698,7 @@
 		INIT_TASK_DATA(align)					\
 	}
 
-#ifdef CONFIG_CONSTRUCTORS
+#ifdef CONFIG_CONSTRUCTORS_KERNEL
 #define KERNEL_CTORS()	. = ALIGN(8);			   \
 			__ctors_start = .;		   \
 			KEEP(*(SORT(.ctors.*)))		   \
@@ -990,11 +990,11 @@
 /*
  * Clang's -fsanitize=kernel-address and -fsanitize=thread produce
  * unwanted sections (.eh_frame and .init_array.*), but
- * CONFIG_CONSTRUCTORS wants to keep any .init_array.* sections.
+ * CONFIG_CONSTRUCTORS_KERNEL wants to keep any .init_array.* sections.
  * https://bugs.llvm.org/show_bug.cgi?id=46478
  */
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
-# ifdef CONFIG_CONSTRUCTORS
+# ifdef CONFIG_CONSTRUCTORS_KERNEL
 #  define SANITIZER_DISCARDS						\
 	*(.eh_frame)
 # else
diff --git a/include/linux/module.h b/include/linux/module.h
index 7a0bcb5b1ffc..027cfdbd84bd 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -528,7 +528,7 @@ struct module {
 	atomic_t refcnt;
 #endif
 
-#ifdef CONFIG_CONSTRUCTORS
+#ifdef CONFIG_CONSTRUCTORS_MODULE
 	/* Constructor functions. */
 	ctor_fn_t *ctors;
 	unsigned int num_ctors;
diff --git a/init/Kconfig b/init/Kconfig
index b77c60f8b963..e409de8d6c17 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -76,7 +76,14 @@ config CC_HAS_ASM_INLINE
 
 config CONSTRUCTORS
 	bool
-	depends on !UML
+
+config CONSTRUCTORS_KERNEL
+	def_bool y
+	depends on CONSTRUCTORS && !UML
+
+config CONSTRUCTORS_MODULE
+	def_bool y
+	depends on CONSTRUCTORS
 
 config IRQ_WORK
 	bool
diff --git a/init/main.c b/init/main.c
index c68d784376ca..51eb4802511c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1066,7 +1066,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 /* Call all constructor functions linked into the kernel. */
 static void __init do_ctors(void)
 {
-#ifdef CONFIG_CONSTRUCTORS
+#ifdef CONFIG_CONSTRUCTORS_KERNEL
 	ctor_fn_t *fn = (ctor_fn_t *) __ctors_start;
 
 	for (; fn < (ctor_fn_t *) __ctors_end; fn++)
diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 3110c77230c7..f62de2dea8a3 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -4,7 +4,7 @@ menu "GCOV-based kernel profiling"
 config GCOV_KERNEL
 	bool "Enable gcov-based kernel profiling"
 	depends on DEBUG_FS
-	select CONSTRUCTORS if !UML
+	select CONSTRUCTORS
 	default n
 	help
 	This option enables gcov-based code profiling (e.g. for code coverage
diff --git a/kernel/module.c b/kernel/module.c
index 4bf30e4b3eaa..c161a360d929 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3257,7 +3257,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					    &mod->num_unused_gpl_syms);
 	mod->unused_gpl_crcs = section_addr(info, "__kcrctab_unused_gpl");
 #endif
-#ifdef CONFIG_CONSTRUCTORS
+#ifdef CONFIG_CONSTRUCTORS_MODULE
 	mod->ctors = section_objs(info, ".ctors",
 				  sizeof(*mod->ctors), &mod->num_ctors);
 	if (!mod->ctors)
@@ -3612,7 +3612,7 @@ static bool finished_loading(const char *name)
 /* Call module constructors. */
 static void do_mod_ctors(struct module *mod)
 {
-#ifdef CONFIG_CONSTRUCTORS
+#ifdef CONFIG_CONSTRUCTORS_MODULE
 	unsigned long i;
 
 	for (i = 0; i < mod->num_ctors; i++)
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

