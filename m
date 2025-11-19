Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFE9CF31AD
	for <linux-um@archiver.kernel.org>; Wed, 19 Nov 2025 11:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1k6hiefpZNiDm3uqDBvrzYJ/HsNFRw0daGH2fKm6G6Y=; b=SC4CJjbtrbyhecokKQ8LU+1caK
	PNrFws+QiKNRZmpkV0kOAY9NK0f7Ye+nTZSmhsRzj1CtdhOP8zTQIkHPYR06pOPhfFMH1KsUqfKM5
	BEgZvj0ex1nWGAL/b2bucImaovyCawGqv9fe5M8lEvY9rdim4Pacok2QLSyDotR0jGTjzBaeDdkeb
	Mb6KsD8rJazGugcW9XBayFMFDhoYdemARdJOoPLM2L54EFrC5yf1KWD45tUmMSVOCoFyyQ4lm/1gu
	HA8TY7o5/tzq8isaOXWqWIprj00ITcTehDeNisoolh4uDL+i/sQUs6ixcc4m+cdJfbgunkrGmIlON
	5pZVtB8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLgWX-000000032qQ-0YXW;
	Wed, 19 Nov 2025 11:38:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLgWV-000000032pk-1DWt
	for linux-um@lists.infradead.org;
	Wed, 19 Nov 2025 11:38:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A9B6143B53;
	Wed, 19 Nov 2025 11:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510B7C2BCB4;
	Wed, 19 Nov 2025 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763552334;
	bh=09EAP2XN+lRanTOPE2mYQg/imEyLIAMTytu/FERJ3KE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZbpzBxMPlijcUIWVvcKZTNGa7zCAJwZY9chXx+w8GbRHAR+rI1lSfYrqXSSvSDYaE
	 MePEVV4EjqdFYyQgiSidQHYaWwO7pQarT3TKZOtNh3sSfSwIQ6SflX1gDL9lMSxLny
	 w06MV9gY5w5TZlc4+ewlulKiXr9osdtN3qFwbuQWIMM4miVH0RvJzhNpO1lxypNit0
	 eeE/heuKvBJlnAAv4sK4Mv4MYw7Xohrvhu7Amo4HOBaY8PCND2DXnAiONttsXskaMh
	 8/Bno4vIYUEF05KYxb1WyXsUI4O64niqkk/pUg+0oPMnWbdq0tM2VTdA0KoQ6gV8im
	 c4sJ+iwsxJ/XQ==
Message-ID: <9b55623a-4606-4610-a0fe-55b8cd6b95e7@kernel.org>
Date: Wed, 19 Nov 2025 12:38:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] mm: enable PT_RECLAIM on all 64-bit architectures
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
 akpm@linux-foundation.org, ioworker0@gmail.com, linmag7@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763537007.git.zhengqi.arch@bytedance.com>
 <caacf08b765ef00770b7c75afdb5e5754485b2aa.1763537007.git.zhengqi.arch@bytedance.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <caacf08b765ef00770b7c75afdb5e5754485b2aa.1763537007.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_033855_361151_9945C274 
X-CRM114-Status: GOOD (  14.49  )
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

On 19.11.25 08:31, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Now, the MMU_GATHER_RCU_TABLE_FREE is enabled on all 64-bit architectures,
> so make PT_RECLAIM depend on 64BIT, thereby enabling PT_RECLAIM on all
> 64-bit architectures.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   arch/x86/Kconfig | 1 -
>   mm/Kconfig       | 9 ++-------
>   2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index eac2e86056902..96bff81fd4787 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -330,7 +330,6 @@ config X86
>   	select FUNCTION_ALIGNMENT_4B
>   	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>   	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> -	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
>   	select ARCH_SUPPORTS_SCHED_SMT		if SMP
>   	select SCHED_SMT			if SMP
>   	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
> diff --git a/mm/Kconfig b/mm/Kconfig
> index d548976d0e0ad..94eec5c0cad96 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1448,14 +1448,9 @@ config ARCH_HAS_USER_SHADOW_STACK
>   	  The architecture has hardware support for userspace shadow call
>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>   
> -config ARCH_SUPPORTS_PT_RECLAIM
> -	def_bool n
> -
>   config PT_RECLAIM
> -	bool "reclaim empty user page table pages"
> -	default y
> -	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
> -	select MMU_GATHER_RCU_TABLE_FREE
> +	def_bool y
> +	depends on 64BIT

As discussed in the other thread, likely

config PT_RECLAIM
	def_bool y
	depends on MMU_GATHER_RCU_TABLE_FREE && 64BIT

Could be nice, and if possible even dropping the 64BIT limitation as 
well if there is no need to.


-- 
Cheers

David

