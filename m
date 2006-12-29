Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H0RQy-0002xd-Sp for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Dec 2006 15:46:44 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H0RQy-0007gz-4h
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Dec 2006 15:46:44 -0800
Message-Id: <200612292341.kBTNfUqs005544@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Fri, 29 Dec 2006 18:41:30 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/6] UML - Lock the irqs_to_free list
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

Fix (i.e. add some) the locking around the irqs_to_free list.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

--
 arch/um/drivers/chan_kern.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/chan_kern.c	2006-12-29 15:27:16.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/chan_kern.c	2006-12-29 16:38:43.000000000 -0500
@@ -222,15 +222,28 @@ void enable_chan(struct line *line)
 	}
 }
 
+/* Items are added in IRQ context, when free_irq can't be called, and
+ * removed in process context, when it can.
+ * This handles interrupt sources which disappear, and which need to
+ * be permanently disabled.  This is discovered in IRQ context, but
+ * the freeing of the IRQ must be done later.
+ */
+static DEFINE_SPINLOCK(irqs_to_free_lock);
 static LIST_HEAD(irqs_to_free);
 
 void free_irqs(void)
 {
 	struct chan *chan;
+	LIST_HEAD(list);
+	struct list_head *ele;
+
+	spin_lock_irq(&irqs_to_free_lock);
+	list_splice_init(&irqs_to_free, &list);
+	INIT_LIST_HEAD(&irqs_to_free);
+	spin_unlock_irq(&irqs_to_free_lock);
 
-	while(!list_empty(&irqs_to_free)){
-		chan = list_entry(irqs_to_free.next, struct chan, free_list);
-		list_del(&chan->free_list);
+	list_for_each(ele, &list){
+		chan = list_entry(ele, struct chan, free_list);
 
 		if(chan->input)
 			free_irq(chan->line->driver->read_irq, chan);
@@ -246,7 +259,9 @@ static void close_one_chan(struct chan *
 		return;
 
 	if(delay_free_irq){
+		spin_lock_irq(&irqs_to_free_lock);
 		list_add(&chan->free_list, &irqs_to_free);
+		spin_unlock_irq(&irqs_to_free_lock);
 	}
 	else {
 		if(chan->input)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
