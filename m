Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iv9uw-0006HF-Pi for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Nov 2007 03:08:22 -0800
Received: from ug-out-1314.google.com ([66.249.92.168])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Iv9uw-0000S7-3o
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Nov 2007 03:08:22 -0800
Received: by ug-out-1314.google.com with SMTP id m2so309602uge
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 22 Nov 2007 03:08:20 -0800 (PST)
Message-ID: <47456321.2080600@gmail.com>
Date: Thu, 22 Nov 2007 12:08:17 +0100
From: Jiri Olsa <olsajiri@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] um: include/asm/arch link creation change
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
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>

Hi,

current um code does not create a proper include/asm/arch link.
when I bisected it I can see this was introduced by following patch:

commit fcbaa088fc8625381bd1096bc2eedc4f58a1572c
Author: Jeff Dike <jdike@addtoit.com>
Date:   Wed Nov 14 16:58:42 2007 -0800

    uml: fix symlink loops
    
    symlinks to directories in the non-O= case were lacking -n, which meant
    that, when the link already existed, a new link pointing at itself was
    created in the target directory.
    
    Signed-off-by: Jeff Dike <jdike@linux.intel.com>
    Cc: Sam Ravnborg <sam@ravnborg.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 768a5d1..31999bc 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -168,7 +168,7 @@ ifneq ($(KBUILD_SRC),)
        $(Q)mkdir -p $(objtree)/include/asm-um
        $(Q)ln -fsn $(srctree)/include/asm-$(HEADER_ARCH) include/asm-um/arch
 else
-       $(Q)cd $(TOPDIR)/include/asm-um && ln -sf ../asm-$(HEADER_ARCH) arch
+       $(Q)cd $(TOPDIR)/include/asm-um && ln -fsn ../asm-$(SUBARCH) arch
 endif

snip


it works for me to use the HEADER_ARCH instead of the SUBARCH
Signed-off-by: Jiri Olsa <olsajiri@gmail.com>

---
 arch/um/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 31999bc..ba6813a 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -168,7 +168,7 @@ ifneq ($(KBUILD_SRC),)
 	$(Q)mkdir -p $(objtree)/include/asm-um
 	$(Q)ln -fsn $(srctree)/include/asm-$(HEADER_ARCH) include/asm-um/arch
 else
-	$(Q)cd $(TOPDIR)/include/asm-um && ln -fsn ../asm-$(SUBARCH) arch
+	$(Q)cd $(TOPDIR)/include/asm-um && ln -fsn ../asm-$(HEADER_ARCH) arch
 endif
 
 $(objtree)/$(ARCH_DIR)/include:

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
