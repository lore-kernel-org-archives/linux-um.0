Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2EWI-0001vE-3E
 for linux-um@lists.infradead.org; Thu, 13 Feb 2020 13:27:07 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 5/6] um: implement ndelay/udelay in time-travel mode
Date: Thu, 13 Feb 2020 14:26:48 +0100
Message-Id: <20200213132651.20506-6-johannes@sipsolutions.net>
In-Reply-To: <20200213132651.20506-1-johannes@sipsolutions.net>
References: <20200213132651.20506-1-johannes@sipsolutions.net>
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

In external or inf-cpu time-travel mode, ndelay/udelay currently
just waste CPU time since the simulation time doesn't advance.
Implement them properly in this case.

Note that the "if (time_travel_mode == ...)" parts compile out
if CONFIG_UML_TIME_TRAVEL_SUPPORT isn't set, time_travel_mode is
defined to TT_MODE_OFF in that case.

Change-Id: I2aceb90291d74a46907818e43b90cab47c9f09d1
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/Kbuild            |  1 -
 arch/um/include/asm/delay.h           | 30 +++++++++++++++++++++++++++
 arch/um/include/linux/time-internal.h |  6 ++++++
 arch/um/kernel/time.c                 |  6 ++++++
 4 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/include/asm/delay.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index db7d9d4e30d8..8d435f8a6dec 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -3,7 +3,6 @@ generic-y += bpf_perf_event.h
 generic-y += bug.h
 generic-y += compat.h
 generic-y += current.h
-generic-y += delay.h
 generic-y += device.h
 generic-y += emergency-restart.h
 generic-y += exec.h
diff --git a/arch/um/include/asm/delay.h b/arch/um/include/asm/delay.h
new file mode 100644
index 000000000000..56fc2b8f2dd0
--- /dev/null
+++ b/arch/um/include/asm/delay.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_DELAY_H
+#define __UM_DELAY_H
+#include <asm-generic/delay.h>
+#include <linux/time-internal.h>
+
+static inline void um_ndelay(unsigned long nsecs)
+{
+	if (time_travel_mode == TT_MODE_INFCPU ||
+	    time_travel_mode == TT_MODE_EXTERNAL) {
+		time_travel_ndelay(nsecs);
+		return;
+	}
+	ndelay(nsecs);
+}
+#undef ndelay
+#define ndelay um_ndelay
+
+static inline void um_udelay(unsigned long usecs)
+{
+	if (time_travel_mode == TT_MODE_INFCPU ||
+	    time_travel_mode == TT_MODE_EXTERNAL) {
+		time_travel_ndelay(1000 * usecs);
+		return;
+	}
+	udelay(usecs);
+}
+#undef udelay
+#define udelay um_udelay
+#endif /* __UM_DELAY_H */
diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index e21655926f08..f3b03d39a854 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -75,4 +75,10 @@ static inline void time_travel_wait_readable(int fd)
 {
 }
 #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
+
+/*
+ * Without CONFIG_UML_TIME_TRAVEL_SUPPORT this is a linker error if used,
+ * which is intentional since we really shouldn't link it in that case.
+ */
+void time_travel_ndelay(unsigned long nsec);
 #endif /* __TIMER_INTERNAL_H__ */
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 15c4825b857e..25eaa6a0c658 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -374,6 +374,12 @@ static void time_travel_update_time(unsigned long long next, bool idle)
 	time_travel_del_event(&ne);
 }
 
+void time_travel_ndelay(unsigned long nsec)
+{
+	time_travel_update_time(time_travel_time + nsec, false);
+}
+EXPORT_SYMBOL(time_travel_ndelay);
+
 void time_travel_add_irq_event(struct time_travel_event *e)
 {
 	BUG_ON(time_travel_mode != TT_MODE_EXTERNAL);
-- 
2.24.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

