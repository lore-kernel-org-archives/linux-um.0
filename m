Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D375ECFD357
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wGSZJTGBgekPP7ZWKI1NSpSXjezm46pwmtVfcdcBt0M=; b=vY4RlrhNkQ7yzyyK16I972GCEQ
	zhUUmHXp9FLIlYQHZpcjKc4QsJqI8fpDKDfxtj71Of3nKWWr2WVXFNIumRD0ICc2GY0KEhy+sl9+g
	b25dO1yJIAQA2iddv7lqq3Hy1iHdZVlgp2GiCQmqcbMcCwNhCp3+Nm4YSrsRZ3flNleYidaMGP7wS
	xAYi4lzaVcHLMkcvpnYKLLsIZSG3pfqLcwdIF1oiclV4e3cIXVz4FiL1XxbhoBRC0KWJiJVpSs0dK
	7c9xfPM2Jb+3TfY9w6YR+NojJ7I/3uHopZTOKMWEdUoAOIr3CnLG9taksH03Snpeg564mSkk7ClOz
	BYGkHHNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szDrr-0000000G8rV-47Hb;
	Fri, 11 Oct 2024 11:31:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szCop-0000000FxcV-1Dmu
	for linux-um@bombadil.infradead.org;
	Fri, 11 Oct 2024 10:24:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=wGSZJTGBgekPP7ZWKI1NSpSXjezm46pwmtVfcdcBt0M=; b=bkcZ+SM8XhO1Jv2gB8GmpGWDNi
	WRzBnEF/FXg/ev+YIB+N2tTjLE9YB7gh7xz8E7Y+TONJehIqoNEcSwywY1u+UWmighxJed/A7C6/d
	ufzL4Stok9wtaUrVrFq30oYS/ImSKaFlTOnealNr+1VMW7kJ80HH0wI/dM5HOH4ey0Gtj4G7kKHLH
	7sDkQoIFOllgyfKOHovyKWjGhm6MC432DzIuHhqjPHrsRSmiJpDStToMBjmFMYGL8Z3a7hDLwBff7
	F3z0PwK9BLZflwQ0EVv6EFqepzffpv1fAVfrhnt/DonWb1fIuOCLl4qvy5oceAmiTaPtbunxBnVMs
	3BMTZ+MA==;
Received: from out0-197.mail.aliyun.com ([140.205.0.197])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szCok-00000005qVr-3rnx
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 10:24:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728642245; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=wGSZJTGBgekPP7ZWKI1NSpSXjezm46pwmtVfcdcBt0M=;
	b=MYoN5fARlJvB1iNSkdeanRRfECJ1m6s8ewrPJ7ux6s8ds5Gbfi1SHPZ6lU3ZZ8oleAtfajnqkxsQ4oBhtgxn2fLO33boe9ykjA2PS5zqNrFdwj6UNL5iX+krsFpXkidFtNLoXfbUrc68pdaGnxgZpqTu0ZFKGV73sKb1Pf9bt84=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZeXjAHV_1728642242 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 18:24:03 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>,
  "Benjamin Berg" <benjamin.berg@intel.com>
Subject: [PATCH v2 1/2] um: Abandon the _PAGE_NEWPROT bit
Date: Fri, 11 Oct 2024 18:23:53 +0800
Message-Id: <20241011102354.1682626-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011102354.1682626-1-tiwei.btw@antgroup.com>
References: <20241011102354.1682626-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_112420_539388_BD45152D 
X-CRM114-Status: GOOD (  22.65  )
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

When a PTE is updated in the page table, the _PAGE_NEWPAGE bit will
always be set. And the corresponding page will always be mapped or
unmapped depending on whether the PTE is present or not. The check
on the _PAGE_NEWPROT bit is not really reachable. Abandoning it will
allow us to simplify the code and remove the unreachable code.

Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/pgtable.h           | 37 +++-----------
 arch/um/include/asm/tlbflush.h          |  4 +-
 arch/um/include/shared/os.h             |  2 -
 arch/um/include/shared/skas/stub-data.h |  1 -
 arch/um/kernel/skas/stub.c              | 10 ----
 arch/um/kernel/tlb.c                    | 66 +++++++++++--------------
 arch/um/os-Linux/skas/mem.c             | 21 --------
 7 files changed, 36 insertions(+), 105 deletions(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index bd7a9593705f..6b1317400190 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -12,7 +12,6 @@
 
 #define _PAGE_PRESENT	0x001
 #define _PAGE_NEWPAGE	0x002
-#define _PAGE_NEWPROT	0x004
 #define _PAGE_RW	0x020
 #define _PAGE_USER	0x040
 #define _PAGE_ACCESSED	0x080
@@ -151,23 +150,12 @@ static inline int pte_newpage(pte_t pte)
 	return pte_get_bits(pte, _PAGE_NEWPAGE);
 }
 
-static inline int pte_newprot(pte_t pte)
-{
-	return(pte_present(pte) && (pte_get_bits(pte, _PAGE_NEWPROT)));
-}
-
 /*
  * =================================
  * Flags setting section.
  * =================================
  */
 
-static inline pte_t pte_mknewprot(pte_t pte)
-{
-	pte_set_bits(pte, _PAGE_NEWPROT);
-	return(pte);
-}
-
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	pte_clear_bits(pte, _PAGE_DIRTY);
@@ -182,19 +170,14 @@ static inline pte_t pte_mkold(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	if (likely(pte_get_bits(pte, _PAGE_RW)))
-		pte_clear_bits(pte, _PAGE_RW);
-	else
-		return pte;
-	return(pte_mknewprot(pte));
+	pte_clear_bits(pte, _PAGE_RW);
+	return pte;
 }
 
 static inline pte_t pte_mkread(pte_t pte)
 {
-	if (unlikely(pte_get_bits(pte, _PAGE_USER)))
-		return pte;
 	pte_set_bits(pte, _PAGE_USER);
-	return(pte_mknewprot(pte));
+	return pte;
 }
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -211,18 +194,14 @@ static inline pte_t pte_mkyoung(pte_t pte)
 
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
-	if (unlikely(pte_get_bits(pte,  _PAGE_RW)))
-		return pte;
 	pte_set_bits(pte, _PAGE_RW);
-	return(pte_mknewprot(pte));
+	return pte;
 }
 
 static inline pte_t pte_mkuptodate(pte_t pte)
 {
 	pte_clear_bits(pte, _PAGE_NEWPAGE);
-	if(pte_present(pte))
-		pte_clear_bits(pte, _PAGE_NEWPROT);
-	return(pte);
+	return pte;
 }
 
 static inline pte_t pte_mknewpage(pte_t pte)
@@ -236,12 +215,10 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
 	pte_copy(*pteptr, pteval);
 
 	/* If it's a swap entry, it needs to be marked _PAGE_NEWPAGE so
-	 * fix_range knows to unmap it.  _PAGE_NEWPROT is specific to
-	 * mapped pages.
+	 * update_pte_range knows to unmap it.
 	 */
 
 	*pteptr = pte_mknewpage(*pteptr);
-	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
 }
 
 #define PFN_PTE_SHIFT		PAGE_SHIFT
@@ -298,8 +275,6 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
 	({ pte_t pte;					\
 							\
 	pte_set_val(pte, page_to_phys(page), (pgprot));	\
-	if (pte_present(pte))				\
-		pte_mknewprot(pte_mknewpage(pte));	\
 	pte;})
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
diff --git a/arch/um/include/asm/tlbflush.h b/arch/um/include/asm/tlbflush.h
index db997976b6ea..13a3009942be 100644
--- a/arch/um/include/asm/tlbflush.h
+++ b/arch/um/include/asm/tlbflush.h
@@ -9,8 +9,8 @@
 #include <linux/mm.h>
 
 /*
- * In UML, we need to sync the TLB over by using mmap/munmap/mprotect syscalls
- * from the process handling the MM (which can be the kernel itself).
+ * In UML, we need to sync the TLB over by using mmap/munmap syscalls from
+ * the process handling the MM (which can be the kernel itself).
  *
  * To track updates, we can hook into set_ptes and flush_tlb_*. With set_ptes
  * we catch all PTE transitions where memory that was unusable becomes usable.
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index bf539fee7831..09f8201de5db 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -279,8 +279,6 @@ int map(struct mm_id *mm_idp, unsigned long virt,
 	unsigned long len, int prot, int phys_fd,
 	unsigned long long offset);
 int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len);
-int protect(struct mm_id *mm_idp, unsigned long addr,
-	    unsigned long len, unsigned int prot);
 
 /* skas/process.c */
 extern int is_skas_winch(int pid, int fd, void *data);
diff --git a/arch/um/include/shared/skas/stub-data.h b/arch/um/include/shared/skas/stub-data.h
index 3fbdda727373..81a4cace032c 100644
--- a/arch/um/include/shared/skas/stub-data.h
+++ b/arch/um/include/shared/skas/stub-data.h
@@ -30,7 +30,6 @@ enum stub_syscall_type {
 	STUB_SYSCALL_UNSET = 0,
 	STUB_SYSCALL_MMAP,
 	STUB_SYSCALL_MUNMAP,
-	STUB_SYSCALL_MPROTECT,
 };
 
 struct stub_syscall {
diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
index 5d52ffa682dc..796fc266d3bb 100644
--- a/arch/um/kernel/skas/stub.c
+++ b/arch/um/kernel/skas/stub.c
@@ -35,16 +35,6 @@ static __always_inline int syscall_handler(struct stub_data *d)
 				return -1;
 			}
 			break;
-		case STUB_SYSCALL_MPROTECT:
-			res = stub_syscall3(__NR_mprotect,
-					    sc->mem.addr, sc->mem.length,
-					    sc->mem.prot);
-			if (res) {
-				d->err = res;
-				d->syscall_data_len = i;
-				return -1;
-			}
-			break;
 		default:
 			d->err = -95; /* EOPNOTSUPP */
 			d->syscall_data_len = i;
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 548af31d4111..23c1f550cd7c 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -23,9 +23,6 @@ struct vm_ops {
 		    int phys_fd, unsigned long long offset);
 	int (*unmap)(struct mm_id *mm_idp,
 		     unsigned long virt, unsigned long len);
-	int (*mprotect)(struct mm_id *mm_idp,
-			unsigned long virt, unsigned long len,
-			unsigned int prot);
 };
 
 static int kern_map(struct mm_id *mm_idp,
@@ -44,15 +41,6 @@ static int kern_unmap(struct mm_id *mm_idp,
 	return os_unmap_memory((void *)virt, len);
 }
 
-static int kern_mprotect(struct mm_id *mm_idp,
-			 unsigned long virt, unsigned long len,
-			 unsigned int prot)
-{
-	return os_protect_memory((void *)virt, len,
-				 prot & UM_PROT_READ, prot & UM_PROT_WRITE,
-				 1);
-}
-
 void report_enomem(void)
 {
 	printk(KERN_ERR "UML ran out of memory on the host side! "
@@ -65,33 +53,37 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 				   struct vm_ops *ops)
 {
 	pte_t *pte;
-	int r, w, x, prot, ret = 0;
+	int ret = 0;
 
 	pte = pte_offset_kernel(pmd, addr);
 	do {
-		r = pte_read(*pte);
-		w = pte_write(*pte);
-		x = pte_exec(*pte);
-		if (!pte_young(*pte)) {
-			r = 0;
-			w = 0;
-		} else if (!pte_dirty(*pte))
-			w = 0;
-
-		prot = ((r ? UM_PROT_READ : 0) | (w ? UM_PROT_WRITE : 0) |
-			(x ? UM_PROT_EXEC : 0));
-		if (pte_newpage(*pte)) {
-			if (pte_present(*pte)) {
-				__u64 offset;
-				unsigned long phys = pte_val(*pte) & PAGE_MASK;
-				int fd = phys_mapping(phys, &offset);
-
-				ret = ops->mmap(ops->mm_idp, addr, PAGE_SIZE,
-						prot, fd, offset);
-			} else
-				ret = ops->unmap(ops->mm_idp, addr, PAGE_SIZE);
-		} else if (pte_newprot(*pte))
-			ret = ops->mprotect(ops->mm_idp, addr, PAGE_SIZE, prot);
+		if (!pte_newpage(*pte))
+			continue;
+
+		if (pte_present(*pte)) {
+			__u64 offset;
+			unsigned long phys = pte_val(*pte) & PAGE_MASK;
+			int fd = phys_mapping(phys, &offset);
+			int r, w, x, prot;
+
+			r = pte_read(*pte);
+			w = pte_write(*pte);
+			x = pte_exec(*pte);
+			if (!pte_young(*pte)) {
+				r = 0;
+				w = 0;
+			} else if (!pte_dirty(*pte))
+				w = 0;
+
+			prot = (r ? UM_PROT_READ : 0) |
+			       (w ? UM_PROT_WRITE : 0) |
+			       (x ? UM_PROT_EXEC : 0);
+
+			ret = ops->mmap(ops->mm_idp, addr, PAGE_SIZE,
+					prot, fd, offset);
+		} else
+			ret = ops->unmap(ops->mm_idp, addr, PAGE_SIZE);
+
 		*pte = pte_mkuptodate(*pte);
 	} while (pte++, addr += PAGE_SIZE, ((addr < end) && !ret));
 	return ret;
@@ -180,11 +172,9 @@ int um_tlb_sync(struct mm_struct *mm)
 	if (mm == &init_mm) {
 		ops.mmap = kern_map;
 		ops.unmap = kern_unmap;
-		ops.mprotect = kern_mprotect;
 	} else {
 		ops.mmap = map;
 		ops.unmap = unmap;
-		ops.mprotect = protect;
 	}
 
 	pgd = pgd_offset(mm, addr);
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 9a13ac23c606..d7f1814b0e5a 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -217,24 +217,3 @@ int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len)
 
 	return 0;
 }
-
-int protect(struct mm_id *mm_idp, unsigned long addr, unsigned long len,
-	    unsigned int prot)
-{
-	struct stub_syscall *sc;
-
-	/* Compress with previous syscall if that is possible */
-	sc = syscall_stub_get_previous(mm_idp, STUB_SYSCALL_MPROTECT, addr);
-	if (sc && sc->mem.prot == prot) {
-		sc->mem.length += len;
-		return 0;
-	}
-
-	sc = syscall_stub_alloc(mm_idp);
-	sc->syscall = STUB_SYSCALL_MPROTECT;
-	sc->mem.addr = addr;
-	sc->mem.length = len;
-	sc->mem.prot = prot;
-
-	return 0;
-}
-- 
2.34.1


