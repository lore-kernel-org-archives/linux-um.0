Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB99CE7B13
	for <linux-um@archiver.kernel.org>; Fri, 14 Nov 2025 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S5k7JH94TxtMFEloEdFAxJN0t9UEXRCPKt9CyNpRt0Q=; b=LPiogSAWKA0cSCxkNu9aM+BRHX
	Qss9gCZ+vlD6yrM/fW9FnCleE9Afkg+hKn7F23BMG0B478zdhrwiCpX/jKeHVwrUTWrl6qtP2X0dW
	1u7LtRLywdWL/qN4vlCsPNtjZeG0NF6Wcl397WJh48Wp5uvt3JBek6AKP54wPy6SHVPCLpPVi6LfY
	VYely0ofYq06PsddCPAhCkrvQB/uqWbYkfpPB3KWImcaBM7yMxHZTZ3LUlbxQb9UO1Yh88uFQKlJP
	1I64qFvX8/mQOVzTsIVcUVsTeH/EXl1tSRIAMddP4qySK++0JgFhcYlhbwDtw2uOkqwun8kKk6F1S
	qJPHpeHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJucv-0000000CLWc-2GGL;
	Fri, 14 Nov 2025 14:18:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJucs-0000000CLUj-2SNh
	for linux-um@lists.infradead.org;
	Fri, 14 Nov 2025 14:18:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 08FCF40ADF
	for <linux-um@lists.infradead.org>; Fri, 14 Nov 2025 14:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54E9C116D0
	for <linux-um@lists.infradead.org>; Fri, 14 Nov 2025 14:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763129888;
	bh=FAWHKTbojrVdbFJ8884Lh9DTaMatsBJR+ahGaIp46Mc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mkEZucYYb4Jiqhxonin6JnXQQjntSnA/rHohrXlYtrzA07gFqs6TpbevhSdi093Ni
	 FRtY6RhqSYxdO6l+3TU7W13StMcizfxHFt2TckZL1B9JHGtsVlstiWJ6XsMjvoBpNr
	 Nh0C4TQVaCECF8rKK28r+QjazqB79RkO+hZQz3/e3qA1wuUoFhwCwOWXS8+ZFylNTl
	 AOG/0vQ3Gp+b10xMJUMg4l1Nrw1gNon+C6G6/E2vPoRdCqqrsgM7M34z3Sjzlowl2E
	 YEiar5qDgG0CqcBAXCtFq1P5aSG5CBCcSWMBIQO1rybYVc6b2T/qGBpm2m5jEPwykt
	 wpH+66uqMF5oA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b735b89501fso181890766b.0
        for <linux-um@lists.infradead.org>; Fri, 14 Nov 2025 06:18:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0Kp5JV6p0KSZB1Us4nj7EaBhE/F3rZ8Zx8+S8v7fuxlrpuHv/ai1AOWqWOLaxME0G4rAihiu2Yg==@lists.infradead.org
X-Gm-Message-State: AOJu0YydDzvf63KoUBMdRCdMrvqEHnV8rPeIuzslgskNMnZVDCtzEyNn
	AXFirPpWQPIXUbVGJaD7cEznPW4EpSkmLUQbq7Gvrk+vTD7pdAGJVtVtOPzC1sK3oWaUbu5Of6U
	NpL5H5F48SOV01VmjUAGZN2aWdbaj778=
X-Google-Smtp-Source: AGHT+IH2APpWlx01lvRmsEjk25T/BroXvRMmdJoqcqdhkk/l43ih7kDnYxsJFdqG1+mvDKp0yNH6Z0TrYw4LGkrxjmI=
X-Received: by 2002:a17:907:748:b0:b70:b661:cfcb with SMTP id
 a640c23a62f3a-b73678ee3a8mr261903966b.31.1763129887364; Fri, 14 Nov 2025
 06:18:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763117269.git.zhengqi.arch@bytedance.com> <146b5a0207052b38d04caac6b20756a61c2189b3.1763117269.git.zhengqi.arch@bytedance.com>
In-Reply-To: <146b5a0207052b38d04caac6b20756a61c2189b3.1763117269.git.zhengqi.arch@bytedance.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 14 Nov 2025 22:17:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6HL+mXeuLqgo5BOVBB0_GHTUmn7_7NTzdUpLX7NbuQ5w@mail.gmail.com>
X-Gm-Features: AWmQ_bnB_yOPM8We43AKxCyF0R_mmEJVAbU9qloFW-YqOpGJ4QJ0yARhVtFDLLs
Message-ID: <CAAhV-H6HL+mXeuLqgo5BOVBB0_GHTUmn7_7NTzdUpLX7NbuQ5w@mail.gmail.com>
Subject: Re: [PATCH 3/7] loongarch: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Qi Zheng <qi.zheng@linux.dev>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, 
	peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org, 
	david@redhat.com, ioworker0@gmail.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_061810_660102_0EE634C4 
X-CRM114-Status: GOOD (  16.85  )
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

Hi, Qi Zheng,

We usually use LoongArch rather than loongarch, but if you want to
keep consistency for all patches, just do it.

On Fri, Nov 14, 2025 at 7:13=E2=80=AFPM Qi Zheng <qi.zheng@linux.dev> wrote=
:
>
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>
> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
> empty PTE page table pages (such as 100GB+). To resolve this problem,
> first enable MMU_GATHER_RCU_TABLE_FREE to prepare for enabling the
> PT_RECLAIM feature, which resolves this problem.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> ---
>  arch/loongarch/Kconfig               | 1 +
>  arch/loongarch/include/asm/pgalloc.h | 6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 5b1116733d881..3bf2f2a9cd647 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -210,6 +210,7 @@ config LOONGARCH
>         select USER_STACKTRACE_SUPPORT
>         select VDSO_GETRANDOM
>         select ZONE_DMA32
> +       select MMU_GATHER_RCU_TABLE_FREE
Please use alpha-betical order.

>
>  config 32BIT
>         bool
> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/includ=
e/asm/pgalloc.h
> index 1c63a9d9a6d35..0539d04bf1525 100644
> --- a/arch/loongarch/include/asm/pgalloc.h
> +++ b/arch/loongarch/include/asm/pgalloc.h
> @@ -79,7 +79,8 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm=
, unsigned long address)
>         return pmd;
>  }
>
> -#define __pmd_free_tlb(tlb, x, addr)   pmd_free((tlb)->mm, x)
> +#define __pmd_free_tlb(tlb, x, addr)   \
> +       tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
I think we can define it in one line.

>
>  #endif
>
> @@ -99,7 +100,8 @@ static inline pud_t *pud_alloc_one(struct mm_struct *m=
m, unsigned long address)
>         return pud;
>  }
>
> -#define __pud_free_tlb(tlb, x, addr)   pud_free((tlb)->mm, x)
> +#define __pud_free_tlb(tlb, x, addr)   \
> +       tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
The same.

Other patches have the same problem.

Huacai

>
>  #endif /* __PAGETABLE_PUD_FOLDED */
>
> --
> 2.20.1
>

