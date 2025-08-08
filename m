Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF50C87FCB
	for <linux-um@archiver.kernel.org>; Fri,  8 Aug 2025 17:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bro5Z1PL2eLig5Q2ncFtimJM/b9sdMd4TeRUxnnShL0=; b=ShJIjJdpKPBNWmg2YiKQ1kMfN8
	ur02s7yUvDiyIwAuOOs81BcbVZPUOhploo8Jxq24I+xKjhVB+NQ3hBfKFWFe03DwarpR8veFRNgbv
	IhIqTCXiCUnpL0URmxjs4fuZNHVXtLTCUYBkRdiicgf1YvkF5n49dkHNjr2swpoEZq5Qq8gBjr3nz
	9kJEnB/eK+5i9gNCp6IMzVupNK/YtBeIbr0b0Oys4jEn2sKZx5bK5aUuURbpSATqIbv8WRpb54JD7
	BR8UQYOSq9Pd1cnGhdHVIlSF0hldBwZnDrZOg8YTP2YNtWqcHMA944Vp9GURfgW+/a5aSKpjqhpP1
	x0pkvcQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukQoG-00000003Olm-3pBP;
	Fri, 08 Aug 2025 17:23:16 +0000
Received: from pegase2.c-s.fr ([93.17.235.10])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukQlf-00000003OL7-1l8d;
	Fri, 08 Aug 2025 17:20:37 +0000
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4bz9NX4Hmyz9sSb;
	Fri,  8 Aug 2025 19:03:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4LtEzBBocysS; Fri,  8 Aug 2025 19:03:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4bz9NX36z3z9sSZ;
	Fri,  8 Aug 2025 19:03:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 55AF68B770;
	Fri,  8 Aug 2025 19:03:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Z2c0fwWGRIPg; Fri,  8 Aug 2025 19:03:56 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 20F878B763;
	Fri,  8 Aug 2025 19:03:55 +0200 (CEST)
Message-ID: <af677847-e625-43d7-8750-b2ce4ba9626c@csgroup.eu>
Date: Fri, 8 Aug 2025 19:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: ryabinin.a.a@gmail.com, bhe@redhat.com, hca@linux.ibm.com,
 andreyknvl@gmail.com, akpm@linux-foundation.org, zhangqing@loongson.cn,
 chenhuacai@loongson.cn, davidgow@google.co, glider@google.com,
 dvyukov@google.com, alex@ghiti.fr, agordeev@linux.ibm.com,
 vincenzo.frascino@arm.com, elver@google.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250807194012.631367-1-snovitoll@gmail.com>
 <20250807194012.631367-2-snovitoll@gmail.com>
 <22872a3f-85dc-4740-b605-ba80b5a3b1bc@csgroup.eu>
 <CACzwLxjnofD0EsxrtgbG3svXHL+TpYcio4B67SCY9Mi3C-jdsQ@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <CACzwLxjnofD0EsxrtgbG3svXHL+TpYcio4B67SCY9Mi3C-jdsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_102035_710783_E458557A 
X-CRM114-Status: GOOD (  17.40  )
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



Le 08/08/2025 à 17:33, Sabyrzhan Tasbolatov a écrit :
> On Fri, Aug 8, 2025 at 10:03 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>>
>>
>> Le 07/08/2025 à 21:40, Sabyrzhan Tasbolatov a écrit :
>>> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures [1] that need
>>> to defer KASAN initialization until shadow memory is properly set up,
>>> and unify the static key infrastructure across all KASAN modes.
>>
>> That probably desserves more details, maybe copy in informations from
>> the top of cover letter.
>>
>> I think there should also be some exeplanations about
>> kasan_arch_is_ready() becoming kasan_enabled(), and also why
>> kasan_arch_is_ready() completely disappear from mm/kasan/common.c
>> without being replaced by kasan_enabled().
>>
>>>
>>> [1] PowerPC, UML, LoongArch selects ARCH_DEFER_KASAN.
>>>
>>> Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D217049&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cfe4f5a759ad6452b047408ddd691024a%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638902640503259176%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=UM4uvQihJdeWwcC6DIiJXbn4wGsrijjRcHc55uCMErI%3D&reserved=0
>>> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
>>> ---
>>> Changes in v5:
>>> - Unified patches where arch (powerpc, UML, loongarch) selects
>>>     ARCH_DEFER_KASAN in the first patch not to break
>>>     bisectability
>>> - Removed kasan_arch_is_ready completely as there is no user
>>> - Removed __wrappers in v4, left only those where it's necessary
>>>     due to different implementations
>>>
>>> Changes in v4:
>>> - Fixed HW_TAGS static key functionality (was broken in v3)
>>> - Merged configuration and implementation for atomicity
>>> ---
>>>    arch/loongarch/Kconfig                 |  1 +
>>>    arch/loongarch/include/asm/kasan.h     |  7 ------
>>>    arch/loongarch/mm/kasan_init.c         |  8 +++----
>>>    arch/powerpc/Kconfig                   |  1 +
>>>    arch/powerpc/include/asm/kasan.h       | 12 ----------
>>>    arch/powerpc/mm/kasan/init_32.c        |  2 +-
>>>    arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
>>>    arch/powerpc/mm/kasan/init_book3s_64.c |  6 +----
>>>    arch/um/Kconfig                        |  1 +
>>>    arch/um/include/asm/kasan.h            |  5 ++--
>>>    arch/um/kernel/mem.c                   | 10 ++++++--
>>>    include/linux/kasan-enabled.h          | 32 ++++++++++++++++++--------
>>>    include/linux/kasan.h                  |  6 +++++
>>>    lib/Kconfig.kasan                      |  8 +++++++
>>>    mm/kasan/common.c                      | 17 ++++++++++----
>>>    mm/kasan/generic.c                     | 19 +++++++++++----
>>>    mm/kasan/hw_tags.c                     |  9 +-------
>>>    mm/kasan/kasan.h                       |  8 ++++++-
>>>    mm/kasan/shadow.c                      | 12 +++++-----
>>>    mm/kasan/sw_tags.c                     |  1 +
>>>    mm/kasan/tags.c                        |  2 +-
>>>    21 files changed, 100 insertions(+), 69 deletions(-)
>>>
>>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>>> index f0abc38c40a..cd64b2bc12d 100644
>>> --- a/arch/loongarch/Kconfig
>>> +++ b/arch/loongarch/Kconfig
>>> @@ -9,6 +9,7 @@ config LOONGARCH
>>>        select ACPI_PPTT if ACPI
>>>        select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
>>>        select ARCH_BINFMT_ELF_STATE
>>> +     select ARCH_DEFER_KASAN if KASAN
>>
>> Instead of adding 'if KASAN' in all users, you could do in two steps:
>>
>> Add a symbol ARCH_NEEDS_DEFER_KASAN.
>>
>> +config ARCH_NEEDS_DEFER_KASAN
>> +       bool
>>
>> And then:
>>
>> +config ARCH_DEFER_KASAN
>> +       def_bool
>> +       depends on KASAN
>> +       depends on ARCH_DEFER_KASAN
>> +       help
>> +         Architectures should select this if they need to defer KASAN
>> +         initialization until shadow memory is properly set up. This
>> +         enables runtime control via static keys. Otherwise, KASAN uses
>> +         compile-time constants for better performance.
>>
> 
> Actually, I don't see the benefits from this option. Sorry, have just
> revisited this again.
> With the new symbol, arch (PowerPC, UML, LoongArch) still needs select
> 2 options:
> 
> select ARCH_NEEDS_DEFER_KASAN
> select ARCH_DEFER_KASAN

Sorry, my mistake, ARCH_DEFER_KASAN has to be 'def_bool y'. Missing the 
'y'. That way it is automatically set to 'y' as long as KASAN and 
ARCH_NEEDS_DEFER_KASAN are selected. Should be:

config ARCH_DEFER_KASAN
	def_bool y
	depends on KASAN
	depends on ARCH_NEEDS_DEFER_KASAN


> 
> and the oneline with `if` condition is cleaner.
> select ARCH_DEFER_KASAN if KASAN
> 

I don't think so because it requires all architectures to add 'if KASAN' 
which is not convenient.

Christophe

