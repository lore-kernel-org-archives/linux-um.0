Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0Nc1-0002nB-UW
 for linux-um@lists.infradead.org; Fri, 15 Jan 2021 11:49:54 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: time: fix initialization in time-travel mode
Date: Fri, 15 Jan 2021 12:49:45 +0100
Message-Id: <20210115124945.63c5931f41fe.Ia3f0736fab828635abfaa670fb7775a397b0ca49@changeid>
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

In time-travel mode, since my previous patch, the start time was
initialized too late, so that the system would read it before we
set it, thus always starting system time at 0 (1970-01-01). This
happens because timekeeping_init() reads the time and is called
before time_init().

Unfortunately, I didn't see this before because I was testing it
only with the RTC patch applied (and enabled), and then the time
is read again by the RTC a little - after time_init() this time.

Fix this by just doing the initialization whenever necessary.

Fixes: 906d5ab985a3 ("um: time: Fix read_persistent_clock64() in time-travel")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/time.c | 50 +++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index d0f93e9e3210..e0cdb9694fb8 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -548,6 +548,31 @@ static int time_travel_connect_external(const char *socket)
 
 	return 1;
 }
+
+static void time_travel_set_start(void)
+{
+	if (time_travel_start_set)
+		return;
+
+	switch (time_travel_mode) {
+	case TT_MODE_EXTERNAL:
+		time_travel_start = time_travel_ext_req(UM_TIMETRAVEL_GET_TOD, -1);
+		/* controller gave us the *current* time, so adjust by that */
+		time_travel_ext_get_time();
+		time_travel_start -= time_travel_time;
+		break;
+	case TT_MODE_INFCPU:
+	case TT_MODE_BASIC:
+		if (!time_travel_start_set)
+			time_travel_start = os_persistent_clock_emulation();
+		break;
+	case TT_MODE_OFF:
+		/* we just read the host clock with os_persistent_clock_emulation() */
+		break;
+	}
+
+	time_travel_start_set = true;
+}
 #else /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 #define time_travel_start_set 0
 #define time_travel_start 0
@@ -566,6 +591,10 @@ static void time_travel_set_interval(unsigned long long interval)
 {
 }
 
+static inline void time_travel_set_start(void)
+{
+}
+
 /* fail link if this actually gets used */
 extern u64 time_travel_ext_req(u32 op, u64 time);
 
@@ -746,6 +775,8 @@ void read_persistent_clock64(struct timespec64 *ts)
 {
 	long long nsecs;
 
+	time_travel_set_start();
+
 	if (time_travel_mode != TT_MODE_OFF)
 		nsecs = time_travel_start + time_travel_time;
 	else
@@ -757,25 +788,6 @@ void read_persistent_clock64(struct timespec64 *ts)
 
 void __init time_init(void)
 {
-#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
-	switch (time_travel_mode) {
-	case TT_MODE_EXTERNAL:
-		time_travel_start = time_travel_ext_req(UM_TIMETRAVEL_GET_TOD, -1);
-		/* controller gave us the *current* time, so adjust by that */
-		time_travel_ext_get_time();
-		time_travel_start -= time_travel_time;
-		break;
-	case TT_MODE_INFCPU:
-	case TT_MODE_BASIC:
-		if (!time_travel_start_set)
-			time_travel_start = os_persistent_clock_emulation();
-		break;
-	case TT_MODE_OFF:
-		/* we just read the host clock with os_persistent_clock_emulation() */
-		break;
-	}
-#endif
-
 	timer_set_signal_handler();
 	late_time_init = um_timer_setup;
 }
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

