Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DslX7-0000xb-RW	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:33 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DslX7-0005mg-9r	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:34 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050713180224.8FD9A21E736@zion.home.lan>
Subject: [uml-devel] [patch 4/9] uml: gcc 2.95 fix and Makefile cleanup
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
Date: Wed, 13 Jul 2005 20:02:24 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, raphael.bossek@gmx.de


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Raphael Bossek <raphael.bossek@gmx.de>

 1) Cleanup an ugly hyper-nested code in Makefile (now only the arith.
 expression is passed through the host bash).

 2) Fix a problem with GCC 2.95: according to a report from Raphael Bossek,
  .remap_data : { arch/um/sys-SUBARCH/unmap_fin.o (.data .bss) }
 is expanded into:
  .remap_data : { arch/um/sys-i386 /unmap_fin.o (.data .bss) }

(because I didn't use ## to join the two tokens), thus stopping linking. Pass
the whole path from the Makefile as a simple and nice fix.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/arch/um/Makefile         |    9 +++++----
 linux-2.6.git-broken-paolo/arch/um/kernel/uml.lds.S |    4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff -puN arch/um/Makefile~uml-cleanup-Makefile-a-bit arch/um/Makefile
--- linux-2.6.git-broken/arch/um/Makefile~uml-cleanup-Makefile-a-bit	2005-07-13 19:41:17.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/Makefile	2005-07-13 19:41:17.000000000 +0200
@@ -116,13 +116,14 @@ CONFIG_KERNEL_STACK_ORDER ?= 2
 STACK_SIZE := $(shell echo $$[ 4096 * (1 << $(CONFIG_KERNEL_STACK_ORDER)) ] )
 
 ifndef START
-  START = $$(($(TOP_ADDR) - $(SIZE)))
+  START = $(shell echo $$[ $(TOP_ADDR) - $(SIZE) ] )
 endif
 
-CPPFLAGS_vmlinux.lds = $(shell echo -U$(SUBARCH) \
+CPPFLAGS_vmlinux.lds = -U$(SUBARCH) \
 	-DSTART=$(START) -DELF_ARCH=$(ELF_ARCH) \
-	-DELF_FORMAT=\"$(ELF_FORMAT)\" $(CPP_MODE-y) \
-	-DKERNEL_STACK_SIZE=$(STACK_SIZE) -DSUBARCH=$(SUBARCH))
+	-DELF_FORMAT="$(ELF_FORMAT)" $(CPP_MODE-y) \
+	-DKERNEL_STACK_SIZE=$(STACK_SIZE) \
+	-DUNMAP_PATH=arch/um/sys-$(SUBARCH)/unmap_fin.o
 
 #The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
diff -puN arch/um/kernel/uml.lds.S~uml-cleanup-Makefile-a-bit arch/um/kernel/uml.lds.S
--- linux-2.6.git-broken/arch/um/kernel/uml.lds.S~uml-cleanup-Makefile-a-bit	2005-07-13 19:41:17.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/kernel/uml.lds.S	2005-07-13 19:41:17.000000000 +0200
@@ -16,8 +16,8 @@ SECTIONS
   __binary_start = .;
 
 #ifdef MODE_TT
-  .remap_data : { arch/um/sys-SUBARCH/unmap_fin.o (.data .bss) }
-  .remap : { arch/um/sys-SUBARCH/unmap_fin.o (.text) }
+  .remap_data : { UNMAP_PATH (.data .bss) }
+  .remap : { UNMAP_PATH (.text) }
 
   . = ALIGN(4096);		/* Init code and data */
 #endif
_


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
