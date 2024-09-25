Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA6DCCF9EF
	for <linux-um@archiver.kernel.org>; Wed, 25 Sep 2024 20:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O3Q/38rXeEUVrojPW4zmGoR/22Nv0/GfBYZQoawwncs=; b=AyRddLhTedtVbvXWbnkkjAiFCb
	DkftyxBJEH6FO5PlYrcdnfIUY6GXB645m0m0P+p/9eYsgGMlP1H28FFVvKbu66BQM8rnW+CCvNt5D
	qDx5+pBjn7fdBR6v10rYee9Bj+94/RDVN8mQTAWHHlbABMO4tZq9+qb7igiiQJ1bB3qn5yyCyOMrv
	aMuKMIT+B/M4tBleC+967nNTNqMC0DJPuIipH211xquAOjGob1de8t5ZDjUe9M6pNr9oN+OApSTy3
	a4VVnW6rCdhgCgXeMCKcQ8f156Q8PS4NUElRPYh4+HjlYKzB3IVCeC/jYgd+5fgp9w6ZRIu3yoF5n
	bJ56hY7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stYh9-00000006V5e-07uY;
	Wed, 25 Sep 2024 20:33:07 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stYh5-00000006V46-3fIJ
	for linux-um@lists.infradead.org;
	Wed, 25 Sep 2024 20:33:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=O3Q/38rXeEUVrojPW4zmGoR/22Nv0/GfBYZQoawwncs=;
	t=1727296383; x=1728505983; b=bOB48lJJirwLssKGeC5/ZVSnDN5ZiD0dDHPWIi0/+bhsy5M
	wzoMqtP2OGfZqIHoDoozrfWGmIhhYQtsF7+q2LQEfhBK8R88amSS6JtHjailqLTdGOetW9NKNE981
	JPyv1y3hDJUMcqEVf4wEacxrRtsnpH9AcVlGAWsLgNLwEsUv+94Xdu4yIRr0cx2JKYiB+sTO8noIR
	6VyQOFzRKO5hIy1HHLHj0TE7TK2kSDqD4ZT1C2MOMuJm7jrnYkX9ZO1chivKmKIuf5pwYt/ei/nCo
	oJ7ZBy3BKsqNMVy0y3A/EAPfY8T8mXugLlBAE44k1xW2LLr5F+CDbjOtsSnZv4AA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1stYh1-00000001A19-43SP;
	Wed, 25 Sep 2024 22:33:00 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH 7/9] um: Track userspace children dying in SECCOMP mode
Date: Wed, 25 Sep 2024 22:32:30 +0200
Message-ID: <20240925203232.565086-8-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240925203232.565086-1-benjamin@sipsolutions.net>
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_133304_092824_54E92466 
X-CRM114-Status: GOOD (  28.77  )
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

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/asm/irq.h           |  5 +-
 arch/um/include/shared/irq_user.h   |  1 +
 arch/um/include/shared/os.h         |  1 +
 arch/um/include/shared/skas/mm_id.h |  5 ++
 arch/um/kernel/irq.c                |  5 ++
 arch/um/kernel/skas/mmu.c           | 91 +++++++++++++++++++++++++++--
 arch/um/os-Linux/process.c          | 31 ++++++++++
 arch/um/os-Linux/signal.c           | 19 +++++-
 8 files changed, 150 insertions(+), 8 deletions(-)

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
index 33c4d2677591..929ddb437ee1 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -199,6 +199,7 @@ extern int create_mem_file(unsigned long long len);
 extern void report_enomem(void);
 
 /* process.c */
+pid_t os_reap_child(void);
 extern void os_alarm_process(int pid);
 extern void os_kill_process(int pid, int reap_child);
 extern void os_kill_ptraced_process(int pid, int reap_child);
diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index 140388c282f6..39948f91d89b 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -7,6 +7,9 @@
 #define __MM_ID_H
 
 struct mm_id {
+	/* Simple list containing all MMs to react to a dead child */
+	struct mm_id *next;
+
 	int pid;
 	unsigned long stack;
 	int syscall_data_len;
@@ -14,4 +17,6 @@ struct mm_id {
 
 void __switch_mm(struct mm_id *mm_idp);
 
+void notify_mm_kill(int pid);
+
 #endif
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 534e91797f89..4fed231a0deb 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -786,3 +786,8 @@ unsigned long from_irq_stack(int nested)
 	return mask & ~1;
 }
 
+extern void sigchld_handler(int sig, struct siginfo *unused_si,
+			    struct uml_pt_regs *regs)
+{
+	do_IRQ(SIGCHLD_IRQ, regs);
+}
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index d3fb506d5bd6..2704f0342a35 100644
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
+struct mm_id *mm_list = NULL;
+
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
 	struct mm_id *new_id = &mm->context.id;
@@ -31,9 +35,13 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 
 	new_id->stack = stack;
 
-	block_signals_trace();
-	new_id->pid = start_userspace(stack);
-	unblock_signals_trace();
+	scoped_guard(spinlock_irqsave, &mm_list_lock) {
+		/* Insert into list, used for lookups when the child dies */
+		new_id->next = mm_list;
+		mm_list = new_id;
+
+		new_id->pid = start_userspace(stack);
+	}
 
 	if (new_id->pid < 0) {
 		ret = new_id->pid;
@@ -55,19 +63,92 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 void destroy_context(struct mm_struct *mm)
 {
 	struct mm_context *mmu = &mm->context;
+	struct mm_id *mm_idp, *prev;
 
 	/*
 	 * If init_new_context wasn't called, this will be
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
+	for (prev = NULL, mm_idp = mm_list;
+	     mm_idp;
+	     prev = mm_idp, mm_idp = prev->next) {
+		if (mm_idp != &mmu->id)
+			continue;
+
+		if (prev)
+			prev->next = mm_idp->next;
+		else
+			mm_list = mm_idp->next;
+
+		break;
+	}
+}
+
+static irqreturn_t mm_sigchld_irq(int irq, void* dev)
+{
+	struct mm_id *mm_idp;
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
+		for (mm_idp = mm_list; mm_idp; mm_idp = mm_idp->next) {
+			if (mm_idp->pid == pid) {
+				struct stub_data *stub_data;
+				printk("Unexpectedly lost MM child! Affected processes will segfault.");
+
+				/* Marks the MM as dead */
+				mm_idp->pid = -1;
+
+				/*
+				 * NOTE: If SMP is implemented, a futex_wake
+				 * needs to be added here.
+				 */
+				stub_data = (void *)mm_idp->stack;
+				stub_data->futex = FUTEX_IN_KERN;
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
+
+	err = request_irq(SIGCHLD_IRQ, mm_sigchld_irq, 0, "SIGCHLD", NULL);
+	if (err < 0)
+		panic("Failed to register SIGCHLD IRQ: %d", err);
+
+	return 0;
 }
+__initcall(init_child_tracking)
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index f20602e793d9..01ddaaadfa04 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -17,17 +17,29 @@
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
@@ -37,11 +49,27 @@ void os_kill_process(int pid, int reap_child)
 
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
@@ -201,5 +229,8 @@ void init_new_thread_signals(void)
 	set_handler(SIGBUS);
 	signal(SIGHUP, SIG_IGN);
 	set_handler(SIGIO);
+	/* We (currently) only use the child reaper IRQ in seccomp mode */
+	if (using_seccomp)
+		set_handler(SIGCHLD);
 	signal(SIGWINCH, SIG_IGN);
 }
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index b11ed66c8bb0..6ca72ffb8d38 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -29,6 +29,7 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 	[SIGBUS]	= bus_handler,
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
 #ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
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
@@ -344,6 +355,12 @@ void unblock_signals(void)
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
2.46.1


