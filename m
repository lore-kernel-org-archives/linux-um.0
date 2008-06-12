Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6pfb-0003FV-Hn for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 09:29:03 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K6pfa-00025j-CO
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 09:29:03 -0700
Date: Thu, 12 Jun 2008 12:28:41 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080612162841.GA8404@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/2] UML - Remove include of asm/user.h
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

I allowed an include of asm/user.h to sneak back in.  This patch
replaces it with sys/user.h.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/sys-i386/registers.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.22/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/sys-i386/registers.c	2008-06-10 11:42:06.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/sys-i386/registers.c	2008-06-10 11:55:54.000000000 -0400
@@ -6,7 +6,7 @@
 
 #include <errno.h>
 #include <sys/ptrace.h>
-#include <asm/user.h>
+#include <sys/user.h>
 #include "kern_constants.h"
 #include "longjmp.h"
 #include "user.h"
@@ -76,7 +76,7 @@ int put_fp_registers(int pid, unsigned l
 
 void arch_init_registers(int pid)
 {
-	struct user_fxsr_struct fpx_regs;
+	struct user_fpxregs_struct fpx_regs;
 	int err;
 
 	err = ptrace(PTRACE_GETFPXREGS, pid, 0, &fpx_regs);

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
