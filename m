Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F59CF3189
	for <linux-um@archiver.kernel.org>; Wed,  2 Oct 2024 01:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KA+stoDZv6kBVnkV+Xzf4MLHAZfHVYVl/y++2UEaVoc=; b=mudY1esPAz/o4rFdB7L6/7d9x1
	TF7jKLDhqewl7vP4JizXqkTMmdH9vjV0hp2Ov5bm3hJ3cW4LJ4wJAydwLWzFWoPgndTg6yislfuXv
	s1H0/mbyaJRx61XAisFw3bHhOdyB4UwX3bqKxBHE0tFI/XjpzZSgcr2v79iA9gAynUTu2rp3gDx3D
	+x7HswAJaW+T8A9z+k+I4zgvvuAGcIx2OuBhQDb+5e0gZs3bqC9jmn5fVsguB61PFZB5NF7zasYfh
	F1RlwTWMQD68/eC5NFoB3F+0lGUbeklGSOjZkeNnHkAfCRdOgrQqByfxHsKEEm1jNBA9GZobAHfj3
	mAuzj0iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svo1B-00000004X5b-46Rq;
	Wed, 02 Oct 2024 01:19:05 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svo19-00000004X4i-1N7m
	for linux-um@lists.infradead.org;
	Wed, 02 Oct 2024 01:19:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 48B10A41560;
	Wed,  2 Oct 2024 01:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9690BC4CEC6;
	Wed,  2 Oct 2024 01:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727831942;
	bh=z31U8u7Saetd9Yh86iw2djS1AiJmkXhk8gUFFgbOklo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qZrB0rAteuEIVVZH0mMb3PsniT3C5p5hMCdpGmD1l63d1VJnq+tHzzVGhZt+LE48c
	 tgkULQ4U/nNcebkdhObCHGtO2MnETeQzx1mfkN66t+tFejs9SN0NaQXejFMSLZc5XR
	 hFMq07gRUIIN1ZUveDzNKEf8w6849Bse3NZngil87XKkl02Izr5BWVkXnJHXlaLuyP
	 tdWFgqLtz5h5R94CQfiNVfT3cbHtpDi3trI9QkfOTJrGItQ5ocTmOoU1/8JQf6ynRn
	 gJC01fd6253tQcb0lF2Ge+R5u1VCC24QeB+8S99cpPoR6OopmwS6zE8IoLKVU7LS7k
	 vDcfFB7h2gD3A==
Date: Tue, 1 Oct 2024 18:18:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Wentao Zhang <wentaoz5@illinois.edu>
Cc: Matt.Kelly2@boeing.com, akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com, anton.ivanov@cambridgegreys.com,
	ardb@kernel.org, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	chuck.wolber@boeing.com, dave.hansen@linux.intel.com,
	dvyukov@google.com, hpa@zytor.com, jinghao7@illinois.edu,
	johannes@sipsolutions.net, jpoimboe@kernel.org,
	justinstitt@google.com, kees@kernel.org, kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, luto@kernel.org, marinov@illinois.edu,
	masahiroy@kernel.org, maskray@google.com,
	mathieu.desnoyers@efficios.com, matthew.l.weber3@boeing.com,
	mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
	ndesaulniers@google.com, oberpar@linux.ibm.com, paulmck@kernel.org,
	peterz@infradead.org, richard@nod.at, rostedt@goodmis.org,
	samitolvanen@google.com, samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com, tglx@linutronix.de,
	tingxur@illinois.edu, tyxu@illinois.edu, x86@kernel.org
Subject: Re: [PATCH v2 4/4] x86: enable llvm-cov support
Message-ID: <20241002011858.GD555609@thelio-3990X>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-5-wentaoz5@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905043245.1389509-5-wentaoz5@illinois.edu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_181903_451068_A40750DD 
X-CRM114-Status: GOOD (  12.80  )
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

On Wed, Sep 04, 2024 at 11:32:45PM -0500, Wentao Zhang wrote:
> Set ARCH_HAS_* options to "y" in kconfig and include section description in

Is description the right word here? Maybe "include the compiler generated
sections"? Open to other suggestions.

> linker script.
> 
> Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
> Reviewed-by: Chuck Wolber <chuck.wolber@boeing.com>
> Tested-by: Chuck Wolber <chuck.wolber@boeing.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/x86/Kconfig              | 2 ++
>  arch/x86/kernel/vmlinux.lds.S | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 007bab9f2..e0a8f7b42 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -85,6 +85,8 @@ config X86
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_KCOV			if X86_64
> +	select ARCH_HAS_LLVM_COV		if X86_64
> +	select ARCH_HAS_LLVM_COV_PROFILE_ALL	if X86_64
>  	select ARCH_HAS_KERNEL_FPU_SUPPORT
>  	select ARCH_HAS_MEM_ENCRYPT
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 6e73403e8..904337722 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -191,6 +191,8 @@ SECTIONS
>  
>  	BUG_TABLE
>  
> +	LLVM_COV_DATA
> +
>  	ORC_UNWIND_TABLE
>  
>  	. = ALIGN(PAGE_SIZE);
> -- 
> 2.45.2
> 

