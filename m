Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWGwt-0006zU-Ki for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 12:03:17 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HWGRV-00049B-UO
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 11:30:51 -0700
Date: Tue, 27 Mar 2007 14:27:49 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070327182749.GA8416@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 5/6] UML - irq locking fixes
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

As the comment immediately preceding this points out, this list is
changed in irq context, so it needs to be protected with
spin_lock_irqsave in process context when it is processed.

Sometimes, gcc should just compile the comments and forget the code.

The IRQ side of this was better, in the sense that it blocked and
unblocked interrupts, but it still should have saved and restored
them.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/chan_kern.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Index: linux-2.6.21-mm/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/chan_kern.c	2007-03-27 12:25:09.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/chan_kern.c	2007-03-27 12:56:21.000000000 -0400
@@ -235,11 +235,11 @@ void free_irqs(void)
 	struct chan *chan;
 	LIST_HEAD(list);
 	struct list_head *ele;
+	unsigned long flags;
 
-	spin_lock_irq(&irqs_to_free_lock);
+	spin_lock_irqsave(&irqs_to_free_lock, flags);
 	list_splice_init(&irqs_to_free, &list);
-	INIT_LIST_HEAD(&irqs_to_free);
-	spin_unlock_irq(&irqs_to_free_lock);
+	spin_unlock_irqrestore(&irqs_to_free_lock, flags);
 
 	list_for_each(ele, &list){
 		chan = list_entry(ele, struct chan, free_list);
@@ -254,13 +254,15 @@ void free_irqs(void)
 
 static void close_one_chan(struct chan *chan, int delay_free_irq)
 {
+	unsigned long flags;
+
 	if(!chan->opened)
 		return;
 
 	if(delay_free_irq){
-		spin_lock_irq(&irqs_to_free_lock);
+		spin_lock_irqsave(&irqs_to_free_lock, flags);
 		list_add(&chan->free_list, &irqs_to_free);
-		spin_unlock_irq(&irqs_to_free_lock);
+		spin_unlock_irqrestore(&irqs_to_free_lock, flags);
 	}
 	else {
 		if(chan->input)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
