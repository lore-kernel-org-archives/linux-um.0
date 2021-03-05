Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI8n1-00En7G-Eg
 for linux-um@lists.infradead.org; Fri, 05 Mar 2021 11:38:53 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3 7/9] um: irqs: allow invoking time-travel handler multiple
 times
Date: Fri,  5 Mar 2021 12:37:55 +0100
Message-Id: <20210305123552.1d565a356c90.I0344b4c8a7e79d8ac1645acad97371f202837777@changeid>
In-Reply-To: <20210305113756.331001-1-johannes@sipsolutions.net>
References: <20210305113756.331001-1-johannes@sipsolutions.net>
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

If we happen to get multiple messages while IRQS are already
suspended, we still need to handle them, since otherwise the
simulation blocks.

Remove the "prevent nesting" part, time_travel_add_irq_event()
will deal with being called multiple times just fine.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/irq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 1c448ea4729e..f3f19da7b876 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -101,10 +101,12 @@ static bool irq_do_timetravel_handler(struct irq_entry *entry,
 	if (!reg->timetravel_handler)
 		return false;
 
-	/* prevent nesting - we'll get it again later when we SIGIO ourselves */
-	if (reg->pending_on_resume)
-		return true;
-
+	/*
+	 * Handle all messages - we might get multiple even while
+	 * interrupts are already suspended, due to suspend order
+	 * etc. Note that time_travel_add_irq_event() will not add
+	 * an event twice, if it's pending already "first wins".
+	 */
 	reg->timetravel_handler(reg->irq, entry->fd, reg->id, &reg->event);
 
 	if (!reg->event.pending)
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

