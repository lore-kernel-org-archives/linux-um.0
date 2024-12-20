Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A78CE77188
	for <linux-um@archiver.kernel.org>; Fri, 20 Dec 2024 11:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mBRlMffFmN+hz5HGm/qsvwuPzuwmJovQ60y3/xe1EoY=; b=G7Cet1ErrdmzXsliaK75gBYOoG
	lTlA+frsoaqrxfqNFyqqCwzGP+71+6oCMP8Djjconf+AlFuHYpxSWcz/+1jFg7B0QHT6qBeXVbdBh
	BPsZup1k+nVJ2L1dV4XTjfXaxfqr2FeUbaatwgBaDt9wFYKAAjq2YBW0vxvWoWDKBFopXselKARiC
	/i3f49q9JzpCMRRgfJ1GJmPFOXiaxIdKAP8jwBhqjn40L2FscVXueP7vDIvrTCfPkMsB3AtVWRQjr
	uck9RdrplenAuV4AVHPfhftMoczEZvfSY0UzFcW92w4o40MjaJeiMFFri61o5xxrh6OCKMYHH2Orl
	K6a1ImrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tObSV-00000004oaL-0AzJ;
	Fri, 20 Dec 2024 11:46:19 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tObSS-00000004oYS-2Qyf
	for linux-um@lists.infradead.org;
	Fri, 20 Dec 2024 11:46:18 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-218c8aca5f1so20101965ad.0
        for <linux-um@lists.infradead.org>; Fri, 20 Dec 2024 03:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734695175; x=1735299975; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBRlMffFmN+hz5HGm/qsvwuPzuwmJovQ60y3/xe1EoY=;
        b=ebwtpK7IIoH28LnyqjcYWkmWPPc3T38g7rzHUvDlCDDAToJkKjkisqqolYFrzO8VIx
         HMeK4v8sfbtxpc5RhFtZnG89PKYriLOG7AYGcgjuFOGy5/dP1yx8GJcyph/sWqndTVwI
         DTBBQv27tyQ2YDFfFPE9ASqCjIv7QPiSysn2mje/4oT+y5aEdsbqKQ48s8temTqR4x/a
         jut9Yjufk7QWz2m31teCJpfdilvIyhAU2+TVYVbOI1XCX/7Np2EdTrle0lYHVSCWM916
         U0mDWvbfQLEiaWvg8gwxfHqGvecel1+/M/4QNn1cTFtdC4GhtjGbLsB08Mm9z39gOgri
         pkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734695175; x=1735299975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBRlMffFmN+hz5HGm/qsvwuPzuwmJovQ60y3/xe1EoY=;
        b=K1cYbqxAjwoz77cPVAHOvkGPf2hu50aROTjBZJVr/7c+GAdVgWZY6WkIuf/sBl1b/n
         WHqN7ciueP0WrbU3ypcWL6ZobT5TZRYW9pX7kgbwNf6YpcgSIYhO8a8apiiCfLIi6Yzv
         EFvz4YNqBXPKLOCpfoMnf6BDAjzLbCKHJEvGwoc3besDzLqv6kxLR1sF8X5DD4jhs0FF
         WxPnGn1MB/kFdwVPFoPD6mnzk3yEB59e7REs29YkGhodVAQBQwK+Gfp7QpuouaX82PJA
         8QExqHvYlcTJn6f3GnsuNmFz6wpAIq77m3l9TKtCeoAng5Ap5JijoNcB9ZkjtnPXnpFX
         uxTw==
X-Forwarded-Encrypted: i=1; AJvYcCUMMMAgU6x+jV1S3Hlo8dMop5Ke26A8I0Ah06m69J6Z4vPampk9oiN3tqnNFsyHFjAHEgj+zq+Mlw==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywgstm3rZRtYkZGw6zT3mU/4yegTVpjg0X10+rNAd3x63+5JmXj
	P1c0IogkskrlL4ywUK/AjE1n6hv20Juwrqcys9pGhsaahb4IMJW8rcWMjqMmmo0=
X-Gm-Gg: ASbGncueie5Izff3h3oChIaNQsGj2KaFqu8eQKhr/eKkC7Ndks2IKUH8oYIxg1RYJSy
	lX3oNNXeRgdUg+53QDVSDYv9EZ+gLz8meVMOUbSxeplGisstFCMVvgQH78JD4W1KzO3NV8ijSVm
	uUoCU0yDdiAacDWrBd/+yvkvLw9IRGtMjcWQkIzFv2p+1iyFJbhI2XJFJdH9tz19VHYVwKvewNv
	Wv9ilbR8YPZpSAeUiyQ3lB/JnG1FYVBRL6gf2DYD9WRVrgkljazzFzZPJn3AJBpC1yJTaQStbEx
	FimRbxVO6a7pOsWFTv26Z1tTCWlcAPf3ahvnn2966cSEXH4Fogb9PGk=
X-Google-Smtp-Source: AGHT+IG40UPaAgLiyyOp9k8XqW2vPy2P2eyTWxZSuqMQTAARXLtkQgcz7lH63J8oRPI229SK+RLglg==
X-Received: by 2002:a17:902:ce92:b0:216:4169:f9d7 with SMTP id d9443c01a7336-219e6e8bc7cmr41107195ad.2.1734695174995;
        Fri, 20 Dec 2024 03:46:14 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:3764:680a:144b:d927:5a3b? ([2409:8a28:f44:3764:680a:144b:d927:5a3b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2db9939b5sm5267286a91.1.2024.12.20.03.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 03:46:14 -0800 (PST)
Message-ID: <0daabd32-cba4-4345-baa8-e8c66bc899ff@bytedance.com>
Date: Fri, 20 Dec 2024 19:46:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm: Move common parts of pagetable_*_[cd]tor to
 helpers
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Ryan Roberts
 <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 loongarch@lists.linux.dev, x86@kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
 <20241219164425.2277022-2-kevin.brodsky@arm.com>
 <20241219171920.GB26279@noisy.programming.kicks-ass.net>
 <75cb4ff8-eb0c-4519-a30a-f8be717ba278@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <75cb4ff8-eb0c-4519-a30a-f8be717ba278@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_034616_812365_6F248AE7 
X-CRM114-Status: GOOD (  20.55  )
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

Hi Kevin,

On 2024/12/20 18:49, Kevin Brodsky wrote:
> Hi Peter, Qi,
> 
> On 19/12/2024 18:19, Peter Zijlstra wrote:
>> On Thu, Dec 19, 2024 at 04:44:16PM +0000, Kevin Brodsky wrote:
>>> Besides the ptlock management at PTE/PMD level, all the
>>> pagetable_*_[cd]tor have the same implementation. Introduce common
>>> helpers for all levels to reduce the duplication.
>> Uff, I forgot to Cc you on the discussion here, sorry!:
>>
>>    https://lkml.kernel.org/r/cover.1734526570.git.zhengqi.arch@bytedance.com
>>
>> we now have two series doing more or less overlapping things :/
>>
>> You can in fact trivially merge the all the implementations -- the
>> apparent non-common bit (ptlock_free) is a no-op for all those other
>> levels because they'll be having ptdesc->lock == NULL.
> 
> Ah that is good to know, thanks for letting me know about that and Qi's
> series! Fortunately there isn't that much overlap between our series - I
> think we can easily sort this out.
> 
> Qi, shall we collaborate to make our series complementary? I believe my
> series covers patch 2 and 4 of your series, but it goes further by
> covering all levels and all architectures, and patches introducing
> ctor/dtor are already split as Alexander suggested on your series. So my
> suggestion would be:
> 
> * Remove patch 1 in my series - I'd just introduce
> pagetable_{p4d,pgd}_[cd]tor with the same implementation as
> pagetable_pud_[cd]tor.
> * Remove patch 2 and 4 from your series and rebase it on mine.

I quickly went through your patch series. It looks like my patch 2 and
your patch 6 are duplicated, so you want me to remove my patch 2.

But I think you may not be able to simple let arm64, riscv and x86 to
use generic p4d_{alloc_one,free}(). Because even if
CONFIG_PGTABLE_LEVELS > 4, the pgtable_l5_enabled() may not be true.

For example, in arm64:

#if CONFIG_PGTABLE_LEVELS > 4

static __always_inline bool pgtable_l5_enabled(void)
{
	if (!alternative_has_cap_likely(ARM64_ALWAYS_BOOT))
		return vabits_actual == VA_BITS;
	return alternative_has_cap_unlikely(ARM64_HAS_VA52);
}

Did I miss something?

My patch series is not only for cleanup, but also for fixes of
UAF issue [1], so is it possible to rebase your patch series onto
mine? I can post v3 ASAP.

[1]. 
https://lore.kernel.org/all/67548279.050a0220.a30f1.015b.GAE@google.com/

Thanks!

> 
> Let me know if that makes sense, if so I'll post a v2.
> 
> Cheers,
> - Kevin

