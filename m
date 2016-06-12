Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1bCBd6-0000HX-4v
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2016 20:05:08 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1bCBd5-0000rr-9B for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2016 20:05:08 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 12 Jun 2016 22:04:53 +0200
Message-Id: <1465761894-27078-1-git-send-email-richard@nod.at>
Subject: [uml-devel] [PATCH 1/2] um: Use asm-generic/irqflags.h
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, daniel.wagner@bmw-carit.de, linux-kernel@vger.kernel.org

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Instead proving its own arch_local_irq_save() and arch_irqs_disabled()
version use the generic version from asm-generic/irqflags.h.

A nice side effect is that um gets a few additional arch_ functions
as well.

One problem though is the include for the signals. I could figured out
which header file to pick without trigger a bunch of header include
clashes. Leaving it away works though it is surely not the best
practice.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/irqflags.h | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/um/include/asm/irqflags.h b/arch/um/include/asm/irqflags.h
index c780d8a..71c2d64 100644
--- a/arch/um/include/asm/irqflags.h
+++ b/arch/um/include/asm/irqflags.h
@@ -6,37 +6,35 @@ extern int set_signals(int enable);
 extern void block_signals(void);
 extern void unblock_signals(void);
 
+#define arch_local_save_flags arch_local_save_flags
 static inline unsigned long arch_local_save_flags(void)
 {
 	return get_signals();
 }
 
+#define arch_local_irq_restore arch_local_irq_restore
 static inline void arch_local_irq_restore(unsigned long flags)
 {
 	set_signals(flags);
 }
 
+#define arch_local_irq_enable arch_local_irq_enable
 static inline void arch_local_irq_enable(void)
 {
 	unblock_signals();
 }
 
+#define arch_local_irq_disable arch_local_irq_disable
 static inline void arch_local_irq_disable(void)
 {
 	block_signals();
 }
 
-static inline unsigned long arch_local_irq_save(void)
-{
-	unsigned long flags;
-	flags = arch_local_save_flags();
-	arch_local_irq_disable();
-	return flags;
-}
+/* #include <uapi/asm/signal.h> */
 
-static inline bool arch_irqs_disabled(void)
-{
-	return arch_local_save_flags() == 0;
-}
+#define ARCH_IRQ_DISABLED	0
+#define ARCh_IRQ_ENABLED	(SIGIO|SIGVTALRM)
+
+#include <asm-generic/irqflags.h>
 
 #endif
-- 
2.7.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

