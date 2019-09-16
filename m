Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9qhk-0002fA-JC
 for linux-um@lists.infradead.org; Mon, 16 Sep 2019 13:06:09 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: move timer-internal.h to non-shared
Date: Mon, 16 Sep 2019 15:05:59 +0200
Message-Id: <1568639159-Iae380466e34ef64cede349e6bd6eeb7854230d1a@changeid>
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

This file isn't really shared, it's only used on the kernel side,
not on the user side. Remove the include from the user-side and
move the file to a better place.

While at it, rename it to time-internal.h, it's not really just
timers but all kinds of things related to timekeeping.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../include/{shared/timer-internal.h => linux/time-internal.h}  | 0
 arch/um/kernel/process.c                                        | 2 +-
 arch/um/kernel/skas/syscall.c                                   | 2 +-
 arch/um/kernel/time.c                                           | 2 +-
 arch/um/os-Linux/time.c                                         | 1 -
 5 files changed, 3 insertions(+), 4 deletions(-)
 rename arch/um/include/{shared/timer-internal.h => linux/time-internal.h} (100%)

diff --git a/arch/um/include/shared/timer-internal.h b/arch/um/include/linux/time-internal.h
similarity index 100%
rename from arch/um/include/shared/timer-internal.h
rename to arch/um/include/linux/time-internal.h
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 263a8f069133..201ca2b4c758 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -32,7 +32,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <skas.h>
-#include <timer-internal.h>
+#include <linux/time-internal.h>
 
 /*
  * This is a per-cpu array.  A processor only modifies its entry and it only
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index f574b1856bc6..58d40fe4f1aa 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -10,7 +10,7 @@
 #include <sysdep/ptrace.h>
 #include <sysdep/ptrace_user.h>
 #include <sysdep/syscalls.h>
-#include <shared/timer-internal.h>
+#include <linux/time-internal.h>
 
 void handle_syscall(struct uml_pt_regs *r)
 {
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 94ea87bd231c..a849d391e909 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -18,7 +18,7 @@
 #include <asm/param.h>
 #include <kern_util.h>
 #include <os.h>
-#include <timer-internal.h>
+#include <linux/time-internal.h>
 #include <shared/init.h>
 
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 432f8e1f55c2..90f6de224c70 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -14,7 +14,6 @@
 #include <kern_util.h>
 #include <os.h>
 #include <string.h>
-#include <timer-internal.h>
 
 static timer_t event_high_res_timer = 0;
 
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

