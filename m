Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyBLX-0000U0-BI	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jul 2005 09:34:59 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1DyBLU-00023B-Ct
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jul 2005 09:34:59 -0700
Message-Id: <200507281626.j6SGQkie009481@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/7] UML - Fix redundant assignment
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
Date: Thu, 28 Jul 2005 12:26:46 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

By this point, .is_user has already been set, so this assignment is useless.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/kernel/skas/trap_user.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/trap_user.c	2005-07-27 17:00:34.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/trap_user.c	2005-07-27 17:01:58.000000000 -0400
@@ -58,7 +58,6 @@
         int segv = ((sig == SIGFPE) || (sig == SIGSEGV) || (sig == SIGBUS) ||
                     (sig == SIGILL) || (sig == SIGTRAP));
 
-	regs->skas.is_user = 1;
 	if (segv)
 		get_skas_faultinfo(pid, &regs->skas.faultinfo);
 	info = &sig_info[sig];



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
