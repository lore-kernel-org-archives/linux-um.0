Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IqaRd-0000QD-9k for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Nov 2007 12:27:32 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IqaRb-0007Pm-MR
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Nov 2007 12:27:13 -0800
Date: Fri, 9 Nov 2007 15:26:37 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071109202637.GA7652@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML - Fix symlink loops
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

[ This should go into 2.6.24 - it's simple enough and people are
complaining about this ]

symlinks to directories in the non-O= case were lacking -n, which
meant that, when the link already existed, a new link pointing at
itself was created in the target directory.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/Makefile |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/um/Makefile
===================================================================
--- linux-2.6.orig/arch/um/Makefile	2007-11-09 14:32:36.000000000 -0500
+++ linux-2.6/arch/um/Makefile	2007-11-09 14:34:05.000000000 -0500
@@ -168,7 +168,7 @@ ifneq ($(KBUILD_SRC),)
 	$(Q)mkdir -p $(objtree)/include/asm-um
 	$(Q)ln -fsn $(srctree)/include/asm-$(HEADER_ARCH) include/asm-um/arch
 else
-	$(Q)cd $(TOPDIR)/include/asm-um && ln -sf ../asm-$(HEADER_ARCH) arch
+	$(Q)cd $(TOPDIR)/include/asm-um && ln -fsn ../asm-$(SUBARCH) arch
 endif
 
 $(objtree)/$(ARCH_DIR)/include:
@@ -180,7 +180,7 @@ $(ARCH_DIR)/include/sysdep: $(objtree)/$
 ifneq ($(KBUILD_SRC),)
 	$(Q)ln -fsn $(srctree)/$(ARCH_DIR)/include/sysdep-$(SUBARCH) $(ARCH_DIR)/include/sysdep
 else
-	$(Q)cd $(ARCH_DIR)/include && ln -sf sysdep-$(SUBARCH) sysdep
+	$(Q)cd $(ARCH_DIR)/include && ln -fsn sysdep-$(SUBARCH) sysdep
 endif
 
 $(ARCH_DIR)/os:
@@ -188,7 +188,7 @@ $(ARCH_DIR)/os:
 ifneq ($(KBUILD_SRC),)
 	$(Q)ln -fsn $(srctree)/$(ARCH_DIR)/os-$(OS) $(ARCH_DIR)/os
 else
-	$(Q)cd $(ARCH_DIR) && ln -sf os-$(OS) os
+	$(Q)cd $(ARCH_DIR) && ln -fsn os-$(OS) os
 endif
 
 # Generated files

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
