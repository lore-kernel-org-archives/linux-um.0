Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKeW5-00B5To-Rl
 for linux-um@lists.infradead.org; Fri, 12 Mar 2021 09:55:44 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 4/6] um: split up CONFIG_GCOV
Date: Fri, 12 Mar 2021 10:55:24 +0100
Message-Id: <20210312104627.927fb4c7d36f.Idb980393c41c2129ee592de4ed71e7a5518212f9@changeid>
In-Reply-To: <20210312095526.197739-1-johannes@sipsolutions.net>
References: <20210312095526.197739-1-johannes@sipsolutions.net>
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
To: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc: Jessica Yu <jeyu@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

It's not always desirable to collect coverage data for the
entire kernel, so split off CONFIG_GCOV_BASE. This option
only enables linking with coverage options, and compiles a
single file (reboot.c) with them as well to force gcov to
be linked into the kernel binary. That way, modules also
work.

To use this new option properly, one needs to manually add
'-fprofile-arcs -ftest-coverage' to the compiler options
of some object(s) or subdir(s) to collect coverage data at
the desired places.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig.debug   | 38 ++++++++++++++++++++++++++++++--------
 arch/um/Makefile-skas   |  2 +-
 arch/um/kernel/Makefile | 11 ++++++++++-
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/arch/um/Kconfig.debug b/arch/um/Kconfig.debug
index 315d368e63ad..ca040b4e86e5 100644
--- a/arch/um/Kconfig.debug
+++ b/arch/um/Kconfig.debug
@@ -13,19 +13,41 @@ config GPROF
 	  If you're involved in UML kernel development and want to use gprof,
 	  say Y.  If you're unsure, say N.
 
-config GCOV
-	bool "Enable gcov support"
+config GCOV_BASE
+	bool "Enable gcov support (selectively)"
 	depends on DEBUG_INFO
-	depends on !KCOV
+	depends on !KCOV && !GCOV_KERNEL
 	help
 	  This option allows developers to retrieve coverage data from a UML
-	  session.
+	  session, stored to disk just like with a regular userspace binary,
+	  use the same tools (gcov, lcov, ...) to collect and process the
+	  data.
 
-	  See <http://user-mode-linux.sourceforge.net/old/gprof.html> for more
-	  details.
+	  See also KCOV and GCOV_KERNEL as alternatives.
 
-	  If you're involved in UML kernel development and want to use gcov,
-	  say Y.  If you're unsure, say N.
+	  This option (almost) only links with the needed support code, but
+	  doesn't enable coverage data collection for any code (other than a
+	  dummy file to get everything linked properly). See also the GCOV
+	  option which enables coverage collection for the entire kernel and
+	  all modules.
+
+	  If you're using UML to test something and want to manually instruct
+	  the compiler to instrument only parts of the code by adding the
+	  relevant options for the objects you care about, say Y and do that
+	  to get coverage collection only for the parts you need.
+
+	  If you're unsure, say N.
+
+config GCOV
+	bool "Enable gcov support (whole kernel)"
+	depends on DEBUG_INFO
+	depends on !KCOV && !GCOV_KERNEL
+	select GCOV_BASE
+	help
+	  This enables coverage data collection for the entire kernel and
+	  all modules, see the GCOV_BASE option for more information.
+
+	  If you're unsure, say N.
 
 config EARLY_PRINTK
 	bool "Early printk"
diff --git a/arch/um/Makefile-skas b/arch/um/Makefile-skas
index ac35de5316a6..b5be5f55ac11 100644
--- a/arch/um/Makefile-skas
+++ b/arch/um/Makefile-skas
@@ -8,5 +8,5 @@ GCOV_OPT += -fprofile-arcs -ftest-coverage
 
 CFLAGS-$(CONFIG_GCOV) += $(GCOV_OPT)
 CFLAGS-$(CONFIG_GPROF) += $(GPROF_OPT)
-LINK-$(CONFIG_GCOV) += $(GCOV_OPT)
+LINK-$(CONFIG_GCOV_BASE) += $(GCOV_OPT)
 LINK-$(CONFIG_GPROF) += $(GPROF_OPT)
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index c1205f9ec17e..0403e329f931 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -21,7 +21,7 @@ obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
-obj-$(CONFIG_GCOV)	+= gmon_syms.o
+obj-$(CONFIG_GCOV_BASE)	+= gmon_syms.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
@@ -32,6 +32,15 @@ include arch/um/scripts/Makefile.rules
 
 targets := config.c config.tmp
 
+# This just causes _something_ to be compiled with coverage
+# collection so that gcov is linked into the binary, in case
+# the only thing that has it enabled is a module, when only
+# CONFIG_GCOV_BASE is selected. Yes, we thus always get some
+# coverage data for this file, but it's not hit often ...
+ifeq ($(CONFIG_GCOV_BASE),y)
+CFLAGS_reboot.o += -fprofile-arcs -ftest-coverage
+endif
+
 # Be careful with the below Sed code - sed is pitfall-rich!
 # We use sed to lower build requirements, for "embedded" builders for instance.
 
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

