Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <544277C5.9030302@gmx.at>
Date: Sat, 18 Oct 2014 16:23:01 +0200
From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: Remove unused bp stack-frame pointer
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Daniel Walter <dwalter@google.com>, Manfred Schlaegl <manfred.schlaegl@gmx.at>, Randy Dunlap <rdunlap@infradead.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

The pointer to bp stack-frame is no longer used. Removed it.
This also removes a corresponding compiler-warning.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>
---
 arch/um/kernel/sysrq.c |    6 +-----
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
 -- 1.7.10.4

