Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EuFjY-0006M7-94 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 12:59:48 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EuFjY-0007gv-1I
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 12:59:48 -0800
Message-Id: <200601042152.k04Lq40R009252@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/9] UML - Capture printk output for mconsole sysrq
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
Date: Wed, 04 Jan 2006 16:52:04 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Pass sysrq output back to the mconsole client using the mechanism
introduced for stack output.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/mconsole_kern.c	2006-01-04 13:59:58.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/mconsole_kern.c	2006-01-04 14:00:45.000000000 -0500
@@ -463,24 +463,6 @@ void mconsole_remove(struct mc_request *
 	mconsole_reply(req, err_msg, err, 0);
 }
 
-#ifdef CONFIG_MAGIC_SYSRQ
-void mconsole_sysrq(struct mc_request *req)
-{
-	char *ptr = req->request.data;
-
-	ptr += strlen("sysrq");
-	while(isspace(*ptr)) ptr++;
-
-	mconsole_reply(req, "", 0, 0);
-	handle_sysrq(*ptr, &current->thread.regs, NULL);
-}
-#else
-void mconsole_sysrq(struct mc_request *req)
-{
-	mconsole_reply(req, "Sysrq not compiled in", 1, 0);
-}
-#endif
-
 static DEFINE_SPINLOCK(console_lock);
 static LIST_HEAD(clients);
 static char console_buf[MCONSOLE_MAX_DATA];
@@ -549,6 +531,36 @@ static void with_console(struct mc_reque
 	list_del(&entry.list);
 }
 
+#ifdef CONFIG_MAGIC_SYSRQ
+static void sysrq_proc(void *arg)
+{
+	char *op = arg;
+
+	handle_sysrq(*op, &current->thread.regs, NULL);
+}
+
+void mconsole_sysrq(struct mc_request *req)
+{
+	char *ptr = req->request.data;
+
+	ptr += strlen("sysrq");
+	while(isspace(*ptr)) ptr++;
+
+	/* With 'b', the system will shut down without a chance to reply,
+	 * so in this case, we reply first.
+	 */
+	if(*ptr == 'b')
+		mconsole_reply(req, "", 0, 0);
+
+	with_console(req, sysrq_proc, ptr);
+}
+#else
+void mconsole_sysrq(struct mc_request *req)
+{
+	mconsole_reply(req, "Sysrq not compiled in", 1, 0);
+}
+#endif
+
 static void stack_proc(void *arg)
 {
 	struct task_struct *from = current, *to = arg;



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
