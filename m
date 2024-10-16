Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A7BD2A538
	for <linux-um@archiver.kernel.org>; Wed, 16 Oct 2024 17:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1GP0B75uZXvlMdPMs8sxWFWqOcAn6bbZYSntM7zvNeg=; b=JgTx0Fq54TUw9xdPNNuV+dnd16
	3Uh3kdwZEywN0XhH+7yzt+BUdQsCVbtF/knzcwx5FW3teLIhsuznI1/6w2VaditlnxM1UuOhjDRTO
	IkNBBDutsocDt2OKZckkvnw6cc4Ea8qvh1EtVHMDClWj/zOaLW3wV4abj0mTLrgFsgraBDbGSBKIN
	cY7mWHarVsLx7md2EFFzjh26yYmde7Ilu0b54BSJBBPMi9O1zvKYQ1XA0eXzYG69y7iX/IgJlD2Fk
	RZ1W6H+gUQpylyerRVVarvRR+P1kH16XI3ldEH91iXXQABPugBTCo47C+c8SdMUczxO96YV3l0y4M
	Dru9R1rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t17i0-0000000CXBb-2YyV;
	Wed, 16 Oct 2024 17:21:16 +0000
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t17hv-0000000CX9N-1z5w;
	Wed, 16 Oct 2024 17:21:13 +0000
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso1106961fa.0;
        Wed, 16 Oct 2024 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729099269; x=1729704069; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1GP0B75uZXvlMdPMs8sxWFWqOcAn6bbZYSntM7zvNeg=;
        b=kKmw2tLBbAbdatXGaV1NbhP8MKa7EW4NQavJSP8wMCKkXQRLFvwexSlH1mIs8Kisud
         paYzelHPZrJLSclyLCk9zebAkQdn1HEXTWvyLsDfqzkHprcRrWFrEpCy2XP98rU8PZz9
         Zo3WnZ+05PGUI0icG/Zc58/ompCnCVBEi9vmJMNfTpkmEfZYts0RYFN0ZHFtaOaQYPeH
         O7heiGbWz5nO+Zsj64brQfwnsmqdBaQCkC0Rxgpfc3+D6cmMRrBzhfhMuT5GkBE3/zbD
         E7nuoKnDqH6JEq97w3OhKFIqevRt1oGKSdMQEdraPrTNzXsOng7yH+hCpwy6u7bQpQHk
         kKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729099269; x=1729704069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GP0B75uZXvlMdPMs8sxWFWqOcAn6bbZYSntM7zvNeg=;
        b=ZV/IcU+DCPDLH8Bbpr8I6IHs1S1/csv3fefjTjguB5dIJ2vJ3J6RFnD64h7fN4h/46
         AvxfyJe4CObQ/uLLlSQAUlgL2ZU8I8jWPRCNNCmIF2tI6RxZRyycOuKFd4g0p0voWaLi
         nGcBM7CU5LhTH4G0I0FZhqOwTTM2N3Yzdw2btYKPv8BMCU3j0lXn1OBLOr1nVQONIj7e
         cIWIs8GhU0fQp7IAtPl7DiWYQurvgR5605zSSjuq5d2NIXNepAw5yjHTiWw1v5uNGptW
         M85sL6UnJCtaSr1ISZfVksQhP99R7SdUwS8i4KPuf1l/Blm/UwiGX4fAWMcHyEQE3hwA
         9cZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsElmbR9mBaT1n4SBYOW4QKfyHUjSw/CckFfj6GtUohmpioB/M63gZcHMdqo12VK94h7N0l9AxFyS7DAjIhsIT@lists.infradead.org, AJvYcCVxJitQxyGE1HNidjy5l57cMJvyd9sTb1UZifWJLPWMI2722s3GPUs6u34jEq+oQkwuOpIkaTT8p101Am8=@lists.infradead.org, AJvYcCWsxGFg2siio2znO8CA/rKkeEUOEWFADte7JzZawPt08zC8+8qFNFIW/HyMzfJRGi2sH/f9xOVOkkdbOCqDCuU=@lists.infradead.org, AJvYcCXIInIVNwgtDBE1/UqaCJ6OhGDvEC5qVhCEFUUzD4ql3maeG0eGbFOhLaeShMbJX2FqyosbiaffAZc=@lists.infradead.org
X-Gm-Message-State: AOJu0YwCNfa64i/moQatoBs9N7r5OftjL+8T7BqZxYeGNCS+Bmf1/wRC
	ucr2Q++hr7zwRJU0Xc1YDBn0DCk1t01QerXXGaj48AOEgWNdagKC
X-Google-Smtp-Source: AGHT+IE3BOIzolDg/ircoXlrXALD+U8X6mjirKNd/VoSdJ8ZQKv3Aj0k5T5yFcByNzOByKxATFiOdw==
X-Received: by 2002:a05:6512:402a:b0:539:f619:b458 with SMTP id 2adb3069b0e04-539f619b4cbmr6540423e87.22.1729099268652;
        Wed, 16 Oct 2024 10:21:08 -0700 (PDT)
Received: from pc636 (host-95-203-1-67.mobileonline.telia.com. [95.203.1.67])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffa8a5fsm512819e87.26.2024.10.16.10.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 10:21:08 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Oct 2024 19:21:02 +0200
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 2/8] mm: vmalloc: don't account for number of nodes
 for HUGE_VMAP allocations
Message-ID: <Zw_1_ln440eHTjGt@pc636>
References: <20241016122424.1655560-1-rppt@kernel.org>
 <20241016122424.1655560-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016122424.1655560-3-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_102111_539669_258243F7 
X-CRM114-Status: GOOD (  26.47  )
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

On Wed, Oct 16, 2024 at 03:24:18PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> vmalloc allocations with VM_ALLOW_HUGE_VMAP that do not explicitly
> specify node ID will use huge pages only if size_per_node is larger than
> a huge page.
> Still the actual allocated memory is not distributed between nodes and
> there is no advantage in such approach.
> On the contrary, BPF allocates SZ_2M * num_possible_nodes() for each
> new bpf_prog_pack, while it could do with a single huge page per pack.
> 
> Don't account for number of nodes for VM_ALLOW_HUGE_VMAP with
> NUMA_NO_NODE and use huge pages whenever the requested allocation size
> is larger than a huge page.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/vmalloc.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 634162271c00..86b2344d7461 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3763,8 +3763,6 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  	}
>  
>  	if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
> -		unsigned long size_per_node;
> -
>  		/*
>  		 * Try huge pages. Only try for PAGE_KERNEL allocations,
>  		 * others like modules don't yet expect huge pages in
> @@ -3772,13 +3770,10 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  		 * supporting them.
>  		 */
>  
> -		size_per_node = size;
> -		if (node == NUMA_NO_NODE)
> -			size_per_node /= num_online_nodes();
> -		if (arch_vmap_pmd_supported(prot) && size_per_node >= PMD_SIZE)
> +		if (arch_vmap_pmd_supported(prot) && size >= PMD_SIZE)
>  			shift = PMD_SHIFT;
>  		else
> -			shift = arch_vmap_pte_supported_shift(size_per_node);
> +			shift = arch_vmap_pte_supported_shift(size);
>  
>  		align = max(real_align, 1UL << shift);
>  		size = ALIGN(real_size, 1UL << shift);
>
Looking at this place, i see that an overwriting a "size" approach seems as
something that is a bit hard to follow. Below we have following code:

<snip>
...
again:
	area = __get_vm_area_node(real_size, align, shift, VM_ALLOC |
	  VM_UNINITIALIZED | vm_flags, start, end, node,
	  gfp_mask, caller);
...
<snip>

where we pass a "real_size", whereas there is only one place in the
__vmalloc_node_range_noprof() function where a "size" is used. It is
in the end of function:

<snip>
...
	size = PAGE_ALIGN(size);
	if (!(vm_flags & VM_DEFER_KMEMLEAK))
		kmemleak_vmalloc(area, size, gfp_mask);

	return area->addr;
<snip>

As fro this patch:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

