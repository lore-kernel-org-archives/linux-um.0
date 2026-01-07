Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9D6CF6BEC
	for <linux-um@archiver.kernel.org>; Wed,  7 Jan 2026 04:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:Date:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nurUXHNs091EaceKYt0jtxQiBJ2IaAdTDr7CGJ+zWBU=; b=bBLsQQ+cT7ZvkMjK6V1EHfw/eN
	PfewBpfK3FcP91DdJ2e5cRaJd1q70oYTM6gUF7Zq4qZ5MDVtEt+IBLx44kikyrmqgN4VyeSYeKDpq
	Y0AyiShvIGkdwcQSzFPdzoB4d1bB6ICETACk4j/XSHJOu1cYdUhOa0DsNeQS5er+TNUpyyPsQEBJx
	P9lN1FKQrkAQtMsSagLpheAYrbGO3uPkBEAOMN9ZKz9EKqHmeFZRRMC9axxbNJsEMYHHflF+ovLqT
	/kn80pSPohroyed9PLg4M3cJZRcAvFY9N64ev/BqlbInU5mIXzFOJp/0nBKR9IsNNjRWUPwEv5XrB
	R9YHM98A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdLco-0000000EAHX-3rIa;
	Wed, 07 Jan 2026 04:58:26 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdLcl-0000000EAG6-1cru
	for linux-um@lists.infradead.org;
	Wed, 07 Jan 2026 04:58:25 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-34c71f462d2so1618970a91.0
        for <linux-um@lists.infradead.org>; Tue, 06 Jan 2026 20:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767761902; x=1768366702; darn=lists.infradead.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nurUXHNs091EaceKYt0jtxQiBJ2IaAdTDr7CGJ+zWBU=;
        b=aKqe1+Hs5jYE9MkwLcrTKlJLIw85Lxti/5NndB7CuRNr4YucpZ76yw68w6mVpc7/ZR
         rAXSpDMV0nsS6Bc49HZ1FPK+ufBBSpn6JNVB7Gc6fiJdsHsOIVIhN3op2toCQXzeBT6F
         b9GNIV18ETHRWjWwZf7TUH2/JgyOpkM1SVIIov5TiA6qNBoKrVz5U7Rr3AJ0xsgSGcNh
         A1Q0558A19ZV/0E41l9+J31KFGbkMuTJMI/sfIDVeFZOuDuC/jPbh6DmuzaJ/9XtnYh/
         4AZykFqOMV2OjHOyijx9fATpG2D2edz1BS1NlRoP3L4kcWnFRYR/vJ5vp3izM744JGU6
         9kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767761902; x=1768366702;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nurUXHNs091EaceKYt0jtxQiBJ2IaAdTDr7CGJ+zWBU=;
        b=GdU8uzSbyqi+3AkOeypgm9I5+ytopVEr6Qr7ECUXi0/WScfRje6YZNRquwfs7SwaOr
         AHcaqedW5j6MDgjm4cf/kiSXhn4UnHH5DcsHT3t9JmWx2J1reSXKIHY/EjzJ8+XxPnO3
         2XVTSZsvRXYJK5d9iKihuPw3ytTqOpn8kweZHNq8sTWaeCIDBLhW6OkKYbTmIIwUhSRv
         MCKD3K1sfiK2i+rtwEyV0ud5J0U8NXSY14T2/WjsC50GOZQwBpepkMEgYmfC0ZR/aqUF
         gSTZi4I42/fUhqLMGx9ufrM2eV/BCVcNTMkiH8f7Ts+ZSyq6YHxXxoY5THRCZx+0uAW1
         TQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS13UkMVUfCuvflqj5AfNPanRvyGmy+bUAKd9yKRWKkKI/aUYjsDDCBSXPfBtDdsOSqUktwc4R/A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyLhBL2TlsVNvU0evuD2ZLSwFXNKFtcbdpSLtF6DwrFq0OCO0kK
	JmLjgG2Li2jzek8noFqojDlaGoOlr52Iio4JQIzE/201j5UHA1crqizY689/sc54+iI=
X-Gm-Gg: AY/fxX659q14A90HdzR0JicAbJusaUpi0vdj1cUHTliWWiE5rtqL297IlQAqq050iKu
	YwFR6v+CMyRsO2rJ7o9vh495pAu0OHBm0rUQ+3eHlvx/QsfIo+pg1LX4U3FPGVCVNaflN4tuo7W
	J2uwJHDsCM9gn5dR8OUvtPmuk+0NWJBlfupexDJ2TG7z4sq+LLlxfsaSZzHHpxe34WqHGgdZqYN
	2Lz9LW6dflm2BMNoY2yDj6lyTyUXKCIseyHyFk7ECzb8lrP8Cq222toR+LAxgcEDSRS2sKCw+G+
	ZoIbD0eBzrXv64+QmQz51upXgl2R3HZqaxSWH7pO4v5wNv1G8Iueofg+yZhXd0vK2XADt0kiu/F
	TFJDowrywJlxf4c0hp6IVTs78feSZVziljoKHpQsK9VoNgvadDTv0a+VJAD87uMDOO98MjOLQ0A
	fDhpXLlA==
X-Google-Smtp-Source: AGHT+IE3iEJ4twso46GOnqJPDopUox2qFLaKHiDPKI95vlPPxjV/F7mxvaI/CeOE2s8GrRHRScEd6Q==
X-Received: by 2002:a17:90b:6c7:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-34f68d3b4a4mr1191743a91.33.1767761901762;
        Tue, 06 Jan 2026 20:58:21 -0800 (PST)
Received: from dw-tp ([49.207.192.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb75902sm3622895a91.16.2026.01.06.20.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 20:58:20 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, 
	Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 14/28] powerpc: introduce arch_zone_limits_init()
In-Reply-To: <20260102070005.65328-15-rppt@kernel.org>
Date: Wed, 07 Jan 2026 09:57:34 +0530
Message-ID: <87ldia9he1.ritesh.list@gmail.com>
References: <20260102070005.65328-1-rppt@kernel.org> <20260102070005.65328-15-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_205823_437111_132A8ADD 
X-CRM114-Status: GOOD (  18.89  )
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

Mike Rapoport <rppt@kernel.org> writes:

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
>  arch/powerpc/mm/mem.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 3ddbfdbfa941..32c496bfab4f 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -221,13 +221,23 @@ static int __init mark_nonram_nosave(void)
>   * anyway) will take a first dip into ZONE_NORMAL and get otherwise served by
>   * ZONE_DMA.
>   */
> -static unsigned long max_zone_pfns[MAX_NR_ZONES];
> +void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
> +{
> +#ifdef CONFIG_ZONE_DMA
> +	max_zone_pfns[ZONE_DMA]	= min(zone_dma_limit, max_low_pfn - 1) + 1;

Hi Mike, 

This doesn't look correct. Isn't the zone_dma_limit value in bytes actually?
Shouldn't it be -

     max_zone_pfns[ZONE_DMA] = min((zone_dma_limit >> PAGE_SHIFT) + 1, max_low_pfn);


-ritesh


> +#endif
> +	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> +#ifdef CONFIG_HIGHMEM
> +	max_zone_pfns[ZONE_HIGHMEM] = max_pfn;
> +#endif
> +}
>  
>  /*
>   * paging_init() sets up the page tables - in fact we've already done this.
>   */
>  void __init paging_init(void)
>  {
> +	unsigned long max_zone_pfns[MAX_NR_ZONES];
>  	unsigned long long total_ram = memblock_phys_mem_size();
>  	phys_addr_t top_of_ram = memblock_end_of_DRAM();
>  	int zone_dma_bits;
> @@ -259,15 +269,7 @@ void __init paging_init(void)
>  
>  	zone_dma_limit = DMA_BIT_MASK(zone_dma_bits);
>  
> -#ifdef CONFIG_ZONE_DMA
> -	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
> -				      1UL << (zone_dma_bits - PAGE_SHIFT));
> -#endif
> -	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> -#ifdef CONFIG_HIGHMEM
> -	max_zone_pfns[ZONE_HIGHMEM] = max_pfn;
> -#endif
> -
> +	arch_zone_limits_init(max_zone_pfns);
>  	free_area_init(max_zone_pfns);
>  
>  	mark_nonram_nosave();
> -- 
> 2.51.0


