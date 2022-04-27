Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 07/30] mips: ip22: Reword PANICED to PANICKED and remove
 useless header
Date: Wed, 27 Apr 2022 19:49:01 -0300
Message-Id: <20220427224924.592546-8-gpiccoli@igalia.com>
In-Reply-To: <20220427224924.592546-1-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, kernel-dev@igalia.com, gpiccoli@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Many other place in the kernel prefer the latter, so let's keep
it consistent in MIPS code as well. Also, removes a useless header.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 arch/mips/sgi-ip22/ip22-reset.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
index 9028dbbb45dd..8f0861c58080 100644
--- a/arch/mips/sgi-ip22/ip22-reset.c
+++ b/arch/mips/sgi-ip22/ip22-reset.c
@@ -11,7 +11,6 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
-#include <linux/notifier.h>
 #include <linux/panic_notifier.h>
 #include <linux/pm.h>
 #include <linux/timer.h>
@@ -41,7 +40,7 @@
 static struct timer_list power_timer, blink_timer, debounce_timer;
 static unsigned long blink_timer_timeout;
 
-#define MACHINE_PANICED		1
+#define MACHINE_PANICKED		1
 #define MACHINE_SHUTTING_DOWN	2
 
 static int machine_state;
@@ -112,7 +111,7 @@ static void debounce(struct timer_list *unused)
 		return;
 	}
 
-	if (machine_state & MACHINE_PANICED)
+	if (machine_state & MACHINE_PANICKED)
 		sgimc->cpuctrl0 |= SGIMC_CCTRL0_SYSINIT;
 
 	enable_irq(SGI_PANEL_IRQ);
@@ -120,7 +119,7 @@ static void debounce(struct timer_list *unused)
 
 static inline void power_button(void)
 {
-	if (machine_state & MACHINE_PANICED)
+	if (machine_state & MACHINE_PANICKED)
 		return;
 
 	if ((machine_state & MACHINE_SHUTTING_DOWN) ||
@@ -167,9 +166,9 @@ static irqreturn_t panel_int(int irq, void *dev_id)
 static int panic_event(struct notifier_block *this, unsigned long event,
 		      void *ptr)
 {
-	if (machine_state & MACHINE_PANICED)
+	if (machine_state & MACHINE_PANICKED)
 		return NOTIFY_DONE;
-	machine_state |= MACHINE_PANICED;
+	machine_state |= MACHINE_PANICKED;
 
 	blink_timer_timeout = PANIC_FREQ;
 	blink_timeout(&blink_timer);
-- 
2.36.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

