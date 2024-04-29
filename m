Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C464C25B10
	for <linux-um@archiver.kernel.org>; Mon, 29 Apr 2024 13:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V2lCcR73yjw2bcoLWiyk3sjlmol2x2DaGhbD9hvT5rE=; b=nKtmHQbzB6S4jweJDa4MY4tBe+
	lU+c1eBOTpvIx5L2mRJetrd864tDVzFz2vrT6FyYCHCJ5U2kKqT3xFn1lgo15Rj4I4rpyyQxhgBI+
	Y+EUOv79RsK5DF+MaknhlwM8Q/JoDnNK3pCBECvw6hrTKJ18VlVTlqsD4tPVUDeuK0Op9NZg4PrI+
	/goTJDLmVnAqV5jEfPjrs5XB0P0YcAGBbbQm2cCwlgwUvkaucMIP/IoQ+lVotPSsyf1nBKtChQuXz
	wbDJfcRjja5YzSHjmazpuhXIste0z3epIsCjRgsurSvSsKsnwY6UIen4GopO3hS+kkIowqgoMUuNJ
	thLwaFjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1RNA-000000030Bi-0dcM;
	Mon, 29 Apr 2024 13:48:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1RMy-0000000300y-0sKW
	for linux-um@lists.infradead.org;
	Mon, 29 Apr 2024 13:48:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=V2lCcR73yjw2bcoLWiyk3sjlmol2x2DaGhbD9hvT5rE=;
	t=1714398515; x=1715608115; b=Gc6+2KGiYLeRCX4o4yQFOXMhQaaUoYcuEASB29rz54M0cdj
	FLfa02WGMoazbJ/BUS7OqIV+RJynfeHUfT9M2uJf8LJGpdXf6jHGcOi42rrDk38w9rBcQSeR5OreQ
	CIq7RPvvIVSIUoedU+Q269C9Exguco3obZhqhhCjuEaBVtYZx2zPd/oHSD8keTh4+qpFJOIosJsRi
	s4/WcpTsS7VJHKDehlOT3EL7mI0i9xYgw505NYdAXgwswfszrhCTB9PP0abQkETjPYP2qEh0a40fE
	goirDUGpdOdA7H8AQxDS+NcaFQRQ9JXGP6fh+aa3coelksnMAquCP+Zw4GqowDJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1s1RMv-0000000CW0d-1OWX;
	Mon, 29 Apr 2024 15:48:33 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 12/12] um: refactor TLB update handling
Date: Mon, 29 Apr 2024 15:47:59 +0200
Message-ID: <20240429134759.244517-13-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429134759.244517-1-benjamin@sipsolutions.net>
References: <20240429134759.244517-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_064836_830758_454BDA27 
X-CRM114-Status: GOOD (  31.71  )
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

Conceptually, we want the memory mappings to always be up to date and
represent whatever is in the TLB. To ensure that, we need to sync them
over in the userspace case and for the kernel we need to process the
mappings.

The kernel will call flush_tlb_* if page table entries that were valid
before become invalid. Unfortunately, this is not the case if entries
are added.

As such, change both flush_tlb_* and set_ptes to track the memory range
that has to be synchronized. For the kernel, we need to execute a
flush_tlb_kern_* immediately but we can wait for the first page fault in
case of set_ptes. For userspace in contrast we only store that a range
of memory needs to be synced and do so whenever we switch to that
process.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v2:
- Address review comments from Tiwei Bie
---
 arch/um/drivers/ubd_kern.c         |   2 -
 arch/um/include/asm/mmu.h          |   4 +
 arch/um/include/asm/pgtable.h      |  32 +++++++
 arch/um/include/asm/tlbflush.h     |  46 ++++++++--
 arch/um/include/shared/skas/skas.h |   1 +
 arch/um/kernel/skas/process.c      |  10 +++
 arch/um/kernel/tlb.c               | 136 +++--------------------------
 arch/um/kernel/trap.c              |  15 +++-
 arch/um/os-Linux/skas/process.c    |   2 +
 9 files changed, 110 insertions(+), 138 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 63fc062add70..ee8667745d11 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -36,7 +36,6 @@
 #include <linux/vmalloc.h>
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
-#include <asm/tlbflush.h>
 #include <kern_util.h>
 #include "mconsole_kern.h"
 #include <init.h>
@@ -771,7 +770,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 			printk(KERN_ERR "Failed to vmalloc COW bitmap\n");
 			goto error;
 		}
-		flush_tlb_kernel_vm();
 
 		err = read_cow_bitmap(ubd_dev->fd, ubd_dev->cow.bitmap,
 				      ubd_dev->cow.bitmap_offset,
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 37eb6e89e79a..4d4e763cc289 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -10,6 +10,10 @@
 
 typedef struct mm_context {
 	struct mm_id id;
+
+	/* Address range in need of a TLB sync */
+	unsigned long sync_tlb_range_from;
+	unsigned long sync_tlb_range_to;
 } mm_context_t;
 
 extern void __switch_mm(struct mm_id * mm_idp);
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index e1ece21dbe3f..5bb397b65efb 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -244,6 +244,38 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
 
 #define PFN_PTE_SHIFT		PAGE_SHIFT
 
+static inline void um_tlb_mark_sync(struct mm_struct *mm, unsigned long start,
+				    unsigned long end)
+{
+	if (!mm->context.sync_tlb_range_to) {
+		mm->context.sync_tlb_range_from = start;
+		mm->context.sync_tlb_range_to = end;
+	} else {
+		if (start < mm->context.sync_tlb_range_from)
+			mm->context.sync_tlb_range_from = start;
+		if (end > mm->context.sync_tlb_range_to)
+			mm->context.sync_tlb_range_to = end;
+	}
+}
+
+#define set_ptes set_ptes
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+			    pte_t *ptep, pte_t pte, int nr)
+{
+	/* Basically the default implementation */
+	size_t length = nr * PAGE_SIZE;
+
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte = __pte(pte_val(pte) + (nr << PFN_PTE_SHIFT));
+	}
+
+	um_tlb_mark_sync(mm, addr, addr + length);
+}
+
 #define __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
 {
diff --git a/arch/um/include/asm/tlbflush.h b/arch/um/include/asm/tlbflush.h
index a5bda890390d..db997976b6ea 100644
--- a/arch/um/include/asm/tlbflush.h
+++ b/arch/um/include/asm/tlbflush.h
@@ -9,23 +9,51 @@
 #include <linux/mm.h>
 
 /*
- * TLB flushing:
+ * In UML, we need to sync the TLB over by using mmap/munmap/mprotect syscalls
+ * from the process handling the MM (which can be the kernel itself).
+ *
+ * To track updates, we can hook into set_ptes and flush_tlb_*. With set_ptes
+ * we catch all PTE transitions where memory that was unusable becomes usable.
+ * While with flush_tlb_* we can track any memory that becomes unusable and
+ * even if a higher layer of the page table was modified.
+ *
+ * So, we simply track updates using both methods and mark the memory area to
+ * be synced later on. The only special case is that flush_tlb_kern_* needs to
+ * be executed immediately as there is no good synchronization point in that
+ * case. In contrast, in the set_ptes case we can wait for the next kernel
+ * segfault before we do the synchornization.
  *
- *  - flush_tlb() flushes the current mm struct TLBs
  *  - flush_tlb_all() flushes all processes TLBs
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - flush_tlb_kernel_vm() flushes the kernel vm area
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
  */
 
+extern int um_tlb_sync(struct mm_struct *mm);
+
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, 
-			    unsigned long end);
-extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long address);
-extern void flush_tlb_kernel_vm(void);
-extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
-extern void __flush_tlb_one(unsigned long addr);
+
+static inline void flush_tlb_page(struct vm_area_struct *vma,
+				  unsigned long address)
+{
+	um_tlb_mark_sync(vma->vm_mm, address, address + PAGE_SIZE);
+}
+
+static inline void flush_tlb_range(struct vm_area_struct *vma,
+				   unsigned long start, unsigned long end)
+{
+	um_tlb_mark_sync(vma->vm_mm, start, end);
+}
+
+static inline void flush_tlb_kernel_range(unsigned long start,
+					  unsigned long end)
+{
+	um_tlb_mark_sync(&init_mm, start, end);
+
+	/* Kernel needs to be synced immediately */
+	um_tlb_sync(&init_mm);
+}
 
 #endif
diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index 5c78b0cc3dd4..ebaa116de30b 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -16,5 +16,6 @@ extern void handle_syscall(struct uml_pt_regs *regs);
 extern long execute_syscall_skas(void *r);
 extern unsigned long current_stub_stack(void);
 extern struct mm_id *current_mm_id(void);
+extern void current_mm_sync(void);
 
 #endif
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index c7345c83e07b..26c12db3eca9 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -8,6 +8,8 @@
 #include <linux/sched/task_stack.h>
 #include <linux/sched/task.h>
 
+#include <asm/tlbflush.h>
+
 #include <as-layout.h>
 #include <kern.h>
 #include <os.h>
@@ -61,3 +63,11 @@ struct mm_id *current_mm_id(void)
 
 	return &current->mm->context.id;
 }
+
+void current_mm_sync(void)
+{
+	if (current->mm == NULL)
+		return;
+
+	um_tlb_sync(current->mm);
+}
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index c137ff6f84dd..232aa7601d5d 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -169,14 +169,16 @@ static inline int update_p4d_range(pgd_t *pgd, unsigned long addr,
 	return ret;
 }
 
-static int fix_range_common(struct mm_struct *mm, unsigned long start_addr,
-			     unsigned long end_addr)
+int um_tlb_sync(struct mm_struct *mm)
 {
 	pgd_t *pgd;
 	struct vm_ops ops;
-	unsigned long addr = start_addr, next;
+	unsigned long addr = mm->context.sync_tlb_range_from, next;
 	int ret = 0;
 
+	if (mm->context.sync_tlb_range_to == 0)
+		return 0;
+
 	ops.mm_idp = &mm->context.id;
 	if (mm == &init_mm) {
 		ops.mmap = kern_map;
@@ -190,7 +192,7 @@ static int fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 
 	pgd = pgd_offset(mm, addr);
 	do {
-		next = pgd_addr_end(addr, end_addr);
+		next = pgd_addr_end(addr, mm->context.sync_tlb_range_to);
 		if (!pgd_present(*pgd)) {
 			if (pgd_newpage(*pgd)) {
 				ret = ops.unmap(ops.mm_idp, addr,
@@ -199,87 +201,16 @@ static int fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 			}
 		} else
 			ret = update_p4d_range(pgd, addr, next, &ops);
-	} while (pgd++, addr = next, ((addr < end_addr) && !ret));
+	} while (pgd++, addr = next,
+		 ((addr < mm->context.sync_tlb_range_to) && !ret));
 
 	if (ret == -ENOMEM)
 		report_enomem();
 
-	return ret;
-}
-
-static void flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
-{
-	int err;
-
-	err = fix_range_common(&init_mm, start, end);
-
-	if (err)
-		panic("flush_tlb_kernel failed, errno = %d\n", err);
-}
-
-void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	struct mm_struct *mm = vma->vm_mm;
-	int r, w, x, prot;
-	struct mm_id *mm_id;
-
-	address &= PAGE_MASK;
-
-	pgd = pgd_offset(mm, address);
-	if (!pgd_present(*pgd))
-		goto kill;
-
-	p4d = p4d_offset(pgd, address);
-	if (!p4d_present(*p4d))
-		goto kill;
-
-	pud = pud_offset(p4d, address);
-	if (!pud_present(*pud))
-		goto kill;
-
-	pmd = pmd_offset(pud, address);
-	if (!pmd_present(*pmd))
-		goto kill;
-
-	pte = pte_offset_kernel(pmd, address);
-
-	r = pte_read(*pte);
-	w = pte_write(*pte);
-	x = pte_exec(*pte);
-	if (!pte_young(*pte)) {
-		r = 0;
-		w = 0;
-	} else if (!pte_dirty(*pte)) {
-		w = 0;
-	}
-
-	mm_id = &mm->context.id;
-	prot = ((r ? UM_PROT_READ : 0) | (w ? UM_PROT_WRITE : 0) |
-		(x ? UM_PROT_EXEC : 0));
-	if (pte_newpage(*pte)) {
-		if (pte_present(*pte)) {
-			unsigned long long offset;
-			int fd;
-
-			fd = phys_mapping(pte_val(*pte) & PAGE_MASK, &offset);
-			map(mm_id, address, PAGE_SIZE, prot, fd, offset);
-		} else
-			unmap(mm_id, address, PAGE_SIZE);
-	} else if (pte_newprot(*pte))
-		protect(mm_id, address, PAGE_SIZE, prot);
-
-	*pte = pte_mkuptodate(*pte);
+	mm->context.sync_tlb_range_from = 0;
+	mm->context.sync_tlb_range_to = 0;
 
-	return;
-
-kill:
-	printk(KERN_ERR "Failed to flush page for address 0x%lx\n", address);
-	force_sig(SIGKILL);
+	return ret;
 }
 
 void flush_tlb_all(void)
@@ -294,54 +225,11 @@ void flush_tlb_all(void)
 	flush_tlb_mm(current->mm);
 }
 
-void flush_tlb_kernel_range(unsigned long start, unsigned long end)
-{
-	flush_tlb_kernel_range_common(start, end);
-}
-
-void flush_tlb_kernel_vm(void)
-{
-	flush_tlb_kernel_range_common(start_vm, end_vm);
-}
-
-void __flush_tlb_one(unsigned long addr)
-{
-	flush_tlb_kernel_range_common(addr, addr + PAGE_SIZE);
-}
-
-static void fix_range(struct mm_struct *mm, unsigned long start_addr,
-		      unsigned long end_addr)
-{
-	/*
-	 * Don't bother flushing if this address space is about to be
-	 * destroyed.
-	 */
-	if (atomic_read(&mm->mm_users) == 0)
-		return;
-
-	fix_range_common(mm, start_addr, end_addr);
-}
-
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-		     unsigned long end)
-{
-	if (vma->vm_mm == NULL)
-		flush_tlb_kernel_range_common(start, end);
-	else fix_range(vma->vm_mm, start, end);
-}
-EXPORT_SYMBOL(flush_tlb_range);
-
-void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-			unsigned long end)
-{
-	fix_range(mm, start, end);
-}
-
 void flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	VMA_ITERATOR(vmi, mm, 0);
 
 	for_each_vma(vmi, vma)
-		fix_range(mm, vma->vm_start, vma->vm_end);
+		um_tlb_mark_sync(mm, vma->vm_start, vma->vm_end);
 }
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 6d8ae86ae978..97c8df9c4401 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -113,7 +113,7 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 #if 0
 	WARN_ON(!pte_young(*pte) || (is_write && !pte_dirty(*pte)));
 #endif
-	flush_tlb_page(vma, address);
+
 out:
 	mmap_read_unlock(mm);
 out_nosemaphore:
@@ -210,8 +210,17 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 	if (!is_user && regs)
 		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
 
-	if (!is_user && (address >= start_vm) && (address < end_vm)) {
-		flush_tlb_kernel_vm();
+	if (!is_user && init_mm.context.sync_tlb_range_to) {
+		/*
+		 * Kernel has pending updates from set_ptes that were not
+		 * flushed yet. Syncing them should fix the pagefault (if not
+		 * we'll get here again and panic).
+		 */
+		err = um_tlb_sync(&init_mm);
+		if (err == -ENOMEM)
+			report_enomem();
+		if (err)
+			panic("Failed to sync kernel TLBs: %d", err);
 		goto out;
 	}
 	else if (current->mm == NULL) {
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 8dca42627f39..06e23cf870e2 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -343,6 +343,8 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 	interrupt_end();
 
 	while (1) {
+		current_mm_sync();
+
 		/* Flush out any pending syscalls */
 		err = syscall_stub_flush(current_mm_id());
 		if (err) {
-- 
2.44.0


