Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hEB32-0002e7-W9
 for linux-um@lists.infradead.org; Wed, 10 Apr 2019 11:05:47 +0000
Message-Id: <20190410103643.662853876@linutronix.de>
Date: Wed, 10 Apr 2019 12:27:55 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC patch 01/41] um/stacktrace: Remove the pointless ULONG_MAX marker
References: <20190410102754.387743324@linutronix.de>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, x86@kernel.org, linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>

Terminating the last trace entry with ULONG_MAX is a completely pointless
exercise and none of the consumers can rely on it because it's
inconsistently implemented across architectures. In fact quite some of the
callers remove the entry and adjust stack_trace.nr_entries afterwards.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org
---
 arch/um/kernel/stacktrace.c |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/um/kernel/stacktrace.c
+++ b/arch/um/kernel/stacktrace.c
@@ -63,8 +63,6 @@ static const struct stacktrace_ops dump_
 static void __save_stack_trace(struct task_struct *tsk, struct stack_trace *trace)
 {
 	dump_trace(tsk, &dump_ops, trace);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 
 void save_stack_trace(struct stack_trace *trace)



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

