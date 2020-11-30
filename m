Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kji60-0005GX-SZ
 for linux-um@lists.infradead.org; Mon, 30 Nov 2020 12:16:00 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v6 3/5] um: allow PM with suspend-to-idle
Date: Mon, 30 Nov 2020 13:15:48 +0100
Message-Id: <20201130131520.7eddb973cd4c.Id4fe7fb6f0405eb24f3db3ae7a6276293f0ce6f7@changeid>
In-Reply-To: <20201130121550.173513-1-johannes@sipsolutions.net>
References: <20201130121550.173513-1-johannes@sipsolutions.net>
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

In order to be able to experiment with suspend in UML, add the
minimal work to be able to suspend (s2idle) an instance of UML,
and be able to wake it back up from that state with the USR1
signal sent to the main UML process.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig                    |  5 +++++
 arch/um/include/shared/kern_util.h |  2 ++
 arch/um/include/shared/os.h        |  1 +
 arch/um/kernel/um_arch.c           | 25 +++++++++++++++++++++++++
 arch/um/os-Linux/signal.c          | 14 +++++++++++++-
 5 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 4b799fad8b48..1c57599b82fa 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -192,3 +192,8 @@ config UML_TIME_TRAVEL_SUPPORT
 endmenu
 
 source "arch/um/drivers/Kconfig"
+
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+
+source "kernel/power/Kconfig"
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index ccafb62e8cce..9c08e728a675 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -39,6 +39,8 @@ extern int is_syscall(unsigned long addr);
 
 extern void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
 
+extern void uml_pm_wake(void);
+
 extern int start_uml(void);
 extern void paging_init(void);
 
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 0f7fb8bad728..78250a05394a 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -241,6 +241,7 @@ extern int set_signals(int enable);
 extern int set_signals_trace(int enable);
 extern int os_is_signal_stack(void);
 extern void deliver_alarm(void);
+extern void register_pm_wake_signal(void);
 
 /* util.c */
 extern void stack_protections(unsigned long address);
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 76b37297b7d4..237a8d73a096 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task.h>
 #include <linux/kmsg_dump.h>
+#include <linux/suspend.h>
 
 #include <asm/processor.h>
 #include <asm/sections.h>
@@ -377,3 +378,27 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 void text_poke_sync(void)
 {
 }
+
+#ifdef CONFIG_PM_SLEEP
+void uml_pm_wake(void)
+{
+	pm_system_wakeup();
+}
+
+static int init_pm_wake_signal(void)
+{
+	/*
+	 * In external time-travel mode we can't use signals to wake up
+	 * since that would mess with the scheduling. We'll have to do
+	 * some additional work to support wakeup on virtio devices or
+	 * similar, perhaps implementing a fake RTC controller that can
+	 * trigger wakeup (and request the appropriate scheduling from
+	 * the external scheduler when going to suspend.)
+	 */
+	if (time_travel_mode != TT_MODE_EXTERNAL)
+		register_pm_wake_signal();
+	return 0;
+}
+
+late_initcall(init_pm_wake_signal);
+#endif
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index b58bc68cbe64..0a2ea84033b4 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -136,6 +136,16 @@ void set_sigstack(void *sig_stack, int size)
 		panic("enabling signal stack failed, errno = %d\n", errno);
 }
 
+static void sigusr1_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
+{
+	uml_pm_wake();
+}
+
+void register_pm_wake_signal(void)
+{
+	set_handler(SIGUSR1);
+}
+
 static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 	[SIGSEGV] = sig_handler,
 	[SIGBUS] = sig_handler,
@@ -145,7 +155,9 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 
 	[SIGIO] = sig_handler,
 	[SIGWINCH] = sig_handler,
-	[SIGALRM] = timer_alarm_handler
+	[SIGALRM] = timer_alarm_handler,
+
+	[SIGUSR1] = sigusr1_handler,
 };
 
 static void hard_handler(int sig, siginfo_t *si, void *p)
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

