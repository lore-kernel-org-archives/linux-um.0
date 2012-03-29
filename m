Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Thu, 29 Mar 2012 19:18:50 +0200
Message-Id: <1333041530-2998-2-git-send-email-richard@nod.at>
In-Reply-To: <1333041530-2998-1-git-send-email-richard@nod.at>
References: <1333041530-2998-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 2/2] um: Use asm-generic/switch_to.h
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, toralf.foerster@gmx.de, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/Kbuild  |    1 +
 arch/um/kernel/process.c    |    6 +-----
 arch/x86/um/asm/switch_to.h |    7 -------
 3 files changed, 2 insertions(+), 12 deletions(-)
 delete mode 100644 arch/x86/um/asm/switch_to.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index bb5d6e6..fff2435 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -1,3 +1,4 @@
 generic-y += bug.h cputime.h device.h emergency-restart.h futex.h hardirq.h
 generic-y += hw_irq.h irq_regs.h kdebug.h percpu.h sections.h topology.h xor.h
 generic-y += ftrace.h pci.h io.h param.h delay.h mutex.h current.h exec.h
+generic-y += switch_to.h
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index f386d04..2b73ded 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -88,11 +88,8 @@ static inline void set_current(struct task_struct *task)
 
 extern void arch_switch_to(struct task_struct *to);
 
-void *_switch_to(void *prev, void *next, void *last)
+void *__switch_to(struct task_struct *from, struct task_struct *to)
 {
-	struct task_struct *from = prev;
-	struct task_struct *to = next;
-
 	to->thread.prev_sched = from;
 	set_current(to);
 
@@ -111,7 +108,6 @@ void *_switch_to(void *prev, void *next, void *last)
 	} while (current->thread.saved_task);
 
 	return current->thread.prev_sched;
-
 }
 
 void interrupt_end(void)
diff --git a/arch/x86/um/asm/switch_to.h b/arch/x86/um/asm/switch_to.h
deleted file mode 100644
index cf97d20..0000000
--- a/arch/x86/um/asm/switch_to.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef _ASM_UM_SWITCH_TO_H_
-#define _ASM_UM_SWITCH_TO_H_
-
-extern void *_switch_to(void *prev, void *next, void *last);
-#define switch_to(prev, next, last) prev = _switch_to(prev, next, last)
-
-#endif
-- 
1.7.7.3

