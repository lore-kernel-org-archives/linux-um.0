Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgCiK-00089r-Cg
 for linux-um@lists.infradead.org; Fri, 20 Nov 2020 20:09:01 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: fix time-travel mode
Date: Fri, 20 Nov 2020 21:08:51 +0100
Message-Id: <20201120210848.f17108c78a7d.I92463af4568758150390ef9e450edabff42c87f3@changeid>
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

Since the time-travel rework, basic time-travel mode hasn't worked
properly, but there's no longer a need for this WARN_ON() so just
remove it and thereby fix things.

Fixes: 4b786e24ca80 ("um: time-travel: Rewrite as an event scheduler")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/time.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 3d109ff3309b..8dafc3f2add4 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -260,11 +260,6 @@ static void __time_travel_add_event(struct time_travel_event *e,
 	struct time_travel_event *tmp;
 	bool inserted = false;
 
-	if (WARN(time_travel_mode == TT_MODE_BASIC &&
-		 e != &time_travel_timer_event,
-		 "only timer events can be handled in basic mode"))
-		return;
-
 	if (e->pending)
 		return;
 
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

