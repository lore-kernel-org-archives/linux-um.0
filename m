Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g8721-0005dL-Hd
 for linux-um@lists.infradead.org; Thu, 04 Oct 2018 17:03:24 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v2] Optimise TLB flush for kernel mm in UML
Date: Thu,  4 Oct 2018 18:02:57 +0100
Message-Id: <20181004170257.4823-1-anton.ivanov@cambridgegreys.com>
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
Cc: richard.weinberger@gmail.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

This patch introduces bulking up memory ranges to be passed to
mmap/munmap/mprotect instead of doing everything one page at a time.

This is already being done for the userspace UML portion, this
adds a simplified version of it for the kernel mm.

This results in speed up of up to 10%+ in some areas (sequential
disk read measured with dd, etc).

Add further speed-up by removing a mandatory tlb force flush
for swapless kernel.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/kernel/tlb.c | 201 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 148 insertions(+), 53 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 37508b190106..6516a34fbd7d 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -15,9 +15,15 @@
 #include <skas.h>
 #include <kern_util.h>
 
+#ifdef CONFIG_SWAP
+#define FORK_MM_FORCE 1
+#elif
+#define FORK_MM_FORCE 0
+#endif
+
 struct host_vm_change {
 	struct host_vm_op {
-		enum { NONE, MMAP, MUNMAP, MPROTECT } type;
+		enum { HOST_NONE, HOST_MMAP, HOST_MUNMAP, HOST_MPROTECT } type;
 		union {
 			struct {
 				unsigned long addr;
@@ -43,14 +49,34 @@ struct host_vm_change {
 	int force;
 };
 
+struct kernel_vm_change {
+	struct {
+		unsigned long phys;
+		unsigned long virt;
+		unsigned long len;
+		unsigned int active;
+	} mmap;
+	struct {
+		unsigned long addr;
+		unsigned long len;
+		unsigned int active;
+	} munmap;
+	struct {
+		unsigned long addr;
+		unsigned long len;
+		unsigned int active;
+	} mprotect;
+};
+
 #define INIT_HVC(mm, force) \
 	((struct host_vm_change) \
-	 { .ops		= { { .type = NONE } },	\
+	 { .ops		= { { .type = HOST_NONE } },	\
 	   .id		= &mm->context.id, \
        	   .data	= NULL, \
 	   .index	= 0, \
 	   .force	= force })
 
+
 static void report_enomem(void)
 {
 	printk(KERN_ERR "UML ran out of memory on the host side! "
@@ -58,7 +84,7 @@ static void report_enomem(void)
 			"vm.max_map_count has been reached.\n");
 }
 
-static int do_ops(struct host_vm_change *hvc, int end,
+static int do_host_ops(struct host_vm_change *hvc, int end,
 		  int finished)
 {
 	struct host_vm_op *op;
@@ -67,22 +93,22 @@ static int do_ops(struct host_vm_change *hvc, int end,
 	for (i = 0; i < end && !ret; i++) {
 		op = &hvc->ops[i];
 		switch (op->type) {
-		case MMAP:
+		case HOST_MMAP:
 			ret = map(hvc->id, op->u.mmap.addr, op->u.mmap.len,
 				  op->u.mmap.prot, op->u.mmap.fd,
 				  op->u.mmap.offset, finished, &hvc->data);
 			break;
-		case MUNMAP:
+		case HOST_MUNMAP:
 			ret = unmap(hvc->id, op->u.munmap.addr,
 				    op->u.munmap.len, finished, &hvc->data);
 			break;
-		case MPROTECT:
+		case HOST_MPROTECT:
 			ret = protect(hvc->id, op->u.mprotect.addr,
 				      op->u.mprotect.len, op->u.mprotect.prot,
 				      finished, &hvc->data);
 			break;
 		default:
-			printk(KERN_ERR "Unknown op type %d in do_ops\n",
+			printk(KERN_ERR "Unknown op type %d in do_host_ops\n",
 			       op->type);
 			BUG();
 			break;
@@ -95,8 +121,32 @@ static int do_ops(struct host_vm_change *hvc, int end,
 	return ret;
 }
 
-static int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
-		    unsigned int prot, struct host_vm_change *hvc)
+static void do_kern_ops(struct kernel_vm_change *kvc)
+{
+	int err = 0;
+
+	if (kvc->munmap.active) {
+		err = os_unmap_memory((void *) kvc->munmap.addr,
+			kvc->munmap.len);
+		kvc->munmap.active = 0;
+		if (err < 0)
+			panic("munmap failed, errno = %d\n", -err);
+	}
+	if (kvc->mmap.active) {
+		map_memory(kvc->mmap.virt,
+			kvc->mmap.phys, kvc->mmap.len, 1, 1, 1);
+		kvc->mmap.active = 0;
+	}
+	if (kvc->mprotect.active) {
+		os_protect_memory((void *) kvc->mprotect.addr,
+			kvc->mprotect.len, 1, 1, 1);
+		kvc->mprotect.active = 0;
+	}
+}
+
+
+static int add_host_mmap(unsigned long virt, unsigned long phys,
+	unsigned long len, unsigned int prot, struct host_vm_change *hvc)
 {
 	__u64 offset;
 	struct host_vm_op *last;
@@ -105,7 +155,7 @@ static int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
 	fd = phys_mapping(phys, &offset);
 	if (hvc->index != 0) {
 		last = &hvc->ops[hvc->index - 1];
-		if ((last->type == MMAP) &&
+		if ((last->type == HOST_MMAP) &&
 		   (last->u.mmap.addr + last->u.mmap.len == virt) &&
 		   (last->u.mmap.prot == prot) && (last->u.mmap.fd == fd) &&
 		   (last->u.mmap.offset + last->u.mmap.len == offset)) {
@@ -115,12 +165,12 @@ static int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
 	}
 
 	if (hvc->index == ARRAY_SIZE(hvc->ops)) {
-		ret = do_ops(hvc, ARRAY_SIZE(hvc->ops), 0);
+		ret = do_host_ops(hvc, ARRAY_SIZE(hvc->ops), 0);
 		hvc->index = 0;
 	}
 
 	hvc->ops[hvc->index++] = ((struct host_vm_op)
-				  { .type	= MMAP,
+				  { .type	= HOST_MMAP,
 				    .u = { .mmap = { .addr	= virt,
 						     .len	= len,
 						     .prot	= prot,
@@ -130,7 +180,7 @@ static int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
 	return ret;
 }
 
-static int add_munmap(unsigned long addr, unsigned long len,
+static int add_host_munmap(unsigned long addr, unsigned long len,
 		      struct host_vm_change *hvc)
 {
 	struct host_vm_op *last;
@@ -141,7 +191,7 @@ static int add_munmap(unsigned long addr, unsigned long len,
 
 	if (hvc->index != 0) {
 		last = &hvc->ops[hvc->index - 1];
-		if ((last->type == MUNMAP) &&
+		if ((last->type == HOST_MUNMAP) &&
 		   (last->u.munmap.addr + last->u.mmap.len == addr)) {
 			last->u.munmap.len += len;
 			return 0;
@@ -149,18 +199,18 @@ static int add_munmap(unsigned long addr, unsigned long len,
 	}
 
 	if (hvc->index == ARRAY_SIZE(hvc->ops)) {
-		ret = do_ops(hvc, ARRAY_SIZE(hvc->ops), 0);
+		ret = do_host_ops(hvc, ARRAY_SIZE(hvc->ops), 0);
 		hvc->index = 0;
 	}
 
 	hvc->ops[hvc->index++] = ((struct host_vm_op)
-				  { .type	= MUNMAP,
+				  { .type	= HOST_MUNMAP,
 			     	    .u = { .munmap = { .addr	= addr,
 						       .len	= len } } });
 	return ret;
 }
 
-static int add_mprotect(unsigned long addr, unsigned long len,
+static int add_host_mprotect(unsigned long addr, unsigned long len,
 			unsigned int prot, struct host_vm_change *hvc)
 {
 	struct host_vm_op *last;
@@ -168,7 +218,7 @@ static int add_mprotect(unsigned long addr, unsigned long len,
 
 	if (hvc->index != 0) {
 		last = &hvc->ops[hvc->index - 1];
-		if ((last->type == MPROTECT) &&
+		if ((last->type == HOST_MPROTECT) &&
 		   (last->u.mprotect.addr + last->u.mprotect.len == addr) &&
 		   (last->u.mprotect.prot == prot)) {
 			last->u.mprotect.len += len;
@@ -177,12 +227,12 @@ static int add_mprotect(unsigned long addr, unsigned long len,
 	}
 
 	if (hvc->index == ARRAY_SIZE(hvc->ops)) {
-		ret = do_ops(hvc, ARRAY_SIZE(hvc->ops), 0);
+		ret = do_host_ops(hvc, ARRAY_SIZE(hvc->ops), 0);
 		hvc->index = 0;
 	}
 
 	hvc->ops[hvc->index++] = ((struct host_vm_op)
-				  { .type	= MPROTECT,
+				  { .type	= HOST_MPROTECT,
 			     	    .u = { .mprotect = { .addr	= addr,
 							 .len	= len,
 							 .prot	= prot } } });
@@ -191,6 +241,60 @@ static int add_mprotect(unsigned long addr, unsigned long len,
 
 #define ADD_ROUND(n, inc) (((n) + (inc)) & ~((inc) - 1))
 
+static void add_kern_mmap(unsigned long virt, unsigned long phys,
+	unsigned long len, struct kernel_vm_change *kvc)
+{
+
+	if (kvc->mmap.active) {
+		if (
+		   (kvc->mmap.phys + kvc->mmap.len == phys) &&
+		   (kvc->mmap.virt + kvc->mmap.len == virt)) {
+			kvc->mmap.len += len;
+			return;
+		}
+		do_kern_ops(kvc);
+	}
+
+	kvc->mmap.phys = phys;
+	kvc->mmap.virt = virt;
+	kvc->mmap.len = len;
+	kvc->mmap.active = 1;
+}
+
+static void add_kern_munmap(unsigned long addr, unsigned long len,
+		      struct kernel_vm_change *kvc)
+{
+
+	if (kvc->munmap.active) {
+		if (
+		   (kvc->munmap.addr + kvc->munmap.len == addr)) {
+			kvc->munmap.len += len;
+			return;
+		}
+		do_kern_ops(kvc);
+	}
+	kvc->munmap.addr = addr;
+	kvc->munmap.len = len;
+	kvc->munmap.active = 1;
+}
+
+static void add_kern_mprotect(unsigned long addr,
+	unsigned long len, struct kernel_vm_change *kvc)
+{
+
+	if (kvc->mprotect.active) {
+		if (
+		   (kvc->mprotect.addr + kvc->mprotect.len == addr)) {
+			kvc->mprotect.len += len;
+			return;
+		}
+		do_kern_ops(kvc);
+	}
+	kvc->mprotect.addr = addr;
+	kvc->mprotect.len = len;
+	kvc->mprotect.active = 1;
+}
+
 static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 				   unsigned long end,
 				   struct host_vm_change *hvc)
@@ -216,12 +320,13 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 			(x ? UM_PROT_EXEC : 0));
 		if (hvc->force || pte_newpage(*pte)) {
 			if (pte_present(*pte))
-				ret = add_mmap(addr, pte_val(*pte) & PAGE_MASK,
-					       PAGE_SIZE, prot, hvc);
+				ret = add_host_mmap(addr,
+					pte_val(*pte) & PAGE_MASK,
+					PAGE_SIZE, prot, hvc);
 			else
-				ret = add_munmap(addr, PAGE_SIZE, hvc);
+				ret = add_host_munmap(addr, PAGE_SIZE, hvc);
 		} else if (pte_newprot(*pte))
-			ret = add_mprotect(addr, PAGE_SIZE, prot, hvc);
+			ret = add_host_mprotect(addr, PAGE_SIZE, prot, hvc);
 		*pte = pte_mkuptodate(*pte);
 	} while (pte++, addr += PAGE_SIZE, ((addr < end) && !ret));
 	return ret;
@@ -240,7 +345,7 @@ static inline int update_pmd_range(pud_t *pud, unsigned long addr,
 		next = pmd_addr_end(addr, end);
 		if (!pmd_present(*pmd)) {
 			if (hvc->force || pmd_newpage(*pmd)) {
-				ret = add_munmap(addr, next - addr, hvc);
+				ret = add_host_munmap(addr, next - addr, hvc);
 				pmd_mkuptodate(*pmd);
 			}
 		}
@@ -262,7 +367,7 @@ static inline int update_pud_range(pgd_t *pgd, unsigned long addr,
 		next = pud_addr_end(addr, end);
 		if (!pud_present(*pud)) {
 			if (hvc->force || pud_newpage(*pud)) {
-				ret = add_munmap(addr, next - addr, hvc);
+				ret = add_host_munmap(addr, next - addr, hvc);
 				pud_mkuptodate(*pud);
 			}
 		}
@@ -285,7 +390,7 @@ void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 		next = pgd_addr_end(addr, end_addr);
 		if (!pgd_present(*pgd)) {
 			if (force || pgd_newpage(*pgd)) {
-				ret = add_munmap(addr, next - addr, &hvc);
+				ret = add_host_munmap(addr, next - addr, &hvc);
 				pgd_mkuptodate(*pgd);
 			}
 		}
@@ -293,7 +398,7 @@ void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 	} while (pgd++, addr = next, ((addr < end_addr) && !ret));
 
 	if (!ret)
-		ret = do_ops(&hvc, hvc.index, 1);
+		ret = do_host_ops(&hvc, hvc.index, 1);
 
 	/* This is not an else because ret is modified above */
 	if (ret) {
@@ -314,7 +419,12 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 	pmd_t *pmd;
 	pte_t *pte;
 	unsigned long addr, last;
-	int updated = 0, err;
+	int updated = 0;
+	struct kernel_vm_change kvc;
+
+	kvc.mmap.active = 0;
+	kvc.munmap.active = 0;
+	kvc.mprotect.active = 0;
 
 	mm = &init_mm;
 	for (addr = start; addr < end;) {
@@ -325,11 +435,7 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 				last = end;
 			if (pgd_newpage(*pgd)) {
 				updated = 1;
-				err = os_unmap_memory((void *) addr,
-						      last - addr);
-				if (err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
+				add_kern_munmap(addr, last - addr, &kvc);
 			}
 			addr = last;
 			continue;
@@ -342,11 +448,7 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 				last = end;
 			if (pud_newpage(*pud)) {
 				updated = 1;
-				err = os_unmap_memory((void *) addr,
-						      last - addr);
-				if (err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
+				add_kern_munmap(addr, last - addr, &kvc);
 			}
 			addr = last;
 			continue;
@@ -359,11 +461,7 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 				last = end;
 			if (pmd_newpage(*pmd)) {
 				updated = 1;
-				err = os_unmap_memory((void *) addr,
-						      last - addr);
-				if (err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
+				add_kern_munmap(addr, last - addr, &kvc);
 			}
 			addr = last;
 			continue;
@@ -372,22 +470,19 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 		pte = pte_offset_kernel(pmd, addr);
 		if (!pte_present(*pte) || pte_newpage(*pte)) {
 			updated = 1;
-			err = os_unmap_memory((void *) addr,
-					      PAGE_SIZE);
-			if (err < 0)
-				panic("munmap failed, errno = %d\n",
-				      -err);
+			add_kern_munmap(addr, PAGE_SIZE, &kvc);
 			if (pte_present(*pte))
-				map_memory(addr,
+				add_kern_mmap(addr,
 					   pte_val(*pte) & PAGE_MASK,
-					   PAGE_SIZE, 1, 1, 1);
+					   PAGE_SIZE, &kvc);
 		}
 		else if (pte_newprot(*pte)) {
 			updated = 1;
-			os_protect_memory((void *) addr, PAGE_SIZE, 1, 1, 1);
+			add_kern_mprotect(addr, PAGE_SIZE, &kvc);
 		}
 		addr += PAGE_SIZE;
 	}
+	do_kern_ops(&kvc);
 	return updated;
 }
 
@@ -553,7 +648,7 @@ void force_flush_all(void)
 	struct vm_area_struct *vma = mm->mmap;
 
 	while (vma != NULL) {
-		fix_range(mm, vma->vm_start, vma->vm_end, 1);
+		fix_range(mm, vma->vm_start, vma->vm_end, FORK_MM_FORCE);
 		vma = vma->vm_next;
 	}
 }
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

