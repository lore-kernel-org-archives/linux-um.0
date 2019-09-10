Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7hgX-0004tO-D1
 for linux-um@lists.infradead.org; Tue, 10 Sep 2019 15:04:03 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 1/2] um: time-travel: fix periodic timers
Date: Tue, 10 Sep 2019 17:03:52 +0200
Message-Id: <1568127832-I40b0f15a0fdd0f17e6636fbfe661e0d3d52e5ef7@changeid>
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

Periodic timers are broken, because the also only fire once.
As it happens, Linux doesn't care because it only sets the
timer to periodic very briefly during boot, and then switches
it only between one-shot and off later.

Nevertheless, fix the logic (we shouldn't even be looking at
time_travel_timer_expiry unless the timer is enabled) and
change the code to fire the timer periodically in periodic
mode, in case it ever gets used in the future.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 - add an explanation to the commit log
---
 arch/um/include/shared/timer-internal.h | 9 +++++++++
 arch/um/kernel/process.c                | 7 ++++++-
 arch/um/kernel/time.c                   | 1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/shared/timer-internal.h b/arch/um/include/shared/timer-internal.h
index 9991ec2371e4..a4d79389b223 100644
--- a/arch/um/include/shared/timer-internal.h
+++ b/arch/um/include/shared/timer-internal.h
@@ -43,6 +43,11 @@ static inline void time_travel_set_timer_expiry(unsigned long long expiry)
 {
 	time_travel_timer_expiry = expiry;
 }
+
+static inline void time_travel_set_timer_interval(unsigned long long interval)
+{
+	time_travel_timer_interval = interval;
+}
 #else
 #define time_travel_mode TT_MODE_OFF
 #define time_travel_time 0
@@ -61,6 +66,10 @@ static inline void time_travel_set_timer_expiry(unsigned long long expiry)
 {
 }
 
+static inline void time_travel_set_timer_interval(unsigned long long interval)
+{
+}
+
 #define time_travel_timer_mode TT_TMR_DISABLED
 #endif
 
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 6bede7888fc2..cf242fc5fe94 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -210,7 +210,12 @@ static void time_travel_sleep(unsigned long long duration)
 	if (time_travel_mode != TT_MODE_INFCPU)
 		os_timer_disable();
 
-	if (time_travel_timer_mode != TT_TMR_DISABLED ||
+	while (time_travel_timer_mode == TT_TMR_PERIODIC &&
+	       time_travel_timer_expiry < time_travel_time)
+		time_travel_set_timer_expiry(time_travel_timer_expiry +
+					     time_travel_timer_interval);
+
+	if (time_travel_timer_mode != TT_TMR_DISABLED &&
 	    time_travel_timer_expiry < next) {
 		if (time_travel_timer_mode == TT_TMR_ONESHOT)
 			time_travel_set_timer_mode(TT_TMR_DISABLED);
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 234757233355..4ecabf7e54c9 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -65,6 +65,7 @@ static int itimer_set_periodic(struct clock_event_device *evt)
 	if (time_travel_mode != TT_MODE_OFF) {
 		time_travel_set_timer_mode(TT_TMR_PERIODIC);
 		time_travel_set_timer_expiry(time_travel_time + interval);
+		time_travel_set_timer_interval(interval);
 	}
 
 	if (time_travel_mode != TT_MODE_INFCPU)
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

