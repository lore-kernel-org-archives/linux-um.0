Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcU1-00018A-Q7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:09 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcU1-0001m3-8L
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:09 -0800
Date: Thu, 17 Jan 2008 16:40:45 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214045.GA6747@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 12/20] UML - Remove TOPDIR
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
Cc: WANG Cong <xiyou.wangcong@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: WANG Cong <xiyou.wangcong@gmail.com>

TOPDIR is obsolete, use srctree instead.
This patch removes TOPDIR from all UML Makefiles.

Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/Makefile         |    4 ++--
 arch/um/sys-ppc/Makefile |   22 +++++++++++-----------
 2 files changed, 13 insertions(+), 13 deletions(-)

Index: linux-2.6.22/arch/um/Makefile
===================================================================
--- linux-2.6.22.orig/arch/um/Makefile	2008-01-01 18:39:11.000000000 -0500
+++ linux-2.6.22/arch/um/Makefile	2008-01-02 09:59:21.000000000 -0500
@@ -149,7 +149,7 @@ ifneq ($(KBUILD_SRC),)
 	$(Q)mkdir -p $(objtree)/include/asm-um
 	$(Q)ln -fsn $(srctree)/include/asm-um/$(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $@
 else
-	$(Q)cd $(TOPDIR)/$(dir $@) ; \
+	$(Q)cd $(srctree)/$(dir $@) ; \
 	ln -sf $(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $(notdir $@)
 endif
 
@@ -159,7 +159,7 @@ ifneq ($(KBUILD_SRC),)
 	$(Q)mkdir -p $(objtree)/include/asm-um
 	$(Q)ln -fsn $(srctree)/include/asm-$(HEADER_ARCH) include/asm-um/arch
 else
-	$(Q)cd $(TOPDIR)/include/asm-um && ln -fsn ../asm-$(HEADER_ARCH) arch
+	$(Q)cd $(srctree)/include/asm-um && ln -fsn ../asm-$(HEADER_ARCH) arch
 endif
 
 $(objtree)/$(ARCH_DIR)/include:
Index: linux-2.6.22/arch/um/sys-ppc/Makefile
===================================================================
--- linux-2.6.22.orig/arch/um/sys-ppc/Makefile	2007-11-14 10:33:29.000000000 -0500
+++ linux-2.6.22/arch/um/sys-ppc/Makefile	2008-01-02 09:59:21.000000000 -0500
@@ -6,7 +6,7 @@ OBJ = built-in.o
 OBJS = ptrace.o sigcontext.o semaphore.o checksum.o miscthings.o misc.o \
 	ptrace_user.o sysrq.o
 
-EXTRA_AFLAGS := -DCONFIG_PPC32 -I. -I$(TOPDIR)/arch/ppc/kernel
+EXTRA_AFLAGS := -DCONFIG_PPC32 -I. -I$(srctree)/arch/ppc/kernel
 
 all: $(OBJ)
 
@@ -22,25 +22,25 @@ sigcontext.o: sigcontext.c
 
 semaphore.c:
 	rm -f $@
-	ln -s $(TOPDIR)/arch/ppc/kernel/$@ $@
+	ln -s $(srctree)/arch/ppc/kernel/$@ $@
 
 checksum.S:
 	rm -f $@
-	ln -s $(TOPDIR)/arch/ppc/lib/$@ $@
+	ln -s $(srctree)/arch/ppc/lib/$@ $@
 
 mk_defs.c:
 	rm -f $@
-	ln -s $(TOPDIR)/arch/ppc/kernel/$@ $@
+	ln -s $(srctree)/arch/ppc/kernel/$@ $@
 
 ppc_defs.head:
 	rm -f $@
-	ln -s $(TOPDIR)/arch/ppc/kernel/$@ $@
+	ln -s $(srctree)/arch/ppc/kernel/$@ $@
 
 ppc_defs.h: mk_defs.c ppc_defs.head \
-		$(TOPDIR)/include/asm-ppc/mmu.h \
-		$(TOPDIR)/include/asm-ppc/processor.h \
-		$(TOPDIR)/include/asm-ppc/pgtable.h \
-		$(TOPDIR)/include/asm-ppc/ptrace.h
+		$(srctree)/include/asm-ppc/mmu.h \
+		$(srctree)/include/asm-ppc/processor.h \
+		$(srctree)/include/asm-ppc/pgtable.h \
+		$(srctree)/include/asm-ppc/ptrace.h
 #	$(CC) $(CFLAGS) -S mk_defs.c
 	cp ppc_defs.head ppc_defs.h
 # for bk, this way we can write to the file even if it's not checked out
@@ -56,13 +56,13 @@ ppc_defs.h: mk_defs.c ppc_defs.head \
 
 checksum.o: checksum.S
 	rm -f asm
-	ln -s $(TOPDIR)/include/asm-ppc asm
+	ln -s $(srctree)/include/asm-ppc asm
 	$(CC) $(EXTRA_AFLAGS) $(KBUILD_AFLAGS) -D__ASSEMBLY__ -D__UM_PPC__ -c $< -o $*.o
 	rm -f asm
 
 misc.o: misc.S ppc_defs.h
 	rm -f asm
-	ln -s $(TOPDIR)/include/asm-ppc asm
+	ln -s $(srctree)/include/asm-ppc asm
 	$(CC) $(EXTRA_AFLAGS) $(KBUILD_AFLAGS) -D__ASSEMBLY__ -D__UM_PPC__ -c $< -o $*.o
 	rm -f asm
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
