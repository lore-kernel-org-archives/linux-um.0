Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] um: Fix _print_addr()
Date: Sun, 25 Dec 2016 23:11:05 +0100
Message-Id: <20161225221105.30112-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Recent changes to printk() broke UML's stack trace
output. Kill the root of the problem by using a single
printk() statement.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/sysrq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index aa1b56f5ac68..18eddf677ec6 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -17,10 +17,8 @@
 
 static void _print_addr(void *data, unsigned long address, int reliable)
 {
-	pr_info(" [<%08lx>]", address);
-	pr_cont(" %s", reliable ? "" : "? ");
-	print_symbol("%s", address);
-	pr_cont("\n");
+	pr_info(" [<%08lx>] %s%pF\n", address, reliable ? "" : "? ",
+		(void *)address);
 }
 
 static const struct stacktrace_ops stackops = {
-- 
2.10.2


