Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCD9D2D0E6
	for <linux-um@archiver.kernel.org>; Tue, 13 Jan 2026 12:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=guD8ZDnRvesT5KvXlXi5P5IpxaFCA5kIle2X5/2VdEk=; b=mu0nBfDDLF2IjEZoBmtPW3DWE/
	rHAVWTRdoLMdcwIry7UHE5UWhDyNnKG6lnJ6G1Z3JWqyzYgt5LZI2gfEhWlJKY0g+jfq8SqRgyblt
	G6D8stXVXgS0ta/V74nCcTdgYj79rGvDTIVKXjyKVuxAVzNvwnSDHyu6D2qYCas8hN0PBxwWDPt91
	DLxyTpMJdGUCwJa9M5HUB4Dz6uc77D2VwIgYvBIWlGdei34yYKHGry7kTrpkSoQc9MQB8JmIYjEPM
	V8OYCbAdJvrsycYnhmxlwcLODlhjvibK7KOv5Dh+jgRFe5y7SDD9mU+OCDcZ4EH+1e5buoJ5d9hsX
	c3jDG4sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfdVY-000000074To-1Im0;
	Tue, 13 Jan 2026 12:28:24 +0000
Received: from smtp-out3.simply.com ([94.231.106.210])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfdVT-000000074Sj-3htt;
	Tue, 13 Jan 2026 12:28:22 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dr7nT4yQ4z1FDXl;
	Tue, 13 Jan 2026 13:28:13 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4dr7nQ25vMz1DDgf;
	Tue, 13 Jan 2026 13:28:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1768307293;
	bh=guD8ZDnRvesT5KvXlXi5P5IpxaFCA5kIle2X5/2VdEk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NC76RtxIq9CvKMBZ8e8fqDdeh4TXwyvNkvf30sHXNOLOnEVZmRBj+bHCDi8FufU/c
	 kWfZWHOIxSWOKL03enthax76m8YsczdRizVAQDjKjHPFRaRl/L5Y0iqK2UA8boHs2h
	 YUuM9qT6Ba/QEyyAn4GTFzIGpGi10RKIEp9TlTeLGd8zC+Hr/coq6gBL6LosZXZTF1
	 gt8Mie1XHzB/bpnFnld9TZavLmhYmlgBWFsXaCVZw4vobFyvtSEkURaEmNJU94ewFm
	 w3pY4SkxqHFB/QXGBXfUllqNu8tQIWuZ/XTNBQs4TvEhLsgrM+Wzf2b59+1+UOXxo8
	 bJQ987lvmGGqA==
Message-ID: <7566eef3-bce4-4100-8a11-d88ef1e887a9@gaisler.com>
Date: Tue, 13 Jan 2026 13:28:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/29] sparc: introduce arch_zone_limits_init()
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Corbet <corbet@lwn.net>, Klara Modin <klarasmodin@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Ritesh Harjani <ritesh.list@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org
References: <20260111082105.290734-1-rppt@kernel.org>
 <20260111082105.290734-20-rppt@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260111082105.290734-20-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_042820_308471_BA2B632A 
X-CRM114-Status: GOOD (  20.96  )
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

On 2026-01-11 09:20, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Move calculations of zone limits to a dedicated arch_zone_limits_init()
> function.
> 
> Later MM core will use this function as an architecture specific callback
> during nodes and zones initialization and thus there won't be a need to
> call free_area_init() from every architecture.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/sparc/mm/init_64.c |  6 ++++++
>  arch/sparc/mm/srmmu.c   | 12 ++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)

Hi Mike,

Thanks for this nice cleanup series.


> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index df9f7c444c39..fbaad449dfc9 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2279,6 +2279,11 @@ static void __init reduce_memory(phys_addr_t limit_ram)
>  	memblock_enforce_memory_limit(limit_ram);
>  }
>  
> +void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
> +{
> +	max_zone_pfns[ZONE_NORMAL] = last_valid_pfn;
> +}
> +
>  void __init paging_init(void)
>  {
>  	unsigned long end_pfn, shift, phys_base;
> @@ -2461,6 +2466,7 @@ void __init paging_init(void)
>  
>  		max_zone_pfns[ZONE_NORMAL] = end_pfn;

This old initialization of max_zone_pfns[ZONE_NORMAL] should also be
removed, right? With that removed it makes the local end_pfn variable
set but unused, so could you please also remove that one?

I know that this whole code block gets removed later, but the cleanup
max_zone_pfns[ZONE_NORMAL] and the removal of end_pfn (that is not done
later in this version of the series) fits logically in this patch.

>  
> +		arch_zone_limits_init(max_zone_pfns);
>  		free_area_init(max_zone_pfns);
>  	}
>  
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index f8fb4911d360..81e90151db90 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -884,6 +884,13 @@ static void __init map_kernel(void)
>  
>  void (*poke_srmmu)(void) = NULL;
>  
> +void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
> +{
> +	max_zone_pfns[ZONE_DMA] = max_low_pfn;
> +	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> +	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
> +}
> +
>  void __init srmmu_paging_init(void)
>  {
>  	int i;
> @@ -967,10 +974,7 @@ void __init srmmu_paging_init(void)
>  	{
>  		unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
>  
> -		max_zone_pfn[ZONE_DMA] = max_low_pfn;
> -		max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
> -		max_zone_pfn[ZONE_HIGHMEM] = highend_pfn;
> -
> +		arch_zone_limits_init(max_zone_pfn);
>  		free_area_init(max_zone_pfn);
>  	}
>  }

With the feedback for arch/sparc/mm/init_64.c addressed:

Acked-by: Andreas Larsson <andreas@gaisler.com>

Cheers,
Andreas


