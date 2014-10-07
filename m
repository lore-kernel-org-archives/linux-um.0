Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Date: Mon,  6 Oct 2014 22:28:26 -0700
Message-Id: <1412659726-29957-25-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 24/44] power/reset: msm-powroff: Register with kernel poweroff handler
To: linux-kernel@vger.kernel.org
Cc: adi-buildroot-devel@lists.sourceforge.net, devel@driverdev.osuosl.org, devicetree@vger.kernel.org, lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, linux-am33-list@redhat.com, linux-cris-kernel@axis.com, linux-efi@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org, openipmi-developer@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Register with kernel poweroff handler instead of setting pm_power_off
directly. Select proprity 0 since the code does not really poweroff
the system.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/power/reset/msm-poweroff.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
index 774f9a3..189bcd3 100644
--- a/drivers/power/reset/msm-poweroff.c
+++ b/drivers/power/reset/msm-poweroff.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/reboot.h>
 
 #include <asm/system_misc.h>
@@ -31,12 +32,19 @@ static void do_msm_restart(enum reboot_mode reboot_mode, const char *cmd)
 	mdelay(10000);
 }
 
-static void do_msm_poweroff(void)
+static int do_msm_poweroff(struct notifier_block *this,
+			   unsigned long unused1, void *unused2)
 {
 	/* TODO: Add poweroff capability */
 	do_msm_restart(REBOOT_HARD, NULL);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block msm_powroff_nb = {
+	.notifier_call = do_msm_poweroff,
+};
+
 static int msm_restart_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -47,7 +55,8 @@ static int msm_restart_probe(struct platform_device *pdev)
 	if (IS_ERR(msm_ps_hold))
 		return PTR_ERR(msm_ps_hold);
 
-	pm_power_off = do_msm_poweroff;
+	if (register_poweroff_handler(&msm_powroff_nb))
+		dev_err(&pdev->dev, "Failed to register poweroff handler\n");
 	arm_pm_restart = do_msm_restart;
 	return 0;
 }
-- 
1.9.1

