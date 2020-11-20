Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgDyH-0008EE-D1
 for linux-um@lists.infradead.org; Fri, 20 Nov 2020 21:29:35 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/4] um: add a pseudo RTC
Date: Fri, 20 Nov 2020 22:29:19 +0100
Message-Id: <20201120222625.6e15df564f9c.I9e5927602a6f5495d3dd574d89e3b138e978bcb4@changeid>
In-Reply-To: <20201120212921.880781-1-johannes@sipsolutions.net>
References: <20201120212921.880781-1-johannes@sipsolutions.net>
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

This isn't quite the right thing, and especially doesn't
actually cause wakeups due to CLOCK_REALTIME (if that
ends up changing due to the host), but it will let us
test suspend/resume.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/Kconfig               |  11 ++
 arch/um/drivers/Makefile              |   1 +
 arch/um/drivers/rtc.c                 | 147 ++++++++++++++++++++++++++
 arch/um/include/asm/irq.h             |   3 +-
 arch/um/include/linux/time-internal.h |  11 ++
 arch/um/kernel/time.c                 |   8 +-
 6 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100644 arch/um/drivers/rtc.c

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 9160ead56e33..8498bcf96bd1 100644
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
index 2a249f619467..2ac39961f56e 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
 obj-$(CONFIG_UML_RANDOM) += random.o
 obj-$(CONFIG_VIRTIO_UML) += virtio_uml.o
+obj-$(CONFIG_UML_RTC) += rtc.o
 
 # pcap_user.o must be added explicitly.
 USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o pcap_user.o vde_user.o vector_user.o
diff --git a/arch/um/drivers/rtc.c b/arch/um/drivers/rtc.c
new file mode 100644
index 000000000000..af3a7ea3abbd
--- /dev/null
+++ b/arch/um/drivers/rtc.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Intel Corporation
+ * Author: Johannes Berg <johannes.berg@intel.com>
+ */
+#include <linux/platform_device.h>
+#include <linux/time-internal.h>
+#include <linux/suspend.h>
+#include <linux/err.h>
+#include <linux/rtc.h>
+#include <kern_util.h>
+#include <irq_kern.h>
+#include <irq_user.h>
+
+static time64_t uml_rtc_alarm_time;
+static bool uml_rtc_alarm_enabled;
+static struct rtc_device *uml_rtc;
+static struct timer_list uml_rtc_timer;
+
+static void uml_rtc_alarm(void)
+{
+	pm_system_wakeup();
+	rtc_update_irq(uml_rtc, 1, RTC_IRQF | RTC_AF);
+}
+
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+static void uml_rtc_time_travel_alarm(struct time_travel_event *ev)
+{
+	uml_rtc_alarm();
+}
+
+static struct time_travel_event uml_rtc_alarm_event = {
+	.fn = uml_rtc_time_travel_alarm,
+};
+#endif
+
+static int uml_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	rtc_time64_to_tm(ktime_get_real_seconds(), tm);
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
+	secs = enable ? uml_rtc_alarm_time - ktime_get_real_seconds() : 0;
+
+	if (time_travel_mode == TT_MODE_OFF) {
+		del_timer(&uml_rtc_timer);
+
+		if (enable)
+			mod_timer(&uml_rtc_timer, jiffies + secs * HZ);
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
+
+static void uml_rtc_timer_fn(struct timer_list *unused)
+{
+	uml_rtc_alarm();
+}
+
+static int uml_rtc_probe(struct platform_device *plat_dev)
+{
+	if (time_travel_mode == TT_MODE_OFF)
+		timer_setup(&uml_rtc_timer, uml_rtc_timer_fn, 0);
+
+	uml_rtc = devm_rtc_allocate_device(&plat_dev->dev);
+	if (IS_ERR(uml_rtc))
+		return PTR_ERR(uml_rtc);
+
+	uml_rtc->ops = &uml_rtc_ops;
+	device_init_wakeup(&plat_dev->dev, 1);
+
+	return rtc_register_device(uml_rtc);
+}
+
+static struct platform_driver uml_rtc_driver = {
+	.probe	= uml_rtc_probe,
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
diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
index 42c6205e2dc4..484cc4fec65f 100644
--- a/arch/um/include/asm/irq.h
+++ b/arch/um/include/asm/irq.h
@@ -18,10 +18,11 @@
 #define XTERM_IRQ 		13
 #define RANDOM_IRQ 		14
 #define VIRTIO_IRQ		15
+#define RTC_IRQ			16
 
 #ifdef CONFIG_UML_NET_VECTOR
 
-#define VECTOR_BASE_IRQ		(VIRTIO_IRQ + 1)
+#define VECTOR_BASE_IRQ		(RTC_IRQ + 1)
 #define VECTOR_IRQ_SPACE	8
 
 #define LAST_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ - 1)
diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index deb7f1d209eb..5a1f72091c12 100644
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
index b69130c77827..d51ce41ef91c 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -299,6 +299,12 @@ static void time_travel_add_event(struct time_travel_event *e,
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
@@ -325,7 +331,7 @@ static void time_travel_deliver_event(struct time_travel_event *e)
 	}
 }
 
-static bool time_travel_del_event(struct time_travel_event *e)
+bool time_travel_del_event(struct time_travel_event *e)
 {
 	if (!e->pending)
 		return false;
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

