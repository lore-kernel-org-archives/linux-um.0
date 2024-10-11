Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D081DCFD352
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0xE8I/eqX8wXeraGOlsIj0r7xfdCnIf/HQneg4xzk8Q=; b=v9Sqm4fC1XukYo8w64G6CqcTKv
	X2W3grScN6QGtQcA1dwYOsqBYHTgyk4QGOR5+Gi5qfuTsYu0SxzmbpnnCz/FyJ7e7M4wlxpKdGhWs
	YR6RBEvBbrUx7vPYqPVXQsSwqxfnSsulcWPY6gMGw8wpTAAJw4T2+uMjfpx4LaDamM9TEh6pfCfzZ
	rMaK6AUXh7fyjmpQPSoqxPf1elJkjrjeOiO2AE4jgkTJ+YVGuzfp5UAUzf1ZRGIp5DyLAR73IZxKg
	8uaPCUwGGqlpCQ6tnWkTchyNlVhQ9u6M8OEeDJH2HAJ5RXYlNg56wa6/tQ+02eFD7Uh/z3NZyfU0r
	bYA/qTYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szDrr-0000000G8rO-2j2U;
	Fri, 11 Oct 2024 11:31:35 +0000
Received: from out0-203.mail.aliyun.com ([140.205.0.203])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szCob-0000000FxbJ-0Fy5
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 10:24:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1728642244; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0xE8I/eqX8wXeraGOlsIj0r7xfdCnIf/HQneg4xzk8Q=;
	b=ZSS7BtSWKzgICNuEKlOoEzPEg0H49V+4d7ckvLXEaAz7H8DjUcHLQwWKE81LPQ4jsl9LyFgb12Z5IuHjorH07aA2sc9p5bsVJOlmP3HDthmH83XhN/ac6lsEzwWja3zLqTx6Zzo5xC1eEkZ4lQQsu9WOerz6vn5nRkaFTruceZY=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZeXjAJE_1728642243 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 18:24:04 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>,
  "Benjamin Berg" <benjamin.berg@intel.com>
Subject: [PATCH v2 2/2] um: Rename _PAGE_NEWPAGE to _PAGE_NEEDSYNC
Date: Fri, 11 Oct 2024 18:23:54 +0800
Message-Id: <20241011102354.1682626-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011102354.1682626-1-tiwei.btw@antgroup.com>
References: <20241011102354.1682626-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_032409_743571_63CBCFC0 
X-CRM114-Status: GOOD (  14.57  )
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

The _PAGE_NEWPAGE bit does not really indicate that this is a new page,
but rather whether this entry needs to be synced or not. Renaming it
to _PAGE_NEEDSYNC will make it more clear how everything ties together.

Suggested-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/page.h           |  2 +-
 arch/um/include/asm/pgtable-2level.h |  2 +-
 arch/um/include/asm/pgtable-4level.h | 14 +++++-----
 arch/um/include/asm/pgtable.h        | 38 ++++++++++++++--------------
 arch/um/kernel/tlb.c                 | 10 ++++----
 5 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index f0ad80fc8c10..99aa459c7c6c 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -56,7 +56,7 @@ typedef struct { unsigned long pud; } pud_t;
 #define pte_set_bits(p, bits) ((p).pte |= (bits))
 #define pte_clear_bits(p, bits) ((p).pte &= ~(bits))
 #define pte_copy(to, from) ((to).pte = (from).pte)
-#define pte_is_zero(p) (!((p).pte & ~_PAGE_NEWPAGE))
+#define pte_is_zero(p) (!((p).pte & ~_PAGE_NEEDSYNC))
 #define pte_set_val(p, phys, prot) (p).pte = (phys | pgprot_val(prot))
 
 typedef unsigned long phys_t;
diff --git a/arch/um/include/asm/pgtable-2level.h b/arch/um/include/asm/pgtable-2level.h
index 8256ecc5b919..ab0c8dd86564 100644
--- a/arch/um/include/asm/pgtable-2level.h
+++ b/arch/um/include/asm/pgtable-2level.h
@@ -31,7 +31,7 @@
         printk("%s:%d: bad pgd %p(%08lx).\n", __FILE__, __LINE__, &(e), \
 	       pgd_val(e))
 
-static inline int pgd_newpage(pgd_t pgd)	{ return 0; }
+static inline int pgd_needsync(pgd_t pgd)	{ return 0; }
 static inline void pgd_mkuptodate(pgd_t pgd)	{ }
 
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
diff --git a/arch/um/include/asm/pgtable-4level.h b/arch/um/include/asm/pgtable-4level.h
index f912fcc16b7a..0d279caee93c 100644
--- a/arch/um/include/asm/pgtable-4level.h
+++ b/arch/um/include/asm/pgtable-4level.h
@@ -55,7 +55,7 @@
         printk("%s:%d: bad pgd %p(%016lx).\n", __FILE__, __LINE__, &(e), \
 	       pgd_val(e))
 
-#define pud_none(x)	(!(pud_val(x) & ~_PAGE_NEWPAGE))
+#define pud_none(x)	(!(pud_val(x) & ~_PAGE_NEEDSYNC))
 #define	pud_bad(x)	((pud_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 #define pud_present(x)	(pud_val(x) & _PAGE_PRESENT)
 #define pud_populate(mm, pud, pmd) \
@@ -63,7 +63,7 @@
 
 #define set_pud(pudptr, pudval) (*(pudptr) = (pudval))
 
-#define p4d_none(x)	(!(p4d_val(x) & ~_PAGE_NEWPAGE))
+#define p4d_none(x)	(!(p4d_val(x) & ~_PAGE_NEEDSYNC))
 #define	p4d_bad(x)	((p4d_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 #define p4d_present(x)	(p4d_val(x) & _PAGE_PRESENT)
 #define p4d_populate(mm, p4d, pud) \
@@ -72,23 +72,23 @@
 #define set_p4d(p4dptr, p4dval) (*(p4dptr) = (p4dval))
 
 
-static inline int pgd_newpage(pgd_t pgd)
+static inline int pgd_needsync(pgd_t pgd)
 {
-	return(pgd_val(pgd) & _PAGE_NEWPAGE);
+	return pgd_val(pgd) & _PAGE_NEEDSYNC;
 }
 
-static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEWPAGE; }
+static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEEDSYNC; }
 
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 
 static inline void pud_clear (pud_t *pud)
 {
-	set_pud(pud, __pud(_PAGE_NEWPAGE));
+	set_pud(pud, __pud(_PAGE_NEEDSYNC));
 }
 
 static inline void p4d_clear (p4d_t *p4d)
 {
-	set_p4d(p4d, __p4d(_PAGE_NEWPAGE));
+	set_p4d(p4d, __p4d(_PAGE_NEEDSYNC));
 }
 
 #define pud_page(pud) phys_to_page(pud_val(pud) & PAGE_MASK)
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 6b1317400190..12bfc58a8580 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -11,7 +11,7 @@
 #include <asm/fixmap.h>
 
 #define _PAGE_PRESENT	0x001
-#define _PAGE_NEWPAGE	0x002
+#define _PAGE_NEEDSYNC	0x002
 #define _PAGE_RW	0x020
 #define _PAGE_USER	0x040
 #define _PAGE_ACCESSED	0x080
@@ -79,22 +79,22 @@ extern unsigned long end_iomem;
  */
 #define ZERO_PAGE(vaddr) virt_to_page(empty_zero_page)
 
-#define pte_clear(mm,addr,xp) pte_set_val(*(xp), (phys_t) 0, __pgprot(_PAGE_NEWPAGE))
+#define pte_clear(mm, addr, xp) pte_set_val(*(xp), (phys_t) 0, __pgprot(_PAGE_NEEDSYNC))
 
-#define pmd_none(x)	(!((unsigned long)pmd_val(x) & ~_PAGE_NEWPAGE))
+#define pmd_none(x)	(!((unsigned long)pmd_val(x) & ~_PAGE_NEEDSYNC))
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
 
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
-#define pmd_clear(xp)	do { pmd_val(*(xp)) = _PAGE_NEWPAGE; } while (0)
+#define pmd_clear(xp)	do { pmd_val(*(xp)) = _PAGE_NEEDSYNC; } while (0)
 
-#define pmd_newpage(x)  (pmd_val(x) & _PAGE_NEWPAGE)
-#define pmd_mkuptodate(x) (pmd_val(x) &= ~_PAGE_NEWPAGE)
+#define pmd_needsync(x)   (pmd_val(x) & _PAGE_NEEDSYNC)
+#define pmd_mkuptodate(x) (pmd_val(x) &= ~_PAGE_NEEDSYNC)
 
-#define pud_newpage(x)  (pud_val(x) & _PAGE_NEWPAGE)
-#define pud_mkuptodate(x) (pud_val(x) &= ~_PAGE_NEWPAGE)
+#define pud_needsync(x)   (pud_val(x) & _PAGE_NEEDSYNC)
+#define pud_mkuptodate(x) (pud_val(x) &= ~_PAGE_NEEDSYNC)
 
-#define p4d_newpage(x)  (p4d_val(x) & _PAGE_NEWPAGE)
-#define p4d_mkuptodate(x) (p4d_val(x) &= ~_PAGE_NEWPAGE)
+#define p4d_needsync(x)   (p4d_val(x) & _PAGE_NEEDSYNC)
+#define p4d_mkuptodate(x) (p4d_val(x) &= ~_PAGE_NEEDSYNC)
 
 #define pmd_pfn(pmd) (pmd_val(pmd) >> PAGE_SHIFT)
 #define pmd_page(pmd) phys_to_page(pmd_val(pmd) & PAGE_MASK)
@@ -145,9 +145,9 @@ static inline int pte_young(pte_t pte)
 	return pte_get_bits(pte, _PAGE_ACCESSED);
 }
 
-static inline int pte_newpage(pte_t pte)
+static inline int pte_needsync(pte_t pte)
 {
-	return pte_get_bits(pte, _PAGE_NEWPAGE);
+	return pte_get_bits(pte, _PAGE_NEEDSYNC);
 }
 
 /*
@@ -200,13 +200,13 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 
 static inline pte_t pte_mkuptodate(pte_t pte)
 {
-	pte_clear_bits(pte, _PAGE_NEWPAGE);
+	pte_clear_bits(pte, _PAGE_NEEDSYNC);
 	return pte;
 }
 
-static inline pte_t pte_mknewpage(pte_t pte)
+static inline pte_t pte_mkneedsync(pte_t pte)
 {
-	pte_set_bits(pte, _PAGE_NEWPAGE);
+	pte_set_bits(pte, _PAGE_NEEDSYNC);
 	return(pte);
 }
 
@@ -214,11 +214,11 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
 {
 	pte_copy(*pteptr, pteval);
 
-	/* If it's a swap entry, it needs to be marked _PAGE_NEWPAGE so
+	/* If it's a swap entry, it needs to be marked _PAGE_NEEDSYNC so
 	 * update_pte_range knows to unmap it.
 	 */
 
-	*pteptr = pte_mknewpage(*pteptr);
+	*pteptr = pte_mkneedsync(*pteptr);
 }
 
 #define PFN_PTE_SHIFT		PAGE_SHIFT
@@ -258,7 +258,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 #define __HAVE_ARCH_PTE_SAME
 static inline int pte_same(pte_t pte_a, pte_t pte_b)
 {
-	return !((pte_val(pte_a) ^ pte_val(pte_b)) & ~_PAGE_NEWPAGE);
+	return !((pte_val(pte_a) ^ pte_val(pte_b)) & ~_PAGE_NEEDSYNC);
 }
 
 /*
@@ -308,7 +308,7 @@ extern pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr);
  *   <--------------- offset ----------------> E < type -> 0 0 0 1 0
  *
  *   E is the exclusive marker that is not stored in swap entries.
- *   _PAGE_NEWPAGE (bit 1) is always set to 1 in set_pte().
+ *   _PAGE_NEEDSYNC (bit 1) is always set to 1 in set_pte().
  */
 #define __swp_type(x)			(((x).val >> 5) & 0x1f)
 #define __swp_offset(x)			((x).val >> 11)
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 23c1f550cd7c..cf7e0d4407f2 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -57,7 +57,7 @@ static inline int update_pte_range(pmd_t *pmd, unsigned long addr,
 
 	pte = pte_offset_kernel(pmd, addr);
 	do {
-		if (!pte_newpage(*pte))
+		if (!pte_needsync(*pte))
 			continue;
 
 		if (pte_present(*pte)) {
@@ -101,7 +101,7 @@ static inline int update_pmd_range(pud_t *pud, unsigned long addr,
 	do {
 		next = pmd_addr_end(addr, end);
 		if (!pmd_present(*pmd)) {
-			if (pmd_newpage(*pmd)) {
+			if (pmd_needsync(*pmd)) {
 				ret = ops->unmap(ops->mm_idp, addr,
 						 next - addr);
 				pmd_mkuptodate(*pmd);
@@ -124,7 +124,7 @@ static inline int update_pud_range(p4d_t *p4d, unsigned long addr,
 	do {
 		next = pud_addr_end(addr, end);
 		if (!pud_present(*pud)) {
-			if (pud_newpage(*pud)) {
+			if (pud_needsync(*pud)) {
 				ret = ops->unmap(ops->mm_idp, addr,
 						 next - addr);
 				pud_mkuptodate(*pud);
@@ -147,7 +147,7 @@ static inline int update_p4d_range(pgd_t *pgd, unsigned long addr,
 	do {
 		next = p4d_addr_end(addr, end);
 		if (!p4d_present(*p4d)) {
-			if (p4d_newpage(*p4d)) {
+			if (p4d_needsync(*p4d)) {
 				ret = ops->unmap(ops->mm_idp, addr,
 						 next - addr);
 				p4d_mkuptodate(*p4d);
@@ -181,7 +181,7 @@ int um_tlb_sync(struct mm_struct *mm)
 	do {
 		next = pgd_addr_end(addr, mm->context.sync_tlb_range_to);
 		if (!pgd_present(*pgd)) {
-			if (pgd_newpage(*pgd)) {
+			if (pgd_needsync(*pgd)) {
 				ret = ops.unmap(ops.mm_idp, addr,
 						next - addr);
 				pgd_mkuptodate(*pgd);
-- 
2.34.1


