Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWrI-0004k1-Pf for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:56:16 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWrC-0000Oe-B8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:56:16 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231723.BF97C363A8@zion.localdomain>
Subject: [uml-devel] [patch 04/20] uml: fix symbol conflict in linking
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
Date: Thu, 04 Nov 2004 00:17:23 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it


Since arch/um/kernel/tt/unmap_fin.o is linked statically, it could contain
some symbols also contained in the rest of vmlinux; on some systems, this
actually happens (due to some glibc differences).

Since that file *must* be linked statically and then relinked (its code must
remap the whole .text area except the section it is contained in during UML
startup), we cannot change this. So, we use objcopy to turn all symbols into
local ones except for switcheroo(), which is the only function actually
defined in the source (the other ones are brought in during linking).

This shouldn't hurt other systems, while improving the behaviour on affected
ones (there is still another issue I'm trying to fix). And it is logically
always needed (i.e., without this UML has just happened to work until now).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/Makefile |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/um/kernel/tt/Makefile~uml-link-fix-symbol-conflict arch/um/kernel/tt/Makefile
--- vanilla-linux-2.6.9/arch/um/kernel/tt/Makefile~uml-link-fix-symbol-conflict	2004-11-03 23:44:57.575807264 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/Makefile	2004-11-03 23:44:57.577806960 +0100
@@ -4,6 +4,7 @@
 #
 
 extra-y := unmap_fin.o
+clean-files := unmap_tmp.o
 
 obj-y = exec_kern.o exec_user.o gdb.o ksyms.o mem.o mem_user.o process_kern.o \
 	syscall_kern.o syscall_user.o time.o tlb.o tracer.o trap_user.o \
@@ -20,10 +21,9 @@ UNMAP_CFLAGS := $(patsubst -fprofile-arc
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
 
-$(O_TARGET) : $(obj)/unmap_fin.o
-
 $(obj)/unmap.o: $(src)/unmap.c
 	$(CC) $(UNMAP_CFLAGS) -c -o $@ $<
 
-$(obj)/unmap_fin.o : $(src)/unmap.o
-	ld -r -o $@ $< -lc -L/usr/lib
+$(obj)/unmap_fin.o : $(obj)/unmap.o
+	ld -r -o $(obj)/unmap_tmp.o  $< -lc -L/usr/lib
+	objcopy $(obj)/unmap_tmp.o $@ -G switcheroo
_


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
