Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hUG0L-0006lX-QY
 for linux-um@lists.infradead.org; Fri, 24 May 2019 19:37:27 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] arch: um: remove locking in deactivate_all_fds()
Date: Fri, 24 May 2019 21:37:00 +0200
Message-Id: <20190524193700.13500-1-johannes@sipsolutions.net>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: j@w1.fi, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Johannes Berg <johannes.berg@intel.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Johannes Berg <johannes.berg@intel.com>

Not only does the locking contradict the comment, and as
the comment says is pointless and actually harmful (all
the actual OS threads have exited already), but it also
causes crashes when lockdep is enabled, because calling
into the spinlock calls into lockdep, which then tries
to determine the current task, which no longer exists.

Remove the locking to let UML shut down cleanly in case
lockdep is enabled.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/irq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index b40dac71e25b..d532377f5808 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -384,10 +384,8 @@ EXPORT_SYMBOL(deactivate_fd);
  */
 int deactivate_all_fds(void)
 {
-	unsigned long flags;
 	struct irq_entry *to_free;
 
-	spin_lock_irqsave(&irq_lock, flags);
 	/* Stop IO. The IRQ loop has no lock so this is our
 	 * only way of making sure we are safe to dispose
 	 * of all IRQ handlers
@@ -404,7 +402,6 @@ int deactivate_all_fds(void)
 		to_free = to_free->next;
 	}
 	garbage_collect_irq_entries();
-	spin_unlock_irqrestore(&irq_lock, flags);
 	os_close_epoll_fd();
 	return 0;
 }
-- 
2.17.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

