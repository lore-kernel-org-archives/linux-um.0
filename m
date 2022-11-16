Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60428C4332F
	for <linux-um@archiver.kernel.org>; Wed, 16 Nov 2022 10:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M7DNfOhrYbohUXndRqP/KN9onJ+ww6DTkvUTp40MZRc=; b=Ng/+9ZT7YIQlI2
	Xt20z2KD1nPeHZVbL574Jv9V2+/9nWoSF6If7lysxR/gQwwvvCsJ+3JUuPDrh91wopA+dJLbZqpu1
	daifhcZ6iufs4/IXGSZySl84SPAgtV075G1JznBbG4YdqyVqI6W/gm/2pkDBK19AP2ga+Ph7xrMYP
	zs7BRF7sTemr9/HeTbspDCMFu+0Iac9yUidouuYQxQiGjuFOMfQ6LZv9tXkqi2FB4NIjNNDb7Y56l
	OBuNt1reevjAQec42yudI4XutVduTtoXAHiz/p+N/tgM47NLMsoMytepzFHyd3hT2Qz7/3UJ2a/wu
	Nl2o1LKLBLZZMWUqKrcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovFgd-002ED4-PP; Wed, 16 Nov 2022 10:30:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovFeC-002CaQ-QU
	for linux-um@lists.infradead.org; Wed, 16 Nov 2022 10:28:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668594480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fetjyNVdxegk0QG4w8mo8gn6x0g2HdvFN8vnJqqr3gA=;
	b=c/GS3sElX0D9F335v3oyyBxgxhPMt29fNdOD/oGymgwO2EQQlPFnAIuIJOJiVgVn81dhl3
	XW9Iy/aEEEyNrS+A3PCV+tg2DQor6hBBVusp+Q4XJ7THnwXu26qNOLzXddYugRMoJOWSHT
	Ah+AcgmTo8402fqEB/ZVc255yymxSKs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-E78fxk5vOCySDX-MBsnqRQ-1; Wed, 16 Nov 2022 05:27:54 -0500
X-MC-Unique: E78fxk5vOCySDX-MBsnqRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B6478027F5;
	Wed, 16 Nov 2022 10:27:53 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9344E2027064;
	Wed, 16 Nov 2022 10:27:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-ia64@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-samsung-soc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Nadav Amit <namit@vmware.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Shuah Khan <shuah@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christoph Hellwig <hch@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH mm-unstable v1 04/20] mm: add early FAULT_FLAG_UNSHARE consistency checks
Date: Wed, 16 Nov 2022 11:26:43 +0100
Message-Id: <20221116102659.70287-5-david@redhat.com>
In-Reply-To: <20221116102659.70287-1-david@redhat.com>
References: <20221116102659.70287-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_022800_967313_E724F65D 
X-CRM114-Status: GOOD (  19.53  )
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

For now, FAULT_FLAG_UNSHARE only applies to anonymous pages, which
implies a COW mapping. Let's hide FAULT_FLAG_UNSHARE early if we're not
dealing with a COW mapping, such that we treat it like a read fault as
documented and don't have to worry about the flag throughout all fault
handlers.

While at it, centralize the check for mutual exclusion of
FAULT_FLAG_UNSHARE and FAULT_FLAG_WRITE and just drop the check that
either flag is set in the WP handler.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c |  3 ---
 mm/hugetlb.c     |  5 -----
 mm/memory.c      | 23 ++++++++++++++++++++---
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ed12cd3acbfd..68d00196b519 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1267,9 +1267,6 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
 	VM_BUG_ON_VMA(!vma->anon_vma, vma);
 
-	VM_BUG_ON(unshare && (vmf->flags & FAULT_FLAG_WRITE));
-	VM_BUG_ON(!unshare && !(vmf->flags & FAULT_FLAG_WRITE));
-
 	if (is_huge_zero_pmd(orig_pmd))
 		goto fallback;
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1de986c62976..383b26069b33 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5314,9 +5314,6 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	unsigned long haddr = address & huge_page_mask(h);
 	struct mmu_notifier_range range;
 
-	VM_BUG_ON(unshare && (flags & FOLL_WRITE));
-	VM_BUG_ON(!unshare && !(flags & FOLL_WRITE));
-
 	/*
 	 * hugetlb does not support FOLL_FORCE-style write faults that keep the
 	 * PTE mapped R/O such as maybe_mkwrite() would do.
@@ -5326,8 +5323,6 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/* Let's take out MAP_SHARED mappings first. */
 	if (vma->vm_flags & VM_MAYSHARE) {
-		if (unlikely(unshare))
-			return 0;
 		set_huge_ptep_writable(vma, haddr, ptep);
 		return 0;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 2d453736f87c..e014435a87db 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3344,9 +3344,6 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
 
-	VM_BUG_ON(unshare && (vmf->flags & FAULT_FLAG_WRITE));
-	VM_BUG_ON(!unshare && !(vmf->flags & FAULT_FLAG_WRITE));
-
 	if (likely(!unshare)) {
 		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -5161,6 +5158,22 @@ static void lru_gen_exit_fault(void)
 }
 #endif /* CONFIG_LRU_GEN */
 
+static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
+				       unsigned int *flags)
+{
+	if (unlikely(*flags & FAULT_FLAG_UNSHARE)) {
+		if (WARN_ON_ONCE(*flags & FAULT_FLAG_WRITE))
+			return VM_FAULT_SIGSEGV;
+		/*
+		 * FAULT_FLAG_UNSHARE only applies to COW mappings. Let's
+		 * just treat it like an ordinary read-fault otherwise.
+		 */
+		if (!is_cow_mapping(vma->vm_flags))
+			*flags &= ~FAULT_FLAG_UNSHARE;
+	}
+	return 0;
+}
+
 /*
  * By the time we get here, we already hold the mm semaphore
  *
@@ -5177,6 +5190,10 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	count_vm_event(PGFAULT);
 	count_memcg_event_mm(vma->vm_mm, PGFAULT);
 
+	ret = sanitize_fault_flags(vma, &flags);
+	if (ret)
+		return ret;
+
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
 					    flags & FAULT_FLAG_REMOTE))
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
