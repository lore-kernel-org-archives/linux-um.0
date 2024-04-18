Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0F2C04FF8
	for <linux-um@archiver.kernel.org>; Thu, 18 Apr 2024 09:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=92Oci2EDcwj9/x6OplVuXOr6TNbmZszzRgd//457NpA=; b=suclYcfHPkYxR8V7KwQY2ijGBL
	2P/a71Oh+GkWrcvQs603etwcCxHbPHMaYUxnwad8lCSQtUnYLDzdoYDuqtSG7cYKIurbbcNLPvJH6
	bzLCxsq0nl9ektGvkHNGFBnf/Zwg7fPkzlbyuULZASSY3CXYdBFTVql8436OEGXCPR0Bj1AKJrgEE
	lmq0hcxG5Y443/YxDjG6xa1piHKFzwvft/1ysY40Ecwc/CMPBhGEboJo8Zbl7lsui6uvdQxe6eEVE
	8Ume4Y4Ru/HVKWsEED+sRFWfmzJjaSAewUz2WkrJgEjLoTFdSZM6r9WaBAyq13oVicMqZ6hKJbxlj
	Tw5RgAig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO16-00000001bXs-1qiQ;
	Thu, 18 Apr 2024 09:25:16 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO0s-00000001bL9-1LK1
	for linux-um@lists.infradead.org;
	Thu, 18 Apr 2024 09:25:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=92Oci2EDcwj9/x6OplVuXOr6TNbmZszzRgd//457NpA=;
	t=1713432302; x=1714641902; b=ZEvXQC7eh58YnN6RDe8S5RcxKt2Q9hGKoozJoyR5Yz8DbLA
	GI+eN85Z3AprveZxNb7cAww09rQnvyzQCZAb+LTCs43gTqJi4p+wIBEOj7vMIsnCbehsiFBaF6CWn
	HuReC+9MlPUyaqmoHFqJoy2Cw1vwpraEgZaW69OYY7Smrd9TXxXB7Swlm1VPMa/ZgJdrACFL87rJN
	Z3cDHl5gtrxF/DiULrfcOLbWDRxrpuhBhIdY8YFnUCCWiMku6ZBGHnsLkEzGEaF/p5MDWoVuIGHwd
	kggcrmsPdOw5U/bCHXTruWIPfC06tdJZCETvtCgFMsF5dozDwEJVvx2CwdsQc1ew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rxO0p-0000000CKXH-34fy;
	Thu, 18 Apr 2024 11:25:00 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 11/12] um: simplify and consolidate TLB updates
Date: Thu, 18 Apr 2024 11:23:26 +0200
Message-ID: <20240418092327.860135-12-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418092327.860135-1-benjamin@sipsolutions.net>
References: <20240418092327.860135-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_022502_883222_CD231662 
X-CRM114-Status: GOOD (  22.45  )
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

The HVC update was mostly used to compress consecutive calls into one.
This is mostly relevant for userspace where it is already handled by the
syscall stub code.

Simplify the whole logic and consolidate it for both kernel and
userspace. This does remove the sequential syscall compression for the
kernel, however that shouldn't be the main factor in most runs.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/include/shared/os.h |  12 +-
 arch/um/kernel/tlb.c        | 386 ++++++++----------------------------
 arch/um/os-Linux/skas/mem.c |  18 +-
 3 files changed, 99 insertions(+), 317 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index ecc1273fd230..01af239dcc01 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -275,12 +275,12 @@ int syscall_stub_flush(struct mm_id *mm_idp);
 struct stub_syscall *syscall_stub_alloc(struct mm_id *mm_idp);
 void syscall_stub_dump_error(struct mm_id *mm_idp);
 
-void map(struct mm_id *mm_idp, unsigned long virt,
-	 unsigned long len, int prot, int phys_fd,
-	 unsigned long long offset);
-void unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len);
-void protect(struct mm_id *mm_idp, unsigned long addr,
-	     unsigned long len, unsigned int prot);
+int map(struct mm_id *mm_idp, unsigned long virt,
+	unsigned long len, int prot, int phys_fd,
+	unsigned long long offset);
+int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len);
+int protect(struct mm_id *mm_idp, unsigned long addr,
+	    unsigned long len, unsigned int prot);
 
 /* skas/process.c */
 extern int is_skas_winch(int pid, int fd, void *data);
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index f183a9b9ff7b..c137ff6f84dd 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -14,207 +14,54 @@
 #include <skas.h>
 #include <kern_util.h>
 
-struct host_vm_change {
-	struct host_vm_op {
-		enum { NONE, MMAP, MUNMAP, MPROTECT } type;
-		union {
-			struct {
-				unsigned long addr;
-				unsigned long len;
-				unsigned int prot;
-				int fd;
-				__u64 offset;
-			} mmap;
-			struct {
-				unsigned long addr;
-				unsigned long len;
-			} munmap;
-			struct {
-				unsigned long addr;
-				unsigned long len;
-				unsigned int prot;
-			} mprotect;
-		} u;
-	} ops[1];
-	int userspace;
-	int index;
-	struct mm_struct *mm;
-	void *data;
+struct vm_ops {
+	struct mm_id *mm_idp;
+
+	int (*mmap)(struct mm_id *mm_idp,
+		    unsigned long virt, unsigned long len, int prot,
+		    int phys_fd, unsigned long long offset);
+	int (*unmap)(struct mm_id *mm_idp,
+		     unsigned long virt, unsigned long len);
+	int (*mprotect)(struct mm_id *mm_idp,
+			unsigned long virt, unsigned long len,
+			unsigned int prot);
 };
 
-#define INIT_HVC(mm, userspace) \
-	((struct host_vm_change) \
-	 { .ops		= { { .type = NONE } },	\
-	   .mm		= mm, \
-       	   .data	= NULL, \
-	   .userspace	= userspace, \
-	   .index	= 0 })
-
-void report_enomem(void)
+static int kern_map(struct mm_id *mm_idp,
+		    unsigned long virt, unsigned long len, int prot,
+		    int phys_fd, unsigned long long offset)
 {
-	printk(KERN_ERR "UML ran out of memory on the host side! "
-			"This can happen due to a memory limitation or "
-			"vm.max_map_count has been reached.\n");
+	/* TODO: Why is executable needed to be always set in the kernel? */
+	return os_map_memory((void *)virt, phys_fd, offset, len,
+			     prot & UM_PROT_READ, prot & UM_PROT_WRITE,
+			     1);
 }
 
-static int do_ops(struct host_vm_change *hvc, int end,
-		  int finished)
+static int kern_unmap(struct mm_id *mm_idp,
+		      unsigned long virt, unsigned long len)
 {
-	struct host_vm_op *op;
-	int i, ret = 0;
-
-	for (i = 0; i < end && !ret; i++) {
-		op = &hvc->ops[i];
-		switch (op->type) {
-		case MMAP:
-			if (hvc->userspace)
-				map(&hvc->mm->context.id, op->u.mmap.addr,
-				    op->u.mmap.len, op->u.mmap.prot,
-				    op->u.mmap.fd,
-				    op->u.mmap.offset);
-			else
-				map_memory(op->u.mmap.addr, op->u.mmap.offset,
-					   op->u.mmap.len, 1, 1, 1);
-			break;
-		case MUNMAP:
-			if (hvc->userspace)
-				unmap(&hvc->mm->context.id,
-				      op->u.munmap.addr,
-				      op->u.munmap.len);
-			else
-				ret = os_unmap_memory(
-					(void *) op->u.munmap.addr,
-						      op->u.munmap.len);
-
-			break;
-		case MPROTECT:
-			if (hvc->userspace)
-				protect(&hvc->mm->context.id,
-					op->u.mprotect.addr,
-					op->u.mprotect.len,
-					op->u.mprotect.prot);
-			else
-				ret = os_protect_memory(
-					(void *) op->u.mprotect.addr,
-							op->u.mprotect.len,
-							1, 1, 1);
-			break;
-		default:
-			printk(KERN_ERR "Unknown op type %d in do_ops\n",
-			       op->type);
-			BUG();
-			break;
-		}
-	}
-
-	if (hvc->userspace && finished)
-		ret = syscall_stub_flush(&hvc->mm->context.id);
-
-	if (ret == -ENOMEM)
-		report_enomem();
-
-	return ret;
+	return os_unmap_memory((void *)virt, len);
 }
 
-static int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
-		    unsigned int prot, struct host_vm_change *hvc)
+static int kern_mprotect(struct mm_id *mm_idp,
+			 unsigned long virt, unsigned long len,
+			 unsigned int prot)
 {
-	__u64 offset;
-	struct host_vm_op *last;
-	int fd = -1, ret = 0;
-
-	if (hvc->userspace)
-		fd = phys_mapping(phys, &offset);
-	else
-		offset = phys;
-	if (hvc->index != 0) {
-		last = &hvc->ops[hvc->index - 1];
-		if ((last->type == MMAP) &&
-		   (last->u.mmap.addr + last->u.mmap.len == virt) &&
-		   (last->u.mmap.prot == prot) && (last->u.mmap.fd == fd) &&
-		   (last->u.mmap.offset + last->u.mmap.len == offset)) {
-			last->u.mmap.len += len;
-			return 0;
-		}
-	}
-
-	if (hvc->index == ARRAY_SIZE(hvc->ops)) {
-		ret = do_ops(hvc, ARRAY_SIZE(hvc->ops), 0);
-		hvc->index = 0;
-	}
-
-	hvc->ops[hvc->index++] = ((struct host_vm_op)
-				  { .type	= MMAP,
-				    .u = { .mmap = { .addr	= virt,
-						     .len	= len,
-						     .prot	= prot,
-						     .fd	= fd,
-						     .offset	= offset }
-			   } });
-	return ret;
+	return os_protect_memory((void *)virt, len,
+				 prot & UM_PROT_READ, prot & UM_PROT_WRITE,
+				 1);
 }
 
-static int add_munmap(unsigned long addr, unsigned long len,
-		      struct host_vm_change *hvc)
-{
-	struct host_vm_op *last;
-	int ret = 0;
-
-	if (hvc->index != 0) {
-		last = &hvc->ops[hvc->index - 1];
-		if ((last->type == MUNMAP) &&
-		   (last->u.munmap.addr + last->u.mmap.len == addr)) {
-			last->u.munmap.len += len;
-			return 0;
-		}
-	}
-
-	if (hvc->index == ARRAY_SIZE(hvc->ops)) {
-		ret = do_ops(hvc, ARRAY_SIZE(hvc->ops), 0);
-		hvc->index = 0;
-	}
-
-	hvc->ops[hvc->index++] = ((struct host_vm_op)
-				  { .type	= MUNMAP,
-			     	    .u = { .munmap = { .addr	= addr,
-						       .len	= len } } });
-	return ret;
-}
-
-static int add_mprotect(unsigned long addr, unsigned long len,
-			unsigned int prot, struct host_vm_change *hvc)
+void report_enomem(void)
 {
-	struct host_vm_op *last;
-	int ret = 0;
-
-	if (hvc->index != 0) {
-		last = &hvc->ops[hvc->index - 1];
-		if ((last->type == MPROTECT) &&
-		   (last->u.mprotect.addr + last->u.mprotect.len == addr) &&
-		   (last->u.mprotect.prot == prot)) {
-			last->u.mprotect.len += len;
-			return 0;
-		}
-	}
-
-	if (hvc->index == ARRAY_SIZE(hvc->ops)) {
-		ret = do_ops(hvc, ARRAY_SIZE(hvc->ops), 0);
-		hvc->index = 0;
-	}
-
-	hvc->ops[hvc->index++] = ((struct host_vm_op)
-				  { .type	= MPROTECT,
-			     	    .u = { .mprotect = { .addr	= addr,
-							 .len	= len,
-							 .prot	= prot } } });
-	return ret;
+	printk(KERN_ERR "UML ran out of memory on the host side! "
+			"This can happen due to a memory limitation or "
+			"vm.max_map_count has been reached.\n");
 }
 
-#define ADD_ROUND(n, inc) (((n) + (inc)) & ~((inc) - 1))
-
 static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 				   unsigned long end,
-				   struct host_vm_change *hvc)
+				   struct vm_ops *ops)
 {
 	pte_t *pte;
 	int r, w, x, prot, ret = 0;
@@ -234,13 +81,20 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 			(x ? UM_PROT_EXEC : 0));
 		if (pte_newpage(*pte)) {
 			if (pte_present(*pte)) {
-				if (pte_newpage(*pte))
-					ret = add_mmap(addr, pte_val(*pte) & PAGE_MASK,
-						       PAGE_SIZE, prot, hvc);
+				if (pte_newpage(*pte)) {
+					__u64 offset;
+					unsigned long phys =
+						pte_val(*pte) & PAGE_MASK;
+					int fd =  phys_mapping(phys, &offset);
+
+					ret = ops->mmap(ops->mm_idp, addr,
+							PAGE_SIZE, prot, fd,
+							offset);
+				}
 			} else
-				ret = add_munmap(addr, PAGE_SIZE, hvc);
+				ret = ops->unmap(ops->mm_idp, addr, PAGE_SIZE);
 		} else if (pte_newprot(*pte))
-			ret = add_mprotect(addr, PAGE_SIZE, prot, hvc);
+			ret = ops->mprotect(ops->mm_idp, addr, PAGE_SIZE, prot);
 		*pte = pte_mkuptodate(*pte);
 	} while (pte++, addr += PAGE_SIZE, ((addr < end) && !ret));
 	return ret;
@@ -248,7 +102,7 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 
 static inline int update_pmd_range(pud_t *pud, unsigned long addr,
 				   unsigned long end,
-				   struct host_vm_change *hvc)
+				   struct vm_ops *ops)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -259,18 +113,19 @@ static inline int update_pmd_range(pud_t *pud, unsigned long addr,
 		next = pmd_addr_end(addr, end);
 		if (!pmd_present(*pmd)) {
 			if (pmd_newpage(*pmd)) {
-				ret = add_munmap(addr, next - addr, hvc);
+				ret = ops->unmap(ops->mm_idp, addr,
+						 next - addr);
 				pmd_mkuptodate(*pmd);
 			}
 		}
-		else ret = update_pte_range(pmd, addr, next, hvc);
+		else ret = update_pte_range(pmd, addr, next, ops);
 	} while (pmd++, addr = next, ((addr < end) && !ret));
 	return ret;
 }
 
 static inline int update_pud_range(p4d_t *p4d, unsigned long addr,
 				   unsigned long end,
-				   struct host_vm_change *hvc)
+				   struct vm_ops *ops)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -281,18 +136,19 @@ static inline int update_pud_range(p4d_t *p4d, unsigned long addr,
 		next = pud_addr_end(addr, end);
 		if (!pud_present(*pud)) {
 			if (pud_newpage(*pud)) {
-				ret = add_munmap(addr, next - addr, hvc);
+				ret = ops->unmap(ops->mm_idp, addr,
+						 next - addr);
 				pud_mkuptodate(*pud);
 			}
 		}
-		else ret = update_pmd_range(pud, addr, next, hvc);
+		else ret = update_pmd_range(pud, addr, next, ops);
 	} while (pud++, addr = next, ((addr < end) && !ret));
 	return ret;
 }
 
 static inline int update_p4d_range(pgd_t *pgd, unsigned long addr,
 				   unsigned long end,
-				   struct host_vm_change *hvc)
+				   struct vm_ops *ops)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -303,142 +159,62 @@ static inline int update_p4d_range(pgd_t *pgd, unsigned long addr,
 		next = p4d_addr_end(addr, end);
 		if (!p4d_present(*p4d)) {
 			if (p4d_newpage(*p4d)) {
-				ret = add_munmap(addr, next - addr, hvc);
+				ret = ops->unmap(ops->mm_idp, addr,
+						 next - addr);
 				p4d_mkuptodate(*p4d);
 			}
 		} else
-			ret = update_pud_range(p4d, addr, next, hvc);
+			ret = update_pud_range(p4d, addr, next, ops);
 	} while (p4d++, addr = next, ((addr < end) && !ret));
 	return ret;
 }
 
-static void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
+static int fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 			     unsigned long end_addr)
 {
 	pgd_t *pgd;
-	struct host_vm_change hvc;
+	struct vm_ops ops;
 	unsigned long addr = start_addr, next;
-	int ret = 0, userspace = 1;
+	int ret = 0;
+
+	ops.mm_idp = &mm->context.id;
+	if (mm == &init_mm) {
+		ops.mmap = kern_map;
+		ops.unmap = kern_unmap;
+		ops.mprotect = kern_mprotect;
+	} else {
+		ops.mmap = map;
+		ops.unmap = unmap;
+		ops.mprotect = protect;
+	}
 
-	hvc = INIT_HVC(mm, userspace);
 	pgd = pgd_offset(mm, addr);
 	do {
 		next = pgd_addr_end(addr, end_addr);
 		if (!pgd_present(*pgd)) {
 			if (pgd_newpage(*pgd)) {
-				ret = add_munmap(addr, next - addr, &hvc);
+				ret = ops.unmap(ops.mm_idp, addr,
+						next - addr);
 				pgd_mkuptodate(*pgd);
 			}
 		} else
-			ret = update_p4d_range(pgd, addr, next, &hvc);
+			ret = update_p4d_range(pgd, addr, next, &ops);
 	} while (pgd++, addr = next, ((addr < end_addr) && !ret));
 
-	if (!ret)
-		ret = do_ops(&hvc, hvc.index, 1);
+	if (ret == -ENOMEM)
+		report_enomem();
+
+	return ret;
 }
 
-static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
+static void flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 {
-	struct mm_struct *mm;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	unsigned long addr, last;
-	int updated = 0, err = 0,  userspace = 0;
-	struct host_vm_change hvc;
-
-	mm = &init_mm;
-	hvc = INIT_HVC(mm, userspace);
-	for (addr = start; addr < end;) {
-		pgd = pgd_offset(mm, addr);
-		if (!pgd_present(*pgd)) {
-			last = ADD_ROUND(addr, PGDIR_SIZE);
-			if (last > end)
-				last = end;
-			if (pgd_newpage(*pgd)) {
-				updated = 1;
-				err = add_munmap(addr, last - addr, &hvc);
-				if (err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
-			}
-			addr = last;
-			continue;
-		}
-
-		p4d = p4d_offset(pgd, addr);
-		if (!p4d_present(*p4d)) {
-			last = ADD_ROUND(addr, P4D_SIZE);
-			if (last > end)
-				last = end;
-			if (p4d_newpage(*p4d)) {
-				updated = 1;
-				err = add_munmap(addr, last - addr, &hvc);
-				if (err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
-			}
-			addr = last;
-			continue;
-		}
+	int err;
 
-		pud = pud_offset(p4d, addr);
-		if (!pud_present(*pud)) {
-			last = ADD_ROUND(addr, PUD_SIZE);
-			if (last > end)
-				last = end;
-			if (pud_newpage(*pud)) {
-				updated = 1;
-				err = add_munmap(addr, last - addr, &hvc);
-				if (err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
-			}
-			addr = last;
-			continue;
-		}
-
-		pmd = pmd_offset(pud, addr);
-		if (!pmd_present(*pmd)) {
-			last = ADD_ROUND(addr, PMD_SIZE);
-			if (last > end)
-				last = end;
-			if (pmd_newpage(*pmd)) {
-				updated = 1;
-				err = add_munmap(addr, last - addr, &hvc);
-				if (err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
-			}
-			addr = last;
-			continue;
-		}
-
-		pte = pte_offset_kernel(pmd, addr);
-		if (!pte_present(*pte) || pte_newpage(*pte)) {
-			updated = 1;
-			err = add_munmap(addr, PAGE_SIZE, &hvc);
-			if (err < 0)
-				panic("munmap failed, errno = %d\n",
-				      -err);
-			if (pte_present(*pte))
-				err = add_mmap(addr, pte_val(*pte) & PAGE_MASK,
-					       PAGE_SIZE, 0, &hvc);
-		}
-		else if (pte_newprot(*pte)) {
-			updated = 1;
-			err = add_mprotect(addr, PAGE_SIZE, 0, &hvc);
-		}
-		addr += PAGE_SIZE;
-	}
-	if (!err)
-		err = do_ops(&hvc, hvc.index, 1);
+	err = fix_range_common(&init_mm, start, end);
 
-	if (err < 0)
+	if (err)
 		panic("flush_tlb_kernel failed, errno = %d\n", err);
-	return updated;
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index bb7eace4feac..5e7e218073d8 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -177,7 +177,7 @@ static struct stub_syscall *syscall_stub_get_previous(struct mm_id *mm_idp,
 	return NULL;
 }
 
-void map(struct mm_id *mm_idp, unsigned long virt, unsigned long len, int prot,
+int map(struct mm_id *mm_idp, unsigned long virt, unsigned long len, int prot,
 	int phys_fd, unsigned long long offset)
 {
 	struct stub_syscall *sc;
@@ -187,7 +187,7 @@ void map(struct mm_id *mm_idp, unsigned long virt, unsigned long len, int prot,
 	if (sc && sc->mem.prot == prot && sc->mem.fd == phys_fd &&
 	    sc->mem.offset == MMAP_OFFSET(offset - sc->mem.length)) {
 		sc->mem.length += len;
-		return;
+		return 0;
 	}
 
 	sc = syscall_stub_alloc(mm_idp);
@@ -197,9 +197,11 @@ void map(struct mm_id *mm_idp, unsigned long virt, unsigned long len, int prot,
 	sc->mem.prot = prot;
 	sc->mem.fd = phys_fd;
 	sc->mem.offset = MMAP_OFFSET(offset);
+
+	return 0;
 }
 
-void unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len)
+int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len)
 {
 	struct stub_syscall *sc;
 
@@ -207,16 +209,18 @@ void unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len)
 	sc = syscall_stub_get_previous(mm_idp, STUB_SYSCALL_MUNMAP, addr);
 	if (sc) {
 		sc->mem.length += len;
-		return;
+		return 0;
 	}
 
 	sc = syscall_stub_alloc(mm_idp);
 	sc->syscall = STUB_SYSCALL_MUNMAP;
 	sc->mem.addr = addr;
 	sc->mem.length = len;
+
+	return 0;
 }
 
-void protect(struct mm_id *mm_idp, unsigned long addr, unsigned long len,
+int protect(struct mm_id *mm_idp, unsigned long addr, unsigned long len,
 	    unsigned int prot)
 {
 	struct stub_syscall *sc;
@@ -225,7 +229,7 @@ void protect(struct mm_id *mm_idp, unsigned long addr, unsigned long len,
 	sc = syscall_stub_get_previous(mm_idp, STUB_SYSCALL_MPROTECT, addr);
 	if (sc && sc->mem.prot == prot) {
 		sc->mem.length += len;
-		return;
+		return 0;
 	}
 
 	sc = syscall_stub_alloc(mm_idp);
@@ -233,4 +237,6 @@ void protect(struct mm_id *mm_idp, unsigned long addr, unsigned long len,
 	sc->mem.addr = addr;
 	sc->mem.length = len;
 	sc->mem.prot = prot;
+
+	return 0;
 }
-- 
2.44.0


