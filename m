Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7gWX-0007JD-RG
 for linux-um@lists.infradead.org; Tue, 10 Sep 2019 13:49:39 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3 1/5] um: don't use generic barrier.h
Date: Tue, 10 Sep 2019 15:49:26 +0200
Message-Id: <1568123305-I95235a4f9e6929241afd5150f1ceceb45f5e28af@changeid>
In-Reply-To: <20190910134930.22688-1-johannes@sipsolutions.net>
References: <20190910134930.22688-1-johannes@sipsolutions.net>
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

UML has its own platform-specific barrier.h under arch/x86/um/,
which should get used. Fix the build system to use it, and then
fix the barrier.h to actually compile.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
I'm debugging some odd stuff with virtio, and the next patch is to
remove dma_rmb/dma_wmb from this, or at least make them conditional
on virtio support, since if we have virtio support we really need
memory barriers there, not just compiler barriers.
.
At least in theory. My problem isn't actually fixed by this.
---
 arch/um/include/asm/Kbuild | 1 -
 arch/x86/um/asm/barrier.h  | 9 +--------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b352ed09260e..398006d27e40 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-generic-y += barrier.h
 generic-y += bpf_perf_event.h
 generic-y += bug.h
 generic-y += compat.h
diff --git a/arch/x86/um/asm/barrier.h b/arch/x86/um/asm/barrier.h
index f31e5d903161..eb0654f39fd2 100644
--- a/arch/x86/um/asm/barrier.h
+++ b/arch/x86/um/asm/barrier.h
@@ -2,14 +2,7 @@
 #ifndef _ASM_UM_BARRIER_H_
 #define _ASM_UM_BARRIER_H_
 
-#include <asm/asm.h>
-#include <asm/segment.h>
-#include <asm/cpufeatures.h>
-#include <asm/cmpxchg.h>
-#include <asm/nops.h>
-
-#include <linux/kernel.h>
-#include <linux/irqflags.h>
+#include <asm/alternative.h>
 
 /*
  * Force strict CPU ordering.
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

