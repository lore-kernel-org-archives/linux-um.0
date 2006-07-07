Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FyeHi-0006Zj-1a for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:30 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FyeHh-0000ff-Go
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Jul 2006 17:33:30 -0700
Message-Id: <200607070033.k670XcXG008692@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 06 Jul 2006 20:33:38 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/19] UML - timer handler tidying
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

Get rid of a user of timer_irq_inited (and first_tick) by observing
that prev_ticks can be used to decide if this is the first call.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-rc-mm/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.16-rc-mm.orig/arch/um/kernel/time_kern.c	2006-06-26 17:50:17.000000000 -0400
+++ linux-2.6.16-rc-mm/arch/um/kernel/time_kern.c	2006-06-28 13:07:08.000000000 -0400
@@ -38,7 +38,6 @@ unsigned long long sched_clock(void)
 /* Changed at early boot */
 int timer_irq_inited = 0;
 
-static int first_tick;
 static unsigned long long prev_nsecs;
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
 static long long delta;   		/* Deviation per interval */
@@ -48,15 +47,8 @@ void timer_irq(union uml_pt_regs *regs)
 {
 	unsigned long long ticks = 0;
 
-	if(!timer_irq_inited){
-		/* This is to ensure that ticks don't pile up when
-		 * the timer handler is suspended */
-		first_tick = 0;
-		return;
-	}
-
-	if(first_tick){
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
+	if(prev_nsecs){
 		/* We've had 1 tick */
 		unsigned long long nsecs = os_nsecs();
 
@@ -69,15 +61,11 @@ void timer_irq(union uml_pt_regs *regs)
 
 		ticks += (delta * HZ) / BILLION;
 		delta -= (ticks * BILLION) / HZ;
+	}
+	else prev_nsecs = os_nsecs();
 #else
-		ticks = 1;
+	ticks = 1;
 #endif
-	}
-	else {
-		prev_nsecs = os_nsecs();
-		first_tick = 1;
-	}
-
 	while(ticks > 0){
 		do_IRQ(TIMER_IRQ, regs);
 		ticks--;


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
