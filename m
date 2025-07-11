Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCDDC83F23
	for <linux-um@archiver.kernel.org>; Fri, 11 Jul 2025 05:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nA3wEzclQ5//Sqn0MdvAPP5DIpc0uaVnBxnsZmvVRhU=; b=wBBfHb2whBqRyFgtDQUnHbBaU2
	gX6v7Gkj+j+R2HxCYXm7l/oRobk+rZ94Wkp8wk0G6ijd0JmKhg/fVd+xXYOCj0pdfWJ4Nt4DmHlze
	yVX3j/lkLtpM0fJQaEEB0koruMDZofw38JYCFkt3yEwz7QfLZntBcXHMnLAfTRPfLty+wbwsRzygA
	WLRW2oRNfOvQKsZ7dyr++M4X3zYELZ7mItdtXXaqIQZLuedt3FRFuQiT7yGCohpwQ3t9eEJaScq3N
	SOqquf9ln6up9PHnP4VB7VVF/uUwrOv/L2rhvAwGQWphYC3jbEKSQUUDpb2FiWTRJBLyxtva6wPzl
	XPOgg3YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua6S7-0000000Dlbq-0j6G;
	Fri, 11 Jul 2025 05:37:43 +0000
Received: from out-176.mta1.migadu.com ([95.215.58.176])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua6Ix-0000000DkkV-0oT1
	for linux-um@lists.infradead.org;
	Fri, 11 Jul 2025 05:28:16 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752211693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nA3wEzclQ5//Sqn0MdvAPP5DIpc0uaVnBxnsZmvVRhU=;
	b=pLm+zlQDkbBOzgivqcJeYi3gpgvzerVeN7UK7g8t30pnO9MTnj3Q30xn970L5LEYcxzPY/
	6Q3aAE18Wm9I9X0NY1MEze5vYoBbPaSlVbB3CxYf0qDW2ERESixLUzVudWI3vsLTs7w2SN
	dVsM3DSXNmA3Kpbq2iykMb7GIa75Lcw=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 3/3] um: Stop tracking stub's PID via userspace_pid[]
Date: Fri, 11 Jul 2025 13:27:48 +0800
Message-Id: <20250711052748.2434424-4-tiwei.bie@linux.dev>
In-Reply-To: <20250711052748.2434424-1-tiwei.bie@linux.dev>
References: <20250711052748.2434424-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_222815_384545_D756A8E7 
X-CRM114-Status: GOOD (  15.63  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

The PID of the stub process can be obtained from current_mm_id().
There is no need to track it via userspace_pid[]. Stop doing that
to simplify the code.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/mmu_context.h   |  9 +--------
 arch/um/include/shared/skas/mm_id.h |  2 --
 arch/um/kernel/exec.c               |  2 --
 arch/um/os-Linux/skas/process.c     | 16 ++++++----------
 4 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 23dcc914d44e..0bbb24868557 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -16,11 +16,6 @@
 #define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 {
-	/*
-	 * This is called by fs/exec.c and sys_unshare()
-	 * when the new ->mm is used for the first time.
-	 */
-	__switch_mm(&new->context.id);
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
@@ -28,11 +23,9 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 {
 	unsigned cpu = smp_processor_id();
 
-	if(prev != next){
+	if (prev != next) {
 		cpumask_clear_cpu(cpu, mm_cpumask(prev));
 		cpumask_set_cpu(cpu, mm_cpumask(next));
-		if(next != &init_mm)
-			__switch_mm(&next->context.id);
 	}
 }
 
diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index 89df9a55fbea..4f977ef5dda5 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -19,8 +19,6 @@ struct mm_id {
 	int syscall_fd_map[STUB_MAX_FDS];
 };
 
-void __switch_mm(struct mm_id *mm_idp);
-
 void notify_mm_kill(int pid);
 
 #endif
diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index cb8b5cd9285c..13812fa97eee 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -26,8 +26,6 @@ void flush_thread(void)
 
 	get_safe_registers(current_pt_regs()->regs.gp,
 			   current_pt_regs()->regs.fp);
-
-	__switch_mm(&current->mm->context.id);
 }
 
 void start_thread(struct pt_regs *regs, unsigned long eip, unsigned long esp)
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index e90a0658bba8..702ff2aeb32a 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -434,7 +434,6 @@ static int __init init_stub_exe_fd(void)
 __initcall(init_stub_exe_fd);
 
 int using_seccomp;
-int userspace_pid[NR_CPUS];
 
 /**
  * start_userspace() - prepare a new userspace process
@@ -553,7 +552,7 @@ extern unsigned long tt_extra_sched_jiffies;
 
 void userspace(struct uml_pt_regs *regs)
 {
-	int err, status, op, pid = userspace_pid[0];
+	int err, status, op;
 	siginfo_t si_ptrace;
 	siginfo_t *si;
 	int sig;
@@ -562,6 +561,8 @@ void userspace(struct uml_pt_regs *regs)
 	interrupt_end();
 
 	while (1) {
+		struct mm_id *mm_id = current_mm_id();
+
 		/*
 		 * When we are in time-travel mode, userspace can theoretically
 		 * do a *lot* of work without being scheduled. The problem with
@@ -590,7 +591,6 @@ void userspace(struct uml_pt_regs *regs)
 		current_mm_sync();
 
 		if (using_seccomp) {
-			struct mm_id *mm_id = current_mm_id();
 			struct stub_data *proc_data = (void *) mm_id->stack;
 
 			err = set_stub_state(regs, proc_data, singlestepping());
@@ -644,8 +644,10 @@ void userspace(struct uml_pt_regs *regs)
 				GET_FAULTINFO_FROM_MC(regs->faultinfo, mcontext);
 			}
 		} else {
+			int pid = mm_id->pid;
+
 			/* Flush out any pending syscalls */
-			err = syscall_stub_flush(current_mm_id());
+			err = syscall_stub_flush(mm_id);
 			if (err) {
 				if (err == -ENOMEM)
 					report_enomem();
@@ -776,7 +778,6 @@ void userspace(struct uml_pt_regs *regs)
 				       __func__, sig);
 				fatal_sigsegv();
 			}
-			pid = userspace_pid[0];
 			interrupt_end();
 
 			/* Avoid -ERESTARTSYS handling in host */
@@ -901,8 +902,3 @@ void reboot_skas(void)
 	block_signals_trace();
 	UML_LONGJMP(&initial_jmpbuf, noreboot ? INIT_JMP_HALT : INIT_JMP_REBOOT);
 }
-
-void __switch_mm(struct mm_id *mm_idp)
-{
-	userspace_pid[0] = mm_idp->pid;
-}
-- 
2.34.1


