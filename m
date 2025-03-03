Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A758C282C6
	for <linux-um@archiver.kernel.org>; Mon,  3 Mar 2025 01:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W8SnZDZRbvLSaoNIXAx3tJOrDKr8WC27+4Kk8dOe4BE=; b=dAJiZ+FVY9HUGv6PIHhtuxceXp
	4ajaRZnOxEpr2o7fMdojzVr4b6I97s467SSV92xdzgy3iCNCszFY+n/27S1qjaR1dLPfFHRc9k3o2
	oqJ6lrQQ81J/l1KqJ8IwVxlb44rzZGpqTOvz0KA/0oT4Wiow4RsH+ZPOm0M7GvdikEi6Zs9Mkl+8F
	v8lTgyuZQGXFOKBDBMbTKKGMsunKnxWlQpg6ezkVFI4HeQ0SV0sRMWV52q+Rwa5dtKTCAgzqzDi95
	43d0Ht3OjJHaTgwfgXLX8ehUMefSUgOmCv/2F0RvtZntcY+6c2KV05oyu0/l2+ZS9SIjOeHHAU0ER
	uh1GK5JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tousZ-0000000Guxw-02c5;
	Mon, 03 Mar 2025 01:45:59 +0000
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tousU-0000000Guvp-2Sc9
	for linux-um@lists.infradead.org;
	Mon, 03 Mar 2025 01:45:57 +0000
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-2bd2218ba4fso1015676fac.1
        for <linux-um@lists.infradead.org>; Sun, 02 Mar 2025 17:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740966349; x=1741571149; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8SnZDZRbvLSaoNIXAx3tJOrDKr8WC27+4Kk8dOe4BE=;
        b=cW9wnI8ssPLASxnYCDGNBlVrI4PKG2zvk3v7CZ3SsrrIHYoM3oPdVqrL0cxA23ud4u
         rNy5xMWTpuycHBY94lSTaYci/CSzn2TTzxy4sdyLpmv/JFx/3/Q9TIxa2Pshg+rv0IaH
         yVpCQzo/G9eaCqBp/neO32jIR/frrY+riVjFycjut8OePnW4cWq8YQ/1BEMxzVbwE1EC
         lyDZQPOU+JqXN9z4mXcTJqysFsidg3ABXXrm9R+rGXIbfwa6i0scY0xbgNXtmtBq8zrk
         AEUBvxfNGKlQ9Yh46C6qHx8Kx3iGIutkGdX9BVaRiKQSWcU75x6+ZZJmMaSAfi3gSlbC
         /5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740966349; x=1741571149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8SnZDZRbvLSaoNIXAx3tJOrDKr8WC27+4Kk8dOe4BE=;
        b=XY5E/j6ElLzkOJE5hzPrSnxbBU7xHTX8+HKc/O0E0YadY6vbDkpzJXxE8Nd72uqeLR
         74CwKh7CLijx0NzUDii26JFnEbY3aZOXmcvtLXLwDs9AYBB879W5wHZqwlOITiMcDqHK
         1QqzXMClUYuZCQwrfDqffruBDZFHC3XImmXjE9GaGjIRkE7IjwY40jzMdnzDUm2kJs01
         eBHsjF0NxETbwrHg/Wl9fOhchOHrqwtmatlKLuIbr+apMbJqti5pEEPO8tpSjmTMB18b
         XXNDFV7faTFGZsjf87G+JfTZAuKROKUPDIOUzhMBGOZ2KXJmwLzjaD/E+8zIZEYeNLSO
         sjRw==
X-Forwarded-Encrypted: i=1; AJvYcCXjkZYu/KD7SqK7tecB3SI8ErsQAtjIzL8eVskk7aeyw+3g1g2FNDKxKERzcH0q/uWRvjPqe6Ma6w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz74AS7ypVvbDz+rW0orh9G/aTMEic8wVX1JF9lFntmTykvZqOe
	vLFpK22KC8+ftIxTXPYzC+A5rCUd9qfW6L9YdcNL1GLPCscSDglFV7ZatNvItxyqiAQuPoGnaWy
	XhWc/HS0IV4JcMJh02IW3v47Wn5DndFl13eGe+A==
X-Gm-Gg: ASbGncugwE2yTlOoqNR6R2Z9w6XZi5usxFOWVqWzi05/mlCJmQWRZN4wGTtDaoojRrv
	2UqTjxhOVm8G8uqmDVEorM9DYROa0I7ow/9tt91Uivjdm6jvyirZMV5ewSvk8U3d2SV0bMkn7eq
	4LY7sRClmzlwRPmbwNbN547NiVX3Bm
X-Google-Smtp-Source: AGHT+IGOWIRMroQZxbRNJcNH5tnmnGD/bIDamuPKwa3GDm5B/gWkRsBelrb1kdvpy/ijW+hukYwC4esnzOdnOPSB3MY=
X-Received: by 2002:a05:6871:aa16:b0:2b8:3d1c:772 with SMTP id
 586e51a60fabf-2c178335be6mr6945276fac.5.1740966349475; Sun, 02 Mar 2025
 17:45:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740454179.git.zhengqi.arch@bytedance.com> <9025595e895515515c95e48db54b29afa489c41d.1740454179.git.zhengqi.arch@bytedance.com>
In-Reply-To: <9025595e895515515c95e48db54b29afa489c41d.1740454179.git.zhengqi.arch@bytedance.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 3 Mar 2025 09:45:37 +0800
X-Gm-Features: AQ5f1Jrb5nkY3jTSkwu3MIgtit28ISDfNBjj4Qwj5SXBUXKwFnVTECUIEIzLwQo
Message-ID: <CAEEQ3wnvgX=Bq=oAQV6wfg5a7H2jiG7f8P6trbC9agJ8D6t4pA@mail.gmail.com>
Subject: Re: [External] [PATCH v2 4/6] riscv: pgtable: unconditionally use tlb_remove_ptdesc()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com, 
	vishal.moola@gmail.com, david@redhat.com, jannh@google.com, hughd@google.com, 
	willy@infradead.org, yuzhao@google.com, muchun.song@linux.dev, 
	akpm@linux-foundation.org, will@kernel.org, aneesh.kumar@kernel.org, 
	npiggin@gmail.com, arnd@arndb.de, dave.hansen@linux.intel.com, 
	rppt@kernel.org, alexghiti@rivosinc.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, x86@kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250302_174554_902433_4183E74B 
X-CRM114-Status: GOOD (  33.04  )
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

Hi Qi,

On Tue, Feb 25, 2025 at 11:48=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.c=
om> wrote:
>
> To support fast gup, the commit 69be3fb111e7 ("riscv: enable
> MMU_GATHER_RCU_TABLE_FREE for SMP && MMU") did the following:
>
> 1) use tlb_remove_page_ptdesc() for those platforms which use IPI to
>    perform TLB shootdown
>
> 2) use tlb_remove_ptdesc() for those platforms which use SBI to perform
>    TLB shootdown
>
> The tlb_remove_page_ptdesc() is the wrapper of the tlb_remove_page(). By
> design, the tlb_remove_page() should be used to remove a normal page from
> a page table entry, and should not be used for page table pages.
>
> The tlb_remove_ptdesc() is the wrapper of the tlb_remove_table(), which i=
s
> designed specifically for freeing page table pages. If the
> CONFIG_MMU_GATHER_TABLE_FREE is enabled, the tlb_remove_table() will use
> semi RCU to free page table pages, that is:
>
>  - batch table freeing: asynchronous free by RCU
>  - single table freeing: IPI + synchronous free
>
> If the CONFIG_MMU_GATHER_TABLE_FREE is disabled, the tlb_remove_table()
> will fall back to pagetable_dtor() + tlb_remove_page().
>
> For case 1), since we need to perform TLB shootdown before freeing the
> page table page, the local_irq_save() in fast gup can block the freeing
> and protect the fast gup page walker. Therefore we can ensure safety by
> just using tlb_remove_page_ptdesc(). In addition, we can also the
> tlb_remove_ptdesc()/tlb_remove_table() to achieve it, and it doesn't
> matter whether CONFIG_MMU_GATHER_RCU_TABLE_FREE is selected. And in
> theory, the performance of freeing pages asynchronously via RCU will not
> be lower than synchronous free.
>
> For case 2), since local_irq_save() only disable S-privilege IPI irq but
> not M-privilege's, which is used by the SBI implementation to perform TLB
> shootdown, so we must select CONFIG_MMU_GATHER_RCU_TABLE_FREE and use
> tlb_remove_ptdesc() to ensure safety. The riscv selects this config for
> SMP && MMU, the CONFIG_RISCV_SBI is dependent on MMU. Therefore, only the
> UP system may have the situation where CONFIG_MMU_GATHER_RCU_TABLE_FREE i=
s
> disabled but CONFIG_RISCV_SBI is enabled. But there is no freeing vs fast
> gup race in the UP system.
>
> So, in summary, we can use tlb_remove_ptdesc() to support fast gup in all
> cases, and this interface is specifically designed for page table pages.
> So let's use it unconditionally.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/riscv/include/asm/pgalloc.h | 26 ++++----------------------
>  1 file changed, 4 insertions(+), 22 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pg=
alloc.h
> index 3e2aebea6312d..770ce18a7328b 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -15,24 +15,6 @@
>  #define __HAVE_ARCH_PUD_FREE
>  #include <asm-generic/pgalloc.h>
>
> -/*
> - * While riscv platforms with riscv_ipi_for_rfence as true require an IP=
I to
> - * perform TLB shootdown, some platforms with riscv_ipi_for_rfence as fa=
lse use
> - * SBI to perform TLB shootdown. To keep software pagetable walkers safe=
 in this
> - * case we switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). S=
ee the
> - * comment below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm=
-generic/tlb.h
> - * for more details.
> - */
> -static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void =
*pt)
> -{
> -       if (riscv_use_sbi_for_rfence()) {
> -               tlb_remove_ptdesc(tlb, pt);
> -       } else {
> -               pagetable_dtor(pt);
> -               tlb_remove_page_ptdesc(tlb, pt);
> -       }
> -}
> -
>  static inline void pmd_populate_kernel(struct mm_struct *mm,
>         pmd_t *pmd, pte_t *pte)
>  {
> @@ -108,14 +90,14 @@ static inline void __pud_free_tlb(struct mmu_gather =
*tlb, pud_t *pud,
>                                   unsigned long addr)
>  {
>         if (pgtable_l4_enabled)
> -               riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
> +               tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
>  }
>
>  static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
>                                   unsigned long addr)
>  {
>         if (pgtable_l5_enabled)
> -               riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
> +               tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
>  }
>  #endif /* __PAGETABLE_PMD_FOLDED */
>
> @@ -143,7 +125,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
>                                   unsigned long addr)
>  {
> -       riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
> +       tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
>  }
>
>  #endif /* __PAGETABLE_PMD_FOLDED */
> @@ -151,7 +133,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *=
tlb, pmd_t *pmd,
>  static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
>                                   unsigned long addr)
>  {
> -       riscv_tlb_remove_ptdesc(tlb, page_ptdesc(pte));
> +       tlb_remove_ptdesc(tlb, page_ptdesc(pte));
>  }
>  #endif /* CONFIG_MMU */
>
> --
> 2.20.1
>
>

This set of patches mainly refactors the remove page table function
interfaces. The comment "riscv_ipi_for_rfence" has been removed, as it
was no longer needed, and this patch handles that.

Additionally, whether riscv_use_sbi_for_rfence is true or false, page
tables can now be released using RCU. This patch changes the previous
synchronous release logic (for !riscv_use_sbi_for_rfence) to an
RCU-based release.

So, Reviewed-by: Yunhui Cui <cuiyunhui@bytedance.com>

Based on qemu-system-riscv64, I tested this patch. The log is as follows:
./gup_test
TAP version 13
1..1
# GUP_FAST_BENCHMARK: Time: get:663365 put:117 us
# ok 1 ioctl status 0
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

So, Tested-by: Yunhui Cui <cuiyunhui@bytedance.com>

Thanks,
Yunhui

