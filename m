Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Azx2y-0001lg-12 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Mar 2004 04:06:20 -0800
Received: from mout0.freenet.de ([194.97.50.131] ident=exim)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AzwRW-0005uz-GH
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Mar 2004 03:27:39 -0800
From: "Patrick \"Petschge\" Kilian" <petschge@web.de>
Subject: Re: [uml-devel] Re: [uml-user] UNIX socket networking
References: <200402290158.54770.jdizzl@xs4all.nl>
	<20040301201438.DE4903BCB7@home.petschge.de>
	<200403021909.47013.blaisorblade_spam@yahoo.it>
	<200403022240.25616.petschge@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20040307105414.EDC363BCB7@home.petschge.de>
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
Date: Sun, 07 Mar 2004 11:54:13 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

Hi all,

Here is a new version:

--- unix_sock_driver.patch

diff -Nur linux-2.6.0-test11-uml/.config linux-2.6.0-test11-uml2/.config
--- linux-2.6.0-test11-uml/.config	Fri Dec 12 17:52:41 2003
+++ linux-2.6.0-test11-uml2/.config	Wed Dec 31 19:21:29 2003
@@ -15,6 +15,7 @@
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
 CONFIG_HOSTFS=y
+CONFIG_HOSTSOCKET=y
 # CONFIG_HPPFS is not set
 CONFIG_MCONSOLE=y
 CONFIG_MAGIC_SYSRQ=y
diff -Nur linux-2.6.0-test11-uml/arch/um/Kconfig linux-2.6.0-test11-uml2/arch/um/Kconfig
--- linux-2.6.0-test11-uml/arch/um/Kconfig	Fri Dec 12 17:38:50 2003
+++ linux-2.6.0-test11-uml2/arch/um/Kconfig	Wed Dec 31 19:20:39 2003
@@ -99,6 +99,15 @@
         If you'd like to be able to work with files stored on the host, 
         say Y or M here; otherwise say N.
 
+config HOSTSOCKET
+	bool "Hostsocket Support"
+	default n
+	depends on EXPERIMENTAL
+	help
+	Support for tunneling of unix sockets. Currently very b0rken.
+
+	If unsure say N.
+
 config HPPFS
 	tristate "HoneyPot ProcFS"
 	help
diff -Nur linux-2.6.0-test11-uml/arch/um/drivers/Makefile linux-2.6.0-test11-uml2/arch/um/drivers/Makefile
--- linux-2.6.0-test11-uml/arch/um/drivers/Makefile	Fri Dec 12 17:30:43 2003
+++ linux-2.6.0-test11-uml2/arch/um/drivers/Makefile	Tue Mar  2 21:12:59 2004
@@ -1,4 +1,4 @@
-# 
+#
 # Copyright (C) 2000, 2002, 2003 Jeff Dike (jdike@karaya.com)
 # Licensed under the GPL
 #
@@ -16,6 +16,7 @@
 net-objs := net_kern.o net_user.o
 mconsole-objs := mconsole_kern.o mconsole_user.o
 hostaudio-objs := hostaudio_kern.o hostaudio_user.o
+hostsocket-objs := hostsocket_user.o hostsocket_kern.o
 ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
@@ -30,8 +31,9 @@
 obj-$(CONFIG_UML_NET) += net.o 
 obj-$(CONFIG_MCONSOLE) += mconsole.o
 obj-$(CONFIG_MMAPPER) += mmapper_kern.o 
 obj-$(CONFIG_HOSTAUDIO) += hostaudio.o
+obj-$(CONFIG_HOSTSOCKET) += hostsocket.o
 obj-$(CONFIG_FD_CHAN) += fd.o 
 obj-$(CONFIG_NULL_CHAN) += null.o 
 obj-$(CONFIG_PORT_CHAN) += port.o
diff -Nur linux-2.6.0-test11-uml/arch/um/drivers/hostsocket.h linux-2.6.0-test11-uml2/arch/um/drivers/hostsocket.h
--- linux-2.6.0-test11-uml/arch/um/drivers/hostsocket.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.0-test11-uml2/arch/um/drivers/hostsocket.h	Wed Mar  3 23:20:01 2004
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) 2004 Patrick Kilian <petschge@web.de>
+ * Licensed under the GPL
+ */
+
+// Socket we are talking to at the host side
+#define HOSTSOCKET "/tmp/hostsocket"
+
+// Socket we are talking from at the host side
+#define SENDSOCKET "/tmp/sendsocket"
+
+// Socket we show inside the guest
+// #define GUESTSOCKET "/tmp/guestsocket"
+// #define GUESTSOCKET "\0guestsocket"
+#define GUESTSOCKET "@guestsocket"
+// #define GUESTSOCKET "guestsocket"
+
+#define H_MESSAGE "This is the uml saying hello"
+#define B_MESSAGE "This is the uml saying byebye"
+
+#define DEBUG_HS
+
+/* host side socket file operations */
+int init_socket_user(void);
+void exit_socket_user(void);
+
+/* package passing functions */
+
+/* package is a wrapper araound a unix socket data packet */
+typedef struct {
+    int len;
+	unsigned char data[4096];
+} package;
+
+// All have to be non-blocking
+// package must be some wrapper araound a unix socket data packet
+package read_from_host(void);
+void write_to_host(package p);
+package read_from_uml(void);
+void write_to_host(package p);
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ *
+ */
diff -Nur linux-2.6.0-test11-uml/arch/um/drivers/hostsocket_kern.c linux-2.6.0-test11-uml2/arch/um/drivers/hostsocket_kern.c
--- linux-2.6.0-test11-uml/arch/um/drivers/hostsocket_kern.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6.0-test11-uml2/arch/um/drivers/hostsocket_kern.c	Wed Mar  3 23:19:55 2004
@@ -0,0 +1,175 @@
+/*
+ * Copyright (C) 2004 Patrick Kilian <petschge@web.de>
+ * Licensed under the GPL
+ */
+
+#include "hostsocket.h"
+
+#include "linux/delay.h"
+#include "linux/init.h"
+#include "linux/module.h"
+#include "linux/kernel.h"
+#include "linux/sched.h"
+#include "linux/signal.h"
+#include "linux/types.h"
+#include "linux/uio.h"
+#include "linux/sched.h"
+#include "linux/net.h"
+#include "net/sock.h"
+#include "linux/un.h"
+#include "kern.h"
+
+int error;
+
+struct socket *guestsock;
+
+pid_t socketpid;
+int st_kill = 0;
+
+
+package read_from_uml(void) {
+    // Do not block
+    int ret = 0;
+    struct msghdr msg;
+    struct iovec iov;
+	mm_segment_t oldfs;
+	package out;
+
+    msg.msg_name     = NULL;    // Socket name
+    msg.msg_namelen  = 0;       // Length of name
+    msg.msg_iov  = &iov;        // Data blocks
+    msg.msg_iovlen   = 1;       // Number of blocks
+    msg.msg_control  = NULL;    // Per protocol magic
+    msg.msg_controllen = 0;     // Length of cmsg list
+    msg.msg_flags    = MSG_DONTWAIT;       // 0 vs MSG_DONTWAIT
+
+    msg.msg_iov->iov_base = &out.data;
+    msg.msg_iov->iov_len  = 4095;
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = sock_recvmsg(guestsock, &msg, 4095, MSG_DONTWAIT);
+	set_fs(oldfs);
+
+    if (ret > 0) {
+        out.len = ret;
+    } else {
+        out.len = 0;
+    }
+    return(out);
+}
+
+void write_to_uml(package p) {
+	int ret = 0;
+	printk(KERN_INFO "packet.length= %d\n", p.len);
+	//size_t size = SUN_LEN (&name);
+	//ret = sendto (guestsock, p.data, p.len, 0, (struct sockaddr *) &name, size);
+	//static int unix_dgram_sendmsg(struct kiocb *kiocb, struct socket *sock, struct msghdr *msg, int len);
+    if (ret < 0) {
+        printk(KERN_INFO "Can't sendto guestsocket socket\n");
+    }
+}
+
+// Create the socket in the uml
+static int setup_guestsocket(void) {
+	struct sockaddr_un sun;
+
+    error = sock_create(PF_UNIX, SOCK_DGRAM, 0, &guestsock);
+    if (error < 0) {
+		return(error);
+    }
+
+    sun.sun_family = AF_UNIX;
+    strncpy (sun.sun_path, GUESTSOCKET, sizeof (GUESTSOCKET));
+    strncpy (sun.sun_path, "\0", 1);
+    error = guestsock->ops->bind(guestsock, (struct sockaddr *)&sun, sizeof(sun));
+    if (error<0) {
+        printk(KERN_INFO "socket thread: can't bind guest socket, error=%d\n", error);
+        printk(KERN_INFO "ENOENT: %d\n", ENOENT);
+    }
+
+	return(error);
+
+}
+
+static int socketfunc(void *data) {
+	package p;	
+
+	// Set thread name
+	sprintf(current->comm, "socket thread");
+
+	/* Startup of the uml side */
+
+	// Create the socket in the uml
+	error = setup_guestsocket();
+	if (error < 0) {
+		printk(KERN_INFO "Socket thread: can't create guest socket, error=%d\n", error);
+	}
+
+	printk(KERN_INFO "Socket thread entering recv loop\n");
+	while (1) {
+	    if (st_kill != 0) {
+			break;
+		}
+
+		p = read_from_uml();
+		if (p.len < 0) {
+			printk(KERN_INFO "Socket thread recv failed, p.len=%d\n", p.len);
+		} else if (p.len > 0) {
+			printk(KERN_INFO "Socket thread got: p.len=%d\n", p.len);
+			write_to_host(p);
+		}
+
+		p = read_from_host();
+		if (p.len < 0) {
+            printk(KERN_INFO "Socket thread read_from_host failed, p.len=%d\n", p.len);
+		} else if (p.len > 0) {
+            printk(KERN_INFO "Socket thread read_from_host: p.len=%d\n", p.len);
+            write_to_uml(p);
+        }
+
+		printk(":");
+		current->state = TASK_UNINTERRUPTIBLE;
+		schedule_timeout(1*HZ);
+	}
+
+	return(0);
+}
+
+static int init_socket(void) {
+
+	printk(KERN_INFO "Registering Socket Relay...\n");
+	/* Startup of the host side */
+	init_socket_user();
+
+	/* Start the kernelthread */
+	socketpid = kernel_thread(socketfunc, NULL, 0);
+	if (socketpid < 0) {
+		printk(KERN_INFO "Can't start socket thread, socketpid=%d\n", socketpid);
+	}
+
+	printk(KERN_INFO "Finished Socket Relay\n");
+	return(0);
+}
+
+static void exit_socket(void) {
+	//XXX: Kill order
+	//kill_proc(socketpid, SIGKILL, 1);
+	exit_socket_user();
+	st_kill=1;
+}
+
+late_initcall(init_socket);
+uml_exitcall(exit_socket);
+
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
diff -Nur linux-2.6.0-test11-uml/arch/um/drivers/hostsocket_user.c linux-2.6.0-test11-uml2/arch/um/drivers/hostsocket_user.c
--- linux-2.6.0-test11-uml/arch/um/drivers/hostsocket_user.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6.0-test11-uml2/arch/um/drivers/hostsocket_user.c	Wed Mar  3 23:19:59 2004
@@ -0,0 +1,115 @@
+/*
+ * Copyright (C) 2004 Patrick Kilian <petschge@web.de>
+ * Licensed under the GPL
+ */
+#include "hostsocket.h"
+
+#include <errno.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+
+struct sockaddr_un name;
+size_t size;
+int nbytes;
+int sendsock;
+
+/* host side operations */
+package read_from_host(void) {
+	// Do not block
+	int ret = 0;
+	struct msghdr msg;
+	struct iovec iov;
+	package out;
+
+    msg.msg_name     = NULL;    // Socket name
+    msg.msg_namelen  = 0;       // Length of name
+    msg.msg_iov  = &iov;        // Data blocks
+    msg.msg_iovlen   = 1;       // Number of blocks
+    msg.msg_control  = NULL;    // Per protocol magic
+    msg.msg_controllen = 0;     // Length of cmsg list
+    msg.msg_flags    = MSG_DONTWAIT;       // 0 vs MSG_DONTWAIT
+
+    msg.msg_iov->iov_base = &out.data;
+    msg.msg_iov->iov_len  = 4095;
+
+	ret = recvmsg(sendsock, &msg, MSG_DONTWAIT);
+	if (ret > 0) {
+		out.len = ret;
+	} else {
+		out.len = 0;
+	}
+	return(out);
+}
+
+void write_to_host(package p) {
+	// Do not block
+    nbytes = sendto (sendsock, p.data, p.len, 0, (struct sockaddr *) &name, size);
+    if (nbytes < 0) {
+        perror("Can't sendto hello to host socket\n");
+    }
+}
+
+int init_socket_user(void) {
+	package hello;
+	printf("Registering Socket Relay on the Host Side...\n");
+	
+	/* Make the sendsocket. */
+	// Remove old sendsocket
+	unlink(SENDSOCKET);
+	// Create socket
+	sendsock = socket (PF_LOCAL, SOCK_DGRAM, 0);
+	if (sendsock < 0) {
+		perror("Can't create sending host socket\n");
+		exit (-1);
+	}
+	// Bind a name to the socket.
+	name.sun_family = AF_LOCAL;
+	strncpy (name.sun_path, SENDSOCKET, sizeof (name.sun_path));
+	size = SUN_LEN (&name);
+	if (bind (sendsock, (struct sockaddr *) &name, size) < 0) {
+		perror("Can't bind sending host socket\n");
+		exit (-1);
+	}
+
+	/* Initialize the server socket address. */
+	name.sun_family = AF_LOCAL;
+	strcpy (name.sun_path, HOSTSOCKET);
+	size = strlen (name.sun_path) + sizeof (name.sun_family);
+
+	/* Send a hello. */
+	hello.len = strlen (H_MESSAGE) + 1;
+	strcpy (hello.data, H_MESSAGE);
+	write_to_host(hello);
+
+	printf("Finished host side setup\n");
+	return(0);
+}
+
+void exit_socket_user(void) {
+	package bye;
+
+	/* Send a goodbye */
+    bye.len = strlen (B_MESSAGE) + 1;
+    strcpy (bye.data, B_MESSAGE);
+    write_to_host(bye);
+    
+	/* Remove sendsocket */
+	// XXX: Remove order
+	unlink(SENDSOCKET);
+	close(sendsock);
+}
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */

--- unix_sock_driver.patch

The listener didn't change.
Any comments to the first version of the code?

mfg,
Patrick "Petschge" Kilian

-- 
The Board views the endemic use of PowerPoint briefing slides instead of
technical papers as an illustration of the problematic methods of technical
communication at NASA.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
