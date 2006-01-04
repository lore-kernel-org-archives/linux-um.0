Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EtvqB-00047I-RB for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 15:45:19 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EtvqB-0000eV-9y
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jan 2006 15:45:20 -0800
Message-Id: <200601040037.k040bfiE012555@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/12] UML - Add static initializations and
	declarations
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
Date: Tue, 03 Jan 2006 19:37:41 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Some structure fields were being dynamically initialized when they
could be initialized at compile-time instead.
This also makes some declarations static (in the C sense).

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/include/line.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/line.h	2006-01-03 17:29:31.000000000 -0500
+++ linux-2.6.15/arch/um/include/line.h	2006-01-03 17:29:31.000000000 -0500
@@ -58,8 +58,8 @@ struct line {
 #define LINE_INIT(str, d) \
 	{ init_str :	str, \
 	  init_pri :	INIT_STATIC, \
-	  chan_list : 	{ }, \
 	  valid :	1, \
+	  lock :	SPIN_LOCK_UNLOCKED, \
 	  buffer :	NULL, \
 	  head :	NULL, \
 	  tail :	NULL, \
Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2006-01-03 17:29:31.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2006-01-03 17:29:31.000000000 -0500
@@ -668,19 +668,18 @@ struct tty_driver *line_register_devfs(s
 	return driver;
 }
 
-static spinlock_t winch_handler_lock;
-LIST_HEAD(winch_handlers);
+static DEFINE_SPINLOCK(winch_handler_lock);
+static LIST_HEAD(winch_handlers);
 
 void lines_init(struct line *lines, int nlines)
 {
 	struct line *line;
 	int i;
 
-	spin_lock_init(&winch_handler_lock);
 	for(i = 0; i < nlines; i++){
 		line = &lines[i];
 		INIT_LIST_HEAD(&line->chan_list);
-		spin_lock_init(&line->lock);
+
 		if(line->init_str == NULL)
 			continue;
 
Index: linux-2.6.15/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/mconsole_kern.c	2006-01-03 17:28:28.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/mconsole_kern.c	2006-01-03 17:30:12.000000000 -0500
@@ -51,7 +51,7 @@ static struct notifier_block reboot_noti
  * itself and it can only happen on CPU 0.
  */
 
-LIST_HEAD(mc_requests);
+static LIST_HEAD(mc_requests);
 
 static void mc_work_proc(void *unused)
 {
@@ -69,7 +69,7 @@ static void mc_work_proc(void *unused)
 	}
 }
 
-DECLARE_WORK(mconsole_work, mc_work_proc, NULL);
+static DECLARE_WORK(mconsole_work, mc_work_proc, NULL);
 
 static irqreturn_t mconsole_interrupt(int irq, void *dev_id,
 				      struct pt_regs *regs)
@@ -535,7 +535,7 @@ void mconsole_stack(struct mc_request *r
  */
 static char *notify_socket = NULL;
 
-int mconsole_init(void)
+static int mconsole_init(void)
 {
 	/* long to avoid size mismatch warnings from gcc */
 	long sock;
Index: linux-2.6.15/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/net_kern.c	2006-01-03 17:27:59.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/net_kern.c	2006-01-03 17:29:31.000000000 -0500
@@ -34,7 +34,7 @@
 #define DRIVER_NAME "uml-netdev"
 
 static DEFINE_SPINLOCK(opened_lock);
-LIST_HEAD(opened);
+static LIST_HEAD(opened);
 
 static int uml_net_rx(struct net_device *dev)
 {
@@ -266,7 +266,7 @@ void uml_net_user_timer_expire(unsigned 
 }
 
 static DEFINE_SPINLOCK(devices_lock);
-static struct list_head devices = LIST_HEAD_INIT(devices);
+static LIST_HEAD(devices);
 
 static struct platform_driver uml_net_driver = {
 	.driver = {



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
