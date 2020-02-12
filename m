Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1onk-0004AE-Ci
 for linux-um@lists.infradead.org; Wed, 12 Feb 2020 09:59:25 +0000
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] um: Don't use console_drivers directly
Date: Wed, 12 Feb 2020 11:59:19 +0200
Message-Id: <20200212095919.80295-1-andriy.shevchenko@linux.intel.com>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Meyer <thomas@m3y3r.de>

console_drivers is kind of (semi-)private variable to the console code.
Direct use of it make us stuck with it being exported here and there.
Reduce use of console_drivers by replacing it with for_each_console().

Cc: Thomas Meyer <thomas@m3y3r.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/um/kernel/kmsg_dump.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 98bdf69e4c2e..a8683b717f94 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -9,20 +9,20 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 				enum kmsg_dump_reason reason)
 {
 	static char line[1024];
-
+	struct console *con;
 	size_t len = 0;
-	bool con_available = false;
 
 	/* only dump kmsg when no console is available */
 	if (!console_trylock())
 		return;
 
-	if (console_drivers != NULL)
-		con_available = true;
+	/* Any registered console is fine to us */
+	for_each_console(con)
+		break;
 
 	console_unlock();
 
-	if (con_available == true)
+	if (con == NULL)
 		return;
 
 	printf("kmsg_dump:\n");
-- 
2.25.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

