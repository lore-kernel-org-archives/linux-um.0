Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPgIO-005dZP-5S
 for linux-um@lists.infradead.org; Thu, 03 Mar 2022 07:54:45 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id x3so3493073qvd.8
 for <linux-um@lists.infradead.org>; Wed, 02 Mar 2022 23:54:44 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
Subject: [PATCH 4/4] um: run_helper: Write error message to kernel log on exec
 failure on host
Date: Thu,  3 Mar 2022 01:53:33 -0600
Message-Id: <94ce8a8b0cac5c5142b802c4e777b2aaa8a1e682.1646292328.git.development@efficientek.com>
In-Reply-To: <cover.1646292328.git.development@efficientek.com>
References: <cover.1646292328.git.development@efficientek.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um <linux-um@lists.infradead.org>
Cc: Glenn Washburn <development@efficientek.com>

The best place to log errors from the host side is in the kernel log within
the UML guest. Letting the user now that exec() failed and why is very
helpful when the user is trying to determine why some aspect of UML is not
working. For instance, when telneting into the UML instance, if the
connection is established and then immediately dropped, this may be due to
exec() failing because in.telnetd is not found.

Signed-off-by: Glenn Washburn <development@efficientek.com>
---
 arch/um/os-Linux/helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 32e88baf18dd..b459745f52e2 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -4,6 +4,7 @@
  */
 
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include <errno.h>
 #include <sched.h>
@@ -99,6 +100,10 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 		CATCH_EINTR(waitpid(pid, NULL, __WALL));
 	}
 
+	if (ret < 0)
+		printk(UM_KERN_ERR "run_helper : failed to exec %s on host: %s\n",
+		       argv[0], strerror(-ret));
+
 out_free2:
 	kfree(data.buf);
 out_close:
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

