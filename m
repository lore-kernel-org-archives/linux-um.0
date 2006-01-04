Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EuFjN-0006L5-3U for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 12:59:37 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EuFjL-0007A7-Pt
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 12:59:37 -0800
Message-Id: <200601042151.k04LpuTO009231@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/9] UML - SIGWINCH handling cleanup
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
Date: Wed, 04 Jan 2006 16:51:56 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Code cleanup - unregister_winch and winch_cleanup had some duplicate code.
This is now abstracted out into free_winch.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2006-01-04 13:57:45.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2006-01-04 13:58:17.000000000 -0500
@@ -774,55 +774,49 @@ void register_winch_irq(int fd, int tty_
 		printk("register_winch_irq - failed to register IRQ\n");
 }
 
+static void free_winch(struct winch *winch)
+{
+	list_del(&winch->list);
+
+	if(winch->pid != -1)
+		os_kill_process(winch->pid, 1);
+	if(winch->fd != -1)
+		os_close_file(winch->fd);
+
+	free_irq(WINCH_IRQ, winch);
+	kfree(winch);
+}
+
 static void unregister_winch(struct tty_struct *tty)
 {
 	struct list_head *ele;
-	struct winch *winch, *found = NULL;
+	struct winch *winch;
 
 	spin_lock(&winch_handler_lock);
+
 	list_for_each(ele, &winch_handlers){
 		winch = list_entry(ele, struct winch, list);
                 if(winch->tty == tty){
-                        found = winch;
-                        break;
+			free_winch(winch);
+			break;
                 }
         }
-        if(found == NULL)
-		goto err;
-
-	list_del(&winch->list);
-	spin_unlock(&winch_handler_lock);
-
-        if(winch->pid != -1)
-                os_kill_process(winch->pid, 1);
-
-        free_irq(WINCH_IRQ, winch);
-        kfree(winch);
-
-	return;
-err:
 	spin_unlock(&winch_handler_lock);
 }
 
-/* XXX: No lock as it's an exitcall... is this valid? Depending on cleanup
- * order... are we sure that nothing else is done on the list? */
 static void winch_cleanup(void)
 {
-	struct list_head *ele;
+	struct list_head *ele, *next;
 	struct winch *winch;
 
-	list_for_each(ele, &winch_handlers){
+	spin_lock(&winch_handler_lock);
+
+	list_for_each_safe(ele, next, &winch_handlers){
 		winch = list_entry(ele, struct winch, list);
-		if(winch->fd != -1){
-			/* Why is this different from the above free_irq(),
-			 * which deactivates SIGIO? This searches the FD
-			 * somewhere else and removes it from the list... */
-			deactivate_fd(winch->fd, WINCH_IRQ);
-			os_close_file(winch->fd);
-		}
-		if(winch->pid != -1)
-			os_kill_process(winch->pid, 1);
+		free_winch(winch);
 	}
+
+	spin_unlock(&winch_handler_lock);
 }
 __uml_exitcall(winch_cleanup);
 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
