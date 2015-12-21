Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@brocade.com>) id 1aAydv-0005im-Fj
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Dec 2015 11:28:43 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aAydu-0003Fg-CW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Dec 2015 11:28:43 +0000
From: Anton Ivanov <aivanov@brocade.com>
Date: Mon, 21 Dec 2015 11:28:03 +0000
Message-Id: <1450697283-339440-2-git-send-email-aivanov@brocade.com>
In-Reply-To: <1450697283-339440-1-git-send-email-aivanov@brocade.com>
References: <1450697283-339440-1-git-send-email-aivanov@brocade.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 2/2] Optimization - do not change hard IRQ flags
	in soft IRQ processing
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at, Anton Ivanov <aivanov@brocade.com>

Software IRQ processing in generic architectures assumes that the
exit out of hard IRQ may have re-enabled interrupts (some
architectures may have an implicit EOI). It presumes them enabled
and toggles the flags once more just in case unless this is turned
off in the architecture specific hardirq.h by setting
__ARCH_IRQ_EXIT_IRQS_DISABLED

This patch adds this to UML where due to the way IRQs are handled
it is an optimization (it works fine without it too).

Signed-off-by: Anton Ivanov <aivanov@brocade.com>
---
 arch/um/include/asm/hardirq.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 arch/um/include/asm/hardirq.h

diff --git a/arch/um/include/asm/hardirq.h b/arch/um/include/asm/hardirq.h
new file mode 100644
index 0000000..756f077
--- /dev/null
+++ b/arch/um/include/asm/hardirq.h
@@ -0,0 +1,23 @@
+#ifndef __ASM_UM_HARDIRQ_H
+#define __ASM_UM_HARDIRQ_H
+
+#include <linux/cache.h>
+#include <linux/threads.h>
+
+typedef struct {
+	unsigned int __softirq_pending;
+} ____cacheline_aligned irq_cpustat_t;
+
+#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
+#include <linux/irq.h>
+
+#ifndef ack_bad_irq
+static inline void ack_bad_irq(unsigned int irq)
+{
+	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
+}
+#endif
+
+#define __ARCH_IRQ_EXIT_IRQS_DISABLED 1
+
+#endif /* __ASM_UM_HARDIRQ_H */
-- 
2.1.4


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

