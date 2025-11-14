Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060F4CE7AEE
	for <linux-um@archiver.kernel.org>; Fri, 14 Nov 2025 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XNy4CVtGzelyvviljfMndhZwOP8iEHHQBelXlL4nqTk=; b=dy2g7CAOgIgY5YD9NaF67hMSzG
	14ANYN8BRdupvpMhK9PHJhBGaROhpEqbXRs36yY5qWnLAkPlf4fnujXe0wP+Qua8YtOxtQB3Dpbyp
	tNMHphMhxSOrnsf3CiaaDURaeo9ms/mR4cGaSmAV7IC11ZPcbvjFMrzT7WHC422QXfQzsyuTOVxky
	Zyp2FxymbuMdoB+9X0qosZ4bCgIOBiq5XUM2ZkzYZbbnvtZ1yZc4kwlwRYeI96rQS+c9hgaUjoDQ6
	xiWCtZphaofGVfcyxc4k7h3XmOeXRqw3ytrWePyYISxU8xlSpNmU450ktipfKLV5CJTW7LlD4joSr
	xQLo+SYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJrr4-0000000C6zS-1pKx;
	Fri, 14 Nov 2025 11:20:38 +0000
Received: from out-182.mta0.migadu.com ([91.218.175.182])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJrr2-0000000C6yJ-0tIA
	for linux-um@lists.infradead.org;
	Fri, 14 Nov 2025 11:20:37 +0000
Message-ID: <5199c367-aabb-43e7-951e-452657dcdddc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763119233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XNy4CVtGzelyvviljfMndhZwOP8iEHHQBelXlL4nqTk=;
	b=UXfRqxSYKG2iIMsq0y7QI0YBpjYVA43NAZ9FotdfgEA7smTT1ii+ka8Donlv0ylAHxiqBn
	RyGAslbUmXZRKFrWlOaihR1yjcUSTjpJEG9FlXij0/eiQO2C2bzMCPOKJbOhp0uN/N5ZXK
	KS3JrJ92b7MC5d87CAz8uAxX76wAATE=
Date: Fri, 14 Nov 2025 19:20:02 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] arc: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org,
 david@redhat.com, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <6a4192f5cef3049f123f08cb04ef5cd0179c3281.1763117269.git.zhengqi.arch@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <6a4192f5cef3049f123f08cb04ef5cd0179c3281.1763117269.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_032036_412217_7370C056 
X-CRM114-Status: GOOD (  12.68  )
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



On 11/14/25 7:11 PM, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
> empty PTE page table pages (such as 100GB+). To resolve this problem,
> first enable MMU_GATHER_RCU_TABLE_FREE to prepare for enabling the
> PT_RECLAIM feature, which resolves this problem.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Vineet Gupta <vgupta@kernel.org>
> ---
>   arch/arc/Kconfig               | 1 +
>   arch/arc/include/asm/pgalloc.h | 9 ++++++---
>   2 files changed, 7 insertions(+), 3 deletions(-)

Strangely, it seems that only ARC does not define CONFIG_64BIT?

Does the ARC architecture support 64-bit? Did I miss something?

> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index f27e6b90428e4..47db93952386d 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -54,6 +54,7 @@ config ARC
>   	select HAVE_ARCH_JUMP_LABEL if ISA_ARCV2 && !CPU_ENDIAN_BE32
>   	select TRACE_IRQFLAGS_SUPPORT
>   	select HAVE_EBPF_JIT if ISA_ARCV2
> +	select MMU_GATHER_RCU_TABLE_FREE
>   
>   config LOCKDEP_SUPPORT
>   	def_bool y
> diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
> index dfae070fe8d55..b1c6619435613 100644
> --- a/arch/arc/include/asm/pgalloc.h
> +++ b/arch/arc/include/asm/pgalloc.h
> @@ -72,7 +72,8 @@ static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4dp, pud_t *pudp)
>   	set_p4d(p4dp, __p4d((unsigned long)pudp));
>   }
>   
> -#define __pud_free_tlb(tlb, pmd, addr)  pud_free((tlb)->mm, pmd)
> +#define __pud_free_tlb(tlb, pud, addr)	\
> +	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pud))
>   
>   #endif
>   
> @@ -83,10 +84,12 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
>   	set_pud(pudp, __pud((unsigned long)pmdp));
>   }
>   
> -#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
> +#define __pmd_free_tlb(tlb, pmd, addr)	\
> +	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pmd))
>   
>   #endif
>   
> -#define __pte_free_tlb(tlb, pte, addr)  pte_free((tlb)->mm, pte)
> +#define __pte_free_tlb(tlb, pte, addr)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
>   
>   #endif /* _ASM_ARC_PGALLOC_H */


