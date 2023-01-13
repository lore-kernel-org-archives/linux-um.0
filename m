Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87744C67871
	for <linux-um@archiver.kernel.org>; Fri, 13 Jan 2023 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jYeH0qDfkdv8e2xa2RFLtuboHX8pU+Oot9ls1DoaIAE=; b=TSGhRJn5HGCXpI
	J80MSBSFcB00VdQYSWViFVF2Q0cZo3DPoLmVSG+K7x/nTP3R51gFgr+D8tLj7EL4hjZgnp0lNvAyu
	qDuKo09vXcepK0iP3gM+qd9U70CN0AThgKpV214y60TY3nM/owHCgSN7NZGvTsD1VbtkASMsPwnCb
	G5DxqXxw4LrVJSFkSKuFg6fWrLxD9TOiPJUg4t9JRJMPDnhpt+EO8rApK8rUETmJxcQ8EVbjnxKeg
	GwpTd6t4PTr34xyma5J517Ljs5FIoVT+AackG98phpq/GlMCjPmyL1BGj9VlQBSYedbmTtGvn0Gj1
	qFCrgVYAmSqRKKdRm2Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGNkU-003gts-At; Fri, 13 Jan 2023 17:21:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGNbh-003bDG-6L
	for linux-um@lists.infradead.org; Fri, 13 Jan 2023 17:12:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673629964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nb3/Kg+q8w8ft77T7rabV7x4+F6BGLijJ0EWAhVZvAg=;
	b=gWd/Jf1nq8sgMNezDx9+pNIlVFe7Z1MXTzdO9oU5opRRk2EH7xqmU1jcgW2rJ6zgrhCfvV
	v7LPA2zP45Z6CCncRBI4H7FbOHBDi3XYYdyOzllV/SlB7ShOuoyqFgtPgZhzDDwdsOx78F
	b1KyVoIs1OhBs3+4ZpQ/OogoEZErNNY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-JtK01FPYOwaf9TktFHEmLQ-1; Fri, 13 Jan 2023 12:12:40 -0500
X-MC-Unique: JtK01FPYOwaf9TktFHEmLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A68780D0EB;
	Fri, 13 Jan 2023 17:12:38 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DDF5F40C2064;
	Fri, 13 Jan 2023 17:12:31 +0000 (UTC)
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
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH mm-unstable v1 16/26] parisc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date: Fri, 13 Jan 2023 18:10:16 +0100
Message-Id: <20230113171026.582290-17-david@redhat.com>
In-Reply-To: <20230113171026.582290-1-david@redhat.com>
References: <20230113171026.582290-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230113_091245_361394_BD323E83 
X-CRM114-Status: GOOD (  14.65  )
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

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by using the yet-unused
_PAGE_ACCESSED location in the swap PTE. Looking at pte_present()
and pte_none() checks, there seems to be no actual reason why we cannot
use it: we only have to make sure we're not using _PAGE_PRESENT.

Reusing this bit avoids having to steal one bit from the swap offset.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/parisc/include/asm/pgtable.h | 41 ++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index ea357430aafe..3033bb88df34 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -218,6 +218,9 @@ extern void __update_cache(pte_t pte);
 #define _PAGE_KERNEL_RWX	(_PAGE_KERNEL_EXEC | _PAGE_WRITE)
 #define _PAGE_KERNEL		(_PAGE_KERNEL_RO | _PAGE_WRITE)
 
+/* We borrow bit 23 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	_PAGE_ACCESSED
+
 /* The pgd/pmd contains a ptr (in phys addr space); since all pgds/pmds
  * are page-aligned, we don't care about the PAGE_OFFSET bits, except
  * for a few meta-information bits, so we shift the address to be
@@ -394,17 +397,49 @@ extern void paging_init (void);
 
 #define update_mmu_cache(vms,addr,ptep) __update_cache(*ptep)
 
-/* Encode and de-code a swap entry */
-
+/*
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ *
+ * Format of swap PTEs (32bit):
+ *
+ *                         1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
+ *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+ *   <---------------- offset -----------------> P E <ofs> < type ->
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
+ *   _PAGE_PRESENT (P) must be 0.
+ *
+ *   For the 64bit version, the offset is extended by 32bit.
+ */
 #define __swp_type(x)                     ((x).val & 0x1f)
 #define __swp_offset(x)                   ( (((x).val >> 6) &  0x7) | \
 					  (((x).val >> 8) & ~0x7) )
-#define __swp_entry(type, offset)         ((swp_entry_t) { (type) | \
+#define __swp_entry(type, offset)         ((swp_entry_t) { \
+					    ((type) & 0x1f) | \
 					    ((offset &  0x7) << 6) | \
 					    ((offset & ~0x7) << 8) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
+static inline int pte_swp_exclusive(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
+}
+
+static inline pte_t pte_swp_mkexclusive(pte_t pte)
+{
+	pte_val(pte) |= _PAGE_SWP_EXCLUSIVE;
+	return pte;
+}
+
+static inline pte_t pte_swp_clear_exclusive(pte_t pte)
+{
+	pte_val(pte) &= ~_PAGE_SWP_EXCLUSIVE;
+	return pte;
+}
+
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
-- 
2.39.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
