Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8wZy-0002U9-Lv for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Mar 2004 23:25:34 -0800
Received: from almesberger.net ([63.105.73.238] helo=host.almesberger.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8wZy-0008CS-Do for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Mar 2004 23:25:34 -0800
Received: from almesberger.net (vpnwa-home [10.200.0.2])
	by host.almesberger.net (8.11.6/8.9.3) with ESMTP id i317PPF07204
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 31 Mar 2004 23:25:28 -0800
Received: (from werner@localhost)
	by almesberger.net (8.11.6/8.11.6) id i317PDH24822
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 1 Apr 2004 04:25:13 -0300
From: Werner Almesberger <werner@almesberger.net>
Message-ID: <20040401042512.Y28573@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] RFC: lossless printk
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
Date: Thu, 1 Apr 2004 04:25:12 -0300
To: user-mode-linux-devel@lists.sourceforge.net

The non-blocking console of UML silenty drops printks if they would
block. This is a tad annoying if you want to record all of them in
a file, e.g. if you're using UML for automated regression tests.

The patch below optionally makes printks pause and retry until they
succeed. Note that printk.c does the serialization for us, so
there's no need to lock again.

Not sure if this should really be a config option, or it it
shouldn't be enabled by default. I've been using this for a while
in a slightly more limited form, and it never seemed to get in the
way such that I'd prefer the original, "lossy" printk.

- Werner

---------------------------------- cut here -----------------------------------

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
+++ linux-2.6.4/arch/um/drivers/Makefile	Wed Mar 31 22:17:18 2004
@@ -41,13 +41,14 @@
 obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW) += cow_kern.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
+obj-$(CONFIG_LOSSLESS_STDIO_CONSOLE) += console_user.o
 
 obj-y += stdio_console.o $(CHAN_OBJS)
 
 USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),$($(f)-objs))
 
 USER_OBJS := $(filter %_user.o,$(obj-y) $(obj-m) $(USER_SINGLE_OBJS)) fd.o \
-	null.o pty.o tty.o xterm.o
+	null.o pty.o tty.o xterm.o console_user.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 $(USER_OBJS) : %.o: %.c
--- linux-2.6.4-orig/arch/um/drivers/stdio_console.c	Tue Mar 16 03:11:43 2004
+++ linux-2.6.4/arch/um/drivers/stdio_console.c	Wed Mar 31 22:16:59 2004
@@ -194,6 +194,11 @@
 static void console_write(struct console *console, const char *string, 
 			  unsigned len)
 {
+#ifdef CONFIG_LOSSLESS_STDIO_CONSOLE
+	void lossless_stdio_console_write(const char *string,unsigned len);
+
+	lossless_stdio_console_write(string,len);
+#else
 	struct line *line = &vts[console->index];
 
 	if(con_init_done)
@@ -201,6 +206,7 @@
 	console_write_chan(&line->chan_list, string, len);
 	if(con_init_done)
 		up(&line->sem);
+#endif
 }
 
 static struct tty_driver *console_device(struct console *c, int *index)
--- /dev/null	Fri Dec 12 23:38:58 2003
+++ linux-2.6.4/arch/um/drivers/console_user.c	Thu Apr  1 04:15:28 2004
@@ -0,0 +1,53 @@
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
+#include <unistd.h>
+#include <errno.h>
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
+	const char *p;
+	int wrote;
+
+	for (p = string; len; p += wrote) {
+		while (1) {
+			int n;
+
+			wrote = write(1,p,len);
+			if (wrote >= 0)
+				break;
+
+			if (errno == EAGAIN) {
+				usleep(100000); /* nap for 100ms */
+				continue;
+			}
+
+			/*
+			 * We're in trouble. Try to get the message out with
+			 * our dying breath, then expire.
+			 */
+			for (n = errno; n; n--)
+				write(2,"#",1);
+
+			/* doesn't really do much, but try to die anyway */
+			abort();
+		}
+		len -= wrote;
+	}
+}

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
