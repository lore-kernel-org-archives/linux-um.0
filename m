Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu82Z-0003ty-Se
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:14:07 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu82Z-00049d-3G
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:14:07 +0000
Date: Thu, 18 Aug 2011 20:14:00 +0100
MIME-Version: 1.0
Message-Id: <E1Qu82S-00089S-2u@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Subject: [PATCH 90/91] um: kill system-um.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


most of it belonged in irqflags.h, actually

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/asm/irqflags.h  |   38 ++++++++++++++++++++++++++++++++-
 arch/um/include/asm/system-um.h |   45 ---------------------------------------
 arch/x86/um/asm/system.h        |    4 ++-
 3 files changed, 40 insertions(+), 47 deletions(-)
 delete mode 100644 arch/um/include/asm/system-um.h

diff --git a/arch/um/include/asm/irqflags.h b/arch/um/include/asm/irqflags.h
index 659b9ab..c780d8a 100644
--- a/arch/um/include/asm/irqflags.h
+++ b/arch/um/include/asm/irqflags.h
@@ -1,6 +1,42 @@
 #ifndef __UM_IRQFLAGS_H
 #define __UM_IRQFLAGS_H
 
-/* Empty for now */
+extern int get_signals(void);
+extern int set_signals(int enable);
+extern void block_signals(void);
+extern void unblock_signals(void);
+
+static inline unsigned long arch_local_save_flags(void)
+{
+	return get_signals();
+}
+
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	set_signals(flags);
+}
+
+static inline void arch_local_irq_enable(void)
+{
+	unblock_signals();
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	block_signals();
+}
+
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags;
+	flags = arch_local_save_flags();
+	arch_local_irq_disable();
+	return flags;
+}
+
+static inline bool arch_irqs_disabled(void)
+{
+	return arch_local_save_flags() == 0;
+}
 
 #endif
diff --git a/arch/um/include/asm/system-um.h b/arch/um/include/asm/system-um.h
deleted file mode 100644
index 0eec245..0000000
--- a/arch/um/include/asm/system-um.h
+++ /dev/null
@@ -1,45 +0,0 @@
-#ifndef __UM_SYSTEM_GENERIC_H
-#define __UM_SYSTEM_GENERIC_H
-
-extern int get_signals(void);
-extern int set_signals(int enable);
-extern void block_signals(void);
-extern void unblock_signals(void);
-
-static inline unsigned long arch_local_save_flags(void)
-{
-	return get_signals();
-}
-
-static inline void arch_local_irq_restore(unsigned long flags)
-{
-	set_signals(flags);
-}
-
-static inline void arch_local_irq_enable(void)
-{
-	unblock_signals();
-}
-
-static inline void arch_local_irq_disable(void)
-{
-	block_signals();
-}
-
-static inline unsigned long arch_local_irq_save(void)
-{
-	unsigned long flags;
-	flags = arch_local_save_flags();
-	arch_local_irq_disable();
-	return flags;
-}
-
-static inline bool arch_irqs_disabled(void)
-{
-	return arch_local_save_flags() == 0;
-}
-
-extern void *_switch_to(void *prev, void *next, void *last);
-#define switch_to(prev, next, last) prev = _switch_to(prev, next, last)
-
-#endif
diff --git a/arch/x86/um/asm/system.h b/arch/x86/um/asm/system.h
index a89113b..a459fd9 100644
--- a/arch/x86/um/asm/system.h
+++ b/arch/x86/um/asm/system.h
@@ -6,7 +6,6 @@
 #include <asm/cpufeature.h>
 #include <asm/cmpxchg.h>
 #include <asm/nops.h>
-#include <asm/system-um.h>
 
 #include <linux/kernel.h>
 #include <linux/irqflags.h>
@@ -130,4 +129,7 @@ static inline void rdtsc_barrier(void)
 	alternative(ASM_NOP3, "lfence", X86_FEATURE_LFENCE_RDTSC);
 }
 
+extern void *_switch_to(void *prev, void *next, void *last);
+#define switch_to(prev, next, last) prev = _switch_to(prev, next, last)
+
 #endif
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

