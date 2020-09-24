Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLLTx-0003hK-9S
 for linux-um@lists.infradead.org; Thu, 24 Sep 2020 07:15:58 +0000
Received: by mail-pg1-x543.google.com with SMTP id 5so1354795pgf.5
 for <linux-um@lists.infradead.org>; Thu, 24 Sep 2020 00:15:57 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v6 16/21] um: nommu: plug in the build system
Date: Thu, 24 Sep 2020 16:12:56 +0900
Message-Id: <8e8af2d046852b7ddedf36e36e522261ebd2350e.1600922529.git.thehajime@gmail.com>
In-Reply-To: <cover.1600922528.git.thehajime@gmail.com>
References: <cover.1600922528.git.thehajime@gmail.com>
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
To: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>, retrage01@gmail.com

Basic Makefiles for building library of nommu mode. Add a new architecture
specific target for installing the resulting library files and headers.

To make nommu binaries build, UML introduced an additional option, UMMODE
variable, to switch the output file of build: kernel (default), or
library (nommu).  Those modes are not able to be ON at the same time.

To build on library mode, users do the following:

  make defconfig ARCH=um UMMODE=library
  make ARCH=um UMMODE=library

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/Kconfig           | 17 ++++++++++++++---
 arch/um/Makefile          | 10 +++++++++-
 arch/um/kernel/Makefile   | 12 ++++++++----
 arch/um/nommu/um/Kconfig  | 37 +++++++++++++++++++++++++++++++++++++
 arch/um/nommu/um/Makefile |  4 ++++
 5 files changed, 72 insertions(+), 8 deletions(-)
 create mode 100644 arch/um/nommu/um/Kconfig
 create mode 100644 arch/um/nommu/um/Makefile

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index e41d31d0d875..df7daceb095c 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -22,9 +22,20 @@ config UML
 	select TTY # Needed for line.c
 	select MODULE_REL_CRCS if MODVERSIONS
 
+config UMMODE_LIB
+	bool "UML mode: library mode"
+	default y if "$(UMMODE)" = "library"
+	help
+	 This mode switches a mode to build a library of UML (Linux
+	 Kernel Library/LKL).  This switch is exclusive to "kernel mode"
+	 of UML, which is traditional mode of UML.
+
+	 For more detail about LKL, see
+	 <file:Documentation/virt/uml/lkl.txt>.
+
 config MMU
 	bool
-	default y
+	default y if !UMMODE_LIB
 
 config NO_IOMEM
 	def_bool y
@@ -45,12 +56,12 @@ config LOCKDEP_SUPPORT
 
 config STACKTRACE_SUPPORT
 	bool
-	default y
+	default y if MMU
 	select STACKTRACE
 
 config GENERIC_CALIBRATE_DELAY
 	bool
-	default y
+	default y if MMU
 
 config HZ
 	int
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 1f958a9280fe..73d3ac061b77 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -17,6 +17,10 @@ else
         KBUILD_DEFCONFIG := $(SUBARCH)_defconfig
 endif
 
+ifeq ($(UMMODE),library)
+  SUBARCH := um/nommu
+endif
+
 ARCH_DIR := arch/um
 OS := $(shell uname -s)
 # We require bash because the vmlinux link and loader script cpp use bash
@@ -102,9 +106,13 @@ all: linux.o
 
 linux.o: vmlinux
 	@echo '  LINK $@'
-	$(Q)$(OBJCOPY) -R .eh_frame $< $@
+	$(Q)$(OBJCOPY) -R .eh_frame -L sem_init -L sem_post -L sem_wait -L sem_destroy $< $@
 
+ifeq ($(UMMODE),library)
+install: linux.o um_headers_install
+else
 install: linux.o
+endif
 	@echo "  INSTALL $(INSTALL_PATH)/lib/$<"
 	@mkdir -p $(INSTALL_PATH)/lib/
 	@cp $< $(INSTALL_PATH)/lib/
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 5aa882011e04..bdc4108bc52e 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -14,10 +14,14 @@ CPPFLAGS_vmlinux.lds := -DSTART=$(LDS_START)		\
 			$(LDS_EXTRA)
 extra-y := vmlinux.lds
 
-obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
-	physmem.o process.o ptrace.o reboot.o sigio.o \
-	signal.o syscall.o sysrq.o time.o tlb.o trap.o \
-	um_arch.o umid.o maccess.o kmsg_dump.o skas/
+obj-y = config.o exitcode.o irq.o ksyms.o \
+	process.o reboot.o sigio.o \
+	signal.o syscall.o time.o \
+	um_arch.o umid.o maccess.o kmsg_dump.o
+
+ifdef CONFIG_MMU
+obj-y += exec.o mem.o physmem.o ptrace.o sysrq.o tlb.o trap.o skas/
+endif
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
diff --git a/arch/um/nommu/um/Kconfig b/arch/um/nommu/um/Kconfig
new file mode 100644
index 000000000000..20b3eaccb6f0
--- /dev/null
+++ b/arch/um/nommu/um/Kconfig
@@ -0,0 +1,37 @@
+config UML_NOMMU
+	def_bool y
+	depends on !SMP && !MMU
+	select UACCESS_MEMCPY
+	select ARCH_THREAD_STACK_ALLOCATOR
+	select ARCH_HAS_SYSCALL_WRAPPER
+
+config 64BIT
+	bool
+	default y
+
+config GENERIC_CSUM
+	def_bool y
+
+config GENERIC_ATOMIC64
+	bool
+	default y if !64BIT
+
+config SECCOMP
+	bool
+	default n
+
+config GENERIC_HWEIGHT
+	def_bool y
+
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default n
+
+config STACKTRACE_SUPPORT
+	bool
+	default n
+
+# XXX: need this to work well with tap13.py
+config PRINTK_TIME
+	bool
+	default y
diff --git a/arch/um/nommu/um/Makefile b/arch/um/nommu/um/Makefile
new file mode 100644
index 000000000000..b580e0fe97b5
--- /dev/null
+++ b/arch/um/nommu/um/Makefile
@@ -0,0 +1,4 @@
+include/generated/user_constants.h: $(srctree)/arch/um/nommu/um/user_constants.h
+	$(Q)cp -f $^ $@
+
+obj-y = bootmem.o console.o cpu.o delay.o setup.o syscalls.o threads.o unimplemented.o
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

