Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Thu, 21 Nov 2013 09:31:55 +0100
Message-Id: <1385022715-21398-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: Rename print_stack_trace to do_stack_trace
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, rdunlap@infradead.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

We cannot use print_stack_trace because the name conflicts
with linux/stacktrace.h.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/sysrq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 4d6fdf6..799d7e4 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -19,7 +19,7 @@ struct stack_frame {
 	unsigned long return_address;
 };
 
-static void print_stack_trace(unsigned long *sp, unsigned long bp)
+static void do_stack_trace(unsigned long *sp, unsigned long bp)
 {
 	int reliable;
 	unsigned long addr;
@@ -94,5 +94,5 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 	}
 	printk(KERN_CONT "\n");
 
-	print_stack_trace(sp, bp);
+	do_stack_trace(sp, bp);
 }
-- 
1.8.4.2

