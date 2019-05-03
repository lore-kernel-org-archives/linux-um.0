Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hMfnk-0007CO-E4
 for linux-um@lists.infradead.org; Fri, 03 May 2019 21:33:06 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 3/3] arch: um: support virtual time
Date: Fri,  3 May 2019 23:32:49 +0200
Message-Id: <20190503213249.30008-3-johannes@sipsolutions.net>
In-Reply-To: <20190503213249.30008-1-johannes@sipsolutions.net>
References: <20190503213249.30008-1-johannes@sipsolutions.net>
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
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Johannes Berg <johannes.berg@intel.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Johannes Berg <johannes.berg@intel.com>

Sometimes it can be useful to run with virtual time inside the
UML instance, for example for testing. For example, some tests
for the wireless subsystem and userspace are based on hwsim, a
virtual wireless adapter. Some tests can take a long time to
run because they e.g. wait for 120 seconds to elapse for some
regulatory checks. This obviously goes faster if it need not
actually wait that long, but time inside the test environment
just "bumps up" when there's nothing to do.

Add a mode - CONFIG_UML_VIRTUAL_TIME - to support such behavior.

With this enabled, the test mentioned above goes from a runtime
of about 130 seconds (with startup overhead and all) to being
CPU bound and finishing in 16 seconds (on my slow laptop).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig         | 17 +++++++++++++++++
 arch/um/kernel/time.c   |  7 +++++++
 arch/um/os-Linux/time.c | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index ec9711d068b7..181ffddc03fc 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -180,6 +180,23 @@ config SECCOMP
 
 	  If unsure, say Y.
 
+config UML_VIRTUAL_TIME
+	bool
+	prompt "Use virtual time (e.g. for test execution)"
+	help
+	  Use this option to use virtual time inside the UML instance,
+	  which means that whenever there's nothing to do it just skips
+	  time forward rather than waiting for any real time to elapse.
+
+	  Note that this changes behaviour a bit - used CPU time doesn't
+	  cause the virtual time to increase.
+
+	  When in doubt, say N.
+
+	  In particular, do NOT set this option if you plan on using the
+	  system interactively as that will just cause it to busy-loop
+	  while waiting for you to enter input.
+
 endmenu
 
 source "arch/um/drivers/Kconfig"
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 3e31d7ba84c6..d27e6cf43904 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -134,3 +134,10 @@ void __init time_init(void)
 	timer_set_signal_handler();
 	late_time_init = um_timer_setup;
 }
+
+#ifdef CONFIG_UML_VIRTUAL_TIME
+unsigned long calibrate_delay_is_known(void)
+{
+	return 1;
+}
+#endif
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 6a60e7506f8d..8d5c0260c627 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -15,8 +15,15 @@
 #include <os.h>
 #include <string.h>
 #include <timer-internal.h>
+#include <generated/autoconf.h>
 
+#ifdef CONFIG_UML_VIRTUAL_TIME
+static unsigned long long virtual_time;
+static unsigned long long timer_expiry;
+static bool timer_enabled;
+#else
 static timer_t event_high_res_timer = 0;
+#endif
 
 static inline long long timeval_to_ns(const struct timeval *tv)
 {
@@ -42,16 +49,19 @@ long long os_persistent_clock_emulation(void)
  */
 int os_timer_create(void)
 {
+#ifndef CONFIG_UML_VIRTUAL_TIME
 	timer_t *t = &event_high_res_timer;
 
 	if (timer_create(CLOCK_MONOTONIC, NULL, t) == -1)
 		return -1;
+#endif
 
 	return 0;
 }
 
 int os_timer_set_interval(void)
 {
+#ifndef CONFIG_UML_VIRTUAL_TIME
 	struct itimerspec its;
 	unsigned long long nsec;
 
@@ -65,12 +75,17 @@ int os_timer_set_interval(void)
 
 	if (timer_settime(event_high_res_timer, 0, &its, NULL) == -1)
 		return -errno;
+#else
+	timer_enabled = true;
+	timer_expiry = virtual_time + UM_NSEC_PER_SEC / UM_HZ;
+#endif
 
 	return 0;
 }
 
 int os_timer_one_shot(unsigned long ticks)
 {
+#ifndef CONFIG_UML_VIRTUAL_TIME
 	struct itimerspec its;
 	unsigned long long nsec;
 	unsigned long sec;
@@ -86,6 +101,11 @@ int os_timer_one_shot(unsigned long ticks)
 	its.it_interval.tv_nsec = 0; // we cheat here
 
 	timer_settime(event_high_res_timer, 0, &its, NULL);
+#else
+	timer_enabled = true;
+	timer_expiry = virtual_time + ticks + 1;
+#endif
+
 	return 0;
 }
 
@@ -94,18 +114,26 @@ int os_timer_one_shot(unsigned long ticks)
  */
 void os_timer_disable(void)
 {
+#ifndef CONFIG_UML_VIRTUAL_TIME
 	struct itimerspec its;
 
 	memset(&its, 0, sizeof(struct itimerspec));
 	timer_settime(event_high_res_timer, 0, &its, NULL);
+#else
+	timer_enabled = false;
+#endif
 }
 
 long long os_nsecs(void)
 {
+#ifndef CONFIG_UML_VIRTUAL_TIME
 	struct timespec ts;
 
 	clock_gettime(CLOCK_MONOTONIC,&ts);
 	return timespec_to_ns(&ts);
+#else
+	return virtual_time;
+#endif
 }
 
 /**
@@ -114,6 +142,7 @@ long long os_nsecs(void)
  */
 void os_idle_sleep(unsigned long long nsecs)
 {
+#ifndef CONFIG_UML_VIRTUAL_TIME
 	struct timespec ts;
 
 	ts = ((struct timespec) {
@@ -126,4 +155,16 @@ void os_idle_sleep(unsigned long long nsecs)
 	 */
 	if (clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL))
 		deliver_alarm();
+#else
+	unsigned long long next = virtual_time + nsecs;
+
+	if (timer_enabled && timer_expiry <= next) {
+		virtual_time = timer_expiry;
+		timer_enabled = false;
+		deliver_alarm();
+		return;
+	}
+
+	virtual_time = next;
+#endif
 }
-- 
2.17.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

