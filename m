Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Helge Deller <deller@gmx.de>
Subject: [PATCH 02/14] um: Use %pS printk format for symbols from direct addresses
Date: Wed,  6 Sep 2017 22:27:49 +0200
Message-Id: <1504729681-3504-3-git-send-email-deller@gmx.de>
In-Reply-To: <1504729681-3504-1-git-send-email-deller@gmx.de>
References: <1504729681-3504-1-git-send-email-deller@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Use the %pS printk format for printing symbols from direct addresses.
In usermode-linux there is actually no difference between %pS and %pF, but for
consistency throughout the kernel fix the wrong usage here too.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
 arch/um/kernel/sysrq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 6b995e8..05585ee 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -20,7 +20,7 @@
 
 static void _print_addr(void *data, unsigned long address, int reliable)
 {
-	pr_info(" [<%08lx>] %s%pF\n", address, reliable ? "" : "? ",
+	pr_info(" [<%08lx>] %s%pS\n", address, reliable ? "" : "? ",
 		(void *)address);
 }
 
-- 
2.1.0


