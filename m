Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D37C3DA78
	for <linux-um@archiver.kernel.org>; Fri, 13 Jan 2023 17:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wt9lk5rJmV2FRxKKR2rFt0E0RgMxTiyF60AFLeisCmg=; b=kf9pN4KFeptMXd
	iLSzw5rxPL+5zpO//I9aYJtCtsvWQI8wA54eZnro32xjnEgQhG6QR+0MCqLw4SRH4Z33+P+IUKIO7
	RrgTbkWAAL4g5C5iArH0hbrxGYw3uOLxrEinDS0lbHHQX1LtRpOl4FVjibnnYeHMcylit2cNGryz4
	s7dEmda60UT9gZp0jlXU7kccSdBnm4J77dgCDNy9/oM7AqFoWS1fKgCWhTL84wDg2XxvqYZXMWrHO
	m3bwUpu9qwMLNKaXlSeEje1Scv5Sn1NbF5E/M1XNb+3BYNHGOcOdWTxBicP+VPt0dBgddrW9NoBOb
	Boy9zSdSahgwfYPAf5aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGNpU-003jhP-On; Fri, 13 Jan 2023 17:27:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGNc7-003bWb-R8
	for linux-um@lists.infradead.org; Fri, 13 Jan 2023 17:13:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673629991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/tSLKnjXWongAfZcI54y+AzPoBqzDq2scVqv8imtys=;
	b=Nk3tDp2m5ZkYmw9IGSj1nv12PKmdhYLGZxFNShTnOmvPsoqQuwBahAVatvi24rxpOtFzMW
	tIEtXkgbHiD2KeWelmB5JYMg4x/N7WF3aNDdyWgcuj1jTXka5Kg2zWthIGvtjr40q1Ig1W
	YSP4ecVfUqtVuTUujOc0zrE8ax0B/TA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-HNQxNCQiN5-TTLiX3HPNWw-1; Fri, 13 Jan 2023 12:13:03 -0500
X-MC-Unique: HNQxNCQiN5-TTLiX3HPNWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CFD61869B70;
	Fri, 13 Jan 2023 17:13:02 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2BFB940C2064;
	Fri, 13 Jan 2023 17:12:55 +0000 (UTC)
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
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH mm-unstable v1 19/26] riscv/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date: Fri, 13 Jan 2023 18:10:19 +0100
Message-Id: <20230113171026.582290-20-david@redhat.com>
In-Reply-To: <20230113171026.582290-1-david@redhat.com>
References: <20230113171026.582290-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230113_091311_986657_8D76DF82 
X-CRM114-Status: GOOD (  15.81  )
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

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit
from the offset. This reduces the maximum swap space per file: on 32bit
to 16 GiB (was 32 GiB).

Note that this bit does not conflict with swap PMDs and could also be used
in swap PMD context later.

While at it, mask the type in __swp_entry().

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/riscv/include/asm/pgtable-bits.h |  3 +++
 arch/riscv/include/asm/pgtable.h      | 29 ++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index b9e13a8fe2b7..f896708e8331 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -27,6 +27,9 @@
  */
 #define _PAGE_PROT_NONE _PAGE_GLOBAL
 
+/* Used for swap PTEs only. */
+#define _PAGE_SWP_EXCLUSIVE _PAGE_ACCESSED
+
 #define _PAGE_PFN_SHIFT 10
 
 /*
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4eba9a98d0e3..03a4728db039 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -724,16 +724,18 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /*
- * Encode and decode a swap entry
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
  *
  * Format of swap PTE:
  *	bit            0:	_PAGE_PRESENT (zero)
  *	bit       1 to 3:       _PAGE_LEAF (zero)
  *	bit            5:	_PAGE_PROT_NONE (zero)
- *	bits      6 to 10:	swap type
- *	bits 10 to XLEN-1:	swap offset
+ *	bit            6:	exclusive marker
+ *	bits      7 to 11:	swap type
+ *	bits 11 to XLEN-1:	swap offset
  */
-#define __SWP_TYPE_SHIFT	6
+#define __SWP_TYPE_SHIFT	7
 #define __SWP_TYPE_BITS		5
 #define __SWP_TYPE_MASK		((1UL << __SWP_TYPE_BITS) - 1)
 #define __SWP_OFFSET_SHIFT	(__SWP_TYPE_BITS + __SWP_TYPE_SHIFT)
@@ -744,11 +746,28 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 #define __swp_type(x)	(((x).val >> __SWP_TYPE_SHIFT) & __SWP_TYPE_MASK)
 #define __swp_offset(x)	((x).val >> __SWP_OFFSET_SHIFT)
 #define __swp_entry(type, offset) ((swp_entry_t) \
-	{ ((type) << __SWP_TYPE_SHIFT) | ((offset) << __SWP_OFFSET_SHIFT) })
+	{ (((type) & __SWP_TYPE_MASK) << __SWP_TYPE_SHIFT) | \
+	  ((offset) << __SWP_OFFSET_SHIFT) })
 
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
+static inline int pte_swp_exclusive(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
+}
+
+static inline pte_t pte_swp_mkexclusive(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SWP_EXCLUSIVE);
+}
+
+static inline pte_t pte_swp_clear_exclusive(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_SWP_EXCLUSIVE);
+}
+
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 #define __pmd_to_swp_entry(pmd) ((swp_entry_t) { pmd_val(pmd) })
 #define __swp_entry_to_pmd(swp) __pmd((swp).val)
-- 
2.39.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
