Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 18 Mar 2011 19:49:29 +0000
From: Prasad Joshi <prasadjoshi124@gmail.com>
Message-ID: <20110318194929.GE4746@prasad-kvm>
References: <20110318194135.GA4746@prasad-kvm>
 <20110318194341.GB4746@prasad-kvm>
 <20110318194600.GC4746@prasad-kvm>
 <20110318194740.GD4746@prasad-kvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110318194740.GD4746@prasad-kvm>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [RFC][PATCH v3 04/22] mm, um: add gfp flags variant of pmd and
 pte allocations
To: jdike@addtoit.com, tj@kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, prasadjoshi124@gmail.com, mitra@kqinfotech.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


- Added __pte_alloc_one_kernel() which is similar to pte_alloc_one_kernel()
  but accepts an additional parameter to be used during page allocation.

- The function pte_alloc_one_kernel() has been modified to call
  __pte_alloc_one_kernel().

- The similar changes are done for pmd allocations. The name of the newly
  added function is __pmd_alloc_one().

- changes help in fixing the Bug 30702

Signed-off-by: Prasad Joshi <prasadjoshi124@gmail.com>
Signed-off-by: Anand Mitra <mitra@kqinfotech.com>
---
 arch/um/include/asm/pgalloc.h |    1 +
 arch/um/kernel/mem.c          |   21 +++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 32c8ce4..8b6257e 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -27,6 +27,7 @@ extern pgd_t *pgd_alloc(struct mm_struct *);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
+extern pte_t *__pte_alloc_one_kernel(struct mm_struct *, unsigned long, gfp_t);
 extern pgtable_t pte_alloc_one(struct mm_struct *, unsigned long);
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 8137ccc..e4caf17 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -284,12 +284,15 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	free_page((unsigned long) pgd);
 }
 
-pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+pte_t *
+__pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address, gfp_t gfp_mask)
 {
-	pte_t *pte;
+	return (pte_t *)__get_free_page(gfp_mask | __GFP_ZERO);
+}
 
-	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
-	return pte;
+pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+{
+	return __pte_alloc_one_kernel(mm, address, GFP_KERNEL | __GFP_REPEAT);
 }
 
 pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
@@ -303,15 +306,21 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 }
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
-pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
+pmd_t *
+__pmd_alloc_one(struct mm_struct *mm, unsigned long address, gfp_t gfp_mask)
 {
-	pmd_t *pmd = (pmd_t *) __get_free_page(GFP_KERNEL);
+	pmd_t *pmd = (pmd_t *) __get_free_page(gfp_mask);
 
 	if (pmd)
 		memset(pmd, 0, PAGE_SIZE);
 
 	return pmd;
 }
+
+pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	return __pmd_alloc_one(mm, address, GFP_KERNEL);
+}
 #endif
 
 void *uml_kmalloc(int size, int flags)
-- 
1.7.0.4

