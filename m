Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbHzw-00074T-MM for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 08:43:24 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IbHzv-0000mD-V2
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 08:43:24 -0700
Date: Fri, 28 Sep 2007 11:43:14 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070928154314.GA7185@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML - Fix locking in skb alloction failure fix
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
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

Add _irqsave/_irqrestore to the locking in update_drop_skb to keep
uml_net_rx out while the drop skb is being messed with.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/net_kern.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.22/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/net_kern.c	2007-09-28 11:10:19.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/net_kern.c	2007-09-28 11:13:58.000000000 -0400
@@ -49,9 +49,10 @@ static int drop_max;
 static int update_drop_skb(int max)
 {
 	struct sk_buff *new;
+	unsigned long flags;
 	int err = 0;
 
-	spin_lock(&drop_lock);
+	spin_lock_irqsave(&drop_lock, flags);
 
 	if (max <= drop_max)
 		goto out;
@@ -68,7 +69,7 @@ static int update_drop_skb(int max)
 	drop_max = max;
 	err = 0;
 out:
-	spin_unlock(&drop_lock);
+	spin_unlock_irqrestore(&drop_lock, flags);
 
 	return err;
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
