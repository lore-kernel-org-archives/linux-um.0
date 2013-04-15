Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1URnb2-0003W4-AK
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Apr 2013 17:53:40 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1URnb0-0004NL-9i
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Apr 2013 17:53:40 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 15 Apr 2013 19:53:25 +0200
Message-Id: <1366048405-4769-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] um: Use generic idle loop
To: tglx@linutronix.de
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.common   |  1 +
 arch/um/kernel/process.c | 27 ++-------------------------
 2 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index bceee66..5783406 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -12,6 +12,7 @@ config UML
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IO
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IDLE_LOOP
 	select TTY # Needed for line.c
 
 config MMU
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index b462b13..4d64860 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -210,33 +210,10 @@ void initial_thread_cb(void (*proc)(void *), void *arg)
 	kmalloc_ok = save_kmalloc_ok;
 }
 
-void default_idle(void)
-{
-	unsigned long long nsecs;
-
-	while (1) {
-		/* endless idle loop with no priority at all */
-
-		/*
-		 * although we are an idle CPU, we do not want to
-		 * get into the scheduler unnecessarily.
-		 */
-		if (need_resched())
-			schedule();
-
-		tick_nohz_idle_enter();
-		rcu_idle_enter();
-		nsecs = disable_timer();
-		idle_sleep(nsecs);
-		rcu_idle_exit();
-		tick_nohz_idle_exit();
-	}
-}
-
-void cpu_idle(void)
+void arch_cpu_idle(void)
 {
 	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
-	default_idle();
+	local_irq_enable();
 }
 
 int __cant_sleep(void) {
-- 
1.8.1.4


------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

