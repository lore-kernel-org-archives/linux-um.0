Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtsSV-0006QA-9L for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Jan 2005 11:04:07 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CtsSU-0005Pc-Ev for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Jan 2005 11:04:07 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050126190318.B4F084AB0@zion>
Subject: [uml-devel] [patch 1/1] uml: Kconfig_arch little cleanup (to merge
	before 2.6.11)
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
Date: Wed, 26 Jan 2005 20:03:18 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


arch/um/Kconfig_arch is actually a symlink, so
* Remove it from the tree.
* Make sure it is removed during make mrproper.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Makefile |    8 ++++++--
 linux-2.6.11/arch/um/Kconfig_arch   |   16 ----------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff -L arch/um/Kconfig_arch -puN arch/um/Kconfig_arch~uml-quick-fix-Makefile /dev/null
--- linux-2.6.11/arch/um/Kconfig_arch
+++ /dev/null	2005-01-24 17:16:49.498209144 +0100
@@ -1,16 +0,0 @@
-config 64_BIT
-	bool
-	default n
-
-config TOP_ADDR
- 	hex
- 	default 0xc0000000 if !HOST_2G_2G
- 	default 0x80000000 if HOST_2G_2G
-
-config 3_LEVEL_PGTABLES
-	bool "Three-level pagetables"
-	default n
-	help
-	Three-level pagetables will let UML have more than 4G of physical
-	memory.  All the memory that can't be mapped directly will be treated
-	as high memory.
diff -puN arch/um/Makefile~uml-quick-fix-Makefile arch/um/Makefile
--- linux-2.6.11/arch/um/Makefile~uml-quick-fix-Makefile	2005-01-26 19:58:50.149680728 +0100
+++ linux-2.6.11-paolo/arch/um/Makefile	2005-01-26 19:58:50.152680272 +0100
@@ -20,8 +20,11 @@ SYMLINK_HEADERS := archparam.h system.h 
 	arch-signal.h module.h vm-flags.h
 SYMLINK_HEADERS := $(foreach header,$(SYMLINK_HEADERS),include/asm-um/$(header))
 
-# The "os" symlink is only used by arch/um/include/os.h, which includes
+# XXX: The "os" symlink is only used by arch/um/include/os.h, which includes
 # ../os/include/file.h
+#
+# These are cleaned up during mrproper. Please DO NOT fix it again, this is
+# the Correct Thing(tm) to do!
 ARCH_SYMLINKS = include/asm-um/arch $(ARCH_DIR)/include/sysdep $(ARCH_DIR)/os \
 	$(SYMLINK_HEADERS) $(ARCH_DIR)/include/uml-config.h
 
@@ -134,7 +137,8 @@ CLEAN_FILES += linux x.i gmon.out $(ARCH
 	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h
 
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
-	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os
+	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os \
+	$(ARCH_DIR)/Kconfig_arch
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(ARCH_DIR)/util
_


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
