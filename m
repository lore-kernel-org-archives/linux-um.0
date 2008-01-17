Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcU1-00017t-C1 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:09 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcU0-0001kX-P1
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:09 -0800
Date: Thu, 17 Jan 2008 16:40:44 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214044.GA6737@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 10/20] UML - Move register initialization
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Calling init_registers inside the skas3 checking causes mysterious
crashes if it doesn't happen because the skas3 checking is bypassed.
This patch moves it to os_early_checks.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/start_up.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: linux-2.6.22/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/start_up.c	2007-12-19 13:15:22.000000000 -0500
+++ linux-2.6.22/arch/um/os-Linux/start_up.c	2007-12-19 13:16:08.000000000 -0500
@@ -342,6 +342,8 @@ static void __init check_coredump_limit(
 
 void __init os_early_checks(void)
 {
+	int pid;
+
 	/* Print out the core dump limits early */
 	check_coredump_limit();
 
@@ -351,6 +353,11 @@ void __init os_early_checks(void)
 	 * kernel is running.
 	 */
 	check_tmpexec();
+
+	pid = start_ptraced_child();
+	if (init_registers(pid))
+		fatal("Failed to initialize default registers");
+	stop_ptraced_child(pid, 1, 1);
 }
 
 static int __init noprocmm_cmd_param(char *str, int* add)
@@ -412,9 +419,6 @@ static inline void check_skas3_ptrace_fa
 			non_fatal("found\n");
 	}
 
-	if (init_registers(pid))
-		fatal("Failed to initialize default registers");
-
 	stop_ptraced_child(pid, 1, 1);
 }
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
