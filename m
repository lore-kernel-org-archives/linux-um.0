Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knf9q-0002QM-Vx
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 09:56:16 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v9 2/2] um: add a pseudo RTC
Date: Fri, 11 Dec 2020 10:56:08 +0100
Message-Id: <20201211105608.079b54e441a8.I9e5927602a6f5495d3dd574d89e3b138e978bcb4@changeid>
In-Reply-To: <20201211105608.360ad4134981.I8977ac4a1a8c221ec8974574a4f9e2b7586dd943@changeid>
References: <20201211105608.360ad4134981.I8977ac4a1a8c221ec8974574a4f9e2b7586dd943@changeid>
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

Add a pseudo RTC that simply is able to send an alarm signal
waking up the system at a given time in the future.

Since apparently timerfd_create() FDs don't support SIGIO, we
use the sigio-creating helper thread, which just learned to do
suspend/resume properly in the previous patch.

For time-travel mode, OTOH, just add an event at the specified
time in the future, and that's already sufficient to wake up
the system at that point in time since suspend will just be in
an "endless wait".

For s2idle support also call pm_system_wakeup().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v8:
 * make sure the helper thread dies (by removing CLONE_FILES)

v9:
 * use sigio helper thread
---
 arch/um/drivers/Kconfig               |  11 ++
 arch/um/drivers/Makefile              |   2 +
 arch/um/drivers/rtc.h                 |  15 ++
 arch/um/drivers/rtc_kern.c            | 210 ++++++++++++++++++++++++++
 arch/um/drivers/rtc_user.c            |  80 ++++++++++
 arch/um/include/linux/time-internal.h |  11 ++
 arch/um/kernel/time.c                 |  10 +-
 7 files changed, 338 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/drivers/rtc.h
 create mode 100644 arch/um/drivers/rtc_kern.c
 create mode 100644 arch/um/drivers/rtc_user.c

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 2e7b8e0e7194..5509e627bbd4 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -346,3 +346,14 @@ config VIRTIO_UML
 	help
 	  This driver provides support for virtio based paravirtual device
 	  drivers over vhost-user sockets.
+
+config UML_RTC
+	bool "UML RTC driver"
+	depends on RTC_CLASS
+	# there's no use in this if PM_SLEEP isn't enabled ...
+	depends on PM_SLEEP
+	help
+	  When PM_SLEEP is configured, it may be desirable to wake up using
+	  rtcwake, especially in time-travel mode. This driver enables that
+	  by providing a fake RTC clock that causes a wakeup at the right
+	  time.
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 2a249f619467..dcc64a02f81f 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -17,6 +17,7 @@ hostaudio-objs := hostaudio_kern.o
 ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
+rtc-objs := rtc_kern.o rtc_user.o
 
 LDFLAGS_pcap.o = $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
 
@@ -62,6 +63,7 @@ obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
 obj-$(CONFIG_UML_RANDOM) += random.o
 obj-$(CONFIG_VIRTIO_UML) += virtio_uml.o
+obj-$(CONFIG_UML_RTC) += rtc.o
 
 # pcap_user.o must be added explicitly.
 USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o pcap_user.o vde_user.o vector_user.o
diff --git a/arch/um/drivers/rtc.h b/arch/um/drivers/rtc.h
new file mode 100644
index 000000000000..95e41c7d35c4
--- /dev/null
+++ b/arch/um/drivers/rtc.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Intel Corporation
+ * Author: Johannes Berg <johannes@sipsolutions.net>
+ */
+#ifndef __UM_RTC_H__
+#define __UM_RTC_H__
+
+int uml_rtc_start(bool timetravel);
+int uml_rtc_enable_alarm(unsigned long long delta_seconds);
+void uml_rtc_disable_alarm(void);
+void uml_rtc_stop(bool timetravel);
+void uml_rtc_send_timetravel_alarm(void);
+
+#endif /* __UM_RTC_H__ */
diff --git a/arch/um/drivers/rtc_kern.c b/arch/um/drivers/rtc_kern.c
new file mode 100644
index 000000000000..3a84ef182eff
--- /dev/null
+++ b/arch/um/drivers/rtc_kern.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Intel Corporation
+ * Author: Johannes Berg <johannes@sipsolutions.net>
+ */
+#include <linux/platform_device.h>
+#include <linux/time-internal.h>
+#include <linux/suspend.h>
+#include <linux/err.h>
+#include <linux/rtc.h>
+#include <kern_util.h>
+#include <irq_kern.h>
+#include <os.h>
+#include "rtc.h"
+
+static time64_t uml_rtc_alarm_time;
+static bool uml_rtc_alarm_enabled;
+static struct rtc_device *uml_rtc;
+static int uml_rtc_irq_fd, uml_rtc_irq;
+
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+
+static void uml_rtc_time_travel_alarm(struct time_travel_event *ev)
+{
+	uml_rtc_send_timetravel_alarm();
+}
+
+static struct time_travel_event uml_rtc_alarm_event = {
+	.fn = uml_rtc_time_travel_alarm,
+};
+#endif
+
+static int uml_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct timespec64 ts;
+
+	/* Use this to get correct time in time-travel mode */
+	read_persistent_clock64(&ts);
+	rtc_time64_to_tm(timespec64_to_ktime(ts) / NSEC_PER_SEC, tm);
+
+	return 0;
+}
+
+static int uml_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	rtc_time64_to_tm(uml_rtc_alarm_time, &alrm->time);
+	alrm->enabled = uml_rtc_alarm_enabled;
+
+	return 0;
+}
+
+static int uml_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
+{
+	unsigned long long secs;
+
+	if (!enable && !uml_rtc_alarm_enabled)
+		return 0;
+
+	uml_rtc_alarm_enabled = enable;
+
+	secs = uml_rtc_alarm_time - ktime_get_real_seconds();
+
+	if (time_travel_mode == TT_MODE_OFF) {
+		if (!enable) {
+			uml_rtc_disable_alarm();
+			return 0;
+		}
+
+		/* enable or update */
+		return uml_rtc_enable_alarm(secs);
+	} else {
+		time_travel_del_event(&uml_rtc_alarm_event);
+
+		if (enable)
+			time_travel_add_event_rel(&uml_rtc_alarm_event,
+						  secs * NSEC_PER_SEC);
+	}
+
+	return 0;
+}
+
+static int uml_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	uml_rtc_alarm_irq_enable(dev, 0);
+	uml_rtc_alarm_time = rtc_tm_to_time64(&alrm->time);
+	uml_rtc_alarm_irq_enable(dev, alrm->enabled);
+
+	return 0;
+}
+
+static const struct rtc_class_ops uml_rtc_ops = {
+	.read_time = uml_rtc_read_time,
+	.read_alarm = uml_rtc_read_alarm,
+	.alarm_irq_enable = uml_rtc_alarm_irq_enable,
+	.set_alarm = uml_rtc_set_alarm,
+};
+
+static irqreturn_t uml_rtc_interrupt(int irq, void *data)
+{
+	unsigned long long c = 0;
+
+	/* alarm triggered, it's now off */
+	uml_rtc_alarm_enabled = false;
+
+	os_read_file(uml_rtc_irq_fd, &c, sizeof(c));
+	WARN_ON(c == 0);
+
+	pm_system_wakeup();
+	rtc_update_irq(uml_rtc, 1, RTC_IRQF | RTC_AF);
+
+	return IRQ_HANDLED;
+}
+
+static int uml_rtc_setup(void)
+{
+	int err;
+
+	err = uml_rtc_start(time_travel_mode != TT_MODE_OFF);
+	if (WARN(err < 0, "err = %d\n", err))
+		return err;
+
+	uml_rtc_irq_fd = err;
+
+	err = um_request_irq(UM_IRQ_ALLOC, uml_rtc_irq_fd, IRQ_READ,
+			     uml_rtc_interrupt, 0, "rtc", NULL);
+	if (err < 0) {
+		uml_rtc_stop(time_travel_mode != TT_MODE_OFF);
+		return err;
+	}
+
+	irq_set_irq_wake(err, 1);
+
+	uml_rtc_irq = err;
+	return 0;
+}
+
+static void uml_rtc_cleanup(void)
+{
+	um_free_irq(uml_rtc_irq, NULL);
+	uml_rtc_stop(time_travel_mode != TT_MODE_OFF);
+}
+
+static int uml_rtc_probe(struct platform_device *pdev)
+{
+	int err;
+
+	err = uml_rtc_setup();
+	if (err)
+		return err;
+
+	uml_rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(uml_rtc)) {
+		err = PTR_ERR(uml_rtc);
+		goto cleanup;
+	}
+
+	uml_rtc->ops = &uml_rtc_ops;
+
+	err = rtc_register_device(uml_rtc);
+	if (err)
+		goto cleanup;
+
+	device_init_wakeup(&pdev->dev, 1);
+	return 0;
+cleanup:
+	uml_rtc_cleanup();
+	return err;
+}
+
+static int uml_rtc_remove(struct platform_device *pdev)
+{
+	device_init_wakeup(&pdev->dev, 0);
+	uml_rtc_cleanup();
+	return 0;
+}
+
+static struct platform_driver uml_rtc_driver = {
+	.probe = uml_rtc_probe,
+	.remove = uml_rtc_remove,
+	.driver = {
+		.name = "uml-rtc",
+	},
+};
+
+static int __init uml_rtc_init(void)
+{
+	struct platform_device *pdev;
+	int err;
+
+	err = platform_driver_register(&uml_rtc_driver);
+	if (err)
+		return err;
+
+	pdev = platform_device_alloc("uml-rtc", 0);
+	if (!pdev) {
+		err = -ENOMEM;
+		goto unregister;
+	}
+
+	err = platform_device_add(pdev);
+	if (err)
+		goto unregister;
+	return 0;
+
+unregister:
+	platform_device_put(pdev);
+	platform_driver_unregister(&uml_rtc_driver);
+	return err;
+}
+device_initcall(uml_rtc_init);
diff --git a/arch/um/drivers/rtc_user.c b/arch/um/drivers/rtc_user.c
new file mode 100644
index 000000000000..4016bc1d577e
--- /dev/null
+++ b/arch/um/drivers/rtc_user.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Intel Corporation
+ * Author: Johannes Berg <johannes@sipsolutions.net>
+ */
+#include <os.h>
+#include <errno.h>
+#include <sched.h>
+#include <unistd.h>
+#include <kern_util.h>
+#include <sys/select.h>
+#include <stdio.h>
+#include <sys/timerfd.h>
+#include "rtc.h"
+
+static int uml_rtc_irq_fds[2];
+
+void uml_rtc_send_timetravel_alarm(void)
+{
+	unsigned long long c = 1;
+
+	CATCH_EINTR(write(uml_rtc_irq_fds[1], &c, sizeof(c)));
+}
+
+int uml_rtc_start(bool timetravel)
+{
+	int err;
+
+	if (timetravel) {
+		int err = os_pipe(uml_rtc_irq_fds, 1, 1);
+		if (err)
+			goto fail;
+	} else {
+		uml_rtc_irq_fds[0] = timerfd_create(CLOCK_REALTIME, TFD_CLOEXEC);
+		if (uml_rtc_irq_fds[0] < 0) {
+			err = -errno;
+			goto fail;
+		}
+
+		/* apparently timerfd won't send SIGIO, use workaround */
+		sigio_broken(uml_rtc_irq_fds[0]);
+		err = add_sigio_fd(uml_rtc_irq_fds[0]);
+		if (err < 0) {
+			close(uml_rtc_irq_fds[0]);
+			goto fail;
+		}
+	}
+
+	return uml_rtc_irq_fds[0];
+fail:
+	uml_rtc_stop(timetravel);
+	return err;
+}
+
+int uml_rtc_enable_alarm(unsigned long long delta_seconds)
+{
+	struct itimerspec it = {
+		.it_value = {
+			.tv_sec = delta_seconds,
+		},
+	};
+
+	if (timerfd_settime(uml_rtc_irq_fds[0], 0, &it, NULL))
+		return -errno;
+	return 0;
+}
+
+void uml_rtc_disable_alarm(void)
+{
+	uml_rtc_enable_alarm(0);
+}
+
+void uml_rtc_stop(bool timetravel)
+{
+	if (timetravel)
+		os_close_file(uml_rtc_irq_fds[1]);
+	else
+		ignore_sigio_fd(uml_rtc_irq_fds[0]);
+	os_close_file(uml_rtc_irq_fds[0]);
+}
diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index 68e45e950137..088d6a4c0b9d 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -54,6 +54,9 @@ static inline void time_travel_wait_readable(int fd)
 }
 
 void time_travel_add_irq_event(struct time_travel_event *e);
+void time_travel_add_event_rel(struct time_travel_event *e,
+			       unsigned long long delay_ns);
+bool time_travel_del_event(struct time_travel_event *e);
 #else
 struct time_travel_event {
 };
@@ -74,6 +77,14 @@ static inline void time_travel_propagate_time(void)
 static inline void time_travel_wait_readable(int fd)
 {
 }
+
+/*
+ * not inlines so the data structure need not exist,
+ * cause linker failures
+ */
+extern void time_travel_not_configured(void);
+#define time_travel_add_event_rel(...) time_travel_not_configured()
+#define time_travel_del_event(...) time_travel_not_configured()
 #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 
 /*
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index aa926c7b9003..4acc1eced732 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -311,6 +311,12 @@ static void time_travel_add_event(struct time_travel_event *e,
 	__time_travel_add_event(e, time);
 }
 
+void time_travel_add_event_rel(struct time_travel_event *e,
+			       unsigned long long delay_ns)
+{
+	time_travel_add_event(e, time_travel_time + delay_ns);
+}
+
 void time_travel_periodic_timer(struct time_travel_event *e)
 {
 	time_travel_add_event(&time_travel_timer_event,
@@ -337,7 +343,7 @@ static void time_travel_deliver_event(struct time_travel_event *e)
 	}
 }
 
-static bool time_travel_del_event(struct time_travel_event *e)
+bool time_travel_del_event(struct time_travel_event *e)
 {
 	if (!e->pending)
 		return false;
@@ -514,6 +520,8 @@ extern u64 time_travel_ext_req(u32 op, u64 time);
 
 /* these are empty macros so the struct/fn need not exist */
 #define time_travel_add_event(e, time) do { } while (0)
+/* externally not usable - redefine here so we can */
+#undef time_travel_del_event
 #define time_travel_del_event(e) do { } while (0)
 #endif
 
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

