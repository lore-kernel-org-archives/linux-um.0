Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZEYf-0008Fe-TK
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 24 Dec 2003 11:20:37 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AZEYe-00047S-W3
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 24 Dec 2003 11:20:37 -0800
From: BlaisorBlade <blaisorblade_work@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7ae6/aoV5+s4l/l"
Message-Id: <200312242019.23335.blaisorblade_work@yahoo.it>
Subject: [uml-devel] Needed help for UML kbuild.
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 24 Dec 2003 20:19:23 +0100
To: kbuild-devel@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_7ae6/aoV5+s4l/l
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm a UML(User mode linux, the arch/um folder in 2.5/2.6) developer, and I 
need some support to update its build system to the 2.6 changes.

The problem is that since that port of Linux runs as a normal process and 
emulates a whole box, some of its source files must be compiled against 
user-space headers and without some flags; this cannot be handled simply by 
setting CFLAGS_<target name>, as the problematic flags are added by 
scripts/Makefile.lib itself; so I've prepared a patch(that I attached) which 
recognizes these objects to compile them properly. This patch will need to go 
in stock 2.6 and mustn't interfere with the rest of the kernel compilation, 
so I especially want to hear from you.

The "stuff" part of it will be sent to the UML developers; it's just changing 
the Uml makefiles to use the new way of working.

The "main" must be reviewed here, especially for the scripts/Makefile.lib; the 
Makefile.build change is just cosmetic(changing the shown tag; I must change 
it more to fix the filename alignment; but why don't you use a tab for 
this?). The Makefile.lib, instead, is the core change: objects listed in 
UML_USER_OBJS get completely different CFLAGS.
The list always contains, in the arch/um subfolders, all objects whose name 
matches %_user.o(as it has always been for UML).

A strange(not documented) issue I met with GNU make 3.80 is that when I export 
a recursively expanded variable, what goes to the sub-make is the expanded 
value, not the "formula definition".

Bye and thanks for your attention.
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN

--Boundary-00=_7ae6/aoV5+s4l/l
Content-Type: text/x-diff;
  charset="us-ascii";
  name="Main_A-04-User_obj_makefiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="Main_A-04-User_obj_makefiles.patch"

--- ./arch/um/Makefile.user_obj	2003-12-13 18:36:36.000000000 +0100
+++ ./arch/um/Makefile	2003-12-24 18:18:22.000000000 +0100
@@ -13,10 +13,6 @@
 # EXTRAVERSION...
 MODLIB := $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
 
-ifeq ($(CONFIG_DEBUG_INFO),y)
-CFLAGS := $(subst -fomit-frame-pointer,,$(CFLAGS))
-endif
-
 core-y			+= $(ARCH_DIR)/kernel/		 \
 			   $(ARCH_DIR)/drivers/          \
 			   $(ARCH_DIR)/sys-$(SUBARCH)/
@@ -129,13 +125,18 @@
 USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
 	$(MODE_INCLUDE)
 
-# To get a definition of F_SETSIG
-USER_CFLAGS += -D_GNU_SOURCE
+#From main Makefile, these options are set after including the ARCH makefile.
+#So copy them here.
+ifndef CONFIG_FRAME_POINTER
+USER_CFLAGS		+= -fomit-frame-pointer
+endif
 
 ifdef CONFIG_DEBUG_INFO
-USER_CFLAGS += -g
+USER_CFLAGS		+= -g
 endif
 
+# To get a definition of F_SETSIG
+USER_CFLAGS += -D_GNU_SOURCE
 
 CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/uml.lds.s \
 	$(ARCH_DIR)/dyn_link.ld.s $(ARCH_DIR)/include/uml-config.h \
--- ./fs/hostfs/Makefile.user_obj	2003-12-19 18:40:23.000000000 +0100
+++ ./fs/hostfs/Makefile	2003-12-24 16:47:25.000000000 +0100
@@ -15,15 +15,10 @@
 obj-y = 
 obj-$(CONFIG_HOSTFS) += hostfs.o
 
-SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),$($(f)-objs))
+# Here we aren't in arch/um, so list explicitly files.
+UML_USER_OBJS := hostfs_user.o
 
-USER_OBJS := $(filter %_user.o,$(obj-y) $(obj-m) $(SINGLE_OBJS))
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
-
-USER_CFLAGS += -DSTAT64_INO_FIELD=$(STAT64_INO_FIELD)
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+CFLAGS_hostfs_user.o += -DSTAT64_INO_FIELD=$(STAT64_INO_FIELD)
 
 clean:
 
--- ./scripts/Makefile.lib.user_obj	2003-10-01 21:25:17.000000000 +0200
+++ ./scripts/Makefile.lib	2003-12-24 16:39:18.000000000 +0100
@@ -136,8 +136,22 @@
 basename_flags = -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F)))
 modname_flags  = $(if $(filter 1,$(words $(modname))),-DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname))))
 
+#For UML
+
+#UML_USER_OBJS += $(foreach i,$(_UML_USER_OBJS),$(filter-out $(subst arch/um,,$(i)),$(i)))
+#UML_USER_OBJS += $(_UML_USER_OBJS)
+
+#With filter-out we add only files if dir is not changed by subst, i.e. is not in arch/um
+
+_UML_USER_OBJS = $(filter %_user.o,$(obj-y) $(obj-m) $(multi-objs))
+UML_USER_OBJS += $(if $(filter-out $(subst arch/um,,$(obj)),$(obj)),\
+			$(_UML_USER_OBJS))
+
+is_user_obj    = $(findstring $(@F),$(UML_USER_OBJS))
+
+_c_flags       = $(if $(is_user_obj),$(USER_CFLAGS),$(CFLAGS) $(EXTRA_CFLAGS)) \
+  		 $(CFLAGS_$(*F).o)
 
-_c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o)
 _a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
 _hostc_flags   = $(HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   $(HOSTCFLAGS_$(*F).o)
 _hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) $(HOSTCXXFLAGS_$(*F).o)
@@ -165,10 +179,17 @@
 __hostcxx_flags	=                              $(call flags,_hostcxx_flags)
 endif
 
-c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
+__kernel_c_flags = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 		 $(__c_flags) $(modkern_cflags) \
 		 $(basename_flags) $(modname_flags)
 
+#We must strip the NOSTDINC and -D__KERNEL__ (else we mess up /usr/include/asm/*)
+#and can strip the -DKBUILD... stuff and the -DMODULE, as we don't include
+#linux headers.
+__umUser_c_flags = -Wp,-MD,$(depfile) $(__c_flags)
+
+c_flags 	= $(if $(is_user_obj), $(__umUser_c_flags), $(__kernel_c_flags))
+
 a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
 		 $(__a_flags) $(modkern_aflags)
 
--- ./scripts/Makefile.build.user_obj	2003-10-10 16:09:28.000000000 +0200
+++ ./scripts/Makefile.build	2003-12-23 17:22:07.000000000 +0100
@@ -125,7 +125,7 @@
 # The C file is compiled and updated dependency information is generated.
 # (See cmd_cc_o_c + relevant part of rule_cc_o_c)
 
-quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
+quiet_cmd_cc_o_c = $(if $(is_user_obj),USR-)CC $(quiet_modtag)  $@
 
 ifndef CONFIG_MODVERSIONS
 cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<

--Boundary-00=_7ae6/aoV5+s4l/l
Content-Type: text/x-diff;
  charset="us-ascii";
  name="Stuff_A-04-User_obj_makefiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="Stuff_A-04-User_obj_makefiles.patch"

--- ./arch/um/drivers/Makefile.user_obj	2003-12-19 18:40:22.000000000 +0100
+++ ./arch/um/drivers/Makefile	2003-12-23 13:14:37.000000000 +0100
@@ -44,14 +44,7 @@
 
 obj-y += stdio_console.o $(CHAN_OBJS)
 
-USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),$($(f)-objs))
-
-USER_OBJS := $(filter %_user.o,$(obj-y) $(obj-m) $(USER_SINGLE_OBJS)) fd.o \
-	null.o pty.o tty.o xterm.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+UML_USER_OBJS += fd.o null.o pty.o tty.o xterm.o
 
 clean:
 
--- ./arch/um/kernel/skas/sys-i386/Makefile.user_obj	2003-04-17 16:11:40.000000000 +0200
+++ ./arch/um/kernel/skas/sys-i386/Makefile	2003-12-23 13:14:37.000000000 +0100
@@ -5,10 +5,6 @@
 
 obj-y = sigcontext.o
 
-USER_OBJS = sigcontext.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+UML_USER_OBJS += sigcontext.o
 
 clean :
--- ./arch/um/kernel/skas/Makefile.user_obj	2003-12-19 18:40:22.000000000 +0100
+++ ./arch/um/kernel/skas/Makefile	2003-12-23 13:14:37.000000000 +0100
@@ -10,8 +10,7 @@
 host-progs	:= util/mk_ptregs
 clean-files	:= include/skas_ptregs.h
 
-USER_OBJS = $(filter %_user.o,$(obj-y)) process.o time.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+UML_USER_OBJS += process.o time.o
 
 $(TOPDIR)/arch/um/include/skas_ptregs.h : $(src)/util/mk_ptregs
 	@echo -n '  Generating $@'
@@ -23,6 +22,3 @@
 		echo ' (updated)'; \
 		mv -f $@.tmp $@; \
 	fi
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
--- ./arch/um/kernel/tt/ptproxy/Makefile.user_obj	2003-04-17 16:11:41.000000000 +0200
+++ ./arch/um/kernel/tt/ptproxy/Makefile	2003-12-24 18:10:10.000000000 +0100
@@ -5,9 +5,6 @@
 
 obj-y = proxy.o ptrace.o sysdep.o wait.o
 
-USER_OBJS := $(foreach file,$(obj-y),$(src)/$(file))
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+UML_USER_OBJS := $(obj-y)
 
 clean:
--- ./arch/um/kernel/tt/sys-i386/Makefile.user_obj	2003-04-17 16:11:41.000000000 +0200
+++ ./arch/um/kernel/tt/sys-i386/Makefile	2003-12-23 13:14:37.000000000 +0100
@@ -5,10 +5,6 @@
 
 obj-y = sigcontext.o
 
-USER_OBJS = sigcontext.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+UML_USER_OBJS += sigcontext.o
 
 clean :
--- ./arch/um/kernel/tt/Makefile.user_obj	2003-08-31 15:51:39.000000000 +0200
+++ ./arch/um/kernel/tt/Makefile	2003-12-23 13:14:37.000000000 +0100
@@ -11,17 +11,11 @@
 
 obj-$(CONFIG_PT_PROXY) += gdb_kern.o ptproxy/
 
-USER_OBJS := $(filter %_user.o,$(obj-y)) gdb.o time.o tracer.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+UML_USER_OBJS += gdb.o time.o tracer.o
 
 UNMAP_CFLAGS := $(patsubst -pg -DPROFILING,,$(USER_CFLAGS))
 UNMAP_CFLAGS := $(patsubst -fprofile-arcs -ftest-coverage,,$(UNMAP_CFLAGS))
 
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
-
-$(O_TARGET) : $(obj)/unmap_fin.o
-
 $(obj)/unmap.o: $(src)/unmap.c
 	$(CC) $(UNMAP_CFLAGS) -c -o $@ $<
 
--- ./arch/um/kernel/Makefile.user_obj	2003-12-02 17:20:43.000000000 +0100
+++ ./arch/um/kernel/Makefile	2003-12-23 17:28:25.000000000 +0100
@@ -25,35 +25,28 @@
 
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
-USER_OBJS := $(filter %_user.o,$(obj-y))  $(user-objs-y) config.o helper.o \
-	process.o tempfile.o time.o tty_log.o umid.o user_util.o user_syms.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+UML_USER_OBJS += $(user-objs-y) config.o helper.o \
+	process.o tempfile.o time.o tty_log.o umid.o user_util.o user_syms.o \
+	frame.o
 
 DMODULES-$(CONFIG_MODULES) = -D__CONFIG_MODULES__
 DMODVERSIONS-$(CONFIG_MODVERSIONS) = -D__CONFIG_MODVERSIONS__
 
-
 CFLAGS_user_syms.o = -D__AUTOCONF_INCLUDED__ $(DMODULES-y) $(DMODVERSIONS-y) \
 	-I/usr/include -I../include
 
-CFLAGS_frame.o := $(patsubst -fomit-frame-pointer,,$(USER_CFLAGS))
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
-
 # This has to be separate because it needs be compiled with frame pointers
 # regardless of how the rest of the kernel is built.
 
-$(obj)/frame.o: $(src)/frame.c
-	$(CC) $(CFLAGS_$(notdir $@)) -c -o $@ $<
+#$(obj)/frame.o: $(src)/frame.c
+#	$(CC) $(CFLAGS_$(notdir $@)) -c -o $@ $<
+CFLAGS_frame.o := -fno-omit-frame-pointer
 
 QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'
 
 $(obj)/config.c : $(src)/config.c.in $(TOPDIR)/.config
 	$(PERL) -e $(QUOTE) < $(src)/config.c.in > $@
 
-$(obj)/config.o : $(obj)/config.c
-
 modules:
 
 fastdep:
--- ./arch/um/os-Linux/drivers/Makefile.user_obj	2003-04-17 16:11:41.000000000 +0200
+++ ./arch/um/os-Linux/drivers/Makefile	2003-12-23 13:14:37.000000000 +0100
@@ -9,11 +9,3 @@
 obj-y = 
 obj-$(CONFIG_UML_NET_ETHERTAP) += ethertap.o
 obj-$(CONFIG_UML_NET_TUNTAP) += tuntap.o
-
-USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y)),$($(f)-objs))
-
-USER_OBJS = $(filter %_user.o,$(obj-y) $(USER_SINGLE_OBJS))
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
--- ./arch/um/os-Linux/Makefile.user_obj	2003-04-17 16:11:41.000000000 +0200
+++ ./arch/um/os-Linux/Makefile	2003-12-23 18:16:11.000000000 +0100
@@ -5,10 +5,7 @@
 
 obj-y = file.o process.o tty.o drivers/
 
-USER_OBJS := $(foreach file,file.o process.o tty.o,$(obj)/$(file))
-
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+UML_USER_OBJS += file.o process.o tty.o
 
 clean :
 
--- ./arch/um/sys-i386/Makefile.user_obj	2003-12-19 18:40:23.000000000 +0100
+++ ./arch/um/sys-i386/Makefile	2003-12-23 13:14:37.000000000 +0100
@@ -4,8 +4,7 @@
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
 
-USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+UML_USER_OBJS += bugs.o sigcontext.o fault.o
 
 SYMLINKS = semaphore.c highmem.c module.c
 SYMLINKS := $(foreach f,$(SYMLINKS),$(src)/$f)
@@ -21,9 +20,6 @@
 	ln -sf $(TOPDIR)/arch/i386/$($(notdir $1)-dir)/$(notdir $1) $1
 endef
 
-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
-
 $(SYMLINKS): 
 	$(call make_link,$@)
 

--Boundary-00=_7ae6/aoV5+s4l/l--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
