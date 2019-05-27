Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hVB5f-00072b-Ii
 for linux-um@lists.infradead.org; Mon, 27 May 2019 08:34:47 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3 2/2] arch: um: support time travel mode
Date: Mon, 27 May 2019 10:34:27 +0200
Message-Id: <20190527083427.6293-2-johannes@sipsolutions.net>
In-Reply-To: <20190527083427.6293-1-johannes@sipsolutions.net>
References: <20190527083427.6293-1-johannes@sipsolutions.net>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: j@w1.fi, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Johannes Berg <johannes.berg@intel.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Johannes Berg <johannes.berg@intel.com>

Sometimes it can be useful to run with "time travel" inside the
UML instance, for example for testing. For example, some tests
for the wireless subsystem and userspace are based on hwsim, a
virtual wireless adapter. Some tests can take a long time to
run because they e.g. wait for 120 seconds to elapse for some
regulatory checks. This obviously goes faster if it need not
actually wait that long, but time inside the test environment
just "bumps up" when there's nothing to do.

Add CONFIG_UML_TIME_TRAVEL_SUPPORT to enable code to support
such modes at runtime, selected on the command line:
 * just "time-travel", in which time inside the UML instance
   can move faster than real time, if there's nothing to do
 * "time-travel=inf-cpu" in which time also moves slower and
   any CPU processing takes no time at all, which allows to
   implement consistent behaviour regardless of host CPU load
   (or speed) or debug overhead.

An additional "time-travel-start=<seconds>" parameter is also
supported in this case to start the wall clock at this time
(in unix epoch).

With this enabled, the test mentioned above goes from a runtime
of about 140 seconds (with startup overhead and all) to being
CPU bound and finishing in 15 seconds (on my slow laptop).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig                         |  12 +++
 arch/um/include/shared/timer-internal.h |  46 +++++++++
 arch/um/kernel/process.c                |  42 +++++++-
 arch/um/kernel/skas/syscall.c           |  11 ++
 arch/um/kernel/time.c                   | 129 ++++++++++++++++++++++--
 5 files changed, 233 insertions(+), 7 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 07da2b284e46..14bb99c8039d 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -179,6 +179,18 @@ config SECCOMP
 
 	  If unsure, say Y.
 
+config UML_TIME_TRAVEL_SUPPORT
+	bool
+	prompt "Support time-travel mode (e.g. for test execution)"
+	help
+	  Enable this option to support time travel inside the UML instance.
+
+	  After enabling this option, two modes are accessible at runtime
+	  (selected by the kernel command line), see the kernel's command-
+	  line help for more details.
+
+	  It is safe to say Y, but you probably don't need this.
+
 endmenu
 
 source "arch/um/drivers/Kconfig"
diff --git a/arch/um/include/shared/timer-internal.h b/arch/um/include/shared/timer-internal.h
index 03e6f217f807..5ca74f415d52 100644
--- a/arch/um/include/shared/timer-internal.h
+++ b/arch/um/include/shared/timer-internal.h
@@ -10,4 +10,50 @@
 #define TIMER_MULTIPLIER 256
 #define TIMER_MIN_DELTA  500
 
+enum time_travel_mode {
+	TT_MODE_OFF,
+	TT_MODE_BASIC,
+	TT_MODE_INFCPU,
+};
+
+enum time_travel_timer_mode {
+	TT_TMR_DISABLED,
+	TT_TMR_ONESHOT,
+	TT_TMR_PERIODIC,
+};
+
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+extern enum time_travel_mode time_travel_mode;
+extern unsigned long long time_travel_time;
+extern enum time_travel_timer_mode time_travel_timer_mode;
+extern unsigned long long time_travel_timer_expiry;
+extern unsigned long long time_travel_timer_interval;
+
+static inline void time_travel_set_time(unsigned long long ns)
+{
+	time_travel_time = ns;
+}
+
+static inline void time_travel_set_timer(enum time_travel_timer_mode mode,
+					 unsigned long long expiry)
+{
+	time_travel_timer_mode = mode;
+	time_travel_timer_expiry = expiry;
+}
+#else
+#define time_travel_mode TT_MODE_OFF
+#define time_travel_time 0
+#define time_travel_timer_expiry 0
+#define time_travel_timer_interval 0
+
+static inline void time_travel_set_time(unsigned long long ns)
+{
+}
+
+static inline void time_travel_set_timer(enum time_travel_timer_mode mode,
+					 unsigned long long expiry)
+{
+}
+#endif
+
 #endif
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 691b83b10649..def2091697ca 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -203,10 +203,50 @@ void initial_thread_cb(void (*proc)(void *), void *arg)
 	kmalloc_ok = save_kmalloc_ok;
 }
 
+static void time_travel_sleep(unsigned long long duration)
+{
+	unsigned long long next = time_travel_time + duration;
+
+	if (time_travel_mode != TT_MODE_INFCPU)
+		os_timer_disable();
+
+	if (time_travel_timer_mode != TT_TMR_DISABLED ||
+	    time_travel_timer_expiry < next) {
+		if (time_travel_timer_mode == TT_TMR_ONESHOT)
+			time_travel_timer_mode = TT_TMR_DISABLED;
+		/*
+		 * time_travel_time will be adjusted in the timer
+		 * IRQ handler so it works even when the signal
+		 * comes from the OS timer
+		 */
+		deliver_alarm();
+	} else {
+		time_travel_set_time(next);
+	}
+
+	if (time_travel_mode != TT_MODE_INFCPU) {
+		if (time_travel_timer_mode == TT_TMR_PERIODIC)
+			os_timer_set_interval(time_travel_timer_interval);
+		else if (time_travel_timer_mode == TT_TMR_ONESHOT)
+			os_timer_one_shot(time_travel_timer_expiry - next);
+	}
+}
+
+static void um_idle_sleep(void)
+{
+	unsigned long long duration = UM_NSEC_PER_SEC;
+
+	if (time_travel_mode != TT_MODE_OFF) {
+		time_travel_sleep(duration);
+	} else {
+		os_idle_sleep(duration);
+	}
+}
+
 void arch_cpu_idle(void)
 {
 	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
-	os_idle_sleep(UM_NSEC_PER_SEC);
+	um_idle_sleep();
 	local_irq_enable();
 }
 
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index b783ac87d98a..44bb10785075 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -10,12 +10,23 @@
 #include <sysdep/ptrace.h>
 #include <sysdep/ptrace_user.h>
 #include <sysdep/syscalls.h>
+#include <shared/timer-internal.h>
 
 void handle_syscall(struct uml_pt_regs *r)
 {
 	struct pt_regs *regs = container_of(r, struct pt_regs, regs);
 	int syscall;
 
+	/*
+	 * If we have infinite CPU resources, then make every syscall also a
+	 * preemption point, since we don't have any other preemption in this
+	 * case, and kernel threads would basically never run until userspace
+	 * went to sleep, even if said userspace interacts with the kernel in
+	 * various ways.
+	 */
+	if (time_travel_mode == TT_MODE_INFCPU)
+		schedule();
+
 	/* Initialize the syscall number and default return value. */
 	UPT_SYSCALL_NR(r) = PT_SYSCALL_NR(r->gp);
 	PT_REGS_SET_SYSCALL_RETURN(regs, -ENOSYS);
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 3a2fe54bef65..6a051b078359 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -19,11 +19,29 @@
 #include <kern_util.h>
 #include <os.h>
 #include <timer-internal.h>
+#include <shared/init.h>
+
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+enum time_travel_mode time_travel_mode;
+unsigned long long time_travel_time;
+enum time_travel_timer_mode time_travel_timer_mode;
+unsigned long long time_travel_timer_expiry;
+unsigned long long time_travel_timer_interval;
+
+static bool time_travel_start_set;
+static unsigned long long time_travel_start;
+#else
+#define time_travel_start_set 0
+#define time_travel_start 0
+#endif
 
 void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
 	unsigned long flags;
 
+	if (time_travel_mode != TT_MODE_OFF)
+		time_travel_set_time(time_travel_timer_expiry);
+
 	local_irq_save(flags);
 	do_IRQ(TIMER_IRQ, regs);
 	local_irq_restore(flags);
@@ -31,26 +49,47 @@ void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 
 static int itimer_shutdown(struct clock_event_device *evt)
 {
-	os_timer_disable();
+	if (time_travel_mode != TT_MODE_OFF)
+		time_travel_set_timer(TT_TMR_DISABLED, 0);
+
+	if (time_travel_mode != TT_MODE_INFCPU)
+		os_timer_disable();
+
 	return 0;
 }
 
 static int itimer_set_periodic(struct clock_event_device *evt)
 {
-	os_timer_set_interval(NSEC_PER_SEC / HZ);
+	unsigned long long interval = NSEC_PER_SEC / HZ;
+
+	if (time_travel_mode != TT_MODE_OFF)
+		time_travel_set_timer(TT_TMR_PERIODIC,
+				      time_travel_time + interval);
+
+	if (time_travel_mode != TT_MODE_INFCPU)
+		os_timer_set_interval(interval);
+
 	return 0;
 }
 
 static int itimer_next_event(unsigned long delta,
 			     struct clock_event_device *evt)
 {
-	return os_timer_one_shot(delta + 1);
+	delta += 1;
+
+	if (time_travel_mode != TT_MODE_OFF)
+		time_travel_set_timer(TT_TMR_ONESHOT,
+				      time_travel_time + delta);
+
+	if (time_travel_mode != TT_MODE_INFCPU)
+		return os_timer_one_shot(delta);
+
+	return 0;
 }
 
 static int itimer_one_shot(struct clock_event_device *evt)
 {
-	os_timer_one_shot(1);
-	return 0;
+	return itimer_next_event(0, evt);
 }
 
 static struct clock_event_device timer_clockevent = {
@@ -87,6 +126,17 @@ static irqreturn_t um_timer(int irq, void *dev)
 
 static u64 timer_read(struct clocksource *cs)
 {
+	if (time_travel_mode != TT_MODE_OFF) {
+		/*
+		 * We make reading the timer cost a bit so that we don't get
+		 * stuck in loops that expect time to move more than the
+		 * exact requested sleep amount, e.g. python's socket server,
+		 * see https://bugs.python.org/issue37026.
+		 */
+		time_travel_set_time(time_travel_time + TIMER_MULTIPLIER);
+		return time_travel_time / TIMER_MULTIPLIER;
+	}
+
 	return os_nsecs() / TIMER_MULTIPLIER;
 }
 
@@ -123,7 +173,12 @@ static void __init um_timer_setup(void)
 
 void read_persistent_clock64(struct timespec64 *ts)
 {
-	long long nsecs = os_persistent_clock_emulation();
+	long long nsecs;
+
+	if (time_travel_start_set)
+		nsecs = time_travel_start + time_travel_time;
+	else
+		nsecs = os_persistent_clock_emulation();
 
 	set_normalized_timespec64(ts, nsecs / NSEC_PER_SEC,
 				  nsecs % NSEC_PER_SEC);
@@ -134,3 +189,65 @@ void __init time_init(void)
 	timer_set_signal_handler();
 	late_time_init = um_timer_setup;
 }
+
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+unsigned long calibrate_delay_is_known(void)
+{
+	if (time_travel_mode == TT_MODE_INFCPU)
+		return 1;
+	return 0;
+}
+
+int setup_time_travel(char *str)
+{
+	if (strcmp(str, "=inf-cpu") == 0) {
+		time_travel_mode = TT_MODE_INFCPU;
+		timer_clockevent.name = "time-travel-timer-infcpu";
+		timer_clocksource.name = "time-travel-clock";
+		return 1;
+	}
+
+	if (!*str) {
+		time_travel_mode = TT_MODE_BASIC;
+		timer_clockevent.name = "time-travel-timer";
+		timer_clocksource.name = "time-travel-clock";
+		return 1;
+	}
+
+	return -EINVAL;
+}
+
+__setup("time-travel", setup_time_travel);
+__uml_help(setup_time_travel,
+"time-travel\n"
+"This option just enables basic time travel mode, in which the clock/timers\n"
+"inside the UML instance skip forward when there's nothing to do, rather than\n"
+"waiting for real time to elapse. However, instance CPU speed is limited by\n"
+"the real CPU speed, so e.g. a 10ms timer will always fire after ~10ms wall\n"
+"clock (but quicker when there's nothing to do).\n"
+"\n"
+"time-travel=inf-cpu\n"
+"This enables time travel mode with infinite processing power, in which there\n"
+"are no wall clock timers, and any CPU processing happens - as seen from the\n"
+"guest - instantly. This can be useful for accurate simulation regardless of\n"
+"debug overhead, physical CPU speed, etc. but is somewhat dangerous as it can\n"
+"easily lead to getting stuck (e.g. if anything in the system busy loops).\n");
+
+int setup_time_travel_start(char *str)
+{
+	int err;
+
+	err = kstrtoull(str, 0, &time_travel_start);
+	if (err)
+		return err;
+
+	time_travel_start_set = 1;
+	return 1;
+}
+
+__setup("time-travel-start", setup_time_travel_start);
+__uml_help(setup_time_travel_start,
+"time-travel-start=<seconds>\n"
+"Configure the UML instance's wall clock to start at this value rather than\n"
+"the host's wall clock at the time of UML boot.\n");
+#endif
-- 
2.17.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

