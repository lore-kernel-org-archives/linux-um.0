Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRYgP-0007mx-6I for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Apr 2006 10:54:13 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRYgN-0000Gr-KY
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Apr 2006 10:54:13 -0700
Message-Id: <200604061655.k36GtRNa005151@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/2] UML memory hotplug cleanups
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
Date: Thu, 06 Apr 2006 12:55:27 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Change memory hotplug to use GFP_NOWAIT instead of GFP_ATOMIC, so that it
will grab memory without sleeping, but doesn't try to use the emergency pools.

A small list initialization suggested by Daniel Phillips - don't initialize
lists which are just about to be list_add-ed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.16.orig/arch/um/drivers/mconsole_kern.c	2006-04-06 12:10:41.000000000 -0400
+++ linux-2.6.16/arch/um/drivers/mconsole_kern.c	2006-04-06 12:21:07.000000000 -0400
@@ -87,7 +87,7 @@ static irqreturn_t mconsole_interrupt(in
 		if(req.cmd->context == MCONSOLE_INTR)
 			(*req.cmd->handler)(&req);
 		else {
-			new = kmalloc(sizeof(*new), GFP_ATOMIC);
+			new = kmalloc(sizeof(*new), GFP_NOWAIT);
 			if(new == NULL)
 				mconsole_reply(&req, "Out of memory", 1, 0);
 			else {
@@ -415,7 +415,6 @@ static int mem_config(char *str)
 
 			unplugged = page_address(page);
 			if(unplug_index == UNPLUGGED_PER_PAGE){
-				INIT_LIST_HEAD(&unplugged->list);
 				list_add(&unplugged->list, &unplugged_pages);
 				unplug_index = 0;
 			}
@@ -655,7 +654,6 @@ static void with_console(struct mc_reque
 	struct mconsole_entry entry;
 	unsigned long flags;
 
-	INIT_LIST_HEAD(&entry.list);
 	entry.request = *req;
 	list_add(&entry.list, &clients);
 	spin_lock_irqsave(&console_lock, flags);



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
