Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mortehu@ping.uio.no>) id 1PO4wi-00051f-9E
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Dec 2010 08:55:20 +0000
Received: from ping.uio.no ([193.157.115.196])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PO4wg-0005N6-OX
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Dec 2010 08:55:20 +0000
Received: from [2001:700:100:570::200] (helo=knuth.ping.uio.no ident=postfix)
	by ping.uio.no with esmtp (Exim 4.69 #1 (Debian)) id 1PO4wW-0005aP-Jk
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 02 Dec 2010 09:55:11 +0100
Date: Thu, 2 Dec 2010 09:55:06 +0100
From: Morten Hustveit <mortehu@ping.uio.no>
Message-ID: <20101202085506.GA1946@ping.uio.no>
References: <20101125173649.GA20609@ping.uio.no>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101125173649.GA20609@ping.uio.no>
Subject: [uml-devel] [PATCH v2] uml_switch: configurable network delay
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Add the "-delay" option to configure network delay in milliseconds

When using UML to test networking code, it would be helpful if the
switch daemon could provide configurable delay, in order to simulate
ordinary network delay.  This patch provides that feature by storing
scheduled packets in a linked list, and using the poll() timeout
parameter to pop items from the list at the appropriate time.

The size of the backlog is unbounded, but I think this is acceptable for
a testing/debugging feature.
--- 
Changes for v2:
  - The previous version was incorrectly submitted, and didn't even
    compile.  Apologies to anyone who tried to use it.

diff -ur tools-20070815/uml_switch/port.c tools-20070815.mortehu/uml_switch/port.c
--- tools-20070815/uml_switch/port.c	2006-02-27 22:02:45.000000000 +0100
+++ tools-20070815.mortehu/uml_switch/port.c	2010-12-01 18:14:03.033429453 +0100
@@ -24,15 +24,57 @@
   void *data;
   int data_len;
   unsigned char src[ETH_ALEN];
-  void (*sender)(int fd, void *packet, int len, void *data);
+  sender_t sender;
 };
 
 static struct port *head = NULL;
 
+struct queued_packet {
+  struct queued_packet *next;
+
+  struct timeval delivery_time;
+
+  sender_t sender;
+  void *data;
+
+  int fd;
+  int len;
+  struct sockaddr_un sock;
+
+  char packet[1];
+};
+
+static struct queued_packet *first_packet = NULL;
+static struct queued_packet *last_packet = NULL;
+
+extern int simulated_delay;
+
 #define IS_BROADCAST(addr) ((addr[0] & 1) == 1)
 
 static void free_port(struct port *port)
 {
+  struct queued_packet *qp, *prev = 0, *next;
+
+  /* Remove queued packets belonging to `port' */
+  qp = first_packet;
+
+  while (qp) {
+    if (qp->fd == port->control) {
+      next = qp->next;
+      if (prev)
+	prev->next = next;
+      else
+	first_packet = next;
+      free (qp);
+      qp = next;
+    } else {
+      prev = qp;
+      qp = qp->next;
+    }
+  }
+
+  last_packet = prev;
+
   if(port->prev) port->prev->next = port->next;
   else head = port->next;
   if(port->next) port->next->prev = port->prev;
@@ -83,6 +125,76 @@
   update_entry_time(p->header.src);
 }
 
+static void send_dst_packet(sender_t sender, int fd, void *packet, int len, void *data)
+{
+  struct queued_packet *qp;
+  if (!simulated_delay) {
+    sender(fd, packet, len, data);
+  } else {
+    qp = malloc(sizeof(*qp) - sizeof(qp->packet) + len);
+
+    if(qp == NULL) {
+      perror("malloc");
+      return;
+    }
+
+    qp->next = 0;
+
+    gettimeofday(&qp->delivery_time, 0);
+
+    qp->delivery_time.tv_usec += simulated_delay * 1000;
+
+    if (qp->delivery_time.tv_usec > 1000000) {
+      qp->delivery_time.tv_sec += qp->delivery_time.tv_usec / 1000000;
+      qp->delivery_time.tv_usec %= 1000000;
+    }
+
+    qp->sender = sender;
+    qp->data = data;
+
+    qp->fd = fd;
+    qp->len = len;
+    memcpy(qp->packet, packet, len);
+
+    if (!first_packet)
+      first_packet = qp;
+    else
+      last_packet->next = qp;
+
+    last_packet = qp;
+  }
+}
+
+void process_queued_packets()
+{
+  struct queued_packet *qp;
+  struct timeval now;
+  int err;
+
+  if (!first_packet)
+    return;
+
+  gettimeofday(&now, 0);
+
+  while (first_packet)
+    {
+      if (first_packet->delivery_time.tv_sec > now.tv_sec
+	  || (first_packet->delivery_time.tv_sec == now.tv_sec
+	      && first_packet->delivery_time.tv_usec > now.tv_usec))
+	break;
+
+      qp = first_packet;
+
+      if (qp == last_packet)
+	last_packet = 0;
+      first_packet = qp->next;
+
+      (*qp->sender)(qp->fd, qp->packet, qp->len, qp->data);
+
+      free(qp);
+    }
+}
+
 static void send_dst(struct port *port, struct packet *packet, int len, 
 		     int hub)
 {
@@ -104,10 +216,11 @@
       /* don't send it back the port it came in */
       if(p == port) continue;
 
-      (*p->sender)(p->control, packet, len, p->data);
+      send_dst_packet(p->sender, p->control, packet, len, p->data);  
     }
   }
-  else (*target->sender)(target->control, packet, len, target->data);
+  else
+    send_dst_packet(target->sender, target->control, packet, len, target->data);  
 }
 
 static void handle_data(int fd, int hub, struct packet *packet, int len, 
@@ -148,8 +261,7 @@
   handle_data(fd, hub, &packet, len, NULL, match_tap);
 }
 
-int setup_port(int fd, void (*sender)(int fd, void *packet, int len, 
-				      void *data), void *data, int data_len)
+int setup_port(int fd, sender_t sender, void *data, int data_len)
 {
   struct port *port;
 
@@ -188,6 +300,25 @@
   }
 }
 
+int next_queued_packet()
+{
+  struct timeval now;
+  int result = -1;
+
+  if (first_packet)
+    {
+      gettimeofday(&now, 0);
+
+      result = (first_packet->delivery_time.tv_sec - now.tv_sec) * 1000
+	+ (first_packet->delivery_time.tv_usec - now.tv_usec) / 1000;
+
+      if (result < 0)
+	result = 0;
+    }
+
+  return result;
+}
+
 static int match_sock(int port_fd, int data_fd, void *port_data, 
 		      int port_data_len, void *data)
 {
diff -ur tools-20070815/uml_switch/port.h tools-20070815.mortehu/uml_switch/port.h
--- tools-20070815/uml_switch/port.h	2002-04-10 15:07:02.000000000 +0200
+++ tools-20070815.mortehu/uml_switch/port.h	2010-12-01 17:59:04.817923444 +0100
@@ -8,13 +8,15 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 
+typedef void (*sender_t)(int fd, void *packet, int len, void *data);
+
 extern int handle_port(int fd);
 extern void close_port(int fd);
 extern int setup_sock_port(int fd, struct sockaddr_un *name, int data_fd);
-extern int setup_port(int fd, void (*sender)(int fd, void *packet, int len, 
-					     void *data), void *data, 
-		      int data_len);
+extern int setup_port(int fd, sender_t sender, void *data, int data_len);
 extern void handle_tap_data(int fd, int hub);
 extern void handle_sock_data(int fd, int hub);
+extern int next_queued_packet();
+extern void process_queued_packets();
 
 #endif
diff -ur tools-20070815/uml_switch/uml_switch.c tools-20070815.mortehu/uml_switch/uml_switch.c
--- tools-20070815/uml_switch/uml_switch.c	2006-02-27 22:02:36.000000000 +0100
+++ tools-20070815.mortehu/uml_switch/uml_switch.c	2010-11-25 18:15:51.545961139 +0100
@@ -26,6 +26,7 @@
 
 static int hub = 0;
 static int compat_v0 = 0;
+int simulated_delay = 0;
 
 enum request_type { REQ_NEW_CONTROL };
 
@@ -392,9 +393,10 @@
   tap_str = "[ -tap tap-device ]";
 #endif
 
-  fprintf(stderr, "Usage : %s [ -unix control-socket ] [ -hub ] %s\n"
+  fprintf(stderr, "Usage : %s [ -unix control-socket ] [ -hub ] "
+	  "[ -delay ms ] %s\n"
 	  "or : %s -compat-v0 [ -unix control-socket data-socket ] "
-	  "[ -hub ] %s\n", prog, tap_str, prog, tap_str);
+	  "[ -hub ] [ -delay ms ] %s\n", prog, tap_str, prog, tap_str);
 
   exit(1);
 }
@@ -455,6 +457,13 @@
       argc--;
       argv++;
     }
+    else if(!strcmp(argv[0], "-delay")){
+      if(argc < 2) 
+	Usage();
+      simulated_delay = atoi(argv[1]);
+      argv += 2;
+      argc -= 2;
+    }
     else Usage();
   }
 
@@ -521,7 +530,7 @@
   while(1){
     char buf[128];
 
-    n = poll(fds, nfds, -1);
+    n = poll(fds, nfds, next_queued_packet());
     if(n < 0){
       if(errno == EINTR) continue;
       perror("poll");
@@ -562,6 +571,8 @@
 	else close_descriptor(fds[i].fd);
       }
     }
+
+    process_queued_packets();
   }
  out:
   cleanup();

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

