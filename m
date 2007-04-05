Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HZFzU-0004LS-6t for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Apr 2007 17:38:16 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HZFzT-00039s-Di
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Apr 2007 17:38:16 -0700
Date: Wed, 4 Apr 2007 20:34:03 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070405003403.GA13285@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 4/4] UML - irq locking commentary
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Locking commentary.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/irq.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: linux-2.6.21-mm/arch/um/kernel/irq.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/irq.c	2007-04-02 13:04:27.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/irq.c	2007-04-02 14:48:48.000000000 -0400
@@ -78,6 +78,14 @@ skip:
 	return 0;
 }
 
+/*
+ * This list is accessed under irq_lock, except in sigio_handler,
+ * where it is safe from being modified.  IRQ handlers won't change it -
+ * if an IRQ source has vanished, it will be freed by free_irqs just
+ * before returning from sigio_handler.  That will process a separate
+ * list of irqs to free, with its own locking, coming back here to
+ * remove list elements, taking the irq_lock to do so.
+ */
 static struct irq_fd *active_fds = NULL;
 static struct irq_fd **last_irq_ptr = &active_fds;
 
@@ -243,6 +251,7 @@ void free_irq_by_fd(int fd)
 	free_irq_by_cb(same_fd, &fd);
 }
 
+/* Must be called with irq_lock held */
 static struct irq_fd *find_irq_by_fd(int fd, int irqnum, int *index_out)
 {
 	struct irq_fd *irq;
@@ -308,6 +317,12 @@ void deactivate_fd(int fd, int irqnum)
 	ignore_sigio_fd(fd);
 }
 
+/*
+ * Called just before shutdown in order to provide a clean exec
+ * environment in case the system is rebooting.  No locking because
+ * that would cause a pointless shutdown hang if something hadn't
+ * released the lock.
+ */
 int deactivate_all_fds(void)
 {
 	struct irq_fd *irq;

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
