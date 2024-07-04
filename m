Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36303C3271F
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 19:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AYOKRaixBXyWK/dGAWwZ6jALUihDgJCQNmaVd3Tm8eE=; b=raFOrcy3gy/bDe5NrKzH/V6ZHL
	ttx+xsQeJPIdJCJBTsXjr4X3KgcanKuYli5Tv55Q0l3Y3XcVP9MOlCESbwF0dCcDoQ0HKduGDElTP
	Xc5sv0dAc9qkE0rQZGdJdGxsgn+HckwuPRvzKOJbQqwRWBhiLOAxiqOICHYA4jLYCupfas8e7jAi7
	oZoCWjyTruYsZvBkZjZMPc/9mfVpyXqoYvNcEnyLS6UgIaSM90li36Pgk2ae6x4bvNAI5dNe1HY1u
	I133s6WhH4h/6dpw2ktJUbt6BucsiMdsvuHAXmLy9iTLug+04F4T9yhn8HOe7cOp2rkDIIcMU9Tws
	jLg9YO5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRln-0000000EELk-3QaM;
	Thu, 04 Jul 2024 19:05:27 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPRlk-0000000EEHq-16Rj
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 19:05:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AYOKRaixBXyWK/dGAWwZ6jALUihDgJCQNmaVd3Tm8eE=;
	t=1720119924; x=1721329524; b=lSvzM1FEXbCWBq3KycXAQUTsmEHgkCrbM+zT72S1rY2yRmL
	H4fSOrMDTveROtGt4+pXofuOoLvvip2laRrits7HBt5WkwJdGXxQO4gaqQCF+e1lk1vmnx4QO0rnc
	4GXAXEEQt3o/BWVQGFOQ8HXia7azQ+qSp9HYFi5HUvOxSW0tW+sKmJjCWdKt3JJ0MvezzECZK4/2M
	lKgUL1ZRrDranQQwBjpNN2gZ4axYlX9nT1MqUxRfnsyZgL5LUCw5ZaCy2Rb2XV65Ns4nbLYf8E4Ht
	JCVUUyGCPtc8XXPQkPV3iPNBoCq6EOV9rJ5+uosW/RcQxbPGjSE2z7eTmLD3+UjA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sPRlh-0000000DrZs-3Kzr;
	Thu, 04 Jul 2024 21:05:22 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v8 7/7] um: Add 4 level page table support
Date: Thu,  4 Jul 2024 21:05:06 +0200
Message-ID: <20240704190506.1438493-8-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704190506.1438493-1-benjamin@sipsolutions.net>
References: <20240704190506.1438493-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_120524_491416_070EC02E 
X-CRM114-Status: GOOD (  21.54  )
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

The larger memory space is useful to support more applications inside
UML. One example for this is ASAN instrumentation of userspace
applications which requires addresses that would otherwise not be
available.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v7:
- Reword options and fix documentation of x86-64 default

v2:
- Do not hide option behind the EXPERT flag
- Fix typo in new "Two-level pagetables" option
---
 arch/um/Kconfig                      |   1 +
 arch/um/include/asm/page.h           |  14 +++-
 arch/um/include/asm/pgalloc.h        |  11 ++-
 arch/um/include/asm/pgtable-4level.h | 119 +++++++++++++++++++++++++++
 arch/um/include/asm/pgtable.h        |   6 +-
 arch/um/kernel/mem.c                 |  17 +++-
 arch/x86/um/Kconfig                  |  38 ++++++---
 7 files changed, 189 insertions(+), 17 deletions(-)
 create mode 100644 arch/um/include/asm/pgtable-4level.h

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index dca84fd6d00a..7f93609ad63d 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -210,6 +210,7 @@ config MMAPPER
 
 config PGTABLE_LEVELS
 	int
+	default 4 if 4_LEVEL_PGTABLES
 	default 3 if 3_LEVEL_PGTABLES
 	default 2
 
diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 9ef9a8aedfa6..c3b2ae03b60c 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -57,14 +57,22 @@ typedef unsigned long long phys_t;
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
 
-#ifdef CONFIG_3_LEVEL_PGTABLES
+#if CONFIG_PGTABLE_LEVELS > 2
+
 typedef struct { unsigned long pmd; } pmd_t;
 #define pmd_val(x)	((x).pmd)
 #define __pmd(x) ((pmd_t) { (x) } )
-#endif
 
-#define pte_val(x)	((x).pte)
+#if CONFIG_PGTABLE_LEVELS > 3
 
+typedef struct { unsigned long pud; } pud_t;
+#define pud_val(x)	((x).pud)
+#define __pud(x) ((pud_t) { (x) } )
+
+#endif /* CONFIG_PGTABLE_LEVELS > 3 */
+#endif /* CONFIG_PGTABLE_LEVELS > 2 */
+
+#define pte_val(x)	((x).pte)
 
 #define pte_get_bits(p, bits) ((p).pte & (bits))
 #define pte_set_bits(p, bits) ((p).pte |= (bits))
diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index de5e31c64793..04fb4e6969a4 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -31,7 +31,7 @@ do {								\
 	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
-#ifdef CONFIG_3_LEVEL_PGTABLES
+#if CONFIG_PGTABLE_LEVELS > 2
 
 #define __pmd_free_tlb(tlb, pmd, address)			\
 do {								\
@@ -39,6 +39,15 @@ do {								\
 	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
 } while (0)
 
+#if CONFIG_PGTABLE_LEVELS > 3
+
+#define __pud_free_tlb(tlb, pud, address)			\
+do {								\
+	pagetable_pud_dtor(virt_to_ptdesc(pud));		\
+	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));	\
+} while (0)
+
+#endif
 #endif
 
 #endif
diff --git a/arch/um/include/asm/pgtable-4level.h b/arch/um/include/asm/pgtable-4level.h
new file mode 100644
index 000000000000..f912fcc16b7a
--- /dev/null
+++ b/arch/um/include/asm/pgtable-4level.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2003 PathScale Inc
+ * Derived from include/asm-i386/pgtable.h
+ */
+
+#ifndef __UM_PGTABLE_4LEVEL_H
+#define __UM_PGTABLE_4LEVEL_H
+
+#include <asm-generic/pgtable-nop4d.h>
+
+/* PGDIR_SHIFT determines what a fourth-level page table entry can map */
+
+#define PGDIR_SHIFT	39
+#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
+#define PGDIR_MASK	(~(PGDIR_SIZE-1))
+
+/* PUD_SHIFT determines the size of the area a third-level page table can
+ * map
+ */
+
+#define PUD_SHIFT	30
+#define PUD_SIZE	(1UL << PUD_SHIFT)
+#define PUD_MASK	(~(PUD_SIZE-1))
+
+/* PMD_SHIFT determines the size of the area a second-level page table can
+ * map
+ */
+
+#define PMD_SHIFT	21
+#define PMD_SIZE	(1UL << PMD_SHIFT)
+#define PMD_MASK	(~(PMD_SIZE-1))
+
+/*
+ * entries per page directory level
+ */
+
+#define PTRS_PER_PTE 512
+#define PTRS_PER_PMD 512
+#define PTRS_PER_PUD 512
+#define PTRS_PER_PGD 512
+
+#define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
+
+#define pte_ERROR(e) \
+        printk("%s:%d: bad pte %p(%016lx).\n", __FILE__, __LINE__, &(e), \
+	       pte_val(e))
+#define pmd_ERROR(e) \
+        printk("%s:%d: bad pmd %p(%016lx).\n", __FILE__, __LINE__, &(e), \
+	       pmd_val(e))
+#define pud_ERROR(e) \
+        printk("%s:%d: bad pud %p(%016lx).\n", __FILE__, __LINE__, &(e), \
+	       pud_val(e))
+#define pgd_ERROR(e) \
+        printk("%s:%d: bad pgd %p(%016lx).\n", __FILE__, __LINE__, &(e), \
+	       pgd_val(e))
+
+#define pud_none(x)	(!(pud_val(x) & ~_PAGE_NEWPAGE))
+#define	pud_bad(x)	((pud_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
+#define pud_present(x)	(pud_val(x) & _PAGE_PRESENT)
+#define pud_populate(mm, pud, pmd) \
+	set_pud(pud, __pud(_PAGE_TABLE + __pa(pmd)))
+
+#define set_pud(pudptr, pudval) (*(pudptr) = (pudval))
+
+#define p4d_none(x)	(!(p4d_val(x) & ~_PAGE_NEWPAGE))
+#define	p4d_bad(x)	((p4d_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
+#define p4d_present(x)	(p4d_val(x) & _PAGE_PRESENT)
+#define p4d_populate(mm, p4d, pud) \
+	set_p4d(p4d, __p4d(_PAGE_TABLE + __pa(pud)))
+
+#define set_p4d(p4dptr, p4dval) (*(p4dptr) = (p4dval))
+
+
+static inline int pgd_newpage(pgd_t pgd)
+{
+	return(pgd_val(pgd) & _PAGE_NEWPAGE);
+}
+
+static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEWPAGE; }
+
+#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
+
+static inline void pud_clear (pud_t *pud)
+{
+	set_pud(pud, __pud(_PAGE_NEWPAGE));
+}
+
+static inline void p4d_clear (p4d_t *p4d)
+{
+	set_p4d(p4d, __p4d(_PAGE_NEWPAGE));
+}
+
+#define pud_page(pud) phys_to_page(pud_val(pud) & PAGE_MASK)
+#define pud_pgtable(pud) ((pmd_t *) __va(pud_val(pud) & PAGE_MASK))
+
+#define p4d_page(p4d) phys_to_page(p4d_val(p4d) & PAGE_MASK)
+#define p4d_pgtable(p4d) ((pud_t *) __va(p4d_val(p4d) & PAGE_MASK))
+
+static inline unsigned long pte_pfn(pte_t pte)
+{
+	return phys_to_pfn(pte_val(pte));
+}
+
+static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
+{
+	pte_t pte;
+	phys_t phys = pfn_to_phys(page_nr);
+
+	pte_set_val(pte, phys, pgprot);
+	return pte;
+}
+
+static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
+{
+	return __pmd((page_nr << PAGE_SHIFT) | pgprot_val(pgprot));
+}
+
+#endif
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 5bb397b65efb..9ab3e34e8100 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -24,9 +24,11 @@
 /* We borrow bit 10 to store the exclusive marker in swap PTEs. */
 #define _PAGE_SWP_EXCLUSIVE	0x400
 
-#ifdef CONFIG_3_LEVEL_PGTABLES
+#if CONFIG_PGTABLE_LEVELS == 4
+#include <asm/pgtable-4level.h>
+#elif CONFIG_PGTABLE_LEVELS == 3
 #include <asm/pgtable-3level.h>
-#else
+#elif CONFIG_PGTABLE_LEVELS == 2
 #include <asm/pgtable-2level.h>
 #endif
 
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index a5b4fe2ad931..e7c262265c31 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -98,7 +98,7 @@ static void __init one_page_table_init(pmd_t *pmd)
 
 static void __init one_md_table_init(pud_t *pud)
 {
-#ifdef CONFIG_3_LEVEL_PGTABLES
+#if CONFIG_PGTABLE_LEVELS > 2
 	pmd_t *pmd_table = (pmd_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
 	if (!pmd_table)
 		panic("%s: Failed to allocate %lu bytes align=%lx\n",
@@ -109,6 +109,19 @@ static void __init one_md_table_init(pud_t *pud)
 #endif
 }
 
+static void __init one_ud_table_init(p4d_t *p4d)
+{
+#if CONFIG_PGTABLE_LEVELS > 3
+	pud_t *pud_table = (pud_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
+	if (!pud_table)
+		panic("%s: Failed to allocate %lu bytes align=%lx\n",
+		      __func__, PAGE_SIZE, PAGE_SIZE);
+
+	set_p4d(p4d, __p4d(_KERNPG_TABLE + (unsigned long) __pa(pud_table)));
+	BUG_ON(pud_table != pud_offset(p4d, 0));
+#endif
+}
+
 static void __init fixrange_init(unsigned long start, unsigned long end,
 				 pgd_t *pgd_base)
 {
@@ -126,6 +139,8 @@ static void __init fixrange_init(unsigned long start, unsigned long end,
 
 	for ( ; (i < PTRS_PER_PGD) && (vaddr < end); pgd++, i++) {
 		p4d = p4d_offset(pgd, vaddr);
+		if (p4d_none(*p4d))
+			one_ud_table_init(p4d);
 		pud = pud_offset(p4d, vaddr);
 		if (pud_none(*pud))
 			one_md_table_init(pud);
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 186f13268401..f7a527ad704c 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -28,16 +28,34 @@ config X86_64
 	def_bool 64BIT
 	select MODULES_USE_ELF_RELA
 
-config 3_LEVEL_PGTABLES
-	bool "Three-level pagetables" if !64BIT
-	default 64BIT
-	help
-	  Three-level pagetables will let UML have more than 4G of physical
-	  memory.  All the memory that can't be mapped directly will be treated
-	  as high memory.
-
-	  However, this it experimental on 32-bit architectures, so if unsure say
-	  N (on x86-64 it's automatically enabled, instead, as it's safe there).
+choice
+	prompt "Pagetable levels"
+	default 2_LEVEL_PGTABLES if !64BIT
+	default 4_LEVEL_PGTABLES if 64BIT
+
+	config 2_LEVEL_PGTABLES
+		bool "Two-level pagetables" if !64BIT
+		depends on !64BIT
+		help
+		  Two-level page table for 32-bit architectures.
+
+	config 3_LEVEL_PGTABLES
+		bool "Three-level pagetables" if 64BIT || (!64BIT && EXPERT)
+		help
+		  Three-level pagetables will let UML have more than 4G of
+		  physical memory. All the memory that can't be mapped
+		  directly will be treated as high memory.
+
+		  However, this it experimental on 32-bit architectures, so if
+		  unsure say N
+
+	config 4_LEVEL_PGTABLES
+		bool "Four-level pagetables" if 64BIT
+		depends on 64BIT
+		help
+		  Four-level pagetables, results in a bigger address space
+		  which can be useful for some applications (e.g. ASAN).
+endchoice
 
 config ARCH_HAS_SC_SIGNALS
 	def_bool !64BIT
-- 
2.45.2


