Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVzMT-0007hY-Uo for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jun 2004 14:02:53 -0700
Received: from firewall.seawaynetworks.com ([216.209.86.50]
	helo=apollo.seawaynetworks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVzMP-0006uv-ND for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jun 2004 14:02:49 -0700
Received: from camelot-054 (camelot-054 [10.10.1.54])
	by apollo.seawaynetworks.com (8.12.8/8.12.8) with ESMTP id
	i53L2hcP001177 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 3 Jun 2004 17:02:43 -0400 (EDT)
Message-ID: <27625.1086296547@camelot-054>
From: Michael Richardson <Michael.Richardson@seawaynetworks.com>
Subject: [uml-devel] switch->netjig patch 2
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
Date: Thu, 03 Jun 2004 17:02:27 -0400
To: user-mode-linux-devel@lists.sourceforge.net


Jeff, this patch (also http://www.sandelman.ca/tmp/jig2.patch )
moves globals and helper functions from uml_switch.c to port.c.


diff -x CVS -x '*~' -u -N -r uml_tools.jig1/uml_router/nethub.h uml_tools.jig2/uml_router/nethub.h
--- uml_tools.jig1/uml_router/nethub.h	Thu Jun  3 14:59:36 2004
+++ uml_tools.jig2/uml_router/nethub.h	Thu Jun  3 15:15:05 2004
@@ -94,6 +94,17 @@
 
 #define xmalloc(X) xmalloc1((X), __FILE__, __LINE__)
 
+extern char *ctl_socket;
+extern char *data_socket;
+extern char *prog;
+extern struct pollfd *fds;
+extern int maxfds;
+extern int nfds;
+
+extern struct sockaddr_un data_sun;
+extern void cleanup(void);
+
+
 #define _NETHUB_H_
 
 #endif /* _NETHUB_H_ */
diff -x CVS -x '*~' -u -N -r uml_tools.jig1/uml_router/port.c uml_tools.jig2/uml_router/port.c
--- uml_tools.jig1/uml_router/port.c	Thu Jun  3 14:59:36 2004
+++ uml_tools.jig2/uml_router/port.c	Thu Jun  3 15:15:05 2004
@@ -1,22 +1,21 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <fcntl.h>
 #include <errno.h>
 #include <sys/socket.h>
+#include <sys/time.h>
 #include <sys/un.h>
+#include <sys/queue.h>
+#include <netinet/in.h>
+
+#include <poll.h>
+
+#include "nethub.h"
 #include "switch.h"
 #include "hash.h"
 #include "port.h"
 
-struct packet {
-  struct {
-    unsigned char dest[ETH_ALEN];
-    unsigned char src[ETH_ALEN];
-    unsigned char proto[2];
-  } header;
-  unsigned char data[1500];
-};
-
 struct port {
   struct port *next;
   struct port *prev;
@@ -253,3 +252,281 @@
   return(1);
 }
 
+struct pollfd *fds = NULL;
+
+int maxfds = 0;
+int nfds = 0;
+
+void add_fd(int fd)
+{
+  struct pollfd *p;
+
+  if(nfds == maxfds){
+    maxfds = maxfds ? 2 * maxfds : 4;
+    if((fds = realloc(fds, maxfds * sizeof(struct pollfd))) == NULL){
+      perror("realloc");
+      cleanup();
+      exit(1);
+    }
+  }
+  p = &fds[nfds++];
+  p->fd = fd;
+  p->events = POLLIN;
+}
+
+static void remove_fd(int fd)
+{
+  int i;
+
+  for(i = 0; i < nfds; i++){
+    if(fds[i].fd == fd) break;
+  }
+  if(i == nfds){
+    fprintf(stderr, "remove_fd : Couldn't find descriptor %d\n", fd);
+  }
+  memmove(&fds[i], &fds[i + 1], (maxfds - i - 1) * sizeof(struct pollfd));
+  nfds--;
+}
+
+void close_descriptor(int fd)
+{
+  remove_fd(fd);
+  close(fd);
+  close_port(fd);
+}
+
+static void new_port_v0(int fd, struct request_v0 *req, int data_fd)
+{
+  switch(req->type){
+  case REQ_NEW_CONTROL:
+    setup_sock_port(fd, &req->u.new_control.name, data_fd);
+    break;
+  default:
+    printf("Bad request type : %d\n", req->type);
+    close_descriptor(fd);
+  }
+}
+
+static void new_port_v1_v3(int fd, enum request_type type, 
+			   struct sockaddr_un *sock, int data_fd)
+{
+  int n, err;
+
+  switch(type){
+  case REQ_NEW_CONTROL:
+    err = setup_sock_port(fd, sock, data_fd);
+    if(err) return;
+    n = write(fd, &data_sun, sizeof(data_sun));
+    if(n != sizeof(data_sun)){
+      perror("Sending data socket name");
+      close_descriptor(fd);
+    }
+    break;
+  default:
+    printf("Bad request type : %d\n", type);
+    close_descriptor(fd);
+  }
+}
+
+static void new_port_v2(int fd, struct request_v2 *req, int data_fd)
+{
+  fprintf(stderr, "Version 2 is not supported\n");
+  close_descriptor(fd);
+}
+
+void new_port(int fd, int data_fd)
+{
+  union request req;
+  int len;
+
+  len = read(fd, &req, sizeof(req));
+  if(len < 0){
+    if(errno != EAGAIN){
+      perror("Reading request");
+      close_descriptor(fd);
+    }
+    return;
+  }
+  else if(len == 0){
+    printf("EOF from new port\n");
+    close_descriptor(fd);
+    return;
+  }
+  if(req.v1.magic == SWITCH_MAGIC){
+    if(req.v2.version == 2) new_port_v2(fd, &req.v2, data_fd);
+    if(req.v3.version == 3) 
+      new_port_v1_v3(fd, req.v3.type, &req.v3.sock, data_fd);
+    else if(req.v2.version > 2) 
+      fprintf(stderr, "Request for a version %d port, which this "
+	      "uml_switch doesn't support\n", req.v2.version);
+    else new_port_v1_v3(fd, req.v1.type, &req.v1.u.new_control.name, data_fd);
+  }
+  else new_port_v0(fd, &req.v0, data_fd);
+}
+
+void accept_connection(int fd)
+{
+  struct sockaddr addr;
+  int len, new;
+
+  len = sizeof(addr);
+  new = accept(fd, &addr, &len);
+  if(new < 0){
+    perror("accept");
+    return;
+  }
+  if(fcntl(new, F_SETFL, O_NONBLOCK) < 0){
+    perror("fcntl - setting O_NONBLOCK");
+    close(new);
+    return;
+  }
+  add_fd(new);
+}
+
+int still_used(struct sockaddr_un *sun)
+{
+  int test_fd, ret = 1;
+
+  if((test_fd = socket(PF_UNIX, SOCK_STREAM, 0)) < 0){
+    perror("socket");
+    exit(1);
+  }
+  if(connect(test_fd, (struct sockaddr *) sun, sizeof(*sun)) < 0){
+    if(errno == ECONNREFUSED){
+      if(unlink(sun->sun_path) < 0){
+	fprintf(stderr, "Failed to removed unused socket '%s': ", 
+		sun->sun_path);
+	perror("");
+      }
+      ret = 0;
+    }
+    else perror("connect");
+  }
+  close(test_fd);
+  return(ret);
+}
+
+int bind_socket(int fd, const char *name, struct sockaddr_un *sock_out)
+{
+  struct sockaddr_un sun;
+
+  sun.sun_family = AF_UNIX;
+  strncpy(sun.sun_path, name, sizeof(sun.sun_path));
+  
+  if(bind(fd, (struct sockaddr *) &sun, sizeof(sun)) < 0){
+    if((errno == EADDRINUSE) && still_used(&sun)) return(EADDRINUSE);
+    else if(bind(fd, (struct sockaddr *) &sun, sizeof(sun)) < 0){
+      perror("bind");
+      return(EPERM);
+    }
+  }
+  if(sock_out != NULL) *sock_out = sun;
+  return(0);
+}
+
+void bind_sockets_v0(int ctl_fd, const char *ctl_name, 
+		     int data_fd, const char *data_name)
+{
+  int ctl_err, ctl_present = 0, ctl_used = 0;
+  int data_err, data_present = 0, data_used = 0;
+  int try_remove_ctl, try_remove_data;
+
+  ctl_err = bind_socket(ctl_fd, ctl_name, NULL);
+  if(ctl_err != 0) ctl_present = 1;
+  if(ctl_err == EADDRINUSE) ctl_used = 1;
+
+  data_err = bind_socket(data_fd, data_name, &data_sun);
+  if(data_err != 0) data_present = 1;
+  if(data_err == EADDRINUSE) data_used = 1;
+
+  if(!ctl_err && !data_err){
+    return;
+  }
+
+  try_remove_ctl = ctl_present;
+  try_remove_data = data_present;
+  if(ctl_present && ctl_used){
+    fprintf(stderr, "The control socket '%s' has another server "
+	    "attached to it\n", ctl_name);
+    try_remove_ctl = 0;
+  }
+  else if(ctl_present && !ctl_used)
+    fprintf(stderr, "The control socket '%s' exists, isn't used, but couldn't "
+	    "be removed\n", ctl_name);
+  if(data_present && data_used){
+    fprintf(stderr, "The data socket '%s' has another server "
+	    "attached to it\n", data_name);
+    try_remove_data = 0;
+  }
+  else if(data_present && !data_used)
+    fprintf(stderr, "The data socket '%s' exists, isn't used, but couldn't "
+	    "be removed\n", data_name);
+  if(try_remove_ctl || try_remove_data){
+    fprintf(stderr, "You can either\n");
+    if(try_remove_ctl && !try_remove_data) 
+      fprintf(stderr, "\tremove '%s'\n", ctl_socket);
+    else if(!try_remove_ctl && try_remove_data) 
+      fprintf(stderr, "\tremove '%s'\n", data_socket);
+    else fprintf(stderr, "\tremove '%s' and '%s'\n", ctl_socket, data_socket);
+    fprintf(stderr, "\tor rerun with different, unused filenames for "
+	    "sockets:\n");
+    fprintf(stderr, "\t\t%s -unix <control> <data>\n", prog);
+    fprintf(stderr, "\t\tand run the UMLs with "
+	    "'eth0=daemon,,unix,<control>,<data>\n");
+    exit(1);
+  }
+  else {
+    fprintf(stderr, "You should rerun with different, unused filenames for "
+	    "sockets:\n");
+    fprintf(stderr, "\t%s -unix <control> <data>\n", prog);
+    fprintf(stderr, "\tand run the UMLs with "
+	    "'eth0=daemon,,unix,<control>,<data>'\n");
+    exit(1);
+  }
+}
+
+void bind_data_socket(int fd, struct sockaddr_un *sun)
+{
+  struct {
+    char zero;
+    int pid;
+    int usecs;
+  } name;
+  struct timeval tv;
+
+  name.zero = 0;
+  name.pid = getpid();
+  gettimeofday(&tv, NULL);
+  name.usecs = tv.tv_usec;
+  sun->sun_family = AF_UNIX;
+  memcpy(sun->sun_path, &name, sizeof(name));
+  if(bind(fd, (struct sockaddr *) sun, sizeof(*sun)) < 0){
+    perror("Binding to data socket");
+    exit(1);
+  }
+}
+
+void bind_sockets(int ctl_fd, const char *ctl_name, int data_fd)
+{
+  int err, used;
+
+  err = bind_socket(ctl_fd, ctl_name, NULL);
+  if(err == 0){
+    bind_data_socket(data_fd, &data_sun);
+    return;
+  }
+  else if(err == EADDRINUSE) used = 1;
+  
+  if(used){
+    fprintf(stderr, "The control socket '%s' has another server "
+	    "attached to it\n", ctl_name);
+    fprintf(stderr, "You can either\n");
+    fprintf(stderr, "\tremove '%s'\n", ctl_name);
+    fprintf(stderr, "\tor rerun with a different, unused filename for a "
+	    "socket\n");
+  }
+  else
+    fprintf(stderr, "The control socket '%s' exists, isn't used, but couldn't "
+	    "be removed\n", ctl_name);
+  exit(1);
+}
diff -x CVS -x '*~' -u -N -r uml_tools.jig1/uml_router/port.h uml_tools.jig2/uml_router/port.h
--- uml_tools.jig1/uml_router/port.h	Thu Jun  3 14:59:36 2004
+++ uml_tools.jig2/uml_router/port.h	Thu Jun  3 15:15:05 2004
@@ -16,5 +16,13 @@
 		      int data_len);
 extern void handle_tap_data(int fd, int hub);
 extern void handle_sock_data(int fd, int hub);
+extern void new_port(int fd, int data_fd);
+extern void bind_sockets(int ctl_fd, const char *ctl_name, int data_fd);
+void bind_sockets_v0(int ctl_fd, const char *ctl_name, 
+		     int data_fd, const char *data_name);
+void add_fd(int fd);
+void accept_connection(int fd);
+void close_descriptor(int fd);
+
 
 #endif
Binary files uml_tools.jig1/uml_router/port.o and uml_tools.jig2/uml_router/port.o differ
Binary files uml_tools.jig1/uml_router/uml_switch and uml_tools.jig2/uml_router/uml_switch differ
diff -x CVS -x '*~' -u -N -r uml_tools.jig1/uml_router/uml_switch.c uml_tools.jig2/uml_router/uml_switch.c
--- uml_tools.jig1/uml_router/uml_switch.c	Thu Jun  3 14:59:36 2004
+++ uml_tools.jig2/uml_router/uml_switch.c	Thu Jun  3 15:15:05 2004
@@ -28,13 +28,14 @@
 
 static int hub = 0;
 static int compat_v0 = 0;
+char *prog;
 
-static char *ctl_socket = "/tmp/uml.ctl";
+char *ctl_socket = "/tmp/uml.ctl";
 
-static char *data_socket = NULL;
-static struct sockaddr_un data_sun;
+char *data_socket = NULL;
+struct sockaddr_un data_sun;
 
-static void cleanup(void)
+void cleanup(void)
 {
   if(unlink(ctl_socket) < 0){
     printf("Couldn't remove control socket '%s' : ", ctl_socket);
@@ -46,41 +47,6 @@
   }
 }
 
-static struct pollfd *fds = NULL;
-static int maxfds = 0;
-static int nfds = 0;
-
-static void add_fd(int fd)
-{
-  struct pollfd *p;
-
-  if(nfds == maxfds){
-    maxfds = maxfds ? 2 * maxfds : 4;
-    if((fds = realloc(fds, maxfds * sizeof(struct pollfd))) == NULL){
-      perror("realloc");
-      cleanup();
-      exit(1);
-    }
-  }
-  p = &fds[nfds++];
-  p->fd = fd;
-  p->events = POLLIN;
-}
-
-static void remove_fd(int fd)
-{
-  int i;
-
-  for(i = 0; i < nfds; i++){
-    if(fds[i].fd == fd) break;
-  }
-  if(i == nfds){
-    fprintf(stderr, "remove_fd : Couldn't find descriptor %d\n", fd);
-  }
-  memmove(&fds[i], &fds[i + 1], (maxfds - i - 1) * sizeof(struct pollfd));
-  nfds--;
-}
-
 static void sig_handler(int sig)
 {
   printf("Caught signal %d, cleaning up and exiting\n", sig);
@@ -89,251 +55,6 @@
   kill(getpid(), sig);
 }
 
-static void close_descriptor(int fd)
-{
-  remove_fd(fd);
-  close(fd);
-  close_port(fd);
-}
-
-static void new_port_v0(int fd, struct request_v0 *req, int data_fd)
-{
-  switch(req->type){
-  case REQ_NEW_CONTROL:
-    setup_sock_port(fd, &req->u.new_control.name, data_fd);
-    break;
-  default:
-    printf("Bad request type : %d\n", req->type);
-    close_descriptor(fd);
-  }
-}
-
-static void new_port_v1_v3(int fd, enum request_type type, 
-			   struct sockaddr_un *sock, int data_fd)
-{
-  int n, err;
-
-  switch(type){
-  case REQ_NEW_CONTROL:
-    err = setup_sock_port(fd, sock, data_fd);
-    if(err) return;
-    n = write(fd, &data_sun, sizeof(data_sun));
-    if(n != sizeof(data_sun)){
-      perror("Sending data socket name");
-      close_descriptor(fd);
-    }
-    break;
-  default:
-    printf("Bad request type : %d\n", type);
-    close_descriptor(fd);
-  }
-}
-
-static void new_port_v2(int fd, struct request_v2 *req, int data_fd)
-{
-  fprintf(stderr, "Version 2 is not supported\n");
-  close_descriptor(fd);
-}
-
-static void new_port(int fd, int data_fd)
-{
-  union request req;
-  int len;
-
-  len = read(fd, &req, sizeof(req));
-  if(len < 0){
-    if(errno != EAGAIN){
-      perror("Reading request");
-      close_descriptor(fd);
-    }
-    return;
-  }
-  else if(len == 0){
-    printf("EOF from new port\n");
-    close_descriptor(fd);
-    return;
-  }
-  if(req.v1.magic == SWITCH_MAGIC){
-    if(req.v2.version == 2) new_port_v2(fd, &req.v2, data_fd);
-    if(req.v3.version == 3) 
-      new_port_v1_v3(fd, req.v3.type, &req.v3.sock, data_fd);
-    else if(req.v2.version > 2) 
-      fprintf(stderr, "Request for a version %d port, which this "
-	      "uml_switch doesn't support\n", req.v2.version);
-    else new_port_v1_v3(fd, req.v1.type, &req.v1.u.new_control.name, data_fd);
-  }
-  else new_port_v0(fd, &req.v0, data_fd);
-}
-
-void accept_connection(int fd)
-{
-  struct sockaddr addr;
-  int len, new;
-
-  len = sizeof(addr);
-  new = accept(fd, &addr, &len);
-  if(new < 0){
-    perror("accept");
-    return;
-  }
-  if(fcntl(new, F_SETFL, O_NONBLOCK) < 0){
-    perror("fcntl - setting O_NONBLOCK");
-    close(new);
-    return;
-  }
-  add_fd(new);
-}
-
-int still_used(struct sockaddr_un *sun)
-{
-  int test_fd, ret = 1;
-
-  if((test_fd = socket(PF_UNIX, SOCK_STREAM, 0)) < 0){
-    perror("socket");
-    exit(1);
-  }
-  if(connect(test_fd, (struct sockaddr *) sun, sizeof(*sun)) < 0){
-    if(errno == ECONNREFUSED){
-      if(unlink(sun->sun_path) < 0){
-	fprintf(stderr, "Failed to removed unused socket '%s': ", 
-		sun->sun_path);
-	perror("");
-      }
-      ret = 0;
-    }
-    else perror("connect");
-  }
-  close(test_fd);
-  return(ret);
-}
-
-int bind_socket(int fd, const char *name, struct sockaddr_un *sock_out)
-{
-  struct sockaddr_un sun;
-
-  sun.sun_family = AF_UNIX;
-  strncpy(sun.sun_path, name, sizeof(sun.sun_path));
-  
-  if(bind(fd, (struct sockaddr *) &sun, sizeof(sun)) < 0){
-    if((errno == EADDRINUSE) && still_used(&sun)) return(EADDRINUSE);
-    else if(bind(fd, (struct sockaddr *) &sun, sizeof(sun)) < 0){
-      perror("bind");
-      return(EPERM);
-    }
-  }
-  if(sock_out != NULL) *sock_out = sun;
-  return(0);
-}
-
-static char *prog;
-
-void bind_sockets_v0(int ctl_fd, const char *ctl_name, 
-		     int data_fd, const char *data_name)
-{
-  int ctl_err, ctl_present = 0, ctl_used = 0;
-  int data_err, data_present = 0, data_used = 0;
-  int try_remove_ctl, try_remove_data;
-
-  ctl_err = bind_socket(ctl_fd, ctl_name, NULL);
-  if(ctl_err != 0) ctl_present = 1;
-  if(ctl_err == EADDRINUSE) ctl_used = 1;
-
-  data_err = bind_socket(data_fd, data_name, &data_sun);
-  if(data_err != 0) data_present = 1;
-  if(data_err == EADDRINUSE) data_used = 1;
-
-  if(!ctl_err && !data_err){
-    return;
-  }
-
-  try_remove_ctl = ctl_present;
-  try_remove_data = data_present;
-  if(ctl_present && ctl_used){
-    fprintf(stderr, "The control socket '%s' has another server "
-	    "attached to it\n", ctl_name);
-    try_remove_ctl = 0;
-  }
-  else if(ctl_present && !ctl_used)
-    fprintf(stderr, "The control socket '%s' exists, isn't used, but couldn't "
-	    "be removed\n", ctl_name);
-  if(data_present && data_used){
-    fprintf(stderr, "The data socket '%s' has another server "
-	    "attached to it\n", data_name);
-    try_remove_data = 0;
-  }
-  else if(data_present && !data_used)
-    fprintf(stderr, "The data socket '%s' exists, isn't used, but couldn't "
-	    "be removed\n", data_name);
-  if(try_remove_ctl || try_remove_data){
-    fprintf(stderr, "You can either\n");
-    if(try_remove_ctl && !try_remove_data) 
-      fprintf(stderr, "\tremove '%s'\n", ctl_socket);
-    else if(!try_remove_ctl && try_remove_data) 
-      fprintf(stderr, "\tremove '%s'\n", data_socket);
-    else fprintf(stderr, "\tremove '%s' and '%s'\n", ctl_socket, data_socket);
-    fprintf(stderr, "\tor rerun with different, unused filenames for "
-	    "sockets:\n");
-    fprintf(stderr, "\t\t%s -unix <control> <data>\n", prog);
-    fprintf(stderr, "\t\tand run the UMLs with "
-	    "'eth0=daemon,,unix,<control>,<data>\n");
-    exit(1);
-  }
-  else {
-    fprintf(stderr, "You should rerun with different, unused filenames for "
-	    "sockets:\n");
-    fprintf(stderr, "\t%s -unix <control> <data>\n", prog);
-    fprintf(stderr, "\tand run the UMLs with "
-	    "'eth0=daemon,,unix,<control>,<data>'\n");
-    exit(1);
-  }
-}
-
-void bind_data_socket(int fd, struct sockaddr_un *sun)
-{
-  struct {
-    char zero;
-    int pid;
-    int usecs;
-  } name;
-  struct timeval tv;
-
-  name.zero = 0;
-  name.pid = getpid();
-  gettimeofday(&tv, NULL);
-  name.usecs = tv.tv_usec;
-  sun->sun_family = AF_UNIX;
-  memcpy(sun->sun_path, &name, sizeof(name));
-  if(bind(fd, (struct sockaddr *) sun, sizeof(*sun)) < 0){
-    perror("Binding to data socket");
-    exit(1);
-  }
-}
-
-void bind_sockets(int ctl_fd, const char *ctl_name, int data_fd)
-{
-  int err, used;
-
-  err = bind_socket(ctl_fd, ctl_name, NULL);
-  if(err == 0){
-    bind_data_socket(data_fd, &data_sun);
-    return;
-  }
-  else if(err == EADDRINUSE) used = 1;
-  
-  if(used){
-    fprintf(stderr, "The control socket '%s' has another server "
-	    "attached to it\n", ctl_name);
-    fprintf(stderr, "You can either\n");
-    fprintf(stderr, "\tremove '%s'\n", ctl_name);
-    fprintf(stderr, "\tor rerun with a different, unused filename for a "
-	    "socket\n");
-  }
-  else
-    fprintf(stderr, "The control socket '%s' exists, isn't used, but couldn't "
-	    "be removed\n", ctl_name);
-  exit(1);
-}
-
 static void Usage(void)
 {
   char *tap_str = "";
Binary files uml_tools.jig1/uml_router/uml_switch.o and uml_tools.jig2/uml_router/uml_switch.o differ


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
