Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDpHe-0002ZG-Bl for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 11:43:22 -0800
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DDpHJ-0007ur-Fq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 11:43:21 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050322162139.50D4197672@zion>
Subject: [uml-devel] [patch 09/12] uml - kbuild: link cmd
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
Date: Tue, 22 Mar 2005 17:21:39 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Use the cmd_* syntax to define a command for symlink creations in UML (to
reuse files from other archs).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/scripts/Makefile.rules |    3 +++
 linux-2.6.11-paolo/arch/um/sys-i386/Makefile      |   13 +++++--------
 linux-2.6.11-paolo/arch/um/sys-x86_64/Makefile    |   16 ++++++++--------
 linux-2.6.11-paolo/include/asm-um/signal.h        |    2 ++
 4 files changed, 18 insertions(+), 16 deletions(-)

diff -puN arch/um/sys-x86_64/Makefile~uml-kbuild-link-cmd arch/um/sys-x86_64/Makefile
--- linux-2.6.11/arch/um/sys-x86_64/Makefile~uml-kbuild-link-cmd	2005-03-21 19:53:36.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/sys-x86_64/Makefile	2005-03-21 19:53:36.000000000 +0100
@@ -14,10 +14,15 @@ include arch/um/scripts/Makefile.rules
 
 SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c memcpy.S \
 	semaphore.c thunk.S
-SYMLINKS := $(foreach f,$(SYMLINKS),$(src)/$f)
 
+# this needs to be before the foreach, because clean-files does not accept
+# complete paths like $(src)/$f.
 clean-files := $(SYMLINKS)
 
+targets += $(SYMLINKS)
+
+SYMLINKS := $(foreach f,$(SYMLINKS),$(obj)/$f)
+
 bitops.c-dir = lib
 csum-copy.S-dir = lib
 csum-partial.c-dir = lib
@@ -26,12 +31,7 @@ memcpy.S-dir = lib
 semaphore.c-dir = kernel
 thunk.S-dir = lib
 
-define make_link
-       -rm -f $1
-       ln -sf $(srctree)/arch/x86_64/$($(notdir $1)-dir)/$(notdir $1) $1
-endef
-
-$(SYMLINKS):
-	$(call make_link,$@)
+$(SYMLINKS): FORCE
+	$(call if_changed,make_link)
 
 CFLAGS_csum-partial.o := -Dcsum_partial=arch_csum_partial
diff -puN arch/um/sys-i386/Makefile~uml-kbuild-link-cmd arch/um/sys-i386/Makefile
--- linux-2.6.11/arch/um/sys-i386/Makefile~uml-kbuild-link-cmd	2005-03-21 19:53:36.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/sys-i386/Makefile	2005-03-21 19:53:36.000000000 +0100
@@ -14,19 +14,16 @@ SYMLINKS = bitops.c semaphore.c highmem.
 # complete paths like $(src)/$f.
 clean-files := $(SYMLINKS)
 
-SYMLINKS := $(foreach f,$(SYMLINKS),$(src)/$f)
+targets += $(SYMLINKS)
+
+SYMLINKS := $(foreach f,$(SYMLINKS),$(obj)/$f)
 
 bitops.c-dir = lib
 semaphore.c-dir = kernel
 highmem.c-dir = mm
 module.c-dir = kernel
 
-define make_link
-	-rm -f $1
-	ln -sf $(srctree)/arch/i386/$($(notdir $1)-dir)/$(notdir $1) $1
-endef
-
-$(SYMLINKS): 
-	$(call make_link,$@)
+$(SYMLINKS): FORCE
+	$(call if_changed,make_link)
 
 subdir- := util
diff -puN arch/um/scripts/Makefile.rules~uml-kbuild-link-cmd arch/um/scripts/Makefile.rules
--- linux-2.6.11/arch/um/scripts/Makefile.rules~uml-kbuild-link-cmd	2005-03-21 19:53:36.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/scripts/Makefile.rules	2005-03-21 19:53:36.000000000 +0100
@@ -8,3 +8,6 @@ USER_OBJS += $(filter %_user.o,$(obj-y) 
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 $(USER_OBJS): c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(notdir $@))
+
+quiet_cmd_make_link = SYMLINK $@
+cmd_make_link       = rm -f $@; ln -sf $(srctree)/arch/$(SUBARCH)/$($(notdir $@)-dir)/$(notdir $@) $@
_


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
