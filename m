Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C3BC4708C
	for <linux-um@archiver.kernel.org>; Tue,  6 Dec 2022 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DM6r/fyWQKpOmVWmGSpm/OP0OPK7wUU2yMclSuPn7Pk=; b=BW7GlzCvjNeIy6
	wiafcEkbWoahaKqIR9dtDLYkLOdsQVo8lEQoUJ8LvASkT+e/MuQfwDv2XitQtiMN1KZNDSIoCTYos
	CHcj3K5noMNSebb7j2u/bvwnhKN/f/mceVLufWhnx6ESS3+1yd70hsXc4A82Icvnaw48xmcwfgfpr
	LgcmGab6LwF/InLAqj5Rm5UWA7f5TN6RGzrXJb1gD6CvVeXc1zT9N2mMpuZapByfPYq0B3U58OA/x
	ELUFfy5oOJXMrUqSRsMTFF3UENfLQrVwNpKrq8mgXbnDjPuXZdi5TLLidssd1IR/0+0321eSY9wZJ
	eQXvJ7d+dgJWgLi6QPxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZP6-00Brda-QJ; Tue, 06 Dec 2022 14:58:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZGI-00BhwI-A6
	for linux-um@lists.infradead.org; Tue, 06 Dec 2022 14:49:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670338173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzoAWpC2EjFS5Q9/UsGf5fjpvpXCCgDj04Gl2nHLJVM=;
	b=eOe4UV8Hwj0lEiDHNkoSOqy5cNOvAKax2USr5IOQ0TMgw6h38MGJYqU4ko932wm6UlODg/
	F0EbXhLB4k8e8froqxyFvAPJk7J33cmi5cETxBydvxVh3wOGC5yTYA2TiojmuBb3GaqLPz
	I7QSfPvBuVi5CJbRqtyrXqFLKgAuawE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-a9U1CV1xO9Gr8wthe35pjg-1; Tue, 06 Dec 2022 09:49:30 -0500
X-MC-Unique: a9U1CV1xO9Gr8wthe35pjg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B36AA101A58E;
	Tue,  6 Dec 2022 14:49:28 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.173])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3F723492B07;
	Tue,  6 Dec 2022 14:49:22 +0000 (UTC)
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
	Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH mm-unstable RFC 13/26] nios2/mm: refactor swap PTE layout
Date: Tue,  6 Dec 2022 15:47:17 +0100
Message-Id: <20221206144730.163732-14-david@redhat.com>
In-Reply-To: <20221206144730.163732-1-david@redhat.com>
References: <20221206144730.163732-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_064934_449694_E2DD5AA7 
X-CRM114-Status: GOOD (  13.28  )
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

nios2 disables swap for a good reason: it doesn't even provide
sufficient type bits as required by core MM. However, swap entries are
nowadays also used for other purposes (migration entries,
PTE markers, HWPoison, ...), and accidential use could be problematic.

Let's properly use 5 bits for the swap type and document the layout.
Bits 26--31 should get ignored by hardware completely, so they can be
used.

Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/nios2/include/asm/pgtable.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index ab793bc517f5..d1e5c9eb4643 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -232,19 +232,21 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 		__FILE__, __LINE__, pgd_val(e))
 
 /*
- * Encode and decode a swap entry (must be !pte_none(pte) && !pte_present(pte):
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
  *
- * 31 30 29 28 27 26 25 24 23 22 21 20 19 18 ...  1  0
- *  0  0  0  0 type.  0  0  0  0  0  0 offset.........
+ * Format of swap PTEs:
  *
- * This gives us up to 2**2 = 4 swap files and 2**20 * 4K = 4G per swap file.
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   0 < type -> 0 0 0 0 0 0 <-------------- offset --------------->
  *
- * Note that the offset field is always non-zero, thus !pte_none(pte) is always
- * true.
+ * Note that the offset field is always non-zero if the swap type is 0, thus
+ * !pte_none() is always true.
  */
-#define __swp_type(swp)		(((swp).val >> 26) & 0x3)
+#define __swp_type(swp)		(((swp).val >> 26) & 0x1f)
 #define __swp_offset(swp)	((swp).val & 0xfffff)
-#define __swp_entry(type, off)	((swp_entry_t) { (((type) & 0x3) << 26) \
+#define __swp_entry(type, off)	((swp_entry_t) { (((type) & 0x1f) << 26) \
 						 | ((off) & 0xfffff) })
 #define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
