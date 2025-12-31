Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF56EE57FB
	for <linux-um@archiver.kernel.org>; Wed, 31 Dec 2025 09:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RhQC3hnAx6vo8ybVJwyWTzkkYGMOha8q8BXdXCtNSM8=; b=BL/LuBI4TnSirOHL6oJo9LJ3h7
	GL4XXF6QcojDo63x2d7FG5rpogBCz/AytcBO8w2EKEuQb+3xRxHPIU1JUmxypQ15FnzeKRmraHSW2
	7ANRjFa1Id4jt+OELyFkU6VxzU1pWRnCPbIAH1I+Lka448X+cAqvg5SsGlwSud96DhOTGb0pDNJpx
	4bD7XKyYXC5wGExwjndV1jprNsxjg4MtsiPPIj7tLneYWEiqbmFjuthxhhovrYdWArX7NEhDUR0mP
	nWZmRkkpOALiAVpwY7OQN7ouLef85A2mrxdfd29chtBO5wXHxigjfp/y6OQmGPvO0m4+AdMGKDwJp
	iSMVwHhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vasjA-00000005q2F-3MeM;
	Wed, 31 Dec 2025 09:42:48 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vasj8-00000005q1k-1dFz
	for linux-um@lists.infradead.org;
	Wed, 31 Dec 2025 09:42:47 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-64b4f730a02so17765817a12.0
        for <linux-um@lists.infradead.org>; Wed, 31 Dec 2025 01:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767174164; x=1767778964; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhQC3hnAx6vo8ybVJwyWTzkkYGMOha8q8BXdXCtNSM8=;
        b=IVNsLNF8ryo7npb1qi9fTS6OQxZd9dLZOXvl/4nwhble13YCAQjl2VLozCLHqAwL03
         31kQmzGzN0rcEE1TC8PSK0Dir1ntUdd6HDGabpftK7FeaQzMjjx0Ub1JNiWIO69kRldb
         BbdDFcq2X5BneNPtz77CR18SUF+bVpFY3A4lj4CiJAttvm1FntnanxpqrFW9C+viGUg7
         Xce9IsSq9qPl5DkH6nQKvUgx11WqFktvlWGm9m276o++ior97mb2tLiymfTkU+vUa/rt
         2bRbCPvSiqwsKHoJ82zEgJdM+nScI4Mb5EB47VCEtC9S70x/aY8yyEkd6oLqqGG2/q7T
         0DYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767174164; x=1767778964;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhQC3hnAx6vo8ybVJwyWTzkkYGMOha8q8BXdXCtNSM8=;
        b=GhOKGBQMCiXVEhnaRff4kCccdGn2/pb/2j76Cns/CSM6FBL6wFdKTWNY61u075IKje
         NyIdE2xZjBeZ6kD79k3w6dBEnKb87+TDhXOwCFmjO2ORAqgdQSFbmDhTrLNqTJSzpVDU
         SOzFAIZmKbgGWIVKwQbn2Ls6jVYnaUnw/r1o0CSNabde2ne1kJQxJl6t2+gEl5C9Jfxe
         LwnlYP5CZVvhqLxNyMdKdKemWQmFUJ7Ki2xvDTdwn7VaHs3gOv5vYumnjDnnhmIA49ao
         z0NHgHhFYzfiSyf1p2SjlLpyOsqL+c90ftxsFHWyDjSIFx1+3wdDkshECejdCuj1Jcwc
         qdsA==
X-Forwarded-Encrypted: i=1; AJvYcCWzuU+pflBwVnAFE4aiQATYVWxNSaX55LSSzqTj455p3AShWV1/xYzO9ZCgL59oCfl8wncKf5d8kA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyZK3mchOVjGk5m1WaFWSA6tmBo0ChI9auJ+Xz+b1TcoUe9rLmq
	I6Ri5cLocueqmlRCjBzijqUT/ycDAKMbAatD+l/Yn0hdh+GodFPwak1j
X-Gm-Gg: AY/fxX5aHezxGAv2UYdkoS4FA8snCG9No+uz5uEaB7f3tsDLMNqD28UhtVOM0DO9QAt
	qaGEl+45TKG75nnNDBaCXpvzzHmyMOVO01ZURZCrrAfB+qc6T6u/Ebh6onX2idmjg4A2izF+FbI
	1NGvF+Evwn37Iq2TjAbbDcTsmlZzxsnRAaGJEUWYPbREL0olZ7fFgeJWZ3ohX2yteLx18FjxHd2
	zHsEtJt4pb7KJWtuOfhz3Z8uqm0+y8Rm2ZlLC+INZEWsLcbhSIoFyTao7zd9+bhUcOqlLevDRtE
	Mkl5dWD2Zj9md4YNh9AHXEtJQyMZVn3H56EJQhwfHo76G08BIJypVY9wW8ps0qTtpKCZoqRAUnd
	n/gSI3LLYWtSz2H+T0IvJyrUDlxkuTmAozJaI28qaC2RiA/hKhZnb7M6m5e9bDcAeRUDWlurB4t
	XKyJhaVtjpBQ==
X-Google-Smtp-Source: AGHT+IG6BnZXWofbdukBItAk61uwrC2j9z3+nQpSf68E/xI1yNmjywUHcnARSPenSAEDWkU1hfWn1g==
X-Received: by 2002:a05:6402:2356:b0:64d:4f75:aa28 with SMTP id 4fb4d7f45d1cf-64d4f75adb0mr30963979a12.18.1767174163924;
        Wed, 31 Dec 2025 01:42:43 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9105655asm37568985a12.9.2025.12.31.01.42.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Dec 2025 01:42:43 -0800 (PST)
Date: Wed, 31 Dec 2025 09:42:43 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org,
	david@kernel.org, ioworker0@gmail.com, linmag7@gmail.com,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 7/7] mm: make PT_RECLAIM depends on
 MMU_GATHER_RCU_TABLE_FREE
Message-ID: <20251231094243.zmjs7kgflm7q6k73@master>
References: <cover.1765963770.git.zhengqi.arch@bytedance.com>
 <ac2bdb2a66da1edb24f60d1da1099e2a0b734880.1765963770.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac2bdb2a66da1edb24f60d1da1099e2a0b734880.1765963770.git.zhengqi.arch@bytedance.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_014246_449011_A54F516E 
X-CRM114-Status: GOOD (  14.53  )
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Wed, Dec 17, 2025 at 05:45:48PM +0800, Qi Zheng wrote:
>From: Qi Zheng <zhengqi.arch@bytedance.com>
>
>The PT_RECLAIM can work on all architectures that support
>MMU_GATHER_RCU_TABLE_FREE, so make PT_RECLAIM depends on
>MMU_GATHER_RCU_TABLE_FREE.
>
>BTW, change PT_RECLAIM to be enabled by default, since nobody should want
>to turn it off.
>
>Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>---
> arch/x86/Kconfig | 1 -
> mm/Kconfig       | 9 ++-------
> 2 files changed, 2 insertions(+), 8 deletions(-)
>
>diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>index 80527299f859a..0d22da56a71b0 100644
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -331,7 +331,6 @@ config X86
> 	select FUNCTION_ALIGNMENT_4B
> 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
> 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>-	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
> 	select ARCH_SUPPORTS_SCHED_SMT		if SMP
> 	select SCHED_SMT			if SMP
> 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
>diff --git a/mm/Kconfig b/mm/Kconfig
>index bd0ea5454af82..fc00b429b7129 100644
>--- a/mm/Kconfig
>+++ b/mm/Kconfig
>@@ -1447,14 +1447,9 @@ config ARCH_HAS_USER_SHADOW_STACK
> 	  The architecture has hardware support for userspace shadow call
>           stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
> 
>-config ARCH_SUPPORTS_PT_RECLAIM
>-	def_bool n
>-
> config PT_RECLAIM
>-	bool "reclaim empty user page table pages"
>-	default y
>-	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>-	select MMU_GATHER_RCU_TABLE_FREE
>+	def_bool y
>+	depends on MMU_GATHER_RCU_TABLE_FREE
> 	help
> 	  Try to reclaim empty user page table pages in paths other than munmap
> 	  and exit_mmap path.

Hi, Qi

I am new to PT_RECLAIM, when reading related code I got one question.

Before this patch,  we could have this config combination:

    CONFIG_MMU_GATHER_RCU_TABLE_FREE & !CONFIG_PT_RECLAIM

This means tlb_remove_table_free() is rcu version while tlb_remove_table_one()
is semi rcu version.

I am curious could we use rcu version tlb_remove_table_one() for this case?
Use rcu version tlb_remove_table_one() if CONFIG_MMU_GATHER_RCU_TABLE_FREE. Is
there some limitation here?

Thanks in advance for your explanation.


-- 
Wei Yang
Help you, Help me

