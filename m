Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAxTz-000684-IB	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Sep 2005 15:24:31 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EAxTy-0002As-My
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Sep 2005 15:24:31 -0700
Message-Id: <200509012217.j81MH23j011535@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/12] UML - build cleanups
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
Date: Thu, 01 Sep 2005 18:17:02 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

Added missing include list to uml AFLAGS
Killed magic for stubs. [So] - it was needed only because of messed AFLAGS
Switched segv_stubs.c to kernel CFLAGS sans profile, instead of user ones
Killed STUBS_CFLAGS - it's not needed and the only remaining use had been
gratitious - it only polluted CFLAGS

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>


Index: test/arch/um/Makefile-i386
===================================================================
--- test.orig/arch/um/Makefile-i386	2005-09-01 16:03:16.000000000 -0400
+++ test/arch/um/Makefile-i386	2005-09-01 16:04:30.000000000 -0400
@@ -27,8 +27,7 @@
 endif
 endif
 
-CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH) $(STUB_CFLAGS) \
-	  -Iinclude/asm-i386/mach-default \
+CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH) -Iinclude/asm-i386/mach-default \
           $(if $(KBUILD_SRC),-Iinclude2/asm-i386/mach-default -I$(srctree)/include/asm-i386/mach-default)
 
 ifneq ($(CONFIG_GPROF),y)
Index: test/arch/um/Makefile-x86_64
===================================================================
--- test.orig/arch/um/Makefile-x86_64	2005-09-01 16:02:46.000000000 -0400
+++ test/arch/um/Makefile-x86_64	2005-09-01 16:04:30.000000000 -0400
@@ -6,7 +6,7 @@
 
 #We #undef __x86_64__ for kernelspace, not for userspace where
 #it's needed for headers to work!
-CFLAGS += -U__$(SUBARCH)__ -fno-builtin $(STUB_CFLAGS)
+CFLAGS += -U__$(SUBARCH)__ -fno-builtin
 USER_CFLAGS += -fno-builtin
 
 ELF_ARCH := i386:x86-64
Index: test/arch/um/sys-i386/Makefile
===================================================================
--- test.orig/arch/um/sys-i386/Makefile	2005-09-01 16:03:16.000000000 -0400
+++ test/arch/um/sys-i386/Makefile	2005-09-01 16:04:30.000000000 -0400
@@ -16,11 +16,7 @@
 highmem.c-dir = mm
 module.c-dir = kernel
 
-STUB_CFLAGS = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS))
-
-# _cflags works with kernel files, not with userspace ones, but c_flags does,
-# why ask why?
-$(obj)/stub_segv.o : c_flags = $(STUB_CFLAGS)
+$(obj)/stub_segv.o : _c_flags = $(call unprofile,$(CFLAGS))
 
 subdir- := util
 
Index: test/arch/um/sys-i386/stub_segv.c
===================================================================
--- test.orig/arch/um/sys-i386/stub_segv.c	2005-09-01 16:02:46.000000000 -0400
+++ test/arch/um/sys-i386/stub_segv.c	2005-09-01 16:04:30.000000000 -0400
@@ -3,8 +3,7 @@
  * Licensed under the GPL
  */
 
-#include <signal.h>
-#include <asm/sigcontext.h>
+#include <asm/signal.h>
 #include <asm/unistd.h>
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"
Index: test/arch/um/sys-x86_64/Makefile
===================================================================
--- test.orig/arch/um/sys-x86_64/Makefile	2005-09-01 16:04:05.000000000 -0400
+++ test/arch/um/sys-x86_64/Makefile	2005-09-01 16:04:30.000000000 -0400
@@ -27,11 +27,7 @@
 thunk.S-dir = lib
 module.c-dir = kernel
 
-STUB_CFLAGS = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS))
-
-# _cflags works with kernel files, not with userspace ones, but c_flags does,
-# why ask why?
-$(obj)/stub_segv.o : c_flags = $(STUB_CFLAGS)
+$(obj)/stub_segv.o: _c_flags = $(call unprofile,$(CFLAGS))
 
 subdir- := util
 
Index: test/arch/um/sys-x86_64/stub_segv.c
===================================================================
--- test.orig/arch/um/sys-x86_64/stub_segv.c	2005-09-01 16:02:46.000000000 -0400
+++ test/arch/um/sys-x86_64/stub_segv.c	2005-09-01 16:04:30.000000000 -0400
@@ -3,9 +3,10 @@
  * Licensed under the GPL
  */
 
-#include <signal.h>
+#include <asm/signal.h>
 #include <linux/compiler.h>
 #include <asm/unistd.h>
+#include <asm/ucontext.h>
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/faultinfo.h"



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
