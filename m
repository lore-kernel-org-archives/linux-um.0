Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G8MrN-0003n5-Np for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Aug 2006 12:58:29 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G8MrN-00005W-9y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Aug 2006 12:58:29 -0700
Message-Id: <200608021958.k72JwMmp006002@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 02 Aug 2006 15:58:22 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 4/4] UML - Remove unused variable
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

timer_irq_inited was useless, so it is removed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-rc2-mm1/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/include/kern_util.h	2006-08-02 15:53:09.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/include/kern_util.h	2006-08-02 15:53:42.000000000 -0400
@@ -27,7 +27,6 @@ extern int ncpus;
 extern char *linux_prog;
 extern char *gdb_init;
 extern int kmalloc_ok;
-extern int timer_irq_inited;
 extern int jail;
 extern int nsyscalls;
 
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/signal.c	2006-08-02 15:53:39.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/signal.c	2006-08-02 15:53:42.000000000 -0400
@@ -55,15 +55,8 @@ void sig_handler(int sig, struct sigcont
 	set_signals(enabled);
 }
 
-extern int timer_irq_inited;
-
 static void real_alarm_handler(int sig, struct sigcontext *sc)
 {
-	if(!timer_irq_inited){
-		signals_enabled = 1;
-		return;
-	}
-
 	if(sig == SIGALRM)
 		switch_timers(0);
 
Index: linux-2.6.18-rc2-mm1/arch/um/kernel/time.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/kernel/time.c	2006-08-02 15:53:41.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/kernel/time.c	2006-08-02 15:53:42.000000000 -0400
@@ -35,9 +35,6 @@ unsigned long long sched_clock(void)
 	return (unsigned long long)jiffies_64 * (1000000000 / HZ);
 }
 
-/* Changed at early boot */
-int timer_irq_inited = 0;
-
 static unsigned long long prev_nsecs;
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
 static long long delta;   		/* Deviation per interval */
@@ -116,8 +113,6 @@ static void register_timer(void)
 		printk(KERN_ERR "register_timer : request_irq failed - "
 		       "errno = %d\n", -err);
 
-	timer_irq_inited = 1;
-
 	err = set_interval(1);
 	if(err != 0)
 		printk(KERN_ERR "register_timer : set_interval failed - "


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
