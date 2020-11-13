Return-Path: <linux-sh-owner@vger.kernel.org>
Message-Id: <20201113141734.096224353@linutronix.de>
Date: Fri, 13 Nov 2020 15:02:19 +0100
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 12/19] softirq: Add RT specific softirq accounting
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Paul McKenney <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Marc Zyngier <maz@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
List-ID: <linux-um.lists.infradead.org>

RT requires the softirq to be preemptible and uses a per CPU local lock to
protect BH disabled sections and softirq processing. Therefore RT cannot
use the preempt counter to keep track of BH disabled/serving.

Add a RT only counter to task struct and adjust the relevant macros in
preempt.h.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/hardirq.h |    1 +
 include/linux/preempt.h |    6 +++++-
 include/linux/sched.h   |    3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -6,6 +6,7 @@
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
 #include <linux/ftrace_irq.h>
+#include <linux/sched.h>
 #include <linux/vtime.h>
 #include <asm/hardirq.h>
 
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -79,7 +79,11 @@
 
 #define nmi_count()	(preempt_count() & NMI_MASK)
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+#ifdef CONFIG_PREEMPT_RT
+# define softirq_count()	(current->softirq_disable_cnt & SOFTIRQ_MASK)
+#else
+# define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+#endif
 #define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
 
 /*
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1004,6 +1004,9 @@ struct task_struct {
 	int				softirq_context;
 	int				irq_config;
 #endif
+#ifdef CONFIG_PREEMPT_RT
+	int				softirq_disable_cnt;
+#endif
 
 #ifdef CONFIG_LOCKDEP
 # define MAX_LOCK_DEPTH			48UL


