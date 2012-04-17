Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1SKF9g-0003b8-Gc
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Apr 2012 20:37:40 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SKF9c-00005k-CS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Apr 2012 20:37:40 +0000
From: Richard Weinberger <richard@nod.at>
Date: Tue, 17 Apr 2012 22:37:16 +0200
Message-Id: <1334695036-19977-4-git-send-email-richard@nod.at>
In-Reply-To: <1334695036-19977-1-git-send-email-richard@nod.at>
References: <1334695036-19977-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 4/4] irq: Remove irq_chip->release()
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, tglx@linutronix.de, linux-kernel@vger.kernel.org

As it's only user (UML) does no longer need it we can get
rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/linux/irq.h |    5 -----
 kernel/irq/manage.c |    6 ------
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 7810406..76c5eb4 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -328,11 +328,6 @@ struct irq_chip {
 	void		(*irq_print_chip)(struct irq_data *data, struct seq_file *p);
 
 	unsigned long	flags;
-
-	/* Currently used only by UML, might disappear one day.*/
-#ifdef CONFIG_IRQ_RELEASE_METHOD
-	void		(*release)(unsigned int irq, void *dev_id);
-#endif
 };
 
 /*
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 89a3ea8..9b7f68a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1204,12 +1204,6 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
 	/* Found it - now remove it from the list of entries: */
 	*action_ptr = action->next;
 
-	/* Currently used only by UML, might disappear one day: */
-#ifdef CONFIG_IRQ_RELEASE_METHOD
-	if (desc->irq_data.chip->release)
-		desc->irq_data.chip->release(irq, dev_id);
-#endif
-
 	/* If this was the last handler, shut down the IRQ line: */
 	if (!desc->action)
 		irq_shutdown(desc);
-- 
1.7.7.3


------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

