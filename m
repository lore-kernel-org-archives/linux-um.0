Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4oQT-00048m-JN	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 16:31:29 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E4oQS-0004HX-7t
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 16:31:29 -0700
Message-Id: <200508152325.j7FNP8Br009015@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/4] UML - Fix a crash under screen
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
Date: Mon, 15 Aug 2005 19:25:08 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Running UML inside a detached screen delivers SIGWINCH when UML is not 
expecting it.  This patch ignores them.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/kernel/skas/process.c	2005-08-13 09:02:43.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/kernel/skas/process.c	2005-08-13 09:03:15.000000000 -0400
@@ -61,7 +61,11 @@
 
                 CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
         } while((n >= 0) && WIFSTOPPED(status) &&
-                (WSTOPSIG(status) == SIGVTALRM));
+                ((WSTOPSIG(status) == SIGVTALRM) || 
+		 /* running UML inside a detached screen can cause 
+		  * SIGWINCHes 
+		  */
+		 (WSTOPSIG(status) == SIGWINCH)));
 
         if((n < 0) || !WIFSTOPPED(status) ||
            (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status) != SIGTRAP)){



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
