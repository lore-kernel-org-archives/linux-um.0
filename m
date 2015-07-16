Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 16 Jul 2015 16:56:31 +0530
Message-Id: <c42684c67db8ba0709dcd29c81678bffa3c21389.1437044518.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437044517.git.viresh.kumar@linaro.org>
References: <cover.1437044517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437044517.git.viresh.kumar@linaro.org>
References: <cover.1437044517.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 19/23] um/time: Migrate to new 'set-state' interface
To: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Migrate um driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/um/kernel/time.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 117568d4f64a..5af441efb377 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -22,23 +22,16 @@ void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 	local_irq_restore(flags);
 }
 
-static void itimer_set_mode(enum clock_event_mode mode,
-			    struct clock_event_device *evt)
+static int itimer_shutdown(struct clock_event_device *evt)
 {
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		set_interval();
-		break;
-
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_ONESHOT:
-		disable_timer();
-		break;
-
-	case CLOCK_EVT_MODE_RESUME:
-		break;
-	}
+	disable_timer();
+	return 0;
+}
+
+static int itimer_set_periodic(struct clock_event_device *evt)
+{
+	set_interval();
+	return 0;
 }
 
 static int itimer_next_event(unsigned long delta,
@@ -48,14 +41,17 @@ static int itimer_next_event(unsigned long delta,
 }
 
 static struct clock_event_device itimer_clockevent = {
-	.name		= "itimer",
-	.rating		= 250,
-	.cpumask	= cpu_all_mask,
-	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= itimer_set_mode,
-	.set_next_event = itimer_next_event,
-	.shift		= 32,
-	.irq		= 0,
+	.name			= "itimer",
+	.rating			= 250,
+	.cpumask		= cpu_all_mask,
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	= itimer_shutdown,
+	.set_state_periodic	= itimer_set_periodic,
+	.set_state_oneshot	= itimer_shutdown,
+	.set_next_event		= itimer_next_event,
+	.shift			= 32,
+	.irq			= 0,
 };
 
 static irqreturn_t um_timer(int irq, void *dev)
-- 
2.4.0

