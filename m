Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVzeI-0003Et-EN for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jun 2004 14:21:18 -0700
Received: from firewall.seawaynetworks.com ([216.209.86.50]
	helo=apollo.seawaynetworks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVzeG-0002TJ-VT for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jun 2004 14:21:17 -0700
Received: from camelot-054 (camelot-054 [10.10.1.54])
	by apollo.seawaynetworks.com (8.12.8/8.12.8) with ESMTP id
	i53LLAcP002140 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 3 Jun 2004 17:21:10 -0400 (EDT)
Message-ID: <27783.1086297654@camelot-054>
From: Michael Richardson <Michael.Richardson@seawaynetworks.com>
Subject: [uml-devel] switch->netjig patch 4
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
Date: Thu, 03 Jun 2004 17:20:54 -0400
To: user-mode-linux-devel@lists.sourceforge.net


Jeff, this patch (also http://www.sandelman.ca/tmp/jig4.patch ) adds
contextualization to the switch functions.  I hope that this patch is
small enough to chew.

for hash.[ch], this is relatively simple, as it just adds struct nethub
* to all functions, and gets rid of the global "h[]" array.

for nethub.c's cleanup_nh(), it cleans up some additional items that
may get created, such as per-switch directories.

add_fd() gets context argument, and changes its allocation technique to
grow the array, doubling in size each time.

A new function, init_nethub() gathers all initialization stuff that was
done by uml_switch's main() into one place.

In port.c, the linked list is replaced with one from queue.h, which has
nice macros to cope.

nethub.h grows the new nethub and netjig_state structures.

for uml_switch, we don't need multiple netjig_state's, but we will
later.

in port.c, some printf()'s are changed to fprintf(stderr,). Also some of
the code is just unwrapped to be more readable. 
new_port becomes handle_new_port(), and gets made more readable.
A new function handle_port() takes over logic from uml_switch.

This is probably the biggest patch that there is.


diff -x CVS -x '*~' -u -N -r uml_tools.jig3/uml_router/hash.c uml_tools.jig4/uml_router/hash.c
--- uml_tools.jig3/uml_router/hash.c	Thu Jun  3 15:24:04 2004
+++ uml_tools.jig4/uml_router/hash.c	Thu Jun  3 17:09:33 2004
@@ -12,12 +12,11 @@
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/signal.h>
+
+#include "nethub.h"
 #include "switch.h"
 #include "hash.h"
 
-#define HASH_SIZE 128
-#define HASH_MOD 11
-
 struct hash_entry {
   struct hash_entry *next;
   struct hash_entry *prev;
@@ -26,37 +25,38 @@
   unsigned char dst[ETH_ALEN];
 };
 
-static struct hash_entry *h[HASH_SIZE];
-
 static int calc_hash(char *src)
 {
   return ((*(u_int32_t *) &src[0] % HASH_MOD) ^ src[4] ^ src[5] ) % HASH_SIZE ;
 }
 
-static struct hash_entry *find_entry(char *dst)
+static struct hash_entry *find_entry(struct nethub *nh,
+				     char *dst)
 {
   struct hash_entry *e;
   int k = calc_hash(dst);
 
-  for(e = h[k]; e; e = e->next){
+  for(e = nh->h[k]; e; e = e->next){
     if(!memcmp(&e->dst, dst, ETH_ALEN)) return(e);
   }
   return(NULL);  
 }
 
-void *find_in_hash(char *dst)
+void *find_in_hash(struct nethub *nh,
+		   char *dst)
 {
-  struct hash_entry *e = find_entry(dst);
+  struct hash_entry *e = find_entry(nh, dst);
   if(e == NULL) return(NULL);
   return(e->port);
 }
 
-void insert_into_hash(char *src, void *port)
+void insert_into_hash(struct nethub *nh,
+		      char *src, void *port)
 {
   struct hash_entry *new;
   int k = calc_hash(src);
 
-  new = find_in_hash(src);
+  new = find_in_hash(nh, src);
   if(new != NULL) return;
 
   new = malloc(sizeof(*new));
@@ -66,50 +66,57 @@
   }
 
   memcpy(&new->dst, src, ETH_ALEN );
-  if(h[k] != NULL) h[k]->prev = new;
-  new->next = h[k];
+  if(nh->h[k] != NULL) nh->h[k]->prev = new;
+  new->next = nh->h[k];
   new->prev = NULL;
   new->port = port;
   new->last_seen = 0;
-  h[k] = new;
+  nh->h[k] = new;
 }
 
-void update_entry_time(char *src)
+void update_entry_time(struct nethub *nh,
+		       char *src)
 {
   struct hash_entry *e;
 
-  e = find_entry(src);
+  e = find_entry(nh, src);
   if(e == NULL) return;
   e->last_seen = time(NULL);
 }
 
-static void delete_hash_entry(struct hash_entry *old)
+static void delete_hash_entry(struct nethub *nh,
+			      struct hash_entry *old)
 {
   int k = calc_hash(old->dst);
 
   if(old->prev != NULL) old->prev->next = old->next;
   if(old->next != NULL) old->next->prev = old->prev;
-  if(h[k] == old) h[k] = old->next;
+  if(nh->h[k] == old) nh->h[k] = old->next;
   free(old);
 }
 
-void delete_hash(char *dst)
+void delete_hash(struct nethub *nh,
+		 char *dst)
 {
-  struct hash_entry *old = find_entry(dst);
+  struct hash_entry *old = find_entry(nh, dst);
 
   if(old == NULL) return;
-  delete_hash_entry(old);
+  delete_hash_entry(nh, old);
 }
 
-static void for_all_hash(void (*f)(struct hash_entry *, void *), void *arg)
+static void for_all_hash(struct nethub *nh,
+			 void (*f)(struct nethub *nh,
+				   struct hash_entry *,
+				   void *),
+			 void *arg)
 {
   int i;
   struct hash_entry *e, *next;
 
   for(i = 0; i < HASH_SIZE; i++){
-    for(e = h[i]; e; e = next){
+    for(e = nh->h[i]; e; e = next){
       next = e->next;
-      (*f)(e, arg);
+      (*f)(nh, e, arg);
     }
   }
 }
@@ -119,57 +126,43 @@
   char *(*port_id)(void *);
 };
 
-static void print_hash_entry(struct hash_entry *e, void *arg)
+static void print_hash_entry(struct nethub *nh,
+			     struct hash_entry *e, void *arg)
 {
   struct printer *p = arg;
 
-  printf("Hash: %d Addr: %02x:%02x:%02x:%02x:%02x:%02x to port: %s  " 
-	 "age %ld secs\n", calc_hash(e->dst),
-	 e->dst[0], e->dst[1], e->dst[2], e->dst[3], e->dst[4], e->dst[5],
-	 (*p->port_id)(e->port), (int) p->now - e->last_seen);
+  fprintf(stderr, "Hash: %d Addr: %02x:%02x:%02x:%02x:%02x:%02x to port: %s  " 
+	  "age %ld secs\n", calc_hash(e->dst),
+	  e->dst[0], e->dst[1], e->dst[2], e->dst[3], e->dst[4], e->dst[5],
+	  (*p->port_id)(e->port), (int) p->now - e->last_seen);
 }
 
-void print_hash(char *(*port_id)(void *))
+void print_hash(struct nethub *nh,
+		char *(*port_id)(void *))
 {
   struct printer p = ((struct printer) { now : 		time(NULL),
 					 port_id :	port_id });
 
-  for_all_hash(print_hash_entry, &p);
+  for_all_hash(nh, print_hash_entry, &p);
 }
 
-#define GC_INTERVAL 2
-#define GC_EXPIRE 100
-
-static void gc(struct hash_entry *e, void *now)
+static void gc(struct nethub *nh,
+	       struct hash_entry *e,
+	       void *now)
 {
   time_t t = *(time_t *) now;
 
   if(e->last_seen + GC_EXPIRE < t)
-    delete_hash_entry(e);
+    delete_hash_entry(nh, e);
 }
 
-static void sig_alarm(int sig)
+void hash_periodic(struct nethub *nh)
 {
-  struct itimerval it;
   time_t t = time(NULL);
-  for_all_hash(&gc, &t);
-
-  it.it_value.tv_sec = GC_INTERVAL;
-  it.it_value.tv_usec = 0 ;
-  it.it_interval.tv_sec = 0;
-  it.it_interval.tv_usec = 0 ;
-  setitimer(ITIMER_REAL, &it, NULL);
+  for_all_hash(nh, &gc, &t);
 }
-
-void hash_init(void)
+  
+void hash_init(struct nethub *nh)
 {
-  struct sigaction sa;
-
-  sa.sa_handler = sig_alarm;
-  sa.sa_flags = SA_RESTART;
-  if(sigaction(SIGALRM, &sa, NULL) < 0){
-    perror("Setting handler for SIGALRM");
-    return;
-  }
-  kill(getpid(), SIGALRM);
+  /* nothing right now */
 }
diff -x CVS -x '*~' -u -N -r uml_tools.jig3/uml_router/hash.h uml_tools.jig4/uml_router/hash.h
--- uml_tools.jig3/uml_router/hash.h	Thu Jun  3 15:24:04 2004
+++ uml_tools.jig4/uml_router/hash.h	Thu Jun  3 17:09:33 2004
@@ -5,11 +5,18 @@
 #ifndef __HASH_H__
 #define __HASH_H__
 
-extern void *find_in_hash(char *dst);
-extern void insert_into_hash(char *src, void *port);
-extern void delete_hash(char *dst);
-extern void print_hash(char *(*port_id)(void *));
-extern void update_entry_time(char *src);
-extern void hash_init(void);
+struct nethub;
+
+extern void *find_in_hash(struct nethub *nh, char *dst);
+extern void insert_into_hash(struct nethub *nh, char *src, void *port);
+extern void delete_hash(struct nethub *nh, char *dst);
+extern void print_hash(struct nethub *nh,
+		       char *(*port_id)(void *));
+extern void update_entry_time(struct nethub *nh, char *src);
+extern void hash_init(struct nethub *nh);
+extern void hash_periodic(struct nethub *nh);
+
+#define GC_INTERVAL 2
+#define GC_EXPIRE 100
 
 #endif
Binary files uml_tools.jig3/uml_router/hash.o and uml_tools.jig4/uml_router/hash.o differ
diff -x CVS -x '*~' -u -N -r uml_tools.jig3/uml_router/nethub.c uml_tools.jig4/uml_router/nethub.c
--- uml_tools.jig3/uml_router/nethub.c	Thu Jun  3 15:24:04 2004
+++ uml_tools.jig4/uml_router/nethub.c	Thu Jun  3 17:09:34 2004
@@ -1,74 +1,154 @@
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/time.h>
 #include <stdio.h>
+#include <stddef.h>
 #include <stdlib.h>
-#include <unistd.h>
 #include <fcntl.h>
+#include <unistd.h>
 #include <errno.h>
+#include <signal.h>
+#include <assert.h>
+#include <setjmp.h>
 #include <sys/socket.h>
-#include <sys/time.h>
+#include <poll.h>
 #include <sys/un.h>
-#include <sys/queue.h>
 #include <netinet/in.h>
+#include <net/ethernet.h>
+#include <net/if_arp.h>
+#define _GNU_SOURCE 1
+#include <getopt.h>
 
-#include <poll.h>
+#include <sys/queue.h>
 
-#include "nethub.h"
-#include "switch.h"
-#include "hash.h"
 #include "port.h"
+#include "hash.h"
 
-struct pollfd *fds = NULL;
-
-int maxfds = 0;
-int nfds = 0;
+#include "nethub.h"
+#include "netjig.h"
 
-void cleanup(void)
+void cleanup_nh(struct nethub *nh)
 {
-  if(unlink(ctl_socket) < 0){
-    printf("Couldn't remove control socket '%s' : ", ctl_socket);
-    perror("");
+  if(nh->pid_file_name) {
+    if(unlink(nh->pid_file_name) < 0 && errno!=ENOENT) {
+      fprintf(stderr, "Could not remove pid file '%s' : %s\n",
+	      nh->ctl_socket_name, strerror(errno));
+    }
+    free(nh->pid_file_name);
+    nh->pid_file_name = NULL;
   }
-  if((data_socket != NULL) && (unlink(data_socket) < 0)){
-    printf("Couldn't remove data socket '%s' : ", data_socket);
-    perror("");
+
+  if(nh->ctl_socket_name) {
+    if(unlink(nh->ctl_socket_name) < 0){
+      fprintf(stderr, "Couldn't remove control socket '%s' : %s\n",
+	      nh->ctl_socket_name, strerror(errno));
+    }
+    free(nh->ctl_socket_name);
+    nh->ctl_socket_name=NULL;
   }
+  if(nh->ctl_listen_fd > 0) {
+    close(nh->ctl_listen_fd);
+    nh->ctl_listen_fd = -1;
+  }
+
+  if(nh->data_socket_name) {
+    if(nh->data_socket_name!=NULL && unlink(nh->data_socket_name) < 0){
+      fprintf(stderr, "Couldn't remove data socket '%s' : %s\n",
+	      nh->data_socket_name, strerror(errno));
+    }
+    free(nh->data_socket_name);
+    nh->data_socket_name=NULL;
+  }
+
+  if(nh->data_fd > 0) {
+    close(nh->data_fd);
+    nh->data_fd = -1;
+  }
+    
+  if(nh->socket_dir != NULL && rmdir(nh->socket_dir) < 0) {
+    fprintf(stderr, "Couldn't remove socket dir '%s' : %s\n",
+	    nh->socket_dir, strerror(errno));
+  }
+
+  /* XXX should free up hash entries and ports */
+  free(nh);
 }
 
-void add_fd(int fd)
+void add_fd(struct netjig_state *ns,
+	    int fd)
 {
   struct pollfd *p;
+  int i;
+
+  /*  fprintf(stderr, "Adding fd %d\n", fd); */
 
-  if(nfds == maxfds){
-    maxfds = maxfds ? 2 * maxfds : 4;
-    if((fds = realloc(fds, maxfds * sizeof(struct pollfd))) == NULL){
+  if(ns->nfds == ns->max_fds){
+    ns->max_fds = ns->max_fds ? 2 * ns->max_fds : 4;
+    if((ns->fds = realloc(ns->fds, ns->max_fds * sizeof(struct pollfd))) == NULL){
       perror("realloc");
-      cleanup();
+      /* XXX need a better cleanup function ! */
       exit(1);
     }
   }
-  p = &fds[nfds++];
+  p = &ns->fds[ns->nfds++];
   p->fd = fd;
   p->events = POLLIN;
+  p->revents=0;
+
+  /*
+   * assuming that FD's are small integers is very Unix.
+   * If you port this to WinBLOWs, well, sorry, figure out someone else.
+   */
+  while(fd >= ns->fd_array_size) {
+    ns->fd_array_size = ns->fd_array_size ? 2*ns->fd_array_size : 4;
+    if((ns->fd_array = realloc(ns->fd_array,
+			       ns->fd_array_size * sizeof(int))) ==NULL) {
+      perror("realloc fd_array");
+      /* XXX need a better cleanup function ! */
+      exit(1);
+    }
+  }
+
+  /* we rebuild the fd->pollfd mapping here because we might have reallocated
+   * it above, and recalculating it is pretty easy.
+   */
+  for(i=0; i < ns->fd_array_size; i++) {
+    ns->fd_array[i]=-1;
+  }
+
+  for(i=0, p=ns->fds; i < ns->nfds; i++, p++) {
+    /* fprintf(stderr, "Mapping fd:%d to item %d\n", p->fd, i); */
+
+    ns->fd_array[p->fd]=i;
+  }
 }
 
-static void remove_fd(int fd)
+void remove_fd(struct netjig_state *ns,
+		      int fd)
 {
   int i;
 
-  for(i = 0; i < nfds; i++){
-    if(fds[i].fd == fd) break;
+  for(i = 0; i < ns->nfds; i++){
+    if(ns->fds[i].fd == fd) break;
   }
-  if(i == nfds){
+  if(i == ns->nfds){
     fprintf(stderr, "remove_fd : Couldn't find descriptor %d\n", fd);
   }
-  memmove(&fds[i], &fds[i + 1], (maxfds - i - 1) * sizeof(struct pollfd));
-  nfds--;
+  memmove(&ns->fds[i], &ns->fds[i + 1], (ns->max_fds - i - 1) * sizeof(struct pollfd));
+  ns->nfds--;
+
+  if(fd < ns->fd_array_size) {
+    ns->fd_array[fd]=-1;
+  }
 }
 
-void close_descriptor(int fd)
+void close_descriptor(struct netjig_state *ns,
+		      struct nethub       *nh,
+		      int fd)
 {
-  remove_fd(fd);
+  remove_fd(ns, fd);
   close(fd);
-  close_port(fd);
+  close_port(ns, nh, fd);
 }
 
 int still_used(struct sockaddr_un *sun)
@@ -79,6 +159,7 @@
     perror("socket");
     exit(1);
   }
+
   if(connect(test_fd, (struct sockaddr *) sun, sizeof(*sun)) < 0){
     if(errno == ECONNREFUSED){
       if(unlink(sun->sun_path) < 0){
@@ -94,12 +175,15 @@
   return(ret);
 }
 
+
 int bind_socket(int fd, const char *name, struct sockaddr_un *sock_out)
 {
   struct sockaddr_un sun;
 
+  memset(&sun, 0, sizeof(sun));
+
   sun.sun_family = AF_UNIX;
-  strncpy(sun.sun_path, name, sizeof(sun.sun_path));
+  strcpy(sun.sun_path, name);
   
   if(bind(fd, (struct sockaddr *) &sun, sizeof(sun)) < 0){
     if((errno == EADDRINUSE) && still_used(&sun)) return(EADDRINUSE);
@@ -112,53 +196,55 @@
   return(0);
 }
 
-void bind_sockets_v0(int ctl_fd, const char *ctl_name, 
-		     int data_fd, const char *data_name)
+
+void bind_sockets_v0(struct nethub *nh)
 {
   int ctl_err, ctl_present = 0, ctl_used = 0;
   int data_err, data_present = 0, data_used = 0;
   int try_remove_ctl, try_remove_data;
 
-  ctl_err = bind_socket(ctl_fd, ctl_name, NULL);
+  ctl_err = bind_socket(nh->ctl_listen_fd, nh->ctl_socket_name, NULL);
   if(ctl_err != 0) ctl_present = 1;
   if(ctl_err == EADDRINUSE) ctl_used = 1;
 
-  data_err = bind_socket(data_fd, data_name, &data_sun);
+  data_err = bind_socket(nh->data_fd, nh->data_socket_name, &nh->data_sun);
   if(data_err != 0) data_present = 1;
   if(data_err == EADDRINUSE) data_used = 1;
 
-  if(!ctl_err && !data_err){
-    return;
-  }
+  if(!ctl_err && !data_err) return;
+
+  unlink(nh->ctl_socket_name);
+  unlink(nh->data_socket_name);
 
   try_remove_ctl = ctl_present;
   try_remove_data = data_present;
   if(ctl_present && ctl_used){
     fprintf(stderr, "The control socket '%s' has another server "
-	    "attached to it\n", ctl_name);
+	    "attached to it\n", nh->ctl_socket_name);
     try_remove_ctl = 0;
   }
   else if(ctl_present && !ctl_used)
     fprintf(stderr, "The control socket '%s' exists, isn't used, but couldn't "
-	    "be removed\n", ctl_name);
+	    "be removed\n", nh->ctl_socket_name);
   if(data_present && data_used){
     fprintf(stderr, "The data socket '%s' has another server "
-	    "attached to it\n", data_name);
+	    "attached to it\n", nh->data_socket_name);
     try_remove_data = 0;
   }
   else if(data_present && !data_used)
     fprintf(stderr, "The data socket '%s' exists, isn't used, but couldn't "
-	    "be removed\n", data_name);
+	    "be removed\n", nh->data_socket_name);
   if(try_remove_ctl || try_remove_data){
     fprintf(stderr, "You can either\n");
     if(try_remove_ctl && !try_remove_data) 
-      fprintf(stderr, "\tremove '%s'\n", ctl_socket);
+      fprintf(stderr, "\tremove '%s'\n", nh->ctl_socket_name);
     else if(!try_remove_ctl && try_remove_data) 
-      fprintf(stderr, "\tremove '%s'\n", data_socket);
-    else fprintf(stderr, "\tremove '%s' and '%s'\n", ctl_socket, data_socket);
+      fprintf(stderr, "\tremove '%s'\n", nh->data_socket_name);
+    else fprintf(stderr, "\tremove '%s' and '%s'\n",
+		 nh->ctl_socket_name, nh->data_socket_name);
     fprintf(stderr, "\tor rerun with different, unused filenames for "
 	    "sockets:\n");
-    fprintf(stderr, "\t\t%s -unix <control> <data>\n", prog);
+    fprintf(stderr, "\t\t%s -unix <control> <data>\n", progname);
     fprintf(stderr, "\t\tand run the UMLs with "
 	    "'eth0=daemon,,unix,<control>,<data>\n");
     exit(1);
@@ -166,7 +252,7 @@
   else {
     fprintf(stderr, "You should rerun with different, unused filenames for "
 	    "sockets:\n");
-    fprintf(stderr, "\t%s -unix <control> <data>\n", prog);
+    fprintf(stderr, "\t%s -unix <control> <data>\n", progname);
     fprintf(stderr, "\tand run the UMLs with "
 	    "'eth0=daemon,,unix,<control>,<data>'\n");
     exit(1);
@@ -194,28 +280,221 @@
   }
 }
 
-void bind_sockets(int ctl_fd, const char *ctl_name, int data_fd)
+void bind_sockets(struct nethub *nh)
 {
   int err, used;
 
-  err = bind_socket(ctl_fd, ctl_name, NULL);
+  err = bind_socket(nh->ctl_listen_fd, nh->ctl_socket_name, NULL);
   if(err == 0){
-    bind_data_socket(data_fd, &data_sun);
+    bind_data_socket(nh->data_fd, &nh->data_sun);
     return;
   }
   else if(err == EADDRINUSE) used = 1;
   
   if(used){
     fprintf(stderr, "The control socket '%s' has another server "
-	    "attached to it\n", ctl_name);
+	    "attached to it\n", nh->ctl_socket_name);
     fprintf(stderr, "You can either\n");
-    fprintf(stderr, "\tremove '%s'\n", ctl_name);
+    fprintf(stderr, "\tremove '%s'\n", nh->ctl_socket_name);
     fprintf(stderr, "\tor rerun with a different, unused filename for a "
 	    "socket\n");
   }
   else
     fprintf(stderr, "The control socket '%s' exists, isn't used, but couldn't "
-	    "be removed\n", ctl_name);
+	    "be removed\n", nh->ctl_socket_name);
   exit(1);
 }
 
+
+struct nethub *init_nethub(struct netjig_state *ns,
+			   char *switchname,
+			   char *data_socket,
+			   char *ctl_socket,
+			   int compat_v0)
+{
+	int one;
+	char *env;
+	char *newdir, *p;
+	struct nethub *nh;
+	int used_base_dir;
+
+	one = 1;
+	used_base_dir = 0;
+
+	nh=xmalloc(sizeof(*nh));
+	memset(nh, 0, sizeof(*nh));
+
+	TAILQ_INIT(&nh->nh_ports);
+
+	nh->nh_name = strdup(switchname);
+
+	/* setup ARP stuff */
+	nh->nh_allarp = 0;
+	
+	nh->nh_defaultgate.s_addr = 0;
+	
+	nh->nh_defaultether[0]=0x10;
+	nh->nh_defaultether[1]=0x00;
+	nh->nh_defaultether[2]=0x00;
+	nh->nh_defaultether[3]=switchname[0];
+	nh->nh_defaultether[4]=switchname[1];
+	nh->nh_defaultether[5]=switchname[2];
+
+	if(ctl_socket == NULL) {
+	  /* cons up the names, and stick them in the environment */
+	  env = xmalloc(sizeof("UML_")+2*strlen(switchname)+sizeof("CTL=")+
+			strlen(ns->socketbasedir)+sizeof("/ctl")+4);
+	  
+	  sprintf(env, "UML_%s_CTL=%s/%s/ctl", switchname,
+		  ns->socketbasedir, switchname);
+	  putenv(env);
+	  nh->ctl_socket_name_env = env;
+	  nh->ctl_socket_name = strdup(strchr(env, '=')+1);
+	  used_base_dir = 1;
+	} else {
+	  nh->ctl_socket_name_env = NULL;
+	  nh->ctl_socket_name = strdup(ctl_socket);
+	}
+
+	if(data_socket == NULL) {
+	  env = xmalloc(sizeof("UML_")+2*strlen(switchname)+sizeof("DATA=")+
+			strlen(ns->socketbasedir)+sizeof("/data")+4);
+	  
+	  sprintf(env, "UML_%s_DATA=%s/%s/data", switchname,
+		  ns->socketbasedir, switchname);
+	  putenv(env);
+	  nh->data_socket_name_env = env;
+	  nh->data_socket_name = strdup(strchr(env, '=')+1);
+	  used_base_dir = 1;
+	} else {
+	  nh->data_socket_name_env = NULL;
+	  nh->data_socket_name = strdup(data_socket);
+	}
+	  
+
+	/* now make the directory, if we need it */
+ 	if(used_base_dir ) {
+		FILE *pidfile;
+
+		if(mkdir(ns->socketbasedir,0700) < 0 &&
+		   errno != EEXIST) {
+			perror(ns->socketbasedir);
+			exit(1);
+		}
+
+		newdir=strdup(nh->ctl_socket_name);
+		if((p=strrchr(newdir, '/'))!=NULL) {
+			*p='\0';
+			if(mkdir(newdir, 0700) < 0 &&
+			   errno != EEXIST) {
+				perror(newdir);
+				exit(1);
+			}
+		}
+		nh->socket_dir=newdir;
+
+		nh->pid_file_name=xmalloc(strlen(nh->socket_dir)+sizeof("pid")+2);
+		sprintf(nh->pid_file_name, "%s/pid", nh->socket_dir);
+		if((pidfile=fopen(nh->pid_file_name, "w"))==NULL) {
+			perror(nh->pid_file_name);
+		} else {
+			fprintf(pidfile, "%d", getpid());
+			fclose(pidfile);
+		}
+	} 
+
+	if((nh->ctl_listen_fd = socket(PF_UNIX, SOCK_STREAM, 0)) < 0){
+		perror("socket");
+		exit(1);
+	}
+	if(setsockopt(nh->ctl_listen_fd,
+		      SOL_SOCKET, SO_REUSEADDR, (char *) &one, 
+		      sizeof(one)) < 0){
+		perror("setsockopt");
+		exit(1);
+	}
+
+	if(fcntl(nh->ctl_listen_fd, F_SETFL, O_NONBLOCK) < 0){
+		perror("Setting O_NONBLOCK on connection fd");
+		exit(1);
+	}
+	
+	if((nh->data_fd = socket(PF_UNIX, SOCK_DGRAM, 0)) < 0){
+		perror("socket");
+		exit(1);
+	}
+
+#if 0
+	if(fcntl(nh->data_fd, F_SETFL, O_NONBLOCK) < 0){
+		perror("Setting O_NONBLOCK on data fd");
+		exit(1);
+	}
+#endif
+
+	if(compat_v0) bind_sockets_v0(nh);
+	else bind_sockets(nh);
+
+	if(listen(nh->ctl_listen_fd, 15) < 0){
+		perror("listen");
+		exit(1);
+	}
+	 
+
+	add_fd(ns, nh->ctl_listen_fd);
+	add_fd(ns, nh->data_fd);
+
+	hash_init(nh);
+
+	TAILQ_INSERT_TAIL(&ns->switches, nh, nh_link);
+	return nh;
+}
+
+
+struct nethub *find_nethubbyname(struct netjig_state *ns,
+				 char *name)
+{
+  struct nethub *nh;
+
+  for(nh=ns->switches.tqh_first;
+      nh;
+      nh=nh->nh_link.tqe_next) {
+
+    if(strcasecmp(nh->nh_name, name)==0) {
+      break;
+    }
+  }
+  return nh;
+}
+
+void create_socket_dir(struct netjig_state *ns)
+{
+	char tmpbuf[1024];
+
+	if(ns->socketbasedir == NULL) {
+		char *tmpdir_env;
+		int   fd_file;
+
+		tmpdir_env = getenv("TMPDIR");
+		if(tmpdir_env == NULL) {
+			tmpdir_env = P_tmpdir;
+		}
+
+		snprintf(tmpbuf, sizeof(tmpbuf)-4, "%s/umlXXXXXX", tmpdir_env);
+		fd_file = mkstemp(tmpbuf);
+		
+		if(fd_file == -1) {
+			fprintf(stderr, "failed to make tmpdir (last=%s)\n", tmpbuf);
+			exit(1);
+		}
+
+		strcat(tmpbuf,".d");
+
+		if(mkdir(tmpbuf, 0700) != 0) {
+			fprintf(stderr, "failed to mkdir(%s): %s\n",
+				tmpbuf, strerror(errno));
+			exit(2);
+		}
+		ns->socketbasedir=strdup(tmpbuf);
+		close(fd_file);
+	}
+}
diff -x CVS -x '*~' -u -N -r uml_tools.jig3/uml_router/nethub.h uml_tools.jig4/uml_router/nethub.h
--- uml_tools.jig3/uml_router/nethub.h	Thu Jun  3 15:24:04 2004
+++ uml_tools.jig4/uml_router/nethub.h	Thu Jun  3 17:09:34 2004
@@ -83,6 +83,78 @@
 
 struct port;
 
+struct nethub {
+	TAILQ_ENTRY(nethub)     nh_link;
+	TAILQ_HEAD(,port)  nh_ports;
+	char              *nh_name;
+	unsigned char      nh_defaultether[ETH_ALEN];
+	struct in_addr     nh_defaultgate;
+	int                nh_allarp;
+	char              *nh_outputFile;
+	int                nh_rate;
+	char              *nh_inputFile;
+	int                nh_hub;
+	int                nh_compat_v0;
+	char              *socket_dir;
+	char              *pid_file_name;
+	char              *ctl_socket_name_env;   /* do not free this one */
+	char              *ctl_socket_name;
+	int                ctl_listen_fd;
+	char              *data_socket_name_env;  /* do not free this one */
+	char              *data_socket_name;
+	struct sockaddr_un data_sun;
+	int                data_fd;
+	int                tap_fd;
+	struct hash_entry *h[HASH_SIZE];
+
+};
+
+#define CMDBUF_LEN 256
+struct netjig_state {
+	int   done;
+	int   debug;
+	int   verbose;
+        int   waitplay;
+	char *socketbasedir;
+	char *startup;
+	char *playprivatefile;
+	char *recordprivatefile;
+	char *playpublicfile;
+	char *recordpublicfile;
+	int arpreply;
+	int cmdproto;
+	int forcetick;   /* if set to 1, then a packet will be sent out */
+	int packetrate;  /* how many miliseconds between packets */
+	FILE *cmdproto_out;
+	int exitonempty;
+	TAILQ_HEAD(,nethub) switches;
+
+	/* stuff to keep track of the sources of input */
+	struct pollfd *fds;        /* array of input sources */
+	int            nfds;       /* number of relevant entries */
+	int            max_fds;    /* current size of the array */
+
+	/* poll(2) doesn't provide a very useful interface to figure out what
+	 * fd belongs to what event, and searching through stuff sucks, we
+	 * we keep a mapping of fd# -> poll descriptor entry. We then walk through
+	 * the set of possible inputs, (in the appropriate priority order) and
+	 * use this array to map to an entry in fds[] to see if this input has
+	 * activity.
+	 */
+	int            *fd_array;
+	int             fd_array_size;  /* so we can grow it in add_fd() */
+
+
+	/* keep track of curtent input buffer, since we predict that eventuallyu
+	 * command sizes will grow such that they do not always fit into a single
+	 * read(2), or that multiple commands may get coalesced into a single buffer.
+	 */
+	char cmdbuf[CMDBUF_LEN];
+	int  cmdloc;
+	int  cmdskip;
+	int  cmdlaststat;         /* 0= success */
+};
+
 struct packet {
   struct {
     unsigned char dest[6];
@@ -92,24 +164,30 @@
   unsigned char data[1500];
 };
 
+/* in nethub.c */
+extern struct nethub *init_nethub(struct netjig_state *ns,
+				  char *switchname,
+				  char *data_socket, char *ctl_socket,
+				  int compat_v0);
+extern void bind_sockets(struct nethub *nh);
+extern void cleanup_nh(struct nethub *nh);
+extern struct nethub *find_nethubbyname(struct netjig_state *ns, char *name);
+extern void add_fd(struct netjig_state *ns, int fd);
+extern void remove_fd(struct netjig_state *ns, int fd);
+
+extern void close_descriptor(struct netjig_state *ns,
+			     struct nethub       *nh,
+			     int fd);
+
 #define xmalloc(X) xmalloc1((X), __FILE__, __LINE__)
 
-extern char *ctl_socket;
-extern char *data_socket;
-extern char *prog;
-extern struct pollfd *fds;
-extern int maxfds;
-extern int nfds;
-
-extern struct sockaddr_un data_sun;
-extern void cleanup(void);
-extern void bind_sockets(int ctl_fd, const char *ctl_name, int data_fd);
-void bind_sockets_v0(int ctl_fd, const char *ctl_name, 
-		     int data_fd, const char *data_name);
-void add_fd(int fd);
-void accept_connection(int fd);
-void close_descriptor(int fd);
+#ifdef NETDISSECT
+#include "netdissect.h"
 
+extern struct netdissect_options gndo;
+extern int tcpdump_print;
+
+#endif
 
 #define _NETHUB_H_
 
@@ -124,3 +202,4 @@
  * End:
  *
  */
+
Binary files uml_tools.jig3/uml_router/nethub.o and uml_tools.jig4/uml_router/nethub.o differ
diff -x CVS -x '*~' -u -N -r uml_tools.jig3/uml_router/netjig.h uml_tools.jig4/uml_router/netjig.h
--- uml_tools.jig3/uml_router/netjig.h	Wed Dec 31 19:00:00 1969
+++ uml_tools.jig4/uml_router/netjig.h	Thu Jun  3 17:09:34 2004
@@ -0,0 +1,29 @@
+extern char *progname;
+extern jmp_buf getMeOut;
+
+#define ETH_ALEN 6
+
+#define MAX(x,y) ((x) > (y) ? (x) : (y))
+
+/* prototypes */
+extern void sig_handler(int sig);
+extern void create_socket_dir(struct netjig_state *ns);
+extern void cmdprompt(struct netjig_state *ns);
+extern void forward_data(struct nethub *nh, struct packet *p, int    len);
+extern int cmdread(struct netjig_state *ns, char  *buf, int    len);
+extern void *xmalloc1(size_t size, char *file, int linenum);
+
+/* from cmdmode.c */
+
+extern void finish_waitplay(struct netjig_state *ns);
+extern int cmdread(struct netjig_state *ns, char  *buf, int    len);
+
+/*
+ * $Log: netjig.h,v $
+ *
+ * Local variables:
+ * c-file-style: "linux"
+ * c-basic-offset: 8
+ * End:
+ *
+ */
diff -x CVS -x '*~' -u -N -r uml_tools.jig3/uml_router/port.c uml_tools.jig4/uml_router/port.c
--- uml_tools.jig3/uml_router/port.c	Thu Jun  3 15:24:04 2004
+++ uml_tools.jig4/uml_router/port.c	Thu Jun  3 17:09:33 2004
@@ -4,104 +4,126 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <sys/socket.h>
-#include <sys/time.h>
 #include <sys/un.h>
 #include <sys/queue.h>
+#include <net/if_arp.h>
 #include <netinet/in.h>
-
 #include <poll.h>
 
-#include "nethub.h"
-#include "switch.h"
 #include "hash.h"
 #include "port.h"
 
+#include "nethub.h"
+
 struct port {
-  struct port *next;
-  struct port *prev;
-  int control;
-  void *data;
-  int data_len;
-  unsigned char src[ETH_ALEN];
-  void (*sender)(int fd, void *packet, int len, void *data);
+	TAILQ_ENTRY(port) link;
+	int control;
+	void *data;
+	int data_len;
+	packet_sender sender;
+        unsigned char most_recent_ethernet[ETH_ALEN];
 };
 
-static struct port *head = NULL;
-
 #define IS_BROADCAST(addr) ((addr[0] & 1) == 1)
 
-static void free_port(struct port *port)
+static void free_port(struct netjig_state *ns,
+		      struct nethub *nh,
+		      struct port *port)
 {
-  if(port->prev) port->prev->next = port->next;
-  else head = port->next;
-  if(port->next) port->next->prev = port->prev;
+  TAILQ_REMOVE(&nh->nh_ports,port,link);
   free(port);
 }
 
-void close_port(int fd)
+void close_port(struct netjig_state *ns,
+		struct nethub *nh,
+		int fd)
 {
   struct port *port;
 
-  for(port = head; port != NULL; port = port->next){
+  for(port = nh->nh_ports.tqh_first;
+      port != NULL;
+      port = port->link.tqe_next){
     if(port->control == fd) break;
   }
+
   if(port == NULL){
     fprintf(stderr, "No port associated with descriptor %d\n", fd);
     return;
   }
-  delete_hash(port->src);
-  free_port(port);
+  free_port(ns, nh, port);
 }
 
-static void update_src(struct port *port, struct packet *p)
+static void update_src(struct netjig_state *ns,
+		       struct nethub       *nh,
+		       struct port *port,
+		       struct packet *p)
 {
   struct port *last;
 
   /* We don't like broadcast source addresses */
   if(IS_BROADCAST(p->header.src)) return;  
 
-  last = find_in_hash(p->header.src);
+  last = find_in_hash(nh, p->header.src);
 
   if(port != last){
     /* old value differs from actual input port */
 
-    printf(" Addr: %02x:%02x:%02x:%02x:%02x:%02x New port %d",
-	   p->header.src[0], p->header.src[1], p->header.src[2],
-	   p->header.src[3], p->header.src[4], p->header.src[5],
-	   port->control);
+    if(ns->verbose) {
+      fprintf(stderr,
+	      " Addr: %02x:%02x:%02x:%02x:%02x:%02x "
+	      " New port %d",
+	      p->header.src[0], p->header.src[1], p->header.src[2],
+	      p->header.src[3], p->header.src[4], p->header.src[5],
+	      port->control);
+    }
 
     if(last != NULL){
-      printf(" old port %d", last->control);
-      delete_hash(p->header.src);
+      if(ns->verbose) {
+	fprintf(stderr, "old port %d", last->control);
+      }
+      delete_hash(nh, p->header.src);
+    }
+    if(ns->verbose) {
+      fprintf(stderr, "\n");
     }
-    printf("\n");
 
-    memcpy(port->src, p->header.src, sizeof(port->src));
-    insert_into_hash(p->header.src, port);
+    memcpy(port->most_recent_ethernet, p->header.src, ETH_ALEN);
+    insert_into_hash(nh, p->header.src, port);
   }
-  update_entry_time(p->header.src);
+  update_entry_time(nh, p->header.src);
 }
 
-static void send_dst(struct port *port, struct packet *packet, int len, 
+static void send_dst(struct netjig_state *ns,
+		     struct nethub       *nh,
+		     struct port *srcport,
+		     struct packet *packet, int len, 
 		     int hub)
 {
   struct port *target, *p;
 
-  target = find_in_hash(packet->header.dest);
+  target = find_in_hash(nh, packet->header.dest);
   if((target == NULL) || IS_BROADCAST(packet->header.dest) || hub){
     if((target == NULL) && !IS_BROADCAST(packet->header.dest)){
-      printf("unknown Addr: %02x:%02x:%02x:%02x:%02x:%02x from port ",
-	     packet->header.src[0], packet->header.src[1], 
-	     packet->header.src[2], packet->header.src[3], 
-	     packet->header.src[4], packet->header.src[5]);
-      if(port == NULL) printf("UNKNOWN\n");
-      else printf("%d\n", port->control);
+      if(ns->verbose) {
+	fprintf(stderr,
+		"hub %s unknown Addr: %02x:%02x:%02x:%02x:%02x:%02x from port %d\n",
+		nh->nh_name,
+		packet->header.src[0], packet->header.src[1], 
+		packet->header.src[2], packet->header.src[3], 
+		packet->header.src[4], packet->header.src[5],
+		(srcport == NULL) ? -1 : srcport->control);
+      }
     } 
 
     /* no cache or broadcast/multicast == all ports */
-    for(p = head; p != NULL; p = p->next){
+    for(p = nh->nh_ports.tqh_first;
+	p != NULL;
+	p = p->link.tqe_next){
       /* don't send it back the port it came in */
-      if(p == port) continue;
+      if(p == srcport) continue;
+
+      /* don't send to ports that aren't initalized yet */
+      if(!p->sender) continue;
 
       (*p->sender)(p->control, packet, len, p->data);
     }
@@ -109,23 +131,37 @@
   else (*target->sender)(target->control, packet, len, target->data);
 }
 
-static void handle_data(int fd, int hub, struct packet *packet, int len, 
-			void *data, int (*matcher)(int port_fd, int data_fd, 
-						   void *port_data,
-						   int port_data_len, 
-						   void *data))
+void insert_data(struct netjig_state *ns,
+		 struct nethub *nh,
+		 struct packet *packet, int len)
+{
+  send_dst(ns, nh, NULL, packet, len, nh->nh_hub);
+}
+
+
+void handle_data(struct netjig_state *ns,
+		 struct nethub *nh,
+		 struct packet *packet, int len,
+		 int   fd,
+		 void *data, int (*matcher)(int port_fd, int data_fd, 
+					    void *port_data,
+					    int port_data_len, 
+					    void *data))
 {
   struct port *p;
 
-  for(p = head; p != NULL; p = p->next){
-    if((*matcher)(p->control, fd, p->data, p->data_len, data)) break;
-  }
+  if(matcher) {
+	  for(p = nh->nh_ports.tqh_first;
+	      p != NULL;
+	      p = p->link.tqe_next){
+		  if((*matcher)(p->control, fd, p->data, p->data_len, data)) break;
+	  }
   
-  /* if we have an incoming port (we should) */
-  if(p != NULL) update_src(p, packet);
-  else printf("Unknown connection for packet, shouldn't happen.\n");
+	  /* if we have an incoming port (we will unless the packet is inserted) */
+	  if(p != NULL) update_src(ns, nh, p, packet);
+  }
 
-  send_dst(p, packet, len, hub);  
+  send_dst(ns, nh, p, packet, len, nh->nh_hub);  
 }
 
 static int match_tap(int port_fd, int data_fd, void *port_data, 
@@ -134,39 +170,34 @@
   return(port_fd == data_fd);
 }
 
-void handle_tap_data(int fd, int hub)
+void handle_tap_data(struct netjig_state *ns,
+		     struct nethub       *nh)
 {
   struct packet packet;
   int len;
 
-  len = read(fd, &packet, sizeof(packet));
+  len = read(nh->tap_fd, &packet, sizeof(packet));
   if(len < 0){
     if(errno != EAGAIN) perror("Reading tap data");
     return;
   }
-  handle_data(fd, hub, &packet, len, NULL, match_tap);
+  handle_data(ns, nh, &packet, len, nh->tap_fd, NULL, match_tap);
 }
 
-int setup_port(int fd, void (*sender)(int fd, void *packet, int len, 
-				      void *data), void *data, int data_len)
+struct port *alloc_port(struct netjig_state *ns,
+			struct nethub       *nh)
 {
   struct port *port;
 
   port = malloc(sizeof(struct port));
   if(port == NULL){
     perror("malloc");
-    return(-1);
+    return(NULL);
   }
-  port->next = head;
-  if(head) head->prev = port;
-  port->prev = NULL;
-  port->control = fd;
-  port->data = data;
-  port->data_len = data_len;
-  port->sender = sender;
-  head = port;
-  printf("New connection\n");
-  return(0);
+  memset(port, 0, sizeof(struct port));
+
+  TAILQ_INSERT_TAIL(&nh->nh_ports, port, link);
+  return port;
 }
 
 struct sock_data {
@@ -181,10 +212,7 @@
   
   err = sendto(mine->fd, packet, len, 0, (struct sockaddr *) &mine->sock,
 	       sizeof(mine->sock));
-  if(err != len){
-    fprintf(stderr, "send_sock sending to fd %d ", mine->fd);
-    perror("");
-  }
+  if(err != len) perror("send_sock");
 }
 
 static int match_sock(int port_fd, int data_fd, void *port_data, 
@@ -197,24 +225,32 @@
   return(!memcmp(&port->sock, &mine->sock, sizeof(mine->sock)));
 }
 
-void handle_sock_data(int fd, int hub)
+
+void handle_sock_data(struct netjig_state *ns,
+		      struct nethub *nh)
 {
   struct packet packet;
   struct sock_data data;
   int len, socklen = sizeof(data.sock);
 
-  len = recvfrom(fd, &packet, sizeof(packet), 0, 
+  len = recvfrom(nh->data_fd,
+		 &packet, sizeof(packet), 0, 
 		 (struct sockaddr *) &data.sock, &socklen);
+
   if(len < 0){
     if(errno != EAGAIN) perror("handle_sock_data");
     return;
   }
-  data.fd = fd;
 
-  handle_data(fd, hub, &packet, len, &data, match_sock);
+  data.fd = nh->data_fd;
+  handle_data(ns, nh, &packet, len, nh->data_fd, &data, match_sock);
 }
 
-int setup_sock_port(int fd, struct sockaddr_un *name, int data_fd)
+
+int setup_sock_port(struct netjig_state *ns,
+		    struct nethub       *nh,
+		    struct port         *port,
+		    struct sockaddr_un  *name)
 {
   struct sock_data *data;
 
@@ -223,120 +259,244 @@
     perror("setup_sock_port");
     return(-1);
   }
-  *data = ((struct sock_data) { fd : 	data_fd,
-				sock :	*name });
-  return(setup_port(fd, send_sock, data, sizeof(*data)));
-}
+  data->fd   = nh->data_fd;
+  data->sock = *name;
+  
+  port->sender = send_sock;
+  port->data   = data;
+  port->data_len=sizeof(*data);
 
-static void service_port(struct port *port)
-{
-  int n;
-  char c;
 
-  n = read(port->control, &c, sizeof(c));
-  if(n < 0) perror("Reading request");
-  else if(n == 0) printf("Disconnect\n");
-  else printf("Bad request\n");  
+  return(0);
 }
 
-int handle_port(int fd)
+int setup_sock_tap(struct netjig_state *ns,
+		   struct nethub       *nh,
+		   int    fd,
+		   packet_sender        tap_sender)
 {
-  struct port *p;
+  struct sock_data *data;
+  struct port *np;
 
-  for(p = head; p != NULL; p = p->next){
-    if(p->control == fd){
-      service_port(p);
-      return(0);
-    }
+  np = alloc_port(ns, nh);
+
+  data = malloc(sizeof(*data));
+  if(data == NULL){
+    perror("setup_sock_port");
+    return(-1);
+  }
+  data->fd   = nh->data_fd;
+  
+  np->sender = tap_sender;
+  np->data   = data;
+  np->data_len=sizeof(*data);
+
+  if(ns->verbose) {
+    fprintf(stderr, "New tap connection\n");
   }
-  return(1);
+  return(0);
 }
 
-static void new_port_v0(int fd, struct request_v0 *req, int data_fd)
+void new_port_v0(struct netjig_state *ns,
+		 struct nethub *nh,
+		 struct port *p,
+		 struct request_v0 *req)
 {
   switch(req->type){
   case REQ_NEW_CONTROL:
-    setup_sock_port(fd, &req->u.new_control.name, data_fd);
-    break;
+	  setup_sock_port(ns, nh, p, &req->u.new_control.name);
+	  break;
+    
   default:
-    printf("Bad request type : %d\n", req->type);
-    close_descriptor(fd);
+	  fprintf(stderr, "Bad request type : %d\n", req->type);
+	  close_descriptor(ns, nh, nh->data_fd);
   }
 }
 
-static void new_port_v1_v3(int fd, enum request_type type, 
-			   struct sockaddr_un *sock, int data_fd)
+void new_port_v1_v3(struct netjig_state *ns,
+		    struct nethub *nh,
+		    struct port   *port,
+		    enum request_type type, 
+		    struct sockaddr_un *sock)
 {
   int n, err;
 
   switch(type){
   case REQ_NEW_CONTROL:
-    err = setup_sock_port(fd, sock, data_fd);
+    err = setup_sock_port(ns, nh, port, sock);
     if(err) return;
-    n = write(fd, &data_sun, sizeof(data_sun));
-    if(n != sizeof(data_sun)){
-      perror("Sending data socket name");
-      close_descriptor(fd);
+    n = write(port->control, &nh->data_sun, sizeof(nh->data_sun));
+    if(n != sizeof(nh->data_sun)){
+      fprintf(stderr, "Sending data socket name: %s\n", strerror(errno));
+      close_descriptor(ns, nh, port->control);
     }
     break;
   default:
-    printf("Bad request type : %d\n", type);
-    close_descriptor(fd);
+    fprintf(stderr, "Bad request type : %d\n", type);
+    close_descriptor(ns, nh, port->control);
   }
 }
 
-static void new_port_v2(int fd, struct request_v2 *req, int data_fd)
+void new_port_v2(struct netjig_state *ns,
+		 struct nethub       *nh,
+		 struct port         *p,
+		 struct request_v2 *req)
 {
   fprintf(stderr, "Version 2 is not supported\n");
-  close_descriptor(fd);
+  close_descriptor(ns, nh, p->control);
 }
 
-void new_port(int fd, int data_fd)
+/*
+ * called when data is ready on a new port
+ */
+void handle_new_port(struct netjig_state *ns,
+		     struct nethub *nh,
+		     struct port   *p) 
 {
   union request req;
   int len;
 
-  len = read(fd, &req, sizeof(req));
+  len = read(p->control, &req, sizeof(req));
   if(len < 0){
     if(errno != EAGAIN){
       perror("Reading request");
-      close_descriptor(fd);
+      close_descriptor(ns,nh,p->control);
     }
     return;
   }
   else if(len == 0){
-    printf("EOF from new port\n");
-    close_descriptor(fd);
+    fprintf(stderr, "EOF from new port\n");
+    close_descriptor(ns,nh,p->control);
     return;
   }
-  if(req.v1.magic == SWITCH_MAGIC){
-    if(req.v2.version == 2) new_port_v2(fd, &req.v2, data_fd);
-    if(req.v3.version == 3) 
-      new_port_v1_v3(fd, req.v3.type, &req.v3.sock, data_fd);
-    else if(req.v2.version > 2) 
-      fprintf(stderr, "Request for a version %d port, which this "
-	      "uml_switch doesn't support\n", req.v2.version);
-    else new_port_v1_v3(fd, req.v1.type, &req.v1.u.new_control.name, data_fd);
+
+  if(req.v1.magic == SWITCH_MAGIC) {
+          if(ns->verbose) {
+	    fprintf(stderr,
+		    "switch %s: new connection using daemon v.%d on port %d\n",
+		    nh->nh_name, req.v2.version, p->control);
+	  }
+	  switch(req.v2.version) {
+	  case 2:
+		  new_port_v2(ns, nh, p, &req.v2);
+		  break;
+		  
+	  case 3:
+		  new_port_v1_v3(ns, nh, p, req.v3.type, &req.v3.sock);
+		  break;
+		  
+	  case 1:
+		  new_port_v1_v3(ns, nh, p, req.v1.type, &req.v1.u.new_control.name);
+		  break;
+		  
+	  default:
+		  fprintf(stderr, "Request for a version %d port, which this "
+			  "uml_switch doesn't support\n", req.v2.version);
+		  break;
+	  }
+  } else {
+	  new_port_v0(ns, nh, p, &req.v0);
   }
-  else new_port_v0(fd, &req.v0, data_fd);
 }
 
-void accept_connection(int fd)
+static void service_port(struct netjig_state *ns,
+			 struct nethub *nh,
+			 struct port *port)
+{
+  int n;
+  char c;
+
+  if(ns->debug > 2) {
+    fprintf(stderr, "servicing port %d\n", port->control);
+  }
+
+  n = read(port->control, &c, sizeof(c));
+  if(n < 0) {
+    fprintf(stderr, "while serving port %d of switch %s reading request: %s",
+	    port->control, nh->nh_name, strerror(errno));
+  }
+  else if(n == 0) {
+    if(ns->verbose) {
+      fprintf(stderr, "Disconnect on switch (%s) from %d addr: %02x:%02x:%02x:%02x:%02x:%02x\n",
+	      nh->nh_name,
+	      port->control,
+	      port->most_recent_ethernet[0], port->most_recent_ethernet[1],
+	      port->most_recent_ethernet[2], port->most_recent_ethernet[3],
+	      port->most_recent_ethernet[4], port->most_recent_ethernet[5]);
+    }
+
+    remove_fd(ns, port->control);
+    free_port(ns, nh, port);
+  }
+  else {
+    if(ns->verbose) {
+      fprintf(stderr,
+	      "Bad request on switch (%s) from %d addr: %02x:%02x:%02x:%02x:%02x:%02x\n",
+	      nh->nh_name,
+	      port->control,
+	      port->most_recent_ethernet[0], port->most_recent_ethernet[1],
+	      port->most_recent_ethernet[2], port->most_recent_ethernet[3],
+	      port->most_recent_ethernet[4], port->most_recent_ethernet[5]);
+    }
+  }
+}
+
+void accept_connection(struct netjig_state *ns,
+		       struct nethub       *nh)
 {
   struct sockaddr addr;
+  struct port *new_port;
   int len, new;
 
   len = sizeof(addr);
-  new = accept(fd, &addr, &len);
+  new = accept(nh->ctl_listen_fd, &addr, &len);
   if(new < 0){
     perror("accept");
     return;
   }
+
+#if 0
   if(fcntl(new, F_SETFL, O_NONBLOCK) < 0){
     perror("fcntl - setting O_NONBLOCK");
     close(new);
     return;
   }
-  add_fd(new);
+#endif
+  
+  new_port = alloc_port(ns, nh);
+  new_port->control = new;
+  add_fd(ns, new);
 }
 
+void handle_port(struct netjig_state *ns,
+		 struct nethub       *nh,
+		 struct pollfd  *l_fds,
+		 int             l_nfds,
+		 int            *l_fd_array,
+		 int             l_fd_array_size)
+{
+  struct port *p;
+  struct port *next_port;
+  
+  for(p = nh->nh_ports.tqh_first;
+      p != NULL;
+      p = next_port)
+    {
+      next_port = p->link.tqe_next;
+
+      if(p->control < l_fd_array_size &&
+	 l_fd_array[p->control]!=-1) {
+
+	if(l_fds[l_fd_array[p->control]].revents & POLLIN) {
+	  if(p->sender) {
+	    service_port(ns, nh, p);
+	  } else {
+	    handle_new_port(ns, nh, p);
+	  }
+	} else if(l_fds[l_fd_array[p->control]].revents & (POLLHUP|POLLERR)) {
+	  remove_fd(ns, p->control);
+	  free_port(ns, nh, p);
+	}
+      }
+    }
+}  
diff -x CVS -x '*~' -u -N -r uml_tools.jig3/uml_router/port.h uml_tools.jig4/uml_router/port.h
--- uml_tools.jig3/uml_router/port.h	Thu Jun  3 15:24:04 2004
+++ uml_tools.jig4/uml_router/port.h	Thu Jun  3 17:09:33 2004
@@ -8,15 +8,65 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 
-extern int handle_port(int fd);
-extern void close_port(int fd);
-extern int setup_sock_port(int fd, struct sockaddr_un *name, int data_fd);
-extern int setup_port(int fd, void (*sender)(int fd, void *packet, int len, 
-					     void *data), void *data, 
-		      int data_len);
-extern void handle_tap_data(int fd, int hub);
-extern void handle_sock_data(int fd, int hub);
-extern void new_port(int fd, int data_fd);
+struct netjig_state;
+struct nethub;
+struct port;
+struct packet;
 
+typedef void (*packet_sender)(int fd, void *packet, int len, void *data);
+
+/* in port.c */
+extern void handle_sock_data(struct netjig_state *ns,
+			     struct nethub *nh);
+extern void handle_tap_data(struct netjig_state *ns,
+			    struct nethub  *nh);
+
+extern void handle_port(struct netjig_state *ns,
+			struct nethub       *nh,
+			struct pollfd  *l_fds,
+			int             l_nfds,
+			int            *l_fd_array,
+			int             l_fd_array_size);
+
+extern void handle_data(struct netjig_state *ns,
+			struct nethub *nh,
+			struct packet *packet, int len,
+			int   fd,
+			void *data, int (*matcher)(int port_fd, int data_fd, 
+						   void *port_data,
+						   int port_data_len, 
+						   void *data));
+
+void insert_data(struct netjig_state *ns,
+		 struct nethub *nh,
+		 struct packet *packet, int len);
+
+
+extern void close_port(struct netjig_state *ns,
+		       struct nethub       *nh,
+		       int fd);
+extern int setup_sock_port(struct netjig_state *ns,
+			   struct nethub       *nh,
+			   struct port        *port,
+			   struct sockaddr_un *name);
+
+extern void setup_port(struct netjig_state *ns,
+		       struct nethub       *nh,
+		       struct port         *port,
+		       int fd,
+		       void (*sender)(int fd, void *packet, int len, 
+				      void *data),
+		       void *data, int data_len);
+
+extern struct port *alloc_port(struct netjig_state *ns,
+			       struct nethub       *nh);
+
+
+extern int setup_sock_tap(struct netjig_state *ns,
+			  struct nethub       *nh,
+			  int    fd,
+			  packet_sender        tap_sender);
+
+extern void accept_connection(struct netjig_state *ns, struct nethub *nh);
 
 #endif
Binary files uml_tools.jig3/uml_router/port.o and uml_tools.jig4/uml_router/port.o differ
diff -x CVS -x '*~' -u -N -r uml_tools.jig3/uml_router/tuntap.c uml_tools.jig4/uml_router/tuntap.c
--- uml_tools.jig3/uml_router/tuntap.c	Thu Jun  3 15:24:04 2004
+++ uml_tools.jig4/uml_router/tuntap.c	Thu Jun  3 17:09:34 2004
@@ -6,6 +6,8 @@
 #include <sys/ioctl.h>
 #include <net/if.h>
 #include <linux/if_tun.h>
+
+#include "nethub.h"
 #include "port.h"
 
 static void send_tap(int fd, void *packet, int len, void *unused)
@@ -18,7 +20,9 @@
   }
 }
 
-int open_tap(char *dev)
+int open_tap(struct netjig_state *ns,
+	     struct nethub *nh,
+	     char *dev)
 {
   struct ifreq ifr;
   int fd, err;
@@ -35,8 +39,12 @@
     close(fd);
     return(-1);
   }
-  err = setup_port(fd, send_tap, NULL, 0);
+
+  err = setup_sock_tap(ns, nh, fd, send_tap);
   if(err) return(err);
+
+  add_fd(ns, fd);
+
   return(fd);
 }
 
diff -x CVS -x '*~' -u -N -r uml_tools.jig3/uml_router/tuntap.h uml_tools.jig4/uml_router/tuntap.h
--- uml_tools.jig3/uml_router/tuntap.h	Thu Jun  3 15:24:04 2004
+++ uml_tools.jig4/uml_router/tuntap.h	Thu Jun  3 17:09:34 2004
@@ -5,7 +5,10 @@
 #ifndef __TUNTAP_H__
 #define __TUNTAP_H__
 
-extern int open_tap(char *dev);
+extern int open_tap(struct netjig_state *ns,
+		    struct nethub *nh,
+		    char *dev);
+
 extern void handle_tap(int fd, int hub);
 
 #endif
Binary files uml_tools.jig3/uml_router/tuntap.o and uml_tools.jig4/uml_router/tuntap.o differ
Binary files uml_tools.jig3/uml_router/uml_switch and uml_tools.jig4/uml_router/uml_switch differ
diff -x CVS -x '*~' -u -N -r uml_tools.jig3/uml_router/uml_switch.c uml_tools.jig4/uml_router/uml_switch.c
--- uml_tools.jig3/uml_router/uml_switch.c	Thu Jun  3 15:24:04 2004
+++ uml_tools.jig4/uml_router/uml_switch.c	Thu Jun  3 17:09:34 2004
@@ -7,12 +7,14 @@
 #include <stdlib.h>
 #include <signal.h>
 #include <fcntl.h>
-#include <stdint.h>
+#include <unistd.h>
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <sys/poll.h>
 #include <sys/time.h>
 #include <unistd.h>
+
+#include "nethub.h"
 #include "switch.h"
 #include "port.h"
 #include "hash.h"
@@ -20,74 +22,128 @@
 #include "tuntap.h"
 #endif
 
-#include "nethub.h"
 
 #ifdef notdef
 #include <stddef.h>
 #endif
 
-static int hub = 0;
-static int compat_v0 = 0;
-char *prog;
+static char *ctl_socket = "/tmp/uml.ctl";
+static char *data_socket = NULL;
 
-char *ctl_socket = "/tmp/uml.ctl";
+char *progname;
 
-char *data_socket = NULL;
-struct sockaddr_un data_sun;
+static struct nethub *global_nh = NULL;
+static struct netjig_state *global_ns=NULL;
+
+static void cleanup(void)
+{
+  if(global_nh) {
+    cleanup_nh(global_nh);
+  }
+}
 
 static void sig_handler(int sig)
 {
-  printf("Caught signal %d, cleaning up and exiting\n", sig);
+  fprintf(stderr, "Caught signal %d, cleaning up and exiting\n", sig);
   cleanup();
   signal(sig, SIG_DFL);
   kill(getpid(), sig);
 }
 
-static void Usage(void)
+void *xmalloc1(size_t size, char *file, int linenum)
 {
-  char *tap_str = "";
+	void *space;
 
-#ifdef TUNTAP
-  tap_str = "[ -tap tap-device ]";
-#endif
+	space = malloc(size);
+	if(space == NULL) {
+		fprintf(stderr, "no memory allocating %d bytes at %s:%d\n",
+			size, file, linenum);
+		exit(1);
+	}
+	return space;
+}
 
-  fprintf(stderr, "Usage : %s [ -unix control-socket ] [ -hub ] %s\n"
-	  "or : %s -compat-v0 [ -unix control-socket data-socket ] "
-	  "[ -hub ] %s\n", prog, tap_str, prog, tap_str);
 
+static void Usage(void)
+{
+  fprintf(stderr, "Usage : %s [ -unix control-socket ] [ -hub ]\n"
+	  "or : %s -compat-v0 [ -unix control-socket data-socket ] [ -hub ]\n"
+	  "or : %s -name switch [ -hub ]\n",
+	  progname, progname, progname);
   exit(1);
 }
 
+static void sig_alarm(int sig)
+{
+  struct itimerval it;
+
+  hash_periodic(global_nh);
+
+  it.it_value.tv_sec = GC_INTERVAL;
+  it.it_value.tv_usec = 0 ;
+  it.it_interval.tv_sec = 0;
+  it.it_interval.tv_usec = 0 ;
+  setitimer(ITIMER_REAL, &it, NULL);
+}
+
+void hash_timer_init()
+{
+  struct sigaction sa;
+
+  sa.sa_handler = sig_alarm;
+  sa.sa_flags = SA_RESTART;
+  if(sigaction(SIGALRM, &sa, NULL) < 0){
+    perror("Setting handler for SIGALRM");
+    return;
+  }
+  kill(getpid(), SIGALRM);
+}
+
 int main(int argc, char **argv)
 {
-  int connect_fd, data_fd, n, i, new, one = 1, daemonize = 0;
+  int hub, compat_v0;
+  int n, i;
   char *tap_dev = NULL;
-#ifdef TUNTAP
-  int tap_fd  = -1;
-#endif
+  char *home;
+  char *switchname;
+  int            *l_fd_array;
+  int             l_fd_array_size;  /* so we can grow it in add_fd() */
+  struct pollfd  *l_fds;        /* array of input sources */
+  int             l_nfds;       /* number of relevant entries */
+
+  hub = 0;
+  compat_v0=0;
+  switchname="switch";
+
+  global_ns = malloc(sizeof(*global_ns));
+  memset(global_ns, 0, sizeof(*global_ns));
+  TAILQ_INIT(&global_ns->switches);
 
-  prog = argv[0];
+  progname = argv[0];
   argv++;
   argc--;
   while(argc > 0){
     if(!strcmp(argv[0], "-unix")){
-      if(argc < 2) 
-	Usage();
+      if(argc < 2) Usage();
       ctl_socket = argv[1];
       argc -= 2;
       argv += 2;
-      if(!compat_v0) 
-	continue;
-      if(argc < 1) 
-	Usage();
+      if(!compat_v0) break;
+      if(argc < 1) Usage();
       data_socket = argv[0];
       argc--;
       argv++;
     }
+    else if(!strcmp(argv[0], "-name")){
+      if(argc < 2) Usage();
+      switchname = argv[1];
+      ctl_socket=NULL;
+      data_socket=NULL;
+      argc -= 2;
+      argv += 2;
+    }
     else if(!strcmp(argv[0], "-tap")){
 #ifdef TUNTAP
-      if(argc < 2) 
-	Usage();
       tap_dev = argv[1];
       argv += 2;
       argc -= 2;
@@ -97,7 +153,7 @@
 #endif      
     }
     else if(!strcmp(argv[0], "-hub")){
-      printf("%s will be a hub instead of a switch\n", prog);
+      printf("%s will be a hub instead of a switch\n", progname);
       hub = 1;
       argc--;
       argv++;
@@ -109,91 +165,85 @@
       argc--;
       argv++;
     }
-    else if(!strcmp(argv[0], "-daemon")){
-      daemonize = 1;
-      argc--;
-      argv++;
-    }
     else Usage();
   }
 
-  if((connect_fd = socket(PF_UNIX, SOCK_STREAM, 0)) < 0){
-    perror("socket");
-    exit(1);
-  }
-  if(setsockopt(connect_fd, SOL_SOCKET, SO_REUSEADDR, (char *) &one, 
-		sizeof(one)) < 0){
-    perror("setsockopt");
-    exit(1);
-  }
-  if(fcntl(connect_fd, F_SETFL, O_NONBLOCK) < 0){
-    perror("Setting O_NONBLOCK on connection fd");
-    exit(1);
-  }
-  if((data_fd = socket(PF_UNIX, SOCK_DGRAM, 0)) < 0){
-    perror("socket");
-    exit(1);
-  }
-  if(fcntl(data_fd, F_SETFL, O_NONBLOCK) < 0){
-    perror("Setting O_NONBLOCK on data fd");
-    exit(1);
-  }
-
-  if(compat_v0) bind_sockets_v0(connect_fd, ctl_socket, data_fd, data_socket);
-  else bind_sockets(connect_fd, ctl_socket, data_fd);
-
-  if(listen(connect_fd, 15) < 0){
-    perror("listen");
-    exit(1);
+  /* set socket base dir to $HOME/.uml, defaulting back to /tmp/uml,
+   * if $HOME is not set.
+   */
+  if((home=getenv("HOME"))==NULL) {
+    global_ns->socketbasedir="/tmp/uml";
+  } else {
+    global_ns->socketbasedir=xmalloc(strlen(home)+1+sizeof(".umlnet")+1);
+    sprintf(global_ns->socketbasedir,
+	    "%s/.umlnet", home);
   }
 
+  global_nh = init_nethub(global_ns,
+			  switchname,
+			  ctl_socket,
+			  data_socket,
+			  compat_v0);
+  global_nh->nh_hub = hub;
+  
   if(signal(SIGINT, sig_handler) < 0)
     perror("Setting handler for SIGINT");
-  hash_init();
+  hash_timer_init();
 
   if(compat_v0) 
-    printf("%s attached to unix sockets '%s' and '%s'", prog, ctl_socket,
-	   data_socket);
-  else printf("%s attached to unix socket '%s'", prog, ctl_socket);
+    printf("%s attached to unix sockets '%s' and '%s'\n",
+ 	   progname,
+	   global_nh->ctl_socket_name,
+	   (global_nh->data_socket_name ?
+	    global_nh->data_socket_name : "-abstract-named-"));
+  else printf("%s attached to unix socket '%s'\n",
+	      progname,
+	      global_nh->ctl_socket_name);
 
-#ifdef TUNTAP
-  if(tap_dev != NULL)
-    printf(" tap device '%s'", tap_dev);
-#endif
-  printf("\n");
-
-  if(isatty(0))
-    add_fd(0);
-  add_fd(connect_fd);
-  add_fd(data_fd);
+  if(isatty(0)) add_fd(global_ns, 0);
 
 #ifdef TUNTAP
-  if(tap_dev != NULL) tap_fd = open_tap(tap_dev);
-  if(tap_fd > -1) add_fd(tap_fd);
+  if(tap_dev != NULL) {
+    global_nh->tap_fd = open_tap(global_ns, global_nh, tap_dev);
+  }
 #endif
 
-  if (daemonize && daemon(0, 1)) {
-    perror("daemon");
-    exit(1);
-  }
+  l_fd_array = NULL;
+  l_fd_array_size = 0;
+  l_fds = NULL;
+  l_nfds= 0;
 
   while(1){
     char buf[128];
 
-    n = poll(fds, nfds, -1);
+    /*
+     * we need to allocate a local copy of the arrays to use!
+     * since we are going to modify the arrays based upon I/O
+     */
+    if(l_nfds != global_ns->nfds) {
+	    l_nfds = global_ns->nfds;
+	    l_fds = realloc(l_fds, l_nfds * sizeof(struct pollfd));
+    }
+    memcpy(l_fds,      global_ns->fds,      l_nfds * sizeof(struct pollfd));
+    if(l_fd_array_size != global_ns->fd_array_size) {
+	    l_fd_array_size = global_ns->fd_array_size;
+	    l_fd_array = realloc(l_fd_array, l_fd_array_size*sizeof(int));
+    }
+    memcpy(l_fd_array, global_ns->fd_array, l_fd_array_size * sizeof(int));
+    
+    n = poll(l_fds, l_nfds, -1);
     if(n < 0){
       if(errno == EINTR) continue;
       perror("poll");
       break;
     }
-    for(i = 0; i < nfds; i++){
-      if(fds[i].revents == 0) continue;
-      if(fds[i].fd == 0){
-	if(fds[i].revents & POLLHUP){
+    for(i = 0; i < l_nfds; i++){
+      if(l_fds[i].revents == 0) continue;
+      if(l_fds[i].fd == 0){
+	if(l_fds[i].revents & POLLHUP){
 	  printf("EOF on stdin, cleaning up and exiting\n");
 	  goto out;
 	}
-
 	n = read(0, buf, sizeof(buf));
 	if(n < 0){
 	  perror("Reading from stdin");
@@ -204,21 +254,25 @@
 	  goto out;
 	}
       }
-      else if(fds[i].fd == connect_fd){
-	if(fds[i].revents & POLLHUP){
+      else if(l_fds[i].fd == global_nh->ctl_listen_fd){
+	if(l_fds[i].revents & POLLHUP){
 	  printf("Error on connection fd\n");
 	  continue;
 	}
-	accept_connection(connect_fd);
+	accept_connection(global_ns, global_nh);
+      }
+      else if(l_fds[i].fd == global_nh->data_fd) {
+	handle_sock_data(global_ns, global_nh);
       }
-      else if(fds[i].fd == data_fd) handle_sock_data(data_fd, hub);
 #ifdef TUNTAP
-      else if(fds[i].fd == tap_fd) handle_tap_data(tap_fd, hub);
+      else if(l_fds[i].fd == global_nh->tap_fd) {
+	handle_tap_data(global_ns, global_nh);
+      }
 #endif
       else {
-	new = handle_port(fds[i].fd);
-	if(new) new_port(fds[i].fd, data_fd);
-	else close_descriptor(fds[i].fd);
+	handle_port(global_ns, global_nh,
+		    l_fds, l_nfds,
+		    l_fd_array, l_fd_array_size);
       }
     }
   }
Binary files uml_tools.jig3/uml_router/uml_switch.o and uml_tools.jig4/uml_router/uml_switch.o differ


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
