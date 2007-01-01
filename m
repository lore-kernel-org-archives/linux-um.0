Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1TCs-0005oL-Uo for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 11:52:27 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H1TCq-0004y1-Bd
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 11:52:26 -0800
Message-Id: <200701011947.l01JlBRL020766@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 01 Jan 2007 14:47:11 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/8] UML - mconsole locking
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Locking fixes.  Locking was totally lacking for the mconsole_devices,
which got a spin lock, and the unplugged pages data, which got a
mutex.

The locking of the mconsole console output code was confused.  Now,
the console_lock (renamed to client_lock) protects the clients list.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/mconsole_kern.c |   21 +++++++++++++++------
 arch/um/drivers/net_kern.c      |    1 +
 arch/um/drivers/ssl.c           |    1 +
 arch/um/drivers/ubd_kern.c      |    1 +
 arch/um/kernel/tt/gdb_kern.c    |    1 +
 5 files changed, 19 insertions(+), 6 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/mconsole_kern.c	2007-01-01 11:32:22.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/mconsole_kern.c	2007-01-01 12:12:53.000000000 -0500
@@ -337,13 +337,15 @@ void mconsole_stop(struct mc_request *re
 	mconsole_reply(req, "", 0, 0);
 }
 
-/* This list is populated by __initcall routines. */
-
+static DEFINE_SPINLOCK(mc_devices_lock);
 static LIST_HEAD(mconsole_devices);
 
 void mconsole_register_dev(struct mc_device *new)
 {
+	spin_lock(&mc_devices_lock);
+	BUG_ON(!list_empty(&new->list));
 	list_add(&new->list, &mconsole_devices);
+	spin_unlock(&mc_devices_lock);
 }
 
 static struct mc_device *mconsole_find_dev(char *name)
@@ -367,6 +369,7 @@ struct unplugged_pages {
 	void *pages[UNPLUGGED_PER_PAGE];
 };
 
+static DECLARE_MUTEX(plug_mem_mutex);
 static unsigned long long unplugged_pages_count = 0;
 static struct list_head unplugged_pages = LIST_HEAD_INIT(unplugged_pages);
 static int unplug_index = UNPLUGGED_PER_PAGE;
@@ -402,6 +405,7 @@ static int mem_config(char *str, char **
 
 	diff /= PAGE_SIZE;
 
+	down(&plug_mem_mutex);
 	for(i = 0; i < diff; i++){
 		struct unplugged_pages *unplugged;
 		void *addr;
@@ -447,7 +451,7 @@ static int mem_config(char *str, char **
 					printk("Failed to release memory - "
 					       "errno = %d\n", err);
 					*error_out = "Failed to release memory";
-					goto out;
+					goto out_unlock;
 				}
 				unplugged->pages[unplug_index++] = addr;
 			}
@@ -457,6 +461,8 @@ static int mem_config(char *str, char **
 	}
 
 	err = 0;
+out_unlock:
+	up(&plug_mem_mutex);
 out:
 	return err;
 }
@@ -487,6 +493,7 @@ static int mem_remove(int n, char **erro
 }
 
 static struct mc_device mem_mc = {
+	.list		= LIST_HEAD_INIT(mem_mc.list),
 	.name		= "mem",
 	.config		= mem_config,
 	.get_config	= mem_get_config,
@@ -629,7 +636,7 @@ struct mconsole_output {
 	struct mc_request *req;
 };
 
-static DEFINE_SPINLOCK(console_lock);
+static DEFINE_SPINLOCK(client_lock);
 static LIST_HEAD(clients);
 static char console_buf[MCONSOLE_MAX_DATA];
 static int console_index = 0;
@@ -684,16 +691,18 @@ static void with_console(struct mc_reque
 	unsigned long flags;
 
 	entry.req = req;
+	spin_lock_irqsave(&client_lock, flags);
 	list_add(&entry.list, &clients);
-	spin_lock_irqsave(&console_lock, flags);
+	spin_unlock_irqrestore(&client_lock, flags);
 
 	(*proc)(arg);
 
 	mconsole_reply_len(req, console_buf, console_index, 0, 0);
 	console_index = 0;
 
-	spin_unlock_irqrestore(&console_lock, flags);
+	spin_lock_irqsave(&client_lock, flags);
 	list_del(&entry.list);
+	spin_unlock_irqrestore(&client_lock, flags);
 }
 
 #ifdef CONFIG_MAGIC_SYSRQ
Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c	2006-12-29 18:24:20.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/net_kern.c	2007-01-01 12:18:47.000000000 -0500
@@ -690,6 +690,7 @@ static int net_remove(int n, char **erro
 }
 
 static struct mc_device net_mc = {
+	.list		= LIST_HEAD_INIT(net_mc.list),
 	.name		= "eth",
 	.config		= net_config,
 	.get_config	= NULL,
Index: linux-2.6.18-mm/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/ssl.c	2006-12-29 17:26:54.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/ssl.c	2007-01-01 12:18:42.000000000 -0500
@@ -64,6 +64,7 @@ static struct line_driver driver = {
 	.symlink_from 		= "serial",
 	.symlink_to 		= "tts",
 	.mc  = {
+		.list		= LIST_HEAD_INIT(driver.mc.list),
 		.name  		= "ssl",
 		.config 	= ssl_config,
 		.get_config 	= ssl_get_config,
Index: linux-2.6.18-mm/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/ubd_kern.c	2007-01-01 11:32:24.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/ubd_kern.c	2007-01-01 12:18:52.000000000 -0500
@@ -828,6 +828,7 @@ out:
  * ubd-specific locks.
  */
 static struct mc_device ubd_mc = {
+	.list		= LIST_HEAD_INIT(ubd_mc.list),
 	.name		= "ubd",
 	.config		= ubd_config,
  	.get_config	= ubd_get_config,
Index: linux-2.6.18-mm/arch/um/kernel/tt/gdb_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/tt/gdb_kern.c	2007-01-01 11:32:21.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/tt/gdb_kern.c	2007-01-01 12:17:46.000000000 -0500
@@ -12,6 +12,7 @@ extern int gdb_config(char *str, char **
 extern int gdb_remove(int n, char **error_out);
 
 static struct mc_device gdb_mc = {
+	.list		= INIT_LIST_HEAD(gdb_mc.list),
 	.name		= "gdb",
 	.config		= gdb_config,
 	.remove		= gdb_remove,


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
