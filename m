Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fm01V-0006uQ-Pu for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jun 2006 20:08:29 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fm01U-0007n6-9Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jun 2006 20:08:29 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060602030825.GA8006@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] non-scalar ktime addition and subtraction broken
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
Date: Thu, 1 Jun 2006 23:08:25 -0400
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: "Christopher S. Aker" <caker@theshore.net>, user-mode-linux-devel@lists.sourceforge.net

The use of 64-bit additions and subtractions on something which is
nominally a struct containing 32-bit second and nanosecond field is
broken when a negative time is involved.  When the structure is
treated as a 64-bit integer, the increment of the upper 32 bits that's
part of two's-complement subtraction is lost.  This leaves the end
result off by one second.

This manifested itself with sleeps inside UML lasting about 1 second
shorter than expected.

The patch below is more a problem statement than a real fix.  People
thought about performance, and I don't know what this does to that
work.

I'm not sure why the hrtimer.c part is needed - I had done that before
tracking down the ktime_add problem.  I see short sleeps without it,
so it is needed somehow.

The ktime_sub piece was done for completeness - UML compiles and boots
with no apparent ill effects, but it's otherwise untested.

As an aside, I fail to see how it can be correct for ktime_sub to add
NSEC_PER_SEC to something without compensating somewhere else for it.

Andrew - please don't drop this into -mm without an OK from Thomas or
someone else who's familiar with this code :-)

				Jeff

Index: linux-2.6.17-mm/include/linux/ktime.h
===================================================================
--- linux-2.6.17-mm.orig/include/linux/ktime.h	2006-06-01 22:15:44.000000000 -0400
+++ linux-2.6.17-mm/include/linux/ktime.h	2006-06-01 23:00:32.000000000 -0400
@@ -148,7 +148,8 @@ static inline ktime_t ktime_sub(const kt
 {
 	ktime_t res;
 
-	res.tv64 = lhs.tv64 - rhs.tv64;
+	res.tv.sec = lhs.tv.sec - rhs.tv.sec;
+	res.tv.nsec = lhs.tv.nsec - rhs.tv.nsec;
 	if (res.tv.nsec < 0)
 		res.tv.nsec += NSEC_PER_SEC;
 
@@ -167,7 +168,8 @@ static inline ktime_t ktime_add(const kt
 {
 	ktime_t res;
 
-	res.tv64 = add1.tv64 + add2.tv64;
+	res.tv.sec = add1.tv.sec + add2.tv.sec;
+	res.tv.nsec = add1.tv.nsec + add2.tv.nsec;
 	/*
 	 * performance trick: the (u32) -NSEC gives 0x00000000Fxxxxxxx
 	 * so we subtract NSEC_PER_SEC and add 1 to the upper 32 bit.
Index: linux-2.6.17-mm/kernel/hrtimer.c
===================================================================
--- linux-2.6.17-mm.orig/kernel/hrtimer.c	2006-06-01 22:15:44.000000000 -0400
+++ linux-2.6.17-mm/kernel/hrtimer.c	2006-06-01 22:57:24.000000000 -0400
@@ -627,7 +627,8 @@ static inline void run_hrtimer_queue(str
 		int restart;
 
 		timer = rb_entry(node, struct hrtimer, node);
-		if (base->softirq_time.tv64 <= timer->expires.tv64)
+		if(ktime_to_ns(base->softirq_time) <=
+		   ktime_to_ns(timer->expires))
 			break;
 
 		fn = timer->function;


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
