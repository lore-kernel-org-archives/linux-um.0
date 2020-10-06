Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPjWu-0008MI-JN
 for linux-um@lists.infradead.org; Tue, 06 Oct 2020 09:45:09 +0000
Received: by mail-pj1-x1043.google.com with SMTP id x5so655988pjv.3
 for <linux-um@lists.infradead.org>; Tue, 06 Oct 2020 02:45:08 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 05/21] um: move arch/x86/um/os-Linux to tools/um/uml/
Date: Tue,  6 Oct 2020 18:44:14 +0900
Message-Id: <451a47b488766c4bc67d69dacff3d6dbc01d0843.1601960644.git.thehajime@gmail.com>
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
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

Similar to arch/um/os-Linux code, arch/x86 also contains OS dependent
part as well.  This patch moves underlying OS dependent part to tools/um
directory so that arch/x86 code does not need to build host build
facilities (e.g., libc).

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/x86/um/Makefile                                |  2 +-
 arch/x86/um/os-Linux/Makefile                       | 13 -------------
 tools/um/Makefile                                   |  2 +-
 tools/um/uml/Build                                  |  2 ++
 tools/um/uml/x86/Build                              | 11 +++++++++++
 .../x86/um/os-Linux => tools/um/uml/x86}/mcontext.c |  0
 {arch/x86/um/os-Linux => tools/um/uml/x86}/prctl.c  |  0
 .../um/os-Linux => tools/um/uml/x86}/registers.c    |  0
 .../um/os-Linux => tools/um/uml/x86}/task_size.c    |  0
 {arch/x86/um/os-Linux => tools/um/uml/x86}/tls.c    |  0
 10 files changed, 15 insertions(+), 15 deletions(-)
 delete mode 100644 arch/x86/um/os-Linux/Makefile
 create mode 100644 tools/um/uml/x86/Build
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/mcontext.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/prctl.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/registers.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/task_size.c (100%)
 rename {arch/x86/um/os-Linux => tools/um/uml/x86}/tls.c (100%)

diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 77f70b969d14..25e9846b36a2 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -13,7 +13,7 @@ obj-y = bugs_$(BITS).o delay.o fault.o ldt.o \
 	ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
 	stub_$(BITS).o stub_segv.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
-	mem_$(BITS).o subarch.o os-$(OS)/
+	mem_$(BITS).o subarch.o
 
 ifeq ($(CONFIG_X86_32),y)
 
diff --git a/arch/x86/um/os-Linux/Makefile b/arch/x86/um/os-Linux/Makefile
deleted file mode 100644
index 253bfb8cb702..000000000000
--- a/arch/x86/um/os-Linux/Makefile
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-# Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
-# Licensed under the GPL
-#
-
-obj-y = registers.o task_size.o mcontext.o
-
-obj-$(CONFIG_X86_32) += tls.o
-obj-$(CONFIG_64BIT) += prctl.o
-
-USER_OBJS := $(obj-y)
-
-include arch/um/scripts/Makefile.rules
diff --git a/tools/um/Makefile b/tools/um/Makefile
index 07b9b93ed817..552ed5f1edae 100644
--- a/tools/um/Makefile
+++ b/tools/um/Makefile
@@ -61,7 +61,7 @@ $(OUTPUT)%-in.o: FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(patsubst %/,%,$(dir $*)) obj=$(notdir $*)
 
 # rule to build objects
-$(OUTPUT)%-in.o: $(OUTPUT)lib/linux.o
+$(OUTPUT)%-in.o: $(OUTPUT)lib/linux.o FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(patsubst %/,%,$(dir $*)) obj=$(notdir $*)
 
 clean:
diff --git a/tools/um/uml/Build b/tools/um/uml/Build
index ad93c6ad51fc..0d87d601bc06 100644
--- a/tools/um/uml/Build
+++ b/tools/um/uml/Build
@@ -12,6 +12,8 @@ liblinux-y += execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
 	umid.o util.o drivers/ skas/
 
+liblinux-y += x86/
+
 liblinux-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
 export O = $(srctree)
diff --git a/tools/um/uml/x86/Build b/tools/um/uml/x86/Build
new file mode 100644
index 000000000000..16bbc7eb19d1
--- /dev/null
+++ b/tools/um/uml/x86/Build
@@ -0,0 +1,11 @@
+#
+# Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+# Licensed under the GPL
+#
+
+include $(objtree)/include/config/auto.conf
+
+liblinux-y = registers.o task_size.o mcontext.o
+
+liblinux-$(CONFIG_X86_32) += tls.o
+liblinux-$(CONFIG_64BIT) += prctl.o
diff --git a/arch/x86/um/os-Linux/mcontext.c b/tools/um/uml/x86/mcontext.c
similarity index 100%
rename from arch/x86/um/os-Linux/mcontext.c
rename to tools/um/uml/x86/mcontext.c
diff --git a/arch/x86/um/os-Linux/prctl.c b/tools/um/uml/x86/prctl.c
similarity index 100%
rename from arch/x86/um/os-Linux/prctl.c
rename to tools/um/uml/x86/prctl.c
diff --git a/arch/x86/um/os-Linux/registers.c b/tools/um/uml/x86/registers.c
similarity index 100%
rename from arch/x86/um/os-Linux/registers.c
rename to tools/um/uml/x86/registers.c
diff --git a/arch/x86/um/os-Linux/task_size.c b/tools/um/uml/x86/task_size.c
similarity index 100%
rename from arch/x86/um/os-Linux/task_size.c
rename to tools/um/uml/x86/task_size.c
diff --git a/arch/x86/um/os-Linux/tls.c b/tools/um/uml/x86/tls.c
similarity index 100%
rename from arch/x86/um/os-Linux/tls.c
rename to tools/um/uml/x86/tls.c
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

