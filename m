Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFfih-0006DH-1c	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 15:27:11 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFfig-0003FD-1D
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 15:27:11 -0700
Message-Id: <200509142156.j8ELu16t012147@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/10] UML - Remove some build warnings
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
Date: Wed, 14 Sep 2005 17:56:01 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

These ugly double-casts are the result of gdb complaining about size 
differences when casting between ints and pointers.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm2/arch/um/os-Linux/aio.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/os-Linux/aio.c	2005-09-08 11:18:05.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/os-Linux/aio.c	2005-09-08 11:29:22.000000000 -0400
@@ -142,7 +142,7 @@
                                "errno = %d\n", errno);
                 }
                 else {
-			aio = (struct aio_context *) event.data;
+			aio = (struct aio_context *) (long) event.data;
 			if(update_aio(aio, event.res)){
 				do_aio(ctx, aio);
 				continue;
Index: linux-2.6.13-mm2/arch/um/os-Linux/elf_aux.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/os-Linux/elf_aux.c	2005-09-08 11:18:05.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/os-Linux/elf_aux.c	2005-09-08 11:29:22.000000000 -0400
@@ -9,6 +9,7 @@
  */
 #include <elf.h>
 #include <stddef.h>
+#include <asm/elf.h>
 #include "init.h"
 #include "elf_user.h"
 #include "mem_user.h"
@@ -54,7 +55,8 @@
                                  * a_un, so we have to use a_val, which is
                                  * all that's left.
                                  */
-				elf_aux_platform = (char *) auxv->a_un.a_val;
+				elf_aux_platform = 
+					(char *) (long) auxv->a_un.a_val;
 				break;
 			case AT_PAGESZ:
 				page_size = auxv->a_un.a_val;



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
