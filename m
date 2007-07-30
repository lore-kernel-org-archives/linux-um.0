Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IFYxZ-0000a7-Rj for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Jul 2007 10:23:11 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IFYkH-0006gN-30
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Jul 2007 10:09:25 -0700
Date: Mon, 30 Jul 2007 13:09:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070730170912.GA7692@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/4] UML - Tidy recently-moved code
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

Now that the generic console operations are in a userspace file, we
can do the following:
	directly call into libc instead of through the os_* wrappers
	eliminate os_window_size since it has only one user

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/chan_user.c |   30 +++++++++++++++---------------
 arch/um/include/os.h        |    1 -
 arch/um/os-Linux/file.c     |   13 -------------
 3 files changed, 15 insertions(+), 29 deletions(-)

Index: linux-2.6.21-mm/arch/um/drivers/chan_user.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/chan_user.c	2007-07-27 11:42:55.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/chan_user.c	2007-07-27 11:46:09.000000000 -0400
@@ -23,43 +23,43 @@
 
 void generic_close(int fd, void *unused)
 {
-	os_close_file(fd);
+	close(fd);
 }
 
 int generic_read(int fd, char *c_out, void *unused)
 {
 	int n;
 
-	n = os_read_file(fd, c_out, sizeof(*c_out));
-
-	if(n == -EAGAIN)
+	n = read(fd, c_out, sizeof(*c_out));
+	if (n > 0)
+		return n;
+	else if (errno == EAGAIN)
 		return 0;
-	else if(n == 0)
+	else if (n == 0)
 		return -EIO;
-	return n;
+	return -errno;
 }
 
-/* XXX Trivial wrapper around os_write_file */
+/* XXX Trivial wrapper around write */
 
 int generic_write(int fd, const char *buf, int n, void *unused)
 {
-	return os_write_file(fd, buf, n);
+	return write(fd, buf, n);
 }
 
 int generic_window_size(int fd, void *unused, unsigned short *rows_out,
 			unsigned short *cols_out)
 {
-	int rows, cols;
+	struct winsize size;
 	int ret;
 
-	ret = os_window_size(fd, &rows, &cols);
-	if(ret < 0)
-		return ret;
+	if(ioctl(fd, TIOCGWINSZ, &size) < 0)
+		return -errno;
 
-	ret = ((*rows_out != rows) || (*cols_out != cols));
+	ret = ((*rows_out != size.ws_row) || (*cols_out != size.ws_col));
 
-	*rows_out = rows;
-	*cols_out = cols;
+	*rows_out = size.ws_row;
+	*cols_out = size.ws_col;
 
 	return ret;
 }
Index: linux-2.6.21-mm/arch/um/include/os.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/os.h	2007-07-27 11:42:27.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/os.h	2007-07-27 11:46:18.000000000 -0400
@@ -134,7 +134,6 @@ extern void os_print_error(int error, co
 extern int os_get_exec_close(int fd, int *close_on_exec);
 extern int os_set_exec_close(int fd, int close_on_exec);
 extern int os_ioctl_generic(int fd, unsigned int cmd, unsigned long arg);
-extern int os_window_size(int fd, int *rows, int *cols);
 extern int os_new_tty_pgrp(int fd, int pid);
 extern int os_get_ifname(int fd, char *namebuf);
 extern int os_set_slip(int fd);
Index: linux-2.6.21-mm/arch/um/os-Linux/file.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/file.c	2007-07-27 11:42:27.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/file.c	2007-07-27 11:46:18.000000000 -0400
@@ -101,19 +101,6 @@ int os_ioctl_generic(int fd, unsigned in
 	return err;
 }
 
-int os_window_size(int fd, int *rows, int *cols)
-{
-	struct winsize size;
-
-	if(ioctl(fd, TIOCGWINSZ, &size) < 0)
-		return -errno;
-
-	*rows = size.ws_row;
-	*cols = size.ws_col;
-
-	return 0;
-}
-
 int os_new_tty_pgrp(int fd, int pid)
 {
 	if(ioctl(fd, TIOCSCTTY, 0) < 0)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
