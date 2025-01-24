Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED42C02181
	for <linux-um@archiver.kernel.org>; Fri, 24 Jan 2025 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rRSCJVP4ndkq+xRdOcjvb/DEkivJMHzPDW1Wja0Gha4=; b=af86sm7eP2fjG7qefyAg/WodKq
	EszDQrOCAzNbg7wEQdlyg+YVZVSyf4omLhTyawjeI2aXLV+HSIhKDKs+fgFDyllz4374pyLdvb2w5
	qh5s6x6xtDg3I8mD8uG1jEjg+TG80c4elnbmo8hqOu8Ubzbfdl8ubRLuAsz25z6rDYpsgqgcokZXl
	w1lYtlNrg5k8JqES9f6qrVZNMshke9IlQH5Eb2m7ISbGsF0YXgbhm190/dmdwsNqNo6PklaDixTcc
	d66mrbRBvNIN9tS1R8E27MYlz/+tS7tUm7GneTowpwZw2fRt1+wB+gLRbByvrEDvmXI6g6eWMtCnx
	bTZZ5fOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbI1f-0000000EaKm-1Evu;
	Fri, 24 Jan 2025 11:39:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbI1d-0000000EaK9-29H2;
	Fri, 24 Jan 2025 11:39:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rRSCJVP4ndkq+xRdOcjvb/DEkivJMHzPDW1Wja0Gha4=; b=KTnsm3fI9AVUkSyp8H79u1gvIz
	aIz07uHBUUDNqQHPOsEPfJaMlksY/+r3dYGd0Gxfpw5KxMpfMD2FkouQIrcub+WAKrKn4xeI8Yrxy
	/JWF1La3cgVbC0hS1rEVG+rtaI340Lq6gd4Djr1FIB0Kz/QdwfC916H5opJ/qJgBtdfvMLYBk235I
	kMi7ATe4rFN6fjRcPB6ph4dPJ+0AcEoI5og8pTmRk87vqFQTj1juTejBclTopp7UdySCyr2k2P1Tr
	FhWEsbRpsHNUOuErEvqkxZ+fKWTUj17WehlSgkP6BiYr8gJ0MX2YIaiVPOt2otMzzaFVFlloWy0Ak
	neR9SFMg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tbI1X-0000000Dzku-05Il;
	Fri, 24 Jan 2025 11:38:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5F707300619; Fri, 24 Jan 2025 12:38:54 +0100 (CET)
Date: Fri, 24 Jan 2025 12:38:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: kevin.brodsky@arm.com, riel@surriel.com, vishal.moola@gmail.com,
	david@redhat.com, jannh@google.com, hughd@google.com,
	willy@infradead.org, yuzhao@google.com, muchun.song@linux.dev,
	akpm@linux-foundation.org, will@kernel.org, aneesh.kumar@kernel.org,
	npiggin@gmail.com, arnd@arndb.de, dave.hansen@linux.intel.com,
	rppt@kernel.org, alexghiti@rivosinc.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org, x86@kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/5] x86: pgtable: unconditionally use tlb_remove_table()
Message-ID: <20250124113854.GA15996@noisy.programming.kicks-ass.net>
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
 <00bf7935d65826eee547ac195d7854b1c946dbc5.1737637631.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00bf7935d65826eee547ac195d7854b1c946dbc5.1737637631.git.zhengqi.arch@bytedance.com>
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

On Thu, Jan 23, 2025 at 09:26:17PM +0800, Qi Zheng wrote:
> If the CONFIG_MMU_GATHER_TABLE_FREE is disabled, the tlb_remove_table()
> will fall back to pagetable_dtor() + tlb_remove_page(). So let's use
> tlb_remove_table() unconditionally to free page table pages.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I think we can clean up more :-)


diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index cc8c3bd0e7c2..1f7c3082a36d 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -239,5 +239,4 @@ void hyperv_setup_mmu_ops(void)
 
 	pr_info("Using hypercall for remote TLB flush\n");
 	pv_ops.mmu.flush_tlb_multi = hyperv_flush_tlb_multi;
-	pv_ops.mmu.tlb_remove_table = tlb_remove_table;
 }
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 041aff51eb50..38a632a282d4 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -91,11 +91,6 @@ static inline void __flush_tlb_multi(const struct cpumask *cpumask,
 	PVOP_VCALL2(mmu.flush_tlb_multi, cpumask, info);
 }
 
-static inline void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	PVOP_VCALL2(mmu.tlb_remove_table, tlb, table);
-}
-
 static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 {
 	PVOP_VCALL1(mmu.exit_mmap, mm);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index fea56b04f436..e26633c00455 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -134,8 +134,6 @@ struct pv_mmu_ops {
 	void (*flush_tlb_multi)(const struct cpumask *cpus,
 				const struct flush_tlb_info *info);
 
-	void (*tlb_remove_table)(struct mmu_gather *tlb, void *table);
-
 	/* Hook for intercepting the destruction of an mm_struct. */
 	void (*exit_mmap)(struct mm_struct *mm);
 	void (*notify_page_enc_status_changed)(unsigned long pfn, int npages, bool enc);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 7a422a6c5983..3be9b3342c67 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -838,7 +838,6 @@ static void __init kvm_guest_init(void)
 #ifdef CONFIG_SMP
 	if (pv_tlb_flush_supported()) {
 		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
-		pv_ops.mmu.tlb_remove_table = tlb_remove_table;
 		pr_info("KVM setup pv remote TLB flush\n");
 	}
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 527f5605aa3e..2aa251d0b308 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -180,7 +180,6 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
 	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
-	.mmu.tlb_remove_table	= tlb_remove_table,
 
 	.mmu.exit_mmap		= paravirt_nop,
 	.mmu.notify_page_enc_status_changed	= paravirt_nop,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3bc8ad282b27..b1c1f72c1fd1 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -18,14 +18,6 @@ EXPORT_SYMBOL(physical_mask);
 #define PGTABLE_HIGHMEM 0
 #endif
 
-#ifndef CONFIG_PARAVIRT
-static inline
-void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	tlb_remove_table(tlb, table);
-}
-#endif /* !CONFIG_PARAVIRT */
-
 gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
@@ -53,7 +45,7 @@ early_param("userpte", setup_userpte);
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
 	paravirt_release_pte(page_to_pfn(pte));
-	paravirt_tlb_remove_table(tlb, page_ptdesc(pte));
+	tlb_remove_table(tlb, page_ptdesc(pte));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -67,21 +59,21 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #ifdef CONFIG_X86_PAE
 	tlb->need_flush_all = 1;
 #endif
-	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(pmd));
+	tlb_remove_table(tlb, virt_to_ptdesc(pmd));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
-	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(pud));
+	tlb_remove_table(tlb, virt_to_ptdesc(pud));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
-	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(p4d));
+	tlb_remove_table(tlb, virt_to_ptdesc(p4d));
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
 #endif	/* CONFIG_PGTABLE_LEVELS > 3 */
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 2c70cd35e72c..a0b371557125 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2141,7 +2141,6 @@ static const typeof(pv_ops) xen_mmu_ops __initconst = {
 		.flush_tlb_kernel = xen_flush_tlb,
 		.flush_tlb_one_user = xen_flush_tlb_one_user,
 		.flush_tlb_multi = xen_flush_tlb_multi,
-		.tlb_remove_table = tlb_remove_table,
 
 		.pgd_alloc = xen_pgd_alloc,
 		.pgd_free = xen_pgd_free,

