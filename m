Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HyU3r-000277-LN for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jun 2007 07:43:04 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HyU3q-0006Rv-Vp
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jun 2007 07:43:03 -0700
Date: Wed, 13 Jun 2007 10:42:45 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070613144245.GA5777@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/2] UML - DEBUG_SHIRQ fixes
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
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, Eduard-Gabriel Munteanu <maxdamage@aladin.ro>

From: Eduard-Gabriel Munteanu <maxdamage@aladin.ro>

DEBUG_SHIRQ generates spurious interrupts, triggering handlers such as
mconsole_interrupt() or line_interrupt(). They expect data to be
available to be read from their sockets/pipes, but in the case of
spurious interrupts, the host didn't actually send anything, so UML  
hangs in read() and friends. Setting those fd's as O_NONBLOCK makes 
DEBUG_SHIRQ-enabled UML kernels boot and run correctly.

The patch was written and tested on Linux 2.6.22-rc2-mm1.

I have also included a couple of short/minor fixes for potential
problems.

Signed-off-by: Eduard-Gabriel Munteanu <maxdamage@aladin.ro>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/chan_user.c     |    8 +++++++-
 arch/um/drivers/mconsole_user.c |    5 +++--
 arch/um/drivers/ubd_user.c      |    6 ++++++
 arch/um/drivers/xterm.c         |    7 +++++++
 4 files changed, 23 insertions(+), 3 deletions(-)

Index: linux-2.6.21-mm/arch/um/drivers/chan_user.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/chan_user.c	2007-06-06 09:28:13.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/chan_user.c	2007-06-11 13:51:29.000000000 -0400
@@ -170,7 +170,13 @@ static int winch_tramp(int fd, struct tt
                 err = -EINVAL;
 		goto out_close;
 	}
-	return err ;
+
+	if (os_set_fd_block(*fd_out, 0)) {
+		printk("winch_tramp: failed to set thread_fd non-blocking.\n");
+		goto out_close;
+	}
+
+	return err;
 
  out_close:
 	os_close_file(fds[1]);
Index: linux-2.6.21-mm/arch/um/drivers/mconsole_user.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/mconsole_user.c	2007-06-06 09:28:13.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/mconsole_user.c	2007-06-11 13:38:19.000000000 -0400
@@ -86,8 +86,9 @@ int mconsole_get_request(int fd, struct 
 	int len;
 
 	req->originlen = sizeof(req->origin);
-	req->len = recvfrom(fd, &req->request, sizeof(req->request), 0,
-			    (struct sockaddr *) req->origin, &req->originlen);
+	req->len = recvfrom(fd, &req->request, sizeof(req->request),
+			    MSG_DONTWAIT, (struct sockaddr *) req->origin,
+			    &req->originlen);
 	if (req->len < 0)
 		return 0;
 
Index: linux-2.6.21-mm/arch/um/drivers/ubd_user.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/ubd_user.c	2007-06-06 09:28:13.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/ubd_user.c	2007-06-11 13:44:56.000000000 -0400
@@ -43,6 +43,12 @@ int start_io_thread(unsigned long sp, in
 	kernel_fd = fds[0];
 	*fd_out = fds[1];
 
+	err = os_set_fd_block(*fd_out, 0);
+	if (err) {
+		printk("start_io_thread - failed to set nonblocking I/O.\n");
+		goto out_close;
+	}
+
 	pid = clone(io_thread, (void *) sp, CLONE_FILES | CLONE_VM | SIGCHLD,
 		    NULL);
 	if(pid < 0){
Index: linux-2.6.21-mm/arch/um/drivers/xterm.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/xterm.c	2007-06-06 09:28:13.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/xterm.c	2007-06-12 12:25:44.000000000 -0400
@@ -151,6 +151,13 @@ int xterm_open(int input, int output, in
 		goto out;
 	}
 
+	err = os_set_fd_block(new, 0);
+	if (err) {
+		printk("xterm_open : failed to set xterm descriptor "
+		       "non-blocking, err = %d\n", -err);
+		goto out;
+	}
+
 	CATCH_EINTR(err = tcgetattr(new, &data->tt));
 	if(err){
 		new = err;

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
