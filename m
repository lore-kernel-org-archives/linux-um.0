Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l23FH-0002LS-GP
 for linux-um@lists.infradead.org; Wed, 20 Jan 2021 02:29:20 +0000
Received: by mail-pg1-x52c.google.com with SMTP id g15so14213474pgu.9
 for <linux-um@lists.infradead.org>; Tue, 19 Jan 2021 18:29:19 -0800 (PST)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v8 14/20] um: lkl: plug in the build system
Date: Wed, 20 Jan 2021 11:27:19 +0900
Message-Id: <b5383a51016b2369ab5cf2a7d883ae00c0e4498b.1611103406.git.thehajime@gmail.com>
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
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
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, thehajime@gmail.com, retrage01@gmail.com

Basic Makefiles for building library of library mode. Add a new
architecture specific target for installing the resulting library files
and headers.

To make LKL binaries build, we can specify the SUBARCH name as "lkl"
to switch the output file of build: kernel (default), or library
(library mode).  Those modes are not able to be ON at the same time.

To build on library mode, users do the following:

  make defconfig ARCH=um SUBARCH=lkl
  make ARCH=um SUBARCH=lkl

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/Makefile              | 27 +++++++++----
 arch/um/configs/lkl_defconfig | 73 +++++++++++++++++++++++++++++++++++
 arch/um/kernel/Makefile       | 14 ++++---
 arch/um/lkl/um/Makefile       |  4 ++
 tools/um/Makefile             |  3 +-
 tools/um/Targets              |  3 ++
 6 files changed, 111 insertions(+), 13 deletions(-)
 create mode 100644 arch/um/configs/lkl_defconfig
 create mode 100644 arch/um/lkl/um/Makefile

diff --git a/arch/um/Makefile b/arch/um/Makefile
index bce0cccae085..6ddc900604a5 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -34,6 +34,10 @@ ifneq ($(filter $(SUBARCH),x86 x86_64 i386),)
 	HEADER_ARCH := x86
 endif
 
+ifeq ($(SUBARCH),lkl)
+	HEADER_ARCH := um/lkl
+endif
+
 ifdef CONFIG_64BIT
 	KBUILD_CFLAGS += -mcmodel=large
 endif
@@ -97,19 +101,27 @@ KBUILD_CFLAGS += $(KERNEL_DEFINES)
 LDFLAGS_vmlinux += -r
 
 INSTALL_PATH=$(objtree)/tools/um
-all: linux
-pre-2nd: linux.o
-	@echo "  INSTALL $(INSTALL_PATH)/lib/$<"
-	@mkdir -p $(INSTALL_PATH)/lib/
-	@cp $< $(INSTALL_PATH)/lib/
+ifeq ($(CONFIG_UMMODE_LIB),y)
+all: pre-2nd
+	$(Q)$(MAKE) -C $(srctree)/tools/um
 
-PHONY += linux.o
+pre-2nd: linux.o um_headers_install
+
+else
+all: linux
 
 linux: pre-2nd
 	$(Q)$(MAKE) -C $(srctree)/tools/um
 	$(Q)cp $(objtree)/tools/um/uml/linux $(objtree)/
 	$(Q)cp $(objtree)/linux $(objtree)/vmlinux
 
+pre-2nd: linux.o
+endif
+	@echo "  INSTALL $(INSTALL_PATH)/lib/$<"
+	@mkdir -p $(INSTALL_PATH)/lib/
+	@cp $< $(INSTALL_PATH)/lib/
+
+PHONY += linux.o
 linux.o: vmlinux
 #revert vmlinux file from vmlinux.a
 ifneq ("$(wildcard vmlinux.a)","")
@@ -117,7 +129,8 @@ ifneq ("$(wildcard vmlinux.a)","")
 endif
 	$(Q)cp vmlinux vmlinux.a
 	@echo "  LINK    $@"
-	$(Q)$(OBJCOPY) -R .eh_frame $< $@
+# symbols in ipc/sem.c conflict with sem_init(3) etc, thus localize the kernel one.
+	$(Q)$(OBJCOPY) -R .eh_frame -L sem_init -L sem_post -L sem_wait -L sem_destroy $< $@
 
 define archhelp
   echo '* linux		- Binary kernel image (./linux) - for backward'
diff --git a/arch/um/configs/lkl_defconfig b/arch/um/configs/lkl_defconfig
new file mode 100644
index 000000000000..7bea9e5b1b09
--- /dev/null
+++ b/arch/um/configs/lkl_defconfig
@@ -0,0 +1,73 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+CONFIG_BLK_CGROUP=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+# CONFIG_PID_NS is not set
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SLAB=y
+CONFIG_UMMODE_LIB=y
+CONFIG_HOSTFS=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_SSL=y
+CONFIG_NULL_CHAN=y
+CONFIG_PORT_CHAN=y
+CONFIG_PTY_CHAN=y
+CONFIG_TTY_CHAN=y
+CONFIG_XTERM_CHAN=y
+CONFIG_CON_CHAN="pts"
+CONFIG_SSL_CHAN="pts"
+CONFIG_UML_SOUND=m
+CONFIG_UML_NET=y
+CONFIG_UML_NET_ETHERTAP=y
+CONFIG_UML_NET_TUNTAP=y
+CONFIG_UML_NET_SLIP=y
+CONFIG_UML_NET_DAEMON=y
+CONFIG_UML_NET_MCAST=y
+CONFIG_UML_NET_SLIRP=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_IOSCHED_BFQ=m
+CONFIG_BINFMT_MISC=m
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_IPV6 is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_BLK_DEV_UBD=y
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_NBD=m
+CONFIG_DUMMY=m
+CONFIG_TUN=m
+CONFIG_PPP=m
+CONFIG_SLIP=m
+CONFIG_LEGACY_PTY_COUNT=32
+# CONFIG_HW_RANDOM is not set
+CONFIG_UML_RANDOM=y
+CONFIG_EXT4_FS=y
+CONFIG_REISERFS_FS=y
+CONFIG_BTRFS_FS=y
+CONFIG_QUOTA=y
+CONFIG_AUTOFS4_FS=m
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_VFAT_FS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_RAID6_PQ_BENCHMARK is not set
+CONFIG_DEBUG_INFO=y
+CONFIG_FRAME_WARN=1024
+CONFIG_DEBUG_KERNEL=y
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 9b63831a69e1..781c39b21403 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -14,17 +14,21 @@ CPPFLAGS_vmlinux.lds := -DSTART=$(LDS_START)		\
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
+ifndef CONFIG_UMMODE_LIB
+obj-y += exec.o mem.o physmem.o ptrace.o sysrq.o tlb.o trap.o skas/
+endif
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
-obj-y += user_syms.o
+obj-$(CONFIG_MMU) += user_syms.o
 
 USER_OBJS := config.o
 
diff --git a/arch/um/lkl/um/Makefile b/arch/um/lkl/um/Makefile
new file mode 100644
index 000000000000..b29b598a1bac
--- /dev/null
+++ b/arch/um/lkl/um/Makefile
@@ -0,0 +1,4 @@
+include/generated/user_constants.h: $(srctree)/arch/um/lkl/um/user_constants.h
+	$(Q)cp -f $^ $@
+
+obj-y = bootmem.o console.o cpu.o delay.o setup.o syscalls.o threads.o unimplemented.o
diff --git a/tools/um/Makefile b/tools/um/Makefile
index 0fdf77261e74..877d0bdefa67 100644
--- a/tools/um/Makefile
+++ b/tools/um/Makefile
@@ -32,6 +32,7 @@ export CFLAGS += -I$(OUTPUT)/include -Iinclude -Wall -g -O2 -Wextra -fPIC \
 	 -Wno-unused-parameter \
 	 -Wno-missing-field-initializers -fno-strict-aliasing
 
+-include $(OUTPUT)/../../include/config/auto.conf
 -include Targets
 
 TARGETS := $(progs-y:%=$(OUTPUT)%)
@@ -69,6 +70,6 @@ clean:
 	$(call QUIET_CLEAN, $(TARGETS))$(RM) $(TARGETS)
 
 FORCE: ;
-.PHONY: all clean FORCE
+.PHONY: all clean FORCE $(OUTPUT)/../../include/config/auto.conf
 .IGNORE: clean
 .NOTPARALLEL : lib/linux.o
diff --git a/tools/um/Targets b/tools/um/Targets
index cfe1d3c3c6ff..e8b43c7758fe 100644
--- a/tools/um/Targets
+++ b/tools/um/Targets
@@ -1,4 +1,7 @@
+ifneq ($(CONFIG_UMMODE_LIB),y)
 progs-y += uml/linux
+endif
+
 LDLIBS_linux-y := -lrt -lpthread -lutil
 LDFLAGS_linux-y := -no-pie -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 LDFLAGS_linux-$(CONFIG_STATIC_LINK) += -static
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

