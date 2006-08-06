Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G9kng-0002d2-4y for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Aug 2006 08:44:24 -0700
Received: from host17-96.pool873.interbusiness.it ([87.3.96.17]
	helo=memento.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1G9knf-0006hA-BP for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Aug 2006 08:44:24 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sun, 06 Aug 2006 17:44:31 +0200
Message-Id: <20060806154431.32159.74360.stgit@memento.home.lan>
Subject: [uml-devel] [PATCH] [RFC] uml: make activate_fd atomic
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Also, fix a bit of issues in activate_fd().
It's not up-to-date wrt comment vs. code.

I had this patch in my queue since some time, because it fixes some spinlocks vs
sleeps issues; please verify whether after your restructuring it is still
needed (it applied before this restructuring).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/kernel/irq.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 589c69a..a5da95f 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -124,7 +124,7 @@ int activate_fd(int irq, int fd, int typ
 	if (err < 0)
 		goto out;
 
-	new_fd = um_kmalloc(sizeof(*new_fd));
+	new_fd = um_kmalloc_atomic(sizeof(*new_fd));
 	err = -ENOMEM;
 	if (new_fd == NULL)
 		goto out;
@@ -145,15 +145,17 @@ int activate_fd(int irq, int fd, int typ
 	/* Critical section - locked by a spinlock because this stuff can
 	 * be changed from interrupt handlers.  The stuff above is done
 	 * outside the lock because it allocates memory.
+	 * Also, we can be called with spinlocks held - see
+	 * write_sigio_workaround->write_sigio_irq->um_request_irq->activate_fd.
 	 */
 
 	/* Actually, it only looks like it can be called from interrupt
 	 * context.  The culprit is reactivate_fd, which calls
 	 * maybe_sigio_broken, which calls write_sigio_workaround,
 	 * which calls activate_fd.  However, write_sigio_workaround should
-	 * only be called once, at boot time.  That would make it clear that
-	 * this is called only from process context, and can be locked with
-	 * a semaphore.
+	 * only be called once, at boot time.
+	 * However we can be still called (once) under spinlocks, so we need
+	 * anyway a semaphore.
 	 */
 	spin_lock_irqsave(&irq_lock, flags);
 	for (irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next) {
@@ -182,21 +184,19 @@ int activate_fd(int irq, int fd, int typ
 		 * and tmp_fds is NULL or too small for new pollfds array.
 		 * Needed size is equal to n as minimum.
 		 *
-		 * Here we have to drop the lock in order to call
-		 * kmalloc, which might sleep.
-		 * If something else came in and changed the pollfds array
+		 * We don't drop the lock any more; when we dropped it, we
+		 * needed to loop:
+		 * "If something else came in and changed the pollfds array
 		 * so we will not be able to put new pollfd struct to pollfds
-		 * then we free the buffer tmp_fds and try again.
+		 * then we free the buffer tmp_fds and try again."
+		 * Do we still need now? Keep on the safe side for now - BB.
 		 */
-		spin_unlock_irqrestore(&irq_lock, flags);
 		kfree(tmp_pfd);
 		tmp_pfd = NULL;
 
-		tmp_pfd = um_kmalloc(n);
+		tmp_pfd = um_kmalloc_atomic(n);
 		if (tmp_pfd == NULL)
-			goto out_kfree;
-
-		spin_lock_irqsave(&irq_lock, flags);
+			goto out_unlock;
 	}
 	/*-------------*/
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
