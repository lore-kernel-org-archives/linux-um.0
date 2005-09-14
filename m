Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFfLS-0003ij-MK	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 15:03:10 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFfLS-0004Ix-Ay
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 15:03:10 -0700
Message-Id: <200509142156.j8ELuFl7012174@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 10/10] UML - remove include of asm/elf.h
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
Date: Wed, 14 Sep 2005 17:56:15 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

asm/elf.h is bad on x86_64, and i386 doesn't need it any more after Al's 
cleanup.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/os-Linux/elf_aux.c
===================================================================
--- test.orig/arch/um/os-Linux/elf_aux.c	2005-09-14 15:47:21.000000000 -0400
+++ test/arch/um/os-Linux/elf_aux.c	2005-09-14 15:48:17.000000000 -0400
@@ -9,7 +9,6 @@
  */
 #include <elf.h>
 #include <stddef.h>
-#include <asm/elf.h>
 #include "init.h"
 #include "elf_user.h"
 #include "mem_user.h"



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
