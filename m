Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khI4D-0007Ky-GI
 for linux-um@lists.infradead.org; Mon, 23 Nov 2020 20:04:07 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v5 2/5] um: time: fix read_persistent_clock64() in time-travel
Date: Mon, 23 Nov 2020 21:03:53 +0100
Message-Id: <20201123210307.51c595dccd81.I3f5effe88fe040ff9262de115dd71bfd65d2b0a2@changeid>
In-Reply-To: <20201123200356.297213-1-johannes@sipsolutions.net>
References: <20201123200356.297213-1-johannes@sipsolutions.net>
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

In time-travel mode, we've relied on read_persistent_clock64()
being called only once at system startup, but this is both the
right thing to call from the pseudo-RTC, and also gets called
by the timekeeping core during suspend/resume.

Thus, fix this to always fall make use of the time_travel_time
in any time-travel mode, initializing time_travel_start at boot
to the right value depending on the time-travel mode.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/time.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 8e8eb8ba04a4..f060d28d0f83 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -676,10 +676,8 @@ void read_persistent_clock64(struct timespec64 *ts)
 {
 	long long nsecs;
 
-	if (time_travel_start_set)
+	if (time_travel_mode != TT_MODE_OFF)
 		nsecs = time_travel_start + time_travel_time;
-	else if (time_travel_mode == TT_MODE_EXTERNAL)
-		nsecs = time_travel_ext_req(UM_TIMETRAVEL_GET_TOD, -1);
 	else
 		nsecs = os_persistent_clock_emulation();
 
@@ -689,6 +687,23 @@ void read_persistent_clock64(struct timespec64 *ts)
 
 void __init time_init(void)
 {
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
 	timer_set_signal_handler();
 	late_time_init = um_timer_setup;
 }
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

