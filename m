Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DslX9-0000xl-FN	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:35 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DslX8-0002fE-VD	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:35 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050713180235.CF8A021E746@zion.home.lan>
Subject: [uml-devel] [patch 7/9] uml: allow building as 32-bit binary on 64bit
	host
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
Date: Wed, 13 Jul 2005 20:02:35 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


This patch makes the command:

make ARCH=um SUBARCH=i386

work on x86_64 hosts (with support for building 32-bit binaries). This is
especially needed since 64-bit UMLs don't support 32-bit emulation for guest
binaries, currently. This has been tested in all possible cases and works.

Only exception is that I've built but not tested a 64-bit binary, because I
hadn't a 64-bit filesystem available.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/arch/um/Makefile               |   11 +----
 linux-2.6.git-broken-paolo/arch/um/Makefile-i386          |   30 +++++++++-----
 linux-2.6.git-broken-paolo/arch/um/Makefile-x86_64        |    6 +-
 linux-2.6.git-broken-paolo/arch/um/scripts/Makefile.unmap |    4 -
 4 files changed, 31 insertions(+), 20 deletions(-)

diff -puN arch/um/Makefile-i386~uml-build-on-64bit-host arch/um/Makefile-i386
--- linux-2.6.git-broken/arch/um/Makefile-i386~uml-build-on-64bit-host	2005-07-13 19:46:33.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/Makefile-i386	2005-07-13 19:46:33.000000000 +0200
@@ -1,4 +1,4 @@
-SUBARCH_CORE := arch/um/sys-i386/ arch/i386/crypto/
+core-y += arch/um/sys-i386/ arch/i386/crypto/
 
 TOP_ADDR := $(CONFIG_TOP_ADDR)
 
@@ -8,21 +8,33 @@ ifeq ($(CONFIG_MODE_SKAS),y)
   endif
 endif
 
+LDFLAGS			+= -m elf_i386
+ELF_ARCH		:= $(SUBARCH)
+ELF_FORMAT 		:= elf32-$(SUBARCH)
+OBJCOPYFLAGS  		:= -O binary -R .note -R .comment -S
+
+ifeq ("$(origin SUBARCH)", "command line")
+ifneq ("$(shell uname -m | sed -e s/i.86/i386/)", "$(SUBARCH)")
+CFLAGS			+= $(call cc-option,-m32)
+USER_CFLAGS		+= $(call cc-option,-m32)
+HOSTCFLAGS		+= $(call cc-option,-m32)
+HOSTLDFLAGS		+= $(call cc-option,-m32)
+AFLAGS			+= $(call cc-option,-m32)
+LINK-y			+= $(call cc-option,-m32)
+UML_OBJCOPYFLAGS	+= -F $(ELF_FORMAT)
+
+export LDFLAGS HOSTCFLAGS HOSTLDFLAGS UML_OBJCOPYFLAGS
+endif
+endif
+
 CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH)
-ARCH_USER_CFLAGS :=
 
 ifneq ($(CONFIG_GPROF),y)
 ARCH_CFLAGS += -DUM_FASTCALL
 endif
 
-ELF_ARCH := $(SUBARCH)
-ELF_FORMAT := elf32-$(SUBARCH)
-
-OBJCOPYFLAGS  := -O binary -R .note -R .comment -S
-
 SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/util
-
-SYS_HEADERS := $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
+SYS_HEADERS	:= $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
 
 prepare: $(SYS_HEADERS)
 
diff -puN arch/um/Makefile~uml-build-on-64bit-host arch/um/Makefile
--- linux-2.6.git-broken/arch/um/Makefile~uml-build-on-64bit-host	2005-07-13 19:46:33.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/Makefile	2005-07-13 19:46:33.000000000 +0200
@@ -51,11 +51,6 @@ MRPROPER_DIRS	+= $(ARCH_DIR)/include2
 endif
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 
-include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
-
-core-y += $(SUBARCH_CORE)
-libs-y += $(SUBARCH_LIBS)
-
 # -Dvmap=kernel_vmap affects everything, and prevents anything from
 # referencing the libpcap.o symbol so named.
 
@@ -64,7 +59,7 @@ CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSU
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
-	$(MODE_INCLUDE) $(ARCH_USER_CFLAGS)
+	$(MODE_INCLUDE)
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
@@ -74,6 +69,8 @@ USER_CFLAGS := $(patsubst -D__KERNEL__,,
 CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask
 CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
+include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
+
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
@@ -132,7 +129,7 @@ CPPFLAGS_vmlinux.lds = -U$(SUBARCH) \
 #The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
-CFLAGS_vmlinux = $(LINK-y) $(LINK_WRAPS)
+CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS)
 define cmd_vmlinux__
 	$(CC) $(CFLAGS_vmlinux) -o $@ \
 	-Wl,-T,$(vmlinux-lds) $(vmlinux-init) \
diff -puN arch/um/Makefile-x86_64~uml-build-on-64bit-host arch/um/Makefile-x86_64
--- linux-2.6.git-broken/arch/um/Makefile-x86_64~uml-build-on-64bit-host	2005-07-13 19:46:33.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/Makefile-x86_64	2005-07-13 19:46:33.000000000 +0200
@@ -1,11 +1,13 @@
 # Copyright 2003 - 2004 Pathscale, Inc
 # Released under the GPL
 
-SUBARCH_LIBS := arch/um/sys-x86_64/
+libs-y += arch/um/sys-x86_64/
 START := 0x60000000
 
+#We #undef __x86_64__ for kernelspace, not for userspace where
+#it's needed for headers to work!
 CFLAGS += -U__$(SUBARCH)__ -fno-builtin
-ARCH_USER_CFLAGS := -D__x86_64__
+USER_CFLAGS += -fno-builtin
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
diff -puN arch/um/scripts/Makefile.unmap~uml-build-on-64bit-host arch/um/scripts/Makefile.unmap
--- linux-2.6.git-broken/arch/um/scripts/Makefile.unmap~uml-build-on-64bit-host	2005-07-13 19:46:33.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/scripts/Makefile.unmap	2005-07-13 19:46:33.000000000 +0200
@@ -12,8 +12,8 @@ $(obj)/unmap.o: _c_flags = $(call unprof
 
 quiet_cmd_wrapld = LD      $@
 define cmd_wrapld
-	$(LD) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) -print-file-name=libc.a); \
-	$(OBJCOPY) $(obj)/unmap_tmp.o $@ -G switcheroo
+	$(LD) $(LDFLAGS) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) $(CFLAGS) -print-file-name=libc.a); \
+	$(OBJCOPY) $(UML_OBJCOPYFLAGS) $(obj)/unmap_tmp.o $@ -G switcheroo
 endef
 
 $(obj)/unmap_fin.o : $(obj)/unmap.o FORCE
_


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
