Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVzKk-0007Jm-QD for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jun 2004 14:01:06 -0700
Received: from firewall.seawaynetworks.com ([216.209.86.50]
	helo=apollo.seawaynetworks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVzKj-0006Ys-Rz for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jun 2004 14:01:06 -0700
Received: from camelot-054 (camelot-054 [10.10.1.54])
	by apollo.seawaynetworks.com (8.12.8/8.12.8) with ESMTP id
	i53L0pcP001092 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 3 Jun 2004 17:00:57 -0400 (EDT)
Message-ID: <27617.1086296435@camelot-054>
From: Michael Richardson <Michael.Richardson@seawaynetworks.com>
Subject: [uml-devel] switch->netjig patch 1
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
Date: Thu, 03 Jun 2004 17:00:35 -0400
To: user-mode-linux-devel@lists.sourceforge.net


Jeff, this patch creates the file nethub.h, and moves the hub
information from uml_switch.c to this file.
(also at http://www.sandelman.ca/tmp/jig1.patch )

There is no functional change at all.



diff -x CVS -x '*~' -u -N -r uml_tools.orig/uml_router/nethub.h uml_tools/uml_router/nethub.h
--- uml_tools.orig/uml_router/nethub.h	Wed Dec 31 19:00:00 1969
+++ uml_tools/uml_router/nethub.h	Thu Jun  3 14:54:48 2004
@@ -0,0 +1,109 @@
+/*
+ * @(#) jig to exercise a UML/FreeSWAN kernel with two interfaces
+ *
+ * Copyright (C) 2001 Michael Richardson  <mcr@freeswan.org>
+ * 
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.  See <http://www.fsf.org/copyleft/gpl.txt>.
+ * 
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * RCSID $Id: nethub.h,v 1.7 2003/04/02 20:25:53 mcr Exp $
+ *
+ * @(#) based upon uml_router from User-Mode-Linux tools package
+ *
+ */
+
+#ifndef _NETHUB_H_
+
+#include <net/ethernet.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <sys/queue.h>
+#include <netinet/in.h>
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
+  unsigned long magic;
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
+  unsigned long magic;
+  int version;
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
+  unsigned long magic;
+  int version;
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
+#define HASH_SIZE 128
+#define HASH_MOD 11
+
+struct port;
+
+struct packet {
+  struct {
+    unsigned char dest[6];
+    unsigned char src[6];
+    u_int16_t     proto;
+  } header;
+  unsigned char data[1500];
+};
+
+#define xmalloc(X) xmalloc1((X), __FILE__, __LINE__)
+
+#define _NETHUB_H_
+
+#endif /* _NETHUB_H_ */
+
+/*
+ * $Log: nethub.h,v $
+ *
+ * Local variables:
+ * c-file-style: "linux"
+ * c-basic-offset: 8
+ * End:
+ *
+ */
Binary files uml_tools.orig/uml_router/uml_switch and uml_tools/uml_router/uml_switch differ
diff -x CVS -x '*~' -u -N -r uml_tools.orig/uml_router/uml_switch.c uml_tools/uml_router/uml_switch.c
--- uml_tools.orig/uml_router/uml_switch.c	Fri Aug 15 15:03:58 2003
+++ uml_tools/uml_router/uml_switch.c	Thu Jun  3 14:54:17 2004
@@ -20,6 +20,8 @@
 #include "tuntap.h"
 #endif
 
+#include "nethub.h"
+
 #ifdef notdef
 #include <stddef.h>
 #endif
@@ -27,57 +29,6 @@
 static int hub = 0;
 static int compat_v0 = 0;
 
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
 static char *ctl_socket = "/tmp/uml.ctl";
 
 static char *data_socket = NULL;
Binary files uml_tools.orig/uml_router/uml_switch.o and uml_tools/uml_router/uml_switch.o differ







-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
