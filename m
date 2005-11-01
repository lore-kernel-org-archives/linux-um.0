Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EX2zy-00060j-UL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Nov 2005 12:44:50 -0800
Received: from host175-37.pool8253.interbusiness.it ([82.53.37.175]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EX2zw-0004yV-TE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Nov 2005 12:44:51 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051101204836.27258.46611.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 1/2] uml: build host-binaries with the native host
	arch again
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
Date: Tue, 01 Nov 2005 21:48:37 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This patch reverts back the changes to HOSTCFLAGS and HOSTLDFLAGS

When we were building complete binaries to get constants (such as ptrace
register layout on stack) from host userspace headers, we needed to make the
arch for building HOST binaries match our one: i.e. on a 64bit system compiling
32bit binaries, we compile 32-bit hostprogs and need, say, 32-bit ncurses. Now
we can revert that - that avoids problem with, say, menuconfig and ncurses, on a
system which can't compile well 32-bit programs.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile-i386 |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -17,8 +17,6 @@ ifeq ("$(origin SUBARCH)", "command line
 ifneq ("$(shell uname -m | sed -e s/i.86/i386/)", "$(SUBARCH)")
 CFLAGS			+= $(call cc-option,-m32)
 USER_CFLAGS		+= $(call cc-option,-m32)
-HOSTCFLAGS		+= $(call cc-option,-m32)
-HOSTLDFLAGS		+= $(call cc-option,-m32)
 AFLAGS			+= $(call cc-option,-m32)
 LINK-y			+= $(call cc-option,-m32)
 UML_OBJCOPYFLAGS	+= -F $(ELF_FORMAT)



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
