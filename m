Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7HBc-0001AP-SR
 for linux-um@lists.infradead.org; Wed, 03 Feb 2021 12:23:09 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: irq.h: include <asm-generic/irq.h>
Date: Wed,  3 Feb 2021 13:23:02 +0100
Message-Id: <20210203132302.cbcb6da074b9.I09cc30d8b2ab45e0d9c31429a8c20d34f54a3a78@changeid>
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

This will get the (no-op) definition of irq_canonicalize()
which some code might want. We could define that ourselves,
but it seems like we'd likely want generic extensions in
the future, if any.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/irq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
index 547bff7b3a89..3f5d3e8228fc 100644
--- a/arch/um/include/asm/irq.h
+++ b/arch/um/include/asm/irq.h
@@ -33,4 +33,5 @@
 
 #define NR_IRQS			64
 
+#include <asm-generic/irq.h>
 #endif
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

