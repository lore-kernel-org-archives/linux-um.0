Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVZZs-000250-PE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 14:16:52 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IVZZr-0000ZX-3e
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 14:16:52 -0700
Date: Wed, 12 Sep 2007 17:16:48 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070912211648.GA10272@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 7/11] UML - clocksource support
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

Add clocksource support.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/time.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

Index: linux-2.6.22/arch/um/kernel/time.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/time.c	2007-09-12 15:12:11.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/time.c	2007-09-12 15:12:35.000000000 -0400
@@ -97,6 +97,21 @@ static irqreturn_t um_timer(int irq, voi
 	return IRQ_HANDLED;
 }
 
+static cycle_t itimer_read(void)
+{
+	return os_nsecs();
+}
+
+static struct clocksource itimer_clocksource = {
+	.name		= "itimer",
+	.rating		= 300,
+	.read		= itimer_read,
+	.mask		= CLOCKSOURCE_MASK(64),
+	.mult		= 1,
+	.shift		= 0,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
 static void __init setup_itimer(void)
 {
 	int err;
@@ -108,6 +123,12 @@ static void __init setup_itimer(void)
 		printk(KERN_ERR "register_timer : request_irq failed - "
 		       "errno = %d\n", -err);
 
+	err = clocksource_register(&itimer_clocksource);
+	if (err) {
+		printk(KERN_ERR "clocksource_register returned %d\n", err);
+		return;
+	}
+
 	itimer_clockevent.mult = div_sc(HZ, NSEC_PER_SEC, 32);
 	itimer_clockevent.max_delta_ns =
 		clockevent_delta2ns(60 * HZ, &itimer_clockevent);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
