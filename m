Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpSAF-0003ll-3h for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:51 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JpS9x-0005Ro-7Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:45 -0700
Date: Fri, 25 Apr 2008 13:56:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080425175613.GA11192@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 11/19] UML - Track and make up lost ticks
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
Cc: Nix <nix@esperi.org.uk>

Alarm delivery could be noticably late in the !CONFIG_NOHZ case
because lost ticks weren't being taken into account.  This is now
treated more carefully, with the time between ticks being calculated
and the appropriate number of ticks delivered to the timekeeping system.

Cc: Nix <nix@esperi.org.uk>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/time.c |   54 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

Index: linux-2.6-git/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6-git.orig/arch/um/os-Linux/time.c	2008-04-25 10:42:12.000000000 -0400
+++ linux-2.6-git/arch/um/os-Linux/time.c	2008-04-25 11:19:26.000000000 -0400
@@ -9,7 +9,9 @@
 #include <time.h>
 #include <sys/time.h>
 #include "kern_constants.h"
+#include "kern_util.h"
 #include "os.h"
+#include "process.h"
 #include "user.h"
 
 int set_interval(void)
@@ -58,12 +60,17 @@ static inline long long timeval_to_ns(co
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
@@ -79,7 +86,44 @@ static int after_sleep_interval(struct t
 {
 	return 0;
 }
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
@@ -102,6 +146,8 @@ static int after_sleep_interval(struct t
 	 */
 	if (start_usecs > usec)
 		start_usecs = usec;
+
+	start_usecs -= skew / UM_NSEC_PER_USEC;
 	tv = ((struct timeval) { .tv_sec  = start_usecs / UM_USEC_PER_SEC,
 				 .tv_usec = start_usecs % UM_USEC_PER_SEC });
 	interval = ((struct itimerval) { { 0, usec }, tv });
@@ -113,8 +159,6 @@ static int after_sleep_interval(struct t
 }
 #endif
 
-extern void alarm_handler(int sig, struct sigcontext *sc);
-
 void idle_sleep(unsigned long long nsecs)
 {
 	struct timespec ts;
@@ -126,10 +170,12 @@ void idle_sleep(unsigned long long nsecs
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
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
