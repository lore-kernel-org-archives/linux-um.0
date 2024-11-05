Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C8ED12671
	for <linux-um@archiver.kernel.org>; Tue,  5 Nov 2024 09:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5FQqNCLOKvW9glyiLM/dzYJq3UH5mFHYuAMx5Xe+JRM=; b=Zy/FkB3tVlQZio8YrU028J+C3o
	m4LHTfbt2xf7XRNxhs0I93+ynta4VlZkU/ncdCgyf3m9k0H6sl9f5icAM5AEg00N9fovVJ6um88Ol
	8YwopQZjtE4/MBTgu8cRy4KJvzs/gjHToVVihZq43onxercky2emZCV4VdXcmPkqwKFSOe9IyV9fs
	oBPJRezk+4iEKiBdG9O1ACqmVwfnkcxO5roSr2pfvRBPTD9GGMbBwsjCqJqVvcssOKOw3NmnT6wfv
	6Pu6tlAjbJD08sRWyr4x4jI6HW9QF6WGSYzHmZcDIzqol5Qnr8djebe6kETKCLRcweBIap3s1Fp9v
	v7lFMudg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8GKe-0000000GbII-2D2E;
	Tue, 05 Nov 2024 09:58:40 +0000
Received: from pegase2.c-s.fr ([93.17.235.10])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8GIp-0000000Gas2-1vhx;
	Tue, 05 Nov 2024 09:56:49 +0000
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XjNyz319Qz9sPd;
	Tue,  5 Nov 2024 10:56:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CpEO93zW8bQ7; Tue,  5 Nov 2024 10:56:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XjNyz27jdz9rvV;
	Tue,  5 Nov 2024 10:56:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 346688B770;
	Tue,  5 Nov 2024 10:56:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id BXNslob-hZDZ; Tue,  5 Nov 2024 10:56:43 +0100 (CET)
Received: from [192.168.232.44] (unknown [192.168.232.44])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E0918B763;
	Tue,  5 Nov 2024 10:56:42 +0100 (CET)
Message-ID: <9ee9c21b-179f-49aa-8c65-304c8ef2c9a7@csgroup.eu>
Date: Tue, 5 Nov 2024 10:56:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] asm-generic: add an optional pfn_valid check to
 page_to_phys
To: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org
References: <20241023053644.311692-1-hch@lst.de>
 <20241023053644.311692-3-hch@lst.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241023053644.311692-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_015647_680459_520A55CC 
X-CRM114-Status: GOOD (  14.31  )
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



Le 23/10/2024 à 07:36, Christoph Hellwig a écrit :
> page_to_pfn is usually implemented by pointer arithmetics on the memory
> map, which means that bogus input can lead to even more bogus output.
> 
> Powerpc had a pfn_valid check on the intermediate pfn in the page_to_phys
> implementation when CONFIG_DEBUG_VIRTUAL is defined, which seems
> generally useful, so add that to the generic version.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/asm-generic/memory_model.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
> index a73a140cbecd..6d1fb6162ac1 100644
> --- a/include/asm-generic/memory_model.h
> +++ b/include/asm-generic/memory_model.h
> @@ -64,7 +64,17 @@ static inline int pfn_valid(unsigned long pfn)
>   #define page_to_pfn __page_to_pfn
>   #define pfn_to_page __pfn_to_page
>   
> +#ifdef CONFIG_DEBUG_VIRTUAL
> +#define page_to_phys(page)						\
> +({									\
> +	unsigned long __pfn = page_to_pfn(page);			\
> +									\
> +	WARN_ON_ONCE(!pfn_valid(__pfn));				\

On powerpc I think it was a WARN_ON().

Will a WARN_ON_ONCE() be enough ?

> +	PFN_PHYS(__pfn);						\
> +})
> +#else
>   #define page_to_phys(page)	PFN_PHYS(page_to_pfn(page))
> +#endif /* CONFIG_DEBUG_VIRTUAL */
>   #define phys_to_page(phys)	pfn_to_page(PHYS_PFN(phys))
>   
>   #endif /* __ASSEMBLY__ */

