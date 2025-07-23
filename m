Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B239C83F1A
	for <linux-um@archiver.kernel.org>; Wed, 23 Jul 2025 17:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KBM3XOa1GXkPG7AU5j/kIOwYcdf4HqHkAm2pQZ3zu3U=; b=YJhOdDUeF5dtiaTCxMzBlXAS4q
	Rpo21cbMqppc9nh6dZa939Cov/FQr8Z1WUM41X5fb9dMfqTcepJN5MZZ0T9WAWjhAI4uKdSEBj3Zg
	kZ0UNIx0hjxC5O9F5c2wB/s2qPj22lFEQKprWenKihAmXAKVUQBfXF0nbT+YV8MI5/j3KyKqSM2t6
	EwxC/JvLX1/tuhm+K8+HtZY/8jVuU8No0f3jckT4hzW5NN8hiLLPvqdcX2Xc87Jve/QbWiOciOLuf
	F8ES5YJo3rox22JRLyZta9YUbCbC78opu769CH6pDEkIrE1lLN7hQKhUXVrMQWO2olcyEIZqpgK7j
	/qDu+VUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uedUE-00000005dwJ-47iI;
	Wed, 23 Jul 2025 17:42:38 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uedLD-00000005c2g-25tF;
	Wed, 23 Jul 2025 17:33:20 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-558fd84da64so4744e87.2;
        Wed, 23 Jul 2025 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753291998; x=1753896798; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBM3XOa1GXkPG7AU5j/kIOwYcdf4HqHkAm2pQZ3zu3U=;
        b=aeQZH6QYHNKGDaYCTef1n6YVbYU7wt2DgR1BIarAzoa0axuvbRE9VCpKr35CUUyda0
         +xnKktmW/bwr35mU+0pT9SwQMywlNOMwWgzY57Al7eeyxt1WGOs5njYhBGH9+EIJyzy6
         fNXC5A1Vg1JVDcNW6CMmygoCYHeQmaVVk2Z06O61yw9WAG7TzzZS2pof6PBA7XJY2n+N
         yI+MCgr1P4o1BFLNTbeiIzoXEpLAv2CBOwAbUf8bkdCHUGFiBtNfjJmorVvmPsUKboLf
         E+5101rUSGQXCMPvrOW6PL0CPDD0rVXm/y4zJ2DrxqbMMlAVo1PPLY/cL1eevl4iVII5
         LIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753291998; x=1753896798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBM3XOa1GXkPG7AU5j/kIOwYcdf4HqHkAm2pQZ3zu3U=;
        b=h8ujWDyC1ewwbTLBSidDPJzL232J2Q1CqYvCXkxsttYBk5JU34B1G7oz4QIWECQVTE
         oTdvK6rzgHS1yr+nUHATPqDtNI6HmlI+G4Dbp4rZLBT3l99RzjXm8t0B/9sjnqSce9nc
         2dd6KqzeNmF6ppFfU9T1dGgT4/TyXVOcRfPzDzvmbVIKbqTTYbtU/6Fr/zWfSUsQxE5z
         GxNlV5Rme8hxzwWuGly7HgdJmtAR3rftnIt6RM0DlqGxo8sxoGeLGiS0/BvzxocbLnG9
         HxK5LA0vjbewMEloL/sbwTCXwCIuiEfHU3zCSk5ZHo4R+kQ3v+TB/NpfsrH369bTFszB
         dLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZPJ+N8f+s9QCD/eEArQZfxDgNmyevx+MmIKfZ+Y8vdyHREKAILDC/ksL4Nk8HlLUoUzjfNqg+864Lw==@lists.infradead.org, AJvYcCWH8BGTTE0f49lV3Uw7kUSVuOjH5RYD2lBtJZfAxH5i089AfzY/XWWcK3YZLYgdm0kditbs3ZCIHkM=@lists.infradead.org
X-Gm-Message-State: AOJu0YxyqGhkIgy4Odpr49Y2nhTxdo2b3XxD6d5s7FaIrREvgrzWOkIn
	avZZIDHtS6arjh3eigg7hBhgfkYuDkK3hHA5KQ/1cxq+yLAWAtdfrHIh
X-Gm-Gg: ASbGncvBYQlS7A2Cj3QPia0mOcKccbDIk6x6OqFMHgEHzm8anCEfYW5diNmo8V3/QXQ
	h5cq89QukHv5rT1z3tJ9wnJApik0xRt8H3uqOG5kc+o8n67D+oTdPCTmEwJIV2J6iWN0CwAnhPY
	wtLkARBKTQz5hyRNx8Dvm4dubAv3tT3aFAwRrELuGQm8o6VeeFiRETTfoQcoeEtKR3I8tC+SBGD
	xs01l22gZPzxp82mR+OOJAMAlsvf4KSTuq+PuK+Etryzr/hYD45FLlEhm4+kgT+XFff5rCbk7jp
	xWWPjsXvkC8UaYCRm37T3gPcKFynnc/qqz7O2hGXr6fSjL20IK46Q8mkFygZP7p9vDFCm7pAb8Q
	4YXZpKmLNIdgwWDxFtqS1LZtD72CPZCWVrCkIf7E=
X-Google-Smtp-Source: AGHT+IEhfKgja72kmMEVu8mg+y0GPA2wBPQGXBF9w7fJkfAZVikcQ8zyKptW1cZk85GIYWtzdxftWQ==
X-Received: by 2002:a05:6512:3c8b:b0:553:24b4:6492 with SMTP id 2adb3069b0e04-55a5132157emr458860e87.5.1753291997236;
        Wed, 23 Jul 2025 10:33:17 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31aac980sm2396014e87.74.2025.07.23.10.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 10:33:16 -0700 (PDT)
Message-ID: <f7051d82-559f-420d-a766-6126ba2ed5ab@gmail.com>
Date: Wed, 23 Jul 2025 19:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] kasan: unify kasan_arch_is_ready() and remove
 arch-specific implementations
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com,
 agordeev@linux.ibm.com, akpm@linux-foundation.org, glider@google.com,
 dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <f10f3599-509d-4455-94a3-fcbeeffd8219@gmail.com>
 <CACzwLxjD0oXGGm2dkDdXjX0sxoNC2asQbjigkDWGCn48bitxSw@mail.gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <CACzwLxjD0oXGGm2dkDdXjX0sxoNC2asQbjigkDWGCn48bitxSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250723_103319_543957_5ABB1E6B 
X-CRM114-Status: GOOD (  24.65  )
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



On 7/22/25 8:21 PM, Sabyrzhan Tasbolatov wrote:
> On Tue, Jul 22, 2025 at 3:59 AM Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>>
>>
>>
>> On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:
>>
>>> === Testing with patches
>>>
>>> Testing in v3:
>>>
>>> - Compiled every affected arch with no errors:
>>>
>>> $ make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
>>>       OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
>>>       HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld \
>>>       ARCH=$ARCH
>>>
>>> $ clang --version
>>> ClangBuiltLinux clang version 19.1.4
>>> Target: x86_64-unknown-linux-gnu
>>> Thread model: posix
>>>
>>> - make ARCH=um produces the warning during compiling:
>>>       MODPOST Module.symvers
>>>       WARNING: modpost: vmlinux: section mismatch in reference: \
>>>               kasan_init+0x43 (section: .ltext) -> \
>>>               kasan_init_generic (section: .init.text)
>>>
>>> AFAIU, it's due to the code in arch/um/kernel/mem.c, where kasan_init()
>>> is placed in own section ".kasan_init", which calls kasan_init_generic()
>>> which is marked with "__init".
>>>
>>> - Booting via qemu-system- and running KUnit tests:
>>>
>>> * arm64  (GENERIC, HW_TAGS, SW_TAGS): no regression, same above results.
>>> * x86_64 (GENERIC): no regression, no errors
>>>
>>
>> It would be interesting to see whether ARCH_DEFER_KASAN=y arches work.
>> These series add static key into __asan_load*()/_store*() which are called
>> from everywhere, including the code patching static branches during the switch.
>>
>> I have suspicion that the code patching static branches during static key switch
>> might not be prepared to the fact the current CPU might try to execute this static
>> branch in the middle of switch.
> 
> AFAIU, you're referring to this function in mm/kasan/generic.c:
> 
> static __always_inline bool check_region_inline(const void *addr,
> 
>       size_t size, bool write,
> 
>       unsigned long ret_ip)
> {
>         if (!kasan_shadow_initialized())
>                 return true;
> ...
> }
> 
> and particularly, to architectures that selects ARCH_DEFER_KASAN=y, which are
> loongarch, powerpc, um. So when these arch try to enable the static key:
> 
> 1. static_branch_enable(&kasan_flag_enabled) called
> 2. Kernel patches code - changes jump instructions
> 3. Code patching involves memory writes
> 4. Memory writes can trigger any KASAN wrapper function
> 5. Wrapper calls kasan_shadow_initialized()
> 6. kasan_shadow_initialized() calls static_branch_likely(&kasan_flag_enabled)
> 7. This reads the static key being patched --- this is the potential issue?
> 


Yes, that's right.


> The current runtime check is following in tis v3 patch series:
> 
> #ifdef CONFIG_ARCH_DEFER_KASAN
> ...
> static __always_inline bool kasan_shadow_initialized(void)
> {
>         return static_branch_likely(&kasan_flag_enabled);
> }
> ...
> #endif
> 
> I wonder, if I should add some protection only for KASAN_GENERIC,
> where check_region_inline() is called (or for all KASAN modes?):
> 
> #ifdef CONFIG_ARCH_DEFER_KASAN
> ...
> static __always_inline bool kasan_shadow_initialized(void)
> {
>         /* Avoid recursion (?) during static key patching */
>         if (static_key_count(&kasan_flag_enabled.key) < 0)
>                 return false;
>         return static_branch_likely(&kasan_flag_enabled);
> }
> ...
> #endif
> 
> Please suggest where the issue is and if I understood the problem.

I don't know if it's a real problem or not. I'm just pointing out that we might
have tricky use case here and maybe that's a problem, because nobody had such use
case in mind. But maybe it's just fine.
I think we just need to boot test it, to see if this works.

> I might try to run QEMU on powerpc with KUnits to see if I see any logs.
powerpc used static key same way before your patches, so powerpc should be fine.

