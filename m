Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Thu, 26 Mar 2015 13:27:12 +0100
Message-Id: <1427372838-16605-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 1/7] um: Remove dead code from stacktrace
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Remove left over code from commit 970e51feaddb
(um: Add support for CONFIG_STACKTRACE)

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/sysrq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 894c8d3..aa1b56f 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -29,7 +29,7 @@ static const struct stacktrace_ops stackops = {
 
 void show_stack(struct task_struct *task, unsigned long *stack)
 {
-	unsigned long *sp = stack, bp = 0;
+	unsigned long *sp = stack;
 	struct pt_regs *segv_regs = current->thread.segv_regs;
 	int i;
 
@@ -39,10 +39,6 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 		return;
 	}
 
-#ifdef CONFIG_FRAME_POINTER
-	bp = get_frame_pointer(task, segv_regs);
-#endif
-
 	if (!stack)
 		sp = get_stack_pointer(task, segv_regs);
 
-- 
1.8.4.5

