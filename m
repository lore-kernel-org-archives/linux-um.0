Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE170C3DA78
	for <linux-um@archiver.kernel.org>; Fri, 13 Jan 2023 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eLgm7J2HLMBqTrtjysVbFHi0yuXgAeiKkPcdq6XIRVQ=; b=3wD9hXOx89ZMTh
	deFCYKbcistLasWuVUqr5NgspMCB/FDRveY7nFufaqpzhLb7AdaApCcrzL+swy6HWmv8zAbmBqbaX
	0I1TadF07EjwRZguNnzcMjzt5VHjfSKUfK4F/wfLps2cC34q21n42J+nDeMWBWnQlqAPDI+KNaqk5
	CGBE8jy81EN126Az94SZLEcQ+N5r8Pm9wBqx0mHyV9kZ/OdARS3Namqt3yOO9mUOTfo7rYgeJp2xs
	oAj25GcnqTBcwBOhBUf+sdrdWjlJhBHUbPDvHbWVnKa4t2WOFZ7hjsHJj0IbqcZXYMeeQS7pCDU0a
	OQaWlcvLIcNB/UxHCYtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGNvM-003moD-36; Fri, 13 Jan 2023 17:33:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGNdB-003cHn-DR
	for linux-um@lists.infradead.org; Fri, 13 Jan 2023 17:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673630033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmpIeZUQPW93vOhFIi7U44xqWezjAAUM6rotNAYg4/I=;
	b=JEN+4RD1LZF8PWuqWfPs3XTK9WiIUKBmPVJqiZqIbNYghkRo9jhPQQbhf7yN9nxtL1uI4L
	6lWSUo72iQcmIENhV7YMP1/ERR/Sw1Nz9HCv4sW0QGYa8xf1NTUIleaMSDgy/MVRppfN/N
	Ay3gFwVgh0Jod4pjBYXZkt7Q6+dq05o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-_4owQC4lN0aWG8hTOfvPjQ-1; Fri, 13 Jan 2023 12:13:46 -0500
X-MC-Unique: _4owQC4lN0aWG8hTOfvPjQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 427DA101A52E;
	Fri, 13 Jan 2023 17:13:45 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E323740C2064;
	Fri, 13 Jan 2023 17:13:37 +0000 (UTC)
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
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH mm-unstable v1 25/26] xtensa/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date: Fri, 13 Jan 2023 18:10:25 +0100
Message-Id: <20230113171026.582290-26-david@redhat.com>
In-Reply-To: <20230113171026.582290-1-david@redhat.com>
References: <20230113171026.582290-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230113_091417_643963_C560FA1F 
X-CRM114-Status: GOOD (  16.07  )
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

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by using bit 1. This
bit should be safe to use for our usecase.

Most importantly, we can still distinguish swap PTEs from PAGE_NONE PTEs
(see pte_present()) and don't use one of the two reserved attribute
masks (1101 and 1111). Attribute mask 1100 and 1110 now identify swap PTEs.

While at it, remove SWP_TYPE_BITS (not really helpful as it's not used in
the actual swap macros) and mask the type in __swp_entry().

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/xtensa/include/asm/pgtable.h | 32 ++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 5b5484d707b2..1025e2dc292b 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -96,7 +96,7 @@
  *		+- - - - - - - - - - - - - - - - - - - - -+
  *   (PAGE_NONE)|    PPN    | 0 | 00 | ADW | 01 | 11 | 11 |
  *		+-----------------------------------------+
- *   swap	|     index     |   type   | 01 | 11 | 00 |
+ *   swap	|     index     |   type   | 01 | 11 | e0 |
  *		+-----------------------------------------+
  *
  * For T1050 hardware and earlier the layout differs for present and (PAGE_NONE)
@@ -112,6 +112,7 @@
  *   RI         ring (0=privileged, 1=user, 2 and 3 are unused)
  *   CA		cache attribute: 00 bypass, 01 writeback, 10 writethrough
  *		(11 is invalid and used to mark pages that are not present)
+ *   e		exclusive marker in swap PTEs
  *   w		page is writable (hw)
  *   x		page is executable (hw)
  *   index      swap offset / PAGE_SIZE (bit 11-31: 21 bits -> 8 GB)
@@ -158,6 +159,9 @@
 #define _PAGE_DIRTY		(1<<7)	/* software: page dirty */
 #define _PAGE_ACCESSED		(1<<8)	/* software: page accessed (read) */
 
+/* We borrow bit 1 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	(1<<1)
+
 #ifdef CONFIG_MMU
 
 #define _PAGE_CHG_MASK	   (PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
@@ -343,19 +347,37 @@ ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 }
 
 /*
- * Encode and decode a swap and file entry.
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
  */
-#define SWP_TYPE_BITS		5
-#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS)
+#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > 5)
 
 #define __swp_type(entry)	(((entry).val >> 6) & 0x1f)
 #define __swp_offset(entry)	((entry).val >> 11)
 #define __swp_entry(type,offs)	\
-	((swp_entry_t){((type) << 6) | ((offs) << 11) | \
+	((swp_entry_t){(((type) & 0x1f) << 6) | ((offs) << 11) | \
 	 _PAGE_CA_INVALID | _PAGE_USER})
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
 #endif /*  !defined (__ASSEMBLY__) */
 
 
-- 
2.39.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
