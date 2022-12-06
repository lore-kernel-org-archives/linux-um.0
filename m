Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49792C352A1
	for <linux-um@archiver.kernel.org>; Tue,  6 Dec 2022 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3IXksf3aWd7Y8qhjl59kIGXDJbhG2WtCUV7wEHxwooU=; b=Bw9HDKU+pktvWr
	jPOySFrylfofT+nyDjrQ93OicE41u1N0UubycM+SWIfEsYmFGOU+xkKW+9e0CNJ3e89frjCyXEVBZ
	yKudMM7SP573TAimxKXrtMJ8QnOeHcwM6nHU+7Dhrt9Ofp/WjFfMwrby0QN/XWJ7hSjfjdklBS7Tt
	x+JRPwLwW9NCfR91iV7zTLInmyFag8+EDHhdGV/j1Vhqu+V8wvzCZREhDAbUWfzUGwjoUioICQt43
	HoMJmRKqCWDpnsRKgPGWPlHe9gTFtVeOJl+GpSpg1rf00DCOzObkOPyIL/qYMrmSWaBbl4Vn1HM0W
	zpS11cJzaob4OwGEw92g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZFy-00Bhdo-BK; Tue, 06 Dec 2022 14:49:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZFG-00BgzH-Mz
	for linux-um@lists.infradead.org; Tue, 06 Dec 2022 14:48:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670338109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuOxPbGlhif4GnxsJcPIMTzkLFnTwbdex8tx3HF/6jU=;
	b=jPVjT/Eh3DkfOROs7Vh8cCMSDgTKz9L0dzLYZE3pnaGnn+ybZHFgRmlI49AsNbDeVMi3yd
	UBnOSJoNwwjdztZFDA4NyuwTXRaYrJMrUFHVwHHXySf/kIbCCBDu+6L+19xI9D/Or5eQVM
	gUM/2vHcS7ZjRYJ7fR7nX947/itW9QY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-YqB8KViVOL-1fgDjirYUAw-1; Tue, 06 Dec 2022 09:48:25 -0500
X-MC-Unique: YqB8KViVOL-1fgDjirYUAw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCB918582B9;
	Tue,  6 Dec 2022 14:48:23 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.173])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F0310492B04;
	Tue,  6 Dec 2022 14:48:06 +0000 (UTC)
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
Subject: [PATCH mm-unstable RFC 03/26] arc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date: Tue,  6 Dec 2022 15:47:07 +0100
Message-Id: <20221206144730.163732-4-david@redhat.com>
In-Reply-To: <20221206144730.163732-1-david@redhat.com>
References: <20221206144730.163732-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_064830_911235_9381C37D 
X-CRM114-Status: GOOD (  13.02  )
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
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
