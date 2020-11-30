Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kji60-0005GV-SY
 for linux-um@lists.infradead.org; Mon, 30 Nov 2020 12:15:58 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v6 1/5] um: simplify os_idle_sleep() and sleep longer
Date: Mon, 30 Nov 2020 13:15:46 +0100
Message-Id: <20201130131520.3a0d2a5443a2.I3b692c844a4ca459ee3084334a92ac5ef5b4cec4@changeid>
In-Reply-To: <20201130121550.173513-1-johannes@sipsolutions.net>
References: <20201130121550.173513-1-johannes@sipsolutions.net>
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
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

There really is no reason to pass the amount of time we should
sleep, especially since it's just hard-coded to one second.

Additionally, one second isn't really all that long, and as we
are expecting to be woken up by a signal, we can sleep longer
and avoid doing some work every second, so replace the current
clock_nanosleep() with just an empty select() that can _only_
be woken up by a signal.

We can also remove the deliver_alarm() since we don't need to
do that when we got e.g. SIGIO that woke us up, and if we got
SIGALRM the signal handler will actually (have) run, so it's
just unnecessary extra work.

Similarly, in time-travel mode, just program the wakeup event
from idle to be S64_MAX, which is basically the most you could
ever simulate to. Of course, you should already have an event
in the list that's earlier and will cause a wakeup, normally
that's the regular timer interrupt, though in suspend it may
(later) also be an RTC event. Since actually getting to this
point would be a bug and you can't ever get out again, panic()
on it in the time control code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/linux/time-internal.h |  4 ++--
 arch/um/include/shared/os.h           |  2 +-
 arch/um/kernel/process.c              | 11 ++++-------
 arch/um/kernel/time.c                 | 12 ++++++++++--
 arch/um/os-Linux/time.c               | 16 +++-------------
 5 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index f3b03d39a854..68e45e950137 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -28,7 +28,7 @@ struct time_travel_event {
 
 extern enum time_travel_mode time_travel_mode;
 
-void time_travel_sleep(unsigned long long duration);
+void time_travel_sleep(void);
 
 static inline void
 time_travel_set_event_fn(struct time_travel_event *e,
@@ -60,7 +60,7 @@ struct time_travel_event {
 
 #define time_travel_mode TT_MODE_OFF
 
-static inline void time_travel_sleep(unsigned long long duration)
+static inline void time_travel_sleep(void)
 {
 }
 
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index e2bb7e488d59..0f7fb8bad728 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -256,7 +256,7 @@ extern void os_warn(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 
 /* time.c */
-extern void os_idle_sleep(unsigned long long nsecs);
+extern void os_idle_sleep(void);
 extern int os_timer_create(void);
 extern int os_timer_set_interval(unsigned long long nsecs);
 extern int os_timer_one_shot(unsigned long long nsecs);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 3bed09538dd9..0686fabba576 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -204,13 +204,10 @@ void initial_thread_cb(void (*proc)(void *), void *arg)
 
 static void um_idle_sleep(void)
 {
-	unsigned long long duration = UM_NSEC_PER_SEC;
-
-	if (time_travel_mode != TT_MODE_OFF) {
-		time_travel_sleep(duration);
-	} else {
-		os_idle_sleep(duration);
-	}
+	if (time_travel_mode != TT_MODE_OFF)
+		time_travel_sleep();
+	else
+		os_idle_sleep();
 }
 
 void arch_cpu_idle(void)
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 8dafc3f2add4..8e8eb8ba04a4 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -46,6 +46,9 @@ static void time_travel_set_time(unsigned long long ns)
 	if (unlikely(ns < time_travel_time))
 		panic("time-travel: time goes backwards %lld -> %lld\n",
 		      time_travel_time, ns);
+	else if (unlikely(ns >= S64_MAX))
+		panic("The system was going to sleep forever, aborting");
+
 	time_travel_time = ns;
 }
 
@@ -399,9 +402,14 @@ static void time_travel_oneshot_timer(struct time_travel_event *e)
 	deliver_alarm();
 }
 
-void time_travel_sleep(unsigned long long duration)
+void time_travel_sleep(void)
 {
-	unsigned long long next = time_travel_time + duration;
+	/*
+	 * Wait "forever" (using S64_MAX because there are some potential
+	 * wrapping issues, especially with the current TT_MODE_EXTERNAL
+	 * controller application.
+	 */
+	unsigned long long next = S64_MAX;
 
 	if (time_travel_mode == TT_MODE_BASIC)
 		os_timer_disable();
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 90f6de224c70..27b447505782 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -99,19 +99,9 @@ long long os_nsecs(void)
 }
 
 /**
- * os_idle_sleep() - sleep for a given time of nsecs
- * @nsecs: nanoseconds to sleep
+ * os_idle_sleep() - sleep until interrupted
  */
-void os_idle_sleep(unsigned long long nsecs)
+void os_idle_sleep(void)
 {
-	struct timespec ts = {
-		.tv_sec  = nsecs / UM_NSEC_PER_SEC,
-		.tv_nsec = nsecs % UM_NSEC_PER_SEC
-	};
-
-	/*
-	 * Relay the signal if clock_nanosleep is interrupted.
-	 */
-	if (clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL))
-		deliver_alarm();
+	select(0, NULL, NULL, NULL, NULL);
 }
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

