Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F13E7718B
	for <linux-um@archiver.kernel.org>; Thu, 19 Dec 2024 18:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SXme/GytDIOL4n/9MQ9Cf0OJewNEVpT4E5Wg5Chg+u0=; b=L+txsPzp+gMt1tL7OGrFK+VuE9
	ZWPgFA3pv+1IL82mOZcE5vVvf4Llm5t2FdBzGZHV3+OAh+fDLu8Z3TYIEhPDpEE0bfoenK7PiV8bu
	5X1X/nOeOQDrxTuwT+RvoXug7GKw6S0ZGUqvNKQUxlevD3jWojmIfRWrcS+bvAN21YYJo67mgQd39
	QUQ1tmicZgBKUguo9vf0bM8Vn7uEbG16EYqkqRHa5pvf3NlrlUm2vdzBWy1aA6LjMLIWwBNf9MvBI
	030dnUt0dmKZW14Tp9Wx++59BBC45T2gsN3EMGYF2VPL8SaxVB3hufLo0zAP0fH8y+IuhAb9E23pz
	XQOLbwbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOKyd-00000002hJG-0zta;
	Thu, 19 Dec 2024 18:10:23 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOJfp-00000002PbD-2K5W;
	Thu, 19 Dec 2024 16:46:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46F061480;
	Thu, 19 Dec 2024 08:47:21 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47EE93F58B;
	Thu, 19 Dec 2024 08:46:49 -0800 (PST)
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
Subject: [PATCH 10/10] mm: Introduce ctor/dtor at PGD level
Date: Thu, 19 Dec 2024 16:44:25 +0000
Message-ID: <20241219164425.2277022-11-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219164425.2277022-1-kevin.brodsky@arm.com>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_084653_673972_A706D89F 
X-CRM114-Status: GOOD (  13.07  )
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

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/m68k/include/asm/mcf_pgalloc.h |  2 ++
 arch/m68k/mm/motorola.c             |  6 ++++++
 arch/s390/include/asm/pgalloc.h     |  8 +++++++-
 include/asm-generic/pgalloc.h       |  2 ++
 include/linux/mm.h                  | 10 ++++++++++
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 302c5bf67179..7bb9652e1d67 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -73,6 +73,7 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
+	pagetable_pgd_dtor(virt_to_ptdesc(pgd));
 	pagetable_free(virt_to_ptdesc(pgd));
 }
 
@@ -84,6 +85,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 	if (!ptdesc)
 		return NULL;
+	pagetable_pgd_ctor(ptdesc);
 	new_pgd = ptdesc_address(ptdesc);
 
 	memcpy(new_pgd, swapper_pg_dir, PTRS_PER_PGD * sizeof(pgd_t));
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 37010ee15928..b0fbb369589f 100644
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
@@ -215,6 +218,9 @@ int free_pointer_table(void *table, int type)
 		case TABLE_PMD:
 			pagetable_pmd_dtor(virt_to_ptdesc((void *)page));
 			break;
+		case TABLE_PGD:
+			pagetable_pgd_dtor(virt_to_ptdesc((void *)page));
+			break;
 		}
 
 		free_page (page);
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 85a5d07365aa..00b69f4ddf17 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -126,11 +126,17 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return (pgd_t *) crst_table_alloc(mm);
+	unsigned long *table = crst_table_alloc(mm);
+
+	if (!table)
+		return NULL;
+	pagetable_pgd_ctor(virt_to_ptdesc(table));
+	return (pgd_t *) table;
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
+	pagetable_pgd_dtor(virt_to_ptdesc(pgd));
 	crst_table_free(mm, (unsigned long *) pgd);
 }
 
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index daa8bea36952..112b09dc992e 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -275,6 +275,7 @@ static inline pgd_t *__pgd_alloc_noprof(struct mm_struct *mm, unsigned int order
 	if (!ptdesc)
 		return NULL;
 
+	pagetable_pgd_ctor(ptdesc);
 	return ptdesc_address(ptdesc);
 }
 #define __pgd_alloc(...)	alloc_hooks(__pgd_alloc_noprof(__VA_ARGS__))
@@ -284,6 +285,7 @@ static inline void __pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pgd);
 
 	BUG_ON((unsigned long)pgd & (PAGE_SIZE-1));
+	pagetable_pgd_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e8b92f4bf3f1..7347da3460c5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3171,6 +3171,16 @@ static inline void pagetable_p4d_dtor(struct ptdesc *ptdesc)
 	__pagetable_dtor(ptdesc);
 }
 
+static inline void pagetable_pgd_ctor(struct ptdesc *ptdesc)
+{
+	__pagetable_ctor(ptdesc);
+}
+
+static inline void pagetable_pgd_dtor(struct ptdesc *ptdesc)
+{
+	__pagetable_dtor(ptdesc);
+}
+
 extern void __init pagecache_init(void);
 extern void free_initmem(void);
 
-- 
2.47.0


