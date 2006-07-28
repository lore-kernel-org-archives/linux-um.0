Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G6Igb-0005g2-JY for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 20:06:50 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G6IgT-00033L-FD
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 20:06:43 -0700
Message-Id: <200607280306.k6S36SYl007946@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 27 Jul 2006 23:06:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/7] UML - Fix handling of failed execs of helpers
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

There were some bugs in handling failures to exec helper programs.
errno was passed back from the child with the wrong sign.  It was also
ignored.  In the case where it mattered, the errno from the
(successful) read in the parent was used instead.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/os-Linux/helper.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/helper.c	2006-07-13 15:32:08.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/helper.c	2006-07-14 10:19:35.000000000 -0400
@@ -42,7 +42,7 @@ static int helper_child(void *arg)
 	if(data->pre_exec != NULL)
 		(*data->pre_exec)(data->pre_data);
 	execvp(argv[0], argv);
-	errval = errno;
+	errval = -errno;
 	printk("helper_child - execve of '%s' failed - errno = %d\n", argv[0], errno);
 	os_write_file(data->fd, &errval, sizeof(errval));
 	kill(os_getpid(), SIGKILL);
@@ -62,7 +62,7 @@ int run_helper(void (*pre_exec)(void *),
 		stack = *stack_out;
 	else stack = alloc_stack(0, __cant_sleep());
 	if(stack == 0)
-		return(-ENOMEM);
+		return -ENOMEM;
 
 	ret = os_pipe(fds, 1, 0);
 	if(ret < 0){
@@ -95,16 +95,16 @@ int run_helper(void (*pre_exec)(void *),
 	/* Read the errno value from the child, if the exec failed, or get 0 if
 	 * the exec succeeded because the pipe fd was set as close-on-exec. */
 	n = os_read_file(fds[0], &ret, sizeof(ret));
-	if (n < 0) {
-		printk("run_helper : read on pipe failed, ret = %d\n", -n);
-		ret = n;
-		kill(pid, SIGKILL);
-		CATCH_EINTR(waitpid(pid, NULL, 0));
-	} else if(n != 0){
-		CATCH_EINTR(n = waitpid(pid, NULL, 0));
-		ret = -errno;
-	} else {
+	if(n == 0)
 		ret = pid;
+	else {
+		if(n < 0){
+			printk("run_helper : read on pipe failed, ret = %d\n", 
+			       -n);
+			ret = n;
+			kill(pid, SIGKILL);
+		}
+		CATCH_EINTR(waitpid(pid, NULL, 0));
 	}
 
 out_close:


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
