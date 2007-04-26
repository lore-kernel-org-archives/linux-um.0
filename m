Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HhA83-0005F6-Il for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 12:59:55 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HhA81-0002He-TQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Apr 2007 12:59:46 -0700
Date: Thu, 26 Apr 2007 15:56:26 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070426195626.GA9568@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 5/5] UML - Virtualized time fix
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Gregory Smith <gasmith3@wisc.edu>

With the current timekeeping, !CONFIG_UML_REAL_TIME_CLOCK has
inconsistent behavior.  Previously, gettimeofday could be (and was)
isolated from the clock ticking.  Now, it's not, so when
CONFIG_UML_REAL_TIME_CLOCK is disabled, gettimeofday must progress in
lockstep with the clock, making it fully virtual.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/time.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

Index: linux-2.6.21-mm/arch/um/kernel/time.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/time.c	2007-04-08 19:18:52.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/time.c	2007-04-19 13:43:55.000000000 -0400
@@ -34,8 +34,8 @@ unsigned long long sched_clock(void)
 	return (unsigned long long)jiffies_64 * (1000000000 / HZ);
 }
 
-static unsigned long long prev_nsecs[NR_CPUS];
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
+static unsigned long long prev_nsecs[NR_CPUS];
 static long long delta[NR_CPUS];		/* Deviation per interval */
 #endif
 
@@ -94,7 +94,12 @@ irqreturn_t um_timer(int irq, void *dev)
 
 	do_timer(1);
 
+#ifdef CONFIG_UML_REAL_TIME_CLOCK
 	nsecs = get_time();
+#else
+	nsecs = (unsigned long long) xtime.tv_sec * BILLION + xtime.tv_nsec +
+		BILLION / HZ;
+#endif
 	xtime.tv_sec = nsecs / NSEC_PER_SEC;
 	xtime.tv_nsec = nsecs - xtime.tv_sec * NSEC_PER_SEC;
 
@@ -127,13 +132,18 @@ void time_init(void)
 	nsecs = os_nsecs();
 	set_normalized_timespec(&wall_to_monotonic, -nsecs / BILLION,
 				-nsecs % BILLION);
+	set_normalized_timespec(&xtime, nsecs / BILLION, nsecs % BILLION);
 	late_time_init = register_timer;
 }
 
 void do_gettimeofday(struct timeval *tv)
 {
+#ifdef CONFIG_UML_REAL_TIME_CLOCK
 	unsigned long long nsecs = get_time();
-
+#else
+	unsigned long long nsecs = (unsigned long long) xtime.tv_sec * BILLION +
+		xtime.tv_nsec;
+#endif
 	tv->tv_sec = nsecs / NSEC_PER_SEC;
 	/* Careful about calculations here - this was originally done as
 	 * (nsecs - tv->tv_sec * NSEC_PER_SEC) / NSEC_PER_USEC

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
