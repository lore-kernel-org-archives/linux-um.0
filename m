Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DECC3DA45
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1m565hAGyX1Kll+tiLj04V7Z3B/rHsPUkYRfYvq/HQw=; b=RdzvcPRrjZqY4GoPNTHcxkEy+b
	kCVPHn7EDRUgSnU60FRBSF7YEFKEW2ToWIU602WDO06Ao4FDltbIm/n4pfGFYLOUQAQqxRE+hYXVQ
	djLq2Qc0VxjKXQFM2R2RfZPQE2YX9WyGbZrKZsHvEGDbs8s1JSIy2lpUY3cgLPfe9iQpVa2hcuCZn
	AwkgewNvHHU6Jaba0bsvCqzySRTctRmj4hRhZ7ycAIrCQo+ZbcDWS1f0tweMkmjkZ6ynsjt/5atv/
	IMSa6Y8AhEAUInyTApWwV8BBv3eBjiZIFtPJvXF5H/k1vhb6bmgMVoU9DQ24jQEc9IFEkxfRN0pO8
	zFdQqMMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1Ta-0000000Aah3-1USt;
	Wed, 03 Jul 2024 15:00:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0Jn-0000000ALO1-1Aji
	for linux-um@bombadil.infradead.org;
	Wed, 03 Jul 2024 13:46:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1m565hAGyX1Kll+tiLj04V7Z3B/rHsPUkYRfYvq/HQw=; b=F0BiAaN8ivoqiGR3O34jmt87/L
	zy/izMabIn/Rj1JMLOV2kOi+6z7TJQQNx1NiQQ2yB312VyDn/uDJAP0cicQJEbOat7CywUiKp7N03
	9YjStuu3sLLHFeLxnRYamx8vK6rcuokLkRlKm2/BPXEHIpnKs9uCbkqtV/SJmHFXRbhzfVjoSeFl1
	xkpPa//3YgUJ4NGtjZyEM6snB/mtZ7ptopD/0IChchUwCqMWhWK+/fHKasL3GbTUGW+6vLZAN0kt/
	5OjQy/RMEcBjja7HVjWn4ojlBdzXaWkysIJ84oM4/O286UkvoqDu4eyNYjIROFl/9HwczKSeRzfFT
	IeOqwAtQ==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0Jf-0000000A1Jv-0XH7
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 13:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1m565hAGyX1Kll+tiLj04V7Z3B/rHsPUkYRfYvq/HQw=;
	t=1720014394; x=1721223994; b=AzNeGTyrac1c1xQLL4hc1hHnv4VbnJhnukc5sqHR1PtrxzB
	cmmhrPIQmt6QNVwE9u4gh8U9tceDsTDEjNFw9tU7NIc9I5VMUADuwSWwndZin86Yu3dzmByacbMml
	pe/sp54qoubquWVi2+Xxty67ZvTkR5MYbrl4Es5Pg7Bik1tL+yWoSIfKJrFddaLuIfHlyirTpM4Kf
	6ddhHzjUd3C9MAiUvkucz/q/cLZ19+HNE3vVZ0a9VGzpPT1gzqEGog1OFOiTJdjPY1Kh+35zIRxpc
	ex+ZY3N74ClCpmLqrILacbZ6B0j0OgFYM2qCc1Z04fZUDxSrngT5aaU4mKke1zmA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sP0Jc-000000094nb-2CX9;
	Wed, 03 Jul 2024 15:46:32 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4 12/12] um: refactor TLB update handling
Date: Wed,  3 Jul 2024 15:45:36 +0200
Message-ID: <20240703134536.1161108-13-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703134536.1161108-1-benjamin@sipsolutions.net>
References: <20240703134536.1161108-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_144638_172299_630E8111 
X-CRM114-Status: GOOD (  31.21  )
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
 arch/um/drivers/ubd_kern.c         |   2 -
 arch/um/include/asm/mmu.h          |   4 +
 arch/um/include/asm/pgtable.h      |  32 +++++++
 arch/um/include/asm/tlbflush.h     |  46 ++++++++--
 arch/um/include/shared/skas/skas.h |   1 +
 arch/um/kernel/skas/process.c      |  10 +++
 arch/um/kernel/tlb.c               | 130 +++--------------------------
 arch/um/kernel/trap.c              |  15 +++-
 arch/um/os-Linux/skas/process.c    |   2 +
 9 files changed, 110 insertions(+), 132 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 1542a6d6a7a1..c186aa77cda4 100644
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
@@ -770,7 +769,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 			printk(KERN_ERR "Failed to vmalloc COW bitmap\n");
 			goto error;
 		}
-		flush_tlb_kernel_vm();
 
 		err = read_cow_bitmap(ubd_dev->fd, ubd_dev->cow.bitmap,
 				      ubd_dev->cow.bitmap_offset,
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 6e433098d8c3..a3eaca41ff61 100644
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
 
 #endif
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
index 41901a74fccc..5f9c1c5f36e2 100644
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
@@ -58,3 +60,11 @@ struct mm_id *current_mm_id(void)
 
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
index 2ba1865679ae..44c6fc697f3a 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -170,14 +170,16 @@ static inline int update_p4d_range(pgd_t *pgd, unsigned long addr,
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
@@ -191,7 +193,7 @@ static int fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 
 	pgd = pgd_offset(mm, addr);
 	do {
-		next = pgd_addr_end(addr, end_addr);
+		next = pgd_addr_end(addr, mm->context.sync_tlb_range_to);
 		if (!pgd_present(*pgd)) {
 			if (pgd_newpage(*pgd)) {
 				ret = ops.unmap(ops.mm_idp, addr,
@@ -200,87 +202,16 @@ static int fix_range_common(struct mm_struct *mm, unsigned long start_addr,
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
@@ -295,48 +226,11 @@ void flush_tlb_all(void)
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
index 9cb61610147a..f7088345b3fc 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -347,6 +347,8 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 	while (1) {
 		time_travel_print_bc_msg();
 
+		current_mm_sync();
+
 		/* Flush out any pending syscalls */
 		err = syscall_stub_flush(current_mm_id());
 		if (err) {
-- 
2.45.2


