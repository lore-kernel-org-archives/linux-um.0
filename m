Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Axe9U-0007tW-V1 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 19:31:32 -0800
Received: from mx1.redhat.com ([66.187.233.31])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Axdxz-0003y6-UO for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 19:19:40 -0800
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id i213JXb08434
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 29 Feb 2004 22:19:33 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com
	[172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i213JX819231
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 29 Feb 2004 22:19:33 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <20040229191932.10b3592e.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] missed_ticks (2.6)
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
Date: Sun, 29 Feb 2004 19:19:32 -0800
To: user-mode-linux-devel@lists.sourceforge.net
Cc: zaitcev@redhat.com

Hi,

I was looking at the way timer works on UML and noticed that missed_ticks
is not actually used for anything. Is there a plan for it? If not, maybe
we should drop it.

Cheers,
-- Pete

diff -ur -X dontdiff linux-2.6.3-rc2-uml-1/arch/um/kernel/skas/trap_user.c linux-2.6.3-rc2-uml-1-t1/arch/um/kernel/skas/trap_user.c
--- linux-2.6.3-rc2-uml-1/arch/um/kernel/skas/trap_user.c	2004-02-15 21:26:30.000000000 -0800
+++ linux-2.6.3-rc2-uml-1-t1/arch/um/kernel/skas/trap_user.c	2004-02-29 18:48:11.000000000 -0800
@@ -35,8 +35,6 @@
 	errno = save_errno;
 }
 
-extern int missed_ticks[];
-
 void user_signal(int sig, union uml_pt_regs *regs)
 {
 	struct signal_info *info;
diff -ur -X dontdiff linux-2.6.3-rc2-uml-1/arch/um/kernel/time_kern.c linux-2.6.3-rc2-uml-1-t1/arch/um/kernel/time_kern.c
--- linux-2.6.3-rc2-uml-1/arch/um/kernel/time_kern.c	2004-02-15 21:26:31.000000000 -0800
+++ linux-2.6.3-rc2-uml-1-t1/arch/um/kernel/time_kern.c	2004-02-29 19:02:44.000000000 -0800
@@ -41,12 +41,6 @@
 /* Changed at early boot */
 int timer_irq_inited = 0;
 
-/* missed_ticks will be modified after kernel memory has been 
- * write-protected, so this puts it in a section which will be left 
- * write-enabled.
- */
-int __attribute__ ((__section__ (".unprotected"))) missed_ticks[NR_CPUS];
-
 static int first_tick;
 static unsigned long long prev_tsc;
 static long long delta;   		/* Deviation per interval */
diff -ur -X dontdiff linux-2.6.3-rc2-uml-1/arch/um/kernel/trap_user.c linux-2.6.3-rc2-uml-1-t1/arch/um/kernel/trap_user.c
--- linux-2.6.3-rc2-uml-1/arch/um/kernel/trap_user.c	2004-02-15 21:26:31.000000000 -0800
+++ linux-2.6.3-rc2-uml-1-t1/arch/um/kernel/trap_user.c	2004-02-29 19:02:28.000000000 -0800
@@ -102,12 +102,11 @@
 			 sig, &sc);
 }
 
-extern int timer_irq_inited, missed_ticks[];
+extern int timer_irq_inited;
 
 void alarm_handler(int sig, struct sigcontext sc)
 {
 	if(!timer_irq_inited) return;
-	missed_ticks[cpu()]++;
 
 	if(sig == SIGALRM)
 		switch_timers(0);


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
