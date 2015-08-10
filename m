Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 10 Aug 2015 11:52:27 +0200
Message-Id: <1439200352-26767-70-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
References: <55C87382.4070309@linaro.org>
 <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 70/74] um/time: Migrate to new 'set-state' interface
To: mingo@kernel.org
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Viresh Kumar <viresh.kumar@linaro.org>

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
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/um/kernel/time.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 117568d..5af441e 100644
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
1.9.1

