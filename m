Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FnRAt-00020u-W8 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jun 2006 19:20:08 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FmmiU-0007gI-SD for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Jun 2006 00:08:06 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fmi9s-0005PW-F6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jun 2006 19:16:05 -0700
Message-Id: <200606040216.k542GJ8Y004852@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Sat, 03 Jun 2006 22:16:19 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/6] UML - add -ffreestanding to CFLAGS
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>

This fixes the undefined reference to strcpy seen when building modules
on i386.  Tracked down by Al Viro.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/Makefile-i386
===================================================================
--- linux-2.6.16.orig/arch/um/Makefile-i386	2006-05-25 16:08:03.000000000 -0400
+++ linux-2.6.16/arch/um/Makefile-i386	2006-05-26 12:26:09.000000000 -0400
@@ -33,5 +33,9 @@ include $(srctree)/arch/i386/Makefile.cp
 # prevent gcc from keeping the stack 16 byte aligned. Taken from i386.
 cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
 
+# Prevent sprintf in nfsd from being converted to strcpy and resulting in
+# an unresolved reference.
+cflags-y += -ffreestanding
+
 CFLAGS += $(cflags-y)
 USER_CFLAGS += $(cflags-y)



_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
