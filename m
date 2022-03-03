Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPgIK-005dX4-4P
 for linux-um@lists.infradead.org; Thu, 03 Mar 2022 07:54:41 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id gm1so3501479qvb.7
 for <linux-um@lists.infradead.org>; Wed, 02 Mar 2022 23:54:39 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
Subject: [PATCH 3/4] um: port_user: Improve error handling when port-helper is
 not found
Date: Thu,  3 Mar 2022 01:53:32 -0600
Message-Id: <e17d38020164bfd224f35e57ebcc83748f399ca7.1646292328.git.development@efficientek.com>
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

Check if port-helper exists and is executable. If not, write an error
message to the kernel log with information to help the user diagnose the
issue and exit with an error. If UML_PORT_HELPER was not set, write a
message suggesting that the user set it. This makes it easier to understand
why telneting to the UML instance is failing and what can be done to fix it.

Signed-off-by: Glenn Washburn <development@efficientek.com>
---
 arch/um/drivers/port_user.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
index 3e32351dadad..3c62ae81df62 100644
--- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -5,6 +5,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
 #include <termios.h>
 #include <unistd.h>
@@ -179,6 +180,17 @@ int port_connection(int fd, int *socket, int *pid_out)
 	if (new < 0)
 		return -errno;
 
+	err = os_access(argv[2], X_OK);
+	if (err < 0) {
+		printk(UM_KERN_ERR "port_connection : error accessing port-helper "
+		       "executable at %s: %s\n", argv[2], strerror(-err));
+		if (env == NULL)
+			printk(UM_KERN_ERR "Set UML_PORT_HELPER environment "
+				"variable to path to uml-utilities port-helper "
+				"binary\n");
+		goto out_close;
+	}
+
 	err = os_pipe(socket, 0, 0);
 	if (err < 0)
 		goto out_close;
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

