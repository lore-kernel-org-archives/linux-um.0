Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E97C83F17
	for <linux-um@archiver.kernel.org>; Wed, 23 Jul 2025 17:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h0LUnIOIz73OOlhKmDgw5NN8XNp7rSGUS+XkRlIQ8F4=; b=zKwCVQg7mVfzKTcOtsWfEKnCy4
	JFrliI3OndzljL13wJ4Yy9I/NrlBlEAnhZxVGkVr6JUqi74SOy7NFvboVkGLkElNsnLzjqQrMNc/Y
	eNxnzV87NEcOes34NkHoB0GSZtt6Md6rT1g5E9E2ohI36+AMYMjR1K5qrW/nnOzlHEPMHnEBcZubV
	/vmCF3NW36PO5lvJvwPxL3A0RzbsT/owkYSsJRkzNJGvy1iNCxIBrxnpjvRmR8zcipxRXLrpwvX7A
	7nFFfiG0/3VNvWDgAvK1aPe5QSgN3/zCm4mX3la7Yc/B14FXWQly+IwfugopGgmOr1ESAk067FA02
	LTw5y/rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ued06-00000005Z6N-2Xa2;
	Wed, 23 Jul 2025 17:11:30 +0000
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ued03-00000005Z4M-176S;
	Wed, 23 Jul 2025 17:11:28 +0000
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-33095f59c43so24831fa.2;
        Wed, 23 Jul 2025 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753290685; x=1753895485; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0LUnIOIz73OOlhKmDgw5NN8XNp7rSGUS+XkRlIQ8F4=;
        b=Y0SObY0U9htZdVeTuT5uBbrZmTompZWkWiYU0dwjsqtBNon3wJTaFslnSq+9Xd3rYV
         uNMgkU23raZ09SUtK+U1N3Dxw/jrlX+WjhGUwgL9ifXRTE2DVXX/8822vU70tXX2822v
         nlWpyzPAzvTmLCBx3xvyw2vDDdYvUxYX1nG5k5yn4gvdFogTI0GEpHRKeYRMJqP/6kwp
         BqKxXbhQYH9SnBG76fc11P/4zgi4OcGMFmRi1hO2X0vvrhNdA7RPWeKWHEZccK+OyYuI
         Dj98vMJQ36z5czs3bU91udmzsOOkvv+Ih3OjKZwryrZNmEv7JCnkt9rNazyTJhdSRYUz
         hizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753290685; x=1753895485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0LUnIOIz73OOlhKmDgw5NN8XNp7rSGUS+XkRlIQ8F4=;
        b=qyMQ4gz9rejI9ujCmDc2S06xgSvk88QRPbBnij0ECWxTUVw3miT3rrlNJB9Sf5bTsa
         OADZ8my3PUr01qECmAonmzeSOrVRjLV9ezhLKNMVbZY3S5B4xuXmYeAH8AH3kU2fmsfm
         aktRhSmceqKLBbDVFn1PuRDu0uX5dv1BYe+ic7UAoZYWVUL/uvTlDKxWFs7RxTuvH1Ym
         I7t1KIBdFEVHkxAUpSzrojrwaNOKK87zc+YeTqB6sUkgEZSdTP/mdGJWDZjQ0YLbv+A5
         PM2PvpC9pKWhdJVJMo/vJWZE5wDLziJQfJ7g7v8b88d5xyH8YueyzJu1s3LCxto2M78J
         gDRA==
X-Forwarded-Encrypted: i=1; AJvYcCWLFI+WseCyxOIpWC/Nm843PpMSbGZDrTNMzwHnYMb0Mxp8En0Jymlms6OhYTCq2Qh8upS/P7v96sR7vQ==@lists.infradead.org, AJvYcCXqsFxnzYWNBmkS0KYkxnO0E0zggdFhcNHQiLes615Lb05QbkFjwXbEksVJWd2ZOQZAnQ+0e6UHIFw=@lists.infradead.org
X-Gm-Message-State: AOJu0YyQBMiW9bjiL6XpcwKr5tQQcmSZLXP3ifmBleJ03M19yVrA7Gf2
	0xu3EBrIytcznE5zQZxGh7+/LujrjAdNktSpB4JoXj4mSwLuQfntG7sx
X-Gm-Gg: ASbGnctLSnnZH9zs7mH/KS1HY/SfytrHak5yuAtExjDqz2NPQ7/FtlYFUfRGwOu0h0W
	wZ8C+S6OK8uCz2aND/zKTKmpYbeg/1uLXsY4ubzbXRMuJ1pz1qtnhuSi1EorX8awqL2IS94b/wT
	0cxLYyaw9j2NRg7wdCNVZKHbR1sd/wA2S7llAQp39Jtu1Gjpw6aGgmbKy+m08huOnJ6Y3HpnXyc
	b/o3BnuOGMdWI0HQ6xSWA4ICnRHAxC2Zo4wodewZapqDvrGAgjLyBNvhV2GHEWoWAjll/arhsb6
	fPcAIfHb6L0G0j62u1SUQMCniwO7WN5YdPfRE4Ej4OgLWSfq8gBP2bGKx19hCI9BUH8F4z/v95J
	Y6K97K+KVd7KpzUIauiCh19ws/FQ1
X-Google-Smtp-Source: AGHT+IH2g67FKl5Ss4FX0QBC4tL2LXDPhFaEQPcQJWbHc0FwMHy9whqZBWSEtQi4JTvV5r53QIeSPA==
X-Received: by 2002:a05:651c:f19:b0:32d:fd8c:7e76 with SMTP id 38308e7fff4ca-330dfd2d969mr3521411fa.7.1753290684563;
        Wed, 23 Jul 2025 10:11:24 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91d9eaasm19869811fa.85.2025.07.23.10.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 10:11:23 -0700 (PDT)
Message-ID: <4dd38293-4307-474f-8eb7-0e83f5d3b996@gmail.com>
Date: Wed, 23 Jul 2025 19:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] kasan/um: select ARCH_DEFER_KASAN and call
 kasan_init_generic
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com,
 agordeev@linux.ibm.com, akpm@linux-foundation.org, glider@google.com,
 dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <20250717142732.292822-9-snovitoll@gmail.com>
 <85de2e1f-a787-4862-87e4-2681e749cef0@gmail.com>
 <CACzwLxiD98BLmEmPhkJQgv297bP_7qw+Vm_icFhTiDYN7WvLjw@mail.gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <CACzwLxiD98BLmEmPhkJQgv297bP_7qw+Vm_icFhTiDYN7WvLjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250723_101127_302512_2002D5E4 
X-CRM114-Status: GOOD (  17.46  )
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



On 7/22/25 4:17 PM, Sabyrzhan Tasbolatov wrote:
> On Tue, Jul 22, 2025 at 4:00 AM Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>>
>>
>>
>> On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:
>>> UserMode Linux needs deferred KASAN initialization as it has a custom
>>> kasan_arch_is_ready() implementation that tracks shadow memory readiness
>>> via the kasan_um_is_ready flag.
>>>
>>> Select ARCH_DEFER_KASAN to enable the unified static key mechanism
>>> for runtime KASAN control. Call kasan_init_generic() which handles
>>> Generic KASAN initialization and enables the static key.
>>>
>>> Delete the key kasan_um_is_ready in favor of the unified kasan_enabled()
>>> interface.
>>>
>>> Note that kasan_init_generic has __init macro, which is called by
>>> kasan_init() which is not marked with __init in arch/um code.
>>>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
>>> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
>>> ---
>>> Changes in v3:
>>> - Added CONFIG_ARCH_DEFER_KASAN selection for proper runtime control
>>> ---
>>>  arch/um/Kconfig             | 1 +
>>>  arch/um/include/asm/kasan.h | 5 -----
>>>  arch/um/kernel/mem.c        | 4 ++--
>>>  3 files changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
>>> index f08e8a7fac9..fd6d78bba52 100644
>>> --- a/arch/um/Kconfig
>>> +++ b/arch/um/Kconfig
>>> @@ -8,6 +8,7 @@ config UML
>>>       select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>>>       select ARCH_HAS_CPU_FINALIZE_INIT
>>>       select ARCH_HAS_FORTIFY_SOURCE
>>> +     select ARCH_DEFER_KASAN
>>>       select ARCH_HAS_GCOV_PROFILE_ALL
>>>       select ARCH_HAS_KCOV
>>>       select ARCH_HAS_STRNCPY_FROM_USER
>>> diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
>>> index f97bb1f7b85..81bcdc0f962 100644
>>> --- a/arch/um/include/asm/kasan.h
>>> +++ b/arch/um/include/asm/kasan.h
>>> @@ -24,11 +24,6 @@
>>>
>>>  #ifdef CONFIG_KASAN
>>>  void kasan_init(void);
>>> -extern int kasan_um_is_ready;
>>> -
>>> -#ifdef CONFIG_STATIC_LINK
>>> -#define kasan_arch_is_ready() (kasan_um_is_ready)
>>> -#endif
>>>  #else
>>>  static inline void kasan_init(void) { }
>>>  #endif /* CONFIG_KASAN */
>>> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
>>> index 76bec7de81b..058cb70e330 100644
>>> --- a/arch/um/kernel/mem.c
>>> +++ b/arch/um/kernel/mem.c
>>> @@ -21,9 +21,9 @@
>>>  #include <os.h>
>>>  #include <um_malloc.h>
>>>  #include <linux/sched/task.h>
>>> +#include <linux/kasan.h>
>>>
>>>  #ifdef CONFIG_KASAN
>>> -int kasan_um_is_ready;
>>>  void kasan_init(void)
>>>  {
>>>       /*
>>> @@ -32,7 +32,7 @@ void kasan_init(void)
>>>        */
>>>       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
>>>       init_task.kasan_depth = 0;
>>> -     kasan_um_is_ready = true;
>>> +     kasan_init_generic();
>>
>> I think this runs before jump_label_init(), and static keys shouldn't be switched before that.>  }
> 
> I got the warning in my local compilation and from kernel CI [1].
> 
> arch/um places kasan_init() in own `.kasan_init` section, while
> kasan_init_generic() is called from __init.

No, kasan_init() is in text section as the warning says. It's kasan_init_ptr in .kasan_init.
Adding __init to kasan_init() should fix the warning.


> Could you suggest a way how I can verify the functions call order?
> 

By code inspection? or run uder gdb.

kasan_init() is initialization routine called before main().
jump_label_init() called from start_kernel()<-start_kernel_proc()<-... main()

> I need to familiarize myself with how to run arch/um locally 

It's as simple as:
ARCH=um  make 
./linux rootfstype=hostfs ro init=/bin/bash


