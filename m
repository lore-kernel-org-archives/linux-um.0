Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kl9MM-0008Dr-DE
 for linux-um@lists.infradead.org; Fri, 04 Dec 2020 11:34:47 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: time-travel: avoid multiple identical propagations
Date: Fri,  4 Dec 2020 12:34:34 +0100
Message-Id: <20201204123433.01282063e81f.I6cdf9966c9d253628195b50d800c8a688f829b46@changeid>
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

If there is some kind of interrupt negotation or such then
it may happen that we send an update message multiple times,
avoid that in the interest of efficiency by storing the last
transmitted value and only sending a new update if it's not
the same as the last update.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/time.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 5ac084deac7e..2c1c04f4ef27 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -198,7 +198,13 @@ static void time_travel_ext_update_request(unsigned long long time)
 
 void __time_travel_propagate_time(void)
 {
+	static unsigned long long last_propagated;
+
+	if (last_propagated == time_travel_time)
+		return;
+
 	time_travel_ext_req(UM_TIMETRAVEL_UPDATE, time_travel_time);
+	last_propagated = time_travel_time;
 }
 EXPORT_SYMBOL_GPL(__time_travel_propagate_time);
 
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

