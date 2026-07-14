Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BACCC44508
	for <linux-um@archiver.kernel.org>; Tue, 14 Jul 2026 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=865cl54nJQTbOF3eykkMxymd6hEBxnf3a3hksIMsfuE=; b=0PG+KSfroilnhWqV2jCqmzh8It
	/JMOJAuDzwNxPatP+iFCGSUjZNh3xMTIkIOofJpJfkmqv69LOst9d4pSdtxsWcH7GSoQuoPU8wFVi
	Iut/2n2djj+BqS2rFRWCFZjwDkzUXqFmzDa11ccSckwCBgCOvCd6ZC5twnOgg6yH7gghgc10buB3i
	Ct+wQptGRoMyR7TT1BfmYUFVxQX9ZxTXu8/dmllaHxodnPTGeEO7DZLbFNzy4yoVYMV3uaafvpklX
	zI1vKyIzrcFpzf0DpH/5WVUpbj5v3WV91JzuWANxaqLEHNHtmfyvltnygg0iI1dWD2uwwdOfrm3+n
	2GVzDuKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdnN-0000000CJli-0VsZ;
	Tue, 14 Jul 2026 14:07:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdnL-0000000CJjO-0Ivz;
	Tue, 14 Jul 2026 14:07:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=865cl54nJQTbOF3eykkMxymd6hEBxnf3a3hksIMsfuE=; b=nBNQX4+mbigCJBhnTmF58J7kYl
	xbYJmiw5HVx6s5ZPr2i0+t5RCYc941t9nJAXz9pjoMaTmkTTKmClCKxie1aXhZnBNhGIy0ZQiNXbj
	F1WSRIxd6juWL6/BCTZoSH2LF40GslVY/03znwmUCspeuWvhkCH9M0KbFaFzLPKaCL+yVgzgoz/it
	/qwm/7qQlMFFTCU+lHQIogm6FMR90n4XkBHbFhvTssKF33MWg0DAFvHHiNuuSLPBonu+dyKY2Vvry
	fAA4HMM42JvyE2crmRdfFcMZVlEciZghabqyXRVPqPqFf3GOF8pXkTKCV4LxzWXBKitOZV4j3bVs6
	ojH8MspA==;
Received: from foss.arm.com ([217.140.110.172])
	by desiato.infradead.org with esmtp (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjdnG-0000000CZWG-3Q0y;
	Tue, 14 Jul 2026 14:07:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0350F1C25;
	Tue, 14 Jul 2026 07:07:25 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2ACB3F7B4;
	Tue, 14 Jul 2026 07:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038049; bh=VE9T6pQuQsM82lM79rZVxS9mOIiIj6SKheB2t7eP+e8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LM6l4iVarrFVDA4j9SWJAplc2WkKEHlGEtdlAtv7pOYj1y3dATl0KnbkElc5xhenP
	 ErHq3OM3B9mOaLihBDgBjY6YaXcTg/I+07sfZRGvHPhPtHlUZIL/cU1EpblJJAXbkJ
	 UH/xAtOtw9tn/FqSE+wrtOg61lpQnXFpNRh+nTaw=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:07 +0100
Subject: [PATCH 18/22] arm64: mm: drop explicit mm_is_efi() check in
 contpte
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-18-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=2365;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=VE9T6pQuQsM82lM79rZVxS9mOIiIj6SKheB2t7eP+e8=;
 b=IJb3I/i6HXAVQpbcZffARFaIRNRmoRCmPcfDA+y7q25vE/t36H63xBNhz/u8eBXK9/0ECckK8
 YJz0OELUjVVA+CXShhe5YzEf7ewVjSRMYhD9KGxFsYnbUmRuESOa0pX
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_150731_261885_FDEB2107 
X-CRM114-Status: GOOD (  15.22  )
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

efi_mm is now marked as a kernel mm, like init_mm. mm_is_kernel()
therefore gives the right answer for efi_mm and mm_is_user() is now
equivalent to !mm_is_kernel().

Remove mm_is_user() and directly use mm_is_kernel() instead.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/mm/contpte.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index ad5c04cf66ff..e21e279101ca 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -4,23 +4,9 @@
  */
 
 #include <linux/mm.h>
-#include <linux/efi.h>
 #include <linux/export.h>
 #include <asm/tlbflush.h>
 
-static inline bool mm_is_user(struct mm_struct *mm)
-{
-	/*
-	 * Don't attempt to apply the contig bit to kernel mappings, because
-	 * dynamically adding/removing the contig bit can cause page faults.
-	 * These racing faults are ok for user space, since they get serialized
-	 * on the PTL. But kernel mappings can't tolerate faults.
-	 */
-	if (unlikely(mm_is_efi(mm)))
-		return false;
-	return !mm_is_kernel(mm);
-}
-
 static inline pte_t *contpte_align_down(pte_t *ptep)
 {
 	return PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
@@ -263,7 +249,13 @@ void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
 
 	int i;
 
-	if (!mm_is_user(mm))
+	/*
+	 * Don't attempt to apply the contig bit to kernel mappings, because
+	 * dynamically adding/removing the contig bit can cause page faults.
+	 * These racing faults are ok for user space, since they get serialized
+	 * on the PTL. But kernel mappings can't tolerate faults.
+	 */
+	if (mm_is_kernel(mm))
 		return;
 
 	page = pte_page(pte);
@@ -302,7 +294,7 @@ void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
 	 * We have already checked that the ptes are contiguous in
 	 * contpte_try_unfold(), so just check that the mm is user space.
 	 */
-	if (!mm_is_user(mm))
+	if (mm_is_kernel(mm))
 		return;
 
 	pte = pte_mknoncont(pte);
@@ -465,7 +457,7 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 	 */
 	VM_WARN_ON(nr == 1);
 
-	if (!mm_is_user(mm))
+	if (mm_is_kernel(mm))
 		return __set_ptes(mm, addr, ptep, pte, nr);
 
 	end = addr + (nr << PAGE_SHIFT);

-- 
2.51.2


