Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8NQW-00060u-6f for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Mar 2004 09:53:28 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B8NQV-0007md-EL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Mar 2004 09:53:27 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [patch] fix for "make O=..."
References: <20040329183802.GA8281@bytesex.org>
In-Reply-To: <20040329183802.GA8281@bytesex.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8YbaAvtzyTdmfMh"
Message-Id: <200403302002.36250.blaisorblade_spam@yahoo.it>
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
Date: Tue, 30 Mar 2004 19:02:36 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>



--Boundary-00=_8YbaAvtzyTdmfMh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 20:38, luned=EC 29 marzo 2004, Gerd Knorr ha scritto:
>   Hi,
>
> uml needs the patch below to build with separated source and object
> trees.
That is needed; but I think that still O=3D... won't work properly - I expe=
ct=20
comments on this.

By "work properly" I mean not only to produce a correct binary (probably th=
is=20
works) but also to avoid writing any file in the source tree. I tried to=20
achieve this some time ago but I had a lot of problem with generated header=
s.=20
Actually I had to add -I$(srctree)/arch/um/include and=20
=2DI$(objtree)/arch/um/include, but Kbuild thinks I am silly and adds by=20
itself, in both cases, the $(srctree) part, and some other Makefiles rely o=
n=20
this, so changing it is hard. I didn't think to make it understand that a=20
full path must not be corrected (which would probably work).

Also, there were heavy changes to do to the include files location.
I'm attaching the patch I built at that time (i.e. 2.6.0 + my MODVERSION pa=
tch=20
which changes a lot of Makefiles..., so it won't apply directly). With the=
=20
above fix you could make it work, maybe.

Bye
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_8YbaAvtzyTdmfMh
Content-Type: text/x-diff; charset="iso-8859-1"; name="umlBuildOutside.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="umlBuildOutside.patch"

--- ./arch/um/include/sysdep-i386/sigcontext.h.fix	2004-02-05 16:45:10.000000000 +0100
+++ ./arch/um/include/sysdep-i386/sigcontext.h	2004-02-08 17:11:13.000000000 +0100
@@ -6,7 +6,7 @@
 #ifndef __SYS_SIGCONTEXT_I386_H
 #define __SYS_SIGCONTEXT_I386_H
 
-#include "sc.h"
+#include "sysdep/sc.h"
 
 #define IP_RESTART_SYSCALL(ip) ((ip) -= 2)
 
--- ./arch/um/kernel/skas/Makefile.fix	2004-02-06 20:02:43.000000000 +0100
+++ ./arch/um/kernel/skas/Makefile	2004-02-08 17:07:57.000000000 +0100
@@ -27,5 +27,5 @@
 endef
 
 filechk_gen_header = $<
-$(TOPDIR)/arch/um/include/skas_ptregs.h : $(src)/util/mk_ptregs
+$(objtree)/include/skas_ptregs.h : $(src)/util/mk_ptregs
 	$(call filechk,gen_header)
--- ./arch/um/kernel/Makefile.fix	2004-02-06 20:02:43.000000000 +0100
+++ ./arch/um/kernel/Makefile	2004-02-08 17:09:36.000000000 +0100
@@ -35,11 +35,11 @@
 CFLAGS_user_syms.o = -D__AUTOCONF_INCLUDED__ $(DMODULES-y) $(DMODVERSIONS-y) \
 	-I/usr/include -I../include
 
-QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'
+QUOTE = 'my $$config=`cat $(objtree)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'
 
 quiet_cmd_quote = QUOTE   $@
       cmd_quote = $(PERL) -e $(QUOTE) < $< > $@
 
 targets += config.c
-$(obj)/config.c : $(src)/config.c.in $(TOPDIR)/.config FORCE
+$(obj)/config.c : $(src)/config.c.in $(objtree)/.config FORCE
 	$(call if_changed,quote)
--- ./arch/um/util/Makefile.fix	2004-02-06 20:02:43.000000000 +0100
+++ ./arch/um/util/Makefile	2004-02-08 17:05:20.000000000 +0100
@@ -14,5 +14,16 @@
 $(obj)/mk_constants_user.o : $(src)/mk_constants_user.c
 	$(HOSTCC) -c $< -o $@
 
+# Normally this pass (in short s/-I/-I$(srctree)) is done by
+# scripts/Makefile.lib; here we must do it ourselves.
+
+ifeq ($(KBUILD_SRC),)
+_CFLAGS = $(CFLAGS)
+else
+flags = $(foreach o,$($(1)),\
+	$(if $(filter -I%,$(o)),$(patsubst -I%,-I$(srctree)/%,$(o)),$(o)))
+_CFLAGS = $(call flags,CFLAGS) -I$(objtree)/include -I$(objtree)/include2
+endif
+
 $(obj)/mk_constants_kern.o : $(src)/mk_constants_kern.c
-	$(HOSTCC) $(CFLAGS) -c $< -o $@
+	$(HOSTCC) $(_CFLAGS) -c $< -o $@
--- ./arch/um/Makefile.fix	2004-02-06 20:02:43.000000000 +0100
+++ ./arch/um/Makefile	2004-02-08 17:18:12.000000000 +0100
@@ -23,10 +23,11 @@
 	include/asm-um/ptrace.h include/asm-um/arch-signal.h \
 	include/asm-um/module.h
 
-ARCH_SYMLINKS = include/asm-um/arch $(ARCH_DIR)/include/sysdep $(ARCH_DIR)/os \
-	$(SYMLINK_HEADERS) $(ARCH_DIR)/include/uml-config.h
+ARCH_SYMLINKS = include/asm-um/arch include/sysdep \
+	$(objtree)/include2/sysdep $(ARCH_DIR)/os $(SYMLINK_HEADERS) \
+	include/uml-config.h
 
-GEN_HEADERS += $(ARCH_DIR)/include/task.h $(ARCH_DIR)/include/kern_constants.h
+GEN_HEADERS += include/task.h include/kern_constants.h
 
 # This target adds dependencies to "prepare". They are defined in the included
 # Makefiles (see Makefile-i386).
@@ -38,15 +39,16 @@
 MAKEFILE-$(CONFIG_MODE_SKAS) += Makefile-skas
 
 ifneq ($(MAKEFILE-y),)
-  include $(addprefix $(ARCH_DIR)/,$(MAKEFILE-y))
+  include $(addprefix $(src)/$(ARCH_DIR)/,$(MAKEFILE-y))
 endif
 
-include $(ARCH_DIR)/Makefile-$(SUBARCH)
-include $(ARCH_DIR)/Makefile-os-$(OS)
+include $(src)/$(ARCH_DIR)/Makefile-$(SUBARCH)
+include $(src)/$(ARCH_DIR)/Makefile-os-$(OS)
 
 EXTRAVERSION := $(EXTRAVERSION)-1um
 
 ARCH_INCLUDE = -I$(ARCH_DIR)/include
+#+ $(if $(KBUILD_SRC),-I$(ARCH_DIR)/include2)
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
@@ -68,7 +70,7 @@
 SIZE = (($(CONFIG_NEST_LEVEL) + $(CONFIG_KERNEL_HALF_GIGS)) * 0x20000000)
 
 ifeq ($(CONFIG_MODE_SKAS), y)
-$(SYS_HEADERS) : $(TOPDIR)/$(ARCH_DIR)/include/skas_ptregs.h
+$(SYS_HEADERS) : $(objtree)/include/skas_ptregs.h
 endif
 
 include/linux/version.h: arch/$(ARCH)/Makefile
@@ -76,7 +78,11 @@
 $(ARCH_DIR)/vmlinux.lds.S :
 	touch $@
 
-prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS)
+.PHONY: mksysdep
+mksysdep:
+	mkdir -p $(objtree)/include/sysdep-$(SUBARCH)
+
+prepare: mksysdep $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS)
 
 LDFLAGS_vmlinux = -r
 
@@ -152,7 +158,7 @@
 USER_CFLAGS += -D_GNU_SOURCE
 
 CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/uml.lds.s \
-	$(ARCH_DIR)/dyn_link.ld.s $(ARCH_DIR)/include/uml-config.h \
+	$(ARCH_DIR)/dyn_link.ld.s include/uml-config.h \
 	$(GEN_HEADERS)
 
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
@@ -184,32 +190,36 @@
 	ln -sf $(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $(notdir $@)
 
 include/asm-um/arch:
-	cd $(TOPDIR)/include/asm-um && ln -sf ../asm-$(SUBARCH) arch
+	cd $(objtree)/include/asm-um && ln -sf ../asm-$(SUBARCH) arch
+
+include/sysdep:
+	cd include && ln -sf sysdep-$(SUBARCH) sysdep
 
-$(ARCH_DIR)/include/sysdep:
-	cd $(ARCH_DIR)/include && ln -sf sysdep-$(SUBARCH) sysdep
+$(objtree)/include2/sysdep:
+	ln -sf $(srctree)/$(ARCH_DIR)/include/sysdep-$(SUBARCH) \
+	$(objtree)/include2/sysdep
 
 $(ARCH_DIR)/os:
-	cd $(ARCH_DIR) && ln -sf os-$(OS) os
+	ln -sf $(srctree)/$(ARCH_DIR)/os-$(OS) $(objtree)/$(ARCH_DIR)/os
 
 #Generated files
 define filechk_umlconfig
 	sed 's/ CONFIG/ UML_CONFIG/'
 endef
 
-filechk_$(ARCH_DIR)/include/task.h := $(ARCH_DIR)/util/mk_task
+filechk_include/task.h := $(ARCH_DIR)/util/mk_task
 
-filechk_$(ARCH_DIR)/include/kern_constants.h := $(ARCH_DIR)/util/mk_constants
+filechk_include/kern_constants.h := $(ARCH_DIR)/util/mk_constants
 
 filechk_gen_header = $<
 
-$(ARCH_DIR)/include/uml-config.h : $(TOPDIR)/include/linux/autoconf.h
+include/uml-config.h : $(objtree)/include/linux/autoconf.h
 	$(call filechk,umlconfig)
 
-$(ARCH_DIR)/include/task.h : $(ARCH_DIR)/util/mk_task
+include/task.h : $(ARCH_DIR)/util/mk_task
 	$(call filechk,gen_header)
 
-$(ARCH_DIR)/include/kern_constants.h : $(ARCH_DIR)/util/mk_constants
+include/kern_constants.h : $(ARCH_DIR)/util/mk_constants
 	$(call filechk,gen_header)
 
 $(ARCH_DIR)/util/mk_task $(ARCH_DIR)/util/mk_constants : $(ARCH_DIR)/util \
--- ./arch/um/Makefile-skas.fix	2004-02-06 20:02:43.000000000 +0100
+++ ./arch/um/Makefile-skas	2004-02-08 17:08:00.000000000 +0100
@@ -9,12 +9,12 @@
 CFLAGS-$(CONFIG_GPROF) += $(PROFILE)
 LINK-$(CONFIG_GPROF) += $(PROFILE)
 
-MODE_INCLUDE += -I$(TOPDIR)/$(ARCH_DIR)/kernel/skas/include
+MODE_INCLUDE += -I$(ARCH_DIR)/kernel/skas/include
 
 LINK_SKAS = -Wl,-rpath,/lib 
 LD_SCRIPT_SKAS = dyn.lds.s
 
-GEN_HEADERS += $(TOPDIR)/$(ARCH_DIR)/include/skas_ptregs.h
+GEN_HEADERS += $(objtree)/include/skas_ptregs.h
 
-$(TOPDIR)/$(ARCH_DIR)/include/skas_ptregs.h :
+$(objtree)/include/skas_ptregs.h :
 	$(Q)$(MAKE) $(build)=$(ARCH_DIR)/kernel/skas $@
--- ./arch/um/Makefile-i386.fix	2004-02-06 20:02:43.000000000 +0100
+++ ./arch/um/Makefile-i386	2004-02-08 16:52:47.000000000 +0100
@@ -11,15 +11,13 @@
 OBJCOPYFLAGS  := -O binary -R .note -R .comment -S
 LDFLAGS_BLOB	:= --format binary --oformat elf32-i386
 
-SYS_DIR		:= $(ARCH_DIR)/include/sysdep-i386
+SYS_DIR		:= include/sysdep-i386
 SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/util
 
 SYS_HEADERS = $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
 
 sys_prepare: $(SYS_DIR)/sc.h
 
-prepare: $(SYS_HEADERS)
-
 filechk_$(SYS_DIR)/sc.h := $(SYS_UTIL_DIR)/mk_sc
 
 $(SYS_DIR)/sc.h: $(SYS_UTIL_DIR)/mk_sc
--- ./arch/um/Makefile-tt.fix	2003-12-20 17:40:55.000000000 +0100
+++ ./arch/um/Makefile-tt	2004-02-08 16:45:24.000000000 +0100
@@ -3,5 +3,5 @@
 # Licensed under the GPL
 #
 
-MODE_INCLUDE += -I$(TOPDIR)/$(ARCH_DIR)/kernel/tt/include
+MODE_INCLUDE += -I$(ARCH_DIR)/kernel/tt/include
 
--- ./scripts/Makefile.lib.fix	2004-02-06 20:02:43.000000000 +0100
+++ ./scripts/Makefile.lib	2004-02-08 17:19:20.000000000 +0100
@@ -186,7 +186,11 @@
 #We must strip the NOSTDINC and -D__KERNEL__ (else we mess up /usr/include/asm/*)
 #and can strip the -DKBUILD... stuff and the -DMODULE, as we don't include
 #linux headers.
+ifeq ($(KBUILD_SRC),)
 __umUser_c_flags = -Wp,-MD,$(depfile) $(__c_flags)
+else
+__umUser_c_flags = -Wp,-MD,$(depfile) $(__c_flags) -Iinclude -Iinclude2
+endif
 
 c_flags 	= $(if $(is_user_obj), $(__umUser_c_flags), $(__kernel_c_flags))
 

--Boundary-00=_8YbaAvtzyTdmfMh--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
