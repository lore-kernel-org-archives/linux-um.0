Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifgpT-0004qI-5w
 for linux-um@lists.infradead.org; Fri, 13 Dec 2019 09:01:44 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: fix time-travel=inf-cpu with xor/raid6
Date: Fri, 13 Dec 2019 10:01:28 +0100
Message-Id: <20191213100128.04075cf409e9.Id772dc879535c85524c32b81fd392bbbfd515741@changeid>
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

Today, I erroneously built a time-travel configuration with btrfs
enabled, and noticed it cannot boot in time-travel=inf-cpu mode,
both xor and raid6 speed measurement gets stuck.

For xor, work around it by picking the first algorithm if inf-cpu
mode is enabled.

For raid6, I didn't find such a workaround, so disallow enabling
time-travel mode if RAID6_PQ_BENCHMARK is enabled.

With this, and RAID6_PQ_BENCHMARK disabled, I can boot a kernel
that has btrfs enabled in time-travel=inf-cpu mode.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig            | 2 ++
 arch/um/include/asm/Kbuild | 1 -
 arch/um/include/asm/xor.h  | 7 +++++++
 3 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/include/asm/xor.h

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 2a6d04fcb3e9..a8bf60b5c208 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -188,6 +188,8 @@ config SECCOMP
 config UML_TIME_TRAVEL_SUPPORT
 	bool
 	prompt "Support time-travel mode (e.g. for test execution)"
+	# inf-cpu mode is incompatible with the benchmarking
+	depends on !RAID6_PQ_BENCHMARK
 	help
 	  Enable this option to support time travel inside the UML instance.
 
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 398006d27e40..db7d9d4e30d8 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -25,5 +25,4 @@ generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
-generic-y += xor.h
 generic-y += kprobes.h
diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
new file mode 100644
index 000000000000..7a3208c47cfc
--- /dev/null
+++ b/arch/um/include/asm/xor.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm-generic/xor.h>
+#include <shared/timer-internal.h>
+
+/* pick an arbitrary one - measuring isn't possible with inf-cpu */
+#define XOR_SELECT_TEMPLATE(x)	\
+	(time_travel_mode == TT_MODE_INFCPU ? &xor_block_8regs : NULL)
-- 
2.23.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

