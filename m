Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06805C352A1
	for <linux-um@archiver.kernel.org>; Tue,  6 Dec 2022 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OsLLk0+CN4g7MWt/OwF7PPZvM/h5lSEiVJbC2K6pSMo=; b=s5Zxpi/TBw3GJx
	Una48iP6eVrv9XbibKzoXx+afiPUOtyfYwSehH00H6YWNDcsVYye0JuFpF2tydyZhuLpfyn+ZIOZl
	STtXEiSQ0cd+8EB89KlkLMNO3VPWGavu0zouq1XutiKBCDwu/TTH/fK8PiDWjpAwo8on6omN6033c
	jcuDzGD8HMruqO88uB7NDis7GxnKktxTht7rb+Ila4iqflRR3NriQPEhAJeouWPGkuoA63qI+/0cS
	/BXGmfPYFBT4dl1TlfHLzWee/bb+K71bI8Vl5OEjDElTn0i2uRsOe60L771ETB8vtrmvys9aTH6gs
	zsojL2njIwXvSP7gl1lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZfZ-00C9g2-Ii; Tue, 06 Dec 2022 15:15:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZHZ-00BjB7-Fs
	for linux-um@lists.infradead.org; Tue, 06 Dec 2022 14:50:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670338252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBnZV0SpnoH1I9XvtR8hHypRV3pWO3Oi0CPIecjHAhU=;
	b=GbHE23FP+IUBwJ66S+xaJh6UWS5NDh+4uduRG6BxTnbxk5x4+HnEOqXsA7KL6nk9E31PnJ
	K0jthdMoS6jJM3+X4AfsbhG4XB1UqAl87QJoVPusCK3q3CgL5jVxluO+sPMyiZjpjud4Zm
	nYXuOT5nLmDuZ9g5i0J37QULvm1DxxI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-koYRKIbVNUuP7sdV7owaiw-1; Tue, 06 Dec 2022 09:50:41 -0500
X-MC-Unique: koYRKIbVNUuP7sdV7owaiw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5352185A59D;
	Tue,  6 Dec 2022 14:50:40 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.173])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E3240492B04;
	Tue,  6 Dec 2022 14:50:33 +0000 (UTC)
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH mm-unstable RFC 24/26] x86/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE also on 32bit
Date: Tue,  6 Dec 2022 15:47:28 +0100
Message-Id: <20221206144730.163732-25-david@redhat.com>
In-Reply-To: <20221206144730.163732-1-david@redhat.com>
References: <20221206144730.163732-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_065053_727483_081F0E9E 
X-CRM114-Status: GOOD (  17.67  )
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

Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE just like we already do on
x86-64. After deciphering the PTE layout it becomes clear that there are
still unused bits for 2-level and 3-level page tables that we should be
able to use. Reusing a bit avoids stealing one bit from the swap offset.

While at it, mask the type in __swp_entry(); use some helper definitions
to make the macros easier to grasp.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/include/asm/pgtable-2level.h | 26 +++++++++++++++++++++-----
 arch/x86/include/asm/pgtable-3level.h | 26 +++++++++++++++++++++++---
 arch/x86/include/asm/pgtable.h        |  2 --
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-2level.h b/arch/x86/include/asm/pgtable-2level.h
index 60d0f9015317..e9482a11ac52 100644
--- a/arch/x86/include/asm/pgtable-2level.h
+++ b/arch/x86/include/asm/pgtable-2level.h
@@ -80,21 +80,37 @@ static inline unsigned long pte_bitop(unsigned long value, unsigned int rightshi
 	return ((value >> rightshift) & mask) << leftshift;
 }
 
-/* Encode and de-code a swap entry */
+/*
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ *
+ * Format of swap PTEs:
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   <----------------- offset ------------------> 0 E <- type --> 0
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
+ */
 #define SWP_TYPE_BITS 5
+#define _SWP_TYPE_MASK ((1U << SWP_TYPE_BITS) - 1)
+#define _SWP_TYPE_SHIFT (_PAGE_BIT_PRESENT + 1)
 #define SWP_OFFSET_SHIFT (_PAGE_BIT_PROTNONE + 1)
 
-#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS)
+#define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > 5)
 
-#define __swp_type(x)			(((x).val >> (_PAGE_BIT_PRESENT + 1)) \
-					 & ((1U << SWP_TYPE_BITS) - 1))
+#define __swp_type(x)			(((x).val >> _SWP_TYPE_SHIFT) \
+					 & _SWP_TYPE_MASK)
 #define __swp_offset(x)			((x).val >> SWP_OFFSET_SHIFT)
 #define __swp_entry(type, offset)	((swp_entry_t) { \
-					 ((type) << (_PAGE_BIT_PRESENT + 1)) \
+					 (((type) & _SWP_TYPE_MASK) << _SWP_TYPE_SHIFT) \
 					 | ((offset) << SWP_OFFSET_SHIFT) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define __swp_entry_to_pte(x)		((pte_t) { .pte = (x).val })
 
+/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	_PAGE_PSE
+
 /* No inverted PFNs on 2 level page tables */
 
 static inline u64 protnone_mask(u64 val)
diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index 28421a887209..2b87f965dd86 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -248,8 +248,24 @@ static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
 #define native_pudp_get_and_clear(xp) native_local_pudp_get_and_clear(xp)
 #endif
 
-/* Encode and de-code a swap entry */
+/*
+ * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
+ * are !pte_none() && !pte_present().
+ *
+  * Format of swap PTEs:
+ *
+ *   6 6 6 6 5 5 5 5 5 5 5 5 5 5 4 4 4 4 4 4 4 4 4 4 3 3 3 3 3 3 3 3
+ *   3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2
+ *   < type -> <---------------------- offset ----------------------
+ *
+ *   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *   --------------------------------------------> 0 E 0 0 0 0 0 0 0
+ *
+ *   E is the exclusive marker that is not stored in swap entries.
+ */
 #define SWP_TYPE_BITS		5
+#define _SWP_TYPE_MASK ((1U << SWP_TYPE_BITS) - 1)
 
 #define SWP_OFFSET_FIRST_BIT	(_PAGE_BIT_PROTNONE + 1)
 
@@ -257,9 +273,10 @@ static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
 #define SWP_OFFSET_SHIFT	(SWP_OFFSET_FIRST_BIT + SWP_TYPE_BITS)
 
 #define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS)
-#define __swp_type(x)			(((x).val) & ((1UL << SWP_TYPE_BITS) - 1))
+#define __swp_type(x)			(((x).val) & _SWP_TYPE_MASK)
 #define __swp_offset(x)			((x).val >> SWP_TYPE_BITS)
-#define __swp_entry(type, offset)	((swp_entry_t){(type) | (offset) << SWP_TYPE_BITS})
+#define __swp_entry(type, offset)	((swp_entry_t){((type) & _SWP_TYPE_MASK) \
+					| (offset) << SWP_TYPE_BITS})
 
 /*
  * Normally, __swp_entry() converts from arch-independent swp_entry_t to
@@ -287,6 +304,9 @@ static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
 #define __pte_to_swp_entry(pte)	(__swp_entry(__pteval_swp_type(pte), \
 					     __pteval_swp_offset(pte)))
 
+/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
+#define _PAGE_SWP_EXCLUSIVE	_PAGE_PSE
+
 #include <asm/pgtable-invert.h>
 
 #endif /* _ASM_X86_PGTABLE_3LEVEL_H */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 0564edd24ffb..02df42cde004 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1299,7 +1299,6 @@ static inline void update_mmu_cache_pud(struct vm_area_struct *vma,
 		unsigned long addr, pud_t *pud)
 {
 }
-#ifdef _PAGE_SWP_EXCLUSIVE
 #define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
 static inline pte_t pte_swp_mkexclusive(pte_t pte)
 {
@@ -1315,7 +1314,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 {
 	return pte_clear_flags(pte, _PAGE_SWP_EXCLUSIVE);
 }
-#endif /* _PAGE_SWP_EXCLUSIVE */
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
