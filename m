Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1364038742.1390.228.camel@x61.thuisdomein>
From: Paul Bolle <pebolle@tiscali.nl>
Date: Sat, 23 Mar 2013 12:39:02 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: remove "config STDIO_CONSOLE"
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

The only user of Kconfig symbol STDIO_CONSOLE was removed in v2.5.65.
Its entry can safely be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Untested.

1) A short history of STDIO_CONSOLE and CONFIG_STDIO_CONSOLE

CONFIG_STDIO_CONSOLE was added in v2.4.9 (August 2001). It wrapped a
call of stdio_console_init() in an #ifdef and #endif pair.

The Kconfig symbol STDIO_CONSOLE was added in v2.5.35 (September 2002).
That release also introduced a definition of stdio_console_init().

Both CONFIG_STDIO_CONSOLE and the call of stdio_console_init() that it
guarded were removed in v2.5.65 (March 2003). An instance of the
console_initcall() macro was then added for stdio_console_init.

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
1.7.11.7

