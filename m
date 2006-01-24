Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F1WjZ-0004Qp-OS for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Jan 2006 14:33:53 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F1WjY-00007A-CN
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Jan 2006 14:33:53 -0800
Message-Id: <200601242326.k0ONQ1kT008903@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/2] UML - Add a build dependency
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
Date: Tue, 24 Jan 2006 18:26:01 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

kern_constants.h now depends on arch/um/include to make sure it exists
before we try to create symlinks in it.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/Makefile
===================================================================
--- linux-2.6.15-mm.orig/arch/um/Makefile	2006-01-24 17:04:35.000000000 -0500
+++ linux-2.6.15-mm/arch/um/Makefile	2006-01-24 17:05:13.000000000 -0500
@@ -172,10 +172,13 @@ else
 	$(Q)cd $(TOPDIR)/include/asm-um && ln -sf ../asm-$(SUBARCH) arch
 endif
 
-$(ARCH_DIR)/include/sysdep:
+$(objtree)/$(ARCH_DIR)/include:
+	@echo '  MKDIR $@'
+	$(Q)mkdir -p $@
+
+$(ARCH_DIR)/include/sysdep: $(objtree)/$(ARCH_DIR)/include
 	@echo '  SYMLINK $@'
 ifneq ($(KBUILD_SRC),)
-	$(Q)mkdir -p $(ARCH_DIR)/include
 	$(Q)ln -fsn $(srctree)/$(ARCH_DIR)/include/sysdep-$(SUBARCH) $(ARCH_DIR)/include/sysdep
 else
 	$(Q)cd $(ARCH_DIR)/include && ln -sf sysdep-$(SUBARCH) sysdep
@@ -218,7 +221,7 @@ $(ARCH_DIR)/include/user_constants.h: $(
 
 CLEAN_FILES += $(ARCH_DIR)/user-offsets.s
 
-$(ARCH_DIR)/include/kern_constants.h:
+$(ARCH_DIR)/include/kern_constants.h: $(objtree)/$(ARCH_DIR)/include
 	@echo '  SYMLINK $@'
 	$(Q) ln -sf ../../../include/asm-um/asm-offsets.h $@
 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
