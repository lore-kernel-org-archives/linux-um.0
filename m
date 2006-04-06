Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRKed-0007NS-If for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 19:55:27 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRKed-0008LK-9a
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Apr 2006 19:55:27 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [PATCH 12/16] UML - Memory hotplug
Message-ID: <20060406015636.GE6924@ccure.user-mode-linux.org>
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org>
	<20060324144535.37b3daf7.akpm@osdl.org>
	<20060325010524.GA8117@ccure.user-mode-linux.org>
	<44343E86.30301@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44343E86.30301@google.com>
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
Date: Wed, 5 Apr 2006 21:56:36 -0400
To: Daniel Phillips <phillips@google.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Apr 05, 2006 at 03:02:46PM -0700, Daniel Phillips wrote:
> > page = alloc_page(GFP_ATOMIC);
> 
> A slightly different objection than Andrew's: this will rapidly eat up
> all the pages available for, e.g., receiving network packets, probably
> not what you want.  How about flags=0?  This will dip a little way into
> reserves but not as far as interrupts or realtime tasks, and will not
> attempt any reclaim.  (Maybe we should have a GFP define for that.)

Yeah, it's a bit non-obvious what 0 means in the twisty little maze of
GFP_ flags.

However, I do want to push the system into reclaim later.  It looks
like the only difference between 0 and GFP_ATOMIC is the use of
emergency pools, which I don't really want to exercise anyway.

> > INIT_LIST_HEAD(&unplugged->list);
> > list_add(&unplugged->list, &unplugged_pages);
> 
> You don't need to initialize the list element you are adding.

This look OK to you?

Index: linux-2.6.16/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.16.orig/arch/um/drivers/mconsole_kern.c	2006-04-03 18:05:29.000000000 -0400
+++ linux-2.6.16/arch/um/drivers/mconsole_kern.c	2006-04-05 22:54:17.000000000 -0400
@@ -87,7 +87,11 @@ static irqreturn_t mconsole_interrupt(in
 		if(req.cmd->context == MCONSOLE_INTR)
 			(*req.cmd->handler)(&req);
 		else {
-			new = kmalloc(sizeof(*new), GFP_ATOMIC);
+			/* 0 means don't wait (like GFP_ATOMIC) and
+			 * don't dip into emergency pools (unlike
+			 * GFP_ATOMIC).
+			 */
+			new = kmalloc(sizeof(*new), 0);
 			if(new == NULL)
 				mconsole_reply(&req, "Out of memory", 1, 0);
 			else {
@@ -415,7 +419,6 @@ static int mem_config(char *str)
 
 			unplugged = page_address(page);
 			if(unplug_index == UNPLUGGED_PER_PAGE){
-				INIT_LIST_HEAD(&unplugged->list);
 				list_add(&unplugged->list, &unplugged_pages);
 				unplug_index = 0;
 			}
@@ -655,7 +658,6 @@ static void with_console(struct mc_reque
 	struct mconsole_entry entry;
 	unsigned long flags;
 
-	INIT_LIST_HEAD(&entry.list);
 	entry.request = *req;
 	list_add(&entry.list, &clients);
 	spin_lock_irqsave(&console_lock, flags);

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
