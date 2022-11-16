Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF02AC43219
	for <linux-um@archiver.kernel.org>; Wed, 16 Nov 2022 10:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RXDzG4Int949SAFLKy3hhDGKJ+4EogDwvWNhVlziVIM=; b=RQjwFeQsh8UXVN
	a7R8FXm+PIIXpLswlAbrQxOzEzUIiPy3pU+9MsVHESbQR/nuA2sUKCMejKB7eyy27LFj+OxCjhk19
	Qdkj58eD9tJlenP6djY+c00Tge2IlMIIemLUEwwwVmhwMBi/filF+k0+eaAdjyeDge53MUKw9asOV
	CqRJGvRyIY96jGAifbAHaHKofS27jWUPeUBhBDLj1J2KMu55FhvQULu+sTUZNRnkfif0PKQAiAg07
	SLituCcGFmGAvB5M0iS7a20vVq4a7Yd7uQWBNdOi7uvZ1kBLawuIg8Rmp3pGDv3191vLpZvquDrn+
	VHGT8S+iKxgyYY+iWcsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovFiL-002F32-Sz; Wed, 16 Nov 2022 10:32:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovFeh-002CvD-V8
	for linux-um@lists.infradead.org; Wed, 16 Nov 2022 10:28:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668594511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1T+ot5qRtqPN1LpUOFfkK/yXOB9NMbn5pFr5NKSN84=;
	b=dPfhw1nkloHnd2rrJYONmUDaf+BI98TW9zYzsWRGezQp3kfPC1U0YAL2NMKoLfXjq7B5mF
	2oIfgisz31fSxFqip8YeJHyW9yTCS1wteJsYTAdOFhDJw3HSMMujpX1VvkGXRfeWNGlVbP
	EL7DUjN53AnysCVVJLzGFIsmK03h054=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-r17LTSJHM5C5l1EBulZ-LQ-1; Wed, 16 Nov 2022 05:28:24 -0500
X-MC-Unique: r17LTSJHM5C5l1EBulZ-LQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D71761C0A110;
	Wed, 16 Nov 2022 10:28:22 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3E25A2024CCA;
	Wed, 16 Nov 2022 10:28:16 +0000 (UTC)
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
Subject: [PATCH mm-unstable v1 08/20] mm: extend FAULT_FLAG_UNSHARE support to anything in a COW mapping
Date: Wed, 16 Nov 2022 11:26:47 +0100
Message-Id: <20221116102659.70287-9-david@redhat.com>
In-Reply-To: <20221116102659.70287-1-david@redhat.com>
References: <20221116102659.70287-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_022832_124256_FB45AE69 
X-CRM114-Status: GOOD (  19.67  )
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

Extend FAULT_FLAG_UNSHARE to break COW on anything mapped into a
COW (i.e., private writable) mapping and adjust the documentation
accordingly.

FAULT_FLAG_UNSHARE will now also break COW when encountering the shared
zeropage, a pagecache page, a PFNMAP, ... inside a COW mapping, by
properly replacing the mapped page/pfn by a private copy (an exclusive
anonymous page).

Note that only do_wp_page() needs care: hugetlb_wp() already handles
FAULT_FLAG_UNSHARE correctly. wp_huge_pmd()/wp_huge_pud() also handles it
correctly, for example, splitting the huge zeropage on FAULT_FLAG_UNSHARE
such that we can handle FAULT_FLAG_UNSHARE on the PTE level.

This change is a requirement for reliable long-term R/O pinning in
COW mappings.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h | 8 ++++----
 mm/memory.c              | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5e7f4fac1e78..5e9aaad8c7b2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1037,9 +1037,9 @@ typedef struct {
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
- * @FAULT_FLAG_UNSHARE: The fault is an unsharing request to unshare (and mark
- *                      exclusive) a possibly shared anonymous page that is
- *                      mapped R/O.
+ * @FAULT_FLAG_UNSHARE: The fault is an unsharing request to break COW in a
+ *                      COW mapping, making sure that an exclusive anon page is
+ *                      mapped after the fault.
  * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
  *                        We should only access orig_pte if this flag set.
  *
@@ -1064,7 +1064,7 @@ typedef struct {
  *
  * The combination FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE is illegal.
  * FAULT_FLAG_UNSHARE is ignored and treated like an ordinary read fault when
- * no existing R/O-mapped anonymous page is encountered.
+ * applied to mappings that are not COW mappings.
  */
 enum fault_flag {
 	FAULT_FLAG_WRITE =		1 << 0,
diff --git a/mm/memory.c b/mm/memory.c
index d47ad33c6487..56b21ab1e4d2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3432,10 +3432,6 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		}
 		wp_page_reuse(vmf);
 		return 0;
-	} else if (unshare) {
-		/* No anonymous page -> nothing to do. */
-		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		return 0;
 	}
 copy:
 	/*
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
