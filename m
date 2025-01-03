Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7B3E77198
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bDYv+lD8IINsE762iomZ4bq5tahQltx5gkKZxMzCtrk=; b=Xz1EdcvTyjE1rDIjuuftXLCXd0
	OldWB2f/7ZRvgTYmnWjfIlpFXwcniqJDe6TxAl14hPveu6BfvYyqo1E7/I5TUgrQAirUeciyl0s8D
	DWPs1ItdIhQDVNrhmgqB/XvEqStOuzFlzFbsjpQCaMzIwEEBUDY2DTXrGLaxhzURjIi/wE/6jU640
	eOArwOsTl8puZZ3/2GWWNcr15N23nkU1vgWZWFXrNXHo7sLlMg2yMf4TFt2QJvnj9Zi/vkD6Pf0Ig
	zYosaXBNnw0TrFSfFb0bi3SCytypHjkO12PQj7dy6puzS9An/LgXPIQUPbS6uI7fAseS2wtJhkqEa
	mUTfpj/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTmn9-0000000DltT-3T0D;
	Fri, 03 Jan 2025 18:53:03 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTmfH-0000000Djbt-3Tif;
	Fri, 03 Jan 2025 18:44:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 575781C14;
	Fri,  3 Jan 2025 10:45:23 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2191A3F673;
	Fri,  3 Jan 2025 10:44:51 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	loongarch@lists.linux.dev,
	x86@kernel.org
Subject: [PATCH v2 6/6] mm: Introduce ctor/dtor at PGD level
Date: Fri,  3 Jan 2025 18:44:15 +0000
Message-ID: <20250103184415.2744423-7-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250103184415.2744423-1-kevin.brodsky@arm.com>
References: <20250103184415.2744423-1-kevin.brodsky@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_104455_955623_232B8B04 
X-CRM114-Status: GOOD (  13.05  )
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

Following on from the introduction of P4D-level ctor/dtor, let's
finish the job and introduce ctor/dtor at PGD level. The incurred
improvement in page accounting is minimal - the main motivation is
to create a single, generic place where construction/destruction
hooks can be added for all page table pages.

This patch should cover all architectures and all configurations
where PGDs are one or more regular pages. This excludes any
configuration where PGDs are allocated from a kmem_cache object.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/m68k/include/asm/mcf_pgalloc.h | 3 ++-
 arch/m68k/mm/motorola.c             | 6 ++++--
 arch/s390/include/asm/pgalloc.h     | 9 ++++++++-
 include/asm-generic/pgalloc.h       | 3 ++-
 include/linux/mm.h                  | 5 +++++
 5 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 22d6c1fcabfb..4c648b51e7fd 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -73,7 +73,7 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	pagetable_free(virt_to_ptdesc(pgd));
+	pagetable_dtor_free(virt_to_ptdesc(pgd));
 }
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
@@ -84,6 +84,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 	if (!ptdesc)
 		return NULL;
+	pagetable_pgd_ctor(ptdesc);
 	new_pgd = ptdesc_address(ptdesc);
 
 	memcpy(new_pgd, swapper_pg_dir, PTRS_PER_PGD * sizeof(pgd_t));
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 6c09ccb72e8b..73651e093c4d 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -169,6 +169,9 @@ void *get_pointer_table(int type)
 		case TABLE_PMD:
 			pagetable_pmd_ctor(virt_to_ptdesc(page));
 			break;
+		case TABLE_PGD:
+			pagetable_pgd_ctor(virt_to_ptdesc(page));
+			break;
 		}
 
 		mmu_page_ctor(page);
@@ -207,8 +210,7 @@ int free_pointer_table(void *table, int type)
 		/* all tables in page are free, free page */
 		list_del(dp);
 		mmu_page_dtor((void *)page);
-		if (type == TABLE_PTE || type == TABLE_PMD)
-			pagetable_dtor(virt_to_ptdesc((void *)page));
+		pagetable_dtor(virt_to_ptdesc((void *)page));
 		free_page (page);
 		return 1;
 	} else if (ptable_list[type].next != dp) {
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 5fced6d3c36b..b19b6ed2ab53 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -130,11 +130,18 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return (pgd_t *) crst_table_alloc(mm);
+	unsigned long *table = crst_table_alloc(mm);
+
+	if (!table)
+		return NULL;
+	pagetable_pgd_ctor(virt_to_ptdesc(table));
+
+	return (pgd_t *) table;
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
+	pagetable_dtor(virt_to_ptdesc(pgd));
 	crst_table_free(mm, (unsigned long *) pgd);
 }
 
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index de4df14158e6..892ece4558a2 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -271,6 +271,7 @@ static inline pgd_t *__pgd_alloc_noprof(struct mm_struct *mm, unsigned int order
 	if (!ptdesc)
 		return NULL;
 
+	pagetable_pgd_ctor(ptdesc);
 	return ptdesc_address(ptdesc);
 }
 #define __pgd_alloc(...)	alloc_hooks(__pgd_alloc_noprof(__VA_ARGS__))
@@ -280,7 +281,7 @@ static inline void __pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pgd);
 
 	BUG_ON((unsigned long)pgd & (PAGE_SIZE-1));
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PGD_FREE
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 065fa9449d03..486638d22fc6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3243,6 +3243,11 @@ static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
 	__pagetable_ctor(ptdesc);
 }
 
+static inline void pagetable_pgd_ctor(struct ptdesc *ptdesc)
+{
+	__pagetable_ctor(ptdesc);
+}
+
 extern void __init pagecache_init(void);
 extern void free_initmem(void);
 
-- 
2.47.0


