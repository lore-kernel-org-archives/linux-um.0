Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWnDV-00010D-5z for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 18:49:13 -0800
Received: from bay24-f27.bay24.hotmail.com ([64.4.18.77] helo=hotmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWnDU-0001kw-UN for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 18:49:13 -0800
Message-ID: <BAY24-F27D8548BC9B2976EFF8B3883B80@phx.gbl>
From: "Steve Schmidtke" <steve_schmidtke@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_7bc2_2b91_7d1"
Subject: [uml-devel] [PATCH] uml_router: cleanup
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
Date: Wed, 24 Nov 2004 02:47:42 +0000
To: User-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_7bc2_2b91_7d1
Content-Type: text/plain; format=flowed

Hi,

While I was playing around with uml_switch, I started thinking that the code 
is a bit messy and really could use a facelift.  I decided to sit down and 
do some grunt work to reorganize the code a bit to help make any future 
modifications to the program easier and more straightforward.  Submitted for 
your inspection, testing, and hopeful addition to uml_router (from 
uml_utilites-20040406) are the following patches:

Patch 1 fixes some minor bugs I noticed while making changes.  It probably 
should be applied whether or not any of my more ambitious patches are used.  
Oh, and there's a stray core file for some reason in the directory that 
should be deleted... ;)

Patch 2 adds files that are the basis of a simple IO event dispatcher.  All 
IO processing can now be handled by a simple callback mechanisim.

Patch 3 shows how to use the IO API added in patch 2 by adding a replacement 
stdin driver.  It is over-engineered, but it is meant as an example template 
for writing other fd drivers.

Patch 4 switches everything to the new API.  I should note that these 
intermediate patches have not been tested to work, they just show how I got 
from here to there.

Patch 5 adds glue and misc stuff that would be useful if one wanted to be 
more modular and break all the driver code out of the main file.

Patch 6 (surprise) finally moves driver functions to their respective files. 
Not all is pretty (sockunix.c), but at least the code has now been coralled 
into functional groups.

There is still a bit of an ifdef hell in uml_switch.c that needs work.  It 
should be pretty straightforward to add a registration API to hide the gory 
details of hooking drivers into the system.

If there's interest in my changes so far, I'll code up some driver 
registration stuff.  It would be useful for my own work anyways.

Enjoy!

Steve Schmidtke


------=_NextPart_000_7bc2_2b91_7d1
Content-Type: text/plain; name="uml_router-1.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="uml_router-1.txt"

diff -Naur uml_router.old/port.c uml_router.new/port.c
--- uml_router.old/port.c	Wed Mar 12 10:19:03 2003
+++ uml_router.new/port.c	Sun Nov 21 14:00:51 2004
@@ -140,9 +140,13 @@
   struct packet packet;
   int len;

+retry:
   len = read(fd, &packet, sizeof(packet));
   if(len < 0){
-    if(errno != EAGAIN) perror("Reading tap data");
+    if(errno == EINTR) goto retry;
+    if(errno == EAGAIN) return;
+
+    perror("Reading tap data");
     return;
   }
   handle_data(fd, hub, &packet, len, NULL, match_tap);
@@ -204,10 +208,14 @@
   struct sock_data data;
   int len, socklen = sizeof(data.sock);

+retry:
   len = recvfrom(fd, &packet, sizeof(packet), 0,
		 (struct sockaddr *) &data.sock, &socklen);
   if(len < 0){
-    if(errno != EAGAIN) perror("handle_sock_data");
+    if(errno == EINTR) goto retry;
+    if(errno == EAGAIN) return;
+
+    perror("handle_sock_data");
     return;
   }
   data.fd = fd;
diff -Naur uml_router.old/uml_switch.c uml_router.new/uml_switch.c
--- uml_router.old/uml_switch.c	Fri Aug 15 15:03:58 2003
+++ uml_router.new/uml_switch.c	Sun Nov 21 13:47:59 2004
@@ -98,6 +98,7 @@
static struct pollfd *fds = NULL;
static int maxfds = 0;
static int nfds = 0;
+static int gc_flag = 0;

static void add_fd(int fd)
{
@@ -114,6 +115,7 @@
   p = &fds[nfds++];
   p->fd = fd;
   p->events = POLLIN;
+  p->revents = 0; /* add_fd() can be (and is) called during the poll loop 
*/
}

static void remove_fd(int fd)
@@ -125,9 +127,14 @@
   }
   if(i == nfds){
     fprintf(stderr, "remove_fd : Couldn't find descriptor %d\n", fd);
+    return;
   }
-  memmove(&fds[i], &fds[i + 1], (maxfds - i - 1) * sizeof(struct pollfd));
-  nfds--;
+
+  /* remove_fd() can be called during the poll loop. *
+   * so just flag the entry for garbage collection.  */
+  fds[i].fd = -1;
+  fds[i].revents = 0;
+  gc_flag = 1;
}

static void sig_handler(int sig)
@@ -189,12 +196,14 @@
   union request req;
   int len;

+retry:
   len = read(fd, &req, sizeof(req));
   if(len < 0){
-    if(errno != EAGAIN){
-      perror("Reading request");
-      close_descriptor(fd);
-    }
+    if(errno == EINTR) goto retry;
+    if(errno == EAGAIN) return;
+
+    perror("Reading request");
+    close_descriptor(fd);
     return;
   }
   else if(len == 0){
@@ -360,7 +369,7 @@

void bind_sockets(int ctl_fd, const char *ctl_name, int data_fd)
{
-  int err, used;
+  int err, used = 0;

   err = bind_socket(ctl_fd, ctl_name, NULL);
   if(err == 0){
@@ -385,15 +394,15 @@

static void Usage(void)
{
-  char *tap_str = "";
-
+  char *option_str = "[ -hub ]"
#ifdef TUNTAP
-  tap_str = "[ -tap tap-device ]";
+   " [ -tap tap-device ]"
#endif
+   " [ -daemon ]";

-  fprintf(stderr, "Usage : %s [ -unix control-socket ] [ -hub ] %s\n"
+  fprintf(stderr, "Usage : %s [ -unix control-socket ] %s\n"
	  "or : %s -compat-v0 [ -unix control-socket data-socket ] "
-	  "[ -hub ] %s\n", prog, tap_str, prog, tap_str);
+	  "%s\n", prog, option_str, prog, option_str);

   exit(1);
}
@@ -401,8 +410,8 @@
int main(int argc, char **argv)
{
   int connect_fd, data_fd, n, i, new, one = 1, daemonize = 0;
-  char *tap_dev = NULL;
#ifdef TUNTAP
+  char *tap_dev = NULL;
   int tap_fd  = -1;
#endif

@@ -534,10 +543,14 @@
	  goto out;
	}

+retry:
	n = read(0, buf, sizeof(buf));
	if(n < 0){
-	  perror("Reading from stdin");
-	  break;
+          if(errno == EINTR) goto retry;
+          if(errno != EAGAIN) {
+	    perror("Reading from stdin");
+	    break;
+          }
	}
	else if(n == 0){
	  printf("EOF on stdin, cleaning up and exiting\n");
@@ -560,6 +573,16 @@
	if(new) new_port(fds[i].fd, data_fd);
	else close_descriptor(fds[i].fd);
       }
+    }
+    if(gc_flag) {  /* garbage collection is now safe */
+      for(i = 0; i < nfds; i++){
+        if(fds[i].fd < 0) {
+          memmove(&fds[i], &fds[i + 1], (maxfds - i - 1) * sizeof(struct 
pollfd));
+          nfds--;
+          i--;  /* don't skip shifted entries */
+        }
+      }
+      gc_flag = 0;
     }
   }
  out:


------=_NextPart_000_7bc2_2b91_7d1
Content-Type: text/plain; name="uml_router-2.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="uml_router-2.txt"

diff -Naur uml_router.old/fdpoll.c uml_router.new/fdpoll.c
--- uml_router.old/fdpoll.c	Wed Dec 31 19:00:00 1969
+++ uml_router.new/fdpoll.c	Fri Nov 19 18:48:44 2004
@@ -0,0 +1,179 @@
+/* Copyright 2004 Steve Schmidtke
+ * Licensed under the GPL
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/poll.h>
+
+struct pollinfo {
+  int fd;
+  void* data;
+  int (*on_read)(void* data);
+  int (*on_write)(void* data);
+  int (*on_hup)(void* data);
+};
+
+static struct pollfd* fds = NULL;
+static struct pollinfo* fdi = NULL;
+static int maxfds = 0;
+static int numfds = 0;
+static int gc_count = 0;
+
+int fdpoll_add(int fd, void* data, int (*on_read)(void* data), int 
(*on_write)(void* data), int (*on_hup)(void* data))
+{
+  struct pollfd* pf;
+  struct pollinfo* pi;
+
+  if(fd < 0) return(-1);
+
+  if(gc_count > 0) {  /* there's a free nugget in there somewhere */
+    int i = numfds - 1;
+
+    while(i >= 0) {
+      if(fds[i].fd < 0) break;
+      i--;
+    }
+    if(i < 0) {  /* Aieee! this should be impossible! */
+      return(-1);
+    }
+
+    pf = &fds[i];
+    pi = &fdi[i];
+    gc_count--;
+  } else { /* append to the array */
+    if(numfds == maxfds) {
+      int newmax = maxfds ? 2 * maxfds : 4;
+      struct pollfd* newfds;
+      struct pollinfo* newfdi;
+
+      if(newmax <= 0) {  /* difficult, but overflow not technically 
impossible. */
+        return(-1);
+      }
+
+      newfdi = realloc(fdi, (size_t)newmax * sizeof(fdi[0]));
+      if(newfdi == NULL) {
+        return(-1);
+      }
+
+      newfds = realloc(fds, (size_t)newmax * sizeof(fds[0]));
+      if(newfds == NULL) {
+        return(-1);
+      }
+
+      maxfds = newmax;  /* OK to increase now */
+      fds = newfds;
+      fdi = newfdi;
+    }
+
+    pf = &fds[numfds];
+    pi = &fdi[numfds];
+    numfds++;
+  }
+
+  pf->fd = fd;
+  pf->events = 0;
+  if(on_read) {
+    pf->events |= POLLIN;
+  }
+  if(on_write) {
+    pf->events |= POLLOUT;
+  }
+  pf->revents = 0;  /* ensure fd_poll() ignores new, unpolled, entries */
+
+  pi->fd = fd;
+  pi->data = data;
+  pi->on_read = on_read;
+  pi->on_write = on_write;
+  pi->on_hup = on_hup;
+
+  return(0);
+}
+
+int fdpoll_remove(int fd)
+{
+  int i = numfds - 1;
+
+  if(fd < 0) return(-1);
+
+  while(i >= 0) {
+    if(fds[i].fd == fd) break;
+    i--;
+  }
+  if(i < 0) {
+    return(-1);
+  }
+
+  /* flag entry for garbage collection */
+  fds[i].fd = -1;
+  fds[i].events = 0;  /* poll() skips entries with no requested events */
+  fds[i].revents = 0;
+  gc_count++;
+
+  return(0);
+}
+
+#define IOCALLBACK(func, payload)  ( (func) ? (func)(payload) : 0 )
+
+/*
+ * it is important to remember that the fds and fdi arrays
+ * may be modified *while* being scanned by this function.
+ */
+int fdpoll_poll(int timeout)
+{
+  int n, i;
+
+  if(gc_count > 0) {  /* dispose of accumulated garbage */
+    i = numfds - 1;
+    while(i >= 0) {  /* think a 0->n for loop better?  think again. :) */
+      if(fds[i].fd < 0) {
+        memmove(&fds[i], &fds[i + 1], (size_t)(numfds - i - 1) * 
sizeof(fds[0]));
+        memmove(&fdi[i], &fdi[i + 1], (size_t)(numfds - i - 1) * 
sizeof(fdi[0]));
+        numfds--;
+      }
+      i--;
+    }
+
+    gc_count = 0;
+  }
+
+retry:
+  n = poll(fds, numfds, timeout);
+  if(n < 0) {
+    if(errno == EINTR) goto retry;
+
+    return(n);
+  } else {
+    for(i = 0; i < numfds; i++) {
+      if(fds[i].revents == 0) continue;
+
+  /* if a defined callback returns < 0 (an unrecoverable error), scanning *
+   * is terminated to avoid any additional events racing with the failure *
+   * Todo: better handling of unexpected states (POLLERR, POLLNVAL...)    
*/
+
+      if(fds[i].revents & (POLLIN|POLLOUT)) {
+        if(fds[i].revents & POLLOUT) {
+          if(IOCALLBACK(fdi[i].on_write, fdi[i].data) < 0) {
+            return(n);
+          }
+        }
+        if(fds[i].revents & POLLIN) {
+          if(IOCALLBACK(fdi[i].on_read, fdi[i].data) < 0) {
+            return(n);
+          }
+        }
+      } else if(fds[i].revents & POLLHUP) {
+        if(IOCALLBACK(fdi[i].on_hup, fdi[i].data) < 0) {
+          return(n);
+        }
+      } else { /* bleh, try to remap any crap not asked for to avoid 
spinning */
+        if(IOCALLBACK(fdi[i].on_hup, fdi[i].data) < 0) {
+          return(n);
+        }
+      }
+    }
+  }
+
+  return(n);
+}
diff -Naur uml_router.old/fdpoll.h uml_router.new/fdpoll.h
--- uml_router.old/fdpoll.h	Wed Dec 31 19:00:00 1969
+++ uml_router.new/fdpoll.h	Thu Nov 18 21:22:51 2004
@@ -0,0 +1,15 @@
+/* Copyright 2004 Steve Schmidtke
+ * Licensed under the GPL
+ */
+
+#ifndef __FDPOLL_H__
+#define __FDPOLL_H__
+
+extern int fdpoll_add(int fd, void* data,
+                      int (*on_read)(void* data),
+                      int (*on_write)(void* data),
+                      int (*on_hup)(void* data));
+extern int fdpoll_remove(int fd);
+extern int fdpoll_poll(int timeout);
+
+#endif


------=_NextPart_000_7bc2_2b91_7d1
Content-Type: text/plain; name="uml_router-3.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="uml_router-3.txt"

diff -Naur uml_router.old/stdin.c uml_router.new/stdin.c
--- uml_router.old/stdin.c	Wed Dec 31 19:00:00 1969
+++ uml_router.new/stdin.c	Sun Nov 21 14:24:41 2004
@@ -0,0 +1,86 @@
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "switch.h"
+#include "fdpoll.h"
+
+struct stdininfo {
+  struct stdininfo* next;
+  int fd;
+};
+
+static struct stdininfo* stdinlist = NULL;
+
+static void stdin_release(struct stdininfo* si)
+{
+  fdpoll_remove(si->fd);
+  free(si);
+}
+
+static int stdin_hup(void* data)
+{
+  printf("EOF on stdin, cleaning up and exiting\n");
+
+  quitprog();
+
+  return(-1); /* stop */
+}
+
+static int stdin_read(void* data)
+{
+  struct stdininfo* si = data;
+  char buf[128];
+  int n;
+
+retry:
+  n = read(si->fd, buf, sizeof(buf));
+  if(n < 0){
+    if(errno == EINTR) goto retry;
+    if(errno == EAGAIN) return(0);
+
+    perror("Reading from stdin");
+    stdin_release(si);
+    return(0); /* continue? */
+  } else if(n == 0){
+    printf("EOF on stdin, cleaning up and exiting\n");
+    quitprog();
+    return(-1); /* stop */
+  }
+
+  return(0); /* OK */
+}
+
+void cleanup_stdin(void)
+{
+  struct stdininfo* scan = stdinlist;
+
+  while(scan) {
+    struct stdininfo* tmp = scan->next;
+
+    stdin_release(scan);
+
+    scan = tmp;
+  }
+
+  stdinlist = NULL;
+}
+
+void init_stdin(int fd)
+{
+  struct stdininfo* si;
+
+  if(!isatty(fd))
+    return;
+
+  si = malloc(sizeof(*si));
+  if(si==NULL)
+    return;
+
+  si->fd = fd;
+  si->next = stdinlist;
+  stdinlist = si;
+
+  fdpoll_add(si->fd, si, stdin_read, NULL, stdin_hup);
+}
diff -Naur uml_router.old/stdin.h uml_router.new/stdin.h
--- uml_router.old/stdin.h	Wed Dec 31 19:00:00 1969
+++ uml_router.new/stdin.h	Sun Nov 21 14:23:23 2004
@@ -0,0 +1,11 @@
+/* Copyright 2004 Steve Schmidtke
+ * Licensed under the GPL
+ */
+
+#ifndef __STDIN_H__
+#define __STDIN_H__
+
+extern void init_stdin(int fd);
+extern void cleanup_stdin(void);
+
+#endif


------=_NextPart_000_7bc2_2b91_7d1
Content-Type: text/plain; name="uml_router-4.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="uml_router-4.txt"

diff -Naur uml_router.old/Makefile uml_router.new/Makefile
--- uml_router.old/Makefile	Fri Feb  7 23:04:39 2003
+++ uml_router.new/Makefile	Mon Nov 22 16:44:18 2004
@@ -1,6 +1,6 @@
TUNTAP = $(shell [ -e /usr/include/linux/if_tun.h ] && echo -DTUNTAP)

-OBJS = hash.o port.o uml_switch.o
+OBJS = hash.o port.o fdpoll.o stdin.o uml_switch.o
BIN = uml_switch
CFLAGS = -g -Wall $(TUNTAP)

diff -Naur uml_router.old/uml_switch.c uml_router.new/uml_switch.c
--- uml_router.old/uml_switch.c	Mon Nov 22 16:44:34 2004
+++ uml_router.new/uml_switch.c	Mon Nov 22 16:46:07 2004
@@ -16,6 +16,8 @@
#include "switch.h"
#include "port.h"
#include "hash.h"
+#include "fdpoll.h"
+#include "stdin.h"
#ifdef TUNTAP
#include "tuntap.h"
#endif
@@ -26,6 +28,11 @@

static int hub = 0;
static int compat_v0 = 0;
+static int done = 0;
+
+#ifdef TUNTAP
+static int tap_fd  = -1;
+#endif

enum request_type { REQ_NEW_CONTROL };

@@ -78,10 +85,19 @@
   struct request_v3 v3;
};

+struct portinfo {
+  struct portinfo* next;
+  int fd;
+};
+
+static struct portinfo* portlist = NULL;
+
static char *ctl_socket = "/tmp/uml.ctl";

static char *data_socket = NULL;
static struct sockaddr_un data_sun;
+static int connect_fd = -1;
+static int data_fd = -1;

static void cleanup(void)
{
@@ -95,48 +111,6 @@
   }
}

-static struct pollfd *fds = NULL;
-static int maxfds = 0;
-static int nfds = 0;
-static int gc_flag = 0;
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
-  p->revents = 0; /* add_fd() can be (and is) called during the poll loop 
*/
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
-    return;
-  }
-
-  /* remove_fd() can be called during the poll loop. *
-   * so just flag the entry for garbage collection.  */
-  fds[i].fd = -1;
-  fds[i].revents = 0;
-  gc_flag = 1;
-}
-
static void sig_handler(int sig)
{
   printf("Caught signal %d, cleaning up and exiting\n", sig);
@@ -147,9 +121,31 @@

static void close_descriptor(int fd)
{
-  remove_fd(fd);
-  close(fd);
-  close_port(fd);
+  struct portinfo* prev = NULL;
+  struct portinfo* scan = portlist;
+
+  /* find the entry */
+  while(scan) {
+    if(scan->fd == fd) break;
+
+    prev = scan;
+    scan = scan->next;
+  }
+
+  if(scan == NULL) {
+    printf("port fd %d not found\n", fd);
+    return;
+  }
+
+  /* extract entry from list */
+  if(prev == NULL) portlist = scan->next;
+  else prev->next = scan->next;
+
+  /* cleanup */
+  fdpoll_remove(scan->fd);
+  close(scan->fd);
+  close_port(scan->fd);
+  free(scan);
}

static void new_port_v0(int fd, struct request_v0 *req, int data_fd)
@@ -223,10 +219,34 @@
   else new_port_v0(fd, &req.v0, data_fd);
}

-void accept_connection(int fd)
+static int port_hup(void* data)
+{
+  struct portinfo* pi = data;
+
+  printf("Error on port fd\n");
+
+  close_descriptor(pi->fd);
+
+  return(0);
+}
+
+static int port_read(void* data)
+{
+  struct portinfo* pi = data;
+  int new;
+
+  new = handle_port(pi->fd);
+  if(new) new_port(pi->fd, data_fd);
+  else close_descriptor(pi->fd);
+
+  return(0);
+}
+
+static void accept_connection(int fd)
{
   struct sockaddr addr;
   int len, new;
+  struct portinfo* pi;

   len = sizeof(addr);
   new = accept(fd, &addr, &len);
@@ -239,7 +259,19 @@
     close(new);
     return;
   }
-  add_fd(new);
+
+  pi = malloc(sizeof(*pi));
+  if(pi == NULL) {
+    fprintf(stderr, "malloc error\n");
+    close(new);
+    return;
+  }
+
+  pi->fd = new;
+  pi->next = portlist;
+  portlist = pi;
+
+  fdpoll_add(pi->fd, pi, port_read, NULL, port_hup);
}

int still_used(struct sockaddr_un *sun)
@@ -392,6 +424,48 @@
   exit(1);
}

+static int sockconn_hup(void* data)
+{
+  printf("Error on connection fd\n");
+
+  return(0);
+}
+
+static int sockconn_read(void* data)
+{
+  accept_connection(connect_fd);
+
+  return(0);
+}
+
+static int sockdata_hup(void* data)
+{
+  printf("Error on data fd\n");
+
+  return(0);
+}
+
+static int sockdata_read(void* data)
+{
+  handle_sock_data(data_fd, hub);
+
+  return(0);
+}
+
+static int tuntap_hup(void* data)
+{
+  printf("Error on tap fd\n");
+
+  return(0);
+}
+
+static int tuntap_read(void* data)
+{
+  handle_tap_data(tap_fd, hub);
+
+  return(0);
+}
+
static void Usage(void)
{
   char *option_str = "[ -hub ]"
@@ -409,10 +483,9 @@

int main(int argc, char **argv)
{
-  int connect_fd, data_fd, n, i, new, one = 1, daemonize = 0;
+  int one = 1, daemonize = 0;
#ifdef TUNTAP
   char *tap_dev = NULL;
-  int tap_fd  = -1;
#endif

   prog = argv[0];
@@ -511,14 +584,14 @@
#endif
   printf("\n");

-  if(isatty(0))
-    add_fd(0);
-  add_fd(connect_fd);
-  add_fd(data_fd);
+  init_stdin(0);
+
+  fdpoll_add(connect_fd, NULL, sockconn_read, NULL, sockconn_hup);
+  fdpoll_add(data_fd, NULL, sockdata_read, NULL, sockdata_hup);

#ifdef TUNTAP
   if(tap_dev != NULL) tap_fd = open_tap(tap_dev);
-  if(tap_fd > -1) add_fd(tap_fd);
+  if(tap_fd > -1) fdpoll_add(tap_fd, NULL, tuntap_read, NULL, tuntap_hup);
#endif

   if (daemonize && daemon(0, 1)) {
@@ -526,66 +599,13 @@
     exit(1);
   }

-  while(1){
-    char buf[128];
-
-    n = poll(fds, nfds, -1);
-    if(n < 0){
-      if(errno == EINTR) continue;
+  while(!done){
+    if(fdpoll_poll(-1) < 0) {
       perror("poll");
-      break;
-    }
-    for(i = 0; i < nfds; i++){
-      if(fds[i].revents == 0) continue;
-      if(fds[i].fd == 0){
-	if(fds[i].revents & POLLHUP){
-	  printf("EOF on stdin, cleaning up and exiting\n");
-	  goto out;
-	}
-
-retry:
-	n = read(0, buf, sizeof(buf));
-	if(n < 0){
-          if(errno == EINTR) goto retry;
-          if(errno != EAGAIN) {
-	    perror("Reading from stdin");
-	    break;
-          }
-	}
-	else if(n == 0){
-	  printf("EOF on stdin, cleaning up and exiting\n");
-	  goto out;
-	}
-      }
-      else if(fds[i].fd == connect_fd){
-	if(fds[i].revents & POLLHUP){
-	  printf("Error on connection fd\n");
-	  continue;
-	}
-	accept_connection(connect_fd);
-      }
-      else if(fds[i].fd == data_fd) handle_sock_data(data_fd, hub);
-#ifdef TUNTAP
-      else if(fds[i].fd == tap_fd) handle_tap_data(tap_fd, hub);
-#endif
-      else {
-	new = handle_port(fds[i].fd);
-	if(new) new_port(fds[i].fd, data_fd);
-	else close_descriptor(fds[i].fd);
-      }
-    }
-    if(gc_flag) {  /* garbage collection is now safe */
-      for(i = 0; i < nfds; i++){
-        if(fds[i].fd < 0) {
-          memmove(&fds[i], &fds[i + 1], (maxfds - i - 1) * sizeof(struct 
pollfd));
-          nfds--;
-          i--;  /* don't skip shifted entries */
-        }
-      }
-      gc_flag = 0;
+      done = 1;
     }
   }
- out:
+
   cleanup();
   return 0;
}


------=_NextPart_000_7bc2_2b91_7d1
Content-Type: text/plain; name="uml_router-5.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="uml_router-5.txt"

diff -Naur uml_router.old/port.c uml_router.new/port.c
--- uml_router.old/port.c	Mon Nov 22 16:44:34 2004
+++ uml_router.new/port.c	Mon Nov 22 16:48:44 2004
@@ -8,15 +8,6 @@
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
diff -Naur uml_router.old/switch.h uml_router.new/switch.h
--- uml_router.old/switch.h	Sun Apr  7 13:57:12 2002
+++ uml_router.new/switch.h	Mon Nov 22 16:48:44 2004
@@ -7,4 +7,16 @@

#define ETH_ALEN 6

+struct packet {
+  struct {
+    unsigned char dest[ETH_ALEN];
+    unsigned char src[ETH_ALEN];
+    unsigned char proto[2];
+  } header;
+  unsigned char data[1500];
+};
+
+extern char* progname(void);
+extern void quitprog(void);
+
#endif
diff -Naur uml_router.old/uml_switch.c uml_router.new/uml_switch.c
--- uml_router.old/uml_switch.c	Mon Nov 22 16:47:59 2004
+++ uml_router.new/uml_switch.c	Mon Nov 22 16:49:56 2004
@@ -99,7 +99,19 @@
static int connect_fd = -1;
static int data_fd = -1;

-static void cleanup(void)
+static char *prog;
+
+char* progname(void)
+{
+  return(prog);
+}
+
+void quitprog(void)
+{
+  done = 1;
+}
+
+void cleanup_sockunix(void)
{
   if(unlink(ctl_socket) < 0){
     printf("Couldn't remove control socket '%s' : ", ctl_socket);
@@ -111,6 +123,11 @@
   }
}

+static void cleanup(void)
+{
+  cleanup_sockunix();
+}
+
static void sig_handler(int sig)
{
   printf("Caught signal %d, cleaning up and exiting\n", sig);
@@ -148,11 +165,11 @@
   free(scan);
}

-static void new_port_v0(int fd, struct request_v0 *req, int data_fd)
+static void new_port_v0(int fd, struct request_v0 *req, int dfd)
{
   switch(req->type){
   case REQ_NEW_CONTROL:
-    setup_sock_port(fd, &req->u.new_control.name, data_fd);
+    setup_sock_port(fd, &req->u.new_control.name, dfd);
     break;
   default:
     printf("Bad request type : %d\n", req->type);
@@ -161,13 +178,13 @@
}

static void new_port_v1_v3(int fd, enum request_type type,
-			   struct sockaddr_un *sock, int data_fd)
+			   struct sockaddr_un *sock, int dfd)
{
   int n, err;

   switch(type){
   case REQ_NEW_CONTROL:
-    err = setup_sock_port(fd, sock, data_fd);
+    err = setup_sock_port(fd, sock, dfd);
     if(err) return;
     n = write(fd, &data_sun, sizeof(data_sun));
     if(n != sizeof(data_sun)){
@@ -181,13 +198,13 @@
   }
}

-static void new_port_v2(int fd, struct request_v2 *req, int data_fd)
+static void new_port_v2(int fd, struct request_v2 *req, int dfd)
{
   fprintf(stderr, "Version 2 is not supported\n");
   close_descriptor(fd);
}

-static void new_port(int fd, int data_fd)
+static void new_port(int fd, int dfd)
{
   union request req;
   int len;
@@ -208,15 +225,15 @@
     return;
   }
   if(req.v1.magic == SWITCH_MAGIC){
-    if(req.v2.version == 2) new_port_v2(fd, &req.v2, data_fd);
+    if(req.v2.version == 2) new_port_v2(fd, &req.v2, dfd);
     if(req.v3.version == 3)
-      new_port_v1_v3(fd, req.v3.type, &req.v3.sock, data_fd);
+      new_port_v1_v3(fd, req.v3.type, &req.v3.sock, dfd);
     else if(req.v2.version > 2)
       fprintf(stderr, "Request for a version %d port, which this "
	      "uml_switch doesn't support\n", req.v2.version);
-    else new_port_v1_v3(fd, req.v1.type, &req.v1.u.new_control.name, 
data_fd);
+    else new_port_v1_v3(fd, req.v1.type, &req.v1.u.new_control.name, dfd);
   }
-  else new_port_v0(fd, &req.v0, data_fd);
+  else new_port_v0(fd, &req.v0, dfd);
}

static int port_hup(void* data)
@@ -315,10 +332,8 @@
   return(0);
}

-static char *prog;
-
void bind_sockets_v0(int ctl_fd, const char *ctl_name,
-		     int data_fd, const char *data_name)
+		     int dfd, const char *data_name)
{
   int ctl_err, ctl_present = 0, ctl_used = 0;
   int data_err, data_present = 0, data_used = 0;
@@ -328,7 +343,7 @@
   if(ctl_err != 0) ctl_present = 1;
   if(ctl_err == EADDRINUSE) ctl_used = 1;

-  data_err = bind_socket(data_fd, data_name, &data_sun);
+  data_err = bind_socket(dfd, data_name, &data_sun);
   if(data_err != 0) data_present = 1;
   if(data_err == EADDRINUSE) data_used = 1;

@@ -363,7 +378,7 @@
     else fprintf(stderr, "\tremove '%s' and '%s'\n", ctl_socket, 
data_socket);
     fprintf(stderr, "\tor rerun with different, unused filenames for "
	    "sockets:\n");
-    fprintf(stderr, "\t\t%s -unix <control> <data>\n", prog);
+    fprintf(stderr, "\t\t%s -unix <control> <data>\n", progname());
     fprintf(stderr, "\t\tand run the UMLs with "
	    "'eth0=daemon,,unix,<control>,<data>\n");
     exit(1);
@@ -371,7 +386,7 @@
   else {
     fprintf(stderr, "You should rerun with different, unused filenames for 
"
	    "sockets:\n");
-    fprintf(stderr, "\t%s -unix <control> <data>\n", prog);
+    fprintf(stderr, "\t%s -unix <control> <data>\n", progname());
     fprintf(stderr, "\tand run the UMLs with "
	    "'eth0=daemon,,unix,<control>,<data>'\n");
     exit(1);
@@ -399,13 +414,13 @@
   }
}

-void bind_sockets(int ctl_fd, const char *ctl_name, int data_fd)
+void bind_sockets(int ctl_fd, const char *ctl_name, int dfd)
{
   int err, used = 0;

   err = bind_socket(ctl_fd, ctl_name, NULL);
   if(err == 0){
-    bind_data_socket(data_fd, &data_sun);
+    bind_data_socket(dfd, &data_sun);
     return;
   }
   else if(err == EADDRINUSE) used = 1;
@@ -428,6 +443,8 @@
{
   printf("Error on connection fd\n");

+  fdpoll_remove(connect_fd);
+
   return(0);
}

@@ -442,6 +459,8 @@
{
   printf("Error on data fd\n");

+  fdpoll_remove(data_fd);
+
   return(0);
}

@@ -456,6 +475,8 @@
{
   printf("Error on tap fd\n");

+  fdpoll_remove(tap_fd);
+
   return(0);
}

@@ -476,7 +497,7 @@

   fprintf(stderr, "Usage : %s [ -unix control-socket ] %s\n"
	  "or : %s -compat-v0 [ -unix control-socket data-socket ] "
-	  "%s\n", prog, option_str, prog, option_str);
+	  "%s\n", progname(), option_str, progname(), option_str);

   exit(1);
}
@@ -519,7 +540,7 @@
#endif
     }
     else if(!strcmp(argv[0], "-hub")){
-      printf("%s will be a hub instead of a switch\n", prog);
+      printf("%s will be a hub instead of a switch\n", progname());
       hub = 1;
       argc--;
       argv++;
@@ -574,9 +595,9 @@
   hash_init();

   if(compat_v0)
-    printf("%s attached to unix sockets '%s' and '%s'", prog, ctl_socket,
+    printf("%s attached to unix sockets '%s' and '%s'", progname(), 
ctl_socket,
	   data_socket);
-  else printf("%s attached to unix socket '%s'", prog, ctl_socket);
+  else printf("%s attached to unix socket '%s'", progname(), ctl_socket);

#ifdef TUNTAP
   if(tap_dev != NULL)
@@ -602,7 +623,7 @@
   while(!done){
     if(fdpoll_poll(-1) < 0) {
       perror("poll");
-      done = 1;
+      quitprog();
     }
   }



------=_NextPart_000_7bc2_2b91_7d1
Content-Type: text/plain; name="uml_router-6.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="uml_router-6.txt"

diff -Naur uml_router.old/Makefile uml_router.new/Makefile
--- uml_router.old/Makefile	Mon Nov 22 16:47:59 2004
+++ uml_router.new/Makefile	Mon Nov 22 16:50:48 2004
@@ -1,6 +1,6 @@
TUNTAP = $(shell [ -e /usr/include/linux/if_tun.h ] && echo -DTUNTAP)

-OBJS = hash.o port.o fdpoll.o stdin.o uml_switch.o
+OBJS = hash.o port.o fdpoll.o stdin.o uml_switch.o sockunix.o
BIN = uml_switch
CFLAGS = -g -Wall $(TUNTAP)

diff -Naur uml_router.old/port.c uml_router.new/port.c
--- uml_router.old/port.c	Mon Nov 22 16:50:29 2004
+++ uml_router.new/port.c	Mon Nov 22 16:50:48 2004
@@ -101,11 +101,9 @@
   else (*target->sender)(target->control, packet, len, target->data);
}

-static void handle_data(int fd, int hub, struct packet *packet, int len,
-			void *data, int (*matcher)(int port_fd, int data_fd,
-						   void *port_data,
-						   int port_data_len,
-						   void *data))
+void handle_data(int fd, int hub, struct packet *packet, int len, void 
*data,
+		 int (*matcher)(int port_fd, int data_fd, void *port_data,
+				int port_data_len, void *data))
{
   struct port *p;

@@ -120,29 +118,6 @@
   send_dst(p, packet, len, hub);
}

-static int match_tap(int port_fd, int data_fd, void *port_data,
-		     int port_data_len, void *data)
-{
-  return(port_fd == data_fd);
-}
-
-void handle_tap_data(int fd, int hub)
-{
-  struct packet packet;
-  int len;
-
-retry:
-  len = read(fd, &packet, sizeof(packet));
-  if(len < 0){
-    if(errno == EINTR) goto retry;
-    if(errno == EAGAIN) return;
-
-    perror("Reading tap data");
-    return;
-  }
-  handle_data(fd, hub, &packet, len, NULL, match_tap);
-}
-
int setup_port(int fd, void (*sender)(int fd, void *packet, int len,
				      void *data), void *data, int data_len)
{
@@ -163,69 +138,6 @@
   head = port;
   printf("New connection\n");
   return(0);
-}
-
-struct sock_data {
-  int fd;
-  struct sockaddr_un sock;
-};
-
-static void send_sock(int fd, void *packet, int len, void *data)
-{
-  struct sock_data *mine = data;
-  int err;
-
-  err = sendto(mine->fd, packet, len, 0, (struct sockaddr *) &mine->sock,
-	       sizeof(mine->sock));
-  if(err != len){
-    fprintf(stderr, "send_sock sending to fd %d ", mine->fd);
-    perror("");
-  }
-}
-
-static int match_sock(int port_fd, int data_fd, void *port_data,
-		      int port_data_len, void *data)
-{
-  struct sock_data *mine = data;
-  struct sock_data *port = port_data;
-
-  if(port_data_len != sizeof(*mine)) return(0);
-  return(!memcmp(&port->sock, &mine->sock, sizeof(mine->sock)));
-}
-
-void handle_sock_data(int fd, int hub)
-{
-  struct packet packet;
-  struct sock_data data;
-  int len, socklen = sizeof(data.sock);
-
-retry:
-  len = recvfrom(fd, &packet, sizeof(packet), 0,
-		 (struct sockaddr *) &data.sock, &socklen);
-  if(len < 0){
-    if(errno == EINTR) goto retry;
-    if(errno == EAGAIN) return;
-
-    perror("handle_sock_data");
-    return;
-  }
-  data.fd = fd;
-
-  handle_data(fd, hub, &packet, len, &data, match_sock);
-}
-
-int setup_sock_port(int fd, struct sockaddr_un *name, int data_fd)
-{
-  struct sock_data *data;
-
-  data = malloc(sizeof(*data));
-  if(data == NULL){
-    perror("setup_sock_port");
-    return(-1);
-  }
-  *data = ((struct sock_data) { fd : 	data_fd,
-				sock :	*name });
-  return(setup_port(fd, send_sock, data, sizeof(*data)));
}

static void service_port(struct port *port)
diff -Naur uml_router.old/port.h uml_router.new/port.h
--- uml_router.old/port.h	Wed Apr 10 09:07:02 2002
+++ uml_router.new/port.h	Mon Nov 22 16:50:48 2004
@@ -9,12 +9,14 @@
#include <sys/un.h>

extern int handle_port(int fd);
+extern void handle_data(int fd, int hub, struct packet *packet, int len,
+			void *data, int (*matcher)(int port_fd, int data_fd,
+						   void *port_data,
+						   int port_data_len,
+						   void *data));
extern void close_port(int fd);
-extern int setup_sock_port(int fd, struct sockaddr_un *name, int data_fd);
extern int setup_port(int fd, void (*sender)(int fd, void *packet, int len,
					     void *data), void *data,
		      int data_len);
-extern void handle_tap_data(int fd, int hub);
-extern void handle_sock_data(int fd, int hub);

#endif
diff -Naur uml_router.old/sockunix.c uml_router.new/sockunix.c
--- uml_router.old/sockunix.c	Wed Dec 31 19:00:00 1969
+++ uml_router.new/sockunix.c	Mon Nov 22 16:50:48 2004
@@ -0,0 +1,586 @@
+/* Copyright 2001, 2002 Jeff Dike and others
+ * Licensed under the GPL
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <sys/time.h>
+#include <unistd.h>
+#include "switch.h"
+#include "port.h"
+
+#include "fdpoll.h"
+#include "stdin.h"
+#include "sockunix.h"
+
+#ifdef notdef
+#include <stddef.h>
+#endif
+
+enum request_type { REQ_NEW_CONTROL };
+
+struct request_v0 {
+  enum request_type type;
+  union {
+    struct {
+      unsigned char addr[ETH_ALEN];
+      struct sockaddr_un name;
+    } new_control;
+  } u;
+};
+
+#define SWITCH_MAGIC 0xfeedface
+
+struct request_v1 {
+  uint32_t magic;
+  enum request_type type;
+  union {
+    struct {
+      unsigned char addr[ETH_ALEN];
+      struct sockaddr_un name;
+    } new_control;
+  } u;
+};
+
+struct request_v2 {
+  uint32_t magic;
+  uint32_t version;
+  enum request_type type;
+  struct sockaddr_un sock;
+};
+
+struct reply_v2 {
+  unsigned char mac[ETH_ALEN];
+  struct sockaddr_un sock;
+};
+
+struct request_v3 {
+  uint32_t magic;
+  uint32_t version;
+  enum request_type type;
+  struct sockaddr_un sock;
+};
+
+union request {
+  struct request_v0 v0;
+  struct request_v1 v1;
+  struct request_v2 v2;
+  struct request_v3 v3;
+};
+
+struct sock_data {
+  int fd;
+  struct sockaddr_un sock;
+};
+
+struct portinfo {
+  struct portinfo* next;
+  int fd;
+};
+
+static struct portinfo* portlist = NULL;
+
+static char *ctl_socket = NULL;
+static char *data_socket = NULL;
+
+static struct sockaddr_un data_sun;
+
+static int connect_fd = -1;
+static int data_fd = -1;
+static int hub = 0;
+
+static void close_descriptor(int fd)
+{
+  struct portinfo* prev = NULL;
+  struct portinfo* scan = portlist;
+
+  /* find the entry */
+  while(scan) {
+    if(scan->fd == fd) break;
+
+    prev = scan;
+    scan = scan->next;
+  }
+
+  if(scan == NULL) {
+    printf("port fd %d not found\n", fd);
+    return;
+  }
+
+  /* extract entry from list */
+  if(prev == NULL) portlist = scan->next;
+  else prev->next = scan->next;
+
+  /* cleanup */
+  fdpoll_remove(scan->fd);
+  close(scan->fd);
+  close_port(scan->fd);
+  free(scan);
+}
+
+static void send_sock(int fd, void *packet, int len, void *data)
+{
+  struct sock_data *mine = data;
+  int err;
+
+  err = sendto(mine->fd, packet, len, 0, (struct sockaddr *) &mine->sock,
+	       sizeof(mine->sock));
+  if(err != len){
+    fprintf(stderr, "send_sock sending to fd %d ", mine->fd);
+    perror("");
+  }
+}
+
+static int setup_sock_port(int fd, struct sockaddr_un *name, int dfd)
+{
+  struct sock_data *data;
+
+  data = malloc(sizeof(*data));
+  if(data == NULL){
+    perror("setup_sock_port");
+    return(-1);
+  }
+  *data = ((struct sock_data) { fd :    dfd,
+				sock :  *name });
+  return(setup_port(fd, send_sock, data, sizeof(*data)));
+}
+
+static void new_port_v0(int fd, struct request_v0 *req, int dfd)
+{
+  switch(req->type){
+  case REQ_NEW_CONTROL:
+    setup_sock_port(fd, &req->u.new_control.name, dfd);
+    break;
+  default:
+    printf("Bad request type : %d\n", req->type);
+    close_descriptor(fd);
+  }
+}
+
+static void new_port_v1_v3(int fd, enum request_type type,
+			   struct sockaddr_un *sock, int dfd)
+{
+  int n, err;
+
+  switch(type){
+  case REQ_NEW_CONTROL:
+    err = setup_sock_port(fd, sock, dfd);
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
+static void new_port_v2(int fd, struct request_v2 *req, int dfd)
+{
+  fprintf(stderr, "Version 2 is not supported\n");
+  close_descriptor(fd);
+}
+
+static void new_port(int fd, int dfd)
+{
+  union request req;
+  int len;
+
+retry:
+  len = read(fd, &req, sizeof(req));
+  if(len < 0){
+    if(errno == EINTR) goto retry;
+    if(errno == EAGAIN) return;
+
+    perror("Reading request");
+    close_descriptor(fd);
+    return;
+  }
+  else if(len == 0){
+    printf("EOF from new port\n");
+    close_descriptor(fd);
+    return;
+  }
+  if(req.v1.magic == SWITCH_MAGIC){
+    if(req.v2.version == 2) new_port_v2(fd, &req.v2, dfd);
+    if(req.v3.version == 3)
+      new_port_v1_v3(fd, req.v3.type, &req.v3.sock, dfd);
+    else if(req.v2.version > 2)
+      fprintf(stderr, "Request for a version %d port, which this "
+	      "uml_switch doesn't support\n", req.v2.version);
+    else new_port_v1_v3(fd, req.v1.type, &req.v1.u.new_control.name, dfd);
+  }
+  else new_port_v0(fd, &req.v0, dfd);
+}
+
+static int port_hup(void* data)
+{
+  struct portinfo* pi = data;
+
+  printf("Error on port fd\n");
+
+  close_descriptor(pi->fd);
+
+  return(0);
+}
+
+static int port_read(void* data)
+{
+  struct portinfo* pi = data;
+  int new;
+
+  new = handle_port(pi->fd);
+  if(new) new_port(pi->fd, data_fd);
+  else close_descriptor(pi->fd);
+
+  return(0);
+}
+
+static void accept_connection(int fd)
+{
+  struct sockaddr addr;
+  int len, new;
+  struct portinfo* pi;
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
+
+  pi = malloc(sizeof(*pi));
+  if(pi == NULL) {
+    fprintf(stderr, "malloc error\n");
+    close(new);
+    return;
+  }
+
+  pi->fd = new;
+  pi->next = portlist;
+  portlist = pi;
+
+  fdpoll_add(pi->fd, pi, port_read, NULL, port_hup);
+}
+
+static int still_used(struct sockaddr_un *sun)
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
+static int bind_socket(int fd, const char *name, struct sockaddr_un 
*sock_out)
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
+static void bind_sockets_v0(int ctl_fd, const char *ctl_name,
+		     int dfd, const char *data_name)
+{
+  int ctl_err, ctl_present = 0, ctl_used = 0;
+  int data_err, data_present = 0, data_used = 0;
+  int try_remove_ctl, try_remove_data;
+
+  ctl_err = bind_socket(ctl_fd, ctl_name, NULL);
+  if(ctl_err != 0) ctl_present = 1;
+  if(ctl_err == EADDRINUSE) ctl_used = 1;
+
+  data_err = bind_socket(dfd, data_name, &data_sun);
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
+    fprintf(stderr, "The control socket '%s' exists, isn't used, but 
couldn't "
+	    "be removed\n", ctl_name);
+  if(data_present && data_used){
+    fprintf(stderr, "The data socket '%s' has another server "
+	    "attached to it\n", data_name);
+    try_remove_data = 0;
+  }
+  else if(data_present && !data_used)
+    fprintf(stderr, "The data socket '%s' exists, isn't used, but couldn't 
"
+	    "be removed\n", data_name);
+  if(try_remove_ctl || try_remove_data){
+    fprintf(stderr, "You can either\n");
+    if(try_remove_ctl && !try_remove_data)
+      fprintf(stderr, "\tremove '%s'\n", ctl_socket);
+    else if(!try_remove_ctl && try_remove_data)
+      fprintf(stderr, "\tremove '%s'\n", data_socket);
+    else fprintf(stderr, "\tremove '%s' and '%s'\n", ctl_socket, 
data_socket);
+    fprintf(stderr, "\tor rerun with different, unused filenames for "
+	    "sockets:\n");
+    fprintf(stderr, "\t\t%s -unix <control> <data>\n", progname());
+    fprintf(stderr, "\t\tand run the UMLs with "
+	    "'eth0=daemon,,unix,<control>,<data>\n");
+    exit(1);
+  }
+  else {
+    fprintf(stderr, "You should rerun with different, unused filenames for 
"
+	    "sockets:\n");
+    fprintf(stderr, "\t%s -unix <control> <data>\n", progname());
+    fprintf(stderr, "\tand run the UMLs with "
+	    "'eth0=daemon,,unix,<control>,<data>'\n");
+    exit(1);
+  }
+}
+
+static void bind_data_socket(int fd, struct sockaddr_un *sun)
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
+static void bind_sockets(int ctl_fd, const char *ctl_name, int dfd)
+{
+  int err, used = 0;
+
+  err = bind_socket(ctl_fd, ctl_name, NULL);
+  if(err == 0){
+    bind_data_socket(dfd, &data_sun);
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
+    fprintf(stderr, "The control socket '%s' exists, isn't used, but 
couldn't "
+	    "be removed\n", ctl_name);
+  exit(1);
+}
+
+static int sockconn_hup(void* data)
+{
+  printf("Error on connection fd\n");
+
+  fdpoll_remove(connect_fd);
+
+  return(0);
+}
+
+static int sockconn_read(void* data)
+{
+  accept_connection(connect_fd);
+
+  return(0);
+}
+
+static int match_sock(int port_fd, int dfd, void *port_data,
+                      int port_data_len, void *data)
+{
+  struct sock_data *mine = data;
+  struct sock_data *port = port_data;
+
+  if(port_data_len != sizeof(*mine)) return(0);
+  return(!memcmp(&port->sock, &mine->sock, sizeof(mine->sock)));
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
+  struct sock_data sdata;
+  int len, socklen = sizeof(sdata.sock);
+
+retry:
+  len = recvfrom(data_fd, &packet, sizeof(packet), 0,
+		 (struct sockaddr *) &sdata.sock, &socklen);
+  if(len < 0){
+    if(errno == EINTR) goto retry;
+    if(errno == EAGAIN) return(0);
+
+    perror("sockdata_read");
+    fdpoll_remove(data_fd);
+    return(0);
+  }
+  sdata.fd = data_fd;
+
+  handle_data(data_fd, hub, &packet, len, &sdata, match_sock);
+
+  return(0);
+}
+
+static int new_sockstream()
+{
+  int one = 1;
+  int fd;
+
+  fd = socket(PF_UNIX, SOCK_STREAM, 0);
+  if(fd < 0){
+    perror("socket");
+    exit(1);
+  }
+  if(setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, (char *) &one,
+		sizeof(one)) < 0){
+    perror("setsockopt");
+    exit(1);
+  }
+  if(fcntl(fd, F_SETFL, O_NONBLOCK) < 0){
+    perror("Setting O_NONBLOCK on connection fd");
+    exit(1);
+  }
+
+  return(fd);
+}
+
+static int new_sockdgram()
+{
+  int fd;
+
+  fd = socket(PF_UNIX, SOCK_DGRAM, 0);
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
+void cleanup_sockunix(void)
+{
+  if((ctl_socket != NULL) && (unlink(ctl_socket) < 0)){
+    printf("Couldn't remove control socket '%s' : ", ctl_socket);
+    perror("");
+  }
+  if((data_socket != NULL) && (unlink(data_socket) < 0)){
+    printf("Couldn't remove data socket '%s' : ", data_socket);
+    perror("");
+  }
+}
+
+void init_sockunix_v0(char* ctl_name, char* data_name, int hubflag)
+{
+  if(connect_fd >= 0) {
+    fprintf(stderr, "Connection socket already initialized.\n");
+    exit(1);
+  }
+
+  ctl_socket = ctl_name;
+  data_socket = data_name;
+  hub = hubflag;
+
+  connect_fd = new_sockstream();
+  data_fd = new_sockdgram();
+
+  bind_sockets_v0(connect_fd, ctl_socket, data_fd, data_socket);
+
+  if(listen(connect_fd, 15) < 0){
+    perror("listen");
+    exit(1);
+  }
+
+  fdpoll_add(connect_fd, NULL, sockconn_read, NULL, sockconn_hup);
+  fdpoll_add(data_fd, NULL, sockdata_read, NULL, sockdata_hup);
+}
+
+void init_sockunix(char* ctl_name, int hubflag)
+{
+  if(connect_fd >= 0) {
+    fprintf(stderr, "Connection socket already initialized.\n");
+    exit(1);
+  }
+
+  ctl_socket = ctl_name;
+  data_socket = NULL;
+  hub = hubflag;
+
+  connect_fd = new_sockstream();
+  data_fd = new_sockdgram();
+
+  bind_sockets(connect_fd, ctl_socket, data_fd);
+
+  if(listen(connect_fd, 15) < 0){
+    perror("listen");
+    exit(1);
+  }
+
+  fdpoll_add(connect_fd, NULL, sockconn_read, NULL, sockconn_hup);
+  fdpoll_add(data_fd, NULL, sockdata_read, NULL, sockdata_hup);
+}
diff -Naur uml_router.old/sockunix.h uml_router.new/sockunix.h
--- uml_router.old/sockunix.h	Wed Dec 31 19:00:00 1969
+++ uml_router.new/sockunix.h	Mon Nov 22 16:50:48 2004
@@ -0,0 +1,12 @@
+/* Copyright 2004 Steve Schmidtke
+ * Licensed under the GPL
+ */
+
+#ifndef __SOCKUNIX_H__
+#define __SOCKUNIX_H__
+
+extern void cleanup_sockunix(void);
+extern void init_sockunix_v0(char* ctl_name, char* data_name, int hubflag);
+extern void init_sockunix(char* ctl_name, int hubflag);
+
+#endif
diff -Naur uml_router.old/tuntap.c uml_router.new/tuntap.c
--- uml_router.old/tuntap.c	Tue Apr 23 20:13:30 2002
+++ uml_router.new/tuntap.c	Mon Nov 22 16:50:48 2004
@@ -6,7 +6,13 @@
#include <sys/ioctl.h>
#include <net/if.h>
#include <linux/if_tun.h>
+#include "switch.h"
#include "port.h"
+#include "fdpoll.h"
+
+static char* tap_dev = NULL;
+static int tap_fd = -1;
+static int hub = 0;

static void send_tap(int fd, void *packet, int len, void *unused)
{
@@ -18,7 +24,42 @@
   }
}

-int open_tap(char *dev)
+static int match_tap(int port_fd, int data_fd, void *port_data,
+                     int port_data_len, void *data)
+{
+  return(port_fd == data_fd);
+}
+
+static int tuntap_hup(void* data)
+{
+  printf("Error on tap fd\n");
+
+  fdpoll_remove(tap_fd);
+
+  return(0);
+}
+
+static int tuntap_read(void* data)
+{
+  struct packet packet;
+  int len;
+
+retry:
+  len = read(tap_fd, &packet, sizeof(packet));
+  if(len < 0){
+    if(errno == EINTR) goto retry;
+    if(errno == EAGAIN) return(0);
+
+    perror("Reading tap data");
+    fdpoll_remove(tap_fd);
+    return(0);
+  }
+  handle_data(tap_fd, hub, &packet, len, NULL, match_tap);
+
+  return(0);
+}
+
+static int open_tap(char *dev)
{
   struct ifreq ifr;
   int fd, err;
@@ -38,5 +79,35 @@
   err = setup_port(fd, send_tap, NULL, 0);
   if(err) return(err);
   return(fd);
+}
+
+void cleanup_tap(void)
+{
+  if(tap_fd >= 0) {
+    fdpoll_remove(tap_fd);
+    close(tap_fd);
+  }
+
+  tap_fd = -1;
+  tap_dev = NULL;
+}
+
+void init_tap(char* tap_name, int hubflag)
+{
+  if(tap_fd >= 0) {
+    fprintf(stderr, "Tun/Tap already initialized.\n");
+    exit(1);
+  }
+
+  tap_dev = tap_name;
+  hub = hubflag;
+
+  tap_fd = open_tap(tap_dev);
+  if(tap_fd<0) {
+    fprintf(stderr, "Tun/Tap open failed.\n");
+    exit(1);
+  }
+
+  fdpoll_add(tap_fd, NULL, tuntap_read, NULL, tuntap_hup);
}

diff -Naur uml_router.old/tuntap.h uml_router.new/tuntap.h
--- uml_router.old/tuntap.h	Wed Apr 10 07:21:56 2002
+++ uml_router.new/tuntap.h	Mon Nov 22 16:50:48 2004
@@ -5,7 +5,7 @@
#ifndef __TUNTAP_H__
#define __TUNTAP_H__

-extern int open_tap(char *dev);
-extern void handle_tap(int fd, int hub);
+extern void cleanup_tap(void);
+extern void init_tap(char* tap_name, int hub);

#endif
diff -Naur uml_router.old/uml_switch.c uml_router.new/uml_switch.c
--- uml_router.old/uml_switch.c	Mon Nov 22 16:50:29 2004
+++ uml_router.new/uml_switch.c	Mon Nov 22 16:50:48 2004
@@ -3,21 +3,16 @@
  */

#include <stdio.h>
-#include <errno.h>
#include <stdlib.h>
#include <signal.h>
#include <fcntl.h>
-#include <stdint.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-#include <sys/poll.h>
-#include <sys/time.h>
#include <unistd.h>
#include "switch.h"
#include "port.h"
#include "hash.h"
#include "fdpoll.h"
#include "stdin.h"
+#include "sockunix.h"
#ifdef TUNTAP
#include "tuntap.h"
#endif
@@ -26,79 +21,7 @@
#include <stddef.h>
#endif

-static int hub = 0;
-static int compat_v0 = 0;
static int done = 0;
-
-#ifdef TUNTAP
-static int tap_fd  = -1;
-#endif
-
-enum request_type { REQ_NEW_CONTROL };
-
-struct request_v0 {
-  enum request_type type;
-  union {
-    struct {
-      unsigned char addr[ETH_ALEN];
-      struct sockaddr_un name;
-    } new_control;
-  } u;
-};
-
-#define SWITCH_MAGIC 0xfeedface
-
-struct request_v1 {
-  uint32_t magic;
-  enum request_type type;
-  union {
-    struct {
-      unsigned char addr[ETH_ALEN];
-      struct sockaddr_un name;
-    } new_control;
-  } u;
-};
-
-struct request_v2 {
-  uint32_t magic;
-  uint32_t version;
-  enum request_type type;
-  struct sockaddr_un sock;
-};
-
-struct reply_v2 {
-  unsigned char mac[ETH_ALEN];
-  struct sockaddr_un sock;
-};
-
-struct request_v3 {
-  uint32_t magic;
-  uint32_t version;
-  enum request_type type;
-  struct sockaddr_un sock;
-};
-
-union request {
-  struct request_v0 v0;
-  struct request_v1 v1;
-  struct request_v2 v2;
-  struct request_v3 v3;
-};
-
-struct portinfo {
-  struct portinfo* next;
-  int fd;
-};
-
-static struct portinfo* portlist = NULL;
-
-static char *ctl_socket = "/tmp/uml.ctl";
-
-static char *data_socket = NULL;
-static struct sockaddr_un data_sun;
-static int connect_fd = -1;
-static int data_fd = -1;
-
static char *prog;

char* progname(void)
@@ -111,21 +34,13 @@
   done = 1;
}

-void cleanup_sockunix(void)
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
static void cleanup(void)
{
   cleanup_sockunix();
+#ifdef TUNTAP
+  cleanup_tap();
+#endif
+  cleanup_stdin();
}

static void sig_handler(int sig)
@@ -136,357 +51,6 @@
   kill(getpid(), sig);
}

-static void close_descriptor(int fd)
-{
-  struct portinfo* prev = NULL;
-  struct portinfo* scan = portlist;
-
-  /* find the entry */
-  while(scan) {
-    if(scan->fd == fd) break;
-
-    prev = scan;
-    scan = scan->next;
-  }
-
-  if(scan == NULL) {
-    printf("port fd %d not found\n", fd);
-    return;
-  }
-
-  /* extract entry from list */
-  if(prev == NULL) portlist = scan->next;
-  else prev->next = scan->next;
-
-  /* cleanup */
-  fdpoll_remove(scan->fd);
-  close(scan->fd);
-  close_port(scan->fd);
-  free(scan);
-}
-
-static void new_port_v0(int fd, struct request_v0 *req, int dfd)
-{
-  switch(req->type){
-  case REQ_NEW_CONTROL:
-    setup_sock_port(fd, &req->u.new_control.name, dfd);
-    break;
-  default:
-    printf("Bad request type : %d\n", req->type);
-    close_descriptor(fd);
-  }
-}
-
-static void new_port_v1_v3(int fd, enum request_type type,
-			   struct sockaddr_un *sock, int dfd)
-{
-  int n, err;
-
-  switch(type){
-  case REQ_NEW_CONTROL:
-    err = setup_sock_port(fd, sock, dfd);
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
-static void new_port_v2(int fd, struct request_v2 *req, int dfd)
-{
-  fprintf(stderr, "Version 2 is not supported\n");
-  close_descriptor(fd);
-}
-
-static void new_port(int fd, int dfd)
-{
-  union request req;
-  int len;
-
-retry:
-  len = read(fd, &req, sizeof(req));
-  if(len < 0){
-    if(errno == EINTR) goto retry;
-    if(errno == EAGAIN) return;
-
-    perror("Reading request");
-    close_descriptor(fd);
-    return;
-  }
-  else if(len == 0){
-    printf("EOF from new port\n");
-    close_descriptor(fd);
-    return;
-  }
-  if(req.v1.magic == SWITCH_MAGIC){
-    if(req.v2.version == 2) new_port_v2(fd, &req.v2, dfd);
-    if(req.v3.version == 3)
-      new_port_v1_v3(fd, req.v3.type, &req.v3.sock, dfd);
-    else if(req.v2.version > 2)
-      fprintf(stderr, "Request for a version %d port, which this "
-	      "uml_switch doesn't support\n", req.v2.version);
-    else new_port_v1_v3(fd, req.v1.type, &req.v1.u.new_control.name, dfd);
-  }
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
-
-  return(0);
-}
-
-static void accept_connection(int fd)
-{
-  struct sockaddr addr;
-  int len, new;
-  struct portinfo* pi;
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
-
-  pi = malloc(sizeof(*pi));
-  if(pi == NULL) {
-    fprintf(stderr, "malloc error\n");
-    close(new);
-    return;
-  }
-
-  pi->fd = new;
-  pi->next = portlist;
-  portlist = pi;
-
-  fdpoll_add(pi->fd, pi, port_read, NULL, port_hup);
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
-void bind_sockets_v0(int ctl_fd, const char *ctl_name,
-		     int dfd, const char *data_name)
-{
-  int ctl_err, ctl_present = 0, ctl_used = 0;
-  int data_err, data_present = 0, data_used = 0;
-  int try_remove_ctl, try_remove_data;
-
-  ctl_err = bind_socket(ctl_fd, ctl_name, NULL);
-  if(ctl_err != 0) ctl_present = 1;
-  if(ctl_err == EADDRINUSE) ctl_used = 1;
-
-  data_err = bind_socket(dfd, data_name, &data_sun);
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
-    fprintf(stderr, "The control socket '%s' exists, isn't used, but 
couldn't "
-	    "be removed\n", ctl_name);
-  if(data_present && data_used){
-    fprintf(stderr, "The data socket '%s' has another server "
-	    "attached to it\n", data_name);
-    try_remove_data = 0;
-  }
-  else if(data_present && !data_used)
-    fprintf(stderr, "The data socket '%s' exists, isn't used, but couldn't 
"
-	    "be removed\n", data_name);
-  if(try_remove_ctl || try_remove_data){
-    fprintf(stderr, "You can either\n");
-    if(try_remove_ctl && !try_remove_data)
-      fprintf(stderr, "\tremove '%s'\n", ctl_socket);
-    else if(!try_remove_ctl && try_remove_data)
-      fprintf(stderr, "\tremove '%s'\n", data_socket);
-    else fprintf(stderr, "\tremove '%s' and '%s'\n", ctl_socket, 
data_socket);
-    fprintf(stderr, "\tor rerun with different, unused filenames for "
-	    "sockets:\n");
-    fprintf(stderr, "\t\t%s -unix <control> <data>\n", progname());
-    fprintf(stderr, "\t\tand run the UMLs with "
-	    "'eth0=daemon,,unix,<control>,<data>\n");
-    exit(1);
-  }
-  else {
-    fprintf(stderr, "You should rerun with different, unused filenames for 
"
-	    "sockets:\n");
-    fprintf(stderr, "\t%s -unix <control> <data>\n", progname());
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
-void bind_sockets(int ctl_fd, const char *ctl_name, int dfd)
-{
-  int err, used = 0;
-
-  err = bind_socket(ctl_fd, ctl_name, NULL);
-  if(err == 0){
-    bind_data_socket(dfd, &data_sun);
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
-    fprintf(stderr, "The control socket '%s' exists, isn't used, but 
couldn't "
-	    "be removed\n", ctl_name);
-  exit(1);
-}
-
-static int sockconn_hup(void* data)
-{
-  printf("Error on connection fd\n");
-
-  fdpoll_remove(connect_fd);
-
-  return(0);
-}
-
-static int sockconn_read(void* data)
-{
-  accept_connection(connect_fd);
-
-  return(0);
-}
-
-static int sockdata_hup(void* data)
-{
-  printf("Error on data fd\n");
-
-  fdpoll_remove(data_fd);
-
-  return(0);
-}
-
-static int sockdata_read(void* data)
-{
-  handle_sock_data(data_fd, hub);
-
-  return(0);
-}
-
-static int tuntap_hup(void* data)
-{
-  printf("Error on tap fd\n");
-
-  fdpoll_remove(tap_fd);
-
-  return(0);
-}
-
-static int tuntap_read(void* data)
-{
-  handle_tap_data(tap_fd, hub);
-
-  return(0);
-}
-
static void Usage(void)
{
   char *option_str = "[ -hub ]"
@@ -504,7 +68,11 @@

int main(int argc, char **argv)
{
-  int one = 1, daemonize = 0;
+  char *ctl_name = "/tmp/uml.ctl";
+  char *data_name = NULL;
+  int daemonize = 0;
+  int hub = 0;
+  int compat_v0 = 0;
#ifdef TUNTAP
   char *tap_dev = NULL;
#endif
@@ -516,14 +84,14 @@
     if(!strcmp(argv[0], "-unix")){
       if(argc < 2)
	Usage();
-      ctl_socket = argv[1];
+      ctl_name = argv[1];
       argc -= 2;
       argv += 2;
       if(!compat_v0)
	continue;
       if(argc < 1)
	Usage();
-      data_socket = argv[0];
+      data_name = argv[0];
       argc--;
       argv++;
     }
@@ -548,7 +116,7 @@
     else if(!strcmp(argv[0], "-compat-v0")){
       printf("Control protocol 0 compatibility\n");
       compat_v0 = 1;
-      data_socket = "/tmp/uml.data";
+      data_name = "/tmp/uml.data";
       argc--;
       argv++;
     }
@@ -560,44 +128,17 @@
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
-  if(compat_v0) bind_sockets_v0(connect_fd, ctl_socket, data_fd, 
data_socket);
-  else bind_sockets(connect_fd, ctl_socket, data_fd);
-
-  if(listen(connect_fd, 15) < 0){
-    perror("listen");
-    exit(1);
-  }
+  if(compat_v0) init_sockunix_v0(ctl_name, data_name, hub);
+  else init_sockunix(ctl_name, hub);

   if(signal(SIGINT, sig_handler) < 0)
     perror("Setting handler for SIGINT");
   hash_init();

   if(compat_v0)
-    printf("%s attached to unix sockets '%s' and '%s'", progname(), 
ctl_socket,
-	   data_socket);
-  else printf("%s attached to unix socket '%s'", progname(), ctl_socket);
+    printf("%s attached to unix sockets '%s' and '%s'", progname(),
+	   ctl_name, data_name);
+  else printf("%s attached to unix socket '%s'", progname(), ctl_name);

#ifdef TUNTAP
   if(tap_dev != NULL)
@@ -607,12 +148,9 @@

   init_stdin(0);

-  fdpoll_add(connect_fd, NULL, sockconn_read, NULL, sockconn_hup);
-  fdpoll_add(data_fd, NULL, sockdata_read, NULL, sockdata_hup);
-
#ifdef TUNTAP
-  if(tap_dev != NULL) tap_fd = open_tap(tap_dev);
-  if(tap_fd > -1) fdpoll_add(tap_fd, NULL, tuntap_read, NULL, tuntap_hup);
+  if(tap_dev != NULL)
+    init_tap(tap_dev, hub);
#endif

   if (daemonize && daemon(0, 1)) {


------=_NextPart_000_7bc2_2b91_7d1--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
