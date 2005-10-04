Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMqN1-0004I2-Qm	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 10:14:27 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EMqMy-0008DY-SR
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 10:14:27 -0700
From: Al Viro <viro@ftp.linux.org.uk>
Message-ID: <20051004171419.GJ7992@ftp.linux.org.uk>
References: <200510021213.40191.blaisorblade@yahoo.it>
	<20051002183758.GR7992@ftp.linux.org.uk>
	<20051002205451.GS7992@ftp.linux.org.uk>
	<200510032030.23705.blaisorblade@yahoo.it>
	<20051004170941.GI7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004170941.GI7992@ftp.linux.org.uk>
Subject: [uml-devel] Re: UML/2.6.14-rc3 doesn't work fixes
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
Date: Tue, 4 Oct 2005 18:14:19 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Alexander Viro <viro@zeniv.linux.org.uk>, sam@ravnborg.org

	Sorry - a line had leaked from later patch; correct variant follows

diff -urN RC14-rc3-git4-base/arch/um/Makefile-x86_64 RC14-rc3-git4-foo/arch/um/Makefile-x86_64
--- RC14-rc3-git4-base/arch/um/Makefile-x86_64	2005-09-12 14:33:28.000000000 -0400
+++ RC14-rc3-git4-foo/arch/um/Makefile-x86_64	2005-10-04 13:04:59.000000000 -0400
@@ -1,7 +1,7 @@
 # Copyright 2003 - 2004 Pathscale, Inc
 # Released under the GPL
 
-libs-y += arch/um/sys-x86_64/
+core-y += arch/um/sys-x86_64/
 START := 0x60000000
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
diff -urN RC14-rc3-git4-base/arch/um/scripts/Makefile.rules RC14-rc3-git4-foo/arch/um/scripts/Makefile.rules
--- RC14-rc3-git4-base/arch/um/scripts/Makefile.rules	2005-09-05 08:35:08.000000000 -0400
+++ RC14-rc3-git4-foo/arch/um/scripts/Makefile.rules	2005-10-04 13:04:59.000000000 -0400
@@ -26,19 +26,7 @@
 	$(patsubst -pg,,$(patsubst -fprofile-arcs -ftest-coverage,,$(1)))
 endef
 
-quiet_cmd_make_link = SYMLINK $@
-cmd_make_link       = ln -sf $(srctree)/arch/$(SUBARCH)/$($(notdir $@)-dir)/$(notdir $@) $@
-
-# this needs to be before the foreach, because targets does not accept
-# complete paths like $(obj)/$(f). To make sure this works, use a := assignment
-# or we will get $(obj)/$(f) in the "targets" value.
-# Also, this forces you to use the := syntax when assigning to targets.
-# Otherwise the line below will cause an infinite loop (if you don't know why,
-# just do it).
-
-targets := $(targets) $(SYMLINKS)
-
-SYMLINKS := $(foreach f,$(SYMLINKS),$(obj)/$(f))
-
-$(SYMLINKS): FORCE
-	$(call if_changed,make_link)
+ifdef subarch-obj-y
+obj-y += subarch.o
+subarch-y = $(addprefix ../../$(SUBARCH)/,$(subarch-obj-y))
+endif
diff -urN RC14-rc3-git4-base/arch/um/sys-i386/Makefile RC14-rc3-git4-foo/arch/um/sys-i386/Makefile
--- RC14-rc3-git4-base/arch/um/sys-i386/Makefile	2005-09-12 14:33:28.000000000 -0400
+++ RC14-rc3-git4-foo/arch/um/sys-i386/Makefile	2005-10-04 13:04:59.000000000 -0400
@@ -1,21 +1,16 @@
-obj-y = bitops.o bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
-	ptrace_user.o semaphore.o signal.o sigcontext.o stub.o stub_segv.o \
+obj-y = bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
+	ptrace_user.o signal.o sigcontext.o stub.o stub_segv.o \
 	syscalls.o sysrq.o sys_call_table.o
 
-obj-$(CONFIG_HIGHMEM) += highmem.o
-obj-$(CONFIG_MODULES) += module.o
+subarch-obj-y = lib/bitops.o kernel/semaphore.o
+subarch-obj-$(CONFIG_HIGHMEM) += mm/highmem.o
+subarch-obj-$(CONFIG_MODULES) += kernel/module.o
 
-USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
 
-SYMLINKS = bitops.c semaphore.c highmem.c module.c
+USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
 
 include arch/um/scripts/Makefile.rules
 
-bitops.c-dir = lib
-semaphore.c-dir = kernel
-highmem.c-dir = mm
-module.c-dir = kernel
-
 $(obj)/stub_segv.o : _c_flags = $(call unprofile,$(CFLAGS))
 
 include arch/um/scripts/Makefile.unmap
diff -urN RC14-rc3-git4-base/arch/um/sys-x86_64/Makefile RC14-rc3-git4-foo/arch/um/sys-x86_64/Makefile
--- RC14-rc3-git4-base/arch/um/sys-x86_64/Makefile	2005-09-12 14:33:28.000000000 -0400
+++ RC14-rc3-git4-foo/arch/um/sys-x86_64/Makefile	2005-10-04 13:04:59.000000000 -0400
@@ -4,29 +4,18 @@
 # Licensed under the GPL
 #
 
-#XXX: why into lib-y?
-lib-y = bitops.o bugs.o csum-partial.o delay.o fault.o mem.o memcpy.o \
-	ptrace.o ptrace_user.o sigcontext.o signal.o stub.o \
-	stub_segv.o syscalls.o syscall_table.o sysrq.o thunk.o
+obj-y = bugs.o delay.o fault.o mem.o ptrace.o ptrace_user.o sigcontext.o \
+	signal.o stub.o stub_segv.o syscalls.o syscall_table.o sysrq.o ksyms.o
 
-obj-y := ksyms.o
-obj-$(CONFIG_MODULES) += module.o um_module.o
+obj-$(CONFIG_MODULES) += um_module.o
 
-USER_OBJS := ptrace_user.o sigcontext.o
+subarch-obj-y = lib/bitops.o lib/csum-partial.o lib/memcpy.o lib/thunk.o
+subarch-obj-$(CONFIG_MODULES) += kernel/module.o
 
-SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c memcpy.S \
-	thunk.S module.c
+USER_OBJS := ptrace_user.o sigcontext.o
 
 include arch/um/scripts/Makefile.rules
 
-bitops.c-dir = lib
-csum-copy.S-dir = lib
-csum-partial.c-dir = lib
-csum-wrappers.c-dir = lib
-memcpy.S-dir = lib
-thunk.S-dir = lib
-module.c-dir = kernel
-
 $(obj)/stub_segv.o: _c_flags = $(call unprofile,$(CFLAGS))
 
 include arch/um/scripts/Makefile.unmap


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
