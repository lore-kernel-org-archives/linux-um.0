Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B9VNR-0008Qt-CS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Apr 2004 12:34:57 -0800
Received: from almesberger.net ([63.105.73.238] helo=host.almesberger.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B9VNR-0005cp-0I for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Apr 2004 12:34:57 -0800
Received: from almesberger.net (vpnwa-home [10.200.0.2])
	by host.almesberger.net (8.11.6/8.9.3) with ESMTP id i32KYtF22353
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 2 Apr 2004 12:34:56 -0800
Received: (from werner@localhost)
	by almesberger.net (8.11.6/8.11.6) id i32KYj415655
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 2 Apr 2004 17:34:45 -0300
From: Werner Almesberger <werner@almesberger.net>
Message-ID: <20040402173445.J32255@almesberger.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
Subject: [uml-devel] RFC: lossless printk, version 2
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
Date: Fri, 2 Apr 2004 17:34:45 -0300
To: user-mode-linux-devel@lists.sourceforge.net



--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Second, cleaner version. The changes:

 - retry on EINTR
 - instead of trying to die, disable console permanently on any error
   but EINTR and EAGAIN
 - prints "nice" message on error
 - removed duplicate console_user.o in Makefile
 - moved lossless_stdio_console_write prototype from stdio_console.c
   to stdio_console.h

Thanks to all who have sent comments !

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p2

--- linux-2.6.4-orig/arch/um/Kconfig_char	Wed Mar 10 23:55:26 2004
+++ linux-2.6.4/arch/um/Kconfig_char	Wed Mar 31 22:18:21 2004
@@ -5,6 +5,14 @@
 	bool
 	default y
 
+config LOSSLESS_STDIO_CONSOLE
+	bool "Lossless standard output console"
+	depends on STDIO_CONSOLE
+	help
+	When console output goes to standard output, retry write operations
+	that would block. This is particularly useful when recording the
+	output of a UML system in a file.
+
 config SSL
 	bool "Virtual serial line"
 	help
--- linux-2.6.4-orig/arch/um/drivers/Makefile	Tue Mar 16 03:11:43 2004
+++ linux-2.6.4/arch/um/drivers/Makefile	Fri Apr  2 16:57:21 2004
@@ -41,6 +41,7 @@
 obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW) += cow_kern.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
+obj-$(CONFIG_LOSSLESS_STDIO_CONSOLE) += console_user.o
 
 obj-y += stdio_console.o $(CHAN_OBJS)
 
--- linux-2.6.4-orig/arch/um/drivers/stdio_console.h	Wed Mar 10 23:55:26 2004
+++ linux-2.6.4/arch/um/drivers/stdio_console.h	Fri Apr  2 17:09:00 2004
@@ -7,6 +7,9 @@
 #define __STDIO_CONSOLE_H
 
 extern void save_console_flags(void);
+
+void lossless_stdio_console_write(const char *string,unsigned len);
+
 #endif
 
 /*
--- linux-2.6.4-orig/arch/um/drivers/stdio_console.c	Tue Mar 16 03:11:43 2004
+++ linux-2.6.4/arch/um/drivers/stdio_console.c	Fri Apr  2 17:09:05 2004
@@ -194,6 +194,9 @@
 static void console_write(struct console *console, const char *string, 
 			  unsigned len)
 {
+#ifdef CONFIG_LOSSLESS_STDIO_CONSOLE
+	lossless_stdio_console_write(string,len);
+#else
 	struct line *line = &vts[console->index];
 
 	if(con_init_done)
@@ -201,6 +204,7 @@
 	console_write_chan(&line->chan_list, string, len);
 	if(con_init_done)
 		up(&line->sem);
+#endif
 }
 
 static struct tty_driver *console_device(struct console *c, int *index)
--- /dev/null	Fri Dec 12 23:38:58 2003
+++ linux-2.6.4/arch/um/drivers/console_user.c	Fri Apr  2 17:20:37 2004
@@ -0,0 +1,62 @@
+/*
+ * arch/um/drivers/console_user.c - Lossless console driver using write(2)
+ *
+ * Written 2003,2004 by Werner Almesberger
+ */
+
+
+#include <stdlib.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "stdio_console.h"
+
+
+/*
+ * UML makes the console non-blocking. And indeed, even when stdout is
+ * redirected to a file, we may occasionally get EAGAIN, and lose a message or
+ * ten. This console write function just retries the write, without affecting
+ * other users of the console.
+ */
+
+
+void lossless_stdio_console_write(const char *string,unsigned len)
+{
+	static int console_broken = 0;
+	static char buf[100]; /* check with message size, below */
+	const char *p;
+	int wrote;
+
+	if (console_broken)
+		return;
+
+	for (p = string; len; p += wrote) {
+		while (1) {
+			wrote = write(1,p,len);
+			if (wrote >= 0)
+				break;
+
+			if (errno == EINTR)
+				continue;
+			if (errno == EAGAIN) {
+				usleep(100000); /* nap for 100ms */
+				continue;
+			}
+
+			/*
+			 * We're in trouble. Try to get the message out on
+			 * stderr, then turn off the console.
+			 */
+			sprintf(buf,"Console write failed with errno %d. "
+			    "Disabling console.\r\n",errno);
+			(void) write(2,buf,strlen(buf));
+
+			console_broken = 1;
+			return;
+		}
+		len -= wrote;
+	}
+}

--XsQoSWH+UP9D9v3l--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
