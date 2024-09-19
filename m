Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA05ACE8D7D
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 12:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NKcLQJ6viXVOi6AvbKrVTd+q6I4BBIzVwNJehKWxq9w=; b=aRYEjYjWpdjotOwRU/HMDnjp2y
	vmbNOLZfgNYwVdOJZZz3+QW/gOgggWMJihrYmroE20nP01UuER+nM8CIFZSo5Y+C9jyGmsXcFjyp8
	XwkPAYJwAjWCIWtAuRSlU4hTzpfKWxhYIZweXjYP4o0p/W8I7igOmOTDNs4KCJsMIfm+2OYAqJc8f
	FBY8nBoF/WtztZ9EoS3Huk17nOdjmCewlqq0f7rqwt4yGrtgTcsYWJ1CUSCr2ys18zprbm+vJZlDf
	TjlnfJYLIzWsan0NRIyrU0RTVd7fCgiBXnJQGj0+aHrMFBwW3BdNCKSbVFf5STenpC+cn3OAG8ejJ
	ijkm+O8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXk-0000000AGxJ-1LTX;
	Thu, 19 Sep 2024 12:45:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXh-0000000AGvC-2hzR
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 12:45:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NKcLQJ6viXVOi6AvbKrVTd+q6I4BBIzVwNJehKWxq9w=;
	t=1726749953; x=1727959553; b=TyTbb13Q9nIz2pTLMSDM8siqCXHd7ObMJNXWIJ2sPXhXC9C
	2N4ORZo5sDsUfU2CNrIkF+Ckz4lqGn2OAMOoF0mV7lxkKYb/fiiY1ZZ49drXmWsek8Jj/triU5/Dg
	6gFDtjoMXSTzmLGZ1a6+oeeFTxiIXF3RZ4tULOMh9NhDnA0WFF5e91GE7pWtUZXxRhzH865CglBS2
	Sm8J+A65wGsRMRPhUipcvirG2rZT2FZKz6LfCUgpWDXCFRbmQUS3jv9uXyVkzWI1NPC+9tCFKYRYL
	JpzO500c20KJXxLd9MRcCnf8HgXW71nsS7neMDvLop4xcupv7kJfZuo8EhMlFn+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1srGXe-000000047AZ-2UBE;
	Thu, 19 Sep 2024 14:45:51 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v9 10/10] um: Switch to 4 level page tables on 64 bit
Date: Thu, 19 Sep 2024 14:45:11 +0200
Message-ID: <20240919124511.282088-11-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919124511.282088-1-benjamin@sipsolutions.net>
References: <20240919124511.282088-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_054553_875219_D8217DED 
X-CRM114-Status: GOOD (  18.00  )
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

v9:
- Drop support for 3 level page tables

v7:
- Reword options and fix documentation of x86-64 default

v2:
- Do not hide option behind the EXPERT flag
- Fix typo in new "Two-level pagetables" option

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/Kconfig                               |  4 +-
 arch/um/include/asm/page.h                    | 14 +++++--
 arch/um/include/asm/pgalloc.h                 | 11 ++++-
 .../{pgtable-3level.h => pgtable-4level.h}    | 40 ++++++++++++++++---
 arch/um/include/asm/pgtable.h                 |  8 ++--
 arch/um/kernel/mem.c                          | 17 +++++++-
 arch/x86/um/Kconfig                           |  3 --
 7 files changed, 78 insertions(+), 19 deletions(-)
 rename arch/um/include/asm/{pgtable-3level.h => pgtable-4level.h} (66%)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index c89575d05021..48db1c99bd46 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -209,8 +209,8 @@ config MMAPPER
 
 config PGTABLE_LEVELS
 	int
-	default 3 if 3_LEVEL_PGTABLES
-	default 2
+	default 4 if 64BIT
+	default 2 if !64BIT
 
 config UML_TIME_TRAVEL_SUPPORT
 	bool
diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 8d2ac5e86cf5..f0ad80fc8c10 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -35,14 +35,22 @@ struct page;
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
diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-4level.h
similarity index 66%
rename from arch/um/include/asm/pgtable-3level.h
rename to arch/um/include/asm/pgtable-4level.h
index 3504a92dc485..f912fcc16b7a 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-4level.h
@@ -4,17 +4,25 @@
  * Derived from include/asm-i386/pgtable.h
  */
 
-#ifndef __UM_PGTABLE_3LEVEL_H
-#define __UM_PGTABLE_3LEVEL_H
+#ifndef __UM_PGTABLE_4LEVEL_H
+#define __UM_PGTABLE_4LEVEL_H
 
-#include <asm-generic/pgtable-nopud.h>
+#include <asm-generic/pgtable-nop4d.h>
 
-/* PGDIR_SHIFT determines what a third-level page table entry can map */
+/* PGDIR_SHIFT determines what a fourth-level page table entry can map */
 
-#define PGDIR_SHIFT	30
+#define PGDIR_SHIFT	39
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
+/* PUD_SHIFT determines the size of the area a third-level page table can
+ * map
+ */
+
+#define PUD_SHIFT	30
+#define PUD_SIZE	(1UL << PUD_SHIFT)
+#define PUD_MASK	(~(PUD_SIZE-1))
+
 /* PMD_SHIFT determines the size of the area a second-level page table can
  * map
  */
@@ -29,6 +37,7 @@
 
 #define PTRS_PER_PTE 512
 #define PTRS_PER_PMD 512
+#define PTRS_PER_PUD 512
 #define PTRS_PER_PGD 512
 
 #define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
@@ -39,6 +48,9 @@
 #define pmd_ERROR(e) \
         printk("%s:%d: bad pmd %p(%016lx).\n", __FILE__, __LINE__, &(e), \
 	       pmd_val(e))
+#define pud_ERROR(e) \
+        printk("%s:%d: bad pud %p(%016lx).\n", __FILE__, __LINE__, &(e), \
+	       pud_val(e))
 #define pgd_ERROR(e) \
         printk("%s:%d: bad pgd %p(%016lx).\n", __FILE__, __LINE__, &(e), \
 	       pgd_val(e))
@@ -51,6 +63,15 @@
 
 #define set_pud(pudptr, pudval) (*(pudptr) = (pudval))
 
+#define p4d_none(x)	(!(p4d_val(x) & ~_PAGE_NEWPAGE))
+#define	p4d_bad(x)	((p4d_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
+#define p4d_present(x)	(p4d_val(x) & _PAGE_PRESENT)
+#define p4d_populate(mm, p4d, pud) \
+	set_p4d(p4d, __p4d(_PAGE_TABLE + __pa(pud)))
+
+#define set_p4d(p4dptr, p4dval) (*(p4dptr) = (p4dval))
+
+
 static inline int pgd_newpage(pgd_t pgd)
 {
 	return(pgd_val(pgd) & _PAGE_NEWPAGE);
@@ -65,9 +86,17 @@ static inline void pud_clear (pud_t *pud)
 	set_pud(pud, __pud(_PAGE_NEWPAGE));
 }
 
+static inline void p4d_clear (p4d_t *p4d)
+{
+	set_p4d(p4d, __p4d(_PAGE_NEWPAGE));
+}
+
 #define pud_page(pud) phys_to_page(pud_val(pud) & PAGE_MASK)
 #define pud_pgtable(pud) ((pmd_t *) __va(pud_val(pud) & PAGE_MASK))
 
+#define p4d_page(p4d) phys_to_page(p4d_val(p4d) & PAGE_MASK)
+#define p4d_pgtable(p4d) ((pud_t *) __va(p4d_val(p4d) & PAGE_MASK))
+
 static inline unsigned long pte_pfn(pte_t pte)
 {
 	return phys_to_pfn(pte_val(pte));
@@ -88,4 +117,3 @@ static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 }
 
 #endif
-
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 83373c9963e7..bd7a9593705f 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -24,10 +24,12 @@
 /* We borrow bit 10 to store the exclusive marker in swap PTEs. */
 #define _PAGE_SWP_EXCLUSIVE	0x400
 
-#ifdef CONFIG_3_LEVEL_PGTABLES
-#include <asm/pgtable-3level.h>
-#else
+#if CONFIG_PGTABLE_LEVELS == 4
+#include <asm/pgtable-4level.h>
+#elif CONFIG_PGTABLE_LEVELS == 2
 #include <asm/pgtable-2level.h>
+#else
+#error "Unsupported number of page table levels"
 #endif
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
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
index 7d16baba8f5f..41bc9221c454 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -28,9 +28,6 @@ config X86_64
 	def_bool 64BIT
 	select MODULES_USE_ELF_RELA
 
-config 3_LEVEL_PGTABLES
-	def_bool 64BIT
-
 config ARCH_HAS_SC_SIGNALS
 	def_bool !64BIT
 
-- 
2.46.0


