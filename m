Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfQ05-000604-1o	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:23:17 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DfQ04-0007Io-1F	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:23:16 -0700
Message-Id: <200506062008.j56K89YA008957@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/5] UML - Clean up tt mode remapping of UML
	binary
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
Date: Mon, 06 Jun 2005 16:08:09 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From Al Viro - this turns the tt mode remapping of the binary into arch 
code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/Makefile
===================================================================
--- linux-2.6.12-rc.orig/arch/um/Makefile	2005-06-02 17:04:01.000000000 -0400
+++ linux-2.6.12-rc/arch/um/Makefile	2005-06-06 11:36:06.000000000 -0400
@@ -119,7 +119,7 @@ ifndef START
   START = $$(($(TOP_ADDR) - $(SIZE)))
 endif
 
-CPPFLAGS_vmlinux.lds = $(shell echo -U$(SUBARCH) \
+CPPFLAGS_vmlinux.lds = $(shell echo -U$(SUBARCH) -I$(SYS_DIR) \
 	-DSTART=$(START) -DELF_ARCH=$(ELF_ARCH) \
 	-DELF_FORMAT=\"$(ELF_FORMAT)\" $(CPP_MODE-y) \
 	-DKERNEL_STACK_SIZE=$(STACK_SIZE))
Index: linux-2.6.12-rc/arch/um/include/sysdep-i386/unmap.lds
===================================================================
--- linux-2.6.12-rc.orig/arch/um/include/sysdep-i386/unmap.lds	2005-06-06 05:54:35.815704808 -0400
+++ linux-2.6.12-rc/arch/um/include/sysdep-i386/unmap.lds	2005-06-02 17:04:44.000000000 -0400
@@ -0,0 +1,14 @@
+  .thread_private : {
+    __start_thread_private = .;
+    errno = .;
+    . += 4;
+    arch/um/sys-i386/unmap_fin.o (.bss)
+    __end_thread_private = .;
+  }
+  . = ALIGN(4096);
+  .remap : { arch/um/sys-i386/unmap_fin.o (.text) }
+
+  /* We want it only if we are in MODE_TT. In both cases, however, when MODE_TT
+   * is off the resulting binary segfaults.*/
+
+  . = ALIGN(4096);		/* Init code and data */
Index: linux-2.6.12-rc/arch/um/include/sysdep-x86_64/unmap.lds
===================================================================
--- linux-2.6.12-rc.orig/arch/um/include/sysdep-x86_64/unmap.lds	2005-06-06 05:54:35.815704808 -0400
+++ linux-2.6.12-rc/arch/um/include/sysdep-x86_64/unmap.lds	2005-06-02 17:04:44.000000000 -0400
@@ -0,0 +1,6 @@
+  . = ALIGN(4096);		/* Init code and data */
+  .remap : {
+	arch/um/sys-x86_64/unmap_fin.o (.bss)
+	arch/um/sys-x86_64/unmap_fin.o (.text)
+  }
+  . = ALIGN(4096);		/* Init code and data */
Index: linux-2.6.12-rc/arch/um/kernel/tt/Makefile
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/tt/Makefile	2005-06-02 17:04:01.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/tt/Makefile	2005-06-06 11:52:11.000000000 -0400
@@ -3,10 +3,6 @@
 # Licensed under the GPL
 #
 
-extra-y := unmap_fin.o
-targets := unmap.o
-clean-files := unmap_tmp.o
-
 obj-y = exec_kern.o exec_user.o gdb.o ksyms.o mem.o mem_user.o process_kern.o \
 	syscall_kern.o syscall_user.o time.o tlb.o tracer.o trap_user.o \
 	uaccess.o uaccess_user.o
@@ -16,14 +12,3 @@ obj-$(CONFIG_PT_PROXY) += gdb_kern.o ptp
 USER_OBJS := gdb.o time.o tracer.o
 
 include arch/um/scripts/Makefile.rules
-
-UNMAP_CFLAGS := $(patsubst -pg -DPROFILING,,$(USER_CFLAGS))
-UNMAP_CFLAGS := $(patsubst -fprofile-arcs -ftest-coverage,,$(UNMAP_CFLAGS))
-
-#XXX: partially copied from arch/um/scripts/Makefile.rules
-$(obj)/unmap.o: c_flags = -Wp,-MD,$(depfile) $(UNMAP_CFLAGS)
-
-$(obj)/unmap_fin.o : $(obj)/unmap.o
-	$(LD) -r -o $(obj)/unmap_tmp.o $< $(shell $(CC) -print-file-name=libc.a)
-	$(OBJCOPY) $(obj)/unmap_tmp.o $@ -G switcheroo
-
Index: linux-2.6.12-rc/arch/um/kernel/tt/unmap.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/tt/unmap.c	2005-06-02 17:04:01.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/tt/unmap.c	2005-06-06 05:54:35.815704808 -0400
@@ -1,31 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <sys/mman.h>
-
-int switcheroo(int fd, int prot, void *from, void *to, int size)
-{
-	if(munmap(to, size) < 0){
-		return(-1);
-	}
-	if(mmap(to, size, prot,	MAP_SHARED | MAP_FIXED, fd, 0) != to){
-		return(-1);
-	}
-	if(munmap(from, size) < 0){
-		return(-1);
-	}
-	return(0);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.12-rc/arch/um/kernel/uml.lds.S
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/uml.lds.S	2005-06-02 17:04:01.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/uml.lds.S	2005-06-06 11:52:10.000000000 -0400
@@ -15,20 +15,7 @@ SECTIONS
    * is remapped.*/
   __binary_start = .;
 #ifdef MODE_TT
-  .thread_private : {
-    __start_thread_private = .;
-    errno = .;
-    . += 4;
-    arch/um/kernel/tt/unmap_fin.o (.data)
-    __end_thread_private = .;
-  }
-  . = ALIGN(4096);
-  .remap : { arch/um/kernel/tt/unmap_fin.o (.text) }
-
-  /* We want it only if we are in MODE_TT. In both cases, however, when MODE_TT
-   * is off the resulting binary segfaults.*/
-
-  . = ALIGN(4096);		/* Init code and data */
+#include <unmap.lds>
 #endif
 
   _stext = .;
Index: linux-2.6.12-rc/arch/um/scripts/Makefile.rules
===================================================================
--- linux-2.6.12-rc.orig/arch/um/scripts/Makefile.rules	2005-06-06 12:14:26.000000000 -0400
+++ linux-2.6.12-rc/arch/um/scripts/Makefile.rules	2005-06-06 12:15:45.000000000 -0400
@@ -10,6 +10,11 @@ USER_OBJS := $(foreach file,$(USER_OBJS)
 $(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) \
 	$(CFLAGS_$(notdir $@))
 
+# The stubs and unmap.o can't try to call mcount or update basic block data
+define unprofile
+	$(patsubst -pg,,$(patsubst -fprofile-arcs -ftest-coverage,,$(1)))
+endef
+
 quiet_cmd_make_link = SYMLINK $@
 cmd_make_link       = ln -sf $(srctree)/arch/$(SUBARCH)/$($(notdir $@)-dir)/$(notdir $@) $@
 
Index: linux-2.6.12-rc/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.12-rc.orig/arch/um/sys-i386/Makefile	2005-06-02 17:04:01.000000000 -0400
+++ linux-2.6.12-rc/arch/um/sys-i386/Makefile	2005-06-06 11:52:10.000000000 -0400
@@ -2,6 +2,8 @@ obj-y = bitops.o bugs.o checksum.o delay
 	ptrace_user.o semaphore.o signal.o sigcontext.o syscalls.o sysrq.o \
 	sys_call_table.o
 
+extra-$(CONFIG_MODE_TT) := unmap_fin.o
+
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
 
@@ -16,4 +18,6 @@ semaphore.c-dir = kernel
 highmem.c-dir = mm
 module.c-dir = kernel
 
+$(obj)/unmap_fin.o : _c_flags = $(call unprofile,$(CFLAGS))
+
 subdir- := util
Index: linux-2.6.12-rc/arch/um/sys-i386/unmap_fin.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/sys-i386/unmap_fin.c	2005-06-06 05:54:35.815704808 -0400
+++ linux-2.6.12-rc/arch/um/sys-i386/unmap_fin.c	2005-06-03 15:36:17.000000000 -0400
@@ -0,0 +1,25 @@
+/* 
+ * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <linux/mman.h>
+#include <asm/unistd.h>
+
+static int errno;
+
+static inline _syscall2(int,munmap,void *,start,size_t,len)
+static inline _syscall6(void *,mmap2,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
+int switcheroo(int fd, int prot, void *from, void *to, int size)
+{
+        if(munmap(to, size) < 0){
+                return(-1);
+        }
+        if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
+                return(-1);
+        }
+        if(munmap(from, size) < 0){
+                return(-1);
+        }
+        return(0);
+}
Index: linux-2.6.12-rc/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.12-rc.orig/arch/um/sys-x86_64/Makefile	2005-06-02 17:04:01.000000000 -0400
+++ linux-2.6.12-rc/arch/um/sys-x86_64/Makefile	2005-06-06 11:52:10.000000000 -0400
@@ -4,6 +4,8 @@
 # Licensed under the GPL
 #
 
+extra-$(CONFIG_MODE_TT) := unmap_fin.o
+
 #XXX: why into lib-y?
 lib-y = bitops.o bugs.o csum-partial.o delay.o fault.o mem.o memcpy.o \
 	ptrace.o ptrace_user.o semaphore.o sigcontext.o signal.o \
@@ -29,3 +31,5 @@ thunk.S-dir = lib
 module.c-dir = kernel
 
 subdir- := util
+
+$(obj)/unmap_fin.o: _c_flags = $(call unprofile,$(CFLAGS))
Index: linux-2.6.12-rc/arch/um/sys-x86_64/unmap_fin.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/sys-x86_64/unmap_fin.c	2005-06-06 05:54:35.815704808 -0400
+++ linux-2.6.12-rc/arch/um/sys-x86_64/unmap_fin.c	2005-06-02 17:04:44.000000000 -0400
@@ -0,0 +1,25 @@
+/* 
+ * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <linux/mman.h>
+#include <asm/unistd.h>
+
+static int errno;
+
+static inline _syscall2(int,munmap,void *,start,size_t,len)
+static inline _syscall6(void *,mmap,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
+int switcheroo(int fd, int prot, void *from, void *to, int size)
+{
+        if(munmap(to, size) < 0){
+                return(-1);
+        }
+        if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
+                return(-1);
+        }
+        if(munmap(from, size) < 0){
+                return(-1);
+        }
+        return(0);
+}



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
