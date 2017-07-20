Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH] um: defconfig: Cleanup from old Kconfig options
Date: Thu, 20 Jul 2017 07:01:10 +0200
Message-Id: <1500526870-4233-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Remove old, dead Kconfig option INET_LRO. It is gone since
commit 7bbf3cae65b6 ("ipv4: Remove inet_lro library").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/um/configs/i386_defconfig   | 1 -
 arch/um/configs/x86_64_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
index 5636221b8785..8f114e3b0a7a 100644
--- a/arch/um/configs/i386_defconfig
+++ b/arch/um/configs/i386_defconfig
@@ -53,7 +53,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UML_NET=y
 CONFIG_UML_NET_ETHERTAP=y
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index 7a67b7ac1a7e..5d0875fc0db2 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -51,7 +51,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UML_NET=y
 CONFIG_UML_NET_ETHERTAP=y
-- 
2.7.4


