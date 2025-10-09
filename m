Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315B2CCA470
	for <linux-um@archiver.kernel.org>; Thu,  9 Oct 2025 01:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1QmteHczt4IB2OaGgMcuo7lCBy1YKUcT8nLt2LHCF7g=; b=cTTJXviPMt/Z/JK5PhMHeB41XE
	3UhOikC5TKq4aper8xQRTbQTz7UCpsRi164GvB0zlVa6OY+WORQ9j4WeYZk27Kbzz9/fG5q4gAome
	b+I+0ezKBWCb9sEksHPmArdLzXUuEPIfJCgW4snbFmve/F0zgv1JjEMdAKbEB6hnNwqgdm5zSEcI+
	PTv11fP9VPJM86M0xECvqH6+JJ/52HiLEiBzi34msgCJLBGVZUq4lcpqGlynZhQwIZLAoTj4xVR4M
	Y4h1JfRo03T6u4PT0IPFnMnVjjgGIee3XK1pEN8HKOHqDQPLIgnk/j2JctJ5coDAvRVdXkTF2VtwC
	P3hTqfug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6f7p-00000004ubL-2MM7;
	Thu, 09 Oct 2025 01:07:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6f7m-00000004uY6-2IDW;
	Thu, 09 Oct 2025 01:07:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 32835450E2;
	Thu,  9 Oct 2025 01:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1021AC4CEE7;
	Thu,  9 Oct 2025 01:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759972038;
	bh=0pQ9vc0S7+W0X1K4N+Om/UUij1yWdKMoXEP+Dp45E6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mgLCEG1psTMeWNX86G6Tj93NFOr9A6HPWBooqhDsK/peZJiDr0z/lTt34SW/uV2wG
	 K2KA79ATbUyDb+QTtCiIb37Rmvl0ZB6h8EYOw6lZaU8PA4YEraSK96r4wnFJg5DgK6
	 px0wfbyKDtcXRuIuG3T18Ewh+okDNXN4RBEutXF8zlOxKiOztQ3FRVjOkE20nlpwGX
	 YhuXK6buub3FK7cN2EWSYIN6r/pZvCaQavyztMciWzkDa46lDOV/dfEDrzjJFL6sad
	 0NMFuRS+cJkrvvNwdswXaYRikNalB+yZpqvN9LdbCi0fl6LsirGqURxRennMUrvEHk
	 ipzxebesp0GnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF8C3A41017;
	Thu,  9 Oct 2025 01:07:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/2] kasan: unify kasan_enabled() and remove
 arch-specific
 implementations
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <175997202628.3661959.104646439887808862.git-patchwork-notify@kernel.org>
Date: Thu, 09 Oct 2025 01:07:06 +0000
References: <20250810125746.1105476-1-snovitoll@gmail.com>
In-Reply-To: <20250810125746.1105476-1-snovitoll@gmail.com>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: linux-riscv@lists.infradead.org, ryabinin.a.a@gmail.com,
 christophe.leroy@csgroup.eu, bhe@redhat.com, hca@linux.ibm.com,
 andreyknvl@gmail.com, akpm@linux-foundation.org, zhangqing@loongson.cn,
 chenhuacai@loongson.cn, davidgow@google.com, glider@google.com,
 dvyukov@google.com, alexghiti@rivosinc.com, alex@ghiti.fr,
 agordeev@linux.ibm.com, vincenzo.frascino@arm.com, elver@google.com,
 kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251008_180718_603668_D1A56981 
X-CRM114-Status: UNSURE (   9.92  )
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

Hello:

This series was applied to riscv/linux.git (for-next)
by Andrew Morton <akpm@linux-foundation.org>:

On Sun, 10 Aug 2025 17:57:44 +0500 you wrote:
> This patch series addresses the fragmentation in KASAN initialization
> across architectures by introducing a unified approach that eliminates
> duplicate static keys and arch-specific kasan_arch_is_ready()
> implementations.
> 
> The core issue is that different architectures have inconsistent approaches
> to KASAN readiness tracking:
> - PowerPC, LoongArch, and UML arch, each implement own kasan_arch_is_ready()
> - Only HW_TAGS mode had a unified static key (kasan_flag_enabled)
> - Generic and SW_TAGS modes relied on arch-specific solutions
>   or always-on behavior
> 
> [...]

Here is the summary with links:
  - [v6,1/2] kasan: introduce ARCH_DEFER_KASAN and unify static key across modes
    https://git.kernel.org/riscv/c/1e338f4d99e6
  - [v6,2/2] kasan: call kasan_init_generic in kasan_init
    https://git.kernel.org/riscv/c/e45085f2673b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



