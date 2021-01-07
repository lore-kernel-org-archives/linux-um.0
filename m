Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from www17.your-server.de ([213.133.104.17])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxQIr-0006Ac-H3
 for linux-um@lists.infradead.org; Thu, 07 Jan 2021 08:05:54 +0000
From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] um: kmsg_dumper: always dump when not tty console
Date: Thu,  7 Jan 2021 09:05:31 +0100
Message-Id: <20210107080531.17936-1-thomas@m3y3r.de>
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
To: richard@nod.at, linux-um@lists.infradead.org
Cc: Thomas Meyer <thomas@m3y3r.de>

With the addition of the ttynull console driver, the chance that a
console driver was already registerd did increase. Refine the logic when
to dump the kernel message buffer: always dump the buffer, when the UML
stdio console driver is not active and the preferred console.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/kernel/kmsg_dump.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index e4abac6c9727..9dd91fc09421 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kmsg_dump.h>
 #include <linux/console.h>
+#include <linux/string.h>
 #include <shared/init.h>
 #include <shared/kern.h>
 #include <os.h>
@@ -16,8 +17,12 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 	if (!console_trylock())
 		return;
 
-	for_each_console(con)
-		break;
+	for_each_console(con) {
+		if(strcmp(con->name, "tty") == 0 &&
+		  con->flags & (CON_ENABLED | CON_CONSDEV) != 0) {
+			break;
+		}
+	}
 
 	console_unlock();
 
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

