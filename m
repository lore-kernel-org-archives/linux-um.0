Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lI8n1-00En7A-4o
 for linux-um@lists.infradead.org; Fri, 05 Mar 2021 11:38:45 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3 4/9] um: export signals_enabled directly
Date: Fri,  5 Mar 2021 12:37:52 +0100
Message-Id: <20210305123552.b1cae3585b98.I2a08cbe698fc23f1731e33e4f2582475290b90dc@changeid>
In-Reply-To: <20210305113756.331001-1-johannes@sipsolutions.net>
References: <20210305113756.331001-1-johannes@sipsolutions.net>
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

Use signals_enabled instead of always jumping through
a function call to read it, there's not much point in
that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/irqflags.h   | 10 +++++-----
 arch/um/include/shared/longjmp.h | 14 +++++++-------
 arch/um/include/shared/os.h      |  1 -
 arch/um/kernel/ksyms.c           |  2 +-
 arch/um/os-Linux/signal.c        |  7 +------
 5 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/um/include/asm/irqflags.h b/arch/um/include/asm/irqflags.h
index 0642ad9035d1..dab5744e9253 100644
--- a/arch/um/include/asm/irqflags.h
+++ b/arch/um/include/asm/irqflags.h
@@ -2,15 +2,15 @@
 #ifndef __UM_IRQFLAGS_H
 #define __UM_IRQFLAGS_H
 
-extern int get_signals(void);
-extern int set_signals(int enable);
-extern void block_signals(void);
-extern void unblock_signals(void);
+extern int signals_enabled;
+int set_signals(int enable);
+void block_signals(void);
+void unblock_signals(void);
 
 #define arch_local_save_flags arch_local_save_flags
 static inline unsigned long arch_local_save_flags(void)
 {
-	return get_signals();
+	return signals_enabled;
 }
 
 #define arch_local_irq_restore arch_local_irq_restore
diff --git a/arch/um/include/shared/longjmp.h b/arch/um/include/shared/longjmp.h
index 85a1cc290ecb..bdb2869b72b3 100644
--- a/arch/um/include/shared/longjmp.h
+++ b/arch/um/include/shared/longjmp.h
@@ -5,6 +5,7 @@
 #include <sysdep/archsetjmp.h>
 #include <os.h>
 
+extern int signals_enabled;
 extern int setjmp(jmp_buf);
 extern void longjmp(jmp_buf, int);
 
@@ -12,13 +13,12 @@ extern void longjmp(jmp_buf, int);
 	longjmp(*buf, val);	\
 } while(0)
 
-#define UML_SETJMP(buf) ({ \
-	int n;	   \
-	volatile int enable;	\
-	enable = get_signals(); \
-	n = setjmp(*buf); \
-	if(n != 0) \
-		set_signals_trace(enable); \
+#define UML_SETJMP(buf) ({				\
+	int n, enable;					\
+	enable = *(volatile int *)&signals_enabled;	\
+	n = setjmp(*buf);				\
+	if(n != 0)					\
+		set_signals_trace(enable);		\
 	n; })
 
 #endif
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 13d86f94cf0f..f9fbbddc38bb 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -237,7 +237,6 @@ extern void send_sigio_to_self(void);
 extern int change_sig(int signal, int on);
 extern void block_signals(void);
 extern void unblock_signals(void);
-extern int get_signals(void);
 extern int set_signals(int enable);
 extern int set_signals_trace(int enable);
 extern int os_is_signal_stack(void);
diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
index 8ade54a86a7e..b1e5634398d0 100644
--- a/arch/um/kernel/ksyms.c
+++ b/arch/um/kernel/ksyms.c
@@ -7,7 +7,7 @@
 #include <os.h>
 
 EXPORT_SYMBOL(set_signals);
-EXPORT_SYMBOL(get_signals);
+EXPORT_SYMBOL(signals_enabled);
 
 EXPORT_SYMBOL(os_stat_fd);
 EXPORT_SYMBOL(os_stat_file);
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 96f511d1aabe..8c9d162e6c51 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -62,7 +62,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 #define SIGALRM_BIT 1
 #define SIGALRM_MASK (1 << SIGALRM_BIT)
 
-static int signals_enabled;
+int signals_enabled;
 static unsigned int signals_pending;
 static unsigned int signals_active = 0;
 
@@ -334,11 +334,6 @@ void unblock_signals(void)
 	}
 }
 
-int get_signals(void)
-{
-	return signals_enabled;
-}
-
 int set_signals(int enable)
 {
 	int ret;
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

