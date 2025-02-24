Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B45FC19776
	for <linux-um@archiver.kernel.org>; Mon, 24 Feb 2025 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BI5YZimuSdtT/W0w9FvjSfRruWwtfA5e2UWLd7UNn6c=; b=ZwhPTu5Xc2GrYK7v+pAsI4+uzd
	ONoZiXj+3vXUHpM3Z8m0tyUUl/6+bW3vQKVImsASFgRIVQw1YD874E1sXyAWTSomxip/ZKjIUK4VM
	XTQ9KENg5IlbjB1X0+wEuhH4x8X8K/2JxDvH0/X69v9tsbAKJEuWFU8pOyzdJtntHF57u8ZXiyZeI
	oXEQwzxixNghEouGG7Pb5YrFlkn+i3X6gqY7loWnOejLZJsvQxJnQAiqeSQBI150PtIzynUyp0y//
	fYpeTvDdkZfvJSrbyB3U3khaUof6YXQ2z/k5qZ7N3XlWrByBxgUQKtGsL0TKvVVh8aLeT2uyeHcf5
	hdkzCMXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd8S-0000000EnN2-09yQ;
	Mon, 24 Feb 2025 18:24:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd2w-0000000EmBH-2nul
	for linux-um@lists.infradead.org;
	Mon, 24 Feb 2025 18:19:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BI5YZimuSdtT/W0w9FvjSfRruWwtfA5e2UWLd7UNn6c=;
	t=1740421154; x=1741630754; b=er2RS+v1viP/bOAsviXtfDUbm5mwW/b1ug1nw14Qdjcncre
	du9yavj3IAvxcK/bfBfwFbZ1BcfLttlCiMPmDg/jka9xCa3JLAx41MAACK3M5ubiwBpFCBR9dr07X
	5m/7B5W7WFRiqILWFdAMHtWapGDq/LNKUbVs8i1HuDGVSQc0yQQs7TNJOIAKfFlkZjvWnfWer61v9
	28wtnJA2wRIOHmGk1TtBfb212YNHXRNkc4sDl3xs6T46JtEcAPyeNB+0du0tSIMdyr+VmZYiQ1KWj
	8mLvlMVnfQI6IDrHWxmpaPo3xx5920BpC3jF0RYemEz0cHHDwSiJkqfiWq2jXcYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tmd2t-00000008tWp-0EFI;
	Mon, 24 Feb 2025 19:19:11 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 6/9] um: Track userspace children dying in SECCOMP mode
Date: Mon, 24 Feb 2025 19:18:24 +0100
Message-ID: <20250224181827.647129-7-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224181827.647129-1-benjamin@sipsolutions.net>
References: <20250224181827.647129-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_101914_858895_F4F9E849 
X-CRM114-Status: GOOD (  30.40  )
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

v1:
- Permit IRQs during startup to enable detection there

RFCv2:
- Use "struct list_head" for the list by placing it into the mm_context
---
 arch/um/include/asm/irq.h           |  5 +-
 arch/um/include/asm/mmu.h           |  3 ++
 arch/um/include/shared/irq_user.h   |  1 +
 arch/um/include/shared/os.h         |  1 +
 arch/um/include/shared/skas/mm_id.h |  2 +
 arch/um/kernel/irq.c                |  6 +++
 arch/um/kernel/skas/mmu.c           | 83 +++++++++++++++++++++++++++--
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
index da0f6eea30d0..53a1f0651b96 100644
--- a/arch/um/include/shared/irq_user.h
+++ b/arch/um/include/shared/irq_user.h
@@ -16,6 +16,7 @@ enum um_irq_type {
 
 struct siginfo;
 extern void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
+extern void sigchld_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
 void sigio_run_timetravel_handlers(void);
 extern void free_irq_by_fd(int fd);
 extern void deactivate_fd(int fd, int irqnum);
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 5babad8c5f75..cb213c9dbeff 100644
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
index a4991746f5ea..7161bde0c8c1 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -689,3 +689,9 @@ void __init init_IRQ(void)
 	/* Initialize EPOLL Loop */
 	os_setup_epoll();
 }
+
+extern void sigchld_handler(int sig, struct siginfo *unused_si,
+			    struct uml_pt_regs *regs)
+{
+	do_IRQ(SIGCHLD_IRQ, regs);
+}
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 0eb5a1d3ba70..f8ee5d612c47 100644
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
@@ -31,10 +35,13 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 
 	new_id->stack = stack;
 
-	block_signals_trace();
-	new_id->pid = start_userspace(stack);
-	unblock_signals_trace();
+	scoped_guard(spinlock_irqsave, &mm_list_lock) {
+		/* Insert into list, used for lookups when the child dies */
+		list_add(&mm->context.list, &mm_list);
+
+	}
 
+	new_id->pid = start_userspace(stack);
 	if (new_id->pid < 0) {
 		ret = new_id->pid;
 		goto out_free;
@@ -60,13 +67,79 @@ void destroy_context(struct mm_struct *mm)
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
+__initcall(init_child_tracking)
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 9f086f939420..2a4722cfa6f3 100644
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
@@ -202,6 +230,9 @@ void init_new_thread_signals(void)
 	set_handler(SIGBUS);
 	signal(SIGHUP, SIG_IGN);
 	set_handler(SIGIO);
+	/* We (currently) only use the child reaper IRQ in seccomp mode */
+	if (using_seccomp)
+		set_handler(SIGCHLD);
 	signal(SIGWINCH, SIG_IGN);
 }
 
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 9ea7269ffb77..b6080529d571 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -29,6 +29,7 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
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
 
 	(*sig_info[sig])(sig, si, &r);
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
+			sigchld_handler(SIGCHLD, NULL, &regs);
+		}
+
 		/* Do not reenter the handler */
 
 		if ((save_pending & SIGALRM_MASK) && (!(signals_active & SIGALRM_MASK)))
-- 
2.48.1


