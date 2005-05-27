Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbTIO-0006R9-3p	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:05:52 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DbTHq-0004m5-Vu	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 May 2005 18:05:52 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050527003843.433BA1AEE88@zion.home.lan>
Subject: [uml-devel] [patch 4/8] irq code: Add coherence test for
	PREEMPT_ACTIVE
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
Date: Fri, 27 May 2005 02:38:42 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


After porting this fixlet to UML:

http://linux.bkbits.net:8080/linux-2.5/cset@41791ab52lfMuF2i3V-eTIGRBbDYKQ

, I've also added a warning which should refuse compilation with insane values
for PREEMPT_ACTIVE... maybe we should simply move PREEMPT_ACTIVE out of
architectures using GENERIC_IRQS.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/linux/hardirq.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN include/linux/hardirq.h~coherence-test-preempt-active include/linux/hardirq.h
--- linux-2.6.git/include/linux/hardirq.h~coherence-test-preempt-active	2005-05-25 00:59:11.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/hardirq.h	2005-05-25 00:59:26.000000000 +0200
@@ -43,13 +43,17 @@
 #define __IRQ_MASK(x)	((1UL << (x))-1)
 
 #define PREEMPT_MASK	(__IRQ_MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
 #define SOFTIRQ_MASK	(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
+#define HARDIRQ_MASK	(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
 
 #define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
 #define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
 #define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
 
+#if PREEMPT_ACTIVE < (1 << (HARDIRQ_SHIFT + HARDIRQ_BITS))
+#error PREEMPT_ACTIVE is too low!
+#endif
+
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
 #define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
 #define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
_


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
