Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgS39-000828-C4
 for linux-um@lists.infradead.org; Sat, 21 Nov 2020 12:31:33 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] um: simplify os_idle_sleep() and sleep longer
Date: Sat, 21 Nov 2020 13:31:11 +0100
Message-Id: <20201121133110.c08aab9c34aa.I3b692c844a4ca459ee3084334a92ac5ef5b4cec4@changeid>
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
and avoid doing some work every second. Bump to two minutes.

In externally controlled time-travel mode, just wait "forever",
which basically sets our next event if any, and if we really
don't have any then we'll wait forever without any control
socket communication until the outside system sends us an event.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/linux/time-internal.h |  2 +-
 arch/um/include/shared/os.h           |  2 +-
 arch/um/kernel/process.c              | 11 ++++-------
 arch/um/kernel/time.c                 | 11 ++++++++++-
 arch/um/os-Linux/time.c               |  8 +++-----
 5 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index f3b03d39a854..deb7f1d209eb 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -28,7 +28,7 @@ struct time_travel_event {
 
 extern enum time_travel_mode time_travel_mode;
 
-void time_travel_sleep(unsigned long long duration);
+void time_travel_sleep(void);
 
 static inline void
 time_travel_set_event_fn(struct time_travel_event *e,
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index f467d28fc0b4..c89ce642b0d3 100644
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
index 26b5e243d3fc..6f599b206bc7 100644
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
index 8dafc3f2add4..b69130c77827 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -399,13 +399,22 @@ static void time_travel_oneshot_timer(struct time_travel_event *e)
 	deliver_alarm();
 }
 
-void time_travel_sleep(unsigned long long duration)
+void time_travel_sleep(void)
 {
+	unsigned long long duration = NSEC_PER_SEC * 120;
 	unsigned long long next = time_travel_time + duration;
 
 	if (time_travel_mode == TT_MODE_BASIC)
 		os_timer_disable();
 
+	/*
+	 * In external mode, just tell the external controller we'll
+	 * (essentially) wait "forever" (S64_MAX because there are
+	 * some potential wrapping issues.)
+	 */
+	if (time_travel_mode == TT_MODE_EXTERNAL)
+		next = S64_MAX;
+
 	time_travel_update_time(next, true);
 
 	if (time_travel_mode == TT_MODE_BASIC &&
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 90f6de224c70..56386ee9e7e8 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -99,14 +99,12 @@ long long os_nsecs(void)
 }
 
 /**
- * os_idle_sleep() - sleep for a given time of nsecs
- * @nsecs: nanoseconds to sleep
+ * os_idle_sleep() - idle sleep for some (long) time
  */
-void os_idle_sleep(unsigned long long nsecs)
+void os_idle_sleep(void)
 {
 	struct timespec ts = {
-		.tv_sec  = nsecs / UM_NSEC_PER_SEC,
-		.tv_nsec = nsecs % UM_NSEC_PER_SEC
+		.tv_sec = 120,
 	};
 
 	/*
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

