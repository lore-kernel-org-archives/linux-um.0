Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G6IgO-0005ae-W7 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 20:06:37 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G6IgO-0007aw-F0
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 20:06:36 -0700
Message-Id: <200607280306.k6S36NFb007936@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 27 Jul 2006 23:06:23 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/7] UML - Fix stack alignment
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
Cc: Frank van Maarseveen <frankvm@frankvm.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Stack randomization needs to be conditional on the personality allowing it.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/process_kern.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/process_kern.c	2006-07-13 15:05:02.000000000 -0400
@@ -23,6 +23,7 @@
 #include "linux/proc_fs.h"
 #include "linux/ptrace.h"
 #include "linux/random.h"
+#include "linux/personality.h"
 #include "asm/unistd.h"
 #include "asm/mman.h"
 #include "asm/segment.h"
@@ -476,7 +477,7 @@ int singlestepping(void * t)
 #ifndef arch_align_stack
 unsigned long arch_align_stack(unsigned long sp)
 {
-	if (randomize_va_space)
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
 		sp -= get_random_int() % 8192;
 	return sp & ~0xf;
 }


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
