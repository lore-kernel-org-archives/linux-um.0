Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JbfBI-0000pI-4X for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Mar 2008 10:00:56 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JbfBE-0001r5-90
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Mar 2008 10:00:55 -0700
Date: Tue, 18 Mar 2008 13:00:19 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080318170019.GA8747@c2.user-mode-linux.org>
References: <47B34BA0.30006@club-internet.fr>
	<20080214003853.GA15952@c2.user-mode-linux.org>
	<47B4BDCD.4080605@club-internet.fr>
	<20080215160205.GA6082@c2.user-mode-linux.org>
	<47B5CE40.9000005@club-internet.fr>
	<20080215184650.GA8810@c2.user-mode-linux.org>
	<87y78kx640.fsf_-_@hades.wkstn.nix>
	<20080317193415.GA12234@c2.user-mode-linux.org>
	<87k5k112kf.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k5k112kf.fsf@hades.wkstn.nix>
Subject: Re: [uml-devel] [2.6.24.x] UML select()/poll() oversleeping
	reproducibly
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
To: Nix <nix@esperi.org.uk>
Cc: Thomas Gleixner <tglx@timesys.com>, linux-kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

Below is another patch.

I was hurt and disappointed by your
> Eeuuuuw. :)
so I got rid of the 9/10 thing.

This version keeps track of the time between ticks (as reported by the
host's gettimeofday) and adjusts its sleeping and reporting ticks
accordingly.

It's still undersleeping a little - your little test once reported 19
seconds for a 20 second sleep.  Otherwise, it's reporting sleep times
that are right on the money.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

Index: linux-2.6.22/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/time.c	2008-03-18 12:32:19.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/time.c	2008-03-18 12:45:50.000000000 -0400
@@ -11,6 +11,7 @@
 #include "kern_constants.h"
 #include "os.h"
 #include "user.h"
+#include "kern_util.h"
 
 int set_interval(void)
 {
@@ -58,12 +59,17 @@ static inline long long timeval_to_ns(co
 long long disable_timer(void)
 {
 	struct itimerval time = ((struct itimerval) { { 0, 0 }, { 0, 0 } });
+	int remain, max = UM_NSEC_PER_SEC / UM_HZ;
 
 	if (setitimer(ITIMER_VIRTUAL, &time, &time) < 0)
 		printk(UM_KERN_ERR "disable_timer - setitimer failed, "
 		       "errno = %d\n", errno);
 
-	return timeval_to_ns(&time.it_value);
+	remain = timeval_to_ns(&time.it_value);
+	if (remain > max)
+		remain = max;
+
+	return remain;
 }
 
 long long os_nsecs(void)
@@ -79,7 +85,47 @@ static int after_sleep_interval(struct t
 {
 	return 0;
 }
+
+
+static void deliver_alarm(void)
+{
+	alarm_handler(SIGVTALRM, NULL);
+}
+
+static unsigned long long sleep_time(unsigned long long nsecs)
+{
+	return nsecs;
+}
+
 #else
+unsigned long long last_tick;
+unsigned long long skew;
+
+extern void alarm_handler(int sig, struct sigcontext *sc);
+
+static void deliver_alarm(void)
+{
+	unsigned long long this_tick = os_nsecs();
+	int one_tick = UM_NSEC_PER_SEC / UM_HZ;
+
+	if (last_tick == 0)
+		last_tick = this_tick - one_tick;
+
+	skew += this_tick - last_tick;
+
+	while (skew >= one_tick) {
+		alarm_handler(SIGVTALRM, NULL);
+		skew -= one_tick;
+	}
+
+	last_tick = this_tick;
+}
+
+static unsigned long long sleep_time(unsigned long long nsecs)
+{
+	return nsecs > skew ? nsecs - skew : 0;
+}
+
 static inline long long timespec_to_us(const struct timespec *ts)
 {
 	return ((long long) ts->tv_sec * UM_USEC_PER_SEC) +
@@ -102,6 +148,8 @@ static int after_sleep_interval(struct t
 	 */
 	if (start_usecs > usec)
 		start_usecs = usec;
+
+	start_usecs -= skew / UM_NSEC_PER_USEC;
 	tv = ((struct timeval) { .tv_sec  = start_usecs / UM_USEC_PER_SEC,
 				 .tv_usec = start_usecs % UM_USEC_PER_SEC });
 	interval = ((struct itimerval) { { 0, usec }, tv });
@@ -113,8 +161,6 @@ static int after_sleep_interval(struct t
 }
 #endif
 
-extern void alarm_handler(int sig, struct sigcontext *sc);
-
 void idle_sleep(unsigned long long nsecs)
 {
 	struct timespec ts;
@@ -126,10 +172,12 @@ void idle_sleep(unsigned long long nsecs
 	 */
 	if (nsecs == 0)
 		nsecs = UM_NSEC_PER_SEC / UM_HZ;
+
+	nsecs = sleep_time(nsecs);
 	ts = ((struct timespec) { .tv_sec	= nsecs / UM_NSEC_PER_SEC,
 				  .tv_nsec	= nsecs % UM_NSEC_PER_SEC });
 
 	if (nanosleep(&ts, &ts) == 0)
-		alarm_handler(SIGVTALRM, NULL);
+		deliver_alarm();
 	after_sleep_interval(&ts);
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
