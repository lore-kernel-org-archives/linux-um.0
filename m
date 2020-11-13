Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20201113141733.501611990@linutronix.de>
Date: Fri, 13 Nov 2020 15:02:14 +0100
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 07/19] asm-generic/irqstat: Add optional __nmi_count member
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Paul McKenney <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Marc Zyngier <maz@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
List-ID: <linux-um.lists.infradead.org>

Add an optional __nmi_count member to irq_cpustat_t so more architectures
can use the generic version.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/asm-generic/hardirq.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/asm-generic/hardirq.h
+++ b/include/asm-generic/hardirq.h
@@ -7,6 +7,9 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
+#ifdef ARCH_WANTS_NMI_IRQSTAT
+	unsigned int __nmi_count;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */


