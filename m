Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5PQq-00066A-Sc
 for linux-um@lists.infradead.org; Wed, 04 Sep 2019 07:10:22 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] um: irq: Fix LAST_IRQ usage
Date: Wed,  4 Sep 2019 09:10:07 +0200
Message-Id: <20190904071007.7837-1-johannes@sipsolutions.net>
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
Cc: Erel Geron <erelx.geron@intel.com>, Johannes Berg <johannes.berg@intel.com>

From: Erel Geron <erelx.geron@intel.com>

LAST_IRQ was used incorrectly in init_IRQ.
Fix this.

Change-Id: I8676920b31fbe61adadc35e36d6f8ad677af5b08
Signed-off-by: Erel Geron <erelx.geron@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/95123
Tested-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/irq.h | 2 +-
 arch/um/kernel/irq.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
index 49ed3e35b35a..ce7a78c3bcf2 100644
--- a/arch/um/include/asm/irq.h
+++ b/arch/um/include/asm/irq.h
@@ -23,7 +23,7 @@
 #define VECTOR_BASE_IRQ		15
 #define VECTOR_IRQ_SPACE	8
 
-#define LAST_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ)
+#define LAST_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ - 1)
 
 #else
 
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index efde1f16c603..402e59bdb65b 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -480,7 +480,7 @@ void __init init_IRQ(void)
 	irq_set_chip_and_handler(TIMER_IRQ, &SIGVTALRM_irq_type, handle_edge_irq);
 
 
-	for (i = 1; i < LAST_IRQ; i++)
+	for (i = 1; i <= LAST_IRQ; i++)
 		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
 	/* Initialize EPOLL Loop */
 	os_setup_epoll();
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

