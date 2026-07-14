Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9F5C44508
	for <linux-um@archiver.kernel.org>; Tue, 14 Jul 2026 14:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3zQydgPZJ7Jyvl0nKZs4MsunHOywP/c9ek9M9Qkn7Jk=; b=Ob9zBLHGbQNGQTFf1hOeTwBJIU
	+AzjmHeIcrucENeEebv20c8lKkJH66IcfEgXpDWH6cW7RSv/IlH4eypv957rOO7qFlfVm0Vemophc
	QVT5xX9aZ8R4lwqldZ+MEMeGeJoSK/4Mo9AEjOIwn9cDxRx1xfY2vQ9iez/ZcS1cprvaWxpIsTjyD
	tQi6wIfQFpaVJE3Q05JPJhcXR8S8TE/NkA2/L8/54DEMX4kp06gXNYGEIC0APzRkddBPTK3xM5WGl
	FzpChigNmhP75phNhB3ya6ngBcazFyaEriwTd1Nsk7Dd7vbFedtFkrOqwK2AyDHm8LCCOCr7CgUO7
	1ppWmFLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdmt-0000000CJIQ-28kK;
	Tue, 14 Jul 2026 14:07:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdmr-0000000CJG1-3lU6;
	Tue, 14 Jul 2026 14:07:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=3zQydgPZJ7Jyvl0nKZs4MsunHOywP/c9ek9M9Qkn7Jk=; b=QWEcJSOR+qNi966uvx8Ka3glyG
	3dU4UISHuyCNy9tz6UTOssriX6McJoZC2IhHw5KaupQQf1Vt3E11/8t28AMkdMd6EHFDhdRt1CN6Y
	oA/pA4pdmpSbwVFU5AWP4UwgiWiJmf97tZb2iV55XzhyiyeoTHZ8/7kvCHs3tEOJKRz8vKS+AzaH0
	L+80nBvDSY4BWc+nRvaIfjf7UiCV95TdfxKO0MF5L6Dj8cqXIjv5eepzeIX1xDV/gHrZnJz5QQqfY
	yEruORCwrLU2xiNl+nCJFvwpaa37umqO9EI+gRG7LrCMI9uNyxqqV7hi3Tf5URUUGtRFVAjz8qQiE
	GN4ysitA==;
Received: from foss.arm.com ([217.140.110.172])
	by desiato.infradead.org with esmtp (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjdmm-0000000CZJa-1l5n;
	Tue, 14 Jul 2026 14:07:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AFDD1C00;
	Tue, 14 Jul 2026 07:06:54 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB3453FBB1;
	Tue, 14 Jul 2026 07:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038018; bh=4PNxqxq/jrUer27xvNkwvequvxQnPhBMXV3o8mC51Ps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WLxWEHcbiO2GB5LbtNB+92/zwEdWv+8J6pCRQbs3PGmarOdTkL8G1gUMIDPggJIxD
	 N9phhhgOR7QXBCkkB6FWwKpw6kiO73Y49hy9kAZeBD1ExbuR501MLF5gHb3/X1UjRF
	 0YbOoaXts+8XwZ3/78QN/pRZ3IolUppQVMb9mRqM=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:03 +0100
Subject: [PATCH 14/22] mm: set page table page type when allocated
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
To: linux-mm@kvack.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org, 
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-s390@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ning Sun <ning.sun@intel.com>, 
 x86@kernel.org, tboot-devel@lists.sourceforge.net, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, 
 Vishal Moola <vishal.moola@gmail.com>, Alistair Popple <apopple@nvidia.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=3368;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=4PNxqxq/jrUer27xvNkwvequvxQnPhBMXV3o8mC51Ps=;
 b=0VdQOf0nra1WPYggXNBDDOliZvhTj/vQmWZ9BxkvIcGSO9bbshMd8ZPkLRqWmNwzRE1zk4sMb
 RKD72ZNcXaiBd0YaTV+GgCHvQw7s/IzNuDs0JxkPVAN8TuJt7kaNkpn
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_150701_062905_C831A04F 
X-CRM114-Status: GOOD (  14.23  )
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

As a step towards removing pagetable ctor/dtor calls for kernel
mm's, move the page type updates from the ctor/dtor to
pagetable_{alloc,free}.

__pagetable_ctor() is now empty so remove it;
pagetable_{pud,p4d,pgd}_ctor() will be removed at a later stage.

The ctor is normally called after pagetable_alloc() (and dtor before
pagetable_free()) so this patch should have no functional effect in
most cases. Where calls to ctor/dtor are currently missing (e.g.
x86's split_large_page()), this patch will ensure the page type is
set correctly.

This patch is based on Matthew's earlier implementation linked
below, with the difference that when freeing the page type is
cleared in __pagetable_free(), meaning that the update is delayed
until the pages are actually freed in the
CONFIG_ASYNC_KERNEL_PGTABLE_FREE case. This shouldn't matter in
practice.

Suggested-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Link: https://lore.kernel.org/r/20251113140448.1814860-4-willy@infradead.org
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 include/linux/mm.h | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 361a0d7b74c5..94f0fb1c662a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3684,6 +3684,7 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
 	if (!page)
 		return NULL;
 
+	__folio_set_pgtable(page_folio(page));
 	lruvec_stat_add_folio(page_folio(page), NR_PAGETABLE);
 
 	return page_ptdesc(page);
@@ -3694,6 +3695,7 @@ static inline void __pagetable_free(struct ptdesc *pt)
 {
 	struct page *page = ptdesc_page(pt);
 
+	__folio_clear_pgtable(page_folio(page));
 	lruvec_stat_sub_folio(page_folio(page), NR_PAGETABLE);
 
 	__free_pages(page, compound_order(page));
@@ -3799,19 +3801,9 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct ptdesc *ptdesc) {}
 #endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
 
-static inline void __pagetable_ctor(struct ptdesc *ptdesc)
-{
-	struct folio *folio = ptdesc_folio(ptdesc);
-
-	__folio_set_pgtable(folio);
-}
-
 static inline void pagetable_dtor(struct ptdesc *ptdesc)
 {
-	struct folio *folio = ptdesc_folio(ptdesc);
-
 	ptlock_free(ptdesc);
-	__folio_clear_pgtable(folio);
 }
 
 static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
@@ -3825,7 +3817,6 @@ static inline bool pagetable_pte_ctor(struct mm_struct *mm,
 {
 	if (!mm_is_kernel(mm) && !ptlock_init(ptdesc))
 		return false;
-	__pagetable_ctor(ptdesc);
 	return true;
 }
 
@@ -3917,7 +3908,6 @@ static inline bool pagetable_pmd_ctor(struct mm_struct *mm,
 	if (!mm_is_kernel(mm) && !pmd_ptlock_init(ptdesc))
 		return false;
 	ptdesc_pmd_pts_init(ptdesc);
-	__pagetable_ctor(ptdesc);
 	return true;
 }
 
@@ -3942,17 +3932,14 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 
 static inline void pagetable_pud_ctor(struct ptdesc *ptdesc)
 {
-	__pagetable_ctor(ptdesc);
 }
 
 static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
 {
-	__pagetable_ctor(ptdesc);
 }
 
 static inline void pagetable_pgd_ctor(struct ptdesc *ptdesc)
 {
-	__pagetable_ctor(ptdesc);
 }
 
 extern void __init pagecache_init(void);

-- 
2.51.2


