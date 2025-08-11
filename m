Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E11C87FD2
	for <linux-um@archiver.kernel.org>; Mon, 11 Aug 2025 05:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1+62RvIlGZfmQnxVgcVSsABjdaj8FSJ42aUXvVPiGuY=; b=tvwF71qZ+BTvL6Sp+5nnWxv9VQ
	xkavMPXZdCKjAeLVD2hz6kDV4nDiBsT7tTNqiR2At5S3ed8+iiwXnV5I3bNO1A1iKXrJjTtYyfMj+
	m8x63qH1yKtbr2Z4p6KMFPRSHvrv47mnJJvTmjBu09tbEOSULBPsEzNJI+vMbVP1vi1g70jcFyakm
	SVqVrDJY29utkINIf+aXSNsnOdpfLfhpHRCQS0JX+GV0+BdLdaB8yRG4Cx1pUvnrk1v8eAo7pOKcN
	b+7kUzs8xMY/LWndzzI+eLbMhcxHMudT4HpR6LMa1UuCmxaZuHozL+fUO90i/KCnISvpJ2Q5BfyYo
	cWGouU+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulLTF-00000006XND-1VHm;
	Mon, 11 Aug 2025 05:53:21 +0000
Received: from pegase2.c-s.fr ([93.17.235.10])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulLQb-00000006X7t-0EYj;
	Mon, 11 Aug 2025 05:50:38 +0000
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c0k2w2kRcz9sSL;
	Mon, 11 Aug 2025 07:39:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Mxf0H61E1tl; Mon, 11 Aug 2025 07:39:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c0k2w1bMnz9sSK;
	Mon, 11 Aug 2025 07:39:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 199008B764;
	Mon, 11 Aug 2025 07:39:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id bIxmuQ19phXS; Mon, 11 Aug 2025 07:39:03 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BAC418B763;
	Mon, 11 Aug 2025 07:39:03 +0200 (CEST)
Message-ID: <b8345cfe-0bde-44cd-b9b7-9a946ff8fc36@csgroup.eu>
Date: Mon, 11 Aug 2025 07:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] kasan: call kasan_init_generic in kasan_init
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com,
 bhe@redhat.com, hca@linux.ibm.com, andreyknvl@gmail.com,
 akpm@linux-foundation.org, zhangqing@loongson.cn, chenhuacai@loongson.cn,
 davidgow@google.com, glider@google.com, dvyukov@google.com,
 alexghiti@rivosinc.com
Cc: alex@ghiti.fr, agordeev@linux.ibm.com, vincenzo.frascino@arm.com,
 elver@google.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250810125746.1105476-1-snovitoll@gmail.com>
 <20250810125746.1105476-3-snovitoll@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250810125746.1105476-3-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_225037_263387_25EDC1F1 
X-CRM114-Status: GOOD (  15.18  )
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



Le 10/08/2025 à 14:57, Sabyrzhan Tasbolatov a écrit :
> Call kasan_init_generic() which handles Generic KASAN initialization.
> For architectures that do not select ARCH_DEFER_KASAN,
> this will be a no-op for the runtime flag but will
> print the initialization banner.
> 
> For SW_TAGS and HW_TAGS modes, their respective init functions will
> handle the flag enabling, if they are enabled/implemented.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv
> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
> Changes in v6:
> - Call kasan_init_generic() in arch/riscv _after_ local_flush_tlb_all()
> ---
>   arch/arm/mm/kasan_init.c    | 2 +-
>   arch/arm64/mm/kasan_init.c  | 4 +---
>   arch/riscv/mm/kasan_init.c  | 1 +
>   arch/s390/kernel/early.c    | 3 ++-
>   arch/x86/mm/kasan_init_64.c | 2 +-
>   arch/xtensa/mm/kasan_init.c | 2 +-
>   6 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
> index 111d4f703136..c6625e808bf8 100644
> --- a/arch/arm/mm/kasan_init.c
> +++ b/arch/arm/mm/kasan_init.c
> @@ -300,6 +300,6 @@ void __init kasan_init(void)
>   	local_flush_tlb_all();
>   
>   	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
> -	pr_info("Kernel address sanitizer initialized\n");
>   	init_task.kasan_depth = 0;
> +	kasan_init_generic();
>   }
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index d541ce45daeb..abeb81bf6ebd 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -399,14 +399,12 @@ void __init kasan_init(void)
>   {
>   	kasan_init_shadow();
>   	kasan_init_depth();
> -#if defined(CONFIG_KASAN_GENERIC)
> +	kasan_init_generic();
>   	/*
>   	 * Generic KASAN is now fully initialized.
>   	 * Software and Hardware Tag-Based modes still require
>   	 * kasan_init_sw_tags() and kasan_init_hw_tags() correspondingly.
>   	 */
> -	pr_info("KernelAddressSanitizer initialized (generic)\n");
> -#endif
>   }
>   
>   #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index 41c635d6aca4..c4a2a9e5586e 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -533,4 +533,5 @@ void __init kasan_init(void)
>   
>   	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
>   	local_flush_tlb_all();
> +	kasan_init_generic();
>   }
> diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
> index 9adfbdd377dc..544e5403dd91 100644
> --- a/arch/s390/kernel/early.c
> +++ b/arch/s390/kernel/early.c
> @@ -21,6 +21,7 @@
>   #include <linux/kernel.h>
>   #include <asm/asm-extable.h>
>   #include <linux/memblock.h>
> +#include <linux/kasan.h>
>   #include <asm/access-regs.h>
>   #include <asm/asm-offsets.h>
>   #include <asm/machine.h>
> @@ -65,7 +66,7 @@ static void __init kasan_early_init(void)
>   {
>   #ifdef CONFIG_KASAN
>   	init_task.kasan_depth = 0;
> -	pr_info("KernelAddressSanitizer initialized\n");
> +	kasan_init_generic();
>   #endif
>   }
>   
> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> index 0539efd0d216..998b6010d6d3 100644
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -451,5 +451,5 @@ void __init kasan_init(void)
>   	__flush_tlb_all();
>   
>   	init_task.kasan_depth = 0;
> -	pr_info("KernelAddressSanitizer initialized\n");
> +	kasan_init_generic();
>   }
> diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
> index f39c4d83173a..0524b9ed5e63 100644
> --- a/arch/xtensa/mm/kasan_init.c
> +++ b/arch/xtensa/mm/kasan_init.c
> @@ -94,5 +94,5 @@ void __init kasan_init(void)
>   
>   	/* At this point kasan is fully initialized. Enable error messages. */
>   	current->kasan_depth = 0;
> -	pr_info("KernelAddressSanitizer initialized\n");
> +	kasan_init_generic();
>   }


