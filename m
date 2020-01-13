Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ir7fm-0008P3-Pi
 for linux-um@lists.infradead.org; Mon, 13 Jan 2020 21:55:00 +0000
Subject: Patch "um: Implement copy_thread_tls" has been added to the
 5.4-stable tree
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jan 2020 22:53:40 +0100
Message-ID: <1578952420143118@kroah.com>
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
To: 20200104123928.1048822-1-amanieu@gmail.com, amanieu@gmail.com, christian.brauner@ubuntu.com, gregkh@linuxfoundation.org, linux-um@lists.infradead.org
Cc: stable-commits@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    um: Implement copy_thread_tls

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     um-implement-copy_thread_tls.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 457677c70c7672a4586b0b8abc396cc1ecdd376d Mon Sep 17 00:00:00 2001
From: Amanieu d'Antras <amanieu@gmail.com>
Date: Sat, 4 Jan 2020 13:39:30 +0100
Subject: um: Implement copy_thread_tls

From: Amanieu d'Antras <amanieu@gmail.com>

commit 457677c70c7672a4586b0b8abc396cc1ecdd376d upstream.

This is required for clone3 which passes the TLS value through a
struct rather than a register.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Cc: linux-um@lists.infradead.org
Cc: <stable@vger.kernel.org> # 5.3.x
Link: https://lore.kernel.org/r/20200104123928.1048822-1-amanieu@gmail.com
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/um/Kconfig                      |    1 +
 arch/um/include/asm/ptrace-generic.h |    2 +-
 arch/um/kernel/process.c             |    6 +++---
 arch/x86/um/tls_32.c                 |    6 ++----
 arch/x86/um/tls_64.c                 |    7 +++----
 5 files changed, 10 insertions(+), 12 deletions(-)

--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -14,6 +14,7 @@ config UML
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_BUGVERBOSE
+	select HAVE_COPY_THREAD_TLS
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -36,7 +36,7 @@ extern long subarch_ptrace(struct task_s
 extern unsigned long getreg(struct task_struct *child, int regno);
 extern int putreg(struct task_struct *child, int regno, unsigned long value);
 
-extern int arch_copy_tls(struct task_struct *new);
+extern int arch_set_tls(struct task_struct *new, unsigned long tls);
 extern void clear_flushed_tls(struct task_struct *task);
 extern int syscall_trace_enter(struct pt_regs *regs);
 extern void syscall_trace_leave(struct pt_regs *regs);
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -153,8 +153,8 @@ void fork_handler(void)
 	userspace(&current->thread.regs.regs, current_thread_info()->aux_fp_regs);
 }
 
-int copy_thread(unsigned long clone_flags, unsigned long sp,
-		unsigned long arg, struct task_struct * p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
+		unsigned long arg, struct task_struct * p, unsigned long tls)
 {
 	void (*handler)(void);
 	int kthread = current->flags & PF_KTHREAD;
@@ -188,7 +188,7 @@ int copy_thread(unsigned long clone_flag
 		 * Set a new TLS for the child thread?
 		 */
 		if (clone_flags & CLONE_SETTLS)
-			ret = arch_copy_tls(p);
+			ret = arch_set_tls(p, tls);
 	}
 
 	return ret;
--- a/arch/x86/um/tls_32.c
+++ b/arch/x86/um/tls_32.c
@@ -215,14 +215,12 @@ static int set_tls_entry(struct task_str
 	return 0;
 }
 
-int arch_copy_tls(struct task_struct *new)
+int arch_set_tls(struct task_struct *new, unsigned long tls)
 {
 	struct user_desc info;
 	int idx, ret = -EFAULT;
 
-	if (copy_from_user(&info,
-			   (void __user *) UPT_SI(&new->thread.regs.regs),
-			   sizeof(info)))
+	if (copy_from_user(&info, (void __user *) tls, sizeof(info)))
 		goto out;
 
 	ret = -EINVAL;
--- a/arch/x86/um/tls_64.c
+++ b/arch/x86/um/tls_64.c
@@ -6,14 +6,13 @@ void clear_flushed_tls(struct task_struc
 {
 }
 
-int arch_copy_tls(struct task_struct *t)
+int arch_set_tls(struct task_struct *t, unsigned long tls)
 {
 	/*
 	 * If CLONE_SETTLS is set, we need to save the thread id
-	 * (which is argument 5, child_tid, of clone) so it can be set
-	 * during context switches.
+	 * so it can be set during context switches.
 	 */
-	t->thread.arch.fs = t->thread.regs.regs.gp[R8 / sizeof(long)];
+	t->thread.arch.fs = tls;
 
 	return 0;
 }


Patches currently in stable-queue which might be from amanieu@gmail.com are

queue-5.4/arm-implement-copy_thread_tls.patch
queue-5.4/arm64-implement-copy_thread_tls.patch
queue-5.4/xtensa-implement-copy_thread_tls.patch
queue-5.4/arm64-move-__arch_want_sys_clone3-definition-to-uapi-headers.patch
queue-5.4/parisc-implement-copy_thread_tls.patch
queue-5.4/clone3-ensure-copy_thread_tls-is-implemented.patch
queue-5.4/riscv-implement-copy_thread_tls.patch
queue-5.4/um-implement-copy_thread_tls.patch

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

