Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH 2/2] um: Use relative modversions with LD_SCRIPT_DYN
Date: Sun, 20 Aug 2017 13:26:05 +0200
Message-Id: <20170820112605.19883-2-thomas@m3y3r.de>
In-Reply-To: <20170820112605.19883-1-thomas@m3y3r.de>
References: <20170820112605.19883-1-thomas@m3y3r.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Cc: Thomas Meyer <thomas@m3y3r.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

When building a dynamic kernel image use relative symbols with MODVERSIONS.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/Kconfig.um | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig.um b/arch/um/Kconfig.um
index 4b2ed5858b2e..e26376ab5452 100644
--- a/arch/um/Kconfig.um
+++ b/arch/um/Kconfig.um
@@ -20,6 +20,7 @@ config LD_SCRIPT_DYN
 	bool
 	default y
 	depends on !LD_SCRIPT_STATIC
+        select MODULE_REL_CRCS if MODVERSIONS
 
 source "fs/Kconfig.binfmt"
 
-- 
2.11.0


