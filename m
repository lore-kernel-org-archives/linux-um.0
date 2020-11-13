Return-Path: <linux-sh-owner@vger.kernel.org>
Message-Id: <20201113141734.207605126@linutronix.de>
Date: Fri, 13 Nov 2020 15:02:20 +0100
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 13/19] softirq: Move various protections into inline helpers
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Paul McKenney <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Marc Zyngier <maz@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
List-ID: <linux-um.lists.infradead.org>

To allow reuse of the bulk of softirq processing code for RT and to avoid
#ifdeffery all over the place, split protections for various code sections
out into inline helpers so the RT variant can just replace them in one go.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/softirq.c |   53 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 9 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -204,6 +204,42 @@ void __local_bh_enable_ip(unsigned long
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
+static inline void local_bh_disable_irq_enter(void)
+{
+	local_bh_disable();
+}
+
+static inline void local_bh_enable_irq_enter(void)
+{
+	_local_bh_enable();
+}
+
+static inline void softirq_handle_begin(void)
+{
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+}
+
+static inline void softirq_handle_end(void)
+{
+	__local_bh_enable(SOFTIRQ_OFFSET);
+	WARN_ON_ONCE(in_interrupt());
+}
+
+static inline void ksoftirqd_run_begin(void)
+{
+	local_irq_disable();
+}
+
+static inline void ksoftirqd_run_end(void)
+{
+	local_irq_enable();
+}
+
+static inline bool should_wake_ksoftirqd(void)
+{
+	return true;
+}
+
 static inline void invoke_softirq(void)
 {
 	if (ksoftirqd_running(local_softirq_pending()))
@@ -317,7 +353,7 @@ asmlinkage __visible void __softirq_entr
 	pending = local_softirq_pending();
 	account_irq_enter_time(current);
 
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	softirq_handle_begin();
 	in_hardirq = lockdep_softirq_start();
 
 restart:
@@ -367,8 +403,7 @@ asmlinkage __visible void __softirq_entr
 
 	lockdep_softirq_end(in_hardirq);
 	account_irq_exit_time(current);
-	__local_bh_enable(SOFTIRQ_OFFSET);
-	WARN_ON_ONCE(in_interrupt());
+	softirq_handle_end();
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
@@ -382,9 +417,9 @@ void irq_enter_rcu(void)
 		 * Prevent raise_softirq from needlessly waking up ksoftirqd
 		 * here, as softirq will be serviced on return from interrupt.
 		 */
-		local_bh_disable();
+		local_bh_disable_irq_enter();
 		tick_irq_enter();
-		_local_bh_enable();
+		local_bh_enable_irq_enter();
 	}
 	__irq_enter();
 }
@@ -467,7 +502,7 @@ inline void raise_softirq_irqoff(unsigne
 	 * Otherwise we wake up ksoftirqd to make sure we
 	 * schedule the softirq soon.
 	 */
-	if (!in_interrupt())
+	if (!in_interrupt() && should_wake_ksoftirqd())
 		wakeup_softirqd();
 }
 
@@ -645,18 +680,18 @@ static int ksoftirqd_should_run(unsigned
 
 static void run_ksoftirqd(unsigned int cpu)
 {
-	local_irq_disable();
+	ksoftirqd_run_begin();
 	if (local_softirq_pending()) {
 		/*
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
 		__do_softirq();
-		local_irq_enable();
+		ksoftirqd_run_end();
 		cond_resched();
 		return;
 	}
-	local_irq_enable();
+	ksoftirqd_run_end();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU


