Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0B6CEACEF
	for <linux-um@archiver.kernel.org>; Mon, 17 Nov 2025 16:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BTWh6KCVX3IOUXWMKrKtbyQgmh8U9cfwOHWJa+mV1OM=; b=vWoST6kMm36GDA/86z7jrHLruo
	z1cln+S4O4HfqmalGV4KeShXIjowlrvba25LYtJqIAwksYGW8+Kc5M8F47wh8akUlS8djmzULMkpR
	ipsJbLiSGVCmrF3nklXaizYYfmMRZUl2hCJ43mBHtf4UlW3JlAXHCYfKmiqoptGDsrRjBvfjGOfFk
	aorkbr9XWZPDcCBs+0idfANbEuaDxqUpwl27Brx4CuwxyKA87cGTxkUMBYXe2cXn6eN8B1WNdFbH7
	FIOsVbiDRRWJKHhE5kpFGMdcUcPcHebk5AkNNunfHLWBWIQgb2bTQxbWCmS0P9NrqFuomWLU7jvUE
	E4tpM8CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL2YL-0000000GRRc-0BgP;
	Mon, 17 Nov 2025 16:58:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL2YH-0000000GRR2-2tTL;
	Mon, 17 Nov 2025 16:58:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4CB7F41AD1;
	Mon, 17 Nov 2025 16:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11DDC116B1;
	Mon, 17 Nov 2025 16:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763398685;
	bh=XI7Dqc8hDG/imiQjwpaa5L5QUXIhiYHcmUsbHNJq770=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dPT+kdRJmrc++E4JgaDg0HvOn87ub1fN81aujiL3JuYrC+XABLmrn8IKbujtOxjox
	 06UW28/7RYwaB1AdZehoyv5pTGVprSBAXjHnoKbjSL+FhOIiMfHk/eazN5xF1ef35L
	 iI2y5+BgESdTBJPjDJ0iyZWOBGh7c+XsGh6M04pYgwNZsjWk51POupKSyh33gdm0EP
	 45y5/jkWLrEhutdIoC4OWF5kMcmkisDNjsD7jjLCsAiCX9ZO+pgaVPoMulUmJlaGb9
	 4LERACYZwJIsl5lju9+IsQAyONXCgmYbWkB3p/ehSBdOllMUN3kNW2OC6dfYrgwBMJ
	 Dugsm9vMMNdlA==
Message-ID: <355d3bf3-c6bc-403e-9f19-89259d868611@kernel.org>
Date: Mon, 17 Nov 2025 17:57:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] mm: make PT_RECLAIM depend on
 MMU_GATHER_RCU_TABLE_FREE && 64BIT
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
 akpm@linux-foundation.org, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch@bytedance.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_085805_794384_A627700B 
X-CRM114-Status: GOOD (  16.94  )
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

On 14.11.25 12:11, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>

Subject: s/&&/&/

> 
> Make PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE so that PT_RECLAIM can
> be enabled by default on all architectures that support
> MMU_GATHER_RCU_TABLE_FREE.
> 
> Considering that a large number of PTE page table pages (such as 100GB+)
> can only be caused on a 64-bit system, let PT_RECLAIM also depend on
> 64BIT.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   arch/x86/Kconfig | 1 -
>   mm/Kconfig       | 6 +-----
>   2 files changed, 1 insertion(+), 6 deletions(-)
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
> index a5a90b169435d..e795fbd69e50c 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1440,14 +1440,10 @@ config ARCH_HAS_USER_SHADOW_STACK
>   	  The architecture has hardware support for userspace shadow call
>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>   
> -config ARCH_SUPPORTS_PT_RECLAIM
> -	def_bool n
> -
>   config PT_RECLAIM
>   	bool "reclaim empty user page table pages"
>   	default y
> -	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
> -	select MMU_GATHER_RCU_TABLE_FREE
> +	depends on MMU_GATHER_RCU_TABLE_FREE && MMU && SMP && 64BIT

Who would we have MMU_GATHER_RCU_TABLE_FREE without MMU? (can we drop 
the MMU part)

Why do we care about SMP in the first place? (can we frop SMP)

But I also wonder why we need "MMU_GATHER_RCU_TABLE_FREE && 64BIT":

Would it be harmful on 32bit (sure, we might not reclaim as much, but 
still there is memory to be reclaimed?)?

If all 64BIT support MMU_GATHER_RCU_TABLE_FREE (as you previously 
state), why can't we only check for 64BIT?

-- 
Cheers

David

