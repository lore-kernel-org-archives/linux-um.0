Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncGmY-008Xrv-Qu
 for linux-um@lists.infradead.org; Thu, 07 Apr 2022 01:17:59 +0000
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 3/7] um: port_user: Improve error handling when
 port-helper is not found
Date: Wed,  6 Apr 2022 21:17:36 -0400
Message-Id: <20220407011740.115717-3-sashal@kernel.org>
In-Reply-To: <20220407011740.115717-1-sashal@kernel.org>
References: <20220407011740.115717-1-sashal@kernel.org>
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
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Glenn Washburn <development@efficientek.com>, Richard Weinberger <richard@nod.at>, Sasha Levin <sashal@kernel.org>, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux-um@lists.infradead.org

From: Glenn Washburn <development@efficientek.com>

[ Upstream commit 3cb5a7f167c620a8b0e38b0446df2e024d2243dc ]

Check if port-helper exists and is executable. If not, write an error
message to the kernel log with information to help the user diagnose the
issue and exit with an error. If UML_PORT_HELPER was not set, write a
message suggesting that the user set it. This makes it easier to understand
why telneting to the UML instance is failing and what can be done to fix it.

Signed-off-by: Glenn Washburn <development@efficientek.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/port_user.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
index 9a8e1b64c22e..d3cf5db1350a 100644
--- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -5,6 +5,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
 #include <termios.h>
 #include <unistd.h>
@@ -175,6 +176,17 @@ int port_connection(int fd, int *socket, int *pid_out)
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
2.35.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

