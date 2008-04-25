Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpSAS-0003nc-Lg for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:57:04 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JpSAP-0005al-QJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:57:04 -0700
Date: Fri, 25 Apr 2008 13:56:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080425175615.GA11198@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 14/19] UML - Fix bad NTP interaction with clock
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
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

UML's supposed nanosecond clock interacts badly with NTP when NTP
decides that the clock has drifted ahead and needs to be slowed down.
Slowing down the clock is done by decrementing the cycle-to-nanosecond
multiplier, which is 1.  Decrementing that gives you 0 and time is
stopped.

This is fixed by switching to a microsecond clock, with a multiplier
of 1000.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/time.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-git/arch/um/kernel/time.c
===================================================================
--- linux-2.6-git.orig/arch/um/kernel/time.c	2008-02-15 11:43:41.000000000 -0500
+++ linux-2.6-git/arch/um/kernel/time.c	2008-04-24 16:01:35.000000000 -0400
@@ -74,7 +74,7 @@ static irqreturn_t um_timer(int irq, voi
 
 static cycle_t itimer_read(void)
 {
-	return os_nsecs();
+	return os_nsecs() / 1000;
 }
 
 static struct clocksource itimer_clocksource = {
@@ -82,7 +82,7 @@ static struct clocksource itimer_clockso
 	.rating		= 300,
 	.read		= itimer_read,
 	.mask		= CLOCKSOURCE_MASK(64),
-	.mult		= 1,
+	.mult		= 1000,
 	.shift		= 0,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
