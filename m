Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EE9iJ-0006ko-8Y	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:04:31 -0700
Received: from ppp-62-11-72-160.dialup.tiscali.it ([62.11.72.160]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EE9iI-0006ny-1R	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:04:31 -0700
Message-Id: <20050910174626.850521000@zion.home.lan>
References: <20050910174452.907256000@zion.home.lan>
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Content-Disposition: inline; filename=uml-more-clean
Subject: [uml-devel] [patch 1/7] Uml: more cleaning
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
Date: Sat, 10 Sep 2005 19:44:53 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

We must remove even arch/um/os-Linux/util/mk_user_constants, which we don't do.
Also, Kconfig_arch must be listed only once, between CLEAN_FILES.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -103,7 +103,6 @@ endef
 
 ifneq ($(KBUILD_SRC),)
 $(shell mkdir -p $(ARCH_DIR) && ln -fsn $(srctree)/$(ARCH_DIR)/Kconfig.$(SUBARCH) $(ARCH_DIR)/Kconfig.arch)
-CLEAN_FILES += $(ARCH_DIR)/Kconfig.arch
 else
 $(shell cd $(ARCH_DIR) && ln -sf Kconfig.$(SUBARCH) Kconfig.arch)
 endif
@@ -144,14 +143,14 @@ endef
 #TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/include/uml-config.h \
 	$(GEN_HEADERS) $(ARCH_DIR)/include/skas_ptregs.h \
-	$(ARCH_DIR)/include/user_constants.h
+	$(ARCH_DIR)/include/user_constants.h $(ARCH_DIR)/Kconfig.arch
 
 MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
-	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os \
-	$(ARCH_DIR)/Kconfig.arch
+	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(ARCH_DIR)/util
+	$(Q)$(MAKE) $(clean)=$(ARCH_DIR)/os-$(OS)/util
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
 

--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
