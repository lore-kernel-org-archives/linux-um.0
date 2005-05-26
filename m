Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbQxT-0005Cn-AD	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 15:36:07 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DbQxS-0007l0-Ip	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 15:36:07 -0700
Message-Id: <200505262230.j4QMUXjF014699@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/7] UML - Fix segfault on exit with CONFIG_GCOV
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
Date: Thu, 26 May 2005 18:30:33 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

We need to disable signals on exit in all cases, not just when rebooting.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/main.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/main.c	2005-05-26 17:16:46.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/main.c	2005-05-26 17:29:27.000000000 -0400
@@ -87,7 +87,7 @@ int main(int argc, char **argv, char **e
 {
 	char **new_argv;
 	sigset_t mask;
-	int ret, i;
+	int ret, i, err;
 
 	/* Enable all signals except SIGIO - in some environments, we can
 	 * enter with some signals blocked
@@ -160,27 +160,29 @@ int main(int argc, char **argv, char **e
 	 */
 	change_sig(SIGPROF, 0);
 
+        /* This signal stuff used to be in the reboot case.  However, 
+         * sometimes a SIGVTALRM can come in when we're halting (reproducably
+         * when writing out gcov information, presumably because that takes
+         * some time) and cause a segfault.
+         */
+
+        /* stop timers and set SIG*ALRM to be ignored */
+        disable_timer();
+        
+        /* disable SIGIO for the fds and set SIGIO to be ignored */
+        err = deactivate_all_fds();
+        if(err)
+                printf("deactivate_all_fds failed, errno = %d\n", -err);
+
+        /* Let any pending signals fire now.  This ensures
+         * that they won't be delivered after the exec, when
+         * they are definitely not expected.
+         */
+        unblock_signals();
+
 	/* Reboot */
 	if(ret){
-		int err;
-
 		printf("\n");
-
-		/* stop timers and set SIG*ALRM to be ignored */
-		disable_timer();
-
-		/* disable SIGIO for the fds and set SIGIO to be ignored */
-		err = deactivate_all_fds();
-		if(err)
-			printf("deactivate_all_fds failed, errno = %d\n",
-			       -err);
-
-		/* Let any pending signals fire now.  This ensures
-		 * that they won't be delivered after the exec, when
-		 * they are definitely not expected.
-		 */
-		unblock_signals();
-
 		execvp(new_argv[0], new_argv);
 		perror("Failed to exec kernel");
 		ret = 1;



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
