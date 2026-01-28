Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816BAD35660
	for <linux-um@archiver.kernel.org>; Wed, 28 Jan 2026 02:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n4t3b1mOfPtHigPq6Z2WHKbf3iNBrW17rXF/iuZKlWU=; b=3D8CL9uO/2C92z+ZoiKimQ9fhq
	sfgzXMRzuwkVFl+7fp2K5+NM3zQKrUv241fdTVYXBxzoevfV7D2OSF4F5PZW4z39ATi82hJU8VW5R
	duWPSdGv7r3NIGT+dumeJsSN2WqYCpSegC6s5wIlNowR/VF+r7121qYH5goP40V2xxtjq2JsarMZZ
	3HzK2go6tL/mhSBFgq/Ps6aMSgaZ0+DQJQ0HupD2M8rI7SgjO/z/oP8eLeateh3NaHpKvJtM0y9YL
	YsjV5EroB84WKniekcLhO3k3PydhX6qpTUSeY8konEuA5nGqs4tucHYKgaIOrz523zENN1XNfhoPi
	BMdY2c9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkuyC-0000000FI1F-0Prz;
	Wed, 28 Jan 2026 02:07:48 +0000
Received: from out-171.mta0.migadu.com ([2001:41d0:1004:224b::ab])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkuy8-0000000FI0f-4484
	for linux-um@lists.infradead.org;
	Wed, 28 Jan 2026 02:07:46 +0000
Message-ID: <4c171a25-e395-4f83-b767-18525fffbee3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769566051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4t3b1mOfPtHigPq6Z2WHKbf3iNBrW17rXF/iuZKlWU=;
	b=I3HQOiCHRK+ra8CKqHdI7J6UYtfRC6z7IH9vbCxNEd8HoqK7Tyx5NW2XzLCUbSdOwtEHCJ
	PrvEUB70GyyRlx7g5xA0Csz7PDTqbdzG32WNgMGufhfuOIaPPVRKNpL+JiU8gfGGSpRv5N
	IuXL9L87r74XS+4rqkFgpDIaGTmcayA=
Date: Wed, 28 Jan 2026 10:07:22 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/8] enable PT_RECLAIM on more 64-bit architectures
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@kernel.org, andreas@gaisler.com, richard.weiyang@gmail.com,
 will@kernel.org, peterz@infradead.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, dev.jain@arm.com, ioworker0@gmail.com, linmag7@gmail.com,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, sparclinux@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1769515122.git.zhengqi.arch@bytedance.com>
 <20260127124642.480123beb01ebb487f986a09@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260127124642.480123beb01ebb487f986a09@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260127_180745_251743_F07D98FC 
X-CRM114-Status: GOOD (  20.11  )
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



On 1/28/26 4:46 AM, Andrew Morton wrote:
> On Tue, 27 Jan 2026 20:12:53 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> 
>> This series aims to enable PT_RECLAIM on more 64-bit architectures.
> 
> Thanks, I updated mm.git's mm-unstable branch to v4.
> 
>> Changes in v4:
>>   - convert __HAVE_ARCH_TLB_REMOVE_TABLE to CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config
>>   - fix a WARN_ON_ONCE() on sparc64 (and on ppc)
>>     (reported by Andreas Larsson)
>>   - collect Acked-by (Hi David, I've kept your Acked-by, feel free to drop it)
>>   - rebase onto the v6.19-rc7
>>
> 
> Below is how v4 altered mm.git.
> 
> I'm not seeing the WARN_ON_ONCE() fix.  I assume that was due to the
> Kconfig alterations?

Yes, sparc64 and ppc will select HAVE_ARCH_TLB_REMOVE_TABLE, so
PT_RECLAIM will not be enabled. This means it won't affect
sparc64 and ppc, and will not trigger WARN_ON_ONCE().

I don't have a testing environment for sparc64 and ppc, but I
expect it should be able to fix the WARN_ON_ONCE().

Thanks,
Qi

> 
> 
> 
> --- a/arch/powerpc/include/asm/tlb.h~b
> +++ a/arch/powerpc/include/asm/tlb.h
> @@ -37,7 +37,6 @@ extern void tlb_flush(struct mmu_gather
>    */
>   #define tlb_needs_table_invalidate()	radix_enabled()
>   
> -#define __HAVE_ARCH_TLB_REMOVE_TABLE
>   /* Get the generic bits... */
>   #include <asm-generic/tlb.h>
>   
> --- a/arch/powerpc/Kconfig~b
> +++ a/arch/powerpc/Kconfig
> @@ -305,6 +305,7 @@ config PPC
>   	select LOCK_MM_AND_FIND_VMA
>   	select MMU_GATHER_PAGE_SIZE
>   	select MMU_GATHER_RCU_TABLE_FREE
> +	select HAVE_ARCH_TLB_REMOVE_TABLE
>   	select MMU_GATHER_MERGE_VMAS
>   	select MMU_LAZY_TLB_SHOOTDOWN		if PPC_BOOK3S_64
>   	select MODULES_USE_ELF_RELA
> --- a/arch/sparc/include/asm/tlb_64.h~b
> +++ a/arch/sparc/include/asm/tlb_64.h
> @@ -33,7 +33,6 @@ void flush_tlb_pending(void);
>   #define tlb_needs_table_invalidate()	(false)
>   #endif
>   
> -#define __HAVE_ARCH_TLB_REMOVE_TABLE
>   #include <asm-generic/tlb.h>
>   
>   #endif /* _SPARC64_TLB_H */
> --- a/arch/sparc/Kconfig~b
> +++ a/arch/sparc/Kconfig
> @@ -74,6 +74,7 @@ config SPARC64
>   	select HAVE_KRETPROBES
>   	select HAVE_KPROBES
>   	select MMU_GATHER_RCU_TABLE_FREE if SMP
> +	select HAVE_ARCH_TLB_REMOVE_TABLE if SMP
>   	select MMU_GATHER_MERGE_VMAS
>   	select MMU_GATHER_NO_FLUSH_CACHE
>   	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
> --- a/include/asm-generic/tlb.h~b
> +++ a/include/asm-generic/tlb.h
> @@ -213,7 +213,7 @@ struct mmu_table_batch {
>   #define MAX_TABLE_BATCH		\
>   	((PAGE_SIZE - sizeof(struct mmu_table_batch)) / sizeof(void *))
>   
> -#ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
> +#ifndef CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE
>   static inline void __tlb_remove_table(void *table)
>   {
>   	struct ptdesc *ptdesc = (struct ptdesc *)table;
> --- a/mm/Kconfig~b
> +++ a/mm/Kconfig
> @@ -1448,9 +1448,12 @@ config ARCH_HAS_USER_SHADOW_STACK
>   	  The architecture has hardware support for userspace shadow call
>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>   
> +config HAVE_ARCH_TLB_REMOVE_TABLE
> +	def_bool n
> +
>   config PT_RECLAIM
>   	def_bool y
> -	depends on MMU_GATHER_RCU_TABLE_FREE
> +	depends on MMU_GATHER_RCU_TABLE_FREE && !HAVE_ARCH_TLB_REMOVE_TABLE
>   	help
>   	  Try to reclaim empty user page table pages in paths other than munmap
>   	  and exit_mmap path.
> _
> 


