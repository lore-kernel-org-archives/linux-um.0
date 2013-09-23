Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 23 Sep 2013 17:38:04 +0200
Message-Id: <1379950684-18710-4-git-send-email-richard@nod.at>
In-Reply-To: <1379950684-18710-1-git-send-email-richard@nod.at>
References: <1379950684-18710-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 4/4] um: Make kstack_depth_to_print conform to arch/x86
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/sysrq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 7122bf9..4d6fdf6 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -46,9 +46,6 @@ static void print_stack_trace(unsigned long *sp, unsigned long bp)
 	printk(KERN_INFO "\n");
 }
 
-/*Stolen from arch/i386/kernel/traps.c */
-static const int kstack_depth_to_print = 24;
-
 static unsigned long get_frame_pointer(struct task_struct *task,
 				       struct pt_regs *segv_regs)
 {
@@ -88,7 +85,7 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 
 	printk(KERN_INFO "Stack:\n");
 	stack = sp;
-	for (i = 0; i < kstack_depth_to_print; i++) {
+	for (i = 0; i < 3 * STACKSLOTS_PER_LINE; i++) {
 		if (kstack_end(stack))
 			break;
 		if (i && ((i % STACKSLOTS_PER_LINE) == 0))
-- 
1.8.3.1

