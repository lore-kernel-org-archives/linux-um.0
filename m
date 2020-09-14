Return-Path: <tglx@linutronix.de>
Message-Id: <20200914204441.268144917@linutronix.de>
Date: Mon, 14 Sep 2020 22:42:12 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 03/13] preempt: Clenaup PREEMPT_COUNT leftovers
References: <20200914204209.256266093@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 include/linux/preempt.h |   37 ++++---------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -56,8 +56,7 @@
 #define PREEMPT_DISABLED	(PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
 
 /*
- * Disable preemption until the scheduler is running -- use an unconditional
- * value so that it also works on !PREEMPT_COUNT kernels.
+ * Disable preemption until the scheduler is running.
  *
  * Reset by start_kernel()->sched_init()->init_idle()->init_idle_preempt_count().
  */
@@ -69,7 +68,6 @@
  *
  *    preempt_count() == 2*PREEMPT_DISABLE_OFFSET
  *
- * Note: PREEMPT_DISABLE_OFFSET is 0 for !PREEMPT_COUNT kernels.
  * Note: See finish_task_switch().
  */
 #define FORK_PREEMPT_COUNT	(2*PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
@@ -106,11 +104,7 @@
 /*
  * The preempt_count offset after preempt_disable();
  */
-#if defined(CONFIG_PREEMPT_COUNT)
-# define PREEMPT_DISABLE_OFFSET	PREEMPT_OFFSET
-#else
-# define PREEMPT_DISABLE_OFFSET	0
-#endif
+#define PREEMPT_DISABLE_OFFSET	PREEMPT_OFFSET
 
 /*
  * The preempt_count offset after spin_lock()
@@ -122,8 +116,8 @@
  *
  *  spin_lock_bh()
  *
- * Which need to disable both preemption (CONFIG_PREEMPT_COUNT) and
- * softirqs, such that unlock sequences of:
+ * Which need to disable both preemption and softirqs, such that unlock
+ * sequences of:
  *
  *  spin_unlock();
  *  local_bh_enable();
@@ -164,8 +158,6 @@ extern void preempt_count_sub(int val);
 #define preempt_count_inc() preempt_count_add(1)
 #define preempt_count_dec() preempt_count_sub(1)
 
-#ifdef CONFIG_PREEMPT_COUNT
-
 #define preempt_disable() \
 do { \
 	preempt_count_inc(); \
@@ -231,27 +223,6 @@ do { \
 	__preempt_count_dec(); \
 } while (0)
 
-#else /* !CONFIG_PREEMPT_COUNT */
-
-/*
- * Even if we don't have any preemption, we need preempt disable/enable
- * to be barriers, so that we don't have things like get_user/put_user
- * that can cause faults and scheduling migrate into our preempt-protected
- * region.
- */
-#define preempt_disable()			barrier()
-#define sched_preempt_enable_no_resched()	barrier()
-#define preempt_enable_no_resched()		barrier()
-#define preempt_enable()			barrier()
-#define preempt_check_resched()			do { } while (0)
-
-#define preempt_disable_notrace()		barrier()
-#define preempt_enable_no_resched_notrace()	barrier()
-#define preempt_enable_notrace()		barrier()
-#define preemptible()				0
-
-#endif /* CONFIG_PREEMPT_COUNT */
-
 #ifdef MODULE
 /*
  * Modules have no business playing preemption tricks.


