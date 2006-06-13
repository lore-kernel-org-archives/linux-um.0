Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FpzMT-0003xt-Fe for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 20:14:37 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FpzMT-0003xW-CA for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 20:14:37 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FpzMR-00060B-U8
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 20:14:37 -0700
Message-Id: <200606130314.k5D3Ei09008886@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 12 Jun 2006 23:14:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH] UML - Fix wall_to_monotonic initialization
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

This is 2.6.17 material.

Change a variable from unsigned to signed in order to get sign-extension
when the thing is negated.  Without this, uptime is horribly confused.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/time_kern.c	2006-06-12 22:57:34.000000000 -0400
+++ linux-2.6.16/arch/um/kernel/time_kern.c	2006-06-12 23:01:48.000000000 -0400
@@ -87,7 +87,7 @@ void timer_irq(union uml_pt_regs *regs)
 
 void time_init_kern(void)
 {
-	unsigned long long nsecs;
+	long long nsecs;
 
 	nsecs = os_nsecs();
 	set_normalized_timespec(&wall_to_monotonic, -nsecs / BILLION,



_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
