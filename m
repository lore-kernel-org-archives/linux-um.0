Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IFYxZ-0000Yw-Rj for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Jul 2007 10:23:11 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IFYkG-0006gM-Nh
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Jul 2007 10:09:25 -0700
Date: Mon, 30 Jul 2007 13:09:11 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070730170911.GA7687@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/4] UML - Move userspace code to userspace file
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

Move some code from a kernelspace file to a userspace file where it
fits better.  This enables some tidying which is the subject of a
later patch.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/chan_kern.c |   48 -------------------------------------------
 arch/um/drivers/chan_user.c |   49 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 48 deletions(-)

Index: linux-2.6.21-mm/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/chan_kern.c	2007-07-27 11:34:20.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/chan_kern.c	2007-07-27 11:35:30.000000000 -0400
@@ -89,54 +89,6 @@ static const struct chan_ops not_configg
 };
 #endif /* CONFIG_NOCONFIG_CHAN */
 
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
-		return 0;
-	else if(n == 0)
-		return -EIO;
-	return n;
-}
-
-/* XXX Trivial wrapper around os_write_file */
-
-int generic_write(int fd, const char *buf, int n, void *unused)
-{
-	return os_write_file(fd, buf, n);
-}
-
-int generic_window_size(int fd, void *unused, unsigned short *rows_out,
-			unsigned short *cols_out)
-{
-	int rows, cols;
-	int ret;
-
-	ret = os_window_size(fd, &rows, &cols);
-	if(ret < 0)
-		return ret;
-
-	ret = ((*rows_out != rows) || (*cols_out != cols));
-
-	*rows_out = rows;
-	*cols_out = cols;
-
-	return ret;
-}
-
-void generic_free(void *data)
-{
-	kfree(data);
-}
-
 static void tty_receive_char(struct tty_struct *tty, char ch)
 {
 	if(tty == NULL) return;
Index: linux-2.6.21-mm/arch/um/drivers/chan_user.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/chan_user.c	2007-07-27 11:34:20.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/chan_user.c	2007-07-27 11:42:55.000000000 -0400
@@ -19,6 +19,55 @@
 #include "os.h"
 #include "choose-mode.h"
 #include "mode.h"
+#include "um_malloc.h"
+
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
+		return 0;
+	else if(n == 0)
+		return -EIO;
+	return n;
+}
+
+/* XXX Trivial wrapper around os_write_file */
+
+int generic_write(int fd, const char *buf, int n, void *unused)
+{
+	return os_write_file(fd, buf, n);
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
+		return ret;
+
+	ret = ((*rows_out != rows) || (*cols_out != cols));
+
+	*rows_out = rows;
+	*cols_out = cols;
+
+	return ret;
+}
+
+void generic_free(void *data)
+{
+	kfree(data);
+}
 
 int generic_console_write(int fd, const char *buf, int n)
 {

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
