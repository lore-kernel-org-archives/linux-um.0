Return-Path: <devicetree-owner@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Date: Mon,  6 Oct 2014 22:28:34 -0700
Message-Id: <1412659726-29957-33-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
Sender: devicetree-owner@vger.kernel.org
Subject: [PATCH 32/44] arm64: psci: Register with kernel poweroff handler
To: linux-kernel@vger.kernel.org
Cc: adi-buildroot-devel@lists.sourceforge.net, devel@driverdev.osuosl.org, devicetree@vger.kernel.org, lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, linux-am33-list@redhat.com, linux-cris-kernel@axis.com, linux-efi@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org, openipmi-developer@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org, Guenter Roeck <linux@roeck-us.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Register with kernel poweroff handler instead of setting pm_power_off
directly.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm64/kernel/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 5539547..c1f3d09 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -286,7 +286,7 @@ static int __init psci_0_2_init(struct device_node *np)
 
 	arm_pm_restart = psci_sys_reset;
 
-	pm_power_off = psci_sys_poweroff;
+	register_poweroff_handler_simple(psci_sys_poweroff, 128);
 
 out_put_node:
 	of_node_put(np);
-- 
1.9.1

