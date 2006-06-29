Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fw4Ba-0006tc-No for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:30 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fw4BZ-0005Ld-FB
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:30 -0700
Message-Id: <200606292136.k5TLaXHZ010812@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 29 Jun 2006 17:36:32 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/9] UML - Add locking to xtime accesses
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
Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

do_timer must be called with xtime_lock held. I'm not sure
boot_timer_handler needs this, however I don't think it hurts: it simply
disables irq and takes a spinlock.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Index: linux-2.6.17/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/time_kern.c	2006-06-29 10:37:16.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/time_kern.c	2006-06-29 11:39:57.000000000 -0400
@@ -96,11 +96,15 @@ void time_init_kern(void)
 
 void do_boot_timer_handler(struct sigcontext * sc)
 {
+	unsigned long flags;
 	struct pt_regs regs;
 
 	CHOOSE_MODE((void) (UPT_SC(&regs.regs) = sc),
 		    (void) (regs.regs.skas.is_user = 0));
+
+	write_seqlock_irqsave(&xtime_lock, flags);
 	do_timer(&regs);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
 }
 
 static DEFINE_SPINLOCK(timer_spinlock);
@@ -125,15 +129,17 @@ irqreturn_t um_timer(int irq, void *dev,
 	unsigned long long nsecs;
 	unsigned long flags;
 
+	write_seqlock_irqsave(&xtime_lock, flags);
+
 	do_timer(regs);
 
-	write_seqlock_irqsave(&xtime_lock, flags);
 	nsecs = get_time() + local_offset;
 	xtime.tv_sec = nsecs / NSEC_PER_SEC;
 	xtime.tv_nsec = nsecs - xtime.tv_sec * NSEC_PER_SEC;
+
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 
-	return(IRQ_HANDLED);
+	return IRQ_HANDLED;
 }
 
 long um_time(int __user *tloc)


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
