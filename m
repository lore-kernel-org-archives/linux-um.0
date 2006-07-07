Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FyeHo-0006ak-LV for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:36 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FyeHo-0000iO-5y
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:36 -0700
Message-Id: <200607070033.k670Xlvt008717@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 06 Jul 2006 20:33:47 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 12/19] UML - Fix exitcall ordering bug
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

This fixes an exitcall ordering bug - calls to ignore_sigio_fd can
come from exitcalls that come after the sigio thread has been killed.
This would cause shutdown to hang or crash.

Fixed by having ignore_sigio_fd check that the thread is present
before trying to communicate with it.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/os-Linux/sigio.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/sigio.c	2006-07-06 13:44:26.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/sigio.c	2006-07-06 14:46:10.000000000 -0400
@@ -191,6 +191,13 @@ int ignore_sigio_fd(int fd)
 	struct pollfd *p;
 	int err = 0, i, n = 0;
 
+	/* This is called from exitcalls elsewhere in UML - if
+	 * sigio_cleanup has already run, then update_thread will hang
+	 * or fail because the thread is no longer running.
+	 */
+	if(write_sigio_pid == -1)
+		return -EIO;
+
 	sigio_lock();
 	for(i = 0; i < current_poll.used; i++){
 		if(current_poll.poll[i].fd == fd) break;
@@ -215,7 +222,7 @@ int ignore_sigio_fd(int fd)
 	update_thread();
  out:
 	sigio_unlock();
-	return(err);
+	return err;
 }
 
 static struct pollfd *setup_initial_poll(int fd)


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
