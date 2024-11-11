Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A73BD2E9D5
	for <linux-um@archiver.kernel.org>; Mon, 11 Nov 2024 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K/lAJA4/rZY3nBRJv/SHlkS1ilHeig7UJshVzO5ST7M=; b=qZiOzz1hD800Mw29ibYP8rPd/p
	LpDN2BlFI8Hj3lDRHvQJcHxvW8OH8JMZxmgNMaUxxcmfMLkvTLXbeiWKY1T6JVLhMAtb4o7jU5Ako
	JGdC2jrL0ulM5cRP3H7pbOImZ06uem8de9D3bAK7OOSFn1UBpoRuwlF4xoCTZPM7S73JpiKVDX+uV
	Xc3gejRnGEehqVy3DNk4DeVr2CIgG347d8rk0/mFw3nCOH5jAjsWruLHGo0J0e67nFl3kAs8O70ny
	NdenoyIMfGPCrqz4zuLKO+LSE+3UQk7ti0eGOs3O66QLGUmKzDM9GsPYnTQKxzY4VozaICDO87FbQ
	P4CAETLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tARhr-0000000HHnP-2YFT;
	Mon, 11 Nov 2024 10:31:39 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tARgQ-0000000HHNS-2USu
	for linux-um@lists.infradead.org;
	Mon, 11 Nov 2024 10:30:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=K/lAJA4/rZY3nBRJv/SHlkS1ilHeig7UJshVzO5ST7M=; t=1731321008; x=1732530608; 
	b=LoIV5fvsDinYMXfOLWm1K6qasD/Yh6AUvdKU9GIzDb0KviwCPCtnQHOA5lpcZzAXWRZcTSKuPp6
	+hVkiB2X9avumV9jjk/FuTkUZFt9IZWFZH3oAp5/90yh8u35LrB8oY4Rjher/LrchuXqWBRlYFIiI
	toySh0iDyHvbRgW4/MbF8b+n4aI8wCE5eJRjnnc8V3C41ZzVtv/Eynh7ctqY3DHVcpgMdtz5UxYeo
	zd1VNzuwOJE9Qs+xcnJ64dmE1gHWxQwdi3tWjTBt+MxNScK/VuvKqSf8ulPgIfvkxqpPOzlViUfM0
	YyCnNDbbSyvCLOdgX8W+VGOjSWMk/1GoL+9g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tARgK-00000001yMs-1wdT;
	Mon, 11 Nov 2024 11:30:05 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Hajime Tazaki <thehajime@gmail.com>
Subject: [PATCH v3] um: move thread info into task
Date: Mon, 11 Nov 2024 11:29:10 +0100
Message-ID: <20241111102910.46512-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_023010_845965_8FA05E99 
X-CRM114-Status: GOOD (  39.82  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

This selects the THREAD_INFO_IN_TASK option for UM and changes the way
that the current task is discovered. This is trivial though, as UML
already tracks the current task in cpu_tasks[] and this can be used to
retrieve it.

Also remove the signal handler code that copies the thread information
into the IRQ stack. It is obsolete now, which also means that the
mentioned race condition cannot happen anymore.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Hajime Tazaki <thehajime@gmail.com>

---
v3:
- Fix whitespace issue (pointed out by Hajime Tazaki)
- Add Reviewed-By

v2:
- Fix circular include (thanks to Hajime Tazaki)
- Make irq stack a static variable and remove unused declaration
---
 arch/um/Kconfig                    |   1 +
 arch/um/include/asm/Kbuild         |   1 -
 arch/um/include/asm/current.h      |  24 +++++++
 arch/um/include/asm/thread_info.h  |  16 -----
 arch/um/include/shared/as-layout.h |   7 +-
 arch/um/kernel/dyn.lds.S           |   2 -
 arch/um/kernel/irq.c               | 112 -----------------------------
 arch/um/kernel/process.c           |   5 +-
 arch/um/kernel/skas/process.c      |   4 +-
 arch/um/kernel/um_arch.c           |   7 +-
 arch/um/kernel/uml.lds.S           |   2 -
 arch/um/os-Linux/signal.c          |  37 +---------
 12 files changed, 35 insertions(+), 183 deletions(-)
 create mode 100644 arch/um/include/asm/current.h

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index a9876bdb5bf9..18051b1cfce0 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -34,6 +34,7 @@ config UML
 	select HAVE_RUST
 	select ARCH_HAS_UBSAN
 	select HAVE_ARCH_TRACEHOOK
+	select THREAD_INFO_IN_TASK
 
 config MMU
 	bool
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 18f902da8e99..428f2c5158c2 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += bug.h
 generic-y += compat.h
-generic-y += current.h
 generic-y += device.h
 generic-y += dma-mapping.h
 generic-y += emergency-restart.h
diff --git a/arch/um/include/asm/current.h b/arch/um/include/asm/current.h
new file mode 100644
index 000000000000..f0094e3ae0e6
--- /dev/null
+++ b/arch/um/include/asm/current.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_CURRENT_H
+#define __ASM_CURRENT_H
+
+#include <linux/compiler.h>
+#include <linux/threads.h>
+
+#ifndef __ASSEMBLY__
+
+struct task_struct;
+extern struct task_struct *cpu_tasks[NR_CPUS];
+
+static __always_inline struct task_struct *get_current(void)
+{
+	return cpu_tasks[0];
+}
+
+
+#define current get_current()
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_CURRENT_H */
+
diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index 4d2a768246bc..f9ad06fcc991 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -17,33 +17,17 @@
 #include <sysdep/ptrace_user.h>
 
 struct thread_info {
-	struct task_struct	*task;		/* main task structure */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
 	int			preempt_count;  /* 0 => preemptable,
 						   <0 => BUG */
-	struct thread_info	*real_thread;    /* Points to non-IRQ stack */
 };
 
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	.task =		&tsk,			\
 	.flags =		0,		\
 	.cpu =		0,			\
 	.preempt_count = INIT_PREEMPT_COUNT,	\
-	.real_thread = NULL,			\
-}
-
-/* how to get the thread information struct from C */
-static inline struct thread_info *current_thread_info(void)
-{
-	struct thread_info *ti;
-	unsigned long mask = THREAD_SIZE - 1;
-	void *p;
-
-	asm volatile ("" : "=r" (p) : "0" (&ti));
-	ti = (struct thread_info *) (((unsigned long)p) & ~mask);
-	return ti;
 }
 
 #endif
diff --git a/arch/um/include/shared/as-layout.h b/arch/um/include/shared/as-layout.h
index d9679c911e54..ea65f151bf48 100644
--- a/arch/um/include/shared/as-layout.h
+++ b/arch/um/include/shared/as-layout.h
@@ -30,11 +30,8 @@
 
 #include <sysdep/ptrace.h>
 
-struct cpu_task {
-	void *task;
-};
-
-extern struct cpu_task cpu_tasks[];
+struct task_struct;
+extern struct task_struct *cpu_tasks[];
 
 extern unsigned long long physmem_size;
 
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index dc9d9a68af55..a36b7918a011 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -116,8 +116,6 @@ SECTIONS
   .fini_array     : { *(.fini_array) }
   .data           : {
     INIT_TASK_DATA(KERNEL_STACK_SIZE)
-    . = ALIGN(KERNEL_STACK_SIZE);
-    *(.data..init_irqstack)
     DATA_DATA
     *(.data.* .gnu.linkonce.d.*)
     SORT(CONSTRUCTORS)
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 534e91797f89..338450741aac 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -674,115 +674,3 @@ void __init init_IRQ(void)
 	/* Initialize EPOLL Loop */
 	os_setup_epoll();
 }
-
-/*
- * IRQ stack entry and exit:
- *
- * Unlike i386, UML doesn't receive IRQs on the normal kernel stack
- * and switch over to the IRQ stack after some preparation.  We use
- * sigaltstack to receive signals on a separate stack from the start.
- * These two functions make sure the rest of the kernel won't be too
- * upset by being on a different stack.  The IRQ stack has a
- * thread_info structure at the bottom so that current et al continue
- * to work.
- *
- * to_irq_stack copies the current task's thread_info to the IRQ stack
- * thread_info and sets the tasks's stack to point to the IRQ stack.
- *
- * from_irq_stack copies the thread_info struct back (flags may have
- * been modified) and resets the task's stack pointer.
- *
- * Tricky bits -
- *
- * What happens when two signals race each other?  UML doesn't block
- * signals with sigprocmask, SA_DEFER, or sa_mask, so a second signal
- * could arrive while a previous one is still setting up the
- * thread_info.
- *
- * There are three cases -
- *     The first interrupt on the stack - sets up the thread_info and
- * handles the interrupt
- *     A nested interrupt interrupting the copying of the thread_info -
- * can't handle the interrupt, as the stack is in an unknown state
- *     A nested interrupt not interrupting the copying of the
- * thread_info - doesn't do any setup, just handles the interrupt
- *
- * The first job is to figure out whether we interrupted stack setup.
- * This is done by xchging the signal mask with thread_info->pending.
- * If the value that comes back is zero, then there is no setup in
- * progress, and the interrupt can be handled.  If the value is
- * non-zero, then there is stack setup in progress.  In order to have
- * the interrupt handled, we leave our signal in the mask, and it will
- * be handled by the upper handler after it has set up the stack.
- *
- * Next is to figure out whether we are the outer handler or a nested
- * one.  As part of setting up the stack, thread_info->real_thread is
- * set to non-NULL (and is reset to NULL on exit).  This is the
- * nesting indicator.  If it is non-NULL, then the stack is already
- * set up and the handler can run.
- */
-
-static unsigned long pending_mask;
-
-unsigned long to_irq_stack(unsigned long *mask_out)
-{
-	struct thread_info *ti;
-	unsigned long mask, old;
-	int nested;
-
-	mask = xchg(&pending_mask, *mask_out);
-	if (mask != 0) {
-		/*
-		 * If any interrupts come in at this point, we want to
-		 * make sure that their bits aren't lost by our
-		 * putting our bit in.  So, this loop accumulates bits
-		 * until xchg returns the same value that we put in.
-		 * When that happens, there were no new interrupts,
-		 * and pending_mask contains a bit for each interrupt
-		 * that came in.
-		 */
-		old = *mask_out;
-		do {
-			old |= mask;
-			mask = xchg(&pending_mask, old);
-		} while (mask != old);
-		return 1;
-	}
-
-	ti = current_thread_info();
-	nested = (ti->real_thread != NULL);
-	if (!nested) {
-		struct task_struct *task;
-		struct thread_info *tti;
-
-		task = cpu_tasks[ti->cpu].task;
-		tti = task_thread_info(task);
-
-		*ti = *tti;
-		ti->real_thread = tti;
-		task->stack = ti;
-	}
-
-	mask = xchg(&pending_mask, 0);
-	*mask_out |= mask | nested;
-	return 0;
-}
-
-unsigned long from_irq_stack(int nested)
-{
-	struct thread_info *ti, *to;
-	unsigned long mask;
-
-	ti = current_thread_info();
-
-	pending_mask = 1;
-
-	to = ti->real_thread;
-	current->stack = to;
-	ti->real_thread = NULL;
-	*to = *ti;
-
-	mask = xchg(&pending_mask, 0);
-	return mask & ~1;
-}
-
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 56e7e525fc91..30bdc0a87dc8 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -43,7 +43,8 @@
  * cares about its entry, so it's OK if another processor is modifying its
  * entry.
  */
-struct cpu_task cpu_tasks[NR_CPUS] = { [0 ... NR_CPUS - 1] = { NULL } };
+struct task_struct *cpu_tasks[NR_CPUS];
+EXPORT_SYMBOL(cpu_tasks);
 
 void free_stack(unsigned long stack, int order)
 {
@@ -64,7 +65,7 @@ unsigned long alloc_stack(int order, int atomic)
 
 static inline void set_current(struct task_struct *task)
 {
-	cpu_tasks[task_thread_info(task)->cpu] = ((struct cpu_task) { task });
+	cpu_tasks[task_thread_info(task)->cpu] = task;
 }
 
 struct task_struct *__switch_to(struct task_struct *from, struct task_struct *to)
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 68657988c8d1..05dcdc057af9 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -22,15 +22,13 @@ static int __init start_kernel_proc(void *unused)
 {
 	block_signals_trace();
 
-	cpu_tasks[0].task = current;
-
 	start_kernel();
 	return 0;
 }
 
 extern int userspace_pid[];
 
-extern char cpu0_irqstack[];
+static char cpu0_irqstack[THREAD_SIZE] __aligned(THREAD_SIZE);
 
 int __init start_uml(void)
 {
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index ec17576ce9fc..62ddb865eb91 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -65,9 +65,6 @@ struct cpuinfo_um boot_cpu_data = {
 
 EXPORT_SYMBOL(boot_cpu_data);
 
-union thread_union cpu0_irqstack
-	__section(".data..init_irqstack") =
-		{ .thread_info = INIT_THREAD_INFO(init_task) };
 
 /* Changed in setup_arch, which is called in early boot */
 static char host_info[(__NEW_UTS_LEN + 1) * 5];
@@ -244,6 +241,8 @@ static struct notifier_block panic_exit_notifier = {
 
 void uml_finishsetup(void)
 {
+	cpu_tasks[0] = &init_task;
+
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &panic_exit_notifier);
 
@@ -418,7 +417,7 @@ void __init setup_arch(char **cmdline_p)
 {
 	u8 rng_seed[32];
 
-	stack_protections((unsigned long) &init_thread_info);
+	stack_protections((unsigned long) init_task.stack);
 	setup_physmem(uml_physmem, uml_reserved, physmem_size);
 	mem_total_pages(physmem_size, iomem_size);
 	uml_dtb_init();
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 5c92d58a78e8..a409d4b66114 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -77,8 +77,6 @@ SECTIONS
   .data    :
   {
     INIT_TASK_DATA(KERNEL_STACK_SIZE)
-    . = ALIGN(KERNEL_STACK_SIZE);
-    *(.data..init_irqstack)
     DATA_DATA
     *(.gnu.linkonce.d*)
     CONSTRUCTORS
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 52852018a3ad..9ea7269ffb77 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -190,43 +190,8 @@ static void hard_handler(int sig, siginfo_t *si, void *p)
 {
 	ucontext_t *uc = p;
 	mcontext_t *mc = &uc->uc_mcontext;
-	unsigned long pending = 1UL << sig;
 
-	do {
-		int nested, bail;
-
-		/*
-		 * pending comes back with one bit set for each
-		 * interrupt that arrived while setting up the stack,
-		 * plus a bit for this interrupt, plus the zero bit is
-		 * set if this is a nested interrupt.
-		 * If bail is true, then we interrupted another
-		 * handler setting up the stack.  In this case, we
-		 * have to return, and the upper handler will deal
-		 * with this interrupt.
-		 */
-		bail = to_irq_stack(&pending);
-		if (bail)
-			return;
-
-		nested = pending & 1;
-		pending &= ~1;
-
-		while ((sig = ffs(pending)) != 0){
-			sig--;
-			pending &= ~(1 << sig);
-			(*handlers[sig])(sig, (struct siginfo *)si, mc);
-		}
-
-		/*
-		 * Again, pending comes back with a mask of signals
-		 * that arrived while tearing down the stack.  If this
-		 * is non-zero, we just go back, set up the stack
-		 * again, and handle the new interrupts.
-		 */
-		if (!nested)
-			pending = from_irq_stack(nested);
-	} while (pending);
+	(*handlers[sig])(sig, (struct siginfo *)si, mc);
 }
 
 void set_handler(int sig)
-- 
2.47.0


