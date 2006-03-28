Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FON9G-0005aK-3Q for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:58:50 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FON9F-00059b-TX
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:58:50 -0800
Message-Id: <200603282300.k2SN08LA022977@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/10] UML - Clean up remapping code build magic
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
Date: Tue, 28 Mar 2006 18:00:08 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk

From: Al Viro <viro@zeniv.linux.org.uk>
uml: kills unmap magic
 
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

 arch/um/Makefile               |    2 +-
 arch/um/scripts/Makefile.unmap |   22 ----------------------
 arch/um/sys-i386/Makefile      |    5 +++--
 arch/um/sys-x86_64/Makefile    |    5 +++--
 4 files changed, 7 insertions(+), 27 deletions(-)
 delete mode 100644 arch/um/scripts/Makefile.unmap

Index: linux-2.6.16-mm/arch/um/Makefile
===================================================================
--- linux-2.6.16-mm.orig/arch/um/Makefile	2006-03-28 09:30:36.000000000 -0500
+++ linux-2.6.16-mm/arch/um/Makefile	2006-03-28 09:34:20.000000000 -0500
@@ -129,7 +129,7 @@ CPPFLAGS_vmlinux.lds = -U$(SUBARCH) \
 	-DSTART=$(START) -DELF_ARCH=$(ELF_ARCH) \
 	-DELF_FORMAT="$(ELF_FORMAT)" $(CPP_MODE-y) \
 	-DKERNEL_STACK_SIZE=$(STACK_SIZE) \
-	-DUNMAP_PATH=arch/um/sys-$(SUBARCH)/unmap_fin.o
+	-DUNMAP_PATH=arch/um/sys-$(SUBARCH)/unmap.o
 
 #The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
Index: linux-2.6.16-mm/arch/um/scripts/Makefile.unmap
===================================================================
--- linux-2.6.16-mm.orig/arch/um/scripts/Makefile.unmap	2005-10-28 12:58:12.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,22 +0,0 @@
-clean-files += unmap_tmp.o unmap_fin.o unmap.o
-
-ifdef CONFIG_MODE_TT
-
-#Always build unmap_fin.o
-extra-y += unmap_fin.o
-#Do dependency tracking for unmap.o (it will be always built, but won't get the tracking unless we use this).
-targets += unmap.o
-
-#XXX: partially copied from arch/um/scripts/Makefile.rules
-$(obj)/unmap.o: _c_flags = $(call unprofile,$(CFLAGS))
-
-quiet_cmd_wrapld = LD      $@
-define cmd_wrapld
-	$(LD) $(LDFLAGS) -r -o $(obj)/unmap_tmp.o $< ; \
-	$(OBJCOPY) $(UML_OBJCOPYFLAGS) $(obj)/unmap_tmp.o $@ -G switcheroo
-endef
-
-$(obj)/unmap_fin.o : $(obj)/unmap.o FORCE
-	$(call if_changed,wrapld)
-
-endif
Index: linux-2.6.16-mm/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.16-mm.orig/arch/um/sys-i386/Makefile	2006-03-28 09:34:18.000000000 -0500
+++ linux-2.6.16-mm/arch/um/sys-i386/Makefile	2006-03-28 09:34:20.000000000 -0500
@@ -11,6 +11,7 @@ USER_OBJS := bugs.o ptrace_user.o sigcon
 
 include arch/um/scripts/Makefile.rules
 
-$(obj)/stub_segv.o : _c_flags = $(call unprofile,$(CFLAGS))
+extra-$(CONFIG_MODE_TT) += unmap.o
 
-include arch/um/scripts/Makefile.unmap
+$(obj)/stub_segv.o $(obj)/unmap.o: \
+	_c_flags = $(call unprofile,$(CFLAGS))
Index: linux-2.6.16-mm/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.16-mm.orig/arch/um/sys-x86_64/Makefile	2006-03-28 09:34:18.000000000 -0500
+++ linux-2.6.16-mm/arch/um/sys-x86_64/Makefile	2006-03-28 09:34:20.000000000 -0500
@@ -19,6 +19,7 @@ USER_OBJS := ptrace_user.o sigcontext.o 
 
 include arch/um/scripts/Makefile.rules
 
-$(obj)/stub_segv.o: _c_flags = $(call unprofile,$(CFLAGS))
+extra-$(CONFIG_MODE_TT) += unmap.o
 
-include arch/um/scripts/Makefile.unmap
+$(obj)/stub_segv.o $(obj)/unmap.o: \
+	_c_flags = $(call unprofile,$(CFLAGS))



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
