Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EL49F-0008Gi-57	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:32:53 -0700
Received: from ppp-62-11-74-97.dialup.tiscali.it ([62.11.74.97]
	helo=zion.home.lan)	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EL49A-0002kC-LZ	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Sep 2005 12:32:53 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050929193021.14528.58899.stgit@zion.home.lan>
In-Reply-To: <200509292102.44942.blaisorblade@yahoo.it>
References: <200509292102.44942.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 1/5] Uml: fix build dependencies with KBUILD
	OUTPUT
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
Date: Thu, 29 Sep 2005 21:30:21 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

When doing "make ARCH=um O=<path>", where <path> only contains .config, the
build failed, because <path>/include2 hadn't been created. It's not supposed to
work like this, at all. Since I never saw this (even with massively parallel
builds - I'm accustomed to test often -j50, given that I use ccache), I suppose
that after doing "make ARCH=um O=<path> *config" this wouldn't happen.

Turns out that the UML "archprepare" target failed - it depends on prepare1
which in turn would cause include2 to be created, but the failing target was
listed as dependency of archprepare. And there's no specific order among
dependencies, so add another dependency.

Btw, fix some clutter I found (duplicate assignments).
And add $(Q) to an ln invocation, since this patch (don't ask me why) causes
$(SYMLINK_HEADERS) to be rebuilt at each "make" call.

Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile        |    6 +++++-
 arch/um/Makefile-i386   |    2 --
 arch/um/Makefile-x86_64 |    3 ---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -111,6 +111,10 @@ else
 $(shell cd $(ARCH_DIR) && ln -sf Kconfig.$(SUBARCH) Kconfig.arch)
 endif
 
+# archprepare depends on prepare1. But we need that all these are made *after* prepare1.
+# Otherwise, for instance, we may miss include2.
+$(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS): prepare1
+
 archprepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS)
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
@@ -161,7 +165,7 @@ archclean:
 $(SYMLINK_HEADERS):
 	@echo '  SYMLINK $@'
 ifneq ($(KBUILD_SRC),)
-	ln -fsn $(srctree)/include/asm-um/$(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $@
+	$(Q)ln -fsn $(srctree)/include/asm-um/$(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $@
 else
 	$(Q)cd $(TOPDIR)/$(dir $@) ; \
 	ln -sf $(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $(notdir $@)
diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -36,8 +36,6 @@ endif
 SYS_UTIL_DIR	:= $(ARCH_DIR)/sys-i386/util
 SYS_HEADERS	:= $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
 
-prepare: $(SYS_HEADERS)
-
 $(SYS_DIR)/sc.h: $(SYS_UTIL_DIR)/mk_sc
 	$(call filechk,gen_header)
 
diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -14,12 +14,9 @@ ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
 
 SYS_UTIL_DIR := $(ARCH_DIR)/sys-x86_64/util
-SYS_DIR := $(ARCH_DIR)/include/sysdep-x86_64
 
 SYS_HEADERS = $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
 
-prepare: $(SYS_HEADERS)
-
 $(SYS_DIR)/sc.h: $(SYS_UTIL_DIR)/mk_sc
 	$(call filechk,gen_header)
 



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
