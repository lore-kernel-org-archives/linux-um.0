Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DB0C44501
	for <linux-um@archiver.kernel.org>; Tue, 14 Jul 2026 14:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bBoBfUS5WMssGgUA/Wo3+dYqN4HjYGy3oqxDSlnyggk=; b=Q9R3WYNi7H5cI1kNzZ7MNhwNFK
	7BzX70Iw9UGPm10rEcxPlqKEZWm9xP/fCTtGMKI2EdcVGK0QO1/vPJmcBf+LHEYKVrI0hVgkoeuGx
	0Bu9VRkUni1HtWZsXysySfUgG98zKbKEw9WMIDmUKXr1dwZEKxkvhF98Z4AH9Yi3/XCEsXKIkVTNN
	0glVzASTDrw8FifhpxlQeNw3CUDkYNZQcNoDaldLSDDmBWO4IONOuhZC6g7vKXSkwpGakXhdAGhAS
	VfweBqPOEGMcZ0pERC0PDExy7pR3B0okTF9/GtmFyirc86bMFuPUrbAgTFgZCu+OUkoZERhOgrpb3
	AW9Tg39A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdmb-0000000CIzB-2itE;
	Tue, 14 Jul 2026 14:06:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjdma-0000000CIxK-1hVr;
	Tue, 14 Jul 2026 14:06:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=bBoBfUS5WMssGgUA/Wo3+dYqN4HjYGy3oqxDSlnyggk=; b=UuJ8HVQvPhmEDggDu+4Qk70zKG
	ZhGk+w/87sAliibjzcd3DJYitDE7BTIY7FrvSoPE909MmIkWS95KEp+5R2X8ScO7ppr6TugTP3hgG
	NJlDj2o0NWkBVpv3Hyw7OncTIV8IoNrYt++yOt8VL8oPTfRQ8wmmAR4RdUHdk0tc6TgXI5BQfD9ww
	wYMEFGAjvHy++qU5UuhsIsi3pXYI1RlsdNH1UZ7MFzJFICZMn6JIEMcr6Re4nQ0TYZRVI92YvqbGx
	CLenrgKQM80FJvlmMwvX9bDkt2GrmXR294EQV0XYFhK7GKt6f/sTJO97YRz5Q3PSn5DMzqenMvtnS
	ZAo5vwPQ==;
Received: from foss.arm.com ([217.140.110.172])
	by desiato.infradead.org with esmtp (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wjdmW-0000000CZCY-0jc4;
	Tue, 14 Jul 2026 14:06:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5A831BF7;
	Tue, 14 Jul 2026 07:06:38 -0700 (PDT)
Received: from localhost.localdomain (e123572-lin.cambridge.arm.com [10.2.208.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BDF53F7B4;
	Tue, 14 Jul 2026 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784038002; bh=mkvNiLNNU7+2GzQNF8eqTlv1xCMmv8/GPTLyXVohroo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HIiwhwiW5/FaoSRBjo11aX1AZpPuYcroDE7X41LVr/xwN0xxR7sqYi+EShBKHthpF
	 n4f8woYlTVlDt26juvjhHDNOK/I92UerlQVr0VVHNOso4VCLR4Gq0Tj1gOY6PCuWSc
	 FVgEvZfyeKpZuGic61DbMkRghFHRNE75lpgzlmYM=
From: Kevin Brodsky <kevin.brodsky@arm.com>
Date: Tue, 14 Jul 2026 15:04:01 +0100
Subject: [PATCH 12/22] x86/mm: use mm_is_kernel() for kernel mm checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-remove_pgtable_cdtor-v1-12-44be8a7685d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784037902; l=3862;
 i=kevin.brodsky@arm.com; s=20260427; h=from:subject:message-id;
 bh=mkvNiLNNU7+2GzQNF8eqTlv1xCMmv8/GPTLyXVohroo=;
 b=TL/ATO2WidViUjXp4JukAFDeik9Bhx9UKyamDJVrFhja594xcdOFPLXtYE8/VvFDMq3oXLjVT
 9Ry1qd/NBLGBGmKjBP3mLajDf99Eimk93BsQgUsx2B9iCCZoXZcZow+
X-Developer-Key: i=kevin.brodsky@arm.com; a=ed25519;
 pk=N2QG+eJKrvkNovwhhwJhnJ4+ScVfsGCHldmqLfcMTFs=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_150644_636933_E8781E83 
X-CRM114-Status: GOOD (  15.85  )
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

The new MMF_KERNEL flag identifies kernel-owned mm's. Checking the
flag with mm_is_kernel() is preferred over comparing directly
against &init_mm.

No functional change, as only init_mm has MMF_KERNEL set for now.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/x86/include/asm/tlbflush.h | 8 ++++----
 arch/x86/mm/pgtable.c           | 2 +-
 arch/x86/mm/tlb.c               | 9 +++++----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 0545fe75c3fa..4af1cf711a60 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -159,10 +159,10 @@ struct tlb_state_shared {
 	 *  - Actively using an mm.  Our CPU's bit will be set in
 	 *    mm_cpumask(loaded_mm) and is_lazy == false;
 	 *
-	 *  - Not using a real mm.  loaded_mm == &init_mm.  Our CPU's bit
-	 *    will not be set in mm_cpumask(&init_mm) and is_lazy == false.
+	 *  - Not using a real mm. loaded_mm is a kernel mm. Our CPU's bit
+	 *    will not be set in mm_cpumask(loaded_mm) and is_lazy == false.
 	 *
-	 *  - Lazily using a real mm.  loaded_mm != &init_mm, our bit
+	 *  - Lazily using a real mm. loaded_mm is not a kernel mm, our bit
 	 *    is set in mm_cpumask(loaded_mm), but is_lazy == true.
 	 *    We're heuristically guessing that the CR3 load we
 	 *    skipped more than makes up for the overhead added by
@@ -188,7 +188,7 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
 #define enter_lazy_tlb enter_lazy_tlb
 static __always_inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
-	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
+	if (mm_is_kernel(this_cpu_read(cpu_tlbstate.loaded_mm)))
 		return;
 
 	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f32facdb3035..91d2a6f2ac5a 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -168,7 +168,7 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 	bool failed = false;
 	gfp_t gfp = GFP_PGTABLE_USER;
 
-	if (mm == &init_mm)
+	if (mm_is_kernel(mm))
 		gfp &= ~__GFP_ACCOUNT;
 	gfp &= ~__GFP_HIGHMEM;
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1023acadd8f8..5517cab8ad00 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -594,7 +594,7 @@ void leave_mm(void)
 	 * This needs to happen before any other sanity checks due to
 	 * intel_idle's shenanigans.
 	 */
-	if (loaded_mm == &init_mm)
+	if (mm_is_kernel(loaded_mm))
 		return;
 
 	/* Warn if we're not lazy. */
@@ -855,7 +855,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		 * cpu_tlbstate_shared.is_lazy whether or not to send an IPI.
 		 */
 		if (IS_ENABLED(CONFIG_DEBUG_VM) &&
-		    WARN_ON_ONCE(prev != &init_mm && !is_notrack_mm(prev) &&
+		    WARN_ON_ONCE(!mm_is_kernel(prev) && !is_notrack_mm(prev) &&
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 
@@ -932,7 +932,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		 * This way switch_mm() must see the new tlb_gen or
 		 * flush_tlb_mm_range() must see the new loaded_mm, or both.
 		 */
-		if (next != &init_mm && !cpumask_test_cpu(cpu, mm_cpumask(next)))
+		if (!mm_is_kernel(next) &&
+		    !cpumask_test_cpu(cpu, mm_cpumask(next)))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 		else
 			smp_mb();
@@ -1134,7 +1135,7 @@ static void flush_tlb_func(void *info)
 		return;
 	}
 
-	if (unlikely(loaded_mm == &init_mm))
+	if (unlikely(mm_is_kernel(loaded_mm)))
 		return;
 
 	/* Reload the ASID if transitioning into or out of a global ASID */

-- 
2.51.2


