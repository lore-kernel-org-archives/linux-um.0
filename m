Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2kn1-0004QA-L0 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 21:37:27 -0800
Received: from mx1.redhat.com ([66.187.233.31])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1B2kmy-0000iD-MG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 14 Mar 2004 21:37:24 -0800
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i2F5bJ07015318
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 15 Mar 2004 00:37:19 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com
	[172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i2F5bJS15077
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 15 Mar 2004 00:37:19 -0500
Received: from niphredil.zaitcev.lan (vpn50-65.rdu.redhat.com [172.16.50.65])
	by devserv.devel.redhat.com (8.12.10/8.12.10) with SMTP id
	i2F5b6eF024501 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 15 Mar 2004 00:37:07 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <20040314213718.063a4753.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Patch for timespec vs. timeval in 2.6
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
Date: Sun, 14 Mar 2004 21:37:18 -0800
To: user-mode-linux-devel@lists.sourceforge.net

Looks to me that timespec and timeval got confused in 2.6, by the way
of an extern declaration in a C file. I'm not sure if this is a problem,
but the attached patch makes me more comfortable. Only you might want
to correct the comment.

-- Pete

diff -ur -X dontdiff linux-2.6.4-uml-1/arch/um/include/time_user.h linux-2.6.4-uml-1-t1/arch/um/include/time_user.h
--- linux-2.6.4-uml-1/arch/um/include/time_user.h	2003-07-13 20:31:22.000000000 -0700
+++ linux-2.6.4-uml-1-t1/arch/um/include/time_user.h	2004-03-14 21:21:43.000000000 -0800
@@ -6,7 +6,9 @@
 #ifndef __TIME_USER_H__
 #define __TIME_USER_H__
 
-extern void timer(void);
+/* struct timeval has the same layout in user and kernel */
+extern void timer(struct timeval *tv);
+
 extern void switch_timers(int to_real);
 extern void set_interval(int timer_type);
 extern void idle_sleep(int secs);
diff -ur -X dontdiff linux-2.6.4-uml-1/arch/um/kernel/time.c linux-2.6.4-uml-1-t1/arch/um/kernel/time.c
--- linux-2.6.4-uml-1/arch/um/kernel/time.c	2004-03-14 16:58:33.000000000 -0800
+++ linux-2.6.4-uml-1-t1/arch/um/kernel/time.c	2004-03-14 21:21:49.000000000 -0800
@@ -23,14 +23,17 @@
  */
 extern struct timespec wall_to_monotonic;
 
-extern struct timeval xtime;
-
 struct timeval local_offset = { 0, 0 };
 
-void timer(void)
+/*
+ * This is just a way to cross user-kernel boundary.
+ * For the moment, it is almost the same as do_gettimeofday, but non-locking.
+ * It may get different if guest time ever diverges from host time.
+ */
+void timer(struct timeval *tv)
 {
-	gettimeofday(&xtime, NULL);
-	timeradd(&xtime, &local_offset, &xtime);
+	gettimeofday(tv, NULL);
+	timeradd(tv, &local_offset, tv);
 }
 
 void set_interval(int timer_type)
diff -ur -X dontdiff linux-2.6.4-uml-1/arch/um/kernel/time_kern.c linux-2.6.4-uml-1-t1/arch/um/kernel/time_kern.c
--- linux-2.6.4-uml-1/arch/um/kernel/time_kern.c	2004-03-14 16:58:33.000000000 -0800
+++ linux-2.6.4-uml-1-t1/arch/um/kernel/time_kern.c	2004-03-14 21:24:15.000000000 -0800
@@ -97,10 +97,13 @@
 irqreturn_t um_timer(int irq, void *dev, struct pt_regs *regs)
 {
 	unsigned long flags;
+	struct timeval timeb;
 
 	do_timer(regs);
 	write_seqlock_irqsave(&xtime_lock, flags);
-	timer();
+	timer(&timeb);
+	xtime.tv_sec = timeb.tv_sec;
+	xtime.tv_nsec = timeb.tv_usec * 1000;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 	return(IRQ_HANDLED);
 }


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
