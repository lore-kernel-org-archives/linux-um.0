Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fw4Bc-0006tq-5p for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:32 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fw4Bb-0004Yu-1J
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:36:32 -0700
Message-Id: <200606292136.k5TLaaFx010822@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Thu, 29 Jun 2006 17:36:36 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 7/9] UML - Remove stray file
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

Forgot to remove arch/um/kernel/time.c when it was mostly moved to 
arch/um/os-Linux.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-rc-mm/arch/um/kernel/time.c
===================================================================
--- linux-2.6.16-rc-mm.orig/arch/um/kernel/time.c	2006-06-26 17:50:17.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,172 +0,0 @@
-/* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <time.h>
-#include <sys/time.h>
-#include <signal.h>
-#include <errno.h>
-#include "user_util.h"
-#include "kern_util.h"
-#include "user.h"
-#include "process.h"
-#include "time_user.h"
-#include "kern_constants.h"
-#include "os.h"
-
-/* XXX This really needs to be declared and initialized in a kernel file since
- * it's in <linux/time.h>
- */
-extern struct timespec wall_to_monotonic;
-
-extern struct timeval xtime;
-
-struct timeval local_offset = { 0, 0 };
-
-void timer(void)
-{
-	gettimeofday(&xtime, NULL);
-	timeradd(&xtime, &local_offset, &xtime);
-}
-
-static void set_interval(int timer_type)
-{
-	int usec = 1000000/hz();
-	struct itimerval interval = ((struct itimerval) { { 0, usec },
-							  { 0, usec } });
-
-	if(setitimer(timer_type, &interval, NULL) == -1)
-		panic("setitimer failed - errno = %d\n", errno);
-}
-
-void enable_timer(void)
-{
-	set_interval(ITIMER_VIRTUAL);
-}
-
-void prepare_timer(void * ptr)
-{
-	int usec = 1000000/hz();
-	*(struct itimerval *)ptr = ((struct itimerval) { { 0, usec },
-							 { 0, usec }});
-}
-
-void disable_timer(void)
-{
-	struct itimerval disable = ((struct itimerval) { { 0, 0 }, { 0, 0 }});
-	if((setitimer(ITIMER_VIRTUAL, &disable, NULL) < 0) ||
-	   (setitimer(ITIMER_REAL, &disable, NULL) < 0))
-		printk("disnable_timer - setitimer failed, errno = %d\n",
-		       errno);
-	/* If there are signals already queued, after unblocking ignore them */
-	set_handler(SIGALRM, SIG_IGN, 0, -1);
-	set_handler(SIGVTALRM, SIG_IGN, 0, -1);
-}
-
-void switch_timers(int to_real)
-{
-	struct itimerval disable = ((struct itimerval) { { 0, 0 }, { 0, 0 }});
-	struct itimerval enable = ((struct itimerval) { { 0, 1000000/hz() },
-							{ 0, 1000000/hz() }});
-	int old, new;
-
-	if(to_real){
-		old = ITIMER_VIRTUAL;
-		new = ITIMER_REAL;
-	}
-	else {
-		old = ITIMER_REAL;
-		new = ITIMER_VIRTUAL;
-	}
-
-	if((setitimer(old, &disable, NULL) < 0) ||
-	   (setitimer(new, &enable, NULL)))
-		printk("switch_timers - setitimer failed, errno = %d\n",
-		       errno);
-}
-
-void uml_idle_timer(void)
-{
-	if(signal(SIGVTALRM, SIG_IGN) == SIG_ERR)
-		panic("Couldn't unset SIGVTALRM handler");
-	
-	set_handler(SIGALRM, (__sighandler_t) alarm_handler, 
-		    SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
-	set_interval(ITIMER_REAL);
-}
-
-extern void ktime_get_ts(struct timespec *ts);
-#define do_posix_clock_monotonic_gettime(ts) ktime_get_ts(ts)
-
-void time_init(void)
-{
-	struct timespec now;
-
-	if(signal(SIGVTALRM, boot_timer_handler) == SIG_ERR)
-		panic("Couldn't set SIGVTALRM handler");
-	set_interval(ITIMER_VIRTUAL);
-
-	do_posix_clock_monotonic_gettime(&now);
-	wall_to_monotonic.tv_sec = -now.tv_sec;
-	wall_to_monotonic.tv_nsec = -now.tv_nsec;
-}
-
-/* Defined in linux/ktimer.h, which can't be included here */
-#define clock_was_set()		do { } while (0)
-
-void do_gettimeofday(struct timeval *tv)
-{
-	unsigned long flags;
-
-	flags = time_lock();
-	gettimeofday(tv, NULL);
-	timeradd(tv, &local_offset, tv);
-	time_unlock(flags);
-	clock_was_set();
-}
-
-int do_settimeofday(struct timespec *tv)
-{
-	struct timeval now;
-	unsigned long flags;
-	struct timeval tv_in;
-
-	if ((unsigned long) tv->tv_nsec >= UM_NSEC_PER_SEC)
-		return -EINVAL;
-
-	tv_in.tv_sec = tv->tv_sec;
-	tv_in.tv_usec = tv->tv_nsec / 1000;
-
-	flags = time_lock();
-	gettimeofday(&now, NULL);
-	timersub(&tv_in, &now, &local_offset);
-	time_unlock(flags);
-
-	return(0);
-}
-
-void idle_sleep(int secs)
-{
-	struct timespec ts;
-
-	ts.tv_sec = secs;
-	ts.tv_nsec = 0;
-	nanosleep(&ts, NULL);
-}
-
-/* XXX This partly duplicates init_irq_signals */
-
-void user_time_init(void)
-{
-	set_handler(SIGVTALRM, (__sighandler_t) alarm_handler,
-		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH,
-		    SIGALRM, SIGUSR2, -1);
-	set_handler(SIGALRM, (__sighandler_t) alarm_handler,
-		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH,
-		    SIGVTALRM, SIGUSR2, -1);
-	set_interval(ITIMER_VIRTUAL);
-}


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
