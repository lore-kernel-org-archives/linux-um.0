Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2V75-0002V5-Ub for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Feb 2005 05:57:39 -0800
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D2V75-0000U0-D5 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Feb 2005 05:57:39 -0800
Subject: Re: [uml-devel] Re: [PATCH] uml: support a separate build tree;
	support USER_OBJS dependencies
References: <opsl43d9yilfdzum@localhost.localdomain>
	<200502132151.j1DLoxnW003492@ccure.user-mode-linux.org>
	<opsl5r02lclfdzum@localhost.localdomain>
	<200502161930.55206.blaisorblade@yahoo.it>
From: "Vadim Abrossimov" <vadim_abrossimov@yahoo.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opsmf6p3ellfdzum@localhost.localdomain>
In-Reply-To: <200502161930.55206.blaisorblade@yahoo.it>
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
Date: Sat, 19 Feb 2005 15:04:41 +0100
To: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Wed, 16 Feb 2005 19:30:54 +0100, Blaisorblade <blaisorblade@yahoo.it>  
wrote:

> Ok, I have two more requests, if possible:
> 1) add something like arch/um/Rules.make which is included everywhere  
> needed

Find below the patch which implements Paolo's suggestion with one  
exception:
I put the common definitions in arch/um/scripts/Makefile.rules to be more  
consistent
with my understanding of conventions.

I did the patch against Jeff's tarball  
(http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.11-rc3-mm2/patches.tar)
the way it may be added to the end of the existing quilt 'series'.
Make me know if you think useful to do it also against some other versions.

Also I noticed that including my original patch in his tarball Jeff  
excluded changes
in some Makefiles (e.g. arch/um/kernel/Makefile).
Jeff, had you a problem with those Makefiles?

Dima


Signed-off-by: Vadim Abrossimov <Vadim_Abrossimov@yahoo.com>

---

#
# Move similar definitions from Makefiles to the newly created
# arch/um/scripts/Makefile.rules and include it everywhere needed
#
Index: 2.6.11-rc3-mm2-jd/arch/um/drivers/Makefile
===================================================================
--- 2.6.11-rc3-mm2-jd.orig/arch/um/drivers/Makefile	2005-02-19  
12:22:20.502114912 +0100
+++ 2.6.11-rc3-mm2-jd/arch/um/drivers/Makefile	2005-02-19  
13:34:08.258236440 +0100
@@ -50,9 +50,7 @@

  USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y)  
$(obj-m)),$($(f)-objs))

-USER_OBJS := $(filter %_user.o,$(obj-y) $(obj-m) $(USER_SINGLE_OBJS))  
fd.o \
+USER_OBJS := $(filter %_user.o, $(USER_SINGLE_OBJS)) fd.o \
  	null.o pty.o tty.o xterm.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))

-$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@)) \
-	$(USER_CFLAGS)
+include arch/um/scripts/Makefile.rules
Index: 2.6.11-rc3-mm2-jd/arch/um/kernel/Makefile
===================================================================
--- 2.6.11-rc3-mm2-jd.orig/arch/um/kernel/Makefile	2005-02-19  
12:22:19.391283784 +0100
+++ 2.6.11-rc3-mm2-jd/arch/um/kernel/Makefile	2005-02-19  
13:57:23.414140504 +0100
@@ -23,14 +23,12 @@

  user-objs-$(CONFIG_TTY_LOG) += tty_log.o

-USER_OBJS := $(filter %_user.o,$(obj-y))  $(user-objs-y) config.o  
helper.o \
+USER_OBJS := $(user-objs-y) config.o helper.o \
  	main.o time.o tty_log.o umid.o user_util.o frame.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))

  CFLAGS_frame.o := -fno-omit-frame-pointer

-$(USER_OBJS) : %.o: %.c
-	$(CC) $(USER_CFLAGS) $(CFLAGS_$(notdir $@)) -c -o $@ $<
+include arch/um/scripts/Makefile.rules

  targets += config.c

@@ -54,3 +52,4 @@
  		  -e 'a""\;'                   \
  		  -e '}'                       \
  		  $< > $@
+
Index: 2.6.11-rc3-mm2-jd/arch/um/kernel/skas/Makefile
===================================================================
--- 2.6.11-rc3-mm2-jd.orig/arch/um/kernel/skas/Makefile	2005-02-19  
12:22:20.502114912 +0100
+++ 2.6.11-rc3-mm2-jd/arch/um/kernel/skas/Makefile	2005-02-19  
13:59:08.706133688 +0100
@@ -6,10 +6,8 @@
  obj-y := exec_kern.o mem.o mem_user.o mmu.o process.o process_kern.o \
  	syscall_kern.o syscall_user.o time.o tlb.o trap_user.o uaccess.o \

-USER_OBJS = $(filter %_user.o,$(obj-y)) process.o time.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+USER_OBJS := process.o time.o

-$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@)) \
-	$(USER_CFLAGS)
+include arch/um/scripts/Makefile.rules

  subdir- := util
Index: 2.6.11-rc3-mm2-jd/arch/um/kernel/tt/Makefile
===================================================================
--- 2.6.11-rc3-mm2-jd.orig/arch/um/kernel/tt/Makefile	2005-02-19  
12:22:20.502114912 +0100
+++ 2.6.11-rc3-mm2-jd/arch/um/kernel/tt/Makefile	2005-02-19  
14:03:37.951202216 +0100
@@ -12,14 +12,12 @@

  obj-$(CONFIG_PT_PROXY) += gdb_kern.o ptproxy/

-USER_OBJS := $(filter %_user.o,$(obj-y)) gdb.o time.o tracer.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+USER_OBJS := gdb.o time.o tracer.o

  UNMAP_CFLAGS := $(patsubst -pg -DPROFILING,,$(USER_CFLAGS))
  UNMAP_CFLAGS := $(patsubst -fprofile-arcs  
-ftest-coverage,,$(UNMAP_CFLAGS))

-$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@)) \
-	$(USER_CFLAGS)
+include arch/um/scripts/Makefile.rules

  $(obj)/unmap.o: c_flags = -Wp,-MD,$(depfile) $(UNMAP_CFLAGS)

Index: 2.6.11-rc3-mm2-jd/arch/um/kernel/tt/ptproxy/Makefile
===================================================================
--- 2.6.11-rc3-mm2-jd.orig/arch/um/kernel/tt/ptproxy/Makefile	2005-02-19  
12:22:20.598100320 +0100
+++ 2.6.11-rc3-mm2-jd/arch/um/kernel/tt/ptproxy/Makefile	2005-02-19  
14:07:00.607393792 +0100
@@ -5,7 +5,6 @@

  obj-y = proxy.o ptrace.o sysdep.o wait.o

-USER_OBJS := $(foreach file,$(obj-y),$(src)/$(file))
+USER_OBJS := $(obj-y)

-$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@)) \
-	$(USER_CFLAGS)
+include arch/um/scripts/Makefile.rules
Index: 2.6.11-rc3-mm2-jd/arch/um/os-Linux/Makefile
===================================================================
--- 2.6.11-rc3-mm2-jd.orig/arch/um/os-Linux/Makefile	2005-02-19  
12:22:20.598100320 +0100
+++ 2.6.11-rc3-mm2-jd/arch/um/os-Linux/Makefile	2005-02-19  
14:14:03.290136248 +0100
@@ -8,9 +8,7 @@

  USER_OBJS := aio.o elf_aux.o file.o mem.o process.o signal.o start_up.o \
  	time.o tt.o tty.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
-
-$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@)) \
-	$(USER_CFLAGS)

  CFLAGS_user_syms.o += -DSUBARCH_$(SUBARCH)
+
+include arch/um/scripts/Makefile.rules
Index: 2.6.11-rc3-mm2-jd/arch/um/os-Linux/drivers/Makefile
===================================================================
--- 2.6.11-rc3-mm2-jd.orig/arch/um/os-Linux/drivers/Makefile	2005-02-19  
12:22:20.599100168 +0100
+++ 2.6.11-rc3-mm2-jd/arch/um/os-Linux/drivers/Makefile	2005-02-19  
14:12:22.882400544 +0100
@@ -12,8 +12,7 @@

  USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y)),$($(f)-objs))

-USER_OBJS = $(filter %_user.o,$(obj-y) $(USER_SINGLE_OBJS))
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+USER_OBJS := $(filter %_user.o, $(USER_SINGLE_OBJS))
+
+include arch/um/scripts/Makefile.rules

-$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@)) \
-	$(USER_CFLAGS)
Index: 2.6.11-rc3-mm2-jd/arch/um/scripts/Makefile.rules
===================================================================
--- 2.6.11-rc3-mm2-jd.orig/arch/um/scripts/Makefile.rules	2004-02-23  
22:02:56.000000000 +0100
+++ 2.6.11-rc3-mm2-jd/arch/um/scripts/Makefile.rules	2005-02-19  
13:37:33.195081304 +0100
@@ -0,0 +1,8 @@
+#  
===========================================================================
+# arch/um: Generic definitions
+#  
===========================================================================
+
+USER_OBJS += $(filter %_user.o,$(obj-y) $(obj-m))
+USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+
+$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS)  
$(CFLAGS_$(notdir $@))
Index: 2.6.11-rc3-mm2-jd/arch/um/sys-i386/Makefile
===================================================================
--- 2.6.11-rc3-mm2-jd.orig/arch/um/sys-i386/Makefile	2005-02-19  
12:22:20.599100168 +0100
+++ 2.6.11-rc3-mm2-jd/arch/um/sys-i386/Makefile	2005-02-19  
14:16:07.505252680 +0100
@@ -6,7 +6,6 @@
  obj-$(CONFIG_MODULES) += module.o

  USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
-USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))

  SYMLINKS = bitops.c semaphore.c highmem.c module.c

@@ -26,8 +25,7 @@
  	ln -sf $(srctree)/arch/i386/$($(notdir $1)-dir)/$(notdir $1) $1
  endef

-$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@)) \
-	$(USER_CFLAGS)
+include arch/um/scripts/Makefile.rules

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
