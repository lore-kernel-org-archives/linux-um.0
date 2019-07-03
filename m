Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hiazr-0002QG-6B
 for linux-um@lists.infradead.org; Wed, 03 Jul 2019 08:52:12 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: fix build without CONFIG_UML_TIME_TRAVEL_SUPPORT
Date: Wed,  3 Jul 2019 10:52:01 +0200
Message-Id: <20190703085201.19585-1-johannes@sipsolutions.net>
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
Cc: Richard Weinberger <richard@nod.at>, Johannes Berg <johannes.berg@intel.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Johannes Berg <johannes.berg@intel.com>

When CONFIG_UML_TIME_TRAVEL_SUPPORT isn't set, the build was broken.
Fix this.

Fixes: 065038706f77 ("um: Support time travel mode")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/timer-internal.h | 2 ++
 arch/um/kernel/process.c                | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/shared/timer-internal.h b/arch/um/include/shared/timer-internal.h
index 5ca74f415d52..8574338bf23b 100644
--- a/arch/um/include/shared/timer-internal.h
+++ b/arch/um/include/shared/timer-internal.h
@@ -54,6 +54,8 @@ static inline void time_travel_set_timer(enum time_travel_timer_mode mode,
 					 unsigned long long expiry)
 {
 }
+
+#define time_travel_timer_mode TT_TMR_DISABLED
 #endif
 
 #endif
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index def2091697ca..67c0d1a860e9 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -213,7 +213,7 @@ static void time_travel_sleep(unsigned long long duration)
 	if (time_travel_timer_mode != TT_TMR_DISABLED ||
 	    time_travel_timer_expiry < next) {
 		if (time_travel_timer_mode == TT_TMR_ONESHOT)
-			time_travel_timer_mode = TT_TMR_DISABLED;
+			time_travel_set_timer(TT_TMR_DISABLED, 0);
 		/*
 		 * time_travel_time will be adjusted in the timer
 		 * IRQ handler so it works even when the signal
-- 
2.17.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

