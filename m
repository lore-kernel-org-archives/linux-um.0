Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj1Tn-00005X-CW for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 11:24:03 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Aj1Tm-0005mU-Pi for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 11:24:02 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bDYDAy7STdKdbCl"
Message-Id: <200401202026.19785.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] First shrinkage of *_user.c files
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
Date: Tue, 20 Jan 2004 20:26:19 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>



--Boundary-00=_bDYDAy7STdKdbCl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've started removing some functions from the user_objs, and here there are 
the two first patches. Any comment on the style of these changes is highly 
appreciated. The next thing I'm going to do is to remove entirely 
hostaudio_user.c (I've already started this, but I've not got a successful 
test yet, since I also did a little fix in this).
Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN

--Boundary-00=_bDYDAy7STdKdbCl
Content-Type: text/x-diff;
  charset="us-ascii";
  name="Os_expand_1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Os_expand_1.diff"

--- ./arch/um/include/os.h.fix	2004-01-17 18:41:12.000000000 +0100
+++ ./arch/um/include/os.h	2004-01-19 20:54:48.000000000 +0100
@@ -130,6 +130,7 @@
 extern int os_set_slip(int fd);
 extern int os_set_owner(int fd, int pid);
 extern int os_sigio_async(int master, int slave);
+extern int os_make_pty_raw(int master);
 extern int os_mode_fd(int fd, int mode);
 
 extern int os_seek_file(int fd, __u64 offset);
--- ./arch/um/kernel/sigio_user.c.fix	2004-01-17 18:41:14.000000000 +0100
+++ ./arch/um/kernel/sigio_user.c	2004-01-19 21:00:50.000000000 +0100
@@ -50,7 +50,6 @@
 void __init check_one_sigio(void (*proc)(int, int))
 {
 	struct sigaction old, new;
-	struct termios tt;
 	struct openpty_arg pty = { .master = -1, .slave = -1 };
 	int master, slave, err;
 
@@ -68,12 +67,9 @@
 		return;
 	}
 
-	/* XXX These can fail with EINTR */
-	if(tcgetattr(master, &tt) < 0)
-		panic("check_sigio : tcgetattr failed, errno = %d\n", errno);
-	cfmakeraw(&tt);
-	if(tcsetattr(master, TCSADRAIN, &tt) < 0)
-		panic("check_sigio : tcsetattr failed, errno = %d\n", errno);
+	err = os_make_pty_raw(master);
+	if (err < 0)
+		panic("check_sigio : os_make_pty_raw failed, errno = %d\n", -err);
 
 	err = os_sigio_async(master, slave);
 	if(err < 0)
--- ./arch/um/os-Linux/file.c.fix	2004-01-17 18:41:19.000000000 +0100
+++ ./arch/um/os-Linux/file.c	2004-01-19 21:24:27.000000000 +0100
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <signal.h>
+#include <termios.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/socket.h>
@@ -132,6 +133,32 @@
 	return(0);
 }
 
+int os_make_pty_raw(int master)
+{
+	struct termios tt;
+	int err;
+
+	while (((err = tcgetattr(master, &tt)) < 0) && errno == EINTR)
+		;
+	if(err < 0) {
+		printk("os_make_pty_raw : tcgetattr failed, errno = %d\n", errno);
+		goto fail;
+	}
+
+	cfmakeraw(&tt);
+
+	while (((err = tcsetattr(master, TCSADRAIN, &tt)) < 0) && errno == EINTR)
+		;
+	if(err < 0) {
+		printk("os_make_pty_raw : tcsetattr failed, errno = %d\n", errno);
+		goto fail;
+	}
+
+	return 0;
+fail:
+	return -errno;
+}
+
 /* FIXME: ensure namebuf in os_get_if_name is big enough */
 int os_get_ifname(int fd, char* namebuf)
 {

--Boundary-00=_bDYDAy7STdKdbCl
Content-Type: text/x-diff;
  charset="us-ascii";
  name="Os_expand_2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Os_expand_2.diff"

--- ./arch/um/drivers/chan_kern.c.fix	2004-01-17 18:41:10.000000000 +0100
+++ ./arch/um/drivers/chan_kern.c	2004-01-19 21:34:30.000000000 +0100
@@ -17,6 +17,7 @@
 #include "irq_user.h"
 #include "sigio.h"
 #include "line.h"
+#include "os.h"
 
 static void *not_configged_init(char *str, int device, struct chan_opts *opts)
 {
@@ -87,6 +88,52 @@
 	.winch		= 0,
 };
 
+void generic_close(int fd, void *unused)
+{
+	os_close_file(fd);
+}
+
+int generic_read(int fd, char *c_out, void *unused)
+{
+	int n;
+
+	n = os_read_file(fd, c_out, sizeof(*c_out));
+
+	if(n == -EAGAIN) 
+		return(0);
+	else if(n == 0) 
+		return(-EIO);
+	return(n);
+}
+
+int generic_write(int fd, const char *buf, int n, void *unused)
+{
+	return(os_write_file(fd, buf, n));
+}
+
+int generic_window_size(int fd, void *unused, unsigned short *rows_out,
+			unsigned short *cols_out)
+{
+	int rows, cols;
+	int ret;
+
+	ret = os_window_size(fd, &rows, &cols);
+	if(ret < 0)
+		return(ret);
+
+	ret = ((*rows_out != rows) || (*cols_out != cols));
+
+	*rows_out = rows;
+	*cols_out = cols;
+
+	return(ret);
+}
+
+void generic_free(void *data)
+{
+	kfree(data);
+}
+
 static void tty_receive_char(struct tty_struct *tty, char ch)
 {
 	if(tty == NULL) return;
--- ./arch/um/drivers/chan_user.c.fix	2004-01-17 18:41:10.000000000 +0100
+++ ./arch/um/drivers/chan_user.c	2004-01-19 21:32:03.000000000 +0100
@@ -21,31 +21,6 @@
 #include "choose-mode.h"
 #include "mode.h"
 
-void generic_close(int fd, void *unused)
-{
-	os_close_file(fd);
-}
-
-int generic_read(int fd, char *c_out, void *unused)
-{
-	int n;
-
-	n = os_read_file(fd, c_out, sizeof(*c_out));
-
-	if(n == -EAGAIN) 
-		return(0);
-	else if(n == 0) 
-		return(-EIO);
-	return(n);
-}
-
-/* XXX Trivial wrapper around os_write_file */
-
-int generic_write(int fd, const char *buf, int n, void *unused)
-{
-	return(os_write_file(fd, buf, n));
-}
-
 int generic_console_write(int fd, const char *buf, int n, void *unused)
 {
 	struct termios save, new;
@@ -62,29 +37,6 @@
 	return(err);
 }
 
-int generic_window_size(int fd, void *unused, unsigned short *rows_out,
-			unsigned short *cols_out)
-{
-	int rows, cols;
-	int ret;
-
-	ret = os_window_size(fd, &rows, &cols);
-	if(ret < 0)
-		return(ret);
-
-	ret = ((*rows_out != rows) || (*cols_out != cols));
-
-	*rows_out = rows;
-	*cols_out = cols;
-
-	return(ret);
-}
-
-void generic_free(void *data)
-{
-	kfree(data);
-}
-
 static void winch_handler(int sig)
 {
 }

--Boundary-00=_bDYDAy7STdKdbCl--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
