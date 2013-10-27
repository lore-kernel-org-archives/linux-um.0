Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Date: Sun, 27 Oct 2013 08:06:10 +0100
Message-Id: <1382857570-3412-1-git-send-email-michael.opdenacker@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: remove used STDIO_CONSOLE Kconfig param
To: jdike@addtoit.com, richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, Michael Opdenacker <michael.opdenacker@free-electrons.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This removes the STDIO_CONSOLE Kconfig parameter which
is defined but no longer used anywhere in the makefiles and source code.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/um/Kconfig.char | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/um/Kconfig.char b/arch/um/Kconfig.char
index b9d7c42..f10738d 100644
--- a/arch/um/Kconfig.char
+++ b/arch/um/Kconfig.char
@@ -6,10 +6,6 @@ config STDERR_CONSOLE
 	help
 	  console driver which dumps all printk messages to stderr.
 
-config STDIO_CONSOLE
-	bool
-	default y
-
 config SSL
 	bool "Virtual serial line"
 	help
-- 
1.8.1.2

