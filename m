Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVzO4-00085R-4x for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jun 2004 14:04:32 -0700
Received: from firewall.seawaynetworks.com ([216.209.86.50]
	helo=apollo.seawaynetworks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVzO3-0007FA-3f for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jun 2004 14:04:31 -0700
Received: from camelot-054 (camelot-054 [10.10.1.54])
	by apollo.seawaynetworks.com (8.12.8/8.12.8) with ESMTP id
	i53L4OcP001188 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 3 Jun 2004 17:04:24 -0400 (EDT)
Message-ID: <27635.1086296649@camelot-054>
From: Michael Richardson <Michael.Richardson@seawaynetworks.com>
Subject: [uml-devel] switch->netjig patch 3
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
Date: Thu, 03 Jun 2004 17:04:09 -0400
To: user-mode-linux-devel@lists.sourceforge.net


Jeff, this patch (also http://www.sandelman.ca/tmp/jig3.patch) adds the
file nethub.c, and moves additional code from uml_switch.c/port.c to
nethub.c. (Sorry, this moves code from port.c that jig2 moves to there.
My mistake, I copied too much)

Again, no new functionality.

diff -x CVS -x '*~' -u -N -r uml_tools.jig2/uml_router/Makefile uml_tools.jig3/uml_router/Makefile
--- uml_tools.jig2/uml_router/Makefile	Thu Jun  3 15:15:05 2004
+++ uml_tools.jig3/uml_router/Makefile	Thu Jun  3 16:25:20 2004
@@ -1,8 +1,8 @@
 TUNTAP = $(shell [ -e /usr/include/linux/if_tun.h ] && echo -DTUNTAP)
 
-OBJS = hash.o port.o uml_switch.o 
+OBJS = hash.o port.o uml_switch.o nethub.o
 BIN = uml_switch
-CFLAGS = -g -Wall $(TUNTAP)
+CFLAGS = -g -Wall $(TUNTAP) 
 
 BIN_DIR ?= /usr/bin
 
diff -x CVS -x '*~' -u -N -r uml_tools.jig2/uml_router/nethub.c uml_tools.jig3/uml_router/nethub.c
--- uml_tools.jig2/uml_router/nethub.c	Wed Dec 31 19:00:00 1969
+++ uml_tools.jig3/uml_router/nethub.c	Thu Jun  3 15:24:04 2004
@@ -0,0 +1,221 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <sys/un.h>
+#include <sys/queue.h>
+#include <netinet/in.h>
+
+#include <poll.h>
+
+#include "nethub.h"
+#include "switch.h"
+#include "hash.h"
+#include "port.h"
+
+struct pollfd *fds = NULL;
+
+int maxfds = 0;
+int nfds = 0;
+
+void cleanup(void)
+{
+  if(unlink(ctl_socket) < 0){
+    printf("Couldn't remove control socket '%s' : ", ctl_socket);
+    perror("");
+  }
+  if((data_socket != NULL) && (unlink(data_socket) < 0)){
+    printf("Couldn't remove data socket '%s' : ", data_socket);
+    perror("");
+  }
+}
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
+
diff -x CVS -x '*~' -u -N -r uml_tools.jig2/uml_router/nethub.h uml_tools.jig3/uml_router/nethub.h
--- uml_tools.jig2/uml_router/nethub.h	Thu Jun  3 15:15:05 2004
+++ uml_tools.jig3/uml_router/nethub.h	Thu Jun  3 15:24:04 2004
@@ -103,6 +103,12 @@
 
 extern struct sockaddr_un data_sun;
 extern void cleanup(void);
+extern void bind_sockets(int ctl_fd, const char *ctl_name, int data_fd);
+void bind_sockets_v0(int ctl_fd, const char *ctl_name, 
+		     int data_fd, const char *data_name);
+void add_fd(int fd);
+void accept_connection(int fd);
+void close_descriptor(int fd);
 
 
 #define _NETHUB_H_
Binary files uml_tools.jig2/uml_router/nethub.o and uml_tools.jig3/uml_router/nethub.o differ
diff -x CVS -x '*~' -u -N -r uml_tools.jig2/uml_router/port.c uml_tools.jig3/uml_router/port.c
--- uml_tools.jig2/uml_router/port.c	Thu Jun  3 15:15:05 2004
+++ uml_tools.jig3/uml_router/port.c	Thu Jun  3 15:24:04 2004
@@ -252,49 +252,6 @@
   return(1);
 }
 
-struct pollfd *fds = NULL;
-
-int maxfds = 0;
-int nfds = 0;
-
-void add_fd(int fd)
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
-void close_descriptor(int fd)
-{
-  remove_fd(fd);
-  close(fd);
-  close_port(fd);
-}
-
 static void new_port_v0(int fd, struct request_v0 *req, int data_fd)
 {
   switch(req->type){
@@ -383,150 +340,3 @@
   add_fd(new);
 }
 
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
diff -x CVS -x '*~' -u -N -r uml_tools.jig2/uml_router/port.h uml_tools.jig3/uml_router/port.h
--- uml_tools.jig2/uml_router/port.h	Thu Jun  3 15:15:05 2004
+++ uml_tools.jig3/uml_router/port.h	Thu Jun  3 15:24:04 2004
@@ -17,12 +17,6 @@
 extern void handle_tap_data(int fd, int hub);
 extern void handle_sock_data(int fd, int hub);
 extern void new_port(int fd, int data_fd);
-extern void bind_sockets(int ctl_fd, const char *ctl_name, int data_fd);
-void bind_sockets_v0(int ctl_fd, const char *ctl_name, 
-		     int data_fd, const char *data_name);
-void add_fd(int fd);
-void accept_connection(int fd);
-void close_descriptor(int fd);
 
 
 #endif
Binary files uml_tools.jig2/uml_router/port.o and uml_tools.jig3/uml_router/port.o differ
Binary files uml_tools.jig2/uml_router/uml_switch and uml_tools.jig3/uml_router/uml_switch differ
diff -x CVS -x '*~' -u -N -r uml_tools.jig2/uml_router/uml_switch.c uml_tools.jig3/uml_router/uml_switch.c
--- uml_tools.jig2/uml_router/uml_switch.c	Thu Jun  3 15:15:05 2004
+++ uml_tools.jig3/uml_router/uml_switch.c	Thu Jun  3 15:24:04 2004
@@ -35,18 +35,6 @@
 char *data_socket = NULL;
 struct sockaddr_un data_sun;
 
-void cleanup(void)
-{
-  if(unlink(ctl_socket) < 0){
-    printf("Couldn't remove control socket '%s' : ", ctl_socket);
-    perror("");
-  }
-  if((data_socket != NULL) && (unlink(data_socket) < 0)){
-    printf("Couldn't remove data socket '%s' : ", data_socket);
-    perror("");
-  }
-}
-
 static void sig_handler(int sig)
 {
   printf("Caught signal %d, cleaning up and exiting\n", sig);
Binary files uml_tools.jig2/uml_router/uml_switch.o and uml_tools.jig3/uml_router/uml_switch.o differ


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
