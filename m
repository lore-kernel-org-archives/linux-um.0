Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMBOQ-0001Uq-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 18 Nov 2003 11:20:06 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AMBOQ-0000mG-2V
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 18 Nov 2003 11:20:06 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_6Gnu/NNGdP67Hw0"
Message-Id: <200311182023.38333.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] [PATCH] Uml 2.4 makefiles and unresolved symbol
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 18 Nov 2003 20:23:38 +0100
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_6Gnu/NNGdP67Hw0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I bundle here two patches: the first fixes some unresolved symbols I got with 
certain modules. The places should be the right ones, I hope. Only I'm not 
sure if it's that easy to add EXPORT_SYMBOL() for symbols from glibc(I've not 
clear how it works when dynamically linking). Yes, I've seen user_syms.c.

The second cleans up the Uml makefiles, namely arch/um/fs/Makefile, 
fs/hppfs/Makefile and fs/hostfs/Makefile. Visible change is that they, being 
correct, don't install hostfs.o and hppfs.o modules twice.

Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN

--Boundary-00=_6Gnu/NNGdP67Hw0
Content-Type: text/x-diff;
  charset="us-ascii";
  name="export_symbols.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="export_symbols.patch"

--- ./arch/um/kernel/ksyms.c.symbols	2003-11-13 16:30:12.000000000 +0100
+++ ./arch/um/kernel/ksyms.c	2003-11-16 12:43:05.000000000 +0100
@@ -68,6 +68,7 @@
 EXPORT_SYMBOL(os_create_unix_socket);
 EXPORT_SYMBOL(os_connect_socket);
 EXPORT_SYMBOL(os_accept_connection);
+EXPORT_SYMBOL(os_ioctl_generic);
 EXPORT_SYMBOL(os_rcv_fd);
 EXPORT_SYMBOL(run_helper);
 EXPORT_SYMBOL(start_thread);
--- ./arch/um/kernel/user_syms.c.symbols	2003-11-13 16:30:13.000000000 +0100
+++ ./arch/um/kernel/user_syms.c	2003-11-16 12:42:08.000000000 +0100
@@ -112,5 +112,7 @@
 
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(strstr);
+EXPORT_SYMBOL(strlen);
+EXPORT_SYMBOL(printf);
 
 EXPORT_SYMBOL(find_iomem);

--Boundary-00=_6Gnu/NNGdP67Hw0
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fs_makefiles.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="fs_makefiles.patch"

--- ./arch/um/fs/hppfs/Makefile.saved	2003-11-13 16:30:11.000000000 +0100
+++ ./arch/um/fs/hppfs/Makefile	2003-11-18 15:12:38.000000000 +0100
@@ -1,6 +1,8 @@
-O_TARGET := hppfs.o
-obj-y = hppfs_kern.o #hppfs_user.o
-obj-m = $(O_TARGET)
+O_TARGET := built-in.o
+
+list-multi := hppfs.o 
+obj-$(CONFIG_HPPFS) += hppfs.o
+hppfs-objs := hppfs_kern.o #hppfs_user.o
 
 CFLAGS_hppfs_kern.o := $(CFLAGS)
 #CFLAGS_hppfs_user.o := $(USER_CFLAGS)
@@ -8,3 +10,8 @@
 override CFLAGS =  
 
 include $(TOPDIR)/Rules.make
+
+hppfs.o: $(hppfs-objs)
+
+$(list-multi) : # This doesn't work, but should : '%.o : $(%-objs)'
+	$(LD) -r -o $@ $($(patsubst %.o,%,$@)-objs)
--- ./arch/um/fs/hostfs/Makefile.saved	2003-11-13 16:30:11.000000000 +0100
+++ ./arch/um/fs/hostfs/Makefile	2003-11-18 15:04:55.000000000 +0100
@@ -7,18 +7,29 @@
 # to __st_ino.  It stayed in the same place, so as long as the correct name
 # is used, hostfs compiled on 2.2 should work on 2.4 and vice versa.
 
+O_TARGET := built-in.o
+
 STAT64_INO_FIELD := $(shell grep -q __st_ino /usr/include/bits/stat.h && \
 				echo __)st_ino
-
 USER_CFLAGS := $(USER_CFLAGS) -DSTAT64_INO_FIELD=$(STAT64_INO_FIELD)
 
-O_TARGET := hostfs.o
-obj-y = hostfs_kern.o hostfs_user.o
-obj-m = $(O_TARGET)
+# The code here
+list-multi := hostfs.o
+hostfs-objs := hostfs_kern.o hostfs_user.o
+
+obj-$(CONFIG_HOSTFS) += hostfs.o
 
-USER_OBJS = $(filter %_user.o,$(obj-y))
+# The known rules
+USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),$($(f)-objs))
+
+USER_OBJS = $(filter %_user.o,$(obj-y) $(obj-m) $(USER_SINGLE_OBJS))
 
 include $(TOPDIR)/Rules.make
 
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$@) $(USER_CFLAGS) -c -o $@ $<
+
+hostfs.o: $(hostfs-objs)
+
+$(list-multi) : # This doesn't work, but should : '%.o : $(%-objs)'
+	$(LD) -r -o $@ $($(patsubst %.o,%,$@)-objs)
--- ./arch/um/fs/Makefile.saved	2003-11-13 16:30:11.000000000 +0100
+++ ./arch/um/fs/Makefile	2003-11-18 14:48:12.000000000 +0100
@@ -5,15 +5,9 @@
 
 O_TARGET := built-in.o
 
-subdir-y =
-subdir-m =
-
 subdir-$(CONFIG_HOSTFS) += hostfs
 subdir-$(CONFIG_HPPFS) += hppfs
 
-obj-y += $(join $(subdir-y),$(subdir-y:%=/%.o))
-obj-m += $(join $(subdir-m),$(subdir-m:%=/%.o))
-
 include $(TOPDIR)/Rules.make
 
 dep:
--- ./arch/um/Makefile.saved	2003-11-13 16:30:13.000000000 +0100
+++ ./arch/um/Makefile	2003-11-18 15:32:05.000000000 +0100
@@ -8,7 +8,7 @@
 ARCH_DIR = arch/um
 
 core-y := kernel sys-$(SUBARCH) os-$(OS)
-drivers-y := fs drivers
+drivers-y := fs/hostfs fs/hppfs drivers
 subdir-y := $(core-y) $(drivers-y)
 SUBDIRS += $(foreach dir,$(subdir-y),$(ARCH_DIR)/$(dir))
 

--Boundary-00=_6Gnu/NNGdP67Hw0--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
