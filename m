Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTwR-005Vb7-Hi
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:01:42 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 27/27] um: Delay flushing syscalls until the thread is
 restarted
Date: Wed,  3 Mar 2021 16:55:23 +0100
Message-Id: <20210303155523.124277-28-benjamin@sipsolutions.net>
In-Reply-To: <20210303155523.124277-1-benjamin@sipsolutions.net>
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
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
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>

This way we can avoid doing two extra context switches when managing
processes using seccomp.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/shared/skas/skas.h |  1 +
 arch/um/kernel/skas/process.c      |  8 ++++++++
 arch/um/kernel/tlb.c               | 10 +---------
 arch/um/os-Linux/skas/process.c    | 29 ++++++++++++++++++++++++++++-
 4 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index f10599995d4d..bc672d607101 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -21,5 +21,6 @@ extern void new_thread_handler(void);
 extern void handle_syscall(struct uml_pt_regs *regs);
 extern long execute_syscall_skas(void *r);
 extern unsigned long current_stub_stack(void);
+extern struct mm_id *current_mm_id(void);
 
 #endif
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index f2ac134c9752..c7345c83e07b 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -53,3 +53,11 @@ unsigned long current_stub_stack(void)
 
 	return current->mm->context.id.stack;
 }
+
+struct mm_id *current_mm_id(void)
+{
+	if (current->mm == NULL)
+		return NULL;
+
+	return &current->mm->context.id;
+}
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index c15cac380fcd..bda516cb1186 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -460,7 +460,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 	pmd_t *pmd;
 	pte_t *pte;
 	struct mm_struct *mm = vma->vm_mm;
-	int r, w, x, prot, err = 0;
+	int r, w, x, prot;
 	struct mm_id *mm_id;
 
 	address &= PAGE_MASK;
@@ -508,14 +508,6 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 	} else if (pte_newprot(*pte))
 		protect(mm_id, address, PAGE_SIZE, prot);
 
-	err = syscall_stub_flush(mm_id);
-	if (err) {
-		if (err == -ENOMEM)
-			report_enomem();
-
-		goto kill;
-	}
-
 	*pte = pte_mkuptodate(*pte);
 
 	return;
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index ceb75ac47b5f..0d3e137bd5b9 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -531,7 +531,8 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 			fatal_sigsegv();
 
 		if (using_seccomp) {
-			struct stub_data *proc_data = (void *)current_stub_stack();
+			struct mm_id *mm_id = current_mm_id();
+			struct stub_data *proc_data = (void *) mm_id->stack;
 			int ret;
 
 			set_stub_state(regs, proc_data, singlestepping(NULL));
@@ -540,6 +541,10 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 			if (proc_data->restart_wait != 0)
 				panic("Programming error: Flag to only run syscalls in child was not cleared!");
 
+			/* Mark pending syscalls for flushing */
+			proc_data->syscall_data_len = mm_id->syscall_data_len;
+			mm_id->syscall_data_len = 0;
+
 			proc_data->signal = 0;
 			proc_data->futex = FUTEX_IN_CHILD;
 			CATCH_EINTR(syscall(__NR_futex, &proc_data->futex,
@@ -552,6 +557,12 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 
 			sig = proc_data->signal;
 
+			if (sig == SIGTRAP && proc_data->err != 0) {
+				printk(UM_KERN_ERR "%s - Error flushing stub syscalls",
+				       __func__);
+				fatal_sigsegv();
+			}
+
 			get_stub_state(regs, proc_data);
 
 			if (proc_data->si_offset > sizeof(proc_data->sigstack) - sizeof(*si))
@@ -569,6 +580,14 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 				GET_FAULTINFO_FROM_MC(regs->faultinfo, mcontext);
 			}
 		} else {
+			/* With ptrace, we need to explicitly flush all pending syscalls. */
+			err = syscall_stub_flush(current_mm_id());
+			if (err) {
+				printk(UM_KERN_ERR "%s - Error flushing stub syscalls: %d",
+				       __func__, -err);
+				fatal_sigsegv();
+			}
+
 			/*
 			 * This can legitimately fail if the process loads a
 			 * bogus value into a segment register.  It will
@@ -733,6 +752,14 @@ int copy_context_skas0(struct mm_id *id, struct mm_id *from)
 	unsigned long long new_offset;
 	int new_fd = phys_mapping(to_phys((void *)id->stack), &new_offset);
 
+	/* Flush out any pending syscalls before trying to run the stub. */
+	err = syscall_stub_flush(from);
+	if (err) {
+		printk(UM_KERN_ERR "%s - Error flushing stub syscalls: %d",
+		       __func__, -err);
+		fatal_sigsegv();
+	}
+
 	/*
 	 * prepare offset and fd of child's stack as argument for parent's
 	 * and child's mmap2 calls
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

