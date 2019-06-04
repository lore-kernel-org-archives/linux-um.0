Return-Path: <krzk@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] um: configs: Remove useless UEVENT_HELPER_PATH
Date: Tue,  4 Jun 2019 09:59:53 +0200
Message-Id: <1559635193-21151-1-git-send-email-krzk@kernel.org>
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
List-ID: <linux-um.lists.infradead.org>

Remove the CONFIG_UEVENT_HELPER_PATH because:
1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
   CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
   made default to 'n',
2. It is not recommended (help message: "This should not be used today
   [...] creates a high system load") and was kept only for ancient
   userland,
3. Certain userland specifically requests it to be disabled (systemd
   README: "Legacy hotplug slows down the system and confuses udev").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/um/configs/i386_defconfig   | 1 -
 arch/um/configs/x86_64_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
index 8f114e3b0a7a..73e98bb57bf5 100644
--- a/arch/um/configs/i386_defconfig
+++ b/arch/um/configs/i386_defconfig
@@ -36,7 +36,6 @@ CONFIG_XTERM_CHAN=y
 CONFIG_CON_CHAN="pts"
 CONFIG_SSL_CHAN="pts"
 CONFIG_UML_SOUND=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_UBD=y
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index 5d0875fc0db2..3281d7600225 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -34,7 +34,6 @@ CONFIG_XTERM_CHAN=y
 CONFIG_CON_CHAN="pts"
 CONFIG_SSL_CHAN="pts"
 CONFIG_UML_SOUND=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_UBD=y
-- 
2.7.4


