Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E9q0p-0001bJ-9E	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2005 13:13:47 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E9q0n-0002yz-CD
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2005 13:13:47 -0700
Message-Id: <200508292006.j7TK6vke029916@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/9] UML - Build cleanup
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
Date: Mon, 29 Aug 2005 16:06:57 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

From Al Viro - Build cleanups

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6/arch/um/Makefile
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/Makefile	2005-08-15 12:03:04.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/Makefile	2005-08-15 13:16:39.000000000 -0400
@@ -56,6 +56,7 @@
 
 CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\" \
 	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap
+AFLAGS += $(ARCH_INCLUDE)
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
Index: linux-2.6.13-rc6/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/sys-i386/Makefile	2005-08-15 12:02:57.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/sys-i386/Makefile	2005-08-15 13:16:55.000000000 -0400
@@ -22,8 +22,6 @@
 # why ask why?
 $(obj)/stub_segv.o : c_flags = $(STUB_CFLAGS)
 
-$(obj)/stub.o : a_flags = $(STUB_CFLAGS)
-
 subdir- := util
 
 include arch/um/scripts/Makefile.unmap
Index: linux-2.6.13-rc6/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/sys-x86_64/Makefile	2005-08-15 12:03:02.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/sys-x86_64/Makefile	2005-08-15 13:17:21.000000000 -0400
@@ -34,8 +34,6 @@
 # why ask why?
 $(obj)/stub_segv.o : c_flags = $(STUB_CFLAGS)
 
-$(obj)/stub.o : a_flags = $(STUB_CFLAGS)
-
 subdir- := util
 
 include arch/um/scripts/Makefile.unmap



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
