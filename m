Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZ0J7-000781-BM for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Nov 2004 21:12:09 -0800
Received: from bay24-f18.bay24.hotmail.com ([64.4.18.68] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CZ0J7-0007yM-5A for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Nov 2004 21:12:09 -0800
Message-ID: <BAY24-F18CD7435AB94FE5A10013283BE0@phx.gbl>
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_61e1_5bfc_3380"
Subject: [uml-devel] [PATCH] uml_router: cleanup #2
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
Date: Tue, 30 Nov 2004 05:11:01 +0000
To: User-mode-linux-devel@lists.sourceforge.net
Cc: kraxel@bytesex.org, uml@uxu.ch

This is a multi-part message in MIME format.

------=_NextPart_000_61e1_5bfc_3380
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by nerdnet.nl id
	iAU5DJwe001485

These patches to uml_router/uml_switch continue from my previous post:

Patch 7 removes the port and MAC code in preparation for new files based =
on=20
Gerd Knorr's improved switch implementation.

Patch 8 just adds the new port and MAC files, along with list.h (shameles=
sly=20
stolen, of course).  The hash based MAC handling of the old system has be=
en=20
retained (it was on Gerd's wish list).

Patch 9 switches everything over to the new system.  IO management is now=
=20
the responsibility of the packet drivers, where it should be.

Patch 10 fixes a couple of fdpoll issues:  modifying event masks on the f=
ly,=20
and *not* retrying an interrupted poll() call.

Patch 11 turns on the packet queue for the tuntap driver.  For technical=20
reasons, it's just too much work to implement on the current sockunix=20
driver.

Patch 12 adds in a simple timer system to support MAC expiry.  I am amaze=
d=20
that the old SIGALRM based system doesn't segfault -- all that list=20
manipulation goin on during interrupt calls can't be safe.

Patch 13 adds another goody from Gerd: pidfile support.

Patch 14 is a fun little UDP packet driver inspired by Felix M=FCri for=20
connecting multiple UMLs together.  It's inherently unsecure so you must=20
uncomment the driver in the makefile if you want to play with it.  Then y=
ou=20
can simply add -udpport <port> and -udpremote <host> arguments to two or=20
more uml switches and watch the packets fly.  As a weak form of security,=
=20
unless you add -udppublic to the command line, then packets not matching =
the=20
specified hosts will be dropped on the floor.  Beware, there is nothing=20
stopping you from creating loops or other weird network topologies. :)  G=
RE=20
tunneling might be the proper way.

I've tested the program by FTPing a linux source tar file between two uml=
=20
guests on the same single-processor host, and found no discernible=20
difference from the same test with the old program.  And assuming I didn'=
t=20
goof (heh), I'm finished with changes for now -- unless I find some time =
to=20
play or funding. :)

Enjoy!

Steve Schmidtke


------=_NextPart_000_61e1_5bfc_3380
Content-Type: text/plain; name="uml_router-7.txt"; format=flowed
Content-Disposition: attachment; filename="uml_router-7.txt"
Content-Transfer-Encoding: 8bit

diff -Naur uml_router.old/hash.c uml_router/hash.c
--- uml_router.old/hash.c	Sat Apr 27 11:42:04 2002
+++ uml_router/hash.c	Wed Dec 31 19:00:00 1969
@@ -1,175 +0,0 @@
-/* Copyright 2002 Yon Uriarte and Jeff Dike
- * Licensed under the GPL
- */
-
-#include <stddef.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include <time.h>
-#include <sys/types.h>
-#include <sys/time.h>
-#include <sys/signal.h>
-#include "switch.h"
-#include "hash.h"
-
-#define HASH_SIZE 128
-#define HASH_MOD 11
-
-struct hash_entry {
-  struct hash_entry *next;
-  struct hash_entry *prev;
-  time_t last_seen;
-  void *port;
-  unsigned char dst[ETH_ALEN];
-};
-
-static struct hash_entry *h[HASH_SIZE];
-
-static int calc_hash(char *src)
-{
-  return ((*(u_int32_t *) &src[0] % HASH_MOD) ^ src[4] ^ src[5] ) % 
HASH_SIZE ;
-}
-
-static struct hash_entry *find_entry(char *dst)
-{
-  struct hash_entry *e;
-  int k = calc_hash(dst);
-
-  for(e = h[k]; e; e = e->next){
-    if(!memcmp(&e->dst, dst, ETH_ALEN)) return(e);
-  }
-  return(NULL);
-}
-
-void *find_in_hash(char *dst)
-{
-  struct hash_entry *e = find_entry(dst);
-  if(e == NULL) return(NULL);
-  return(e->port);
-}
-
-void insert_into_hash(char *src, void *port)
-{
-  struct hash_entry *new;
-  int k = calc_hash(src);
-
-  new = find_in_hash(src);
-  if(new != NULL) return;
-
-  new = malloc(sizeof(*new));
-  if(new == NULL){
-    perror("Failed to malloc hash entry");
-    return;
-  }
-
-  memcpy(&new->dst, src, ETH_ALEN );
-  if(h[k] != NULL) h[k]->prev = new;
-  new->next = h[k];
-  new->prev = NULL;
-  new->port = port;
-  new->last_seen = 0;
-  h[k] = new;
-}
-
-void update_entry_time(char *src)
-{
-  struct hash_entry *e;
-
-  e = find_entry(src);
-  if(e == NULL) return;
-  e->last_seen = time(NULL);
-}
-
-static void delete_hash_entry(struct hash_entry *old)
-{
-  int k = calc_hash(old->dst);
-
-  if(old->prev != NULL) old->prev->next = old->next;
-  if(old->next != NULL) old->next->prev = old->prev;
-  if(h[k] == old) h[k] = old->next;
-  free(old);
-}
-
-void delete_hash(char *dst)
-{
-  struct hash_entry *old = find_entry(dst);
-
-  if(old == NULL) return;
-  delete_hash_entry(old);
-}
-
-static void for_all_hash(void (*f)(struct hash_entry *, void *), void *arg)
-{
-  int i;
-  struct hash_entry *e, *next;
-
-  for(i = 0; i < HASH_SIZE; i++){
-    for(e = h[i]; e; e = next){
-      next = e->next;
-      (*f)(e, arg);
-    }
-  }
-}
-
-struct printer {
-  time_t now;
-  char *(*port_id)(void *);
-};
-
-static void print_hash_entry(struct hash_entry *e, void *arg)
-{
-  struct printer *p = arg;
-
-  printf("Hash: %d Addr: %02x:%02x:%02x:%02x:%02x:%02x to port: %s  "
-	 "age %ld secs\n", calc_hash(e->dst),
-	 e->dst[0], e->dst[1], e->dst[2], e->dst[3], e->dst[4], e->dst[5],
-	 (*p->port_id)(e->port), (int) p->now - e->last_seen);
-}
-
-void print_hash(char *(*port_id)(void *))
-{
-  struct printer p = ((struct printer) { now : 		time(NULL),
-					 port_id :	port_id });
-
-  for_all_hash(print_hash_entry, &p);
-}
-
-#define GC_INTERVAL 2
-#define GC_EXPIRE 100
-
-static void gc(struct hash_entry *e, void *now)
-{
-  time_t t = *(time_t *) now;
-
-  if(e->last_seen + GC_EXPIRE < t)
-    delete_hash_entry(e);
-}
-
-static void sig_alarm(int sig)
-{
-  struct itimerval it;
-  time_t t = time(NULL);
-  for_all_hash(&gc, &t);
-
-  it.it_value.tv_sec = GC_INTERVAL;
-  it.it_value.tv_usec = 0 ;
-  it.it_interval.tv_sec = 0;
-  it.it_interval.tv_usec = 0 ;
-  setitimer(ITIMER_REAL, &it, NULL);
-}
-
-void hash_init(void)
-{
-  struct sigaction sa;
-
-  sa.sa_handler = sig_alarm;
-  sa.sa_flags = SA_RESTART;
-  if(sigaction(SIGALRM, &sa, NULL) < 0){
-    perror("Setting handler for SIGALRM");
-    return;
-  }
-  kill(getpid(), SIGALRM);
-}
diff -Naur uml_router.old/hash.h uml_router/hash.h
--- uml_router.old/hash.h	Tue Apr  9 10:38:23 2002
+++ uml_router/hash.h	Wed Dec 31 19:00:00 1969
@@ -1,15 +0,0 @@
-/* Copyright 2002 Yon Uriarte and Jeff Dike
- * Licensed under the GPL
- */
-
-#ifndef __HASH_H__
-#define __HASH_H__
-
-extern void *find_in_hash(char *dst);
-extern void insert_into_hash(char *src, void *port);
-extern void delete_hash(char *dst);
-extern void print_hash(char *(*port_id)(void *));
-extern void update_entry_time(char *src);
-extern void hash_init(void);
-
-#endif
diff -Naur uml_router.old/port.c uml_router/port.c
--- uml_router.old/port.c	Wed Nov 24 17:28:47 2004
+++ uml_router/port.c	Wed Dec 31 19:00:00 1969
@@ -1,166 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-#include "switch.h"
-#include "hash.h"
-#include "port.h"
-
-struct port {
-  struct port *next;
-  struct port *prev;
-  int control;
-  void *data;
-  int data_len;
-  unsigned char src[ETH_ALEN];
-  void (*sender)(int fd, void *packet, int len, void *data);
-};
-
-static struct port *head = NULL;
-
-#define IS_BROADCAST(addr) ((addr[0] & 1) == 1)
-
-static void free_port(struct port *port)
-{
-  if(port->prev) port->prev->next = port->next;
-  else head = port->next;
-  if(port->next) port->next->prev = port->prev;
-  free(port);
-}
-
-void close_port(int fd)
-{
-  struct port *port;
-
-  for(port = head; port != NULL; port = port->next){
-    if(port->control == fd) break;
-  }
-  if(port == NULL){
-    fprintf(stderr, "No port associated with descriptor %d\n", fd);
-    return;
-  }
-  delete_hash(port->src);
-  free_port(port);
-}
-
-static void update_src(struct port *port, struct packet *p)
-{
-  struct port *last;
-
-  /* We don't like broadcast source addresses */
-  if(IS_BROADCAST(p->header.src)) return;
-
-  last = find_in_hash(p->header.src);
-
-  if(port != last){
-    /* old value differs from actual input port */
-
-    printf(" Addr: %02x:%02x:%02x:%02x:%02x:%02x New port %d",
-	   p->header.src[0], p->header.src[1], p->header.src[2],
-	   p->header.src[3], p->header.src[4], p->header.src[5],
-	   port->control);
-
-    if(last != NULL){
-      printf(" old port %d", last->control);
-      delete_hash(p->header.src);
-    }
-    printf("\n");
-
-    memcpy(port->src, p->header.src, sizeof(port->src));
-    insert_into_hash(p->header.src, port);
-  }
-  update_entry_time(p->header.src);
-}
-
-static void send_dst(struct port *port, struct packet *packet, int len,
-		     int hub)
-{
-  struct port *target, *p;
-
-  target = find_in_hash(packet->header.dest);
-  if((target == NULL) || IS_BROADCAST(packet->header.dest) || hub){
-    if((target == NULL) && !IS_BROADCAST(packet->header.dest)){
-      printf("unknown Addr: %02x:%02x:%02x:%02x:%02x:%02x from port ",
-	     packet->header.src[0], packet->header.src[1],
-	     packet->header.src[2], packet->header.src[3],
-	     packet->header.src[4], packet->header.src[5]);
-      if(port == NULL) printf("UNKNOWN\n");
-      else printf("%d\n", port->control);
-    }
-
-    /* no cache or broadcast/multicast == all ports */
-    for(p = head; p != NULL; p = p->next){
-      /* don't send it back the port it came in */
-      if(p == port) continue;
-
-      (*p->sender)(p->control, packet, len, p->data);
-    }
-  }
-  else (*target->sender)(target->control, packet, len, target->data);
-}
-
-void handle_data(int fd, int hub, struct packet *packet, int len, void 
*data,
-		 int (*matcher)(int port_fd, int data_fd, void *port_data,
-				int port_data_len, void *data))
-{
-  struct port *p;
-
-  for(p = head; p != NULL; p = p->next){
-    if((*matcher)(p->control, fd, p->data, p->data_len, data)) break;
-  }
-
-  /* if we have an incoming port (we should) */
-  if(p != NULL) update_src(p, packet);
-  else printf("Unknown connection for packet, shouldn't happen.\n");
-
-  send_dst(p, packet, len, hub);
-}
-
-int setup_port(int fd, void (*sender)(int fd, void *packet, int len,
-				      void *data), void *data, int data_len)
-{
-  struct port *port;
-
-  port = malloc(sizeof(struct port));
-  if(port == NULL){
-    perror("malloc");
-    return(-1);
-  }
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
-}
-
-static void service_port(struct port *port)
-{
-  int n;
-  char c;
-
-  n = read(port->control, &c, sizeof(c));
-  if(n < 0) perror("Reading request");
-  else if(n == 0) printf("Disconnect\n");
-  else printf("Bad request\n");
-}
-
-int handle_port(int fd)
-{
-  struct port *p;
-
-  for(p = head; p != NULL; p = p->next){
-    if(p->control == fd){
-      service_port(p);
-      return(0);
-    }
-  }
-  return(1);
-}
-
diff -Naur uml_router.old/port.h uml_router/port.h
--- uml_router.old/port.h	Wed Nov 24 17:28:47 2004
+++ uml_router/port.h	Wed Dec 31 19:00:00 1969
@@ -1,22 +0,0 @@
-/* Copyright 2002 Jeff Dike
- * Licensed under the GPL
- */
-
-#ifndef __PORT_H__
-#define __PORT_H__
-
-#include <sys/socket.h>
-#include <sys/un.h>
-
-extern int handle_port(int fd);
-extern void handle_data(int fd, int hub, struct packet *packet, int len,
-			void *data, int (*matcher)(int port_fd, int data_fd,
-						   void *port_data,
-						   int port_data_len,
-						   void *data));
-extern void close_port(int fd);
-extern int setup_port(int fd, void (*sender)(int fd, void *packet, int len,
-					     void *data), void *data,
-		      int data_len);
-
-#endif


------=_NextPart_000_61e1_5bfc_3380
Content-Type: text/plain; name="uml_router-8.txt"; format=flowed
Content-Disposition: attachment; filename="uml_router-8.txt"
Content-Transfer-Encoding: 8bit

diff -Naur uml_router.old/list.h uml_router/list.h
--- uml_router.old/list.h	Wed Dec 31 19:00:00 1969
+++ uml_router/list.h	Sun Nov 28 15:45:15 2004
@@ -0,0 +1,169 @@
+#ifndef _LIST_H
+#define _LIST_H 1
+
+/*
+ * Simple doubly linked list implementation.
+ *	-- shameless stolen from the linux kernel sources
+ *
+ * Some of the internal functions ("__xxx") are useful when
+ * manipulating whole lists rather than single entries, as
+ * sometimes we already know the next/prev entries and we can
+ * generate better code by using them directly rather than
+ * using the generic single-entry routines.
+ */
+
+struct list_head {
+	struct list_head *next, *prev;
+};
+
+#define LIST_HEAD_INIT(name) { &(name), &(name) }
+
+#define LIST_HEAD(name) \
+	struct list_head name = LIST_HEAD_INIT(name)
+
+#define INIT_LIST_HEAD(ptr) do { \
+	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
+} while (0)
+
+/*
+ * Insert a item entry between two known consecutive entries.
+ *
+ * This is only for internal list manipulation where we know
+ * the prev/next entries already!
+ */
+static __inline__ void __list_add(struct list_head * item,
+	struct list_head * prev,
+	struct list_head * next)
+{
+	next->prev = item;
+	item->next = next;
+	item->prev = prev;
+	prev->next = item;
+}
+
+/**
+ * list_add - add a item entry
+ * @item: item entry to be added
+ * @head: list head to add it after
+ *
+ * Insert a item entry after the specified head.
+ * This is good for implementing stacks.
+ */
+static __inline__ void list_add(struct list_head *item, struct list_head 
*head)
+{
+	__list_add(item, head, head->next);
+}
+
+/**
+ * list_add_tail - add a item entry
+ * @item: item entry to be added
+ * @head: list head to add it before
+ *
+ * Insert a item entry before the specified head.
+ * This is useful for implementing queues.
+ */
+static __inline__ void list_add_tail(struct list_head *item, struct 
list_head *head)
+{
+	__list_add(item, head->prev, head);
+}
+
+/*
+ * Delete a list entry by making the prev/next entries
+ * point to each other.
+ *
+ * This is only for internal list manipulation where we know
+ * the prev/next entries already!
+ */
+static __inline__ void __list_del(struct list_head * prev,
+				  struct list_head * next)
+{
+	next->prev = prev;
+	prev->next = next;
+}
+
+/**
+ * list_del - deletes entry from list.
+ * @entry: the element to delete from the list.
+ * Note: list_empty on entry does not return true after this, the entry is 
in an undefined state.
+ */
+static __inline__ void list_del(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+}
+
+/**
+ * list_del_init - deletes entry from list and reinitialize it.
+ * @entry: the element to delete from the list.
+ */
+static __inline__ void list_del_init(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+	INIT_LIST_HEAD(entry);
+}
+
+/**
+ * list_empty - tests whether a list is empty
+ * @head: the list to test.
+ */
+static __inline__ int list_empty(struct list_head *head)
+{
+	return head->next == head;
+}
+
+/**
+ * list_splice - join two lists
+ * @list: the item list to add.
+ * @head: the place to add it in the first list.
+ */
+static __inline__ void list_splice(struct list_head *list, struct list_head 
*head)
+{
+	struct list_head *first = list->next;
+
+	if (first != list) {
+		struct list_head *last = list->prev;
+		struct list_head *at = head->next;
+
+		first->prev = head;
+		head->next = first;
+
+		last->next = at;
+		at->prev = last;
+	}
+}
+
+/**
+ * list_entry - get the struct for this entry
+ * @ptr:	the &struct list_head pointer.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_entry(ptr, type, member) \
+	((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
+
+/**
+ * list_for_each	-	iterate over a list
+ * @pos:	the &struct list_head to use as a loop counter.
+ * @head:	the head for your list.
+ */
+#define list_for_each(pos, head) \
+	for (pos = (head)->next; pos != (head); pos = pos->next)
+
+/**
+ * list_for_each_safe	-	iterate over a list safe against removal of list 
entry
+ * @pos:	the &struct list_head to use as a loop counter.
+ * @n:		another &struct list_head to use as temporary storage
+ * @head:	the head for your list.
+ */
+#define list_for_each_safe(pos, n, head) \
+	for (pos = (head)->next, n = pos->next; pos != (head); \
+		pos = n, n = pos->next)
+
+/**
+ * list_for_each_prev	-	iterate over a list in reverse order
+ * @pos:	the &struct list_head to use as a loop counter.
+ * @head:	the head for your list.
+ */
+#define list_for_each_prev(pos, head) \
+	for (pos = (head)->prev; pos != (head); pos = pos->prev)
+
+#endif /* _LIST_H */
diff -Naur uml_router.old/mac.c uml_router/mac.c
--- uml_router.old/mac.c	Wed Dec 31 19:00:00 1969
+++ uml_router/mac.c	Sun Nov 28 15:47:11 2004
@@ -0,0 +1,200 @@
+/* Copyright 2004 Steve Schmidtke
+ * Based on work done by Gerd Knorr, Yon Uriarte, and Jeff Dike
+ * Licensed under the GPL
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include "switch.h"
+#include "list.h"
+
+struct mac {
+    struct list_head   list;
+    unsigned char      addr[ETH_ALEN];
+    time_t             seen;
+    void*              userdata;
+};
+
+#define HASH_SIZE 128
+#define HASH_MOD 11
+
+static struct list_head macs[HASH_SIZE];
+
+/* (debug) messages */
+static int dbg_mac = 0;
+
+/* settings */
+static int  expire      = 300;
+
+/* callback to get userdata label */
+static char* (*userdata_ident)(void* data);
+
+/* this is used if no other ident routine sepecified */
+static char* default_labeler(void* data)
+{
+  return("unknown");
+}
+
+static unsigned int calc_hash(unsigned char *addr)
+{
+  return ((*(u_int32_t *) &addr[0] % HASH_MOD) ^ addr[4] ^ addr[5] ) % 
HASH_SIZE ;
+}
+
+static struct mac* mac_find(unsigned char* addr)
+{
+  struct list_head* lhed = &macs[calc_hash(addr)];
+  struct list_head* lptr;
+
+  list_for_each(lptr, lhed) {
+    struct mac *m = list_entry(lptr, struct mac, list);
+
+    if (memcmp(&m->addr, addr, ETH_ALEN) == 0) return(m);
+  }
+
+  return(NULL);
+}
+
+void* mac_userdata(unsigned char* addr)
+{
+  struct mac* mac;
+
+  /* bcast dest -- we will not find that in the mac register ... */
+  if (addr[0] & 1)
+	return NULL;
+
+  mac = mac_find(addr);
+  if (mac == NULL) {
+    if (dbg_mac > 1) {
+	fprintf(stderr,
+		"mac %02x:%02x:%02x:%02x:%02x:%02x not found\n",
+		 addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
+    }
+    return(NULL);
+  }
+
+  if (dbg_mac > 1) {
+    fprintf(stderr,
+	    "mac %02x:%02x:%02x:%02x:%02x:%02x is at port %s\n",
+	    addr[0], addr[1], addr[2], addr[3], addr[4], addr[5],
+	    userdata_ident(mac->userdata));
+  }
+
+  return(mac->userdata);
+}
+
+int mac_register(unsigned char* addr, void* userdata)
+{
+  struct mac* mac;
+  time_t now = time(NULL);
+
+  /* ignore bcast source addresses */
+  if (addr[0] & 1)
+	return 0;
+
+  mac = mac_find(addr);
+  if (mac) {
+    if (mac->userdata != userdata && dbg_mac) {
+	fprintf(stderr,
+		"mac %02x:%02x:%02x:%02x:%02x:%02x moved: port %s => %s\n",
+		addr[0], addr[1], addr[2], addr[3], addr[4], addr[5],
+	        userdata_ident(mac->userdata), userdata_ident(userdata));
+    }
+    mac->userdata = userdata;
+    mac->seen = now;
+    return 0;
+  }
+
+  if (dbg_mac) {
+    fprintf(stderr,
+	    "mac %02x:%02x:%02x:%02x:%02x:%02x new: port %s\n",
+	    addr[0], addr[1], addr[2], addr[3], addr[4], addr[5],
+	    userdata_ident(userdata));
+  }
+
+  mac = malloc(sizeof(*mac));
+  memset(mac,0,sizeof(*mac));
+  memcpy(mac->addr, addr, ETH_ALEN);
+  mac->userdata = userdata;
+  mac->seen = now;
+  list_add(&mac->list, &macs[calc_hash(addr)]);
+  return 0;
+}
+
+void mac_delall_userdata(void* userdata)
+{
+  int i;
+
+  for(i = 0; i < HASH_SIZE; i++) {
+    struct list_head* lhed = &macs[i];
+    struct list_head* ltmp;
+    struct list_head* lptr;
+
+    list_for_each_safe(lptr, ltmp, lhed) {
+      struct mac* mac = list_entry(lptr, struct mac, list);
+
+      if (userdata != mac->userdata)
+        continue;
+
+      if (dbg_mac) {
+        fprintf(stderr,
+	        "mac %02x:%02x:%02x:%02x:%02x:%02x del: port %s\n",
+		mac->addr[0],mac->addr[1],mac->addr[2],
+		mac->addr[3],mac->addr[4],mac->addr[5],
+	        userdata_ident(mac->userdata));
+      }
+
+      list_del(&mac->list);
+      free(mac);
+    }
+  }
+}
+
+void mac_delall_expired(void)
+{
+  time_t now = time(NULL);
+  static time_t last;
+  int i;
+
+  if (last + expire/4 > now)
+    return;
+  last = now;
+
+  for(i = 0; i < HASH_SIZE; i++) {
+    struct list_head* lhed = &macs[i];
+    struct list_head* ltmp;
+    struct list_head* lptr;
+
+    list_for_each_safe(lptr, ltmp, lhed) {
+      struct mac* mac = list_entry(lptr, struct mac, list);
+
+      if (mac->seen + expire > now)
+        continue;
+
+      if (dbg_mac) {
+        fprintf(stderr,
+		"mac %02x:%02x:%02x:%02x:%02x:%02x del: expired\n",
+		mac->addr[0],mac->addr[1],mac->addr[2],
+		mac->addr[3],mac->addr[4],mac->addr[5]);
+      }
+
+      list_del(&mac->list);
+      free(mac);
+    }
+  }
+}
+
+int mac_init(char* (*labeler)(void* data))
+{
+  int i;
+
+  if(labeler) userdata_ident = labeler;
+  else userdata_ident = default_labeler;
+
+  for(i = 0; i < HASH_SIZE; i++) {
+    INIT_LIST_HEAD(&macs[i]);
+  }
+
+  return(0);
+}
diff -Naur uml_router.old/mac.h uml_router/mac.h
--- uml_router.old/mac.h	Wed Dec 31 19:00:00 1969
+++ uml_router/mac.h	Sun Nov 28 15:45:15 2004
@@ -0,0 +1,14 @@
+/* Copyright 2004 Steve Schmidtke
+ * Based on work done by Gerd Knorr, and others
+ * Licensed under the GPL
+ */
+#ifndef __MAC_H__
+#define __MAC_H__
+
+extern void* mac_userdata(unsigned char* addr);
+extern int mac_register(unsigned char* addr, void* userdata);
+extern void mac_delall_userdata(void* userdata);
+extern void mac_delall_expired(void);
+extern int mac_init(char* (*labeler)(void* data));
+
+#endif
diff -Naur uml_router.old/port.c uml_router/port.c
--- uml_router.old/port.c	Wed Dec 31 19:00:00 1969
+++ uml_router/port.c	Sun Nov 28 15:45:15 2004
@@ -0,0 +1,253 @@
+/* Copyright 2004 Steve Schmidtke
+ * Based on work done by Gerd Knorr, and others
+ * Licensed under the GPL
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+
+#include "switch.h"
+#include "mac.h"
+#include "list.h"
+
+/* 
------------------------------------------------------------------------- */
+
+struct fifo {
+    struct list_head   list;
+    struct packet      packet;
+    int                len;
+};
+
+struct port {
+    struct list_head   list;
+    struct list_head   queue;
+    char*              label;
+    int                qlen;
+    int                dropping;
+    void*              userdata;
+    int                (*on_write)(void* userdata, void *packet, int len);
+    int                (*on_queue)(void* userdata, int drain);
+    void               (*on_release)(void* userdata);
+};
+
+static LIST_HEAD(ports);
+
+/* (debug) messages */
+static int  msg_info    = 0;
+static int  dbg_port    = 0;
+static int  dbg_recv    = 0;
+static int  dbg_send    = 0;
+
+/* settings */
+static int  hub         = 0;
+static int  maxq        = 32;
+
+/* called via mac_* ident request */
+static char* label_port(void* data)
+{
+  struct port *port = data;
+
+  return(port->label);
+}
+
+static int queue_port(struct port *port, struct packet *packet, int len)
+{
+    struct fifo *fifo;
+
+    if (port->qlen >= maxq) {
+	if ((msg_info || dbg_send) && !port->dropping)
+	    fprintf(stderr,"port %s: queue full (%d), start dropping packets\n",
+		    port->label, maxq);
+	port->dropping++;
+	return 0;
+    }
+    fifo = malloc(sizeof(*fifo));
+    memcpy(&fifo->packet,packet,len);
+    fifo->len = len;
+    list_add_tail(&fifo->list,&port->queue);
+    port->qlen++;
+    return 0;
+}
+
+void* port_add(char* label, void* userdata,
+	       int (*on_write)(void* userdata, void *packet, int len),
+	       int (*on_queue)(void* userdata, int drain),
+	       void (*on_release)(void* userdata))
+{
+    struct port *port;
+
+    port = malloc(sizeof(*port));
+    if(port == NULL) return(NULL);
+
+    memset(port,0,sizeof(*port));
+    port->label      = label ? label : "unknown";
+    port->userdata   = userdata;
+    port->on_write   = on_write;
+    port->on_queue   = on_queue;
+    port->on_release = on_release;
+    INIT_LIST_HEAD(&port->queue);
+    list_add_tail(&port->list,&ports);
+    if (dbg_port)
+	fprintf(stderr, "add port %s\n", port->label);
+    return(port);
+}
+
+void port_del(void* data)
+{
+    struct port *port = data;
+    struct fifo *fifo;
+
+    if (dbg_port)
+	fprintf(stderr, "del port %s\n", port->label);
+    mac_delall_userdata(port);
+    while (!list_empty(&port->queue)) {
+	fifo = list_entry(port->queue.next, struct fifo, list);
+	list_del(&fifo->list);
+	free(fifo);
+	port->qlen--;
+    }
+
+    if(port->on_release) {
+        port->on_release(port->userdata);
+    }
+    list_del(&port->list);
+    free(port);
+}
+
+int port_flush(void* data)
+{
+    struct port *port = data;
+    struct fifo *fifo;
+    int written = 0;
+
+    if ((msg_info || dbg_send) && port->dropping)
+	fprintf(stderr,"port %s: stop dropping packets (%d lost)\n",
+		port->label, port->dropping);
+    port->dropping = 0;
+    if (dbg_send)
+	fprintf(stderr, "flush port %s\n", port->label);
+    while (!list_empty(&port->queue)) {
+	fifo = list_entry(port->queue.next, struct fifo, list);
+	switch (port->on_write(port->userdata, &fifo->packet, fifo->len)) {
+	case -1:
+	    /* error */
+	    port_del(port);
+	    return written;
+	case 0:
+	    /* not written - stop here */
+	    return written;
+	default:
+	    /* written - rm from queue */
+	    list_del(&fifo->list);
+	    free(fifo);
+	    port->qlen--;
+	    written++;
+	}
+    }
+
+    /* queue is now empty */
+    if(port->on_queue) {  /* notify user */
+      port->on_queue(port->userdata, 0);
+    }
+
+    return written;
+}
+
+/* 
------------------------------------------------------------------------- */
+
+static void send_port(struct port *oport, struct packet *packet, int len)
+{
+    if (!list_empty(&oport->queue)) {
+	queue_port(oport,packet,len);
+	return;
+    }
+
+    switch (oport->on_write(oport->userdata, packet, len)) {
+    case -1:
+	/* error */
+	port_del(oport);
+	break;
+    case 0:
+	/* not written */
+	if(oport->on_queue) {  /* user can handle draining */
+	  if(oport->on_queue(oport->userdata, 1) < 0) {
+	    if (msg_info || dbg_send) {
+	      fprintf(stderr,"port %s: drain control failed\n",
+		      oport->label);
+	    }
+	  } else { /* All OK, can queue packet */
+	    queue_port(oport, packet, len);
+	  }
+	} /* else drop on floor */
+	break;
+    default:
+	/* written - nothing to do */
+	break;
+    }
+}
+
+static int send_hub(struct port *iport, struct packet *packet, int len)
+{
+    struct list_head *item,*safe;
+    struct port *oport;
+
+    list_for_each_safe(item,safe,&ports) {
+	oport = list_entry(item, struct port, list);
+	if (oport == iport)
+	    continue;
+	send_port(oport, packet, len);
+    }
+    return 0;
+}
+
+static int send_switch(struct port *iport, struct packet *packet, int len)
+{
+    struct port *oport;
+
+    mac_register(packet->header.src, iport);
+    oport = mac_userdata(packet->header.dest);
+    if (oport) {
+	if (iport != oport)
+	    send_port(oport, packet, len);
+	return 0;
+    }
+    return send_hub(iport, packet, len);
+}
+
+int handle_packet(void* data, struct packet *packet, int len)
+{
+    struct port* port = data;
+    int rc;
+
+    if (dbg_recv)
+	fprintf(stderr,"port %s: recv %d bytes"
+		" %02x:%02x:%02x:%02x:%02x:%02x =>"
+		" %02x:%02x:%02x:%02x:%02x:%02x\n",
+		port->label, len,
+		packet->header.src[0], packet->header.src[1],
+		packet->header.src[2], packet->header.src[3],
+		packet->header.src[4], packet->header.src[5],
+		packet->header.dest[0], packet->header.dest[1],
+		packet->header.dest[2], packet->header.dest[3],
+		packet->header.dest[4], packet->header.dest[5]);
+
+    if (hub)
+	rc = send_hub(port, packet, len);
+    else
+	rc = send_switch(port, packet, len);
+    return rc;
+}
+
+int init_port(int hubflag)
+{
+  hub = hubflag;
+
+  if(mac_init(label_port) < 0) {
+    fprintf(stderr, "port_init failed.\n");
+    exit(1);
+  }
+
+  return(0);
+}
diff -Naur uml_router.old/port.h uml_router/port.h
--- uml_router.old/port.h	Wed Dec 31 19:00:00 1969
+++ uml_router/port.h	Sun Nov 28 15:45:15 2004
@@ -0,0 +1,18 @@
+/* Copyright 2004 Steve Schmidtke
+ * Based on work done by Gerd Knorr, and others
+ * Licensed under the GPL
+ */
+
+#ifndef __PORT_H__
+#define __PORT_H__
+
+extern void* port_add(char* label, void* userdata,
+                      int (*on_write)(void* userdata, void *packet, int 
len),
+                      int (*on_queue)(void* userdata, int drain),
+                      void (*on_release)(void* userdata));
+extern void port_del(void* data);
+extern int port_flush(void* data);
+extern int handle_packet(void* data, struct packet *packet, int len);
+extern int init_port(int hubflag);
+
+#endif


------=_NextPart_000_61e1_5bfc_3380
Content-Type: text/plain; name="uml_router-9.txt"; format=flowed
Content-Disposition: attachment; filename="uml_router-9.txt"
Content-Transfer-Encoding: 8bit

diff -Naur uml_router.old/Makefile uml_router/Makefile
--- uml_router.old/Makefile	Wed Nov 24 17:28:47 2004
+++ uml_router/Makefile	Sun Nov 28 15:49:30 2004
@@ -1,6 +1,6 @@
TUNTAP = $(shell [ -e /usr/include/linux/if_tun.h ] && echo -DTUNTAP)

-OBJS = hash.o port.o fdpoll.o stdin.o uml_switch.o sockunix.o
+OBJS = mac.o port.o fdpoll.o stdin.o uml_switch.o sockunix.o
BIN = uml_switch
CFLAGS = -g -Wall $(TUNTAP)

diff -Naur uml_router.old/sockunix.c uml_router/sockunix.c
--- uml_router.old/sockunix.c	Wed Nov 24 17:28:47 2004
+++ uml_router/sockunix.c	Sun Nov 28 15:49:30 2004
@@ -14,6 +14,7 @@
#include "switch.h"
#include "port.h"

+#include "list.h"
#include "fdpoll.h"
#include "stdin.h"
#include "sockunix.h"
@@ -73,17 +74,16 @@
   struct request_v3 v3;
};

-struct sock_data {
-  int fd;
-  struct sockaddr_un sock;
-};
-
-struct portinfo {
-  struct portinfo* next;
-  int fd;
+struct conndata {
+  struct list_head list;
+  void* port_handle;
+  int ctl_fd;
+  struct sockaddr_un sockname;
+  char ident[32];
};

-static struct portinfo* portlist = NULL;
+static LIST_HEAD(conns_pending);
+static LIST_HEAD(conns_online);

static char *ctl_socket = NULL;
static char *data_socket = NULL;
@@ -92,188 +92,192 @@

static int connect_fd = -1;
static int data_fd = -1;
-static int hub = 0;

-static void close_descriptor(int fd)
+static void close_ctl(struct conndata* conn)
{
-  struct portinfo* prev = NULL;
-  struct portinfo* scan = portlist;
-
-  /* find the entry */
-  while(scan) {
-    if(scan->fd == fd) break;
-
-    prev = scan;
-    scan = scan->next;
+  if(conn->port_handle) { /* in "connected" state */
+    /* port_del() handles cleanup call */
+    port_del(conn->port_handle);
+  } else { /* unconnected state */
+    fdpoll_remove(conn->ctl_fd);
+    close(conn->ctl_fd);
+    list_del(&conn->list);
+    free(conn);
   }
+}

-  if(scan == NULL) {
-    printf("port fd %d not found\n", fd);
-    return;
-  }
-
-  /* extract entry from list */
-  if(prev == NULL) portlist = scan->next;
-  else prev->next = scan->next;
+/* called via port_del() */
+static void sock_release(void* data)
+{
+  struct conndata* conn = data;

-  /* cleanup */
-  fdpoll_remove(scan->fd);
-  close(scan->fd);
-  close_port(scan->fd);
-  free(scan);
+  fdpoll_remove(conn->ctl_fd);
+  close(conn->ctl_fd);
+  list_del(&conn->list);
+  free(conn);
}

-static void send_sock(int fd, void *packet, int len, void *data)
+static int sock_send(void *data, void *packet, int len)
{
-  struct sock_data *mine = data;
-  int err;
+  struct conndata* conn = data;
+  int n;

-  err = sendto(mine->fd, packet, len, 0, (struct sockaddr *) &mine->sock,
-	       sizeof(mine->sock));
-  if(err != len){
-    fprintf(stderr, "send_sock sending to fd %d ", mine->fd);
-    perror("");
+retry:
+  n = sendto(data_fd, packet, len, 0, (struct sockaddr *) &conn->sockname,
+	       sizeof(conn->sockname));
+  if(n < 0) {
+    if(errno == EINTR) goto retry;
+    if(errno == EAGAIN) return(0);
+
+    fprintf(stderr, "send_sock %s\n", conn->ident);
+
+    return(-1);
   }
+
+  return(n);
}

-static int setup_sock_port(int fd, struct sockaddr_un *name, int dfd)
+static int setup_dataport(struct conndata* conn, struct sockaddr_un *name)
{
-  struct sock_data *data;
-
-  data = malloc(sizeof(*data));
-  if(data == NULL){
-    perror("setup_sock_port");
+  conn->sockname = *name;
+  snprintf(conn->ident, sizeof(conn->ident), "'cfd=%d data=%p'",
+  	   conn->ctl_fd, conn);
+  conn->port_handle = port_add(conn->ident, conn, sock_send, NULL, 
sock_release);
+  if(conn->port_handle == NULL) {
+    fprintf(stderr, "setup_connection %s failed\n", conn->ident);
     return(-1);
   }
-  *data = ((struct sock_data) { fd :    dfd,
-				sock :  *name });
-  return(setup_port(fd, send_sock, data, sizeof(*data)));
+
+  /* all OK, move to the 'up' list */
+  list_del(&conn->list);
+  list_add(&conn->list, &conns_online);
+
+  return(0);
}

-static void new_port_v0(int fd, struct request_v0 *req, int dfd)
+static void new_port_v0(struct conndata* conn, struct request_v0 *req)
{
+  int err;
+
   switch(req->type){
   case REQ_NEW_CONTROL:
-    setup_sock_port(fd, &req->u.new_control.name, dfd);
+    err = setup_dataport(conn, &req->u.new_control.name);
+    if(err) {
+      close_ctl(conn);
+      return;
+    }
     break;
   default:
     printf("Bad request type : %d\n", req->type);
-    close_descriptor(fd);
+    close_ctl(conn);
   }
}

-static void new_port_v1_v3(int fd, enum request_type type,
-			   struct sockaddr_un *sock, int dfd)
+static void new_port_v1_v3(struct conndata* conn, enum request_type type,
+			   struct sockaddr_un *sock)
{
   int n, err;

   switch(type){
   case REQ_NEW_CONTROL:
-    err = setup_sock_port(fd, sock, dfd);
-    if(err) return;
-    n = write(fd, &data_sun, sizeof(data_sun));
+    err = setup_dataport(conn, sock);
+    if(err) {
+      close_ctl(conn);
+      return;
+    }
+    n = write(conn->ctl_fd, &data_sun, sizeof(data_sun));
     if(n != sizeof(data_sun)){
       perror("Sending data socket name");
-      close_descriptor(fd);
+      close_ctl(conn);
     }
     break;
   default:
     printf("Bad request type : %d\n", type);
-    close_descriptor(fd);
+    close_ctl(conn);
   }
}

-static void new_port_v2(int fd, struct request_v2 *req, int dfd)
+static void new_port_v2(struct conndata* conn, struct request_v2 *req)
{
   fprintf(stderr, "Version 2 is not supported\n");
-  close_descriptor(fd);
+  close_ctl(conn);
}

-static void new_port(int fd, int dfd)
+static int ctl_hup(void* data)
{
+  struct conndata* conn = data;
+
+  fprintf(stderr, "Error on port %s\n", conn->ident);
+
+  close_ctl(conn);
+
+  return(0);
+}
+
+static int ctl_read(void* data)
+{
+  struct conndata* conn = data;
   union request req;
   int len;

retry:
-  len = read(fd, &req, sizeof(req));
+  len = read(conn->ctl_fd, &req, sizeof(req));
   if(len < 0){
     if(errno == EINTR) goto retry;
-    if(errno == EAGAIN) return;
+    if(errno == EAGAIN) return(0);

     perror("Reading request");
-    close_descriptor(fd);
-    return;
+    close_ctl(conn);
+    return(0);
   }
   else if(len == 0){
-    printf("EOF from new port\n");
-    close_descriptor(fd);
-    return;
+    fprintf(stderr, "EOF from port %s\n", conn->ident);
+    close_ctl(conn);
+    return(0);
+  }
+
+  if(conn->port_handle) { /* connection is up */
+    /* there are no valid requests after successful setup (yet) */
+    fprintf(stderr, "Bad request on %s\n", conn->ident);
+    close_ctl(conn);
+    return(0);
   }
+
+  /* a new port! (a new mess!) */
+
   if(req.v1.magic == SWITCH_MAGIC){
-    if(req.v2.version == 2) new_port_v2(fd, &req.v2, dfd);
+    if(req.v2.version == 2) new_port_v2(conn, &req.v2);
     if(req.v3.version == 3)
-      new_port_v1_v3(fd, req.v3.type, &req.v3.sock, dfd);
-    else if(req.v2.version > 2)
+      new_port_v1_v3(conn, req.v3.type, &req.v3.sock);
+    else if(req.v2.version > 2)
       fprintf(stderr, "Request for a version %d port, which this "
	      "uml_switch doesn't support\n", req.v2.version);
-    else new_port_v1_v3(fd, req.v1.type, &req.v1.u.new_control.name, dfd);
+    else
+      new_port_v1_v3(conn, req.v1.type, &req.v1.u.new_control.name);
   }
-  else new_port_v0(fd, &req.v0, dfd);
-}
-
-static int port_hup(void* data)
-{
-  struct portinfo* pi = data;
-
-  printf("Error on port fd\n");
-
-  close_descriptor(pi->fd);
-
-  return(0);
-}
-
-static int port_read(void* data)
-{
-  struct portinfo* pi = data;
-  int new;
-
-  new = handle_port(pi->fd);
-  if(new) new_port(pi->fd, data_fd);
-  else close_descriptor(pi->fd);
+  else new_port_v0(conn, &req.v0);

   return(0);
}

-static void accept_connection(int fd)
+static int accept_connection(int fd)
{
   struct sockaddr addr;
   int len, new;
-  struct portinfo* pi;

   len = sizeof(addr);
   new = accept(fd, &addr, &len);
   if(new < 0){
     perror("accept");
-    return;
+    return(-1);
   }
   if(fcntl(new, F_SETFL, O_NONBLOCK) < 0){
     perror("fcntl - setting O_NONBLOCK");
     close(new);
-    return;
-  }
-
-  pi = malloc(sizeof(*pi));
-  if(pi == NULL) {
-    fprintf(stderr, "malloc error\n");
-    close(new);
-    return;
+    return(-1);
   }

-  pi->fd = new;
-  pi->next = portlist;
-  portlist = pi;
-
-  fdpoll_add(pi->fd, pi, port_read, NULL, port_hup);
+  return(new);
}

static int still_used(struct sockaddr_un *sun)
@@ -435,19 +439,49 @@

static int sockconn_read(void* data)
{
-  accept_connection(connect_fd);
+  struct conndata* conn;
+  int fd;
+
+  fd = accept_connection(connect_fd);
+  if(fd < 0) {
+    return(0);
+  }
+
+  conn = malloc(sizeof(*conn));
+  if(conn == NULL) {
+    fprintf(stderr, "malloc error\n");
+    close(fd);
+    return(0);
+  }
+
+  conn->ctl_fd = fd;
+  conn->port_handle = NULL;  /* set when connected */
+
+  /* add it to the new connection list */
+  list_add(&conn->list, &conns_pending);
+
+  fdpoll_add(conn->ctl_fd, conn, ctl_read, NULL, ctl_hup);

   return(0);
}

-static int match_sock(int port_fd, int dfd, void *port_data,
-                      int port_data_len, void *data)
+/* TODO: this should be a hash or tree search */
+static struct conndata* find_connection(struct sockaddr_un* sock, int 
socklen)
{
-  struct sock_data *mine = data;
-  struct sock_data *port = port_data;
+  struct conndata* conn;
+  struct list_head* lptr;
+
+  if(socklen != sizeof(conn->sockname)) return(NULL);
+
+  list_for_each(lptr, &conns_online) {
+    conn = list_entry(lptr, struct conndata, list);
+
+    if(memcmp(sock, &conn->sockname, sizeof(conn->sockname)) == 0) {
+      return(conn);
+    }
+  }

-  if(port_data_len != sizeof(*mine)) return(0);
-  return(!memcmp(&port->sock, &mine->sock, sizeof(mine->sock)));
+  return(NULL);
}

static int sockdata_hup(void* data)
@@ -462,12 +496,13 @@
static int sockdata_read(void* data)
{
   struct packet packet;
-  struct sock_data sdata;
-  int len, socklen = sizeof(sdata.sock);
+  struct sockaddr_un sock;
+  int len, socklen = sizeof(sock);
+  struct conndata* conn;

retry:
   len = recvfrom(data_fd, &packet, sizeof(packet), 0,
-		 (struct sockaddr *) &sdata.sock, &socklen);
+		 (struct sockaddr *) &sock, &socklen);
   if(len < 0){
     if(errno == EINTR) goto retry;
     if(errno == EAGAIN) return(0);
@@ -476,9 +511,14 @@
     fdpoll_remove(data_fd);
     return(0);
   }
-  sdata.fd = data_fd;

-  handle_data(data_fd, hub, &packet, len, &sdata, match_sock);
+  conn = find_connection(&sock, socklen);
+  if(!conn) {
+    fprintf(stderr, "Received stray packet on fd %d\n", data_fd);
+    return(0);
+  }
+
+  handle_packet(conn->port_handle, &packet, len);

   return(0);
}
@@ -535,7 +575,7 @@
   }
}

-void init_sockunix_v0(char* ctl_name, char* data_name, int hubflag)
+void init_sockunix_v0(char* ctl_name, char* data_name)
{
   if(connect_fd >= 0) {
     fprintf(stderr, "Connection socket already initialized.\n");
@@ -544,7 +584,6 @@

   ctl_socket = ctl_name;
   data_socket = data_name;
-  hub = hubflag;

   connect_fd = new_sockstream();
   data_fd = new_sockdgram();
@@ -560,7 +599,7 @@
   fdpoll_add(data_fd, NULL, sockdata_read, NULL, sockdata_hup);
}

-void init_sockunix(char* ctl_name, int hubflag)
+void init_sockunix(char* ctl_name)
{
   if(connect_fd >= 0) {
     fprintf(stderr, "Connection socket already initialized.\n");
@@ -569,7 +608,6 @@

   ctl_socket = ctl_name;
   data_socket = NULL;
-  hub = hubflag;

   connect_fd = new_sockstream();
   data_fd = new_sockdgram();
diff -Naur uml_router.old/sockunix.h uml_router/sockunix.h
--- uml_router.old/sockunix.h	Wed Nov 24 17:28:47 2004
+++ uml_router/sockunix.h	Sun Nov 28 15:49:30 2004
@@ -6,7 +6,7 @@
#define __SOCKUNIX_H__

extern void cleanup_sockunix(void);
-extern void init_sockunix_v0(char* ctl_name, char* data_name, int hubflag);
-extern void init_sockunix(char* ctl_name, int hubflag);
+extern void init_sockunix_v0(char* ctl_name, char* data_name);
+extern void init_sockunix(char* ctl_name);

#endif
diff -Naur uml_router.old/tuntap.c uml_router/tuntap.c
--- uml_router.old/tuntap.c	Wed Nov 24 17:28:47 2004
+++ uml_router/tuntap.c	Sun Nov 28 15:49:30 2004
@@ -10,35 +10,55 @@
#include "port.h"
#include "fdpoll.h"

+static void* port_handle = NULL;
static char* tap_dev = NULL;
static int tap_fd = -1;
-static int hub = 0;

-static void send_tap(int fd, void *packet, int len, void *unused)
+/* called via port_del() */
+static void release_tap(void* data)
{
-  int n;
-
-  n = write(fd, packet, len);
-  if(n != len){
-    if(errno != EAGAIN) perror("send_tap");
+  if(tap_fd >= 0) {
+    fdpoll_remove(tap_fd);
+    close(tap_fd);
   }
+
+  tap_fd = -1;
+  tap_dev = NULL;
}

-static int match_tap(int port_fd, int data_fd, void *port_data,
-                     int port_data_len, void *data)
+/* called via port_send() */
+static int send_tap(void* data, void* packet, int len)
{
-  return(port_fd == data_fd);
+  int n;
+
+retry:
+  n = write(tap_fd, packet, len);
+  if(n < 0){
+    if(errno == EINTR) goto retry;
+    if(errno == EAGAIN) return(0);
+
+    perror("Writing tap data");
+
+    return(-1);
+  } else if(n == 0) {
+    return(-1);
+  }
+
+  return(n);
}

+/* called if HUP event on fd */
static int tuntap_hup(void* data)
{
   printf("Error on tap fd\n");

-  fdpoll_remove(tap_fd);
+  port_del(port_handle);
+  port_handle = NULL;

   return(0);
}

+/* called via fdpoll_poll() */
static int tuntap_read(void* data)
{
   struct packet packet;
@@ -51,10 +71,12 @@
     if(errno == EAGAIN) return(0);

     perror("Reading tap data");
-    fdpoll_remove(tap_fd);
+
+    port_del(port_handle);
+    port_handle = NULL;
     return(0);
   }
-  handle_data(tap_fd, hub, &packet, len, NULL, match_tap);
+  handle_packet(port_handle, &packet, len);

   return(0);
}
@@ -62,7 +84,7 @@
static int open_tap(char *dev)
{
   struct ifreq ifr;
-  int fd, err;
+  int fd;

   if((fd = open("/dev/net/tun", O_RDWR)) < 0){
     perror("Failed to open /dev/net/tun");
@@ -76,23 +98,19 @@
     close(fd);
     return(-1);
   }
-  err = setup_port(fd, send_tap, NULL, 0);
-  if(err) return(err);
   return(fd);
}

+/* called just before program shutdown */
void cleanup_tap(void)
{
-  if(tap_fd >= 0) {
-    fdpoll_remove(tap_fd);
-    close(tap_fd);
+  if(port_handle) {
+    port_del(port_handle);
+    port_handle = NULL;
   }
-
-  tap_fd = -1;
-  tap_dev = NULL;
}

-void init_tap(char* tap_name, int hubflag)
+void init_tap(char* tap_name)
{
   if(tap_fd >= 0) {
     fprintf(stderr, "Tun/Tap already initialized.\n");
@@ -100,7 +118,6 @@
   }

   tap_dev = tap_name;
-  hub = hubflag;

   tap_fd = open_tap(tap_dev);
   if(tap_fd<0) {
@@ -108,6 +125,18 @@
     exit(1);
   }

-  fdpoll_add(tap_fd, NULL, tuntap_read, NULL, tuntap_hup);
-}
+  port_handle = port_add(tap_dev, NULL, send_tap, NULL, release_tap);
+  if(!port_handle) {
+    fprintf(stderr, "Tun/Tap port_add failed.\n");
+    close(tap_fd);
+    tap_fd = -1;
+    exit(1);
+  }

+  if(fdpoll_add(tap_fd, NULL, tuntap_read, NULL, tuntap_hup) < 0) {
+    fprintf(stderr, "Tun/Tap fdpoll_add failed.\n");
+    port_del(port_handle);
+    port_handle = NULL;
+    exit(1);
+  }
+}
diff -Naur uml_router.old/tuntap.h uml_router/tuntap.h
--- uml_router.old/tuntap.h	Wed Nov 24 17:28:47 2004
+++ uml_router/tuntap.h	Sun Nov 28 15:49:30 2004
@@ -6,6 +6,6 @@
#define __TUNTAP_H__

extern void cleanup_tap(void);
-extern void init_tap(char* tap_name, int hub);
+extern void init_tap(char* tap_name);

#endif
diff -Naur uml_router.old/uml_switch.c uml_router/uml_switch.c
--- uml_router.old/uml_switch.c	Wed Nov 24 17:28:47 2004
+++ uml_router/uml_switch.c	Sun Nov 28 15:49:30 2004
@@ -9,7 +9,6 @@
#include <unistd.h>
#include "switch.h"
#include "port.h"
-#include "hash.h"
#include "fdpoll.h"
#include "stdin.h"
#include "sockunix.h"
@@ -128,12 +127,13 @@
     else Usage();
   }

-  if(compat_v0) init_sockunix_v0(ctl_name, data_name, hub);
-  else init_sockunix(ctl_name, hub);
+  init_port(hub);
+
+  if(compat_v0) init_sockunix_v0(ctl_name, data_name);
+  else init_sockunix(ctl_name);

   if(signal(SIGINT, sig_handler) < 0)
     perror("Setting handler for SIGINT");
-  hash_init();

   if(compat_v0)
     printf("%s attached to unix sockets '%s' and '%s'", progname(),
@@ -150,7 +150,7 @@

#ifdef TUNTAP
   if(tap_dev != NULL)
-    init_tap(tap_dev, hub);
+    init_tap(tap_dev);
#endif

   if (daemonize && daemon(0, 1)) {


------=_NextPart_000_61e1_5bfc_3380
Content-Type: text/plain; name="uml_router-10.txt"; format=flowed
Content-Disposition: attachment; filename="uml_router-10.txt"
Content-Transfer-Encoding: 8bit

diff -Naur uml_router.old/fdpoll.c uml_router/fdpoll.c
--- uml_router.old/fdpoll.c	Wed Nov 24 17:28:38 2004
+++ uml_router/fdpoll.c	Sun Nov 28 16:05:34 2004
@@ -21,7 +21,22 @@
static int numfds = 0;
static int gc_count = 0;

-int fdpoll_add(int fd, void* data, int (*on_read)(void* data), int 
(*on_write)(void* data), int (*on_hup)(void* data))
+static int find_entry(int fd)
+{
+  int i = numfds - 1;
+
+  while(i >= 0) {
+    if(fds[i].fd == fd) return(i);
+    i--;
+  }
+
+  return(-1);
+}
+
+int fdpoll_add(int fd, void* data,
+	       int (*on_read)(void* data),
+	       int (*on_write)(void* data),
+	       int (*on_hup)(void* data))
{
   struct pollfd* pf;
   struct pollinfo* pi;
@@ -91,16 +106,71 @@
   return(0);
}

-int fdpoll_remove(int fd)
+/* only test POLLOUT when there's something to write */
+int fdpoll_modwrite(int fd, int (*on_write)(void* data))
{
-  int i = numfds - 1;
+  struct pollfd* pf;
+  struct pollinfo* pi;
+  int i;

   if(fd < 0) return(-1);

-  while(i >= 0) {
-    if(fds[i].fd == fd) break;
-    i--;
+  i = find_entry(fd);
+  if(i < 0) {
+    return(-1);
+  }
+
+  pf = &fds[i];
+  pi = &fdi[i];
+
+  if(on_write) {
+    pf->events |= POLLOUT;
+  } else {
+    pf->events &= ~(POLLOUT);
+  }
+  pf->revents = 0;  /* ensure fd_poll() ignores changed entry */
+
+  pi->on_write = on_write;
+
+  return(0);
+}
+
+/* only test POLLIN when input is expected */
+int fdpoll_modread(int fd, int (*on_read)(void* data))
+{
+  struct pollfd* pf;
+  struct pollinfo* pi;
+  int i;
+
+  if(fd < 0) return(-1);
+
+  i = find_entry(fd);
+  if(i < 0) {
+    return(-1);
   }
+
+  pf = &fds[i];
+  pi = &fdi[i];
+
+  if(on_read) {
+    pf->events |= POLLIN;
+  } else {
+    pf->events &= ~(POLLIN);
+  }
+  pf->revents = 0;  /* ensure fd_poll() ignores changed entry */
+
+  pi->on_read = on_read;
+
+  return(0);
+}
+
+int fdpoll_remove(int fd)
+{
+  int i;
+
+  if(fd < 0) return(-1);
+
+  i = find_entry(fd);
   if(i < 0) {
     return(-1);
   }
@@ -138,10 +208,13 @@
     gc_count = 0;
   }

-retry:
   n = poll(fds, numfds, timeout);
   if(n < 0) {
-    if(errno == EINTR) goto retry;
+    if(errno == EINTR) {
+      /* something happened.  Who knows what, but going back to sleep *
+       * could mess up any pending timed events.  So just return.     */
+       return(0);
+    }

     return(n);
   } else {
diff -Naur uml_router.old/fdpoll.h uml_router/fdpoll.h
--- uml_router.old/fdpoll.h	Wed Nov 24 17:28:38 2004
+++ uml_router/fdpoll.h	Sun Nov 28 15:56:35 2004
@@ -9,6 +9,8 @@
                       int (*on_read)(void* data),
                       int (*on_write)(void* data),
                       int (*on_hup)(void* data));
+extern int fdpoll_modwrite(int fd, int (*on_write)(void* data));
+extern int fdpoll_modread(int fd, int (*on_read)(void* data));
extern int fdpoll_remove(int fd);
extern int fdpoll_poll(int timeout);



------=_NextPart_000_61e1_5bfc_3380
Content-Type: text/plain; name="uml_router-11.txt"; format=flowed
Content-Disposition: attachment; filename="uml_router-11.txt"
Content-Transfer-Encoding: 8bit

diff -Naur uml_router.old/tuntap.c uml_router/tuntap.c
--- uml_router.old/tuntap.c	Sun Nov 28 15:49:58 2004
+++ uml_router/tuntap.c	Sun Nov 28 16:10:25 2004
@@ -47,6 +47,26 @@
   return(n);
}

+/* if drain is called then output is possible */
+static int drain_tap(void* data)
+{
+  port_flush(port_handle);
+
+  return(0);
+}
+
+/* output flow control called via port_send() */
+static int flow_tap(void* data, int drain)
+{
+  if(drain) {  /* watch POLLOUT */
+    fdpoll_modwrite(tap_fd, drain_tap);
+  } else {  /* ignore POLLOUT */
+    fdpoll_modwrite(tap_fd, NULL);
+  }
+
+  return(0);
+}
+
/* called if HUP event on fd */
static int tuntap_hup(void* data)
{
@@ -125,7 +145,7 @@
     exit(1);
   }

-  port_handle = port_add(tap_dev, NULL, send_tap, NULL, release_tap);
+  port_handle = port_add(tap_dev, NULL, send_tap, flow_tap, release_tap);
   if(!port_handle) {
     fprintf(stderr, "Tun/Tap port_add failed.\n");
     close(tap_fd);


------=_NextPart_000_61e1_5bfc_3380
Content-Type: text/plain; name="uml_router-12.txt"; format=flowed
Content-Disposition: attachment; filename="uml_router-12.txt"
Content-Transfer-Encoding: 8bit

diff -Naur uml_router.old/Makefile uml_router/Makefile
--- uml_router.old/Makefile	Sun Nov 28 15:49:58 2004
+++ uml_router/Makefile	Sun Nov 28 16:12:00 2004
@@ -1,6 +1,6 @@
TUNTAP = $(shell [ -e /usr/include/linux/if_tun.h ] && echo -DTUNTAP)

-OBJS = mac.o port.o fdpoll.o stdin.o uml_switch.o sockunix.o
+OBJS = mac.o port.o fdpoll.o timer.o stdin.o uml_switch.o sockunix.o
BIN = uml_switch
CFLAGS = -g -Wall $(TUNTAP)

diff -Naur uml_router.old/mac.c uml_router/mac.c
--- uml_router.old/mac.c	Sun Nov 28 15:48:12 2004
+++ uml_router/mac.c	Sun Nov 28 16:16:26 2004
@@ -8,6 +8,7 @@
#include <string.h>
#include <time.h>
#include "switch.h"
+#include "timer.h"
#include "list.h"

struct mac {
@@ -151,16 +152,11 @@
   }
}

-void mac_delall_expired(void)
+static int mac_delall_expired(void* data)
{
   time_t now = time(NULL);
-  static time_t last;
   int i;

-  if (last + expire/4 > now)
-    return;
-  last = now;
-
   for(i = 0; i < HASH_SIZE; i++) {
     struct list_head* lhed = &macs[i];
     struct list_head* ltmp;
@@ -183,6 +179,10 @@
       free(mac);
     }
   }
+
+  /* TODO: be smart and schedule a wakeup for some *
+   * time after the next expected mac expiry.      */
+  return(expire/4 + 1);  /* reschedule event */
}

int mac_init(char* (*labeler)(void* data))
@@ -194,6 +194,11 @@

   for(i = 0; i < HASH_SIZE; i++) {
     INIT_LIST_HEAD(&macs[i]);
+  }
+
+  if(tevent_add(expire/4 + 1, NULL, mac_delall_expired) < 0) {
+    fprintf(stderr, "mac expire timer failed.\n");
+    return(-1);
   }

   return(0);
diff -Naur uml_router.old/mac.h uml_router/mac.h
--- uml_router.old/mac.h	Sun Nov 28 15:48:12 2004
+++ uml_router/mac.h	Sun Nov 28 16:12:00 2004
@@ -8,7 +8,6 @@
extern void* mac_userdata(unsigned char* addr);
extern int mac_register(unsigned char* addr, void* userdata);
extern void mac_delall_userdata(void* userdata);
-extern void mac_delall_expired(void);
extern int mac_init(char* (*labeler)(void* data));

#endif
diff -Naur uml_router.old/timer.c uml_router/timer.c
--- uml_router.old/timer.c	Wed Dec 31 19:00:00 1969
+++ uml_router/timer.c	Sun Nov 28 16:12:00 2004
@@ -0,0 +1,174 @@
+/* Copyright 2004 Steve Schmidtke
+ * Licensed under the GPL
+ */
+
+/* this interface is only accurate to within a couple seconds even *
+ * under ideal conditions.  If you need better, don't look here.   */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include "list.h"
+
+struct event {
+  struct list_head list;
+  time_t trigger;
+  void* userdata;
+  int (*on_event)(void* data);
+};
+
+static LIST_HEAD(events);
+static time_t last = 0;
+
+/* insert in time order */
+static void insert_event(struct event* new)
+{
+  struct list_head* lptr;
+
+  list_for_each(lptr, &events) {
+    struct event* e = list_entry(lptr, struct event, list);
+
+    if(e->trigger > new->trigger) {
+      /* insert *before* e */
+      list_add_tail(&new->list, &e->list);
+      return;
+    }
+  }
+
+  /* new->trigger is > than all other events */
+  list_add_tail(&new->list, &events);
+}
+
+/* seconds 'til next event */
+int tevent_interval(void)
+{
+  time_t now = time(NULL);
+  struct list_head* lptr;
+
+  list_for_each(lptr, &events) {
+    struct event* e = list_entry(lptr, struct event, list);
+    int secs;
+
+    secs = e->trigger - now;
+    /* TODO: make secs sane on time_t wrap around */
+
+    /* event may be ripe */
+    if(secs < 0) secs = 0;
+
+    return(secs);
+  }
+
+  return(-1); /* no events scheduled */
+}
+
+/* dispatch all triggered events *must be called periodically* */
+int tevent_service(void)
+{
+  time_t now = time(NULL);
+  struct list_head* ltmp;
+  struct list_head* lptr;
+
+  if(last > now) { /* yay, a TIME MACHINE! */
+    /* TODO: make sane all events when clock reset */
+  }
+
+  last = now;
+
+  list_for_each_safe(lptr, ltmp, &events) {
+    struct event* e = list_entry(lptr, struct event, list);
+    int ret;
+
+    if(e->trigger > now) break;
+
+    list_del(lptr);
+
+    ret = e->on_event(e->userdata);
+
+    if(ret < 0) {
+      /* fatal error */
+      free(e);
+      return(-1);
+    } if(ret == 0) {
+      /* one shot */
+      free(e);
+    } else {
+      /* recurring (no race with loop because: now + ret > now) */
+      e->trigger = now + ret;
+      insert_event(e);
+    }
+  }
+
+  return(0);
+}
+
+int tevent_add(int secs, void* data, int (*on_event)(void* data))
+{
+  time_t now = time(NULL);
+  time_t when;
+  struct event* new;
+
+  if(secs < 0) return(-1);
+  if(on_event == NULL) return(-1);
+
+  when = now + secs;
+  /* TODO: make 'when' sane on time_t wrap around */
+
+  new = malloc(sizeof(*new));
+  if(new == NULL) {
+    return(-1);
+  }
+
+  new->trigger = when;
+  new->userdata = data;
+  new->on_event = on_event;
+
+  insert_event(new);
+
+  return(0);
+}
+
+/* modify the trigger time of a scheduled event */
+int tevent_update(int secs, void* data, int (*on_event)(void* data))
+{
+  time_t now = time(NULL);
+  struct list_head* lptr;
+  time_t when;
+
+  if(secs < 0) return(-1);
+
+  when = now + secs;
+  /* TODO: make 'when' sane on time_t wrap around */
+
+  list_for_each(lptr, &events) {
+    struct event* e = list_entry(lptr, struct event, list);
+
+    if((e->userdata == data) && (e->on_event == on_event)) {
+      list_del(lptr);
+      e->trigger = when;
+      insert_event(e);
+
+      return(0);
+    }
+  }
+
+  /* not found */
+
+  return(-1);
+}
+
+/* deletes all matching events (there should only be one) */
+void tevent_del(void* data, int (*on_event)(void* data))
+{
+  struct list_head* ltmp;
+  struct list_head* lptr;
+
+  list_for_each_safe(lptr, ltmp, &events) {
+    struct event* e = list_entry(lptr, struct event, list);
+
+    if((e->userdata == data) && (e->on_event == on_event)) {
+      list_del(lptr);
+      free(e);
+    }
+  }
+}
diff -Naur uml_router.old/timer.h uml_router/timer.h
--- uml_router.old/timer.h	Wed Dec 31 19:00:00 1969
+++ uml_router/timer.h	Sun Nov 28 16:12:00 2004
@@ -0,0 +1,14 @@
+/* Copyright 2004 Steve Schmidtke
+ * Licensed under the GPL
+ */
+
+#ifndef __TIMER_H__
+#define __TIMER_H__
+
+extern int tevent_interval(void);
+extern int tevent_service(void);
+extern int tevent_add(int secs, void* data, int (*on_event)(void* data));
+extern int tevent_update(int secs, void* data, int (*on_event)(void* 
data));
+extern void tevent_del(void* data, int (*on_event)(void* data));
+
+#endif
diff -Naur uml_router.old/uml_switch.c uml_router/uml_switch.c
--- uml_router.old/uml_switch.c	Sun Nov 28 15:49:58 2004
+++ uml_router/uml_switch.c	Sun Nov 28 16:12:00 2004
@@ -12,6 +12,7 @@
#include "fdpoll.h"
#include "stdin.h"
#include "sockunix.h"
+#include "timer.h"
#ifdef TUNTAP
#include "tuntap.h"
#endif
@@ -159,9 +160,19 @@
   }

   while(!done){
-    if(fdpoll_poll(-1) < 0) {
+    int timeout;
+
+    timeout = tevent_interval();
+    if(timeout > 0) timeout *= 1000; /* secs->millisecs */
+
+    if(fdpoll_poll(timeout) < 0) {
       perror("poll");
-      quitprog();
+      exit(1);
+    }
+
+    if(tevent_service() < 0) {
+      fprintf(stderr, "Event handler failure.\n");
+      exit(1);
     }
   }



------=_NextPart_000_61e1_5bfc_3380
Content-Type: text/plain; name="uml_router-13.txt"; format=flowed
Content-Disposition: attachment; filename="uml_router-13.txt"
Content-Transfer-Encoding: 8bit

diff -Naur uml_router.old/Makefile uml_router/Makefile
--- uml_router.old/Makefile	Mon Nov 29 13:41:00 2004
+++ uml_router/Makefile	Mon Nov 29 13:41:11 2004
@@ -1,6 +1,7 @@
TUNTAP = $(shell [ -e /usr/include/linux/if_tun.h ] && echo -DTUNTAP)

-OBJS = mac.o port.o fdpoll.o timer.o stdin.o uml_switch.o sockunix.o
+OBJS = mac.o port.o fdpoll.o timer.o stdin.o pidfile.o uml_switch.o 
sockunix.o
+LIBS =
BIN = uml_switch
CFLAGS = -g -Wall $(TUNTAP)

@@ -13,7 +14,7 @@
all : $(BIN)

$(BIN) : $(OBJS)
-	$(CC) $(CFLAGS) -o $(BIN) $(OBJS)
+	$(CC) $(CFLAGS) -o $(BIN) $(OBJS) $(LIBS)

clean :
	rm -f $(BIN) $(OBJS) *~
diff -Naur uml_router.old/pidfile.c uml_router/pidfile.c
--- uml_router.old/pidfile.c	Wed Dec 31 19:00:00 1969
+++ uml_router/pidfile.c	Mon Nov 29 13:41:44 2004
@@ -0,0 +1,79 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+
+static char* pid_file = NULL;
+static int pid_fd = -1;
+static int exit_hooked = 0;
+
+/*
+ * All roads lead to Rome (or in this case: pidfile cleanup).
+ * May be called multiple times as the program shuts down.
+ */
+void cleanup_pidfile(void)
+{
+  if(pid_fd >= 0) {
+    close(pid_fd);
+    pid_fd = -1;
+  }
+  if(pid_file) {
+    unlink(pid_file);
+    pid_file = NULL;
+  }
+}
+
+/* write pidfile */
+int write_pidfile(int pid)
+{
+  char pid_str[16];
+  int n, len;
+
+  if(pid_fd < 0) return(-1);
+
+  len = snprintf(pid_str, sizeof(pid_str), "%d\n", pid);
+  if(len < 0 || len >= sizeof(pid_str)) {
+    return(-1);
+  }
+
+  n = write(pid_fd, pid_str, len);
+  if(n != len) {
+    fprintf(stderr, "write %s: %s\n", pid_file, strerror(errno));
+    return(-1);
+  }
+
+  close(pid_fd);
+  pid_fd = -1;
+
+  return(0);
+}
+
+/* open pidfile */
+int init_pidfile(char* filename)
+{
+  if (pid_file != NULL) return(-1);
+
+  if (filename == NULL) return(-1);
+
+  if(!exit_hooked) {
+    if(atexit(cleanup_pidfile)) {
+      fprintf(stderr, "atexit %s: failed\n", pid_file);
+      return(-1);
+    }
+
+    exit_hooked = 1;
+  }
+
+  pid_fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0600);
+  if (-1 == pid_fd) {
+    fprintf(stderr, "open %s: %s\n", filename, strerror(errno));
+    return(-1);
+  }
+
+  /* set after successful open (don't 'race' with cleanup_pidfile()) */
+  pid_file = filename;
+
+  return(0);
+}
diff -Naur uml_router.old/pidfile.h uml_router/pidfile.h
--- uml_router.old/pidfile.h	Wed Dec 31 19:00:00 1969
+++ uml_router/pidfile.h	Mon Nov 29 13:41:11 2004
@@ -0,0 +1,11 @@
+/* Copyright 2004 Steve Schmidtke
+ * Licensed under the GPL
+ */
+#ifndef __PIDFILE_H__
+#define __PIDFILE_H__
+
+extern void cleanup_pidfile(void);
+extern int write_pidfile(int pid);
+extern int init_pidfile(char* filename);
+
+#endif
diff -Naur uml_router.old/uml_switch.c uml_router/uml_switch.c
--- uml_router.old/uml_switch.c	Mon Nov 29 13:41:00 2004
+++ uml_router/uml_switch.c	Mon Nov 29 13:42:46 2004
@@ -13,6 +13,7 @@
#include "stdin.h"
#include "sockunix.h"
#include "timer.h"
+#include "pidfile.h"
#ifdef TUNTAP
#include "tuntap.h"
#endif
@@ -41,6 +42,7 @@
   cleanup_tap();
#endif
   cleanup_stdin();
+  cleanup_pidfile();
}

static void sig_handler(int sig)
@@ -57,6 +59,7 @@
#ifdef TUNTAP
    " [ -tap tap-device ]"
#endif
+   " [ -pidfile pidfile ]"
    " [ -daemon ]";

   fprintf(stderr, "Usage : %s [ -unix control-socket ] %s\n"
@@ -73,6 +76,7 @@
   int daemonize = 0;
   int hub = 0;
   int compat_v0 = 0;
+  char *pid_file = NULL;
#ifdef TUNTAP
   char *tap_dev = NULL;
#endif
@@ -95,6 +99,13 @@
       argc--;
       argv++;
     }
+    else if(!strcmp(argv[0], "-pidfile")){
+      if(argc < 2)
+	Usage();
+      pid_file = argv[1];
+      argv += 2;
+      argc -= 2;
+    }
     else if(!strcmp(argv[0], "-tap")){
#ifdef TUNTAP
       if(argc < 2)
@@ -128,6 +139,13 @@
     else Usage();
   }

+  if(pid_file != NULL) {
+    if(init_pidfile(pid_file) < 0) {
+      fprintf(stderr, "pidfile %s init failed.\n", pid_file);
+      exit(1);
+    }
+  }
+
   init_port(hub);

   if(compat_v0) init_sockunix_v0(ctl_name, data_name);
@@ -157,6 +175,13 @@
   if (daemonize && daemon(0, 1)) {
     perror("daemon");
     exit(1);
+  }
+
+  if(pid_file != NULL) {
+    if(write_pidfile(getpid()) < 0) {
+      fprintf(stderr, "pidfile %s write failed.\n", pid_file);
+      exit(1);
+    }
   }

   while(!done){


------=_NextPart_000_61e1_5bfc_3380
Content-Type: text/plain; name="uml_router-14.txt"; format=flowed
Content-Disposition: attachment; filename="uml_router-14.txt"
Content-Transfer-Encoding: 8bit

diff -Naur uml_router.old/Makefile uml_router/Makefile
--- uml_router.old/Makefile	Mon Nov 29 14:01:59 2004
+++ uml_router/Makefile	Mon Nov 29 18:51:20 2004
@@ -1,14 +1,19 @@
TUNTAP = $(shell [ -e /usr/include/linux/if_tun.h ] && echo -DTUNTAP)
+# uncomment SOCKUDP to add the driver to the program
+#SOCKUDP = -DSOCKUDP

OBJS = mac.o port.o fdpoll.o timer.o stdin.o pidfile.o uml_switch.o 
sockunix.o
LIBS =
BIN = uml_switch
-CFLAGS = -g -Wall $(TUNTAP)
+CFLAGS = -g -Wall $(TUNTAP) $(SOCKUDP)

BIN_DIR ?= /usr/bin

ifneq ($(TUNTAP),)
	OBJS += tuntap.o
+endif
+ifneq ($(SOCKUDP),)
+	OBJS += sockudp.o
endif

all : $(BIN)
diff -Naur uml_router.old/sockudp.c uml_router/sockudp.c
--- uml_router.old/sockudp.c	Wed Dec 31 19:00:00 1969
+++ uml_router/sockudp.c	Mon Nov 29 18:44:23 2004
@@ -0,0 +1,336 @@
+/* Copyright 2001, 2002 Jeff Dike and others
+ * Copyright 2004 Steve Schmidtke
+ * Licensed under the GPL
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <netdb.h>
+#include <time.h>
+#include <unistd.h>
+#include "switch.h"
+#include "port.h"
+
+#include "list.h"
+#include "fdpoll.h"
+#include "timer.h"
+#include "sockudp.h"
+
+#ifdef notdef
+#include <stddef.h>
+#endif
+
+struct conndata {
+  struct list_head list;
+  void* port_handle;
+  int perm;
+  time_t seen;
+  struct sockaddr_in sockname;
+  char ident[32];
+};
+
+struct rem_data {
+  struct list_head list;
+  struct sockaddr_in saddr;
+  char* host;
+  int port;
+};
+
+static LIST_HEAD(conns);
+static LIST_HEAD(remotes);
+
+static int expires = 600;
+
+static int data_port = 0;
+static int data_fd = -1;
+
+static int accept_unsolicited = 0;
+
+/* called via port_del() */
+static void sock_release(void* data)
+{
+  struct conndata* conn = data;
+
+  list_del(&conn->list);
+  free(conn);
+}
+
+static int purge_expired(void* data)
+{
+  struct list_head* ltmp;
+  struct list_head* lptr;
+  time_t now = time(NULL);
+
+  list_for_each_safe(lptr, ltmp, &conns) {
+    struct conndata* conn = list_entry(lptr, struct conndata, list);
+    if(conn->perm) continue;
+
+    if(conn->seen + expires < now) {
+      unsigned char* addr = (unsigned 
char*)&conn->sockname.sin_addr.s_addr;
+
+      fprintf(stderr, "Expired UDP: %u.%u.%u.%u:%d\n",
+	    addr[0], addr[1], addr[2], addr[3],
+	    ntohs(conn->sockname.sin_port));
+      port_del(conn->port_handle);
+    }
+  }
+
+  return(expires/4 + 1); /* reschedule */
+}
+
+static int sock_send(void *data, void *packet, int len)
+{
+  struct conndata* conn = data;
+  int n;
+
+retry:
+  n = sendto(data_fd, packet, len, 0, (struct sockaddr *) &conn->sockname,
+	       sizeof(conn->sockname));
+  if(n < 0) {
+    if(errno == EINTR) goto retry;
+    if(errno == EAGAIN) return(0);
+
+    fprintf(stderr, "send_sock %s\n", conn->ident);
+
+    return(-1);
+  }
+
+  return(n);
+}
+
+static struct conndata* new_port(struct sockaddr_in* name)
+{
+  struct conndata* conn;
+  unsigned char* addr = (unsigned char*)&name->sin_addr.s_addr;
+
+  conn = malloc(sizeof(*conn));
+  if(conn == NULL) {
+    perror("malloc");
+    return(NULL);
+  }
+
+  conn->sockname = *name;
+  conn->seen = 0;
+  conn->perm = 0;
+  snprintf(conn->ident, sizeof(conn->ident), "%u.%u.%u.%u:%d",
+	   addr[0], addr[1], addr[2], addr[3], ntohs(name->sin_port));
+  conn->port_handle = port_add(conn->ident, conn, sock_send, NULL, 
sock_release);
+  if(conn->port_handle == NULL) {
+    fprintf(stderr, "setup_connection %s failed\n", conn->ident);
+    free(conn);
+    return(NULL);
+  }
+
+  /* all OK */
+  list_add(&conn->list, &conns);
+
+  return(conn);
+}
+
+/* TODO: this should be a hash or tree search */
+static struct conndata* find_connection(struct sockaddr_in* sock, int 
socklen)
+{
+  struct conndata* conn;
+  struct list_head* lptr;
+
+  if(socklen != sizeof(conn->sockname)) return(NULL);
+
+  list_for_each(lptr, &conns) {
+    conn = list_entry(lptr, struct conndata, list);
+
+    if(sock->sin_addr.s_addr == conn->sockname.sin_addr.s_addr &&
+       sock->sin_port == conn->sockname.sin_port) {
+      return(conn);
+    }
+  }
+
+  return(NULL);
+}
+
+static int sockdata_hup(void* data)
+{
+  printf("Error on data fd\n");
+
+  fdpoll_remove(data_fd);
+
+  return(0);
+}
+
+static int sockdata_read(void* data)
+{
+  struct packet packet;
+  struct sockaddr_in sock;
+  int len, socklen = sizeof(sock);
+  struct conndata* conn;
+
+retry:
+  len = recvfrom(data_fd, &packet, sizeof(packet), 0,
+		 (struct sockaddr *) &sock, &socklen);
+  if(len < 0){
+    if(errno == EINTR) goto retry;
+    if(errno == EAGAIN) return(0);
+
+    perror("sockdata_read");
+    fdpoll_remove(data_fd);
+    return(0);
+  }
+
+  conn = find_connection(&sock, socklen);
+  if(!conn) {
+    if(accept_unsolicited) {
+      unsigned char* addr = (unsigned char*)&sock.sin_addr.s_addr;
+
+      fprintf(stderr, "New UDP source %u.%u.%u.%u:%d\n",
+	      addr[0], addr[1], addr[2], addr[3],
+	      ntohs(sock.sin_port));
+      conn = new_port(&sock);
+      if(conn == NULL) {
+        fprintf(stderr, "Failed UDP setup on fd %d\n", data_fd);
+        return(0);
+      }
+    } else { /* drop packet on floor */
+      return(0);
+    }
+  }
+
+  conn->seen = time(NULL);
+
+  handle_packet(conn->port_handle, &packet, len);
+
+  return(0);
+}
+
+static int bind_sockudp(int fd, int port)
+{
+  struct sockaddr_in saddr;
+
+  saddr.sin_family = AF_INET;
+  saddr.sin_port = htons(port);
+  saddr.sin_addr.s_addr = htonl(INADDR_ANY);
+
+  if(bind(fd, (struct sockaddr *)&saddr, sizeof(saddr)) < 0) {
+    perror("bind");
+    return(-1);
+  }
+
+  return(0);
+}
+
+static int new_sockdgram(void)
+{
+  int fd;
+
+  fd = socket(PF_INET, SOCK_DGRAM, 0);
+  if(fd < 0){
+    perror("socket");
+    exit(1);
+  }
+  if(fcntl(fd, F_SETFL, O_NONBLOCK) < 0){
+    perror("Setting O_NONBLOCK on data fd");
+    exit(1);
+  }
+
+  return(fd);
+}
+
+void cleanup_sockudp(void)
+{
+  if(data_fd >= 0) {
+    close(data_fd);
+    data_fd = -1;
+  }
+}
+
+int remote_udp(char* host, int port)
+{
+  struct hostent* he;
+  struct rem_data* r;
+
+  he = gethostbyname(host);
+  if(he == NULL) {
+    fprintf(stderr, "unknown host: %s\n", host);
+    exit(1);
+  }
+
+  r = malloc(sizeof(*r));
+  if(r == NULL) {
+    perror("malloc");
+    exit(1);
+  }
+
+  r->saddr.sin_family = AF_INET;
+  r->saddr.sin_port = htons(port);
+  memcpy(&r->saddr.sin_addr.s_addr, &he->h_addr_list[0][0], 4);
+
+  r->host = host;
+  r->port = port;
+
+  if(data_fd < 0) {
+    fprintf(stderr, "Preloading UDP port:  %s:%d\n", r->host, r->port);
+    list_add_tail(&r->list, &remotes);
+    return(0);
+  }
+
+  if(new_port(&r->saddr) == NULL) {
+    fprintf(stderr, "Remote UDP setup failed:  %s:%d\n", r->host, r->port);
+    free(r);
+    exit(1);
+  }
+
+  free(r);
+  return(0);
+}
+
+void init_sockudp(int port, int public)
+{
+  struct list_head* ltmp;
+  struct list_head* lptr;
+
+  if(data_fd >= 0) {
+    fprintf(stderr, "UDP socket already initialized.\n");
+    exit(1);
+  }
+
+  data_port = port;
+
+  data_fd = new_sockdgram();
+
+  if(bind_sockudp(data_fd, port) < 0) {
+    fprintf(stderr, "UDP bind on port %d failed.\n", port);
+    close(data_fd);
+    data_fd = -1;
+    exit(1);
+  }
+
+  if(tevent_add(expires/4 + 1, NULL, purge_expired) < 0) {
+    fprintf(stderr, "UDP expiry timer failed.\n");
+    close(data_fd);
+    data_fd = -1;
+    exit(1);
+  }
+
+  list_for_each_safe(lptr, ltmp, &remotes) {
+    struct rem_data* r = list_entry(lptr, struct rem_data, list);
+    struct conndata* conn;
+
+    conn = new_port(&r->saddr);
+    if(conn == NULL) {
+      fprintf(stderr, "Remote UDP setup failed:  %s:%d\n", r->host, 
r->port);
+      exit(1);
+    }
+
+    /* mark permanent so that defined routes don't get dropped */
+    conn->perm = 1;
+
+    free(r);
+  }
+
+  accept_unsolicited = public;
+
+  fdpoll_add(data_fd, NULL, sockdata_read, NULL, sockdata_hup);
+}
diff -Naur uml_router.old/sockudp.h uml_router/sockudp.h
--- uml_router.old/sockudp.h	Wed Dec 31 19:00:00 1969
+++ uml_router/sockudp.h	Mon Nov 29 18:47:09 2004
@@ -0,0 +1,12 @@
+/* Copyright 2004 Steve Schmidtke
+ * Licensed under the GPL
+ */
+
+#ifndef __SOCKUDP_H__
+#define __SOCKUDP_H__
+
+extern void cleanup_sockudp(void);
+extern int remote_udp(char* host, int port);
+extern void init_sockudp(int port, int public);
+
+#endif
diff -Naur uml_router.old/uml_switch.c uml_router/uml_switch.c
--- uml_router.old/uml_switch.c	Mon Nov 29 14:01:59 2004
+++ uml_router/uml_switch.c	Mon Nov 29 18:49:08 2004
@@ -17,6 +17,9 @@
#ifdef TUNTAP
#include "tuntap.h"
#endif
+#ifdef SOCKUDP
+#include "sockudp.h"
+#endif

#ifdef notdef
#include <stddef.h>
@@ -41,6 +44,9 @@
#ifdef TUNTAP
   cleanup_tap();
#endif
+#ifdef SOCKUDP
+  cleanup_sockudp();
+#endif
   cleanup_stdin();
   cleanup_pidfile();
}
@@ -59,6 +65,11 @@
#ifdef TUNTAP
    " [ -tap tap-device ]"
#endif
+#ifdef SOCKUDP
+   " [ -udpport port ]"
+   " [ -udpremote hostname ]"
+   " [ -udppublic ]"
+#endif
    " [ -pidfile pidfile ]"
    " [ -daemon ]";

@@ -80,6 +91,10 @@
#ifdef TUNTAP
   char *tap_dev = NULL;
#endif
+#ifdef SOCKUDP
+  int udp_port = 0;
+  int udp_pub = 0;
+#endif

   prog = argv[0];
   argv++;
@@ -118,6 +133,40 @@
       Usage();
#endif
     }
+    else if(!strcmp(argv[0], "-udpport")){
+#ifdef SOCKUDP
+      if(argc < 2)
+        Usage();
+      udp_port = atoi(argv[1]);
+      argv += 2;
+      argc -= 2;
+#else
+      fprintf(stderr, "-udpport isn't supported since SOCKUDP isn't 
enabled\n");
+      Usage();
+#endif
+    }
+    else if(!strcmp(argv[0], "-udpremote")){
+#ifdef SOCKUDP
+      if(argc < 2 || udp_port <= 0)
+        Usage();
+      remote_udp(argv[1], udp_port);
+      argv += 2;
+      argc -= 2;
+#else
+      fprintf(stderr, "-udpremote isn't supported since SOCKUDP isn't 
enabled\n");
+      Usage();
+#endif
+    }
+    else if(!strcmp(argv[0], "-udppublic")){
+#ifdef SOCKUDP
+      udp_pub = 1;
+      argv += 1;
+      argc -= 1;
+#else
+      fprintf(stderr, "-udppublic isn't supported since SOCKUDP isn't 
enabled\n");
+      Usage();
+#endif
+    }
     else if(!strcmp(argv[0], "-hub")){
       printf("%s will be a hub instead of a switch\n", progname());
       hub = 1;
@@ -163,6 +212,11 @@
   if(tap_dev != NULL)
     printf(" tap device '%s'", tap_dev);
#endif
+#ifdef SOCKUDP
+  if(udp_port > 0) {
+    printf(" UDP port '%d'", udp_port);
+  }
+#endif
   printf("\n");

   init_stdin(0);
@@ -170,6 +224,11 @@
#ifdef TUNTAP
   if(tap_dev != NULL)
     init_tap(tap_dev);
+#endif
+#ifdef SOCKUDP
+  if(udp_port > 0) {
+    init_sockudp(udp_port, udp_pub);
+  }
#endif

   if (daemonize && daemon(0, 1)) {


------=_NextPart_000_61e1_5bfc_3380--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
