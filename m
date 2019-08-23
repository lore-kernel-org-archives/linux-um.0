Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i19kO-0008Ok-1r
 for linux-um@lists.infradead.org; Fri, 23 Aug 2019 13:36:57 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] arch: um: enable CONFIG_CONSTRUCTORS
Date: Fri, 23 Aug 2019 15:36:50 +0200
Message-Id: <20190823133650.16986-1-johannes@sipsolutions.net>
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

We do need to call the constructors for *modules*, and
at least for KASAN in the future, we must call even the
kernel constructors only later when the kernel has been
initialized.

Instead of relying on libc to call them, emit an empty
section for libc and let the kernel's CONSTRUCTORS code
do the rest of the job.

Tested that it indeed doesn't work in modules, and does
work after the fixes in both, with a few functions with
__attribute__((constructor)) in both dynamic and static
builds.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/common.lds.S | 2 +-
 arch/um/kernel/dyn.lds.S         | 1 -
 init/Kconfig                     | 1 -
 kernel/gcov/Kconfig              | 2 +-
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index 4049f2c46387..d7086b985f27 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -83,8 +83,8 @@
 	__preinit_array_end = .;
   }
   .init_array : {
+        /* dummy - we call this ourselves */
 	__init_array_start = .;
-	*(.init_array)
 	__init_array_end = .;
   }
   .fini_array : {
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index f5001481010c..c69d69ee96be 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -103,7 +103,6 @@ SECTIONS
      be empty, which isn't pretty.  */
   . = ALIGN(32 / 8);
   .preinit_array     : { *(.preinit_array) }
-  .init_array     : { *(.init_array) }
   .fini_array     : { *(.fini_array) }
   .data           : {
     INIT_TASK_DATA(KERNEL_STACK_SIZE)
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

