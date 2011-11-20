Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <frank.laub@gmail.com>) id 1RRwE2-0005aV-HM
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Nov 2011 01:29:42 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1RRwE1-0004iL-Q8
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Nov 2011 01:29:42 +0000
Received: by iahk25 with SMTP id k25so7119422iah.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 19 Nov 2011 17:29:36 -0800 (PST)
Message-ID: <4EC857FD.6090709@gmail.com>
Date: Sat, 19 Nov 2011 17:29:33 -0800
From: Frank Laub <frank.laub@gmail.com>
MIME-Version: 1.0
References: <4EC838CB.6080009@gmail.com> <4EC83B50.8090906@sigma-star.at>
In-Reply-To: <4EC83B50.8090906@sigma-star.at>
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
Subject: Re: [uml-devel] ]PATCH 3.03 1/1] um: VDE backend needs to handle
 EINTR/EAGAIN
Cc: user-mode-linux-devel@lists.sourceforge.net

Handle EINTR and EAGAIN during vde_send() and vde_recv() in case the VDE library doesn't. Use the same approach that net_user.c takes.

Signed-off-by: Frank Laub<flaub@anomali.es>

--- a/arch/um/drivers/vde_user.c
+++ b/arch/um/drivers/vde_user.c
@@ -11,6 +11,7 @@
  #include "um_malloc.h"
  #include "user.h"
  #include "vde.h"
+#include "os.h"

  static int vde_user_init(void *data, void *dev)
  {
@@ -103,7 +104,7 @@ int vde_user_read(void *conn, void *buf,
      if (vconn == NULL)
          return 0;

-    rv = vde_recv(vconn, buf, len, 0);
+    CATCH_EINTR(rv = vde_recv(vconn, buf, len, 0));
      if (rv < 0) {
          if (errno == EAGAIN)
              return 0;
@@ -118,10 +119,17 @@ int vde_user_read(void *conn, void *buf,
  int vde_user_write(void *conn, void *buf, int len)
  {
      VDECONN *vconn = conn;
+    int rv;

      if (vconn == NULL)
          return 0;

-    return vde_send(vconn, buf, len, 0);
+    CATCH_EINTR(rv = vde_send(vconn, buf, len, 0));
+    if (rv < 0) {
+        if (errno == EAGAIN)
+            return 0;
+        return -errno;
+    }
+    return rv;
  }


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

