Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Tue, 16 Apr 2013 23:53:29 +0200
Message-Id: <1366149209-24787-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: Use generic idle loop
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.common   |  1 +
 arch/um/kernel/process.c | 27 ++++-----------------------
 2 files changed, 5 insertions(+), 23 deletions(-)

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
index b462b13..bbcef52 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -210,33 +210,14 @@ void initial_thread_cb(void (*proc)(void *), void *arg)
 	kmalloc_ok = save_kmalloc_ok;
 }
 
-void default_idle(void)
+void arch_cpu_idle(void)
 {
 	unsigned long long nsecs;
 
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
-{
 	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
-	default_idle();
+	nsecs = disable_timer();
+	idle_sleep(nsecs);
+	local_irq_enable();
 }
 
 int __cant_sleep(void) {
-- 
1.8.1.4

