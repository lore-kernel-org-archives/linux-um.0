Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPWrR-0004k6-Kb for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:56:25 -0800
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]
	helo=zion.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CPWrQ-0000QG-8y for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 17:56:25 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20041103231759.C564055C8D@zion.localdomain>
Subject: [uml-devel] [patch 19/20] uml: readd linux Makefile target - fixes to
	the old version.
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
Date: Thu, 04 Nov 2004 00:17:59 +0100
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org, blaisorblade_spam@yahoo.it


(Please CC me on replies).
We have readded the "linux" target which just creates a hardlink to vmlinux.
It was noted (sorry for forgetting who said this) that "make ARCH=um"
will leave an old "linux" file, since the target is not listed in .PHONY.

Using a symlink, instead of an hard link, was suggested because the hard link
does not get updated with make vmlinux. But mv linux $destpath (the most
meaningful installation command) is broken, so I instead added linux to .PHONY.
Obviously, linux will not be rebuilt on "make vmlinux ARCH=um", but this makes
sense (if people use the new way, don't use old tricks). Anyway, we remove
"linux" in any case.

Acked-by: Jeff Dike <jdike@addtoit.com>

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/Makefile |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff -puN arch/um/Makefile~uml-readd-linux-target-part2 arch/um/Makefile
--- vanilla-linux-2.6.9/arch/um/Makefile~uml-readd-linux-target-part2	2004-11-03 23:30:36.465715896 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/Makefile	2004-11-03 23:30:36.467715592 +0100
@@ -63,16 +63,18 @@ ifeq ($(CONFIG_MODE_SKAS), y)
 $(SYS_HEADERS) : $(ARCH_DIR)/include/skas_ptregs.h
 endif
 
+.PHONY: linux
+
 all: linux
 
 linux: vmlinux
-	$(RM) $@
-	ln $< $@
+	ln -f $< $@
 
 define archhelp
   echo '* linux		- Binary kernel image (./linux) - for backward'
-  echo '		   compatibility only: now you can simply run'
-  echo '		   the vmlinux binary you find in the kernel root.'
+  echo '		   compatibility only, this creates a hard link to the'
+  echo '		   real kernel binary, the the "vmlinux" binary you'
+  echo '		   find in the kernel root.'
 endef
 
 prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS) \
@@ -118,7 +120,8 @@ define cmd_vmlinux__
 	-Wl,-T,$(vmlinux-lds) $(vmlinux-init) \
 	-Wl,--start-group $(vmlinux-main) -Wl,--end-group \
 	-L/usr/lib -lutil \
-	$(filter-out $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) FORCE ,$^)
+	$(filter-out $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) \
+	FORCE ,$^) ; rm -f linux
 endef
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
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
