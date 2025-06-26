Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432F2C7EE32
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 12:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JNPRNVa0NXAIt/TPNv1Il9lD8lH58j3TXeT6bKfk/5M=; b=XEmZLk5Nt/7Ogt41YnjmGjH2mx
	vY3v5wto/CNPXWkykI882rEkLu0o7ByebGOFr07LWquY9HyLB+8g1h5OK43M11PmNj8vc02Hq0jI0
	buw2S4oLRbqPLSYlEQeaSRAc6r/TZ5RnmO8K/+wyMkTkywTNkiSDB3EQpQiJjuegfWpggztJpxuUV
	SiNNSPoIyoxD6T4rlBA1YKnV4TEBtIrwGnDNFEoRs9BDSRsTY6dp96nxJywva6NMORGYwHdoEsAzx
	O+yjsJ3hRib9aruU8CrS6NK7+ZP/KSyZFbv6plY/vwTvSixXarzR6+mX6aVxHqooa9v7Jr3XsYXtZ
	oSmn5ZYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUlTA-0000000BWAM-2VpV;
	Thu, 26 Jun 2025 12:12:44 +0000
Received: from pegase1.c-s.fr ([93.17.236.30])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUkel-0000000BNeJ-3R55;
	Thu, 26 Jun 2025 11:20:41 +0000
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bSbB02K49z9vGJ;
	Thu, 26 Jun 2025 12:52:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uDQegORpF3hS; Thu, 26 Jun 2025 12:52:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bSbB017ZFz9vGH;
	Thu, 26 Jun 2025 12:52:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B36F8B7B7;
	Thu, 26 Jun 2025 12:52:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 1FFBuvr_5nqx; Thu, 26 Jun 2025 12:52:39 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F3C38B7A7;
	Thu, 26 Jun 2025 12:52:37 +0200 (CEST)
Message-ID: <3b6ff3a9-6b88-4a28-a0fd-31f31ae3e84b@csgroup.eu>
Date: Thu, 26 Jun 2025 12:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] kasan/powerpc: call kasan_init_generic in kasan_init
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com,
 glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
 vincenzo.frascino@arm.com, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
 akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com, geert@linux-m68k.org, rppt@kernel.org,
 tiwei.btw@antgroup.com, richard.weiyang@gmail.com, benjamin.berg@intel.com,
 kevin.brodsky@arm.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250625095224.118679-1-snovitoll@gmail.com>
 <20250625095224.118679-10-snovitoll@gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250625095224.118679-10-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_042040_016211_E20C9CF3 
X-CRM114-Status: GOOD (  12.94  )
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



Le 25/06/2025 à 11:52, Sabyrzhan Tasbolatov a écrit :
> Call kasan_init_generic() which enables the static flag
> to mark generic KASAN initialized, otherwise it's an inline stub.
> Also prints the banner from the single place.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
> Fixes: 55d77bae7342 ("kasan: fix Oops due to missing calls to kasan_arch_is_ready()")
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>   arch/powerpc/include/asm/kasan.h       | 14 --------------
>   arch/powerpc/mm/kasan/init_book3s_64.c |  6 +-----
>   2 files changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> index b5bbb94c51f..23a06fbec72 100644
> --- a/arch/powerpc/include/asm/kasan.h
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -52,20 +52,6 @@
>   
>   #endif
>   
> -#ifdef CONFIG_KASAN

The above #ifdef must remain, at the moment I get:

   CC      arch/powerpc/kernel/asm-offsets.s
In file included from ./arch/powerpc/include/asm/nohash/32/pgtable.h:65,
                  from ./arch/powerpc/include/asm/nohash/pgtable.h:13,
                  from ./arch/powerpc/include/asm/pgtable.h:20,
                  from ./include/linux/pgtable.h:6,
                  from ./arch/powerpc/include/asm/kup.h:43,
                  from ./arch/powerpc/include/asm/uaccess.h:8,
                  from ./include/linux/uaccess.h:12,
                  from ./include/linux/sched/task.h:13,
                  from ./include/linux/sched/signal.h:9,
                  from ./include/linux/rcuwait.h:6,
                  from ./include/linux/percpu-rwsem.h:7,
                  from ./include/linux/fs.h:34,
                  from ./include/linux/compat.h:17,
                  from arch/powerpc/kernel/asm-offsets.c:12:
./arch/powerpc/include/asm/kasan.h:70:2: error: #endif without #if
  #endif
   ^~~~~
In file included from ./include/linux/kasan.h:21,
                  from ./include/linux/slab.h:260,
                  from ./include/linux/fs.h:46,
                  from ./include/linux/compat.h:17,
                  from arch/powerpc/kernel/asm-offsets.c:12:
./arch/powerpc/include/asm/kasan.h:70:2: error: #endif without #if
  #endif
   ^~~~~
make[2]: *** [scripts/Makefile.build:182: 
arch/powerpc/kernel/asm-offsets.s] Error 1


> -#ifdef CONFIG_PPC_BOOK3S_64
> -DECLARE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
> -
> -static __always_inline bool kasan_arch_is_ready(void)
> -{
> -	if (static_branch_likely(&powerpc_kasan_enabled_key))
> -		return true;
> -	return false;
> -}
> -
> -#define kasan_arch_is_ready kasan_arch_is_ready
> -#endif
> -
>   void kasan_early_init(void);
>   void kasan_mmu_init(void);
>   void kasan_init(void);
> diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
> index 7d959544c07..dcafa641804 100644
> --- a/arch/powerpc/mm/kasan/init_book3s_64.c
> +++ b/arch/powerpc/mm/kasan/init_book3s_64.c
> @@ -19,8 +19,6 @@
>   #include <linux/memblock.h>
>   #include <asm/pgalloc.h>
>   
> -DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
> -
>   static void __init kasan_init_phys_region(void *start, void *end)
>   {
>   	unsigned long k_start, k_end, k_cur;
> @@ -92,11 +90,9 @@ void __init kasan_init(void)
>   	 */
>   	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
>   
> -	static_branch_inc(&powerpc_kasan_enabled_key);
> -
>   	/* Enable error messages */
>   	init_task.kasan_depth = 0;
> -	pr_info("KASAN init done\n");
> +	kasan_init_generic();
>   }
>   
>   void __init kasan_early_init(void) { }


