Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0Sn6-0001SU-VR for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Feb 2005 15:04:36 -0800
Received: from smtp108.mail.sc5.yahoo.com ([66.163.170.6])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D0Sn5-0004hK-9F for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Feb 2005 15:04:36 -0800
Subject: Re: [uml-devel] Re: [PATCH] uml: support a separate build tree;
	support USER_OBJS dependencies
References: <opsl43d9yilfdzum@localhost.localdomain>
	<200502131813.j1DICsnW002251@ccure.user-mode-linux.org>
	<20050213164652.GE8859@parcelfarce.linux.theplanet.co.uk>
	<opsl5gb1holfdzum@localhost.localdomain>
	<200502132151.j1DLoxnW003492@ccure.user-mode-linux.org>
From: "Vadim Abrossimov" <vadim_abrossimov@yahoo.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opsl5r02lclfdzum@localhost.localdomain>
In-Reply-To: <200502132151.j1DLoxnW003492@ccure.user-mode-linux.org>
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
Date: Mon, 14 Feb 2005 00:11:16 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Sun, 13 Feb 2005 16:50:59 -0500, Jeff Dike <jdike@addtoit.com> wrote:

>
> Yup, that would be useful.
>

Quite simple.

BTW, after application of all patches from your tarboll I got an error  
compiling kernel-offsets.c.
I solve it adding the following dependency:

diff -rup 2.6.11-rc3.orig/arch/um/Makefile-i386  
2.6.11-rc3/arch/um/Makefile-i386
--- 2.6.11-rc3.orig/arch/um/Makefile-i386	2005-02-13 23:31:35.116344504  
+0100
+++ 2.6.11-rc3/arch/um/Makefile-i386	2005-02-13 23:11:31.344345664 +0100
@@ -36,6 +36,7 @@ CLEAN_FILES += $(ARCH_DIR)/user-offsets.

  $(ARCH_DIR)/kernel-offsets.s: $(SUBARCH_CORE)/kernel-offsets.c \
  				   $(ARCH_SYMLINKS) \
+				   $(ARCH_DIR)/include/user_constants.h \
  				   $(SYS_DIR)/sc.h \
  				   include/asm include/linux/version.h \
  				   include/config/MARKER

This is the patch for USER_OBJS:

---

diff -rup 2.6.11-rc3.orig/arch/um/drivers/Makefile  
2.6.11-rc3/arch/um/drivers/Makefile
--- 2.6.11-rc3.orig/arch/um/drivers/Makefile	2005-02-13 23:31:34.754399528  
+0100
+++ 2.6.11-rc3/arch/um/drivers/Makefile	2005-02-13 23:21:05.547053584 +0100
@@ -54,5 +54,4 @@ USER_OBJS := $(filter %_user.o,$(obj-y)
  	null.o pty.o tty.o xterm.o
  USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)
diff -rup 2.6.11-rc3.orig/arch/um/kernel/Makefile  
2.6.11-rc3/arch/um/kernel/Makefile
--- 2.6.11-rc3.orig/arch/um/kernel/Makefile	2005-02-13 23:31:35.118344200  
+0100
+++ 2.6.11-rc3/arch/um/kernel/Makefile	2005-02-13 23:21:43.820235176 +0100
@@ -29,8 +29,7 @@ USER_OBJS := $(foreach file,$(USER_OBJS)

  CFLAGS_frame.o := -fno-omit-frame-pointer

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(USER_CFLAGS) $(CFLAGS_$(notdir $@)) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS)  
$(CFLAGS_$(notdir $@))

  targets += config.c
diff -rup 2.6.11-rc3.orig/arch/um/kernel/skas/Makefile  
2.6.11-rc3/arch/um/kernel/skas/Makefile
--- 2.6.11-rc3.orig/arch/um/kernel/skas/Makefile	2005-02-13  
23:30:36.017328920 +0100
+++ 2.6.11-rc3/arch/um/kernel/skas/Makefile	2005-02-13 23:22:10.380197448  
+0100
@@ -9,7 +9,6 @@ obj-y := exec_kern.o mem.o mem_user.o mm
  USER_OBJS = $(filter %_user.o,$(obj-y)) process.o time.o
  USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)

  subdir- := util
diff -rup 2.6.11-rc3.orig/arch/um/kernel/tt/Makefile  
2.6.11-rc3/arch/um/kernel/tt/Makefile
--- 2.6.11-rc3.orig/arch/um/kernel/tt/Makefile	2005-02-13  
23:31:35.120343896 +0100
+++ 2.6.11-rc3/arch/um/kernel/tt/Makefile	2005-02-13 23:23:21.856331424  
+0100
@@ -18,11 +18,9 @@ USER_OBJS := $(foreach file,$(USER_OBJS)
  UNMAP_CFLAGS := $(patsubst -pg -DPROFILING,,$(USER_CFLAGS))
  UNMAP_CFLAGS := $(patsubst -fprofile-arcs  
-ftest-coverage,,$(UNMAP_CFLAGS))

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)

-$(obj)/unmap.o: $(src)/unmap.c
-	$(CC) $(UNMAP_CFLAGS) -c -o $@ $<
+$(obj)/unmap.o: c_flags = -Wp,-MD,$(depfile) $(UNMAP_CFLAGS)

  $(obj)/unmap_fin.o : $(obj)/unmap.o
  	$(LD) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) -print-file-name=libc.a)
diff -rup 2.6.11-rc3.orig/arch/um/kernel/tt/ptproxy/Makefile  
2.6.11-rc3/arch/um/kernel/tt/ptproxy/Makefile
--- 2.6.11-rc3.orig/arch/um/kernel/tt/ptproxy/Makefile	2005-02-03  
02:55:40.000000000 +0100
+++ 2.6.11-rc3/arch/um/kernel/tt/ptproxy/Makefile	2005-02-13  
23:24:03.203045768 +0100
@@ -7,5 +7,4 @@ obj-y = proxy.o ptrace.o sysdep.o wait.o

  USER_OBJS := $(foreach file,$(obj-y),$(src)/$(file))

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)
diff -rup 2.6.11-rc3.orig/arch/um/os-Linux/drivers/Makefile  
2.6.11-rc3/arch/um/os-Linux/drivers/Makefile
--- 2.6.11-rc3.orig/arch/um/os-Linux/drivers/Makefile	2005-02-03  
02:55:50.000000000 +0100
+++ 2.6.11-rc3/arch/um/os-Linux/drivers/Makefile	2005-02-13  
23:24:56.239982928 +0100
@@ -15,5 +15,4 @@ USER_SINGLE_OBJS = $(foreach f,$(patsubs
  USER_OBJS = $(filter %_user.o,$(obj-y) $(USER_SINGLE_OBJS))
  USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)
diff -rup 2.6.11-rc3.orig/arch/um/os-Linux/Makefile  
2.6.11-rc3/arch/um/os-Linux/Makefile
--- 2.6.11-rc3.orig/arch/um/os-Linux/Makefile	2005-02-13  
23:31:33.859535568 +0100
+++ 2.6.11-rc3/arch/um/os-Linux/Makefile	2005-02-13 23:24:35.699105616  
+0100
@@ -10,7 +10,6 @@ USER_OBJS := aio.o elf_aux.o file.o mem.
  	time.o tt.o tty.o
  USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)

  CFLAGS_user_syms.o += -DSUBARCH_$(SUBARCH)
diff -rup 2.6.11-rc3.orig/arch/um/sys-i386/Makefile  
2.6.11-rc3/arch/um/sys-i386/Makefile
--- 2.6.11-rc3.orig/arch/um/sys-i386/Makefile	2005-02-13  
23:31:35.120343896 +0100
+++ 2.6.11-rc3/arch/um/sys-i386/Makefile	2005-02-13 23:26:06.141356304  
+0100
@@ -26,8 +26,7 @@ define make_link
  	ln -sf $(srctree)/arch/i386/$($(notdir $1)-dir)/$(notdir $1) $1
  endef

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))  
$(USER_CFLAGS)

  $(SYMLINKS):
  	$(call make_link,$@)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
