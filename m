Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkXlt-00035q-R1	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 18:41:49 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DkXlt-0001zQ-4E
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 18:41:49 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050621014156.6928E9919D@zion.home.lan>
Subject: [uml-devel] [patch 1/1] uml: remove winch sem
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
Date: Tue, 21 Jun 2005 03:41:56 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Replace a semaphore (winch_handler_sem) used in atomic code with a spinlock,
and reduces as needed the amount of protected code to the bare minimum (for
instance no kmalloc calls are needed).

This fixes the last problems with spinlocking (in UP mode with DEBUG options);
the semaphore, taken inside spinlocks, caused a "spin_lock was already locked"
warning, without this patch.

Some doubts about existing code and changes are marked in the comments, so
keep this for a while into -mm.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/drivers/line.c |   37 ++++++++++++++++++-----------
 1 files changed, 24 insertions(+), 13 deletions(-)

diff -puN arch/um/drivers/line.c~uml-remove-winch-sem arch/um/drivers/line.c
--- linux-2.6.git/arch/um/drivers/line.c~uml-remove-winch-sem	2005-06-21 03:35:38.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/drivers/line.c	2005-06-21 03:37:19.000000000 +0200
@@ -648,11 +648,15 @@ struct tty_driver *line_register_devfs(s
 	return driver;
 }
 
+static spinlock_t winch_handler_lock;
+LIST_HEAD(winch_handlers);
+
 void lines_init(struct line *lines, int nlines)
 {
 	struct line *line;
 	int i;
 
+	spin_lock_init(&winch_handler_lock);
 	for(i = 0; i < nlines; i++){
 		line = &lines[i];
 		INIT_LIST_HEAD(&line->chan_list);
@@ -709,31 +713,30 @@ irqreturn_t winch_interrupt(int irq, voi
 	return IRQ_HANDLED;
 }
 
-DECLARE_MUTEX(winch_handler_sem);
-LIST_HEAD(winch_handlers);
-
 void register_winch_irq(int fd, int tty_fd, int pid, struct tty_struct *tty)
 {
 	struct winch *winch;
 
-	down(&winch_handler_sem);
 	winch = kmalloc(sizeof(*winch), GFP_KERNEL);
 	if (winch == NULL) {
 		printk("register_winch_irq - kmalloc failed\n");
-		goto out;
+		return;
 	}
+
 	*winch = ((struct winch) { .list  	= LIST_HEAD_INIT(winch->list),
 				   .fd  	= fd,
 				   .tty_fd 	= tty_fd,
 				   .pid  	= pid,
 				   .tty 	= tty });
+
+	spin_lock(&winch_handler_lock);
 	list_add(&winch->list, &winch_handlers);
+	spin_unlock(&winch_handler_lock);
+
 	if(um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
 			  SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
 			  "winch", winch) < 0)
 		printk("register_winch_irq - failed to register IRQ\n");
- out:
-	up(&winch_handler_sem);
 }
 
 static void unregister_winch(struct tty_struct *tty)
@@ -741,7 +744,7 @@ static void unregister_winch(struct tty_
 	struct list_head *ele;
 	struct winch *winch, *found = NULL;
 
-	down(&winch_handler_sem);
+	spin_lock(&winch_handler_lock);
 	list_for_each(ele, &winch_handlers){
 		winch = list_entry(ele, struct winch, list);
                 if(winch->tty == tty){
@@ -749,20 +752,25 @@ static void unregister_winch(struct tty_
                         break;
                 }
         }
-
         if(found == NULL)
-                goto out;
+		goto err;
+
+	list_del(&winch->list);
+	spin_unlock(&winch_handler_lock);
 
         if(winch->pid != -1)
                 os_kill_process(winch->pid, 1);
 
         free_irq(WINCH_IRQ, winch);
-        list_del(&winch->list);
         kfree(winch);
- out:
-	up(&winch_handler_sem);
+
+	return;
+err:
+	spin_unlock(&winch_handler_lock);
 }
 
+/* XXX: No lock as it's an exitcall... is this valid? Depending on cleanup
+ * order... are we sure that nothing else is done on the list? */
 static void winch_cleanup(void)
 {
 	struct list_head *ele;
@@ -771,6 +779,9 @@ static void winch_cleanup(void)
 	list_for_each(ele, &winch_handlers){
 		winch = list_entry(ele, struct winch, list);
 		if(winch->fd != -1){
+			/* Why is this different from the above free_irq(),
+			 * which deactivates SIGIO? This searches the FD
+			 * somewhere else and removes it from the list... */
 			deactivate_fd(winch->fd, WINCH_IRQ);
 			os_close_file(winch->fd);
 		}
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
