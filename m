Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C378C54EBE
	for <linux-um@archiver.kernel.org>; Fri, 13 Jan 2023 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hzvQDj9Z/T75IxeoKJiBmwrlIY2RwuBPaBTDpfj303I=; b=1xwvRDFpRhD5Eh
	+JWpY3XL/fQuo507nadPVUfYHCYOoXNkI1ow6UpyhFE4rW1PNbsv2QsuvjiQJfp7GCXRlfzjgl5IJ
	M1i0yg+1oM+3Pbn5yuj8Lzpk7NA3VHyZrxO0hWrMcN8M4jBy44IawEYBhHEylg1nWO9pqVNiXazwU
	AJFBOcE23Jnszc6dtJi0BCNkgj19P9J8ghYIkwbmDmRLsF+pwkZLZh2xgga1o2CNUUo/tx/cpuNXN
	fGvxwiOwRCuPbv5snC5R7gYup7Mcg3fiNzQCsZjlQ7EEYN+LazFqYjGNr4v3hxUWRx3JwqcLfceXB
	VbFHRxwwTD9VFKoTFfzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGNaP-003aDl-GL; Fri, 13 Jan 2023 17:11:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGNaB-003a2h-DX
	for linux-um@lists.infradead.org; Fri, 13 Jan 2023 17:11:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673629869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsZI6CBJjkMgqSDB0pNEUq6oiZDvtrxY4s2APwPC8ec=;
	b=Lu+hGEvUxsuX6r/SOmQehHWN73U1MFMX2bdGcum5DIlgcSwf1h+NB8oWFdtOJwrScMdaqy
	XfuRrLF/Td00/BQBAZYCry81GPAP1xQIqAiHEPn+5u80au9k/rABRMAD2Tn5Tiji1BjvVx
	f5QYblUYYSTs+DXgpQzLZkhIEbnsm8E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-ElAanbZ3Nt6z3bJp0Ss8PQ-1; Fri, 13 Jan 2023 12:11:08 -0500
X-MC-Unique: ElAanbZ3Nt6z3bJp0Ss8PQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A512010113C2;
	Fri, 13 Jan 2023 17:11:06 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7DEC840C2064;
	Fri, 13 Jan 2023 17:11:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Yang Shi <shy828301@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Nadav Amit <namit@vmware.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	linux-mm@kvack.org,
	x86@kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-ia64@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	openrisc@lists.librecores.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-xtensa@linux-xtensa.org,
	David Hildenbrand <david@redhat.com>,
	Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH mm-unstable v1 03/26] arc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date: Fri, 13 Jan 2023 18:10:03 +0100
Message-Id: <20230113171026.582290-4-david@redhat.com>
In-Reply-To: <20230113171026.582290-1-david@redhat.com>
References: <20230113171026.582290-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230113_091111_618901_9C329DC5 
X-CRM114-Status: GOOD (  13.34  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by using bit 5, which is yet
unused. The only important parts seems to be to not use _PAGE_PRESENT
(bit 9).

Cc: Vineet Gupta <vgupta@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arc/include/asm/pgtable-bits-arcv2.h | 27 ++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/asm/pgtable-bits-arcv2.h
index 515e82db519f..611f412713b9 100644
--- a/arch/arc/include/asm/pgtable-bits-arcv2.h
+++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
@@ -26,6 +26,9 @@
 #define _PAGE_GLOBAL		(1 << 8)  /* ASID agnostic (H) */
 #define _PAGE_PRESENT		(1 << 9)  /* PTE/TLB Valid (H) */
 
+/* We borrow bit 5 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	_PAGE_DIRTY
+
 #ifdef CONFIG_ARC_MMU_V4
 #define _PAGE_HW_SZ		(1 << 10)  /* Normal/super (H) */
 #else
@@ -106,9 +109,18 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		      pte_t *ptep);
 
-/* Encode swap {type,off} tuple into PTE
- * We reserve 13 bits for 5-bit @type, keeping bits 12-5 zero, ensuring that
- * PAGE_PRESENT is zero in a PTE holding swap "identifier"
+/*
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ *
+ * Format of swap PTEs:
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   <-------------- offset -------------> <--- zero --> E < type ->
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
+ *   The zero'ed bits include _PAGE_PRESENT.
  */
 #define __swp_entry(type, off)		((swp_entry_t) \
 					{ ((type) & 0x1f) | ((off) << 13) })
@@ -120,6 +132,15 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
+static inline int pte_swp_exclusive(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
+}
+
+PTE_BIT_FUNC(swp_mkexclusive, |= (_PAGE_SWP_EXCLUSIVE));
+PTE_BIT_FUNC(swp_clear_exclusive, &= ~(_PAGE_SWP_EXCLUSIVE));
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #include <asm/hugepage.h>
 #endif
-- 
2.39.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
