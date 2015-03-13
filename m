Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alex Dowad <alexinbeijing@gmail.com>
Date: Fri, 13 Mar 2015 20:14:52 +0200
Message-Id: <1426270496-26362-19-git-send-email-alexinbeijing@gmail.com>
In-Reply-To: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
References: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 29/32] um: copy_thread(): rename 'arg' argument to 'kthread_arg'
To: linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

The 'arg' argument to copy_thread() is only ever used when forking a new
kernel thread. Hence, rename it to 'kthread_arg' for clarity (and consistency
with do_fork() and other arch-specific implementations of copy_thread()).

Signed-off-by: Alex Dowad <alexinbeijing@gmail.com>
---
 arch/um/kernel/process.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index f17bca8..80ac9fe 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -149,8 +149,11 @@ void fork_handler(void)
 	userspace(&current->thread.regs.regs);
 }
 
+/*
+ * Copy architecture-specific thread state
+ */
 int copy_thread(unsigned long clone_flags, unsigned long sp,
-		unsigned long arg, struct task_struct * p)
+		unsigned long kthread_arg, struct task_struct *p)
 {
 	void (*handler)(void);
 	int kthread = current->flags & PF_KTHREAD;
@@ -159,6 +162,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 	p->thread = (struct thread_struct) INIT_THREAD;
 
 	if (!kthread) {
+		/* user thread */
 	  	memcpy(&p->thread.regs.regs, current_pt_regs(),
 		       sizeof(p->thread.regs.regs));
 		PT_REGS_SET_SYSCALL_RETURN(&p->thread.regs, 0);
@@ -169,9 +173,10 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 
 		arch_copy_thread(&current->thread.arch, &p->thread.arch);
 	} else {
+		/* kernel thread */
 		get_safe_registers(p->thread.regs.regs.gp, p->thread.regs.regs.fp);
 		p->thread.request.u.thread.proc = (int (*)(void *))sp;
-		p->thread.request.u.thread.arg = (void *)arg;
+		p->thread.request.u.thread.arg = (void *)kthread_arg;
 		handler = new_thread_handler;
 	}
 
-- 
2.0.0.GIT

