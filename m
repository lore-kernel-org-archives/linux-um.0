Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfNyP-0006l1-5h	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 13:13:25 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DfNyM-0007Vl-88	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 13:13:24 -0700
Message-Id: <200506062008.j56K8BKG008967@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/5] UML - clean up error path
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
Date: Mon, 06 Jun 2005 16:08:11 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This cleans an error path which used to leak file descriptors by returning
without trying to tidy up.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/drivers/chan_user.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/chan_user.c	2005-06-02 17:04:11.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/chan_user.c	2005-06-03 17:46:17.000000000 -0400
@@ -143,22 +143,22 @@ static int winch_tramp(int fd, struct tt
 {
 	struct winch_data data;
 	unsigned long stack;
-	int fds[2], pid, n, err;
+	int fds[2], n, err;
 	char c;
 
 	err = os_pipe(fds, 1, 1);
 	if(err < 0){
 		printk("winch_tramp : os_pipe failed, err = %d\n", -err);
-		return(err);
+		goto out;
 	}
 
 	data = ((struct winch_data) { .pty_fd 		= fd,
 				      .pipe_fd 		= fds[1],
 				      .close_me 	= fds[0] } );
-	pid = run_helper_thread(winch_thread, &data, 0, &stack, 0);
-	if(pid < 0){
+	err = run_helper_thread(winch_thread, &data, 0, &stack, 0);
+	if(err < 0){
 		printk("fork of winch_thread failed - errno = %d\n", errno);
-		return(pid);
+		goto out_close;
 	}
 
 	os_close_file(fds[1]);
@@ -168,14 +168,22 @@ static int winch_tramp(int fd, struct tt
 		printk("winch_tramp : failed to read synchronization byte\n");
 		printk("read failed, err = %d\n", -n);
 		printk("fd %d will not support SIGWINCH\n", fd);
-                pid = -1;
+                err = -EINVAL;
+		goto out_close1;
 	}
-	return(pid);
+	return err ;
+
+ out_close:
+	os_close_file(fds[1]);
+ out_close1:
+	os_close_file(fds[0]);
+ out:
+	return err;
 }
 
 void register_winch(int fd, struct tty_struct *tty)
 {
-	int pid, thread, thread_fd;
+	int pid, thread, thread_fd = -1;
 	int count;
 	char c = 1;
 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
