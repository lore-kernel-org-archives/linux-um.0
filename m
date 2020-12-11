Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kndMg-0006fx-DW
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 08:01:23 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] um: time-travel: actually apply "free-until" optimisation
Date: Fri, 11 Dec 2020 09:01:14 +0100
Message-Id: <20201211090114.baf5fc3e82e1.I0326b116f23cf30c573a54e9a0d9882c5703ef65@changeid>
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

Due a bug - we never checked the time_travel_ext_free_until value - we
were always requesting time for every single scheduling. This adds up
since we make reading time cost 256ns, and it's a fairly common call.
Fix this.

While at it, also make reading time only cost something when we're not
currently waiting for our scheduling turn - otherwise things get mixed
up in a very confusing way. We should never get here, since we're not
actually running, but it's possible if you stick printk() or such into
the virtio code that must handle the external interrupts.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: fix build w/o CONFIG_UML_TIME_TRAVEL
---
 arch/um/kernel/time.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 303565ce8c64..4acc1eced732 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -183,6 +183,14 @@ static void time_travel_ext_update_request(unsigned long long time)
 	    time == time_travel_ext_prev_request)
 		return;
 
+	/*
+	 * if we're running and are allowed to run past the request
+	 * then we don't need to update it either
+	 */
+	if (!time_travel_ext_waiting && time_travel_ext_free_until_valid &&
+	    time < time_travel_ext_free_until)
+		return;
+
 	time_travel_ext_prev_request = time;
 	time_travel_ext_prev_request_valid = true;
 	time_travel_ext_req(UM_TIMETRAVEL_REQUEST, time);
@@ -217,6 +225,7 @@ static void time_travel_ext_wait(bool idle)
 	};
 
 	time_travel_ext_prev_request_valid = false;
+	time_travel_ext_free_until_valid = false;
 	time_travel_ext_waiting++;
 
 	time_travel_ext_req(UM_TIMETRAVEL_WAIT, -1);
@@ -492,6 +501,7 @@ static int time_travel_connect_external(const char *socket)
 #define time_travel_start_set 0
 #define time_travel_start 0
 #define time_travel_time 0
+#define time_travel_ext_waiting 0
 
 static inline void time_travel_update_time(unsigned long long ns, bool retearly)
 {
@@ -639,7 +649,8 @@ static u64 timer_read(struct clocksource *cs)
 		 * "what do I do next" and onstack event we use to know when
 		 * to return from time_travel_update_time().
 		 */
-		if (!irqs_disabled() && !in_interrupt() && !in_softirq())
+		if (!irqs_disabled() && !in_interrupt() && !in_softirq() &&
+		    !time_travel_ext_waiting)
 			time_travel_update_time(time_travel_time +
 						TIMER_MULTIPLIER,
 						false);
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

