Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGIvJ-0000DK-9c
 for linux-um@lists.infradead.org; Thu, 10 Sep 2020 09:31:21 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 1/2] um: time-travel: fix IRQ handling in
 time_travel_handle_message()
Date: Thu, 10 Sep 2020 11:31:12 +0200
Message-Id: <20200910113049.6de850314f17.Ic74385f3d36466cc01cc8487fc54affe0fdf7f26@changeid>
In-Reply-To: <20200910093113.90307-1-johannes@sipsolutions.net>
References: <20200910093113.90307-1-johannes@sipsolutions.net>
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

As the comment here indicates, we need to do the polling in the
idle loop without blocking interrupts, since interrupts can be
vhost-user messages that we must process even while in our idle
loop.

I don't know why I explained one thing and implemented another,
but we have indeed observed random hangs due to this, depending
on the timing of the messages.

Fixes: 88ce64249233 ("um: Implement time-travel=ext")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/time.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 25eaa6a0c658..c07436e89e59 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -70,13 +70,17 @@ static void time_travel_handle_message(struct um_timetravel_msg *msg,
 	 * read of the message and write of the ACK.
 	 */
 	if (mode != TTMH_READ) {
+		bool disabled = irqs_disabled();
+
+		BUG_ON(mode == TTMH_IDLE && !disabled);
+
+		if (disabled)
+			local_irq_enable();
 		while (os_poll(1, &time_travel_ext_fd) != 0) {
-			if (mode == TTMH_IDLE) {
-				BUG_ON(!irqs_disabled());
-				local_irq_enable();
-				local_irq_disable();
-			}
+			/* nothing */
 		}
+		if (disabled)
+			local_irq_disable();
 	}
 
 	ret = os_read_file(time_travel_ext_fd, msg, sizeof(*msg));
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

