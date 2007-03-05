Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOKG6-0006qx-DB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 12:58:28 -0800
Received: from mbox.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOKG3-0004hG-Ny
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 12:58:14 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Mon, 05 Mar 2007 21:49:08 +0100
Message-Id: <20070305204908.9072.72355.stgit@americanbeauty.home.lan>
In-Reply-To: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
References: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 09/11] uml: fix confusion irq early reenabling
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
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix confusion about call context - comments and code are inconsistent and plain
wrong, my fault.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/line.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 01d4ab6..f75d7b0 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -370,10 +370,10 @@ static irqreturn_t line_write_interrupt(int irq, void *data)
 	struct tty_struct *tty = line->tty;
 	int err;
 
-	/* Interrupts are enabled here because we registered the interrupt with
+	/* Interrupts are disabled here because we registered the interrupt with
 	 * IRQF_DISABLED (see line_setup_irq).*/
 
-	spin_lock_irq(&line->lock);
+	spin_lock(&line->lock);
 	err = flush_buffer(line);
 	if (err == 0) {
 		return IRQ_NONE;
@@ -381,7 +381,7 @@ static irqreturn_t line_write_interrupt(int irq, void *data)
 		line->head = line->buffer;
 		line->tail = line->buffer;
 	}
-	spin_unlock_irq(&line->lock);
+	spin_unlock(&line->lock);
 
 	if(tty == NULL)
 		return IRQ_NONE;



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
