Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyHu6-00059S-R6 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 13:58:18 -0800
Received: from mout2.freenet.de ([194.97.50.155])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AyHPF-0007Xk-SO
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 13:26:26 -0800
Content-Type: text/plain; charset="iso-8859-1"
From: Patrick Kilian <petschge@gmx.de>
Reply-To: petschge@web.de
References: <200402290158.54770.jdizzl@xs4all.nl>
	<20040301201438.DE4903BCB7@home.petschge.de>
	<200403021909.47013.blaisorblade_spam@yahoo.it>
In-Reply-To: <200403021909.47013.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Message-Id: <200403022240.25616.petschge@gmx.de>
Subject: [uml-devel] Re: [uml-user] UNIX socket networking
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
Date: Tue, 2 Mar 2004 22:40:25 +0100
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

Hi all,

Am Dienstag, 2. M=E4rz 2004 19:09 schrieb BlaisorBlade:
>> Well bind is returning -2 which seams to be -ENOENT. Does somebody
>> know why this happens?
> Hmm, I'm no expert with sockets; possibly the folder in which you
> create the socket does not exist. However, possibly code it like a
> normal program which just opens the socket and calls bind() and try
> it.
No the folder exists and is on a rw filesystem. This problem was the reason=
 why I abandond the the driver the first time.

> However, posting the code would be *very* helpful ... do not be shy!
Well you asked for it. Here we go:

--- unix_sock_driver.patch

diff -Nur linux-2.6.0-test11-uml/.config linux-2.6.0-test11-uml2/.config
--- linux-2.6.0-test11-uml/.config	Fri Dec 12 17:52:41 2003
+++ linux-2.6.0-test11-uml2/.config	Wed Dec 31 19:21:29 2003
@@ -15,6 +15,7 @@
 CONFIG_BINFMT_ELF=3Dy
 CONFIG_BINFMT_MISC=3Dy
 CONFIG_HOSTFS=3Dy
+CONFIG_HOSTSOCKET=3Dy
 # CONFIG_HPPFS is not set
 CONFIG_MCONSOLE=3Dy
 CONFIG_MAGIC_SYSRQ=3Dy
Binary files linux-2.6.0-test11-uml/.tmp_vmlinux1 and linux-2.6.0-test11-um=
l2/.tmp_vmlinux1 differ
Binary files linux-2.6.0-test11-uml/.tmp_vmlinux2 and linux-2.6.0-test11-um=
l2/.tmp_vmlinux2 differ
diff -Nur linux-2.6.0-test11-uml/arch/um/Kconfig linux-2.6.0-test11-uml2/ar=
ch/um/Kconfig
--- linux-2.6.0-test11-uml/arch/um/Kconfig	Fri Dec 12 17:38:50 2003
+++ linux-2.6.0-test11-uml2/arch/um/Kconfig	Wed Dec 31 19:20:39 2003
@@ -99,6 +99,15 @@
         If you'd like to be able to work with files stored on the host,=20
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
diff -Nur linux-2.6.0-test11-uml/arch/um/drivers/Makefile linux-2.6.0-test1=
1-uml2/arch/um/drivers/Makefile
--- linux-2.6.0-test11-uml/arch/um/drivers/Makefile	Fri Dec 12 17:30:43 2003
+++ linux-2.6.0-test11-uml2/arch/um/drivers/Makefile	Tue Mar  2 21:12:59 20=
04
@@ -1,4 +1,4 @@
-#
+#
 # Copyright (C) 2000, 2002, 2003 Jeff Dike (jdike@karaya.com)
 # Licensed under the GPL
 #
@@ -16,6 +16,7 @@
 net-objs :=3D net_kern.o net_user.o
 mconsole-objs :=3D mconsole_kern.o mconsole_user.o
 hostaudio-objs :=3D hostaudio_kern.o hostaudio_user.o
+hostsocket-objs :=3D hostsocket_user.o hostsocket_kern.o
 ubd-objs :=3D ubd_kern.o ubd_user.o
 port-objs :=3D port_kern.o port_user.o
 harddog-objs :=3D harddog_kern.o harddog_user.o
@@ -30,8 +31,9 @@
 obj-$(CONFIG_UML_NET) +=3D net.o
 obj-$(CONFIG_MCONSOLE) +=3D mconsole.o
 obj-$(CONFIG_MMAPPER) +=3D mmapper_kern.o
 obj-$(CONFIG_HOSTAUDIO) +=3D hostaudio.o
+obj-$(CONFIG_HOSTSOCKET) +=3D hostsocket.o
 obj-$(CONFIG_FD_CHAN) +=3D fd.o=20
 obj-$(CONFIG_NULL_CHAN) +=3D null.o
 obj-$(CONFIG_PORT_CHAN) +=3D port.o
diff -Nur linux-2.6.0-test11-uml/arch/um/drivers/hostsocket.h linux-2.6.0-t=
est11-uml2/arch/um/drivers/hostsocket.h
--- linux-2.6.0-test11-uml/arch/um/drivers/hostsocket.h	Thu Jan  1 01:00:00=
 1970
+++ linux-2.6.0-test11-uml2/arch/um/drivers/hostsocket.h	Tue Mar  2 22:22:1=
9 2004
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
+ * -----------------------------------------------------------------------=
----
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ *
+ */
diff -Nur linux-2.6.0-test11-uml/arch/um/drivers/hostsocket_kern.c linux-2.=
6.0-test11-uml2/arch/um/drivers/hostsocket_kern.c
--- linux-2.6.0-test11-uml/arch/um/drivers/hostsocket_kern.c	Thu Jan  1 01:=
00:00 1970
+++ linux-2.6.0-test11-uml2/arch/um/drivers/hostsocket_kern.c	Tue Mar  2 22=
:22:23 2004
@@ -0,0 +1,164 @@
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
+int st_kill =3D 0;
+
+
+package read_from_uml(void) {
+	package out;
+	out.len =3D 0;
+	return(out);
+	/*
+	mm_segment_t oldfs;
+	struct msghdr msg;
+	struct iovec iov;
+	static char Buffer[4096];
+
+	msg.msg_name     =3D NULL;	// Socket name
+	msg.msg_namelen  =3D 0;		// Length of name
+	msg.msg_iov	 =3D &iov;		// Data blocks
+	msg.msg_iovlen   =3D 1;		// Number of blocks
+	msg.msg_control  =3D NULL;	// Per protocol magic
+	msg.msg_controllen =3D 0;		// Length of cmsg list
+	msg.msg_flags    =3D 0;		// 0 vs MSG_DONTWAIT
+
+	msg.msg_iov->iov_base =3D &Buffer[0];
+	msg.msg_iov->iov_len  =3D (__kernel_size_t)1024;
+
+	oldfs =3D get_fs();
+	set_fs(KERNEL_DS);
+	len =3D sock_recvmsg(guestsock, &msg, 4096, 0);
+	// len =3D sock_recvmsg(guestsock, &msg, 4096, MSG_DONTWAIT);
+	set_fs(oldfs);
+	*/
+}
+
+void write_to_uml(package p) {
+	printk(KERN_INFO "packet.length=3D %d\n", p.len);
+}
+
+// Create the socket in the uml
+static int setup_guestsocket(void) {
+	struct sockaddr_un sun;
+
+    error =3D sock_create(PF_UNIX, SOCK_DGRAM, 0, &guestsock);
+    if (error < 0) {
+		return(error);
+    }
+
+    sun.sun_family =3D AF_UNIX;
+    strncpy (sun.sun_path, GUESTSOCKET, sizeof (GUESTSOCKET));
+    strncpy (sun.sun_path, "\0", 1);
+    error =3D guestsock->ops->bind(guestsock, (struct sockaddr *)&sun, siz=
eof(sun));
+    if (error<0) {
+        printk(KERN_INFO "socket thread: can't bind guest socket, error=3D=
%d\n", error);
+        printk(KERN_INFO "ENOENT: %d\n", ENOENT);
+    }
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
+	error =3D setup_guestsocket();
+	if (error < 0) {
+		printk(KERN_INFO "Socket thread: can't create guest socket, error=3D%d\n=
", error);
+	}
+
+	printk(KERN_INFO "Socket thread entering recv loop\n");
+	while (1) {
+	    if (st_kill !=3D 0) {
+			break;
+		}
+
+		p =3D read_from_uml();
+		if (p.len < 0) {
+			printk(KERN_INFO "Socket thread recv failed, p.len=3D%d\n", p.len);
+		} else {
+			printk(KERN_INFO "Socket thread got: p.len=3D%d\n", p.len);
+			write_to_host(p);
+		}
+
+		p =3D read_from_host();
+		if (p.len < 0) {
+            printk(KERN_INFO "Socket thread read_from_host failed, p.len=
=3D%d\n", p.len);
+        } else {
+            printk(KERN_INFO "Socket thread read_from_host: p.len=3D%d\n",=
 p.len);
+            write_to_uml(p);
+        }
+
+		printk(":");
+		current->state =3D TASK_UNINTERRUPTIBLE;
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
+	socketpid =3D kernel_thread(socketfunc, NULL, 0);
+	if (socketpid < 0) {
+		printk(KERN_INFO "Can't start socket thread, socketpid=3D%d\n", socketpi=
d);
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
+	st_kill=3D1;
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
+ * -----------------------------------------------------------------------=
----
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
diff -Nur linux-2.6.0-test11-uml/arch/um/drivers/hostsocket_user.c linux-2.=
6.0-test11-uml2/arch/um/drivers/hostsocket_user.c
--- linux-2.6.0-test11-uml/arch/um/drivers/hostsocket_user.c	Thu Jan  1 01:=
00:00 1970
+++ linux-2.6.0-test11-uml2/arch/um/drivers/hostsocket_user.c	Tue Mar  2 22=
:22:21 2004
@@ -0,0 +1,98 @@
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
+	package out;
+	out.len=3D0;
+	return(out);
+}
+EXPORT_SYMBOL(read_from_host);
+
+void write_to_host(package p) {
+	// Do not block
+	// printf("p.len=3D%d, p=3D%s\n", p.len, p.data);
+    nbytes =3D sendto (sendsock, p.data, p.len, 0, (struct sockaddr *) &na=
me, size);
+    if (nbytes < 0) {
+        perror("Can't sendto hello to host socket\n");
+    }
+}
+EXPORT_SYMBOL(write_to_host);
+
+int init_socket_user(void) {
+	package hello;
+	printf("Registering Socket Relay on the Host Side...\n");
+=09
+	/* Make the sendsocket. */
+	// Remove old sendsocket
+	unlink(SENDSOCKET);
+	// Create socket
+	sendsock =3D socket (PF_LOCAL, SOCK_DGRAM, 0);
+	if (sendsock < 0) {
+		perror("Can't create sending host socket\n");
+		exit (-1);
+	}
+	// Bind a name to the socket.
+	name.sun_family =3D AF_LOCAL;
+	strncpy (name.sun_path, SENDSOCKET, sizeof (name.sun_path));
+	size =3D SUN_LEN (&name);
+	if (bind (sendsock, (struct sockaddr *) &name, size) < 0) {
+		perror("Can't bind sending host socket\n");
+		exit (-1);
+	}
+
+	/* Initialize the server socket address. */
+	name.sun_family =3D AF_LOCAL;
+	strcpy (name.sun_path, HOSTSOCKET);
+	size =3D strlen (name.sun_path) + sizeof (name.sun_family);
+
+	/* Send a hello. */
+	hello.len =3D strlen (H_MESSAGE) + 1;
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
+    bye.len =3D strlen (B_MESSAGE) + 1;
+    strcpy (bye.data, B_MESSAGE);
+    write_to_host(bye);
+   =20
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
+ * -----------------------------------------------------------------------=
----
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
diff -Nur linux-2.6.0-test11-uml/include/config/hostsocket.h linux-2.6.0-te=
st11-uml2/include/config/hostsocket.h
--- linux-2.6.0-test11-uml/include/config/hostsocket.h	Thu Jan  1 01:00:00 =
1970
+++ linux-2.6.0-test11-uml2/include/config/hostsocket.h	Wed Dec 31 19:22:37=
 2003
@@ -0,0 +1 @@
+#define CONFIG_HOSTSOCKET 1
diff -Nur linux-2.6.0-test11-uml/include/linux/autoconf.h linux-2.6.0-test1=
1-uml2/include/linux/autoconf.h
--- linux-2.6.0-test11-uml/include/linux/autoconf.h	Fri Dec 12 17:52:41 2003
+++ linux-2.6.0-test11-uml2/include/linux/autoconf.h	Wed Dec 31 19:21:29 20=
03
@@ -16,6 +16,7 @@
 #define CONFIG_BINFMT_ELF 1
 #define CONFIG_BINFMT_MISC 1
 #define CONFIG_HOSTFS 1
+#define CONFIG_HOSTSOCKET 1
 #undef CONFIG_HPPFS
 #define CONFIG_MCONSOLE 1
 #define CONFIG_MAGIC_SYSRQ 1
diff -Nur linux-2.6.0-test11-uml/net/unix/af_unix.c linux-2.6.0-test11-uml2=
/net/unix/af_unix.c
--- linux-2.6.0-test11-uml/net/unix/af_unix.c	Mon Nov 24 02:32:13 2003
+++ linux-2.6.0-test11-uml2/net/unix/af_unix.c	Mon Mar  1 20:28:05 2004
@@ -686,7 +686,9 @@
 		 * Get the parent directory, calculate the hash for last
 		 * component.
 		 */
+		printk("sunaddr->sun_path: %s\n", sunaddr->sun_path);
 		err =3D path_lookup(sunaddr->sun_path, LOOKUP_PARENT, &nd);
+		printk("err: %d\n", err);
 		if (err)
 			goto out_mknod_parent;
 		/*

-- unix_sock_driver.patch

It also need's a listener on the host-side on /tmp/hostsocket. Here is some=
 sample source code.

--- sserver.c
#include <errno.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>

#define SERVER  "/tmp/hostsocket"
#define MAXMSG  512


int make_named_socket (const char *filename) {
    struct sockaddr_un name;
    int sock;
    size_t size;

    /* Create the socket. */
    sock =3D socket (PF_LOCAL, SOCK_DGRAM, 0);
    if (sock < 0) {
        perror ("socket");
        exit (EXIT_FAILURE);
    }

    /* Bind a name to the socket. */
    name.sun_family =3D AF_LOCAL;
    strncpy (name.sun_path, filename, sizeof (name.sun_path));
    size =3D SUN_LEN (&name);

    if (bind (sock, (struct sockaddr *) &name, size) < 0) {
        perror ("bind");
        exit (EXIT_FAILURE);
    }

    return sock;
}

int main (void) {
    int sock;
    char message[MAXMSG];
    struct sockaddr_un name;
    size_t size;
    int nbytes;

    /* Remove the filename first, it's ok if the call fails */
    unlink (SERVER);

    /* Make the socket, then loop endlessly. */
    sock =3D make_named_socket (SERVER);
    while (1) {
        /* Wait for a datagram. */
        size =3D sizeof (name);
        nbytes =3D recvfrom (sock, message, MAXMSG, 0, (struct sockaddr *) =
& name, &size);
        if (nbytes < 0) {
            perror ("recfrom (server)");
            exit (EXIT_FAILURE);
        }

        /* Give a diagnostic message. */
        fprintf (stderr, "Server: got message: %s\n", message);
    }
}
--- sserver.c

Most of the above code should probably be edited with rm, but you
wanted to have my results so far. Now go and find a brown paper bag.


mfg,
Patrick "Petschge" Kilian

--=20
Spam ist weniger ein technisches als ein soziales Problem. Die einzigen
technischen Mittel, die soziale Probleme halbwegs brauchbar loesen,
sind schwere Waffen. Und das auch nur bei wirklich konsequenter
Anwendung.	-- Alexander Schreiber in dasr



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
