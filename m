Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H46SM-0006eS-7W for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jan 2007 18:11:18 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H46SL-0001Ly-KY
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jan 2007 18:11:18 -0800
Message-Id: <200701090205.l0925lqE024386@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 08 Jan 2007 21:05:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/7] UML - Delete unused file
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
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

It turns out that resource.c isn't needed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/Makefile   |    2 +-
 arch/um/kernel/resource.c |   23 -----------------------
 2 files changed, 1 insertion(+), 24 deletions(-)

Index: linux-2.6.18-mm/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/Makefile	2007-01-08 16:15:33.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/Makefile	2007-01-08 16:16:37.000000000 -0500
@@ -7,7 +7,7 @@ extra-y := vmlinux.lds
 clean-files :=
 
 obj-y = config.o exec.o exitcode.o init_task.o irq.o ksyms.o mem.o \
-	physmem.o process.o ptrace.o reboot.o resource.o sigio.o \
+	physmem.o process.o ptrace.o reboot.o sigio.o \
 	signal.o smp.o syscall.o sysrq.o time.o tlb.o trap.o uaccess.o \
 	um_arch.o umid.o
 
Index: linux-2.6.18-mm/arch/um/kernel/resource.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/resource.c	2007-01-07 10:51:51.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,23 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include "linux/pci.h"
-
-unsigned long resource_fixup(struct pci_dev * dev, struct resource * res,
-			     unsigned long start, unsigned long size)
-{
-	return start;
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
