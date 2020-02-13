Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2EWI-0001vI-3K
 for linux-um@lists.infradead.org; Thu, 13 Feb 2020 13:27:09 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 6/6] um: implement cpu_relax() as ndelay(1) for time-travel
Date: Thu, 13 Feb 2020 14:26:49 +0100
Message-Id: <20200213132651.20506-7-johannes@sipsolutions.net>
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

In time-travel mode, cpu_relax() currently does actual CPU relax,
but that doesn't affect the simulation. Ideally, we wouldn't run
anything that uses it in simulation, but if we actually have virtio
devices combined with the same simulation it's possible. Implement
cpu_relax() as ndelay(1) in this case, using time_travel_ndelay(1)
directly to catch errors if this is used erroneously in builds that
don't set CONFIG_UML_TIME_TRAVEL_SUPPORT.

While at it, convert it to an __always_inline and also add that to
rep_nop() like the original does now.

Change-Id: I9c86c5c488c1cb2f7eabf4e8b8d1da9e24163ca9
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/x86/um/asm/processor.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/asm/processor.h b/arch/x86/um/asm/processor.h
index 593d5f3902bd..478710384b34 100644
--- a/arch/x86/um/asm/processor.h
+++ b/arch/x86/um/asm/processor.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __UM_PROCESSOR_H
 #define __UM_PROCESSOR_H
+#include <linux/time-internal.h>
 
 /* include faultinfo structure */
 #include <sysdep/faultinfo.h>
@@ -21,12 +22,19 @@
 #include <asm/user.h>
 
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
-static inline void rep_nop(void)
+static __always_inline void rep_nop(void)
 {
 	__asm__ __volatile__("rep;nop": : :"memory");
 }
 
-#define cpu_relax()		rep_nop()
+static __always_inline void cpu_relax(void)
+{
+	if (time_travel_mode == TT_MODE_INFCPU ||
+	    time_travel_mode == TT_MODE_EXTERNAL)
+		time_travel_ndelay(1);
+	else
+		rep_nop();
+}
 
 #define task_pt_regs(t) (&(t)->thread.regs)
 
-- 
2.24.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

