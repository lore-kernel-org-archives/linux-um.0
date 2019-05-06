Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hNcuL-0002ee-7I
 for linux-um@lists.infradead.org; Mon, 06 May 2019 12:39:52 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 5/5] arch: um: support virtual time
Date: Mon,  6 May 2019 14:39:39 +0200
Message-Id: <20190506123939.21091-6-johannes@sipsolutions.net>
In-Reply-To: <20190506123939.21091-1-johannes@sipsolutions.net>
References: <20190506123939.21091-1-johannes@sipsolutions.net>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: j@w1.fi, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

Sometimes it can be useful to run with virtual time inside the
UML instance, for example for testing. For example, some tests
for the wireless subsystem and userspace are based on hwsim, a
virtual wireless adapter. Some tests can take a long time to
run because they e.g. wait for 120 seconds to elapse for some
regulatory checks. This obviously goes faster if it need not
actually wait that long, but time inside the test environment
just "bumps up" when there's nothing to do.

Add a mode - CONFIG_UML_VIRTUAL_TIME_SUPPORT - to support such
behavior; it needs to be enabled with the "virtual-time" option
passed to the UML invocation.

With this enabled, the test mentioned above goes from a runtime
of about 130 seconds (with startup overhead and all) to being
CPU bound and finishing in 16 seconds (on my slow laptop).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig             | 17 ++++++++++
 arch/um/include/shared/os.h | 14 ++++++++
 arch/um/kernel/time.c       | 13 +++++++
 arch/um/os-Linux/time.c     | 68 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index ec9711d068b7..71ff7ef3aa0c 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -180,6 +180,23 @@ config SECCOMP
 
 	  If unsure, say Y.
 
+config UML_VIRTUAL_TIME_SUPPORT
+	bool
+	prompt "Support virtual time (e.g. for test execution)"
+	help
+	  Enable this option to support virtual time inside the UML instance,
+	  which means that whenever there's nothing to do it just skips time
+	  forward rather than waiting for any real time to elapse.
+
+	  Note that this changes behaviour a bit - used CPU time may not always
+	  cause the virtual time to increase unless enough CPU was consumed to
+	  advance the tick (HZ).
+
+	  Note that to enable the virtual time, you also need to pass
+	  "virtual-time" on the command-line.
+
+	  It is safe to say Y, but you probably don't need this, so say N.
+
 endmenu
 
 source "arch/um/drivers/Kconfig"
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 449e71edefaa..a891a5665704 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -257,6 +257,20 @@ extern void os_timer_disable(void);
 extern void uml_idle_timer(void);
 extern long long os_persistent_clock_emulation(void);
 extern long long os_nsecs(void);
+#ifdef CONFIG_UML_VIRTUAL_TIME_SUPPORT
+extern unsigned long long virtual_time;
+extern unsigned long long timer_expiry;
+int os_setup_virtual_time(char *str);
+static inline void os_set_virtual_time_to_timer(void)
+{
+	/* ignored if virtual time isn't enabled */
+	virtual_time = timer_expiry;
+}
+#else
+static inline void os_set_virtual_time_to_timer(void)
+{
+}
+#endif
 
 /* skas/mem.c */
 extern long run_syscall_stub(struct mm_id * mm_idp,
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 3898119f773e..0ceb7c540d60 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -19,11 +19,14 @@
 #include <kern_util.h>
 #include <os.h>
 #include <timer-internal.h>
+#include <shared/init.h>
 
 void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
 	unsigned long flags;
 
+	os_set_virtual_time_to_timer();
+
 	local_irq_save(flags);
 	do_IRQ(TIMER_IRQ, regs);
 	local_irq_restore(flags);
@@ -134,3 +137,13 @@ void __init time_init(void)
 	timer_set_signal_handler();
 	late_time_init = um_timer_setup;
 }
+
+#ifdef CONFIG_UML_VIRTUAL_TIME_SUPPORT
+__setup("virtual-time", os_setup_virtual_time);
+__uml_help(os_setup_virtual_time,
+"virtual-time\n"
+"    Run the system in virtual time mode, i.e. bump time\n"
+"    forward when there's nothing to do, rather than waiting\n"
+"    for real time to elapse. Useful for test execution.\n\n"
+);
+#endif
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index ea720149f5b8..d37ee59cb936 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -15,8 +15,27 @@
 #include <os.h>
 #include <string.h>
 #include <timer-internal.h>
+#include <generated/autoconf.h>
 
 static timer_t event_high_res_timer = 0;
+#ifdef CONFIG_UML_VIRTUAL_TIME_SUPPORT
+unsigned long long virtual_time;
+unsigned long long timer_expiry;
+static enum {
+	TMR_DIS,
+	TMR_ONE,
+	TMR_INT,
+} timer_mode;
+static bool virtual_time_enabled;
+
+int os_setup_virtual_time(char *str)
+{
+	virtual_time_enabled = true;
+	return 1;
+}
+#else
+#define virtual_time_enabled false
+#endif
 
 static inline long long timeval_to_ns(const struct timeval *tv)
 {
@@ -66,6 +85,11 @@ int os_timer_set_interval(void)
 	if (timer_settime(event_high_res_timer, 0, &its, NULL) == -1)
 		return -errno;
 
+#ifdef CONFIG_UML_VIRTUAL_TIME_SUPPORT
+	timer_mode = TMR_INT;
+	timer_expiry = virtual_time + nsec;
+#endif
+
 	return 0;
 }
 
@@ -81,6 +105,10 @@ int os_timer_one_shot(unsigned long ticks)
 	};
 
 	timer_settime(event_high_res_timer, 0, &its, NULL);
+#ifdef CONFIG_UML_VIRTUAL_TIME_SUPPORT
+	timer_mode = TMR_ONE;
+	timer_expiry = virtual_time + nsec;
+#endif
 	return 0;
 }
 
@@ -93,12 +121,20 @@ void os_timer_disable(void)
 
 	memset(&its, 0, sizeof(struct itimerspec));
 	timer_settime(event_high_res_timer, 0, &its, NULL);
+#ifdef CONFIG_UML_VIRTUAL_TIME_SUPPORT
+	timer_mode = TMR_DIS;
+#endif
 }
 
 long long os_nsecs(void)
 {
 	struct timespec ts;
 
+#ifdef CONFIG_UML_VIRTUAL_TIME_SUPPORT
+	if (virtual_time_enabled)
+		return virtual_time;
+#endif
+
 	clock_gettime(CLOCK_MONOTONIC,&ts);
 	return timespec_to_ns(&ts);
 }
@@ -109,6 +145,10 @@ long long os_nsecs(void)
  */
 void os_idle_sleep(unsigned long long nsecs)
 {
+#ifdef CONFIG_UML_VIRTUAL_TIME_SUPPORT
+	unsigned long long next = virtual_time + nsecs;
+	struct itimerspec stop = {}, cfg;
+#endif
 	struct timespec ts = {
 		.tv_sec  = nsecs / UM_NSEC_PER_SEC,
 		.tv_nsec = nsecs % UM_NSEC_PER_SEC
@@ -117,6 +157,32 @@ void os_idle_sleep(unsigned long long nsecs)
 	/*
 	 * Relay the signal if clock_nanosleep is interrupted.
 	 */
-	if (clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL))
+	if (!virtual_time_enabled) {
+		if (clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL))
+			deliver_alarm();
+		return;
+	}
+
+#ifdef CONFIG_UML_VIRTUAL_TIME_SUPPORT
+	timer_settime(event_high_res_timer, 0, &stop, &cfg);
+
+	if (timer_mode != TMR_DIS && timer_expiry < next) {
+		if (timer_mode == TMR_ONE)
+			timer_mode = TMR_DIS;
+		/* virtual_time will be adjusted in timer_handler() */
 		deliver_alarm();
+		return;
+	}
+
+	virtual_time = next;
+
+	if (timer_mode != TMR_DIS) {
+		unsigned long long remaining = timer_expiry - virtual_time;
+
+		cfg.it_value.tv_sec = remaining / UM_NSEC_PER_SEC;
+		cfg.it_value.tv_nsec = remaining % UM_NSEC_PER_SEC;
+
+		timer_settime(event_high_res_timer, 0, &cfg, NULL);
+	}
+#endif
 }
-- 
2.17.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

