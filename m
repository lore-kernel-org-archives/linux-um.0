Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGKXb-0007lL-9d	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 11:02:27 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EGKXZ-0001UY-GB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 11:02:27 -0700
Message-Id: <200509161755.j8GHtR4G006755@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/1] UML - UML/i386 cmpxchg fix
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
Date: Fri, 16 Sep 2005 13:55:27 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This is 2.6.14 material, as it works in current mainline, and is a slight 
improvment there.

In -rc1-mm1, this fixes a compilation breakage caused by the cmpxchg changes
in asm-i386/system.h.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc1-mm1/arch/um/Kconfig.i386
===================================================================
--- linux-2.6.13-rc1-mm1.orig/arch/um/Kconfig.i386	2005-09-16 12:33:07.000000000 -0400
+++ linux-2.6.13-rc1-mm1/arch/um/Kconfig.i386	2005-09-16 13:20:49.000000000 -0400
@@ -42,3 +42,7 @@
 config ARCH_REUSE_HOST_VSYSCALL_AREA
 	bool
 	default y
+
+config X86_CMPXCHG
+	bool
+	default y
Index: linux-2.6.13-rc1-mm1/include/asm-um/system-i386.h
===================================================================
--- linux-2.6.13-rc1-mm1.orig/include/asm-um/system-i386.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13-rc1-mm1/include/asm-um/system-i386.h	2005-09-16 13:20:20.000000000 -0400
@@ -3,6 +3,4 @@
 
 #include "asm/system-generic.h"
     
-#define __HAVE_ARCH_CMPXCHG 1
-
 #endif



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
