Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conuserg-09.nifty.com ([210.131.2.76])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m7MVo-007fJb-FL
 for linux-um@lists.infradead.org; Sat, 24 Jul 2021 18:36:38 +0000
From: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kbuild: do not require sub-make for separate output tree
 builds
Date: Sun, 25 Jul 2021 03:35:56 +0900
Message-Id: <20210724183556.76680-1-masahiroy@kernel.org>
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
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-mips@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>, Richard Weinberger <richard@nod.at>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

As explained in commit 3204a7fb98a3 ("kbuild: prefix $(srctree)/ to some
included Makefiles"), I want to stop using --include-dir some day.

I already fixed up the top Makefile, but some arch Makefiles (mips, um,
x86) still include check-in Makefiles without $(srctree)/.

Fix them up so 'need-sub-make := 1' can go away for this case.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile           | 5 ++---
 arch/mips/Makefile | 2 +-
 arch/um/Makefile   | 6 +++---
 arch/x86/Makefile  | 2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index e4f5895badb5..bb10a93edf5c 100644
--- a/Makefile
+++ b/Makefile
@@ -191,10 +191,9 @@ endif
 ifneq ($(abs_srctree),$(abs_objtree))
 # Look for make include files relative to root of kernel src
 #
-# This does not become effective immediately because MAKEFLAGS is re-parsed
-# once after the Makefile is read. We need to invoke sub-make.
+# --included-dir is added for backward compatibility, but you should not rely on
+# it. Please add $(srctree)/ prefix to include Makefiles in the source tree.
 MAKEFLAGS += --include-dir=$(abs_srctree)
-need-sub-make := 1
 endif
 
 ifneq ($(filter 3.%,$(MAKE_VERSION)),)
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 4e942b7ef022..bc2e1857d8ce 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -254,7 +254,7 @@ endif
 #
 # Board-dependent options and extra files
 #
-include arch/mips/Kbuild.platforms
+include $(srctree)/arch/mips/Kbuild.platforms
 
 ifdef CONFIG_PHYSICAL_START
 load-y					= $(CONFIG_PHYSICAL_START)
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 12a7acef0357..f2fe63bfd819 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -41,8 +41,8 @@ endif
 
 HOST_DIR := arch/$(HEADER_ARCH)
 
-include $(ARCH_DIR)/Makefile-skas
-include $(HOST_DIR)/Makefile.um
+include $(srctree)/$(ARCH_DIR)/Makefile-skas
+include $(srctree)/$(HOST_DIR)/Makefile.um
 
 core-y += $(HOST_DIR)/um/
 
@@ -76,7 +76,7 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
 
 #This will adjust *FLAGS accordingly to the platform.
-include $(ARCH_DIR)/Makefile-os-$(OS)
+include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
 KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/include \
 		   -I$(srctree)/$(HOST_DIR)/include/uapi \
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 307fd0000a83..0fa7dc73b5d8 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -75,7 +75,7 @@ ifeq ($(CONFIG_X86_32),y)
         KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align4))
 
         # CPU-specific tuning. Anything which can be shared with UML should go here.
-        include arch/x86/Makefile_32.cpu
+        include $(srctree)/arch/x86/Makefile_32.cpu
         KBUILD_CFLAGS += $(cflags-y)
 
         # temporary until string.h is fixed
-- 
2.27.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

