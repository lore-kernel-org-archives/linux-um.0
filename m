Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dxb6H-00069z-BX	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Jul 2005 18:52:49 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1Dxb6H-0001cC-4y
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Jul 2005 18:52:49 -0700
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.11.2) with ESMTP id j6R0rfm13262
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 26 Jul 2005 20:53:46 -0400
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	j6R1gi4e014263	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 26 Jul 2005 21:42:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050727014243.GA14161@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [PATCH] load ave >= 1
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
Date: Tue, 26 Jul 2005 21:42:43 -0400
To: user-mode-linux-devel@lists.sourceforge.net

The patch below might fix the ksoftirqd load average >= 1 problem.

I can't reproduce it, but in chasing it in one of Chris Aker's
non-debuggable images, I uncovered this bug.

Testing and feedback are welcome.

It's applied against my incrementals, but it should be easy to apply
in any other UML.

				Jeff

Index: linux-2.6.12/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/time_kern.c	2005-07-26 16:46:19.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/time_kern.c	2005-07-26 18:46:09.000000000 -0400
@@ -189,8 +189,10 @@
 void timer_handler(int sig, union uml_pt_regs *regs)
 {
 	local_irq_disable();
+	irq_enter();
 	update_process_times(CHOOSE_MODE(user_context(UPT_SP(regs)), 
 					 (regs)->skas.is_user));
+	irq_exit();
 	local_irq_enable();
 	if(current_thread->cpu == 0)
 		timer_irq(regs);


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
