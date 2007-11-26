Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwkxX-0005ap-NF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 12:53:39 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IwkxX-0000Oa-6A
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 12:53:39 -0800
Date: Mon, 26 Nov 2007 15:52:42 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071126205242.GA11444@c2.user-mode-linux.org>
References: <E1Is5FL-00078H-00@dorka.pomaz.szeredi.hu>
	<20071114011002.GA11477@c2.user-mode-linux.org>
	<E1IsFbA-0007y2-00@dorka.pomaz.szeredi.hu>
	<20071114142247.GA5848@c2.user-mode-linux.org>
	<E1IsK83-0008CJ-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IsK83-0008CJ-00@dorka.pomaz.szeredi.hu>
Subject: Re: [uml-devel] uml doesn't work on 2.6.24-rc2
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: tglx@linutronix.de, mingo@elte.hu, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Nov 14, 2007 at 04:26:11PM +0100, Miklos Szeredi wrote:
> This one fixed the EINVAL messages, and now UML boots, but consumes
> 100% CPU constantly.

Can you disable NO_HZ and try the patch below, which WorksForMe (TM)?

				Jeff

-- 
Work email - jdike at linux dot intel dot com


Index: linux-2.6.22/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/time.c	2007-11-14 10:33:29.000000000 -0500
+++ linux-2.6.22/arch/um/os-Linux/time.c	2007-11-26 15:50:46.000000000 -0500
@@ -59,7 +59,7 @@ long long disable_timer(void)
 {
 	struct itimerval time = ((struct itimerval) { { 0, 0 }, { 0, 0 } });
 
-	if(setitimer(ITIMER_VIRTUAL, &time, &time) < 0)
+	if (setitimer(ITIMER_VIRTUAL, &time, &time) < 0)
 		printk(UM_KERN_ERR "disable_timer - setitimer failed, "
 		       "errno = %d\n", errno);
 
@@ -74,13 +74,61 @@ long long os_nsecs(void)
 	return timeval_to_ns(&tv);
 }
 
+#ifdef UML_CONFIG_NO_HZ
+static int after_sleep_interval(struct timespec *ts)
+{
+}
+#else
+static inline long long timespec_to_us(const struct timespec *ts)
+{
+	return ((long long) ts->tv_sec * UM_USEC_PER_SEC) +
+		ts->tv_nsec / UM_NSEC_PER_USEC;
+}
+
+static int after_sleep_interval(struct timespec *ts)
+{
+	int usec = UM_USEC_PER_SEC / UM_HZ;
+	long long start_usecs = timespec_to_us(ts);
+	struct timeval tv;
+	struct itimerval interval;
+
+	/*
+	 * It seems that rounding can increase the value returned from
+	 * setitimer to larger than the one passed in.  Over time,
+	 * this will cause the remaining time to be greater than the
+	 * tick interval.  If this happens, then just reduce the first
+	 * tick to the interval value.
+	 */
+	if (start_usecs > usec)
+		start_usecs = usec;
+	tv = ((struct timeval) { .tv_sec  = start_usecs / UM_USEC_PER_SEC,
+				 .tv_usec = start_usecs % UM_USEC_PER_SEC });
+	interval = ((struct itimerval) { { 0, usec }, tv });
+
+	if (setitimer(ITIMER_VIRTUAL, &interval, NULL) == -1)
+		return -errno;
+
+	return 0;
+}
+#endif
+
 extern void alarm_handler(int sig, struct sigcontext *sc);
 
 void idle_sleep(unsigned long long nsecs)
 {
-	struct timespec ts = { .tv_sec	= nsecs / UM_NSEC_PER_SEC,
-			       .tv_nsec = nsecs % UM_NSEC_PER_SEC };
+	struct timespec ts;
+
+	/*
+	 * nsecs can come in as zero, in which case, this starts a
+	 * busy loop.  To prevent this, reset nsecs to the tick
+	 * interval if it is zero.
+	 */
+	if (nsecs == 0)
+		nsecs = UM_NSEC_PER_SEC / UM_HZ;
+	ts = ((struct timespec) { .tv_sec	= nsecs / UM_NSEC_PER_SEC,
+				  .tv_nsec	= nsecs % UM_NSEC_PER_SEC });
 
 	if (nanosleep(&ts, &ts) == 0)
 		alarm_handler(SIGVTALRM, NULL);
+	after_sleep_interval(&ts);
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
