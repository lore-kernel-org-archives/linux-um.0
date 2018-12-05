Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUWRM-0007oD-0K
 for linux-um@lists.infradead.org; Wed, 05 Dec 2018 12:38:12 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH 1/3] um: Optimize TLB operations v2
Date: Wed,  5 Dec 2018 12:37:39 +0000
Message-Id: <20181205123741.15456-1-anton.ivanov@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Make the code to merge mmap/munmap/mprotect operations in tlb.c
common for userspace and kernel. Kernel tlb operations can now
be merged as well.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/kernel/tlb.c | 85 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 37508b190106..b7f7a60a0928 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -37,17 +37,19 @@ struct host_vm_change {
 			} mprotect;
 		} u;
 	} ops[1];
+	int userspace;
 	int index;
-	struct mm_id *id;
+	struct mm_struct *mm;
 	void *data;
 	int force;
 };
 
-#define INIT_HVC(mm, force) \
+#define INIT_HVC(mm, force, userspace) \
 	((struct host_vm_change) \
 	 { .ops		= { { .type = NONE } },	\
-	   .id		= &mm->context.id, \
+	   .mm		= mm, \
        	   .data	= NULL, \
+	   .userspace	= userspace, \
 	   .index	= 0, \
 	   .force	= force })
 
@@ -68,18 +70,40 @@ static int do_ops(struct host_vm_change *hvc, int end,
 		op = &hvc->ops[i];
 		switch (op->type) {
 		case MMAP:
-			ret = map(hvc->id, op->u.mmap.addr, op->u.mmap.len,
-				  op->u.mmap.prot, op->u.mmap.fd,
-				  op->u.mmap.offset, finished, &hvc->data);
+			if (hvc->userspace)
+				ret = map(&hvc->mm->context.id, op->u.mmap.addr,
+					  op->u.mmap.len, op->u.mmap.prot,
+					  op->u.mmap.fd,
+					  op->u.mmap.offset, finished,
+					  &hvc->data);
+			else
+				map_memory(op->u.mmap.addr, op->u.mmap.offset,
+					   op->u.mmap.len, 1, 1, 1);
 			break;
 		case MUNMAP:
-			ret = unmap(hvc->id, op->u.munmap.addr,
-				    op->u.munmap.len, finished, &hvc->data);
+			if (hvc->userspace)
+				ret = unmap(&hvc->mm->context.id,
+					    op->u.munmap.addr,
+					    op->u.munmap.len, finished,
+					    &hvc->data);
+			else
+				ret = os_unmap_memory(
+					(void *) op->u.munmap.addr,
+						      op->u.munmap.len);
+
 			break;
 		case MPROTECT:
-			ret = protect(hvc->id, op->u.mprotect.addr,
-				      op->u.mprotect.len, op->u.mprotect.prot,
-				      finished, &hvc->data);
+			if (hvc->userspace)
+				ret = protect(&hvc->mm->context.id,
+					      op->u.mprotect.addr,
+					      op->u.mprotect.len,
+					      op->u.mprotect.prot,
+					      finished, &hvc->data);
+			else
+				ret = os_protect_memory(
+					(void *) op->u.mprotect.addr,
+							op->u.mprotect.len,
+							1, 1, 1);
 			break;
 		default:
 			printk(KERN_ERR "Unknown op type %d in do_ops\n",
@@ -100,9 +124,12 @@ static int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
 {
 	__u64 offset;
 	struct host_vm_op *last;
-	int fd, ret = 0;
+	int fd = -1, ret = 0;
 
-	fd = phys_mapping(phys, &offset);
+	if (hvc->userspace)
+		fd = phys_mapping(phys, &offset);
+	else
+		offset = phys;
 	if (hvc->index != 0) {
 		last = &hvc->ops[hvc->index - 1];
 		if ((last->type == MMAP) &&
@@ -277,9 +304,9 @@ void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 	pgd_t *pgd;
 	struct host_vm_change hvc;
 	unsigned long addr = start_addr, next;
-	int ret = 0;
+	int ret = 0, userspace = 1;
 
-	hvc = INIT_HVC(mm, force);
+	hvc = INIT_HVC(mm, force, userspace);
 	pgd = pgd_offset(mm, addr);
 	do {
 		next = pgd_addr_end(addr, end_addr);
@@ -314,9 +341,11 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long addr, last;
-	int updated = 0, err;
+	int updated = 0, err = 0, force = 0, userspace = 0;
+	struct host_vm_change hvc;
 
 	mm = &init_mm;
+	hvc = INIT_HVC(mm, force, userspace);
 	for (addr = start; addr < end;) {
 		pgd = pgd_offset(mm, addr);
 		if (!pgd_present(*pgd)) {
@@ -325,8 +354,7 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 				last = end;
 			if (pgd_newpage(*pgd)) {
 				updated = 1;
-				err = os_unmap_memory((void *) addr,
-						      last - addr);
+				err = add_munmap(addr, last - addr, &hvc);
 				if (err < 0)
 					panic("munmap failed, errno = %d\n",
 					      -err);
@@ -342,8 +370,7 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 				last = end;
 			if (pud_newpage(*pud)) {
 				updated = 1;
-				err = os_unmap_memory((void *) addr,
-						      last - addr);
+				err = add_munmap(addr, last - addr, &hvc);
 				if (err < 0)
 					panic("munmap failed, errno = %d\n",
 					      -err);
@@ -359,8 +386,7 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 				last = end;
 			if (pmd_newpage(*pmd)) {
 				updated = 1;
-				err = os_unmap_memory((void *) addr,
-						      last - addr);
+				err = add_munmap(addr, last - addr, &hvc);
 				if (err < 0)
 					panic("munmap failed, errno = %d\n",
 					      -err);
@@ -372,22 +398,25 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 		pte = pte_offset_kernel(pmd, addr);
 		if (!pte_present(*pte) || pte_newpage(*pte)) {
 			updated = 1;
-			err = os_unmap_memory((void *) addr,
-					      PAGE_SIZE);
+			err = add_munmap(addr, PAGE_SIZE, &hvc);
 			if (err < 0)
 				panic("munmap failed, errno = %d\n",
 				      -err);
 			if (pte_present(*pte))
-				map_memory(addr,
-					   pte_val(*pte) & PAGE_MASK,
-					   PAGE_SIZE, 1, 1, 1);
+				err = add_mmap(addr, pte_val(*pte) & PAGE_MASK,
+					       PAGE_SIZE, 0, &hvc);
 		}
 		else if (pte_newprot(*pte)) {
 			updated = 1;
-			os_protect_memory((void *) addr, PAGE_SIZE, 1, 1, 1);
+			err = add_mprotect(addr, PAGE_SIZE, 0, &hvc);
 		}
 		addr += PAGE_SIZE;
 	}
+	if (!err)
+		err = do_ops(&hvc, hvc.index, 1);
+
+	if (err < 0)
+		panic("flush_tlb_kernel failed, errno = %d\n", err);
 	return updated;
 }
 
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

