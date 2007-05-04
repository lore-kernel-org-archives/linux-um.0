Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hk1pT-00053e-12 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 May 2007 10:44:27 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hk1pS-0004zv-GY
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 May 2007 10:44:26 -0700
Date: Fri, 4 May 2007 13:39:58 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070504173958.GA7948@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/3] UML - An idle system should have zero load
	average
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
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, caker@linode.com

The ever-vigilant users of linode.com noticed that an idle 2.6 UML has
a persistent load average of ~.4.

It turns out that because the UML timer handler processed softirqs
before actually delivering the tick, the tick was counted in the
context of the idle thread about half the time.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/time.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.21-mm/arch/um/kernel/time.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/time.c	2007-05-04 12:40:52.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/time.c	2007-05-04 13:13:39.000000000 -0400
@@ -177,6 +177,8 @@ int do_settimeofday(struct timespec *tv)
 
 void timer_handler(int sig, union uml_pt_regs *regs)
 {
+	if(current_thread->cpu == 0)
+		timer_irq(regs);
 	local_irq_disable();
 	irq_enter();
 	update_process_times(CHOOSE_MODE(
@@ -184,6 +186,4 @@ void timer_handler(int sig, union uml_pt
 			     (regs)->skas.is_user));
 	irq_exit();
 	local_irq_enable();
-	if(current_thread->cpu == 0)
-		timer_irq(regs);
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
