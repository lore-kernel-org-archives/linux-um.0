Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHANf-0002gc-8S for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:07 -0700
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CHANb-0000IB-RK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 17:19:07 -0700
From: blaisorblade_spam@yahoo.it
Message-Id: <20041012001752.184DC868F@zion.localdomain>
Subject: [uml-devel] [patch 04/10] uml: Single Linking Step for vmlinux
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 12 Oct 2004 02:17:52 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


Uml-specific patch (which requires a mainline hook, mailed separately).

This patch avoid the linking kludge which leaves kbuild link vmlinux and
then link it with libc inside linux. This kludge has the big problem of
making kallsyms break, since the kallsyms pass is done on a completely
different binary than the running one.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile       |   48 +++++++++--------------
 linux-2.6.9-current-paolo/arch/um/Makefile-i386  |    6 --
 linux-2.6.9-current-paolo/arch/um/Makefile-skas  |    2 
 linux-2.6.9-current/arch/um/kernel/vmlinux.lds.S |   11 -----
 4 files changed, 22 insertions(+), 45 deletions(-)

diff -puN arch/um/Makefile~uml-Single_Linking_Step arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-Single_Linking_Step	2004-10-12 01:06:27.994232456 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-10-12 01:06:28.031226832 +0200
@@ -22,13 +22,6 @@ ARCH_SYMLINKS = include/asm-um/arch $(AR
 
 GEN_HEADERS += $(ARCH_DIR)/include/task.h $(ARCH_DIR)/include/kern_constants.h
 
-# This target adds dependencies to "prepare". They are defined in the included
-# Makefiles (see Makefile-i386).
-
-.PHONY: sys_prepare
-sys_prepare:
-	@:
-
 MAKEFILE-$(CONFIG_MODE_TT) += Makefile-tt
 MAKEFILE-$(CONFIG_MODE_SKAS) += Makefile-skas
 
@@ -66,18 +59,14 @@ ifeq ($(CONFIG_MODE_SKAS), y)
 $(SYS_HEADERS) : $(TOPDIR)/$(ARCH_DIR)/include/skas_ptregs.h
 endif
 
-$(ARCH_DIR)/vmlinux.lds.S :
-	touch $@
-
-prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS)
-
-LDFLAGS_vmlinux = -r
+prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
+	$(ARCH_DIR)/kernel/vmlinux.lds.S
 
 # These aren't in Makefile-tt because they are needed in the !CONFIG_MODE_TT +
 # CONFIG_MODE_SKAS + CONFIG_STATIC_LINK case.
 
 LINK_TT = -static
-LD_SCRIPT_TT := uml.lds
+LD_SCRIPT_TT := uml.lds.S
 
 ifeq ($(CONFIG_STATIC_LINK),y)
   LINK-y += $(LINK_TT)
@@ -94,6 +83,12 @@ endif
 endif
 endif
 
+#We need to re-preprocess this when the symlink dest changes.
+#So we just touch it.
+$(ARCH_DIR)/kernel/vmlinux.lds.S:
+	ln -sf $(LD_SCRIPT-y) $@
+	touch $@
+
 CPP_MODE_TT := $(shell [ "$(CONFIG_MODE_TT)" = "y" ] && echo -DMODE_TT)
 CONFIG_KERNEL_STACK_ORDER ?= 2
 STACK_SIZE := $(shell echo $$[ 4096 * (1 << $(CONFIG_KERNEL_STACK_ORDER)) ] )
@@ -107,13 +102,14 @@ CPPFLAGS_vmlinux.lds = $(shell echo -U$(
 	-DELF_FORMAT=\"$(ELF_FORMAT)\" $(CPP_MODE_TT) \
 	-DKERNEL_STACK_SIZE=$(STACK_SIZE))
 
-export CPPFLAGS_$(LD_SCRIPT-y) = $(CPPFLAGS_vmlinux.lds) -P -C -Uum
-
-LD_SCRIPT-y := $(ARCH_DIR)/kernel/$(LD_SCRIPT-y)
-
-linux: vmlinux $(LD_SCRIPT-y)
-	$(CC) -Wl,-T,$(LD_SCRIPT-y) $(LINK-y) $(LINK_WRAPS) \
-		-o linux vmlinux -L/usr/lib -lutil
+CFLAGS_vmlinux = $(LINK-y) $(LINK_WRAPS)
+define cmd_vmlinux__
+	$(CC) $(CFLAGS_vmlinux) -o $@ \
+	-Wl,-T,$(vmlinux-lds) $(vmlinux-init) \
+	-Wl,--start-group $(vmlinux-main) -Wl,--end-group \
+	-L/usr/lib -lutil \
+	$(filter-out $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) FORCE ,$^)
+endef
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -Derrno=kernel_errno,,$(USER_CFLAGS))
@@ -168,15 +164,9 @@ $(ARCH_DIR)/include/kern_constants.h : $
 	$(call filechk,gen_header)
 
 $(ARCH_DIR)/util/mk_task $(ARCH_DIR)/util/mk_constants : $(ARCH_DIR)/util \
-	sys_prepare FORCE ;
+	FORCE ;
 
-$(ARCH_DIR)/util: FORCE
+$(ARCH_DIR)/util: $(SYS_DIR)/sc.h FORCE
 	$(Q)$(MAKE) $(build)=$@
 
 export SUBARCH USER_CFLAGS OS
-
-all: linux
-
-define archhelp
-  echo  '* linux	- Binary kernel image (./linux)'
-endef
diff -puN Makefile~uml-Single_Linking_Step Makefile
diff -puN arch/um/Makefile-i386~uml-Single_Linking_Step arch/um/Makefile-i386
--- linux-2.6.9-current/arch/um/Makefile-i386~uml-Single_Linking_Step	2004-10-12 01:06:28.026227592 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile-i386	2004-10-12 01:06:28.031226832 +0200
@@ -26,8 +26,6 @@ SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/uti
 
 SYS_HEADERS = $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
 
-sys_prepare: $(SYS_DIR)/sc.h
-
 prepare: $(SYS_HEADERS)
 
 filechk_$(SYS_DIR)/sc.h := $(SYS_UTIL_DIR)/mk_sc
@@ -40,10 +38,10 @@ filechk_$(SYS_DIR)/thread.h := $(SYS_UTI
 $(SYS_DIR)/thread.h: $(SYS_UTIL_DIR)/mk_thread 
 	$(call filechk,$@)
 
-$(SYS_UTIL_DIR)/mk_sc: scripts/basic/fixdep include/config/MARKER FORCE ;
+$(SYS_UTIL_DIR)/mk_sc: scripts/basic/fixdep include/config/MARKER FORCE
 	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
 
-$(SYS_UTIL_DIR)/mk_thread: $(ARCH_SYMLINKS) $(GEN_HEADERS) sys_prepare FORCE ;
+$(SYS_UTIL_DIR)/mk_thread: $(ARCH_SYMLINKS) $(GEN_HEADERS) FORCE
 	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
 
 $(SYS_UTIL_DIR): include/asm FORCE
diff -L arch/um/kernel/vmlinux.lds.S -puN arch/um/kernel/vmlinux.lds.S~uml-Single_Linking_Step /dev/null
--- linux-2.6.9-current/arch/um/kernel/vmlinux.lds.S
+++ /dev/null	2004-06-25 17:47:25.000000000 +0200
@@ -1,11 +0,0 @@
-#include <asm-generic/vmlinux.lds.h>
-	
-OUTPUT_FORMAT(ELF_FORMAT)
-OUTPUT_ARCH(ELF_ARCH)
-ENTRY(_start)
-jiffies = jiffies_64;
-
-SECTIONS
-{
-#include "asm/common.lds.S"
-}
diff -puN arch/um/Makefile-skas~uml-Single_Linking_Step arch/um/Makefile-skas
--- linux-2.6.9-current/arch/um/Makefile-skas~uml-Single_Linking_Step	2004-10-12 01:06:28.028227288 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile-skas	2004-10-12 01:06:28.032226680 +0200
@@ -12,7 +12,7 @@ LINK-$(CONFIG_GPROF) += $(PROFILE)
 MODE_INCLUDE += -I$(TOPDIR)/$(ARCH_DIR)/kernel/skas/include
 
 LINK_SKAS = -Wl,-rpath,/lib 
-LD_SCRIPT_SKAS = dyn.lds
+LD_SCRIPT_SKAS = dyn.lds.S
 
 GEN_HEADERS += $(TOPDIR)/$(ARCH_DIR)/include/skas_ptregs.h
 
_


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
