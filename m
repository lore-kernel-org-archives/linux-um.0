Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D21DE77197
	for <linux-um@archiver.kernel.org>; Tue,  7 Jan 2025 12:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=afiW8AwTqxiyrnYAmDWsh5UN0PQKjWSItqqmcC5x0jI=; b=0BrxmklEg/mSfTr3DZvj+0pqSj
	OPCFh6UpR7ZE/iT1Rvc1evwiFbFOWCGp40xdoLyF6gJYnd7sdrTi5qe9jdBG3hYOsTXiRnKNt0B1J
	GLGjALhUWfvqQq01Gfypk3tcJiPP37DWhCvx+XB3WIacFAQIbr5CNUm0McgLTZBrOExiFnO8cFhVO
	SGNRxzGpClP5TQHhsdCgRRKh6G/7pOimzzBUKyrtKtVg+2hHKQeHZCemOzUsYh2BPtoKS8/sZPBfd
	edYXH8H0c1H85oepDc5c/3uO41rjI9K9kDlo1Ep0fvlu0KLWA0n8Td5IU4qN+CUv9H7pP6O/NuXg3
	trsecKtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV8mc-00000004mkB-3PlA;
	Tue, 07 Jan 2025 12:34:06 +0000
Received: from smtp-out3.simply.com ([94.231.106.210])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV8kk-00000004mFB-17FZ;
	Tue, 07 Jan 2025 12:32:15 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4YS9R95VpRz1DQrv;
	Tue,  7 Jan 2025 13:32:05 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4YS9R855Gvz1DPkt;
	Tue,  7 Jan 2025 13:32:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1736253125;
	bh=afiW8AwTqxiyrnYAmDWsh5UN0PQKjWSItqqmcC5x0jI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K8Sn0vHtwM1d9RRHFMpf2UBap6Ok8/k3Y7KwC2OxqXXituKlp3nxPRyAyw6ESSaEg
	 nRhg8kkgeHKR8GWCh1uafNV9eGH67rpjoOXkPL//LTDEBibTsZkLTAwXFx8/Wb/AXh
	 cIT1WOGyJ7orxqpPCFoWzougYe222KDCTr5pTxiQ=
Message-ID: <6e1aa2aa-a70d-4292-9c5e-21c8fea386f5@gaisler.com>
Date: Tue, 7 Jan 2025 13:32:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] mm: pgtable: introduce generic
 __tlb_remove_table()
To: Qi Zheng <zhengqi.arch@bytedance.com>, peterz@infradead.org,
 agordeev@linux.ibm.com, kevin.brodsky@arm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <f7febc7719fd84673a8eae8af71b7b4278d3e110.1735549103.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <f7febc7719fd84673a8eae8af71b7b4278d3e110.1735549103.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_043210_727319_60D0C403 
X-CRM114-Status: UNSURE (   9.41  )
X-CRM114-Notice: Please train this message.
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

On 2024-12-30 10:07, Qi Zheng wrote:
> diff --git a/arch/sparc/include/asm/tlb_32.h b/arch/sparc/include/asm/tlb_32.h
> index 5cd28a8793e39..910254867dfbd 100644
> --- a/arch/sparc/include/asm/tlb_32.h
> +++ b/arch/sparc/include/asm/tlb_32.h
> @@ -2,6 +2,7 @@
>  #ifndef _SPARC_TLB_H
>  #define _SPARC_TLB_H
>  
> +#define __HAVE_ARCH_TLB_REMOVE_TABLE

sparc32 does not select MMU_GATHER_TABLE_FREE, and therefore does not
have (nor need) __tlb_remove_table, so this define should not be added.


>  #include <asm-generic/tlb.h>
>  
>  #endif /* _SPARC_TLB_H */
> diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
> index 3037187482db7..1a6e694418e39 100644
> --- a/arch/sparc/include/asm/tlb_64.h
> +++ b/arch/sparc/include/asm/tlb_64.h
> @@ -33,6 +33,7 @@ void flush_tlb_pending(void);
>  #define tlb_needs_table_invalidate()	(false)
>  #endif
>  
> +#define __HAVE_ARCH_TLB_REMOVE_TABLE
>  #include <asm-generic/tlb.h>
>  
>  #endif /* _SPARC64_TLB_H */
LGTM. 


With the removal of the define for sparc32 in v5:

Acked-by: Andreas Larsson <andreas@gaisler.com> # sparc

Thanks,
Andreas


