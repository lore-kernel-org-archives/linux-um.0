Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPgIA-005dTf-Ic
 for linux-um@lists.infradead.org; Thu, 03 Mar 2022 07:54:31 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id p8so521714qvg.12
 for <linux-um@lists.infradead.org>; Wed, 02 Mar 2022 23:54:29 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
Subject: [PATCH 1/4] um: port_user: Search for in.telnetd in PATH
Date: Thu,  3 Mar 2022 01:53:30 -0600
Message-Id: <771f13e1343d63532bf559bffdb483a11667df3b.1646292328.git.development@efficientek.com>
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

This allows in.telnetd to be run from non-standard installation locations
and is especially useful when running a UML instance as an unprivileged user
on a system where the administrator has not installed the in.telnetd binary.

Signed-off-by: Glenn Washburn <development@efficientek.com>
---
 arch/um/drivers/port_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
index 5b5b64cb1071..0625aa42041d 100644
--- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -167,7 +167,7 @@ static void port_pre_exec(void *arg)
 int port_connection(int fd, int *socket, int *pid_out)
 {
 	int new, err;
-	char *argv[] = { "/usr/sbin/in.telnetd", "-L",
+	char *argv[] = { "in.telnetd", "-L",
 			 OS_LIB_PATH "/uml/port-helper", NULL };
 	struct port_pre_exec_data data;
 
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

