Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPqxh-0005mv-QJ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 15:51:57 -0700
Received: from c61052.upc-c.chello.nl ([212.187.61.52] helo=linuxops.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPqxg-0000qD-Ns for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 15:51:56 -0700
Received: from m00 ([127.0.0.1]) by m00 with esmtp (Exim 3.36 #1 (Debian))
	id 1BPqxl-0000Px-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 18 May 2004 00:52:01 +0200
From: "Ferdinand O. Tempel" <ftempel@linuxops.net>
Content-Type: multipart/mixed; boundary="=-Ff/4NW4m6Ut/sew+B2Ax"
Message-Id: <1084834321.668.45.camel@m00>
Mime-Version: 1.0
Subject: [uml-devel] [patch] VLAN (i.e. IEEE802.1q) support for uml_switch
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
Date: Tue, 18 May 2004 00:52:01 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--=-Ff/4NW4m6Ut/sew+B2Ax
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

For some reason I totally forgot in the process, I thought I needed VLAN
support in uml_switch. I had fun all weekend working on this, and it
actually seems to be working, too. Which is amazing, as in general my C
code doesn't work all that great :-)

So, if you want to play with the kernel's 8021q module which implements
IEEE802.1q VLANs, here's a patch to uml_switch so VLANs stay seperate on
a switch level too.

About this patch:
This patch is against uml_router in uml_utilities_20040406.tar.bz2 and
it adds a -vlan parameter to uml_switch. If -vlan is not used, it should
drop back to default behaviour of switching all packets (did a quick
test, and it seems to do that). The switch itself is still not very
intelligent. In effect it's the connecting UML which decides which VLAN
it wants to be on, and the switch will happily forward packets to ports
which are listed as being on the same VLAN. For this the "port"
structure in port.c has been expanded to hold an extra VLAN ID field
(static int vid). Also, the packet struct has been replaced by a packet
union, which is capable of switching holding either a IEEE 802.1q packet
or a normal packet. The switching functionality itself has been modified
to check for a VLAN match between sender host and receiving port. If no
match can be made, it'll drop the packet silently, else it'll pass it
along to the proper port on which the destination host lives. Also the
TUNTAP interface can now be VLAN'ed to accomodate several separate
chunks of UML network. I tested some scenarios, and it seems to work
fairly well under my tests.

The use:
I have no idea. Maybe it's a useful feature for someone, maybe it's not.
For me it's been primarily playing around so far, though I'm starting to
develop an idea of making an UML based router which is capable of
routing between seperate VLANs with UMLs and from there to the host OS
using only one TUNTAP interface.

Oh, for those who want to play around with this; you'll need a tool to
configure VLANs available in your UML image. It's called `vconfig`, and
can be found, together with a short explanation/howto on:
http://www.candelatech.com/~greear/vlan.html

I'm not a star coder by any definition, so this might in fact be the
ugliest hack you've ever seen. Don't be afraid to let me know about it,
but please also include suggestions on how to make it better.

Enjoy.

-- 
Regards,

Ferdinand O. Tempel

Your friendly neighborhood linuxops.net administrator.

--=-Ff/4NW4m6Ut/sew+B2Ax
Content-Disposition: attachment; filename=uml_switch-vlan.patch
Content-Type: text/x-patch; name=uml_switch-vlan.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -uar uml_router/port.c uml_router.vlan/port.c
--- uml_router/port.c	2003-03-12 16:19:03.000000000 +0100
+++ uml_router.vlan/port.c	2004-05-17 23:42:51.000000000 +0200
@@ -7,16 +7,49 @@
 #include "switch.h"
 #include "hash.h"
 #include "port.h"
+#include <netinet/in.h>
 
-struct packet {
-  struct {
-    unsigned char dest[ETH_ALEN];
-    unsigned char src[ETH_ALEN];
-    unsigned char proto[2];
-  } header;
+/* 
+ * Modified by Ferdinand O. Tempel <ftempel@linuxops.net> to add VLAN support
+ * (802.1q) support to uml_switch.
+ * Modifications released under the same license as the original port.c,
+ * and that was what, GPL? Who knows, noone bothered to put a license or
+ * copyright notice on this file.
+ *
+ * Some stuff is hatched using 2.6.4 kernel code as reference. I appologize.
+ */
+
+#define DEBUG 1
+
+#define ALLOWVLANBROADCAST 0
+#define ALLOWVLANCROSSING 0
+#define VLAN_VID_MASK 0xfff
+#define VLAN_PROTO 0x8100
+
+struct ethhdr {
+	unsigned char h_dest[ETH_ALEN]; /* destination eth addr */
+	unsigned char h_source[ETH_ALEN]; /* source ether addr  */
+	unsigned char h_proto[2];    /* packet type ID field, 0x8100 for VLAN */
+};
+
+struct vlan_packet {
+	unsigned short h_vlan_TCI;                /* Encapsulates priority and VLAN ID */
+	unsigned short h_vlan_encapsulated_proto; /* packet type ID field (or len) */
   unsigned char data[1500];
 };
 
+struct eth_packet {
+  unsigned char data[1500];
+};
+
+struct packet {
+	struct ethhdr header;
+	union {
+		struct vlan_packet vpacket;
+		struct eth_packet epacket;
+	} pktdata;
+};
+
 struct port {
   struct port *next;
   struct port *prev;
@@ -24,6 +57,7 @@
   void *data;
   int data_len;
   unsigned char src[ETH_ALEN];
+	short vid;
   void (*sender)(int fd, void *packet, int len, void *data);
 };
 
@@ -31,6 +65,11 @@
 
 #define IS_BROADCAST(addr) ((addr[0] & 1) == 1)
 
+static short get_vid(unsigned short h_vlan_TCI) {
+	unsigned short vlan_TCI = ntohs(h_vlan_TCI);
+	return (vlan_TCI & VLAN_VID_MASK);
+}
+
 static void free_port(struct port *port)
 {
   if(port->prev) port->prev->next = port->next;
@@ -54,47 +93,48 @@
   free_port(port);
 }
 
-static void update_src(struct port *port, struct packet *p)
+static void update_src(struct port *port, struct packet *packet)
 {
   struct port *last;
+	
+  if(IS_BROADCAST(packet->header.h_source)) return;  
 
-  /* We don't like broadcast source addresses */
-  if(IS_BROADCAST(p->header.src)) return;  
-
-  last = find_in_hash(p->header.src);
+	if(packet->header.h_proto[0] == 0x81 && packet->header.h_proto[1]==0x00)
+		port->vid = get_vid(packet->pktdata.vpacket.h_vlan_TCI);
+	
+  last = find_in_hash(packet->header.h_source);
 
   if(port != last){
     /* old value differs from actual input port */
 
     printf(" Addr: %02x:%02x:%02x:%02x:%02x:%02x New port %d",
-	   p->header.src[0], p->header.src[1], p->header.src[2],
-	   p->header.src[3], p->header.src[4], p->header.src[5],
+	   packet->header.h_source[0], packet->header.h_source[1], packet->header.h_source[2],
+	   packet->header.h_source[3], packet->header.h_source[4], packet->header.h_source[5],
 	   port->control);
 
     if(last != NULL){
       printf(" old port %d", last->control);
-      delete_hash(p->header.src);
+      delete_hash(packet->header.h_source);
     }
     printf("\n");
-
-    memcpy(port->src, p->header.src, sizeof(port->src));
-    insert_into_hash(p->header.src, port);
+    
+		memcpy(port->src, packet->header.h_source, sizeof(port->src));
+    insert_into_hash(packet->header.h_source, port);
   }
-  update_entry_time(p->header.src);
+  update_entry_time(packet->header.h_source);
 }
 
-static void send_dst(struct port *port, struct packet *packet, int len, 
-		     int hub)
+static void send_dst(struct port *port, int len, int vlan, 
+		     int hub, struct packet *packet)
 {
   struct port *target, *p;
-
-  target = find_in_hash(packet->header.dest);
-  if((target == NULL) || IS_BROADCAST(packet->header.dest) || hub){
-    if((target == NULL) && !IS_BROADCAST(packet->header.dest)){
+  target = find_in_hash(packet->header.h_dest);
+  if((target == NULL) || IS_BROADCAST(packet->header.h_dest) || hub){
+    if((target == NULL) && !IS_BROADCAST(packet->header.h_dest)){
       printf("unknown Addr: %02x:%02x:%02x:%02x:%02x:%02x from port ",
-	     packet->header.src[0], packet->header.src[1], 
-	     packet->header.src[2], packet->header.src[3], 
-	     packet->header.src[4], packet->header.src[5]);
+	     packet->header.h_source[0], packet->header.h_source[1], 
+	     packet->header.h_source[2], packet->header.h_source[3], 
+	     packet->header.h_source[4], packet->header.h_source[5]);
       if(port == NULL) printf("UNKNOWN\n");
       else printf("%d\n", port->control);
     } 
@@ -103,18 +143,37 @@
     for(p = head; p != NULL; p = p->next){
       /* don't send it back the port it came in */
       if(p == port) continue;
-
-      (*p->sender)(p->control, packet, len, p->data);
+			/* check for protocol number, if it's 0x8100, we need to do some magic[2] */
+			if(vlan && packet->header.h_proto[0]==0x81 && packet->header.h_proto[1]==0x00) {
+#if DEBUG
+				printf("Traffic from %02x:%02x:%02x:%02x:%02x:%02x, VLAN %i to %02x:%02x:%02x:%02x:%02x:%02x, VLAN %i.\n",
+					packet->header.h_source[0], packet->header.h_source[1],
+					packet->header.h_source[2], packet->header.h_source[3],
+					packet->header.h_source[4], packet->header.h_source[5], get_vid(packet->pktdata.vpacket.h_vlan_TCI),
+					packet->header.h_dest[0], packet->header.h_dest[1],
+					packet->header.h_dest[2], packet->header.h_dest[3],
+					packet->header.h_dest[4], packet->header.h_dest[5], p->vid);
+#endif
+				if(get_vid(packet->pktdata.vpacket.h_vlan_TCI)==p->vid || ALLOWVLANBROADCAST)
+	  	   	(*p->sender)(p->control, packet, len, p->data);
+			}
+			else if (!vlan) (*p->sender)(p->control, packet, len, p->data);
     }
   }
-  else (*target->sender)(target->control, packet, len, target->data);
+  else {
+		if(vlan && packet->header.h_proto[0]==0x81 && packet->header.h_proto[1]==0x00) {
+			if(get_vid(packet->pktdata.vpacket.h_vlan_TCI)==target->vid || ALLOWVLANCROSSING)
+				(*target->sender)(target->control, packet, len, target->data);
+		}
+		else if (!vlan) (*target->sender)(target->control, packet, len, target->data);
+	}
 }
 
-static void handle_data(int fd, int hub, struct packet *packet, int len, 
+static void handle_data(int fd, int vlan, int hub, int len, 
 			void *data, int (*matcher)(int port_fd, int data_fd, 
 						   void *port_data,
 						   int port_data_len, 
-						   void *data))
+						   void *data), void *packet)
 {
   struct port *p;
 
@@ -126,7 +185,7 @@
   if(p != NULL) update_src(p, packet);
   else printf("Unknown connection for packet, shouldn't happen.\n");
 
-  send_dst(p, packet, len, hub);  
+  send_dst(p, len, vlan, hub, packet);  
 }
 
 static int match_tap(int port_fd, int data_fd, void *port_data, 
@@ -135,9 +194,9 @@
   return(port_fd == data_fd);
 }
 
-void handle_tap_data(int fd, int hub)
+void handle_tap_data(int fd, int vlan, int hub)
 {
-  struct packet packet;
+  struct vlan_packet packet;
   int len;
 
   len = read(fd, &packet, sizeof(packet));
@@ -145,7 +204,7 @@
     if(errno != EAGAIN) perror("Reading tap data");
     return;
   }
-  handle_data(fd, hub, &packet, len, NULL, match_tap);
+  handle_data(fd, vlan, hub, len, NULL, match_tap, &packet);
 }
 
 int setup_port(int fd, void (*sender)(int fd, void *packet, int len, 
@@ -198,12 +257,11 @@
   return(!memcmp(&port->sock, &mine->sock, sizeof(mine->sock)));
 }
 
-void handle_sock_data(int fd, int hub)
+void handle_sock_data(int fd, int vlan, int hub)
 {
-  struct packet packet;
+  struct vlan_packet packet;
   struct sock_data data;
   int len, socklen = sizeof(data.sock);
-
   len = recvfrom(fd, &packet, sizeof(packet), 0, 
 		 (struct sockaddr *) &data.sock, &socklen);
   if(len < 0){
@@ -211,8 +269,7 @@
     return;
   }
   data.fd = fd;
-
-  handle_data(fd, hub, &packet, len, &data, match_sock);
+  handle_data(fd, vlan, hub, len, &data, match_sock, &packet);
 }
 
 int setup_sock_port(int fd, struct sockaddr_un *name, int data_fd)
diff -uar uml_router/port.h uml_router.vlan/port.h
--- uml_router/port.h	2002-04-10 15:07:02.000000000 +0200
+++ uml_router.vlan/port.h	2004-05-16 18:14:05.000000000 +0200
@@ -14,7 +14,7 @@
 extern int setup_port(int fd, void (*sender)(int fd, void *packet, int len, 
 					     void *data), void *data, 
 		      int data_len);
-extern void handle_tap_data(int fd, int hub);
-extern void handle_sock_data(int fd, int hub);
+extern void handle_tap_data(int fd, int vlan, int hub);
+extern void handle_sock_data(int fd, int vlan, int hub);
 
 #endif
diff -uar uml_router/uml_switch.c uml_router.vlan/uml_switch.c
--- uml_router/uml_switch.c	2003-08-15 21:03:58.000000000 +0200
+++ uml_router.vlan/uml_switch.c	2004-05-16 18:29:04.000000000 +0200
@@ -25,6 +25,7 @@
 #endif
 
 static int hub = 0;
+static int vlan = 0;
 static int compat_v0 = 0;
 
 enum request_type { REQ_NEW_CONTROL };
@@ -391,8 +392,8 @@
   tap_str = "[ -tap tap-device ]";
 #endif
 
-  fprintf(stderr, "Usage : %s [ -unix control-socket ] [ -hub ] %s\n"
-	  "or : %s -compat-v0 [ -unix control-socket data-socket ] "
+  fprintf(stderr, "Usage : %s [ -unix control-socket ] [ -vlan] [ -hub ] %s\n"
+	  "or : %s -compat-v0 [ -unix control-socket data-socket ] [ -vlan ]"
 	  "[ -hub ] %s\n", prog, tap_str, prog, tap_str);
 
   exit(1);
@@ -442,6 +443,13 @@
       argc--;
       argv++;
     }
+    else if(!strcmp(argv[0], "-vlan")){
+      printf("%s will have VLAN support (note: this will imply switch mode, and hence disable -hub)\n", prog);
+      hub = 0;
+			vlan = 1;
+      argc--;
+      argv++;
+    }
     else if(!strcmp(argv[0], "-compat-v0")){
       printf("Control protocol 0 compatibility\n");
       compat_v0 = 1;
@@ -551,9 +559,9 @@
 	}
 	accept_connection(connect_fd);
       }
-      else if(fds[i].fd == data_fd) handle_sock_data(data_fd, hub);
+      else if(fds[i].fd == data_fd) handle_sock_data(data_fd, vlan, hub);
 #ifdef TUNTAP
-      else if(fds[i].fd == tap_fd) handle_tap_data(tap_fd, hub);
+      else if(fds[i].fd == tap_fd) handle_tap_data(tap_fd, vlan, hub);
 #endif
       else {
 	new = handle_port(fds[i].fd);

--=-Ff/4NW4m6Ut/sew+B2Ax--



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
