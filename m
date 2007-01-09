Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H46SN-0006ed-4W for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jan 2007 18:11:19 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H46SL-0001Lu-Hl
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Jan 2007 18:11:19 -0800
Message-Id: <200701090205.l0925lMt024381@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 08 Jan 2007 21:05:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/7] UML - Make time data per-cpu
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

prev_nsecs and delta need to be arrays, and indexed by CPU number.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/time.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

Index: linux-2.6.18-mm/arch/um/kernel/time.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/time.c	2007-01-08 14:55:49.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/time.c	2007-01-08 16:14:01.000000000 -0500
@@ -35,31 +35,31 @@ unsigned long long sched_clock(void)
 	return (unsigned long long)jiffies_64 * (1000000000 / HZ);
 }
 
-static unsigned long long prev_nsecs;
+static unsigned long long prev_nsecs[NR_CPUS];
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
-static long long delta;   		/* Deviation per interval */
+static long long delta[NR_CPUS];		/* Deviation per interval */
 #endif
 
 void timer_irq(union uml_pt_regs *regs)
 {
 	unsigned long long ticks = 0;
-
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
-	if(prev_nsecs){
+	int c = cpu();
+	if(prev_nsecs[c]){
 		/* We've had 1 tick */
 		unsigned long long nsecs = os_nsecs();
 
-		delta += nsecs - prev_nsecs;
-		prev_nsecs = nsecs;
+		delta[c] += nsecs - prev_nsecs[c];
+		prev_nsecs[c] = nsecs;
 
 		/* Protect against the host clock being set backwards */
-		if(delta < 0)
-			delta = 0;
+		if(delta[c] < 0)
+			delta[c] = 0;
 
-		ticks += (delta * HZ) / BILLION;
-		delta -= (ticks * BILLION) / HZ;
+		ticks += (delta[c] * HZ) / BILLION;
+		delta[c] -= (ticks * BILLION) / HZ;
 	}
-	else prev_nsecs = os_nsecs();
+	else prev_nsecs[c] = os_nsecs();
 #else
 	ticks = 1;
 #endif
@@ -69,8 +69,8 @@ void timer_irq(union uml_pt_regs *regs)
 	}
 }
 
+/* Protects local_offset */
 static DEFINE_SPINLOCK(timer_spinlock);
-
 static unsigned long long local_offset = 0;
 
 static inline unsigned long long get_time(void)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
