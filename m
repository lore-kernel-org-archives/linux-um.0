Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14425C87FD3
	for <linux-um@archiver.kernel.org>; Fri,  8 Aug 2025 07:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4/QklETFhE/HaMV63Zcte41AoyA4FbhUpoG+hqiHyGs=; b=hQZGvcnDptRBddO4GoDPLoTBCX
	lRWHO1Llx2QGjmrbkfRtillPyNG/LMgPZPx+EU4IakanmlwCb+pyeussmi1kiewNYWcMzci4R5nQY
	QEMpsIcrZMeRDiYkNgRAXXietp7iAbVdp1vtBuhqJq6IpfxnU+ttnEDQnWJBdjbCKDAHlCe0qr2cI
	+Zp0BwU6HmFa7BDWyNUxO/AtYNSyFyjDlQEx+QHRwKDpmBPvj6v+FpSQFRm/TXGaUTVMF1Q5jwZGa
	fMdXYiLBkvUtjo2MxPfjpTsOZNxvjiPAzgmfvBoTSfCVENwCa4kwqbSpvaJ5b9q/RyjRZVAOcieEu
	KIABQnaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukHjs-00000002EWk-2p6k;
	Fri, 08 Aug 2025 07:42:08 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukHQ6-00000002BHu-1Qwj;
	Fri, 08 Aug 2025 07:21:44 +0000
Received: by mail.gandi.net (Postfix) with ESMTPSA id 37190443D6;
	Fri,  8 Aug 2025 07:21:33 +0000 (UTC)
Message-ID: <7487516c-3eb1-46fa-aed5-6dc72600c952@ghiti.fr>
Date: Fri, 8 Aug 2025 09:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] kasan: call kasan_init_generic in kasan_init
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: ryabinin.a.a@gmail.com, bhe@redhat.com, hca@linux.ibm.com,
 andreyknvl@gmail.com, akpm@linux-foundation.org, zhangqing@loongson.cn,
 chenhuacai@loongson.cn, davidgow@google.co, glider@google.com,
 dvyukov@google.com, agordeev@linux.ibm.com, vincenzo.frascino@arm.com,
 elver@google.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20250807194012.631367-1-snovitoll@gmail.com>
 <20250807194012.631367-3-snovitoll@gmail.com>
 <07ffb27c-3416-43c9-a50a-164a76e5ab60@csgroup.eu>
 <CACzwLxhahYWfRc5xKshayniV6SuFFnMT0NfHttippcASzZgtRw@mail.gmail.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CACzwLxhahYWfRc5xKshayniV6SuFFnMT0NfHttippcASzZgtRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdefudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeduffeugedvtdegleeuhfeuteetueegfeefkefhheffvdduhfegvdehuddukeffgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhhfrhgruggvrggurdhorhhgnecukfhppeduleefrdeffedrheejrdduleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelfedrfeefrdehjedrudelledphhgvlhhopegludelvddrudeikedrvddvrddutddungdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehsnhhovhhithholhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdprhgtphhtthhopehrhigrsghinhhinhdrrgdrrgesghhmrghilhdrtghomhdprhgtphhtthhopegshhgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehhtggrsehlihhnuhigr
 dhisghmrdgtohhmpdhrtghpthhtoheprghnughrvgihkhhnvhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopeiihhgrnhhgqhhinhhgsehlohhonhhgshhonhdrtghn
X-GND-Sasl: alex@ghiti.fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_002142_510072_265527D6 
X-CRM114-Status: GOOD (  17.73  )
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


On 8/8/25 08:44, Sabyrzhan Tasbolatov wrote:
> On Fri, Aug 8, 2025 at 10:07 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>>
>> Le 07/08/2025 à 21:40, Sabyrzhan Tasbolatov a écrit :
>>> Call kasan_init_generic() which handles Generic KASAN initialization.
>>> For architectures that do not select ARCH_DEFER_KASAN,
>>> this will be a no-op for the runtime flag but will
>>> print the initialization banner.
>>>
>>> For SW_TAGS and HW_TAGS modes, their respective init functions will
>>> handle the flag enabling, if they are enabled/implemented.
>>>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
>>> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
>>> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv
>>> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
>>> ---
>>> Changes in v5:
>>> - Unified arch patches into a single one, where we just call
>>>        kasan_init_generic()
>>> - Added Tested-by tag for riscv (tested the same change in v4)
>>> - Added Acked-by tag for s390 (tested the same change in v4)
>>> ---
>>>    arch/arm/mm/kasan_init.c    | 2 +-
>>>    arch/arm64/mm/kasan_init.c  | 4 +---
>>>    arch/riscv/mm/kasan_init.c  | 1 +
>>>    arch/s390/kernel/early.c    | 3 ++-
>>>    arch/x86/mm/kasan_init_64.c | 2 +-
>>>    arch/xtensa/mm/kasan_init.c | 2 +-
>>>    6 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
>>> index 111d4f70313..c6625e808bf 100644
>>> --- a/arch/arm/mm/kasan_init.c
>>> +++ b/arch/arm/mm/kasan_init.c
>>> @@ -300,6 +300,6 @@ void __init kasan_init(void)
>>>        local_flush_tlb_all();
>>>
>>>        memset(kasan_early_shadow_page, 0, PAGE_SIZE);
>>> -     pr_info("Kernel address sanitizer initialized\n");
>>>        init_task.kasan_depth = 0;
>>> +     kasan_init_generic();
>>>    }
>>> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
>>> index d541ce45dae..abeb81bf6eb 100644
>>> --- a/arch/arm64/mm/kasan_init.c
>>> +++ b/arch/arm64/mm/kasan_init.c
>>> @@ -399,14 +399,12 @@ void __init kasan_init(void)
>>>    {
>>>        kasan_init_shadow();
>>>        kasan_init_depth();
>>> -#if defined(CONFIG_KASAN_GENERIC)
>>> +     kasan_init_generic();
>>>        /*
>>>         * Generic KASAN is now fully initialized.
>>>         * Software and Hardware Tag-Based modes still require
>>>         * kasan_init_sw_tags() and kasan_init_hw_tags() correspondingly.
>>>         */
>>> -     pr_info("KernelAddressSanitizer initialized (generic)\n");
>>> -#endif
>>>    }
>>>
>>>    #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>>> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
>>> index 41c635d6aca..ba2709b1eec 100644
>>> --- a/arch/riscv/mm/kasan_init.c
>>> +++ b/arch/riscv/mm/kasan_init.c
>>> @@ -530,6 +530,7 @@ void __init kasan_init(void)
>>>
>>>        memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
>>>        init_task.kasan_depth = 0;
>>> +     kasan_init_generic();
>> I understood KASAN is really ready to function only once the csr_write()
>> and local_flush_tlb_all() below are done. Shouldn't kasan_init_generic()
>> be called after it ?
> I will try to test this in v6:
>
>          csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
>          local_flush_tlb_all();
>          kasan_init_generic();


Before setting the final kasan mapping, we still have the early one so 
we won't trap or anything on some kasan accesses. But if there is a v6, 
I agree it will be cleaner to do it this ^ way.

Thanks,

Alex


>
> Alexandre Ghiti said [1] it was not a problem, but I will check.
>
> [1] https://lore.kernel.org/all/20c1e656-512e-4424-9d4e-176af18bb7d6@ghiti.fr/
>
>>>        csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
>>>        local_flush_tlb_all();
>>> diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
>>> index 9adfbdd377d..544e5403dd9 100644
>>> --- a/arch/s390/kernel/early.c
>>> +++ b/arch/s390/kernel/early.c
>>> @@ -21,6 +21,7 @@
>>>    #include <linux/kernel.h>
>>>    #include <asm/asm-extable.h>
>>>    #include <linux/memblock.h>
>>> +#include <linux/kasan.h>
>>>    #include <asm/access-regs.h>
>>>    #include <asm/asm-offsets.h>
>>>    #include <asm/machine.h>
>>> @@ -65,7 +66,7 @@ static void __init kasan_early_init(void)
>>>    {
>>>    #ifdef CONFIG_KASAN
>>>        init_task.kasan_depth = 0;
>>> -     pr_info("KernelAddressSanitizer initialized\n");
>>> +     kasan_init_generic();
>>>    #endif
>>>    }
>>>
>>> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
>>> index 0539efd0d21..998b6010d6d 100644
>>> --- a/arch/x86/mm/kasan_init_64.c
>>> +++ b/arch/x86/mm/kasan_init_64.c
>>> @@ -451,5 +451,5 @@ void __init kasan_init(void)
>>>        __flush_tlb_all();
>>>
>>>        init_task.kasan_depth = 0;
>>> -     pr_info("KernelAddressSanitizer initialized\n");
>>> +     kasan_init_generic();
>>>    }
>>> diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
>>> index f39c4d83173..0524b9ed5e6 100644
>>> --- a/arch/xtensa/mm/kasan_init.c
>>> +++ b/arch/xtensa/mm/kasan_init.c
>>> @@ -94,5 +94,5 @@ void __init kasan_init(void)
>>>
>>>        /* At this point kasan is fully initialized. Enable error messages. */
>>>        current->kasan_depth = 0;
>>> -     pr_info("KernelAddressSanitizer initialized\n");
>>> +     kasan_init_generic();
>>>    }
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

