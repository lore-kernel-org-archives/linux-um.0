Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i174u-00053X-2F
 for linux-um@lists.infradead.org; Fri, 23 Aug 2019 10:45:58 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 3/4] arch: um: remove misleading #define ARCh_IRQ_ENABLED
Date: Fri, 23 Aug 2019 12:44:28 +0200
Message-Id: <20190823104429.11047-3-johannes@sipsolutions.net>
In-Reply-To: <20190823104429.11047-1-johannes@sipsolutions.net>
References: <20190823104429.11047-1-johannes@sipsolutions.net>
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

Due to the typo in the name, this can never be used, but
it's also misleading because our value for enabled/disabled
is always just 0/1, not an actual signal mask.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/irqflags.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/include/asm/irqflags.h b/arch/um/include/asm/irqflags.h
index cbc6c0013a64..0642ad9035d1 100644
--- a/arch/um/include/asm/irqflags.h
+++ b/arch/um/include/asm/irqflags.h
@@ -32,7 +32,6 @@ static inline void arch_local_irq_disable(void)
 }
 
 #define ARCH_IRQ_DISABLED	0
-#define ARCh_IRQ_ENABLED	(SIGIO|SIGVTALRM)
 
 #include <asm-generic/irqflags.h>
 
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

