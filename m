Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cx9Z6-0004Db-7W for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 11:56:28 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Cx9Z2-00079V-6r for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 11:56:28 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sK9ACaiRmWN7RtK"
Message-Id: <200502042053.16703.blaisorblade@yahoo.it>
Subject: [uml-devel] [patch 0/8] uml: important patches to merge before 2.6.11
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
Date: Fri, 4 Feb 2005 20:53:16 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_sK9ACaiRmWN7RtK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Andrew Morton, these are needed fixes for UML to go in before 2.6.11 release.

These patches also depend onto the just sent-and-merged (in the BitKeeper 
repository) "[PATCH] UML - compile fixes for 2.6.11-rc3".

Finally, you also confirmed on "Fri Jan 28 23:10:28 2005" that you have 
pending this patch, which is not yet applied in -rc3, nor is in 
2.6.11-rc2-mm2 or 2.6.11-rc3-mm1 for what I see:

uml-kconfig_arch-little-cleanup-to-merge-before-2611.patch

We'd need it merged too, as marked in the name (it removes a file which is 
actually a symlink but went into the tree, i.e. arch/um/Kconfig_arch).

I'm resending it, too, as plain-text attachment. Please apply.

Thanks and regards
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_sK9ACaiRmWN7RtK
Content-Type: text/x-diff; charset="us-ascii";
	name="uml-quick-fix-Makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-quick-fix-Makefile.patch"


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

--Boundary-00=_sK9ACaiRmWN7RtK--




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
