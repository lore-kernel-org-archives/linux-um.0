Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPgIF-005dV8-KR
 for linux-um@lists.infradead.org; Thu, 03 Mar 2022 07:54:37 +0000
Received: by mail-qv1-xf36.google.com with SMTP id f11so3509702qvz.4
 for <linux-um@lists.infradead.org>; Wed, 02 Mar 2022 23:54:35 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
Subject: [PATCH 2/4] um: port_user: Allow setting path to port-helper using
 UML_PORT_HELPER envvar
Date: Thu,  3 Mar 2022 01:53:31 -0600
Message-Id: <6ae7e7114a5c61ae3f87d42a3e1be2e4328be9b4.1646292328.git.development@efficientek.com>
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

This is useful when the uml-utilities user-space package has not been
installed by the administrator and an unprivileged user wants to be able to
telnet into a UML instance. The user can install the port-helper binary to
a writable path and set UML_PORT_HELPER. Fallback to using hardcoded path to
port-helper if environment variable is not set.

Signed-off-by: Glenn Washburn <development@efficientek.com>
---
 arch/um/drivers/port_user.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
index 0625aa42041d..3e32351dadad 100644
--- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -167,10 +167,14 @@ static void port_pre_exec(void *arg)
 int port_connection(int fd, int *socket, int *pid_out)
 {
 	int new, err;
+	char *env;
 	char *argv[] = { "in.telnetd", "-L",
 			 OS_LIB_PATH "/uml/port-helper", NULL };
 	struct port_pre_exec_data data;
 
+	if ((env = getenv("UML_PORT_HELPER")))
+		argv[2] = env;
+
 	new = accept(fd, NULL, 0);
 	if (new < 0)
 		return -errno;
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

