Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D575E77184
	for <linux-um@archiver.kernel.org>; Thu, 19 Dec 2024 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=URvkOy53UcBsPFjkdm3DY6eWupuu8tvChY7EKfoY7IQ=; b=vw/MNdAhs/PF8YNiqbu/VF6FjF
	ENJcylkxjNDoUrwvMSyS1yBXQb1jWTn/ggFogfqn4v6kUOJitNk8SSsdEfrQTIQJVSwn/+pN8vQ2l
	mq6Rs0LlXYNL5nOSTUbYpwmmoB5kmu5m4aIEASmPT/bpBNFaK38zuJVBzJSpVAHJUpJ+C14iPhlPL
	PCLIwTAvzyc1dRDBKSxfVtU3TqOkzD7q4GRN8XGHoJhxYGylOtviYnWiG7aeR12U8iRuqmxro7Z/k
	8g42F4MpE6G5G52t77OnrfjL91wkVs27h7GrW0oejA7axGWLmPSfOXHB3KyTkFf12GyXa6FLvqp/3
	tAXxTuFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOJk3-00000002Qnp-0mjo;
	Thu, 19 Dec 2024 16:51:15 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOJfM-00000002PM1-2AUT;
	Thu, 19 Dec 2024 16:46:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEB531480;
	Thu, 19 Dec 2024 08:46:51 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C069C3F58B;
	Thu, 19 Dec 2024 08:46:19 -0800 (PST)
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
Subject: [PATCH 03/10] m68k: mm: Add calls to pagetable_pmd_[cd]tor
Date: Thu, 19 Dec 2024 16:44:18 +0000
Message-ID: <20241219164425.2277022-4-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219164425.2277022-1-kevin.brodsky@arm.com>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_084624_681851_22EA2490 
X-CRM114-Status: GOOD (  15.13  )
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

get_pointer_table() and free_pointer_table() already special-case
TABLE_PTE to call pagetable_pte_[cd]tor. Let's do the same at PMD
level to improve accounting further. TABLE_PGD and TABLE_PMD are
currently defined to the same value, so we first need to separate
them. That also implies separating ptable_list for PMD/PGD levels.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/m68k/include/asm/motorola_pgalloc.h |  6 +++---
 arch/m68k/mm/motorola.c                  | 25 +++++++++++++++++++-----
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/include/asm/motorola_pgalloc.h b/arch/m68k/include/asm/motorola_pgalloc.h
index 74a817d9387f..5abe7da8ac5a 100644
--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -9,9 +9,9 @@ extern void mmu_page_ctor(void *page);
 extern void mmu_page_dtor(void *page);
 
 enum m68k_table_types {
-	TABLE_PGD = 0,
-	TABLE_PMD = 0, /* same size as PGD */
-	TABLE_PTE = 1,
+	TABLE_PGD,
+	TABLE_PMD,
+	TABLE_PTE,
 };
 
 extern void init_pointer_table(void *table, int type);
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index c1761d309fc6..37010ee15928 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -97,17 +97,19 @@ void mmu_page_dtor(void *page)
 
 typedef struct list_head ptable_desc;
 
-static struct list_head ptable_list[2] = {
+static struct list_head ptable_list[3] = {
 	LIST_HEAD_INIT(ptable_list[0]),
 	LIST_HEAD_INIT(ptable_list[1]),
+	LIST_HEAD_INIT(ptable_list[2]),
 };
 
 #define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page((void *)(page))->lru))
 #define PD_PAGE(ptable) (list_entry(ptable, struct page, lru))
 #define PD_MARKBITS(dp) (*(unsigned int *)&PD_PAGE(dp)->index)
 
-static const int ptable_shift[2] = {
-	7+2, /* PGD, PMD */
+static const int ptable_shift[3] = {
+	7+2, /* PGD */
+	7+2, /* PMD */
 	6+2, /* PTE */
 };
 
@@ -156,12 +158,17 @@ void *get_pointer_table(int type)
 		if (!(page = (void *)get_zeroed_page(GFP_KERNEL)))
 			return NULL;
 
-		if (type == TABLE_PTE) {
+		switch (type) {
+		case TABLE_PTE:
 			/*
 			 * m68k doesn't have SPLIT_PTE_PTLOCKS for not having
 			 * SMP.
 			 */
 			pagetable_pte_ctor(virt_to_ptdesc(page));
+			break;
+		case TABLE_PMD:
+			pagetable_pmd_ctor(virt_to_ptdesc(page));
+			break;
 		}
 
 		mmu_page_ctor(page);
@@ -200,8 +207,16 @@ int free_pointer_table(void *table, int type)
 		/* all tables in page are free, free page */
 		list_del(dp);
 		mmu_page_dtor((void *)page);
-		if (type == TABLE_PTE)
+
+		switch (type) {
+		case TABLE_PTE:
 			pagetable_pte_dtor(virt_to_ptdesc((void *)page));
+			break;
+		case TABLE_PMD:
+			pagetable_pmd_dtor(virt_to_ptdesc((void *)page));
+			break;
+		}
+
 		free_page (page);
 		return 1;
 	} else if (ptable_list[type].next != dp) {
-- 
2.47.0


