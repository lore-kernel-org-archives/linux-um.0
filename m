Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jDqwc-0003yW-Qk
 for linux-um@lists.infradead.org; Mon, 16 Mar 2020 14:42:20 +0000
Received: by mail-pj1-x1043.google.com with SMTP id mq3so8826152pjb.0
 for <linux-um@lists.infradead.org>; Mon, 16 Mar 2020 07:42:18 -0700 (PDT)
From: Dmitry Safonov <dima@arista.com>
Subject: [PATCHv2 35/50] um/sysrq: Remove needless variable sp
Date: Mon, 16 Mar 2020 14:39:01 +0000
Message-Id: <20200316143916.195608-36-dima@arista.com>
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Richard Weinberger <richard@nod.at>, Dmitry Safonov <dima@arista.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeff Dike <jdike@addtoit.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, linux-um@lists.infradead.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

`sp' is a needless excercise here.

Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/um/kernel/sysrq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index c71b5ef7ea8c..c831a1c2eb94 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -27,7 +27,6 @@ static const struct stacktrace_ops stackops = {
 
 void show_stack(struct task_struct *task, unsigned long *stack)
 {
-	unsigned long *sp = stack;
 	struct pt_regs *segv_regs = current->thread.segv_regs;
 	int i;
 
@@ -38,10 +37,9 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 	}
 
 	if (!stack)
-		sp = get_stack_pointer(task, segv_regs);
+		stack = get_stack_pointer(task, segv_regs);
 
 	pr_info("Stack:\n");
-	stack = sp;
 	for (i = 0; i < 3 * STACKSLOTS_PER_LINE; i++) {
 		if (kstack_end(stack))
 			break;
-- 
2.25.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

