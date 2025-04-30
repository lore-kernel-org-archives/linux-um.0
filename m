Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B7BC3ABB5
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 16:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lfgl2PRBGDTmnLNnXIsMguAGQIHF6zw81qS+Lc6/FX0=; b=J4DA2E8Eo5RPltLeAZ0oDisLuV
	0WvLVCrg9tM8sJ/deWESnQFcSHZ4aiLLKDIw9VZrFtbcVbveSP2O/K5+Oj0WN5rJ1UvjtmDG4wu99
	fs0svL5ljQm6oR2dPaubIdD+dlyh9Qw338TEMBO8bi8nzOkriBvQSUljHPYZtDd53gHc8OPWrbu6r
	1zDyZcpOqoZ0bkpA6IfclB+RCn4yjA1twfchCOObvoYSbLjRLr8SsiHRNQUIYSvH4E+o6PccigwYD
	w9PMte1oQ8tSECw8Zs3sp6kPKJ+lR7FvGNGOaM48SogvPtNBfTv1yNaPYF9Q8S+arVlVAyUMxT9bo
	FgqRJtvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA9zV-0000000DO2O-3JYy;
	Wed, 30 Apr 2025 16:08:57 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA9wu-0000000DNgG-2r8c
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 16:06:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Lfgl2PRBGDTmnLNnXIsMguAGQIHF6zw81qS+Lc6/FX0=;
	t=1746029176; x=1747238776; b=r+Y40cx8B9YQ5lRHH5yN67MefOG8dFHmFAMex0QlMaw1Vq7
	Tdvmqz0bxed3nUbMbdN7JOoriS+hAZVkjMJQtwQl9JvhHF3le+TQ12LEbMxG52sBIjiR30ntASLiK
	Rav+NtRkWg6DtSlxAPs3HIsrP/+V6/3L8DQUNCIc9GOErwiHxn7fgjs0anp2tXXZt1lAf3gFAgpHF
	dltV+MArMAlZVec6OH0sneAvMc0OCuBs53+erubAdOJzdSsIqKw9MhDM4LMs4U/yNf7EJNv53MlzF
	9mEmflcEy1aB/G1K5cZj9Aai+4aBzvD5td1IJ0EG4404yR4QsH/XeCCv6dPHzvJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uA9wr-0000000DxyX-1GA5;
	Wed, 30 Apr 2025 18:06:13 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 5/8] um: Track userspace children dying in SECCOMP mode
Date: Wed, 30 Apr 2025 18:04:10 +0200
Message-ID: <20250430160413.3250227-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430160413.3250227-1-benjamin@sipsolutions.net>
References: <20250430160413.3250227-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_090616_899223_4CD7E77D 
X-CRM114-Status: GOOD (  31.05  )
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

When in seccomp mode, we would hang forever on the futex if a child has
died unexpectedly. In contrast, ptrace mode will notice it and kill the
corresponding thread when it fails to run it.

Fix this issue using a new IRQ that is fired after a SIGCHLD and keeping
an (internal) list of all MMs. In the IRQ handler, find the affected MM
and set its PID to -1 as well as the futex variable to FUTEX_IN_KERN.

This, together with futex returning -EINTR after the signal is
sufficient to implement a race-free detection of a child dying.

Note that this also enables IRQ handling while starting a userspace
process. This should be safe and SECCOMP requires the IRQ in case the
process does not come up properly.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v2:
- Fix whitespace issue

v1:
- Permit IRQs during startup to enable detection there

RFCv2:
- Use "struct list_head" for the list by placing it into the mm_context
---
 arch/um/include/asm/irq.h           |  5 +-
 arch/um/include/asm/mmu.h           |  3 ++
 arch/um/include/shared/irq_user.h   |  2 +
 arch/um/include/shared/os.h         |  1 +
 arch/um/include/shared/skas/mm_id.h |  2 +
 arch/um/kernel/irq.c                |  6 +++
 arch/um/kernel/skas/mmu.c           | 82 +++++++++++++++++++++++++++--
 arch/um/os-Linux/process.c          | 31 +++++++++++
 arch/um/os-Linux/signal.c           | 19 ++++++-
 9 files changed, 143 insertions(+), 8 deletions(-)

diff --git a/arch/um/include/asm/irq.h b/arch/um/include/asm/irq.h
index 749dfe8512e8..36dbedd1af48 100644
--- a/arch/um/include/asm/irq.h
+++ b/arch/um/include/asm/irq.h
@@ -13,17 +13,18 @@
 #define TELNETD_IRQ 		8
 #define XTERM_IRQ 		9
 #define RANDOM_IRQ 		10
+#define SIGCHLD_IRQ		11
 
 #ifdef CONFIG_UML_NET_VECTOR
 
-#define VECTOR_BASE_IRQ		(RANDOM_IRQ + 1)
+#define VECTOR_BASE_IRQ		(SIGCHLD_IRQ + 1)
 #define VECTOR_IRQ_SPACE	8
 
 #define UM_FIRST_DYN_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ)
 
 #else
 
-#define UM_FIRST_DYN_IRQ (RANDOM_IRQ + 1)
+#define UM_FIRST_DYN_IRQ (SIGCHLD_IRQ + 1)
 
 #endif
 
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index a3eaca41ff61..4d0e4239f3cc 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -6,11 +6,14 @@
 #ifndef __ARCH_UM_MMU_H
 #define __ARCH_UM_MMU_H
 
+#include "linux/types.h"
 #include <mm_id.h>
 
 typedef struct mm_context {
 	struct mm_id id;
 
+	struct list_head list;
+
 	/* Address range in need of a TLB sync */
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
diff --git a/arch/um/include/shared/irq_user.h b/arch/um/include/shared/irq_user.h
index 88835b52ae2b..746abc24a5d5 100644
--- a/arch/um/include/shared/irq_user.h
+++ b/arch/um/include/shared/irq_user.h
@@ -17,6 +17,8 @@ enum um_irq_type {
 struct siginfo;
 extern void sigio_handler(int sig, struct siginfo *unused_si,
 			  struct uml_pt_regs *regs, void *mc);
+extern void sigchld_handler(int sig, struct siginfo *unused_si,
+			   struct uml_pt_regs *regs, void *mc);
 void sigio_run_timetravel_handlers(void);
 extern void free_irq_by_fd(int fd);
 extern void deactivate_fd(int fd, int irqnum);
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 152a60080d5b..39a6828bf78a 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -198,6 +198,7 @@ extern int create_mem_file(unsigned long long len);
 extern void report_enomem(void);
 
 /* process.c */
+pid_t os_reap_child(void);
 extern void os_alarm_process(int pid);
 extern void os_kill_process(int pid, int reap_child);
 extern void os_kill_ptraced_process(int pid, int reap_child);
diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index 140388c282f6..0654c57bb28e 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -14,4 +14,6 @@ struct mm_id {
 
 void __switch_mm(struct mm_id *mm_idp);
 
+void notify_mm_kill(int pid);
+
 #endif
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index abe8f30a521c..f1787be3983c 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -690,3 +690,9 @@ void __init init_IRQ(void)
 	/* Initialize EPOLL Loop */
 	os_setup_epoll();
 }
+
+extern void sigchld_handler(int sig, struct siginfo *unused_si,
+			    struct uml_pt_regs *regs, void *mc)
+{
+	do_IRQ(SIGCHLD_IRQ, regs);
+}
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 0eb5a1d3ba70..1e146a0f9549 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -8,6 +8,7 @@
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
 
+#include <shared/irq_kern.h>
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
 #include <asm/mmu_context.h>
@@ -19,6 +20,9 @@
 /* Ensure the stub_data struct covers the allocated area */
 static_assert(sizeof(struct stub_data) == STUB_DATA_PAGES * UM_KERN_PAGE_SIZE);
 
+spinlock_t mm_list_lock;
+struct list_head mm_list;
+
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
 	struct mm_id *new_id = &mm->context.id;
@@ -31,10 +35,12 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 
 	new_id->stack = stack;
 
-	block_signals_trace();
-	new_id->pid = start_userspace(stack);
-	unblock_signals_trace();
+	scoped_guard(spinlock_irqsave, &mm_list_lock) {
+		/* Insert into list, used for lookups when the child dies */
+		list_add(&mm->context.list, &mm_list);
+	}
 
+	new_id->pid = start_userspace(stack);
 	if (new_id->pid < 0) {
 		ret = new_id->pid;
 		goto out_free;
@@ -60,13 +66,79 @@ void destroy_context(struct mm_struct *mm)
 	 * zero, resulting in a kill(0), which will result in the
 	 * whole UML suddenly dying.  Also, cover negative and
 	 * 1 cases, since they shouldn't happen either.
+	 *
+	 * Negative cases happen if the child died unexpectedly.
 	 */
-	if (mmu->id.pid < 2) {
+	if (mmu->id.pid >= 0 && mmu->id.pid < 2) {
 		printk(KERN_ERR "corrupt mm_context - pid = %d\n",
 		       mmu->id.pid);
 		return;
 	}
-	os_kill_ptraced_process(mmu->id.pid, 1);
+
+	if (mmu->id.pid > 0) {
+		os_kill_ptraced_process(mmu->id.pid, 1);
+		mmu->id.pid = -1;
+	}
 
 	free_pages(mmu->id.stack, ilog2(STUB_DATA_PAGES));
+
+	guard(spinlock_irqsave)(&mm_list_lock);
+
+	list_del(&mm->context.list);
+}
+
+static irqreturn_t mm_sigchld_irq(int irq, void* dev)
+{
+	struct mm_context *mm_context;
+	pid_t pid;
+
+	guard(spinlock)(&mm_list_lock);
+
+	while ((pid = os_reap_child()) > 0) {
+		/*
+		* A child died, check if we have an MM with the PID. This is
+		* only relevant in SECCOMP mode (as ptrace will fail anyway).
+		*
+		* See wait_stub_done_seccomp for more details.
+		*/
+		list_for_each_entry(mm_context, &mm_list, list) {
+			if (mm_context->id.pid == pid) {
+				struct stub_data *stub_data;
+				printk("Unexpectedly lost MM child! Affected tasks will segfault.");
+
+				/* Marks the MM as dead */
+				mm_context->id.pid = -1;
+
+				/*
+				 * NOTE: If SMP is implemented, a futex_wake
+				 * needs to be added here.
+				 */
+				stub_data = (void *)mm_context->id.stack;
+				stub_data->futex = FUTEX_IN_KERN;
+
+				/*
+				 * NOTE: Currently executing syscalls by
+				 * affected tasks may finish normally.
+				 */
+				break;
+			}
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int __init init_child_tracking(void)
+{
+	int err;
+
+	spin_lock_init(&mm_list_lock);
+	INIT_LIST_HEAD(&mm_list);
+
+	err = request_irq(SIGCHLD_IRQ, mm_sigchld_irq, 0, "SIGCHLD", NULL);
+	if (err < 0)
+		panic("Failed to register SIGCHLD IRQ: %d", err);
+
+	return 0;
 }
+early_initcall(init_child_tracking)
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 184566edeee9..00b49e90d05f 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -18,17 +18,29 @@
 #include <init.h>
 #include <longjmp.h>
 #include <os.h>
+#include <skas/skas.h>
 
 void os_alarm_process(int pid)
 {
+	if (pid <= 0)
+		return;
+
 	kill(pid, SIGALRM);
 }
 
 void os_kill_process(int pid, int reap_child)
 {
+	if (pid <= 0)
+		return;
+
+	/* Block signals until child is reaped */
+	block_signals();
+
 	kill(pid, SIGKILL);
 	if (reap_child)
 		CATCH_EINTR(waitpid(pid, NULL, __WALL));
+
+	unblock_signals();
 }
 
 /* Kill off a ptraced child by all means available.  kill it normally first,
@@ -38,11 +50,27 @@ void os_kill_process(int pid, int reap_child)
 
 void os_kill_ptraced_process(int pid, int reap_child)
 {
+	if (pid <= 0)
+		return;
+
+	/* Block signals until child is reaped */
+	block_signals();
+
 	kill(pid, SIGKILL);
 	ptrace(PTRACE_KILL, pid);
 	ptrace(PTRACE_CONT, pid);
 	if (reap_child)
 		CATCH_EINTR(waitpid(pid, NULL, __WALL));
+
+	unblock_signals();
+}
+
+pid_t os_reap_child(void)
+{
+	int status;
+
+	/* Try to reap a child */
+	return waitpid(-1, &status, WNOHANG);
 }
 
 /* Don't use the glibc version, which caches the result in TLS. It misses some
@@ -151,6 +179,9 @@ void init_new_thread_signals(void)
 	set_handler(SIGBUS);
 	signal(SIGHUP, SIG_IGN);
 	set_handler(SIGIO);
+	/* We (currently) only use the child reaper IRQ in seccomp mode */
+	if (using_seccomp)
+		set_handler(SIGCHLD);
 	signal(SIGWINCH, SIG_IGN);
 }
 
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index e71e5b4878d1..11f07f498270 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -29,6 +29,7 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *, void *mc) =
 	[SIGBUS]	= relay_signal,
 	[SIGSEGV]	= segv_handler,
 	[SIGIO]		= sigio_handler,
+	[SIGCHLD]	= sigchld_handler,
 };
 
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
@@ -44,7 +45,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 	}
 
 	/* enable signals if sig isn't IRQ signal */
-	if ((sig != SIGIO) && (sig != SIGWINCH))
+	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGCHLD))
 		unblock_signals_trace();
 
 	(*sig_info[sig])(sig, si, &r, mc);
@@ -64,6 +65,9 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 #define SIGALRM_BIT 1
 #define SIGALRM_MASK (1 << SIGALRM_BIT)
 
+#define SIGCHLD_BIT 2
+#define SIGCHLD_MASK (1 << SIGCHLD_BIT)
+
 int signals_enabled;
 #if IS_ENABLED(CONFIG_UML_TIME_TRAVEL_SUPPORT)
 static int signals_blocked, signals_blocked_pending;
@@ -102,6 +106,11 @@ static void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 		return;
 	}
 
+	if (!enabled && (sig == SIGCHLD)) {
+		signals_pending |= SIGCHLD_MASK;
+		return;
+	}
+
 	block_signals_trace();
 
 	sig_handler_common(sig, si, mc);
@@ -181,6 +190,8 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 
 	[SIGIO] = sig_handler,
 	[SIGWINCH] = sig_handler,
+	/* SIGCHLD is only actually registered in seccomp mode. */
+	[SIGCHLD] = sig_handler,
 	[SIGALRM] = timer_alarm_handler,
 
 	[SIGUSR1] = sigusr1_handler,
@@ -309,6 +320,12 @@ void unblock_signals(void)
 		if (save_pending & SIGIO_MASK)
 			sig_handler_common(SIGIO, NULL, NULL);
 
+		if (save_pending & SIGCHLD_MASK) {
+			struct uml_pt_regs regs = {};
+
+			sigchld_handler(SIGCHLD, NULL, &regs, NULL);
+		}
+
 		/* Do not reenter the handler */
 
 		if ((save_pending & SIGALRM_MASK) && (!(signals_active & SIGALRM_MASK)))
-- 
2.49.0


