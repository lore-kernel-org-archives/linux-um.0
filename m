Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Na1-0002Dt-8l for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:07:49 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8NZz-0002cp-7R for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:07:49 -0800
Message-Id: <200503072038.j27Kcvbc004013@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 15/16] UML - Improve error reporting
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
Date: Mon, 07 Mar 2005 15:38:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This patch adds some errors and warnings where there were none before:
    If someone typos "ubd" as "udb", that is caught and a warning is printed
    If a ubd file can't be opened, that now results in an error message
    If there are more telnet connections to port consoles than there are 
consoles, then a message will appear in the telnet session explaining why
there is no login prompt.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/port_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/port_kern.c	2005-03-05 12:07:31.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/port_kern.c	2005-03-05 12:25:42.000000000 -0500
@@ -10,6 +10,7 @@
 #include "linux/irq.h"
 #include "linux/spinlock.h"
 #include "linux/errno.h"
+#include "asm/atomic.h"
 #include "asm/semaphore.h"
 #include "asm/errno.h"
 #include "kern_util.h"
@@ -22,6 +23,7 @@
 
 struct port_list {
 	struct list_head list;
+	atomic_t wait_count;
 	int has_connection;
 	struct semaphore sem;
 	int port;
@@ -70,6 +72,13 @@
 	return(IRQ_HANDLED);
 }
 
+#define NO_WAITER_MSG \
+    "****\n" \
+    "There are currently no UML consoles waiting for port connections.\n" \
+    "Either disconnect from one to make it available or activate some more\n" \
+    "by enabling more consoles in the UML /etc/inittab.\n" \
+    "****\n"
+
 static int port_accept(struct port_list *port)
 {
 	struct connection *conn;
@@ -104,6 +113,10 @@
 		goto out_free;
 	}
 
+	if(atomic_read(&port->wait_count) == 0){
+		os_write_file(fd, NO_WAITER_MSG, sizeof(NO_WAITER_MSG));
+		printk("No one waiting for port\n");
+	}
 	list_add(&conn->list, &port->pending);
 	return(1);
 
@@ -182,6 +195,7 @@
 
 	*port = ((struct port_list) 
 		{ .list 	 	= LIST_HEAD_INIT(port->list),
+		  .wait_count		= ATOMIC_INIT(0),
 		  .has_connection 	= 0,
 		  .sem 			= __SEMAPHORE_INITIALIZER(port->sem, 
 								  0),
@@ -220,9 +234,11 @@
 	struct port_list *port = dev->port;
 	int fd;
 
+        atomic_inc(&port->wait_count);
 	while(1){
+		fd = -ERESTARTSYS;
 		if(down_interruptible(&port->sem))
-			return(-ERESTARTSYS);
+                        goto out;
 
 		spin_lock(&port->lock);
 
@@ -254,8 +270,9 @@
 	dev->helper_pid = conn->helper_pid;
 	dev->telnetd_pid = conn->telnetd_pid;
 	kfree(conn);
-
-	return(fd);
+ out:
+	atomic_dec(&port->wait_count);
+	return fd;
 }
 
 void port_remove_dev(void *d)
Index: linux-2.6.11/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/ubd_kern.c	2005-03-05 12:11:43.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/ubd_kern.c	2005-03-05 12:24:27.000000000 -0500
@@ -453,6 +453,22 @@
 "    an 's' will cause data to be written to disk on the host immediately.\n\n"
 );
 
+static int udb_setup(char *str)
+{
+	printk("udb%s specified on command line is almost certainly a ubd -> "
+	       "udb TYPO\n", str);
+	return(1);
+}
+
+__setup("udb", udb_setup);
+__uml_help(udb_setup,
+"udb\n"
+"    This option is here solely to catch ubd -> udb typos, which can be\n\n"
+"    to impossible to catch visually unless you specifically look for\n\n"
+"    them.  The only result of any option starting with 'udb' is an error\n\n"
+"    in the boot output.\n\n"
+);
+
 static int fakehd_set = 0;
 static int fakehd(char *str)
 {
@@ -605,7 +621,11 @@
 		}
 	}
 
-	if(dev->fd < 0) return(dev->fd);
+	if(dev->fd < 0){
+		printk("Failed to open '%s', errno = %d\n", dev->file, 
+		       -dev->fd);
+		return(dev->fd);
+	}
 
 	if(dev->cow.file != NULL){
 		err = -ENOMEM;



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
