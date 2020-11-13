Return-Path: <linux-sh-owner@vger.kernel.org>
Message-Id: <20201113141734.558782917@linutronix.de>
Date: Fri, 13 Nov 2020 15:02:23 +0100
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 16/19] rcu: Prevent false positive softirq warning on RT
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Paul McKenney <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Marc Zyngier <maz@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
List-ID: <linux-um.lists.infradead.org>

Soft interrupt disabled sections can legitimately be preempted or schedule
out when blocking on a lock on RT enabled kernels so the RCU preempt check
warning has to be disabled for RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rcupdate.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -319,7 +319,8 @@ static inline void rcu_preempt_sleep_che
 #define rcu_sleep_check()						\
 	do {								\
 		rcu_preempt_sleep_check();				\
-		RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map),	\
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))			\
+		    RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map),	\
 				 "Illegal context switch in RCU-bh read-side critical section"); \
 		RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map),	\
 				 "Illegal context switch in RCU-sched read-side critical section"); \


