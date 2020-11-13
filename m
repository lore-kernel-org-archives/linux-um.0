Return-Path: <linux-sh-owner@vger.kernel.org>
Message-Id: <20201113141734.660734753@linutronix.de>
Date: Fri, 13 Nov 2020 15:02:24 +0100
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 17/19] softirq: Replace barrier() with cpu_relax() in
 tasklet_unlock_wait()
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Paul McKenney <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Marc Zyngier <maz@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
List-ID: <linux-um.lists.infradead.org>

A barrier() in a tight loop which waits for something to happen on a remote
CPU is a pointless exercise. Replace it with cpu_relax() which allows HT
siblings to make progress.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -668,7 +668,8 @@ static inline void tasklet_unlock(struct
 
 static inline void tasklet_unlock_wait(struct tasklet_struct *t)
 {
-	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
+	while (test_bit(TASKLET_STATE_RUN, &(t)->state))
+		cpu_relax();
 }
 #else
 #define tasklet_trylock(t) 1


