Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF841C531D2
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RPHhwFWgRMxIXmP3e+QqcrRvsL/hDGwhBhkbL7rn424=; b=QmcXOU2UnkgbPK/Hr71LmbT8wE
	91+fUSQCJKNrSmrT7SvRns8wZwufi/4MIV08+/geQSZcNrc3SG9bd9t/FAcQLvaR6gYBhsmKc16wH
	UHvqcEXxKq23+PMeUHPabDwBdNf/N1yqN7y8Ok09nirH6gDRhshVaUCGdq39JaSBpwT6xrsuRs80W
	95Sjzx5MKCBTPw3t9/Y5xxRqf3xWYQ7M53eKa7vxGmnsQFMocHMdRk3i9Uyccjygz77+Pva2YpOHJ
	z4HC0G/ydpyqSrDgdgmEMwRIRpG9j7zhVs6Fc7/U+Ed+MlMifz9bVeP7dSb4z4avpaqCAGldqTz3r
	UgSA51JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmprE-0000000Drvl-2HdF;
	Thu, 23 Jul 2026 09:36:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmpr9-0000000Drmk-2wzW
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 09:36:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RPHhwFWgRMxIXmP3e+QqcrRvsL/hDGwhBhkbL7rn424=;
	t=1784799403; x=1786009003; b=s6A6bdKzFkXNl1ipsJPLzXtIPnkF0f7V7WOFF64t4ZxSEHd
	XpRt8gK3Rs69Ax5ek6x46r8HV3gLS/4Go7sPzdxEf9//MShxueAa3l4KtlWQu/6pRCt9rALDDQ2C9
	gdiP0NZb78fLIQY4zj7h4wXfscabeNOSmyo2nZxGBSMOLz/DEs/NTNP+s9hJ3yi4bQIsip3sFN+p+
	8hoZ1uEmBX2TBO2axit8ebRu+d+1KXbEBNElXlH+sG47kyb+5w1gxK6F8SXONjM+zrYgAyByFBCRP
	LBDpuNyDpwQiZgWiWS5r8tZdHQwFp6yrYFW3TcdYonXmNF4X2+MD0fndZO/5K6Fg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmpr7-0000000Aeqq-0Lwx;
	Thu, 23 Jul 2026 11:36:41 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>,
	liam@infradead.org,
	ljs@kernel.org,
	Ricardo Koller <ricarkol@google.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 06/10] um: further decouple MMU related code
Date: Thu, 23 Jul 2026 11:35:47 +0200
Message-ID: <20260723113633.163686eb0863.Ibb7f37d5645cbd566ae5b74fbb19c54c7327ba68@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723093633.140989-12-johannes@sipsolutions.net>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_023644_124198_B956E27E 
X-CRM114-Status: GOOD (  39.90  )
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

From: Johannes Berg <johannes.berg@intel.com>

Since this approach shares more code with the MMU version
in nommu, further move some code around to be able to use
it in nommu (report_enomem) or be able to replace it (this
applies to mm_id, stack, sync). Also add empty inlines for
the TLB flushing and decouple trap.c code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/tlbflush.h |  20 +++
 arch/um/kernel/Makefile        |   2 +-
 arch/um/kernel/physmem.c       |   7 +
 arch/um/kernel/skas/Makefile   |   3 +-
 arch/um/kernel/skas/mmu.c      |  25 ++++
 arch/um/kernel/skas/process.c  |  26 ----
 arch/um/kernel/tlb.c           |   7 -
 arch/um/kernel/trap-mmu.c      | 238 +++++++++++++++++++++++++++++++++
 arch/um/kernel/trap.c          | 219 ------------------------------
 9 files changed, 293 insertions(+), 254 deletions(-)
 create mode 100644 arch/um/kernel/trap-mmu.c

diff --git a/arch/um/include/asm/tlbflush.h b/arch/um/include/asm/tlbflush.h
index 13a3009942be..f73b568a0859 100644
--- a/arch/um/include/asm/tlbflush.h
+++ b/arch/um/include/asm/tlbflush.h
@@ -30,6 +30,8 @@
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  */
 
+#ifdef CONFIG_MMU
+
 extern int um_tlb_sync(struct mm_struct *mm);
 
 extern void flush_tlb_all(void);
@@ -56,4 +58,22 @@ static inline void flush_tlb_kernel_range(unsigned long start,
 	um_tlb_sync(&init_mm);
 }
 
+#else /* !CONFIG_MMU */
+
+/*
+ * With NOMMU the kernel and userspace share a single host address space,
+ * so there is nothing to synchronise and all TLB flushes are no-ops.
+ */
+static inline int um_tlb_sync(struct mm_struct *mm) { return 0; }
+static inline void flush_tlb_all(void) { }
+static inline void flush_tlb_mm(struct mm_struct *mm) { }
+static inline void flush_tlb_page(struct vm_area_struct *vma,
+				  unsigned long address) { }
+static inline void flush_tlb_range(struct vm_area_struct *vma,
+				   unsigned long start, unsigned long end) { }
+static inline void flush_tlb_kernel_range(unsigned long start,
+					  unsigned long end) { }
+
+#endif /* CONFIG_MMU */
+
 #endif
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index d56fe6d829cc..5cd1bd4b23ac 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -19,7 +19,7 @@ obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	signal.o sysrq.o time.o trap.o \
 	um_arch.o umid.o kmsg_dump.o capflags.o skas/
 obj-y += load_file.o
-obj-$(CONFIG_MMU) += mem-pgtable.o tlb.o
+obj-$(CONFIG_MMU) += mem-pgtable.o tlb.o trap-mmu.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index ae6ca373c261..ae9b8f3144b8 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -110,6 +110,13 @@ int phys_mapping(unsigned long phys, unsigned long long *offset_out)
 }
 EXPORT_SYMBOL(phys_mapping);
 
+void report_enomem(void)
+{
+	printk(KERN_ERR "UML ran out of memory on the host side! "
+			"This can happen due to a memory limitation or "
+			"vm.max_map_count has been reached.\n");
+}
+
 static int __init uml_mem_setup(char *line, int *add)
 {
 	char *retptr;
diff --git a/arch/um/kernel/skas/Makefile b/arch/um/kernel/skas/Makefile
index 3384be42691f..28dd33580abc 100644
--- a/arch/um/kernel/skas/Makefile
+++ b/arch/um/kernel/skas/Makefile
@@ -3,8 +3,9 @@
 # Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
 #
 
-obj-y := stub.o mmu.o process.o syscall.o uaccess.o \
+obj-y := stub.o process.o syscall.o \
 	 stub_exe_embed.o
+obj-$(CONFIG_MMU) += mmu.o uaccess.o
 
 # Stub executable
 
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index b5017096028b..facb88d1e393 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -12,6 +12,7 @@
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
 #include <asm/mmu_context.h>
+#include <asm/tlbflush.h>
 #include <as-layout.h>
 #include <os.h>
 #include <skas.h>
@@ -40,6 +41,30 @@ void exit_turnstile(struct mm_id *mm_id)
 	mutex_unlock(__get_turnstile(mm_id));
 }
 
+unsigned long current_stub_stack(void)
+{
+	if (current->mm == NULL)
+		return 0;
+
+	return current->mm->context.id.stack;
+}
+
+struct mm_id *current_mm_id(void)
+{
+	if (current->mm == NULL)
+		return NULL;
+
+	return &current->mm->context.id;
+}
+
+void current_mm_sync(void)
+{
+	if (current->mm == NULL)
+		return;
+
+	um_tlb_sync(current->mm);
+}
+
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
 	struct mm_id *new_id = &mm->context.id;
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 4a7673b0261a..dcdce50b4595 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -9,8 +9,6 @@
 #include <linux/sched/task.h>
 #include <linux/smp-internal.h>
 
-#include <asm/tlbflush.h>
-
 #include <as-layout.h>
 #include <kern.h>
 #include <os.h>
@@ -42,30 +40,6 @@ int __init start_uml(void)
 				 &init_task.thread.switch_buf);
 }
 
-unsigned long current_stub_stack(void)
-{
-	if (current->mm == NULL)
-		return 0;
-
-	return current->mm->context.id.stack;
-}
-
-struct mm_id *current_mm_id(void)
-{
-	if (current->mm == NULL)
-		return NULL;
-
-	return &current->mm->context.id;
-}
-
-void current_mm_sync(void)
-{
-	if (current->mm == NULL)
-		return;
-
-	um_tlb_sync(current->mm);
-}
-
 static DEFINE_SPINLOCK(initial_jmpbuf_spinlock);
 
 void initial_jmpbuf_lock(void)
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 1f175716b474..012bcc76168d 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -40,13 +40,6 @@ static int kern_unmap(struct mm_id *mm_idp,
 	return os_unmap_memory((void *)virt, len);
 }
 
-void report_enomem(void)
-{
-	printk(KERN_ERR "UML ran out of memory on the host side! "
-			"This can happen due to a memory limitation or "
-			"vm.max_map_count has been reached.\n");
-}
-
 static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 				   unsigned long end,
 				   struct vm_ops *ops)
diff --git a/arch/um/kernel/trap-mmu.c b/arch/um/kernel/trap-mmu.c
new file mode 100644
index 000000000000..a233a61e1801
--- /dev/null
+++ b/arch/um/kernel/trap-mmu.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ */
+
+#include <linux/mm.h>
+#include <linux/sched/signal.h>
+#include <linux/hardirq.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/sched/debug.h>
+#include <asm/current.h>
+#include <asm/tlbflush.h>
+#include <arch.h>
+#include <as-layout.h>
+#include <kern_util.h>
+#include <os.h>
+#include <skas.h>
+
+/*
+ * NOTE: UML does not have exception tables. As such, this is almost a copy
+ * of the code in mm/memory.c, only adjusting the logic to simply check whether
+ * we are coming from the kernel instead of doing an additional lookup in the
+ * exception table.
+ * We can do this simplification because we never get here if the exception was
+ * fixable.
+ */
+static inline bool get_mmap_lock_carefully(struct mm_struct *mm, bool is_user)
+{
+	if (likely(mmap_read_trylock(mm)))
+		return true;
+
+	if (!is_user)
+		return false;
+
+	return !mmap_read_lock_killable(mm);
+}
+
+static inline bool mmap_upgrade_trylock(struct mm_struct *mm)
+{
+	/*
+	 * We don't have this operation yet.
+	 *
+	 * It should be easy enough to do: it's basically a
+	 *    atomic_long_try_cmpxchg_acquire()
+	 * from RWSEM_READER_BIAS -> RWSEM_WRITER_LOCKED, but
+	 * it also needs the proper lockdep magic etc.
+	 */
+	return false;
+}
+
+static inline bool upgrade_mmap_lock_carefully(struct mm_struct *mm, bool is_user)
+{
+	mmap_read_unlock(mm);
+	if (!is_user)
+		return false;
+
+	return !mmap_write_lock_killable(mm);
+}
+
+/*
+ * Helper for page fault handling.
+ *
+ * This is kind of equivalend to "mmap_read_lock()" followed
+ * by "find_extend_vma()", except it's a lot more careful about
+ * the locking (and will drop the lock on failure).
+ *
+ * For example, if we have a kernel bug that causes a page
+ * fault, we don't want to just use mmap_read_lock() to get
+ * the mm lock, because that would deadlock if the bug were
+ * to happen while we're holding the mm lock for writing.
+ *
+ * So this checks the exception tables on kernel faults in
+ * order to only do this all for instructions that are actually
+ * expected to fault.
+ *
+ * We can also actually take the mm lock for writing if we
+ * need to extend the vma, which helps the VM layer a lot.
+ */
+static struct vm_area_struct *
+um_lock_mm_and_find_vma(struct mm_struct *mm,
+			unsigned long addr, bool is_user)
+{
+	struct vm_area_struct *vma;
+
+	if (!get_mmap_lock_carefully(mm, is_user))
+		return NULL;
+
+	vma = find_vma(mm, addr);
+	if (likely(vma && (vma->vm_start <= addr)))
+		return vma;
+
+	/*
+	 * Well, dang. We might still be successful, but only
+	 * if we can extend a vma to do so.
+	 */
+	if (!vma || !(vma->vm_flags & VM_GROWSDOWN)) {
+		mmap_read_unlock(mm);
+		return NULL;
+	}
+
+	/*
+	 * We can try to upgrade the mmap lock atomically,
+	 * in which case we can continue to use the vma
+	 * we already looked up.
+	 *
+	 * Otherwise we'll have to drop the mmap lock and
+	 * re-take it, and also look up the vma again,
+	 * re-checking it.
+	 */
+	if (!mmap_upgrade_trylock(mm)) {
+		if (!upgrade_mmap_lock_carefully(mm, is_user))
+			return NULL;
+
+		vma = find_vma(mm, addr);
+		if (!vma)
+			goto fail;
+		if (vma->vm_start <= addr)
+			goto success;
+		if (!(vma->vm_flags & VM_GROWSDOWN))
+			goto fail;
+	}
+
+	if (expand_stack_locked(vma, addr))
+		goto fail;
+
+success:
+	mmap_write_downgrade(mm);
+	return vma;
+
+fail:
+	mmap_write_unlock(mm);
+	return NULL;
+}
+
+/*
+ * Note this is constrained to return 0, -EFAULT, -EACCES, -ENOMEM by
+ * segv().
+ */
+int handle_page_fault(unsigned long address, unsigned long ip,
+		      int is_write, int is_user, int *code_out)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	pmd_t *pmd;
+	pte_t *pte;
+	int err = -EFAULT;
+	unsigned int flags = FAULT_FLAG_DEFAULT;
+
+	*code_out = SEGV_MAPERR;
+
+	/*
+	 * If the fault was with pagefaults disabled, don't take the fault, just
+	 * fail.
+	 */
+	if (faulthandler_disabled())
+		goto out_nosemaphore;
+
+	if (is_user)
+		flags |= FAULT_FLAG_USER;
+retry:
+	vma = um_lock_mm_and_find_vma(mm, address, is_user);
+	if (!vma)
+		goto out_nosemaphore;
+
+	*code_out = SEGV_ACCERR;
+	if (is_write) {
+		if (!(vma->vm_flags & VM_WRITE))
+			goto out;
+		flags |= FAULT_FLAG_WRITE;
+	} else {
+		/* Don't require VM_READ|VM_EXEC for write faults! */
+		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+			goto out;
+	}
+
+	do {
+		vm_fault_t fault;
+
+		fault = handle_mm_fault(vma, address, flags, NULL);
+
+		if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
+			goto out_nosemaphore;
+
+		/* The fault is fully completed (including releasing mmap lock) */
+		if (fault & VM_FAULT_COMPLETED)
+			return 0;
+
+		if (unlikely(fault & VM_FAULT_ERROR)) {
+			if (fault & VM_FAULT_OOM) {
+				goto out_of_memory;
+			} else if (fault & VM_FAULT_SIGSEGV) {
+				goto out;
+			} else if (fault & VM_FAULT_SIGBUS) {
+				err = -EACCES;
+				goto out;
+			}
+			BUG();
+		}
+		if (fault & VM_FAULT_RETRY) {
+			flags |= FAULT_FLAG_TRIED;
+
+			goto retry;
+		}
+
+		pmd = pmd_off(mm, address);
+		pte = pte_offset_kernel(pmd, address);
+	} while (!pte_present(*pte));
+	err = 0;
+	/*
+	 * The below warning was added in place of
+	 *	pte_mkyoung(); if (is_write) pte_mkdirty();
+	 * If it's triggered, we'd see normally a hang here (a clean pte is
+	 * marked read-only to emulate the dirty bit).
+	 * However, the generic code can mark a PTE writable but clean on a
+	 * concurrent read fault, triggering this harmlessly. So comment it out.
+	 */
+#if 0
+	WARN_ON(!pte_young(*pte) || (is_write && !pte_dirty(*pte)));
+#endif
+
+out:
+	mmap_read_unlock(mm);
+out_nosemaphore:
+	return err;
+
+out_of_memory:
+	/*
+	 * We ran out of memory, call the OOM killer, and return the userspace
+	 * (which will retry the fault, or kill us if we got oom-killed).
+	 */
+	mmap_read_unlock(mm);
+	if (!is_user)
+		goto out_nosemaphore;
+	pagefault_out_of_memory();
+	return 0;
+}
+
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 177615820a4c..ab60bab8d987 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -17,225 +17,6 @@
 #include <os.h>
 #include <skas.h>
 
-/*
- * NOTE: UML does not have exception tables. As such, this is almost a copy
- * of the code in mm/memory.c, only adjusting the logic to simply check whether
- * we are coming from the kernel instead of doing an additional lookup in the
- * exception table.
- * We can do this simplification because we never get here if the exception was
- * fixable.
- */
-static inline bool get_mmap_lock_carefully(struct mm_struct *mm, bool is_user)
-{
-	if (likely(mmap_read_trylock(mm)))
-		return true;
-
-	if (!is_user)
-		return false;
-
-	return !mmap_read_lock_killable(mm);
-}
-
-static inline bool mmap_upgrade_trylock(struct mm_struct *mm)
-{
-	/*
-	 * We don't have this operation yet.
-	 *
-	 * It should be easy enough to do: it's basically a
-	 *    atomic_long_try_cmpxchg_acquire()
-	 * from RWSEM_READER_BIAS -> RWSEM_WRITER_LOCKED, but
-	 * it also needs the proper lockdep magic etc.
-	 */
-	return false;
-}
-
-static inline bool upgrade_mmap_lock_carefully(struct mm_struct *mm, bool is_user)
-{
-	mmap_read_unlock(mm);
-	if (!is_user)
-		return false;
-
-	return !mmap_write_lock_killable(mm);
-}
-
-/*
- * Helper for page fault handling.
- *
- * This is kind of equivalend to "mmap_read_lock()" followed
- * by "find_extend_vma()", except it's a lot more careful about
- * the locking (and will drop the lock on failure).
- *
- * For example, if we have a kernel bug that causes a page
- * fault, we don't want to just use mmap_read_lock() to get
- * the mm lock, because that would deadlock if the bug were
- * to happen while we're holding the mm lock for writing.
- *
- * So this checks the exception tables on kernel faults in
- * order to only do this all for instructions that are actually
- * expected to fault.
- *
- * We can also actually take the mm lock for writing if we
- * need to extend the vma, which helps the VM layer a lot.
- */
-static struct vm_area_struct *
-um_lock_mm_and_find_vma(struct mm_struct *mm,
-			unsigned long addr, bool is_user)
-{
-	struct vm_area_struct *vma;
-
-	if (!get_mmap_lock_carefully(mm, is_user))
-		return NULL;
-
-	vma = find_vma(mm, addr);
-	if (likely(vma && (vma->vm_start <= addr)))
-		return vma;
-
-	/*
-	 * Well, dang. We might still be successful, but only
-	 * if we can extend a vma to do so.
-	 */
-	if (!vma || !(vma->vm_flags & VM_GROWSDOWN)) {
-		mmap_read_unlock(mm);
-		return NULL;
-	}
-
-	/*
-	 * We can try to upgrade the mmap lock atomically,
-	 * in which case we can continue to use the vma
-	 * we already looked up.
-	 *
-	 * Otherwise we'll have to drop the mmap lock and
-	 * re-take it, and also look up the vma again,
-	 * re-checking it.
-	 */
-	if (!mmap_upgrade_trylock(mm)) {
-		if (!upgrade_mmap_lock_carefully(mm, is_user))
-			return NULL;
-
-		vma = find_vma(mm, addr);
-		if (!vma)
-			goto fail;
-		if (vma->vm_start <= addr)
-			goto success;
-		if (!(vma->vm_flags & VM_GROWSDOWN))
-			goto fail;
-	}
-
-	if (expand_stack_locked(vma, addr))
-		goto fail;
-
-success:
-	mmap_write_downgrade(mm);
-	return vma;
-
-fail:
-	mmap_write_unlock(mm);
-	return NULL;
-}
-
-/*
- * Note this is constrained to return 0, -EFAULT, -EACCES, -ENOMEM by
- * segv().
- */
-int handle_page_fault(unsigned long address, unsigned long ip,
-		      int is_write, int is_user, int *code_out)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	pmd_t *pmd;
-	pte_t *pte;
-	int err = -EFAULT;
-	unsigned int flags = FAULT_FLAG_DEFAULT;
-
-	*code_out = SEGV_MAPERR;
-
-	/*
-	 * If the fault was with pagefaults disabled, don't take the fault, just
-	 * fail.
-	 */
-	if (faulthandler_disabled())
-		goto out_nosemaphore;
-
-	if (is_user)
-		flags |= FAULT_FLAG_USER;
-retry:
-	vma = um_lock_mm_and_find_vma(mm, address, is_user);
-	if (!vma)
-		goto out_nosemaphore;
-
-	*code_out = SEGV_ACCERR;
-	if (is_write) {
-		if (!(vma->vm_flags & VM_WRITE))
-			goto out;
-		flags |= FAULT_FLAG_WRITE;
-	} else {
-		/* Don't require VM_READ|VM_EXEC for write faults! */
-		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
-			goto out;
-	}
-
-	do {
-		vm_fault_t fault;
-
-		fault = handle_mm_fault(vma, address, flags, NULL);
-
-		if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
-			goto out_nosemaphore;
-
-		/* The fault is fully completed (including releasing mmap lock) */
-		if (fault & VM_FAULT_COMPLETED)
-			return 0;
-
-		if (unlikely(fault & VM_FAULT_ERROR)) {
-			if (fault & VM_FAULT_OOM) {
-				goto out_of_memory;
-			} else if (fault & VM_FAULT_SIGSEGV) {
-				goto out;
-			} else if (fault & VM_FAULT_SIGBUS) {
-				err = -EACCES;
-				goto out;
-			}
-			BUG();
-		}
-		if (fault & VM_FAULT_RETRY) {
-			flags |= FAULT_FLAG_TRIED;
-
-			goto retry;
-		}
-
-		pmd = pmd_off(mm, address);
-		pte = pte_offset_kernel(pmd, address);
-	} while (!pte_present(*pte));
-	err = 0;
-	/*
-	 * The below warning was added in place of
-	 *	pte_mkyoung(); if (is_write) pte_mkdirty();
-	 * If it's triggered, we'd see normally a hang here (a clean pte is
-	 * marked read-only to emulate the dirty bit).
-	 * However, the generic code can mark a PTE writable but clean on a
-	 * concurrent read fault, triggering this harmlessly. So comment it out.
-	 */
-#if 0
-	WARN_ON(!pte_young(*pte) || (is_write && !pte_dirty(*pte)));
-#endif
-
-out:
-	mmap_read_unlock(mm);
-out_nosemaphore:
-	return err;
-
-out_of_memory:
-	/*
-	 * We ran out of memory, call the OOM killer, and return the userspace
-	 * (which will retry the fault, or kill us if we got oom-killed).
-	 */
-	mmap_read_unlock(mm);
-	if (!is_user)
-		goto out_nosemaphore;
-	pagefault_out_of_memory();
-	return 0;
-}
-
 static void show_segv_info(struct uml_pt_regs *regs)
 {
 	struct task_struct *tsk = current;
-- 
2.53.0


