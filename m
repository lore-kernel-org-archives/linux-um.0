Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6IV5-0003pk-7C for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Feb 2006 18:22:39 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F6IV4-00044G-Ht
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Feb 2006 18:22:39 -0800
Message-Id: <200602070223.k172NxuT009664@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/8] UML - Close TUN/TAP file descriptors
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
Date: Mon, 06 Feb 2006 21:23:59 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Robert Hillen <robert.hillen@skynet.be>

When UML opens a TUN/TAP device, the file descriptor could be copied into
later, long-lived threads, holding the device open even after the interface
is taken down, preventing it from being brought up again.  This patch makes
these descriptors close-on-exec so that they disappear from helper processes,
and adds CLONE_FILES to a UML helper thread so that the descriptors are closed
in the thread when they are closed elsewhere in UML.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/chan_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/chan_user.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/chan_user.c	2006-02-06 17:35:47.000000000 -0500
@@ -9,6 +9,7 @@
 #include <termios.h>
 #include <string.h>
 #include <signal.h>
+#include <sched.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -73,7 +74,6 @@ static void winch_handler(int sig)
 struct winch_data {
 	int pty_fd;
 	int pipe_fd;
-	int close_me;
 };
 
 static int winch_thread(void *arg)
@@ -84,7 +84,6 @@ static int winch_thread(void *arg)
 	int count, err;
 	char c = 1;
 
-	os_close_file(data->close_me);
 	pty_fd = data->pty_fd;
 	pipe_fd = data->pipe_fd;
 	count = os_write_file(pipe_fd, &c, sizeof(c));
@@ -153,15 +152,16 @@ static int winch_tramp(int fd, struct tt
 	}
 
 	data = ((struct winch_data) { .pty_fd 		= fd,
-				      .pipe_fd 		= fds[1],
-				      .close_me 	= fds[0] } );
-	err = run_helper_thread(winch_thread, &data, 0, &stack, 0);
+				      .pipe_fd 		= fds[1] } );
+	/* CLONE_FILES so this thread doesn't hold open files which are open
+	 * now, but later closed.  This is a problem with /dev/net/tun.
+	 */
+	err = run_helper_thread(winch_thread, &data, CLONE_FILES, &stack, 0);
 	if(err < 0){
 		printk("fork of winch_thread failed - errno = %d\n", errno);
 		goto out_close;
 	}
 
-	os_close_file(fds[1]);
 	*fd_out = fds[0];
 	n = os_read_file(fds[0], &c, sizeof(c));
 	if(n != sizeof(c)){
@@ -169,13 +169,12 @@ static int winch_tramp(int fd, struct tt
 		printk("read failed, err = %d\n", -n);
 		printk("fd %d will not support SIGWINCH\n", fd);
                 err = -EINVAL;
-		goto out_close1;
+		goto out_close;
 	}
 	return err ;
 
  out_close:
 	os_close_file(fds[1]);
- out_close1:
 	os_close_file(fds[0]);
  out:
 	return err;
Index: linux-2.6.15/arch/um/os-Linux/drivers/tuntap_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/drivers/tuntap_user.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/drivers/tuntap_user.c	2006-02-06 17:35:47.000000000 -0500
@@ -122,6 +122,7 @@ static int tuntap_open_tramp(char *gate,
 		return(-EINVAL);
 	}
 	*fd_out = ((int *) CMSG_DATA(cmsg))[0];
+	os_set_exec_close(*fd_out, 1);
 	return(0);
 }
 
@@ -137,7 +138,8 @@ static int tuntap_open(void *data)
 		return(err);
 
 	if(pri->fixed_config){
-		pri->fd = os_open_file("/dev/net/tun", of_rdwr(OPENFLAGS()), 0);
+		pri->fd = os_open_file("/dev/net/tun",
+				       of_cloexec(of_rdwr(OPENFLAGS())), 0);
 		if(pri->fd < 0){
 			printk("Failed to open /dev/net/tun, err = %d\n",
 			       -pri->fd);



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
