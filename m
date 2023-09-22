Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E52CD4F5B
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 11:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nAVX0u/CjMFqUOojcEb8er5raMx3Qp6O8j60QQXnpLQ=; b=AtZ6XTbi5u3P8R
	pK/QqmoYy6doAc4wBskqLUEQ+gMqZlGkHUV6TJnnEdZLQUyMzY1FwFtFL15TEnA2zGt2hYHBoknyW
	DNUkBUHNmRhpIUPeNurvZ9QN/T72/rSHZpIDRkSYPTuoUCRcM+B5AVd3feQ3+vN1pU/O61+IZ22HO
	4xbZ7cYdPxGPWbBFlj9wJcSDeLjoVZEd4N52Lnf3wpnxsEP9FF6TcSHNTggb39yV7B84EbiUKJ/q3
	Ju+uG35IVcOX0R6xnnXvMK5nAm8gL/NCHK7R4MeFGDps0Xwr6SCCPCpRseuZIPXu0I3oRV2DUYQft
	tCiSnmsCP7QdssYehUgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qje9a-008w26-1H;
	Fri, 22 Sep 2023 11:16:58 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qje9W-008vz4-34
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 11:16:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=/kaaIHJryvQTvac8gkHZF0RJzYPsQE+f7+VP3sIv6Qg=; t=1695381408; x=1696591008; 
	b=hHkhi4b8V6GyqDp9mAtj5IBaOS0xs37SmUNQrxFDEPYd3tTf+txXusQKLKLKjUyFvEWdH5OI0s6
	XVki1nrN8I6qCA3/D7+1b2aJ+sLIrf9tEs9lPA3zdTMmwbcHqwODbtVTpqVObHR3zyNCniuEciTCr
	pQ4NvNpSLwIPgdnx9AT2S7M57u6EW4aPIslaKXEm48UdB9KtCzHjP3f/Z84R7jA6lNcJjj3x/7OvT
	xGjIUtkY8ngw1Q0lhvcgFGXZ/kshOfyW5wXrySRMt+/VostTFZeoph/9VCRSDlAUKqSCsSAVFt6J7
	aCaLJ3DRpgxJJ/d8rJBDbo+hnLIH+QOK1nDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qje9N-00FDJR-1r;
	Fri, 22 Sep 2023 13:16:45 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: clean up mm creation
Date: Fri, 22 Sep 2023 13:16:39 +0200
Message-ID: <20230922131638.2c57ec713d1c.Id11dff4b349e6a8f0136bb6bb09f6e01a80befbb@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_041655_167476_A6510E07 
X-CRM114-Status: GOOD (  33.89  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Johannes Berg <johannes.berg@intel.com>

While enabling PREEMPT on UML, we found that the call to
force_flush_all() cannot be done where it is, it sleeps
while atomic.

Further investigation shows that all this seems at least
a bit roundabout and possibly wrong wrong in the first
place - we copy from the 'current' process and then flush
when it starts running.

What we really want is to start fresh with an empty mm
process, then have it all set up by the kernel (copying
the original mm contents as needed), and then sync it
in arch_dup_mmap().

We should do the same for the LDT, so need to split that
to be able to do this.

Note that this fixes what seems like an issue - we look
at current->mm when we copy, but that doesn't seem right
in the case of clone() without copying the MM. This is
probably saved by the forced flush later right now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/Kbuild        |   1 -
 arch/um/include/asm/mm_hooks.h    |  22 ++++++
 arch/um/include/asm/mmu.h         |   3 +-
 arch/um/include/asm/mmu_context.h |   2 +-
 arch/um/include/shared/os.h       |   1 -
 arch/um/kernel/process.c          |   3 -
 arch/um/kernel/skas/mmu.c         |  35 ++++++----
 arch/um/kernel/tlb.c              |   5 +-
 arch/um/os-Linux/skas/process.c   | 107 ------------------------------
 arch/x86/um/ldt.c                 |  53 +++++++--------
 10 files changed, 76 insertions(+), 156 deletions(-)
 create mode 100644 arch/um/include/asm/mm_hooks.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b2d834a29f3a..de8d82a6fd7b 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -26,5 +26,4 @@ generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += kprobes.h
-generic-y += mm_hooks.h
 generic-y += vga.h
diff --git a/arch/um/include/asm/mm_hooks.h b/arch/um/include/asm/mm_hooks.h
new file mode 100644
index 000000000000..b1016520c5b8
--- /dev/null
+++ b/arch/um/include/asm/mm_hooks.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UM_MM_HOOKS_H
+#define _ASM_UM_MM_HOOKS_H
+
+int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm);
+
+static inline void arch_exit_mmap(struct mm_struct *mm)
+{
+}
+
+static inline void arch_unmap(struct mm_struct *mm,
+			unsigned long start, unsigned long end)
+{
+}
+
+static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool execute, bool foreign)
+{
+	/* by default, allow everything */
+	return true;
+}
+#endif	/* _ASM_UM_MM_HOOKS_H */
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 5b072aba5b65..68a710d23b5d 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -18,7 +18,8 @@ typedef struct mm_context {
 extern void __switch_mm(struct mm_id * mm_idp);
 
 /* Avoid tangled inclusion with asm/ldt.h */
-extern long init_new_ldt(struct mm_context *to_mm, struct mm_context *from_mm);
+extern int init_new_ldt(struct mm_context *to_mm);
+extern int copy_ldt(struct mm_context *to_mm, struct mm_context *from_mm);
 extern void free_ldt(struct mm_context *mm);
 
 #endif
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 68e2eb9cfb47..8668861d4a85 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -13,7 +13,7 @@
 #include <asm/mm_hooks.h>
 #include <asm/mmu.h>
 
-extern void force_flush_all(void);
+void force_flush_all(struct mm_struct *mm);
 
 #define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 1a82c6548dd5..c9acc28fe47c 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -289,7 +289,6 @@ extern int protect(struct mm_id * mm_idp, unsigned long addr,
 /* skas/process.c */
 extern int is_skas_winch(int pid, int fd, void *data);
 extern int start_userspace(unsigned long stub_stack);
-extern int copy_context_skas0(unsigned long stack, int pid);
 extern void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs);
 extern void new_thread(void *stack, jmp_buf *buf, void (*handler)(void));
 extern void switch_threads(jmp_buf *me, jmp_buf *you);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 6daffb9d8a8d..a024acd6d85c 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -25,7 +25,6 @@
 #include <linux/threads.h>
 #include <linux/resume_user_mode.h>
 #include <asm/current.h>
-#include <asm/mmu_context.h>
 #include <linux/uaccess.h>
 #include <as-layout.h>
 #include <kern_util.h>
@@ -139,8 +138,6 @@ void new_thread_handler(void)
 /* Called magically, see new_thread_handler above */
 void fork_handler(void)
 {
-	force_flush_all();
-
 	schedule_tail(current->thread.prev_sched);
 
 	/*
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 656fe16c9b63..ac4ca203ac24 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -10,13 +10,13 @@
 
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
+#include <asm/mmu_context.h>
 #include <as-layout.h>
 #include <os.h>
 #include <skas.h>
 
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
- 	struct mm_context *from_mm = NULL;
 	struct mm_context *to_mm = &mm->context;
 	unsigned long stack = 0;
 	int ret = -ENOMEM;
@@ -26,14 +26,13 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		goto out;
 
 	to_mm->id.stack = stack;
-	if (current->mm != NULL && current->mm != &init_mm)
-		from_mm = &current->mm->context;
 
+	/*
+	 * Allocate a completely fresh mm. We'll sync the mappings once
+	 * the rest of the kernel is done, in arch_copy_mm().
+	 */
 	block_signals_trace();
-	if (from_mm)
-		to_mm->id.u.pid = copy_context_skas0(stack,
-						     from_mm->id.u.pid);
-	else to_mm->id.u.pid = start_userspace(stack);
+	to_mm->id.u.pid = start_userspace(stack);
 	unblock_signals_trace();
 
 	if (to_mm->id.u.pid < 0) {
@@ -41,12 +40,9 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		goto out_free;
 	}
 
-	ret = init_new_ldt(to_mm, from_mm);
-	if (ret < 0) {
-		printk(KERN_ERR "init_new_context_skas - init_ldt"
-		       " failed, errno = %d\n", ret);
+	ret = init_new_ldt(to_mm);
+	if (ret)
 		goto out_free;
-	}
 
 	return 0;
 
@@ -57,6 +53,21 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	return ret;
 }
 
+int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
+{
+	int ret = copy_ldt(&mm->context, &oldmm->context);
+
+	if (ret < 0) {
+		printk(KERN_ERR "%s - copy_ldt failed, errno = %d\n",
+		       __func__, ret);
+		return ret;
+	}
+
+	force_flush_all(mm);
+	return 0;
+}
+
+
 void destroy_context(struct mm_struct *mm)
 {
 	struct mm_context *mmu = &mm->context;
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 34ec8e677fb9..7c0161321fd9 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -600,14 +600,11 @@ void flush_tlb_mm(struct mm_struct *mm)
 		fix_range(mm, vma->vm_start, vma->vm_end, 0);
 }
 
-void force_flush_all(void)
+void force_flush_all(struct mm_struct *mm)
 {
-	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	VMA_ITERATOR(vmi, mm, 0);
 
-	mmap_read_lock(mm);
 	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-	mmap_read_unlock(mm);
 }
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index f92129bbf981..403f4c6082b6 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -508,113 +508,6 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 	}
 }
 
-static unsigned long thread_regs[MAX_REG_NR];
-static unsigned long thread_fp_regs[FP_SIZE];
-
-static int __init init_thread_regs(void)
-{
-	get_safe_registers(thread_regs, thread_fp_regs);
-	/* Set parent's instruction pointer to start of clone-stub */
-	thread_regs[REGS_IP_INDEX] = STUB_CODE +
-				(unsigned long) stub_clone_handler -
-				(unsigned long) __syscall_stub_start;
-	thread_regs[REGS_SP_INDEX] = STUB_DATA + STUB_DATA_PAGES * UM_KERN_PAGE_SIZE -
-		sizeof(void *);
-#ifdef __SIGNAL_FRAMESIZE
-	thread_regs[REGS_SP_INDEX] -= __SIGNAL_FRAMESIZE;
-#endif
-	return 0;
-}
-
-__initcall(init_thread_regs);
-
-int copy_context_skas0(unsigned long new_stack, int pid)
-{
-	int err;
-	unsigned long current_stack = current_stub_stack();
-	struct stub_data *data = (struct stub_data *) current_stack;
-	struct stub_data *child_data = (struct stub_data *) new_stack;
-	unsigned long long new_offset;
-	int new_fd = phys_mapping(uml_to_phys((void *)new_stack), &new_offset);
-
-	/*
-	 * prepare offset and fd of child's stack as argument for parent's
-	 * and child's mmap2 calls
-	 */
-	*data = ((struct stub_data) {
-		.offset	= MMAP_OFFSET(new_offset),
-		.fd     = new_fd,
-		.parent_err = -ESRCH,
-		.child_err = 0,
-	});
-
-	*child_data = ((struct stub_data) {
-		.child_err = -ESRCH,
-	});
-
-	err = ptrace_setregs(pid, thread_regs);
-	if (err < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "%s : PTRACE_SETREGS failed, pid = %d, errno = %d\n",
-		      __func__, pid, -err);
-		return err;
-	}
-
-	err = put_fp_registers(pid, thread_fp_regs);
-	if (err < 0) {
-		printk(UM_KERN_ERR "%s : put_fp_registers failed, pid = %d, err = %d\n",
-		       __func__, pid, err);
-		return err;
-	}
-
-	/*
-	 * Wait, until parent has finished its work: read child's pid from
-	 * parent's stack, and check, if bad result.
-	 */
-	err = ptrace(PTRACE_CONT, pid, 0, 0);
-	if (err) {
-		err = -errno;
-		printk(UM_KERN_ERR "Failed to continue new process, pid = %d, errno = %d\n",
-		       pid, errno);
-		return err;
-	}
-
-	wait_stub_done(pid);
-
-	pid = data->parent_err;
-	if (pid < 0) {
-		printk(UM_KERN_ERR "%s - stub-parent reports error %d\n",
-		      __func__, -pid);
-		return pid;
-	}
-
-	/*
-	 * Wait, until child has finished too: read child's result from
-	 * child's stack and check it.
-	 */
-	wait_stub_done(pid);
-	if (child_data->child_err != STUB_DATA) {
-		printk(UM_KERN_ERR "%s - stub-child %d reports error %ld\n",
-		       __func__, pid, data->child_err);
-		err = data->child_err;
-		goto out_kill;
-	}
-
-	if (ptrace(PTRACE_OLDSETOPTIONS, pid, NULL,
-		   (void *)PTRACE_O_TRACESYSGOOD) < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "%s : PTRACE_OLDSETOPTIONS failed, errno = %d\n",
-		       __func__, errno);
-		goto out_kill;
-	}
-
-	return pid;
-
- out_kill:
-	os_kill_ptraced_process(pid, 1);
-	return err;
-}
-
 void new_thread(void *stack, jmp_buf *buf, void (*handler)(void))
 {
 	(*buf)[0].JB_IP = (unsigned long) handler;
diff --git a/arch/x86/um/ldt.c b/arch/x86/um/ldt.c
index 255a44dd415a..609feaeff23b 100644
--- a/arch/x86/um/ldt.c
+++ b/arch/x86/um/ldt.c
@@ -297,36 +297,37 @@ static void ldt_get_host_info(void)
 	free_pages((unsigned long)ldt, order);
 }
 
-long init_new_ldt(struct mm_context *new_mm, struct mm_context *from_mm)
+int init_new_ldt(struct mm_context *new_mm)
 {
-	struct user_desc desc;
+	struct user_desc desc = {};
 	short * num_p;
-	int i;
-	long page, err=0;
+	int err = 0;
 	void *addr = NULL;
 
-
 	mutex_init(&new_mm->arch.ldt.lock);
 
-	if (!from_mm) {
-		memset(&desc, 0, sizeof(desc));
-		/*
-		 * Now we try to retrieve info about the ldt, we
-		 * inherited from the host. All ldt-entries found
-		 * will be reset in the following loop
-		 */
-		ldt_get_host_info();
-		for (num_p=host_ldt_entries; *num_p != -1; num_p++) {
-			desc.entry_number = *num_p;
-			err = write_ldt_entry(&new_mm->id, 1, &desc,
-					      &addr, *(num_p + 1) == -1);
-			if (err)
-				break;
-		}
-		new_mm->arch.ldt.entry_count = 0;
-
-		goto out;
+	memset(&desc, 0, sizeof(desc));
+	/*
+	 * Now we try to retrieve info about the ldt, we
+	 * inherited from the host. All ldt-entries found
+	 * will be reset in the following loop
+	 */
+	ldt_get_host_info();
+	for (num_p=host_ldt_entries; *num_p != -1; num_p++) {
+		desc.entry_number = *num_p;
+		err = write_ldt_entry(&new_mm->id, 1, &desc,
+				      &addr, *(num_p + 1) == -1);
+		if (err)
+			break;
 	}
+	new_mm->arch.ldt.entry_count = 0;
+
+	return err;
+}
+
+int copy_ldt(struct mm_context *new_mm, struct mm_context *from_mm)
+{
+	int err = 0;
 
 	/*
 	 * Our local LDT is used to supply the data for
@@ -339,7 +340,9 @@ long init_new_ldt(struct mm_context *new_mm, struct mm_context *from_mm)
 		memcpy(new_mm->arch.ldt.u.entries, from_mm->arch.ldt.u.entries,
 		       sizeof(new_mm->arch.ldt.u.entries));
 	else {
-		i = from_mm->arch.ldt.entry_count / LDT_ENTRIES_PER_PAGE;
+		int i = from_mm->arch.ldt.entry_count / LDT_ENTRIES_PER_PAGE;
+		unsigned long page;
+
 		while (i-->0) {
 			page = __get_free_page(GFP_KERNEL|__GFP_ZERO);
 			if (!page) {
@@ -355,11 +358,9 @@ long init_new_ldt(struct mm_context *new_mm, struct mm_context *from_mm)
 	new_mm->arch.ldt.entry_count = from_mm->arch.ldt.entry_count;
 	mutex_unlock(&from_mm->arch.ldt.lock);
 
-    out:
 	return err;
 }
 
-
 void free_ldt(struct mm_context *mm)
 {
 	int i;
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
