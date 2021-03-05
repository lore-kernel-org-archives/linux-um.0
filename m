Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI9RV-00EwnW-SD
 for linux-um@lists.infradead.org; Fri, 05 Mar 2021 12:20:31 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v4 5/9] um: expose time-travel mode to userspace side
Date: Fri,  5 Mar 2021 13:19:55 +0100
Message-Id: <20210305131934.171d1ec75bea.Id2bd78c4198c3a57eac2ed766fda392944e6f76c@changeid>
In-Reply-To: <20210305122010.442577-1-johannes@sipsolutions.net>
References: <20210305122010.442577-1-johannes@sipsolutions.net>
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

This will be necessary in the userspace side to fix the
signal/interrupt handling in time-travel=ext mode, which
is the next patch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v3: new patch in this patchset
v4: fix circular build dependency
---
 arch/um/include/linux/time-internal.h | 12 +-----------
 arch/um/include/shared/timetravel.h   | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 11 deletions(-)
 create mode 100644 arch/um/include/shared/timetravel.h

diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index 759956ab0108..b22226634ff6 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -8,17 +8,11 @@
 #define __TIMER_INTERNAL_H__
 #include <linux/list.h>
 #include <asm/bug.h>
+#include <shared/timetravel.h>
 
 #define TIMER_MULTIPLIER 256
 #define TIMER_MIN_DELTA  500
 
-enum time_travel_mode {
-	TT_MODE_OFF,
-	TT_MODE_BASIC,
-	TT_MODE_INFCPU,
-	TT_MODE_EXTERNAL,
-};
-
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
 struct time_travel_event {
 	unsigned long long time;
@@ -27,8 +21,6 @@ struct time_travel_event {
 	bool pending, onstack;
 };
 
-extern enum time_travel_mode time_travel_mode;
-
 void time_travel_sleep(void);
 
 static inline void
@@ -62,8 +54,6 @@ bool time_travel_del_event(struct time_travel_event *e);
 struct time_travel_event {
 };
 
-#define time_travel_mode TT_MODE_OFF
-
 static inline void time_travel_sleep(void)
 {
 }
diff --git a/arch/um/include/shared/timetravel.h b/arch/um/include/shared/timetravel.h
new file mode 100644
index 000000000000..e5c3d69f1b69
--- /dev/null
+++ b/arch/um/include/shared/timetravel.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019-2021 Intel Corporation
+ */
+#ifndef _UM_TIME_TRAVEL_H_
+#define _UM_TIME_TRAVEL_H_
+
+enum time_travel_mode {
+	TT_MODE_OFF,
+	TT_MODE_BASIC,
+	TT_MODE_INFCPU,
+	TT_MODE_EXTERNAL,
+};
+
+#if defined(UML_CONFIG_UML_TIME_TRAVEL_SUPPORT) || \
+    defined(CONFIG_UML_TIME_TRAVEL_SUPPORT)
+extern enum time_travel_mode time_travel_mode;
+#else
+#define time_travel_mode TT_MODE_OFF
+#endif /* (UML_)CONFIG_UML_TIME_TRAVEL_SUPPORT */
+
+#endif /* _UM_TIME_TRAVEL_H_ */
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

