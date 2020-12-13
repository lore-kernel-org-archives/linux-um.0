Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koYlA-00044Z-HG
 for linux-um@lists.infradead.org; Sun, 13 Dec 2020 21:18:29 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: time-travel: correct time event IRQ delivery
Date: Sun, 13 Dec 2020 22:18:18 +0100
Message-Id: <20201213221818.bceac7d53d45.I4380e96f48f8db50b118b49ca050b26d5a74b456@changeid>
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

Lockdep (on 5.10-rc) points out that we're delivering IRQs while IRQs
are not even enabled, which clearly shouldn't happen. Defer the time
event IRQ delivery until they actually are enabled.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/common-offsets.h |  3 ++
 arch/um/include/shared/os.h             |  3 ++
 arch/um/kernel/time.c                   | 38 +++++++++++++++++++++++++
 arch/um/os-Linux/signal.c               |  3 ++
 4 files changed, 47 insertions(+)

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index 4e99fe05576a..16a51a8c800f 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -40,3 +40,6 @@ DEFINE(UML_CONFIG_UML_X86, CONFIG_UML_X86);
 #ifdef CONFIG_64BIT
 DEFINE(UML_CONFIG_64BIT, CONFIG_64BIT);
 #endif
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+DEFINE(UML_CONFIG_UML_TIME_TRAVEL_SUPPORT, CONFIG_UML_TIME_TRAVEL_SUPPORT);
+#endif
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index f467d28fc0b4..9040c2e68825 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -330,4 +330,7 @@ extern void unblock_signals_trace(void);
 extern void um_trace_signals_on(void);
 extern void um_trace_signals_off(void);
 
+/* time-travel */
+extern void deliver_time_travel_irqs(void);
+
 #endif
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 3d109ff3309b..142c7b245ccf 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -31,6 +31,7 @@ static bool time_travel_start_set;
 static unsigned long long time_travel_start;
 static unsigned long long time_travel_time;
 static LIST_HEAD(time_travel_events);
+static LIST_HEAD(time_travel_irqs);
 static unsigned long long time_travel_timer_interval;
 static unsigned long long time_travel_next_event;
 static struct time_travel_event time_travel_timer_event;
@@ -311,6 +312,35 @@ void time_travel_periodic_timer(struct time_travel_event *e)
 	deliver_alarm();
 }
 
+void deliver_time_travel_irqs(void)
+{
+	struct time_travel_event *e;
+	unsigned long flags;
+
+	/*
+	 * Don't do anything for most cases. Note that because here we have
+	 * to disable IRQs (and re-enable later) we'll actually recurse at
+	 * the end of the function, so this is strictly necessary.
+	 */
+	if (likely(list_empty(&time_travel_irqs)))
+		return;
+
+	local_irq_save(flags);
+	irq_enter();
+	while ((e = list_first_entry_or_null(&time_travel_irqs,
+					     struct time_travel_event,
+					     list))) {
+		WARN(e->time != time_travel_time,
+		     "time moved from %lld to %lld before IRQ delivery\n",
+		     time_travel_time, e->time);
+		list_del(&e->list);
+		e->pending = false;
+		e->fn(e);
+	}
+	irq_exit();
+	local_irq_restore(flags);
+}
+
 static void time_travel_deliver_event(struct time_travel_event *e)
 {
 	if (e == &time_travel_timer_event) {
@@ -319,6 +349,14 @@ static void time_travel_deliver_event(struct time_travel_event *e)
 		 * by itself, so must handle it specially here
 		 */
 		e->fn(e);
+	} else if (irqs_disabled()) {
+		list_add_tail(&e->list, &time_travel_irqs);
+		/*
+		 * set pending again, it was set to false when the
+		 * event was deleted from the original list, but
+		 * now it's still pending until we deliver the IRQ.
+		 */
+		e->pending = true;
 	} else {
 		unsigned long flags;
 
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index b58bc68cbe64..b8bbd6c2768c 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -254,6 +254,9 @@ void unblock_signals(void)
 		return;
 
 	signals_enabled = 1;
+#ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
+	deliver_time_travel_irqs();
+#endif
 
 	/*
 	 * We loop because the IRQ handler returns with interrupts off.  So,
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

