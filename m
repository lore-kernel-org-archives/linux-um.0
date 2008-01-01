Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J9bOX-0000Tp-Nx for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Dec 2007 23:18:37 -0800
Received: from po-out-1718.google.com ([72.14.252.158])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J9bOX-0000Zs-C2
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 31 Dec 2007 23:18:37 -0800
Received: by po-out-1718.google.com with SMTP id y22so3044186pof.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 31 Dec 2007 23:18:36 -0800 (PST)
Date: Tue, 1 Jan 2008 15:18:46 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20080101071846.GB2496@hacking>
References: <20080101071311.GA2496@hacking>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080101071311.GA2496@hacking>
Subject: [uml-devel] [Patch 1/8] UML: Remove 'TOPDIR' from Makefiles
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com, Sam Ravnborg <sam@ravnborg.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org


TOPDIR is obsolete, use objtree instead.
This patch removes TOPDIR from all UML Makefiles.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---

diff --git a/arch/um/Makefile b/arch/um/Makefile
index ba6813a..57491af 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -158,7 +158,7 @@ ifneq ($(KBUILD_SRC),)
 	$(Q)mkdir -p $(objtree)/include/asm-um
 	$(Q)ln -fsn $(srctree)/include/asm-um/$(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $@
 else
-	$(Q)cd $(TOPDIR)/$(dir $@) ; \
+	$(Q)cd $(objtree)/$(dir $@) ; \
 	ln -sf $(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $(notdir $@)
 endif
 
@@ -168,7 +168,7 @@ ifneq ($(KBUILD_SRC),)
 	$(Q)mkdir -p $(objtree)/include/asm-um
 	$(Q)ln -fsn $(srctree)/include/asm-$(HEADER_ARCH) include/asm-um/arch
 else
-	$(Q)cd $(TOPDIR)/include/asm-um && ln -fsn ../asm-$(HEADER_ARCH) arch
+	$(Q)cd $(objtree)/include/asm-um && ln -fsn ../asm-$(HEADER_ARCH) arch
 endif
 
 $(objtree)/$(ARCH_DIR)/include:
diff --git a/arch/um/sys-ppc/Makefile b/arch/um/sys-ppc/Makefile
index a9814a7..a3cfae7 100644
--- a/arch/um/sys-ppc/Makefile
+++ b/arch/um/sys-ppc/Makefile
@@ -6,7 +6,7 @@ OBJ = built-in.o
 OBJS = ptrace.o sigcontext.o semaphore.o checksum.o miscthings.o misc.o \
 	ptrace_user.o sysrq.o
 
-EXTRA_AFLAGS := -DCONFIG_PPC32 -I. -I$(TOPDIR)/arch/ppc/kernel
+EXTRA_AFLAGS := -DCONFIG_PPC32 -I. -I$(objtree)/arch/ppc/kernel
 
 all: $(OBJ)
 
@@ -22,25 +22,25 @@ sigcontext.o: sigcontext.c
 
 semaphore.c:
 	rm -f $@
-	ln -s $(TOPDIR)/arch/ppc/kernel/$@ $@
+	ln -s $(objtree)/arch/ppc/kernel/$@ $@
 
 checksum.S:
 	rm -f $@
-	ln -s $(TOPDIR)/arch/ppc/lib/$@ $@
+	ln -s $(objtree)/arch/ppc/lib/$@ $@
 
 mk_defs.c:
 	rm -f $@
-	ln -s $(TOPDIR)/arch/ppc/kernel/$@ $@
+	ln -s $(objtree)/arch/ppc/kernel/$@ $@
 
 ppc_defs.head:
 	rm -f $@
-	ln -s $(TOPDIR)/arch/ppc/kernel/$@ $@
+	ln -s $(objtree)/arch/ppc/kernel/$@ $@
 
 ppc_defs.h: mk_defs.c ppc_defs.head \
-		$(TOPDIR)/include/asm-ppc/mmu.h \
-		$(TOPDIR)/include/asm-ppc/processor.h \
-		$(TOPDIR)/include/asm-ppc/pgtable.h \
-		$(TOPDIR)/include/asm-ppc/ptrace.h
+		$(objtree)/include/asm-ppc/mmu.h \
+		$(objtree)/include/asm-ppc/processor.h \
+		$(objtree)/include/asm-ppc/pgtable.h \
+		$(objtree)/include/asm-ppc/ptrace.h
 #	$(CC) $(CFLAGS) -S mk_defs.c
 	cp ppc_defs.head ppc_defs.h
 # for bk, this way we can write to the file even if it's not checked out
@@ -56,13 +56,13 @@ ppc_defs.h: mk_defs.c ppc_defs.head \
 
 checksum.o: checksum.S
 	rm -f asm
-	ln -s $(TOPDIR)/include/asm-ppc asm
+	ln -s $(objtree)/include/asm-ppc asm
 	$(CC) $(EXTRA_AFLAGS) $(KBUILD_AFLAGS) -D__ASSEMBLY__ -D__UM_PPC__ -c $< -o $*.o
 	rm -f asm
 
 misc.o: misc.S ppc_defs.h
 	rm -f asm
-	ln -s $(TOPDIR)/include/asm-ppc asm
+	ln -s $(objtree)/include/asm-ppc asm
 	$(CC) $(EXTRA_AFLAGS) $(KBUILD_AFLAGS) -D__ASSEMBLY__ -D__UM_PPC__ -c $< -o $*.o
 	rm -f asm
 
diff --git a/arch/x86/Makefile_32 b/arch/x86/Makefile_32

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
