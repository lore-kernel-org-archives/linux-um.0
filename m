Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bp6H4-0001bN-5T for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 07:16:18 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bp6H3-0002uJ-1C for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 07:16:18 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: [patch] Re: [uml-devel] Kallsyms on UML
References: <20040726002724.GA11374@kevlar.burdell.org>
	<web-1072592@b1.c.plasa.com>
	<20040726060108.GA17971@kevlar.burdell.org>
In-Reply-To: <20040726060108.GA17971@kevlar.burdell.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5KRBBg0ohh9IcuY"
Message-Id: <200407261618.33778.blaisorblade_spam@yahoo.it>
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
Date: Mon, 26 Jul 2004 16:18:33 +0200
To: Sonny Rao <sonny@burdell.org>, Mulyadi-Santosa <a_mulyadi@telkom.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>



--Boundary-00=_5KRBBg0ohh9IcuY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alle 08:01, luned=EC 26 luglio 2004, Sonny Rao ha scritto:
> On Mon, Jul 26, 2004 at 10:57:05AM +0700, Mulyadi-Santosa wrote:
> > Hello Sonny
> >
> > >I had one question, I noticed that on stack traces I'm
> > >not getting
> > >symbols even though I had CONFIG_KALLSYMS enabled.  I
> > >looked into it a
> > >bit more and it appears that the kernel build system is

> I was referring to the stack traces which appear after an Oops or
> panic, or if you is simply call dump_stack() somewhere.  Normally, if
> CONFIG_KALLSYMS isn't defined in the kernel's .config file, then those
> stack traces don't show function names, just the address of the
> function, which is somewhat annoying to decode :)

> Fortunately, an in-kernel symbol table has been added in 2.6 which
> does the work for you.  It doesn't seem to work out of the box on UML
> on 2.6, and I was just wondering if it would be trivial to add that
> support to UML.  It seems that way to me, and its a rather useful
> feature for people using UML as a kernel development tool.

Yes, exactly. (It is not matter of EXPORT_SYMBOL, you're right).

You got the right fixes... I've just been working on those ones, and the on=
ly=20
difference is that I removed the vmlinux -> linux step (with the attached=20
patches, the binary to run is vmlinux), to avoid doing again the kallsyms=20
trick. Note that to get kallsyms right, you must follow the instructions in=
=20
the main Makefile (which means running it three times which special care).

However, on any 2.6 UML, run cat /dev/kmem (which will panic, the fix is kn=
own=20
but yet to submit) and say if you can get the stacktrace. For some reason, =
I=20
cannot (even if dump_stack() is invoked); nothing is printed. Seems like th=
e=20
printk() are lost (maybe some tricks with bust_spinlock() are needed).

Note: the Set_cflags one is just a cleanup, I send it because without it=20
you'll maybe get rejects.
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_5KRBBg0ohh9IcuY
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-Set_cflags_before_arch_Makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-Set_cflags_before_arch_Makefile.patch"


If arch/$(ARCH)/Makefile is included before adding -O2 (and the rest) to
CFLAGS, I must duplicate the addition of it to USER_CFLAGS. So let's fix this.
Also, the below code is useless, since if CONFIG_DEBUG_INFO is y, then
CONFIG_FRAME_POINTER is always y.

ifeq ($(CONFIG_DEBUG_INFO),y)
CFLAGS := $(subst -fomit-frame-pointer,,$(CFLAGS))
endif


Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.7-paolo/Makefile         |    4 ++--
 uml-linux-2.6.7-paolo/arch/um/Makefile |   21 ---------------------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff -puN Makefile~uml-Set_cflags_before_arch_Makefile Makefile
--- uml-linux-2.6.7/Makefile~uml-Set_cflags_before_arch_Makefile	2004-07-25 15:56:52.676053752 +0200
+++ uml-linux-2.6.7-paolo/Makefile	2004-07-25 15:56:52.680053144 +0200
@@ -447,8 +447,6 @@ else
 include/linux/autoconf.h: ;
 endif
 
-include $(srctree)/arch/$(ARCH)/Makefile
-
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 CFLAGS		+= -Os
 else
@@ -466,6 +464,8 @@ endif
 # warn about C99 declaration after statement
 CFLAGS += $(call check_gcc,-Wdeclaration-after-statement,)
 
+include $(srctree)/arch/$(ARCH)/Makefile
+
 #
 # INSTALL_PATH specifies where to place the updated kernel and system map
 # images.  Uncomment if you want to place them anywhere other than root.
diff -puN arch/um/Makefile~uml-Set_cflags_before_arch_Makefile arch/um/Makefile
--- uml-linux-2.6.7/arch/um/Makefile~uml-Set_cflags_before_arch_Makefile	2004-07-25 15:56:52.677053600 +0200
+++ uml-linux-2.6.7-paolo/arch/um/Makefile	2004-07-25 15:56:52.680053144 +0200
@@ -13,10 +13,6 @@ OS := $(shell uname -s)
 # EXTRAVERSION...
 MODLIB := $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
 
-ifeq ($(CONFIG_DEBUG_INFO),y)
-CFLAGS := $(subst -fomit-frame-pointer,,$(CFLAGS))
-endif
-
 core-y			+= $(ARCH_DIR)/kernel/		 \
 			   $(ARCH_DIR)/drivers/          \
 			   $(ARCH_DIR)/sys-$(SUBARCH)/
@@ -138,23 +134,6 @@ USER_CFLAGS := $(patsubst -D__KERNEL__,,
 # To get a definition of F_SETSIG
 USER_CFLAGS += -D_GNU_SOURCE
 
-# From main Makefile, these options are set after including the ARCH makefile.
-# So copy them here.
-
-ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-USER_CFLAGS		+= -Os
-else
-USER_CFLAGS		+= -O2
-endif
-
-ifndef CONFIG_FRAME_POINTER
-USER_CFLAGS		+= -fomit-frame-pointer
-endif
-
-ifdef CONFIG_DEBUG_INFO
-USER_CFLAGS		+= -g
-endif
-
 CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/uml.lds.s \
 	$(ARCH_DIR)/dyn_link.ld.s $(ARCH_DIR)/include/uml-config.h \
 	$(GEN_HEADERS)
_

--Boundary-00=_5KRBBg0ohh9IcuY
Content-Type: text/x-diff; charset="iso-8859-1"; name="uml-use-kallsyms.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="uml-use-kallsyms.patch"


This patch makes UML use print_symbol when dumping the stack. It is not yet
complete (the i386 version uses the frame pointers to walk the stack, for
instance).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.7-paolo/arch/um/kernel/sysrq.c   |    4 +++-
 uml-linux-2.6.7-paolo/arch/um/kernel/um_arch.c |    6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff -puN arch/um/kernel/sysrq.c~uml-use-kallsyms arch/um/kernel/sysrq.c
--- uml-linux-2.6.7/arch/um/kernel/sysrq.c~uml-use-kallsyms	2004-07-25 21:53:23.197200256 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/sysrq.c	2004-07-25 21:54:17.627925528 +0200
@@ -6,6 +6,7 @@
 #include "linux/sched.h"
 #include "linux/kernel.h"
 #include "linux/module.h"
+#include "linux/kallsyms.h"
 #include "asm/page.h"
 #include "asm/processor.h"
 #include "sysrq.h"
@@ -26,7 +27,8 @@ void show_trace(unsigned long * stack)
 		if (kernel_text_address(addr)) {
 			if (i && ((i % 6) == 0))
 				printk("\n   ");
-			printk("[<%08lx>] ", addr);
+			printk(" [<%08lx>] ", addr);
+			print_symbol("%s\n", addr);
 			i++;
                 }
         }
diff -puN arch/um/kernel/um_arch.c~uml-use-kallsyms arch/um/kernel/um_arch.c
--- uml-linux-2.6.7/arch/um/kernel/um_arch.c~uml-use-kallsyms	2004-07-25 22:03:19.815500488 +0200
+++ uml-linux-2.6.7-paolo/arch/um/kernel/um_arch.c	2004-07-25 22:06:10.488554240 +0200
@@ -394,9 +394,9 @@ extern int uml_exitcode;
 static int panic_exit(struct notifier_block *self, unsigned long unused1,
 		      void *unused2)
 {
-#ifdef CONFIG_MAGIC_SYSRQ
-	handle_sysrq('p', &current->thread.regs, NULL);
-#endif
+	bust_spinlocks(1);
+	show_regs(&(current->thread.regs));
+	bust_spinlocks(0);
 	uml_exitcode = 1;
 	machine_halt();
 	return(0);
_

--Boundary-00=_5KRBBg0ohh9IcuY
Content-Type: text/x-diff; charset="iso-8859-1";
	name="uml-Single_Linking_Step.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="uml-Single_Linking_Step.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.7-paolo/Makefile               |   25 +++++++---
 uml-linux-2.6.7-paolo/arch/um/Makefile       |   63 ++++++++++++---------------
 uml-linux-2.6.7-paolo/arch/um/Makefile-i386  |    6 --
 uml-linux-2.6.7/arch/um/kernel/vmlinux.lds.S |   11 ----
 4 files changed, 50 insertions(+), 55 deletions(-)

diff -puN arch/um/Makefile~uml-Single_Linking_Step arch/um/Makefile
--- uml-linux-2.6.7/arch/um/Makefile~uml-Single_Linking_Step	2004-07-25 20:44:47.851827848 +0200
+++ uml-linux-2.6.7-paolo/arch/um/Makefile	2004-07-25 20:44:47.857826936 +0200
@@ -27,13 +27,6 @@ ARCH_SYMLINKS = include/asm-um/arch $(AR
 
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
 
@@ -75,14 +68,8 @@ endif
 
 include/linux/version.h: arch/$(ARCH)/Makefile
 
-$(ARCH_DIR)/vmlinux.lds.S :
-	touch $@
-
-prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS)
-
-LDFLAGS_vmlinux = -r
-
-vmlinux: $(ARCH_DIR)/main.o 
+prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
+	 $(ARCH_DIR)/kernel/vmlinux.lds.S $(ARCH_DIR)/main.o
 
 # These aren't in Makefile-tt because they are needed in the !CONFIG_MODE_TT +
 # CONFIG_MODE_SKAS + CONFIG_STATIC_LINK case.
@@ -105,6 +92,10 @@ endif
 endif
 endif
 
+$(ARCH_DIR)/kernel/vmlinux.lds.S :
+	rm -f $@
+	ln -s ../$(LD_SCRIPT-y:.s=.S) $@
+
 CPP_MODE_TT := $(shell [ "$(CONFIG_MODE_TT)" = "y" ] && echo -DMODE_TT)
 CONFIG_KERNEL_STACK_ORDER ?= 2
 STACK_SIZE := $(shell echo $$[ 4096 * (1 << $(CONFIG_KERNEL_STACK_ORDER)) ] )
@@ -114,16 +105,22 @@ AFLAGS_vmlinux.lds.o = $(shell echo -U$(
 	-DELF_FORMAT=\"$(ELF_FORMAT)\" $(CPP_MODE_TT) \
 	-DKERNEL_STACK_SIZE=$(STACK_SIZE))
 
-export AFLAGS_$(LD_SCRIPT-y:.s=).o = $(AFLAGS_vmlinux.lds.o) -P -C -Uum
-
-LD_SCRIPT-y := $(ARCH_DIR)/$(LD_SCRIPT-y)
-
-#$(LD_SCRIPT-y) : $(LD_SCRIPT-y:.s=.S) scripts FORCE
-#	$(call if_changed_dep,as_s_S)
-
-linux: vmlinux $(LD_SCRIPT-y)
-	$(CC) -Wl,-T,$(LD_SCRIPT-y) $(LINK-y) $(LINK_WRAPS) \
-		-o linux $(ARCH_DIR)/main.o vmlinux -L/usr/lib -lutil
+#LD_SCRIPT-y := $(ARCH_DIR)/$(LD_SCRIPT-y)
+#
+#linux: vmlinux $(LD_SCRIPT-y)
+#	$(CC) -Wl,-T,$(LD_SCRIPT-y) $(LINK-y) $(LINK_WRAPS) \
+#		-o linux $(ARCH_DIR)/main.o vmlinux -L/usr/lib -lutil
+
+define cmd_vmlinux__
+	$(CC) $(CFLAGS_vmlinux) $(LINK-y) $(LINK_WRAPS) \
+	$(ARCH_DIR)/main.o $(vmlinux-init-objs) \
+	-Wl,--start-group \
+	$(vmlinux-main-objs) \
+	-Wl,--end-group \
+	-L/usr/lib -lutil \
+	$(vmlinux-special-objs) \
+	-o $@
+endef
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -Derrno=kernel_errno,,$(USER_CFLAGS))
@@ -141,7 +138,7 @@ CLEAN_FILES += linux x.i gmon.out $(ARCH
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
 	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS))
 
-$(ARCH_DIR)/main.o: $(ARCH_DIR)/main.c sys_prepare
+$(ARCH_DIR)/main.o: $(ARCH_DIR)/main.c
 	@ echo '  MAIN    $@'
 	@ $(CC) $(USER_CFLAGS) $(EXTRA_CFLAGS) -c -o $@ $<
 
@@ -182,15 +179,15 @@ $(ARCH_DIR)/include/kern_constants.h : $
 	$(call filechk,gen_header)
 
 $(ARCH_DIR)/util/mk_task $(ARCH_DIR)/util/mk_constants : $(ARCH_DIR)/util \
-	sys_prepare FORCE ;
+	FORCE ;
 
-$(ARCH_DIR)/util: FORCE
+$(ARCH_DIR)/util: $(SYS_DIR)/sc.h FORCE
 	$(Q)$(MAKE) $(build)=$@
 
 export SUBARCH USER_CFLAGS OS 
 
-all: linux
-
-define archhelp
-  echo  '* linux	- Binary kernel image (./linux)'
-endef
+#all: linux
+#
+#define archhelp
+#  echo  '* linux	- Binary kernel image (./linux)'
+#endef
diff -puN Makefile~uml-Single_Linking_Step Makefile
--- uml-linux-2.6.7/Makefile~uml-Single_Linking_Step	2004-07-25 20:44:47.853827544 +0200
+++ uml-linux-2.6.7-paolo/Makefile	2004-07-25 20:44:47.858826784 +0200
@@ -513,20 +513,30 @@ libs-y		:= $(libs-y1) $(libs-y2)
 #       we cannot yet know if we will need to relink vmlinux.
 #	So we descend into init/ inside the rule for vmlinux again.
 head-y += $(HEAD)
-vmlinux-objs := $(head-y) $(init-y) $(core-y) $(libs-y) $(drivers-y) $(net-y)
+# If an arch (like UML) uses its own linking command for vmlinux, supply
+# it everything to avoid it forgetting some objects.
+vmlinux-init-objs := $(head-y) $(init-y)
+vmlinux-main-objs := $(core-y) $(libs-y) $(drivers-y) $(net-y)
+vmlinux-special-objs = $(filter .tmp_kallsyms%,$^)
+# List of dependencies for vmlinux
+vmlinux-objs := $(vmlinux-init-objs) $(vmlinux-main-objs)
 
 quiet_cmd_vmlinux__ = LD      $@
+#Allow UML to use gcc to link vmlinux.
+#The command below is parametrized enough that you will never change it;
+#but if you still want to change it, update every arch accordingly
+#(at least UML, maybe other ones will use it, too).
+ifeq ($(cmd_vmlinux__),)
 define cmd_vmlinux__
-	$(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) $(head-y) $(init-y) \
+	$(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) \
+	$(vmlinux-init-objs) \
 	--start-group \
-	$(core-y) \
-	$(libs-y) \
-	$(drivers-y) \
-	$(net-y) \
+	$(vmlinux-main-objs) \
 	--end-group \
-	$(filter .tmp_kallsyms%,$^) \
+	$(vmlinux-special-objs) \
 	-o $@
 endef
+endif
 
 #	set -e makes the rule exit immediately on error
 
@@ -550,6 +560,7 @@ define rule_vmlinux
 endef
 
 LDFLAGS_vmlinux += -T arch/$(ARCH)/kernel/vmlinux.lds.s
+CFLAGS_vmlinux += -Wl,-T,arch/$(ARCH)/kernel/vmlinux.lds.s
 
 #	Generate section listing all symbols and add it into vmlinux
 #	It's a three stage process:
diff -puN arch/um/Makefile-i386~uml-Single_Linking_Step arch/um/Makefile-i386
--- uml-linux-2.6.7/arch/um/Makefile-i386~uml-Single_Linking_Step	2004-07-25 20:44:47.854827392 +0200
+++ uml-linux-2.6.7-paolo/arch/um/Makefile-i386	2004-07-25 20:44:47.858826784 +0200
@@ -16,8 +16,6 @@ SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/uti
 
 SYS_HEADERS = $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
 
-sys_prepare: $(SYS_DIR)/sc.h
-
 prepare: $(SYS_HEADERS)
 
 filechk_$(SYS_DIR)/sc.h := $(SYS_UTIL_DIR)/mk_sc
@@ -30,10 +28,10 @@ filechk_$(SYS_DIR)/thread.h := $(SYS_UTI
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
--- uml-linux-2.6.7/arch/um/kernel/vmlinux.lds.S
+++ /dev/null	1970-01-01 01:00:00.000000000 +0100
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
_

--Boundary-00=_5KRBBg0ohh9IcuY--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
