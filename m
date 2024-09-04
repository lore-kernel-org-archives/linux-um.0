Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C529DCA0ED3
	for <linux-um@archiver.kernel.org>; Wed,  4 Sep 2024 10:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l1FqEQ1EBx69cTLnkmcyioGnFBqM8g0rb/DEQgLCWWo=; b=12sradFOm+Vh8i/K5x3un1J+CY
	sRP8amodiY7UM6hDtNt0wwrPjpeTgiOGtV5FP9RunYebmdlNwgGQQLh0F7BzG1z8HPnKVGFAc+wBz
	qLB5qud1C9FEJHMtdks1WEfu+NMdKkMfm2+AjtnfOfxaiHhNz800lfO6ZChLwOfT5MD5RuCUkyPLt
	igQSzVZXjZJrK5RnvnruosJC/yNQiAfAZ4Ll4I18ZJHxteuz+gxVSMsfVrQIi4fqIAo5hdGgi6tJe
	x5moduX3z4BjRjuSOYzR6JMxAWKTbulz4u0jZfrlxMYh9oop2GtluVUT1BEevqRKQySdjooUJK/vc
	XCzHYLTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slmvv-00000003pnI-1A9p;
	Wed, 04 Sep 2024 10:08:15 +0000
Received: from hop.stappers.nl ([141.105.120.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slmLO-00000003gZp-2s8L
	for linux-um@lists.infradead.org;
	Wed, 04 Sep 2024 09:30:32 +0000
Received: from gpm.stappers.nl (gpm.stappers.nl [82.168.249.201])
	by hop.stappers.nl (Postfix) with ESMTP id 9137C20203;
	Wed,  4 Sep 2024 09:30:14 +0000 (UTC)
Received: by gpm.stappers.nl (Postfix, from userid 1000)
	id 7470E30417C; Wed,  4 Sep 2024 11:30:13 +0200 (CEST)
Date: Wed, 4 Sep 2024 11:30:12 +0200
From: Geert Stappers <stappers@stappers.nl>
To: Zigit Zo <zig@iorw.io>
Cc: ojeda@kernel.org, bjorn3_gh@protonmail.com, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	tglx@linutronix.de, mingo@redhat.com, nathan@kernel.org,
	ndesaulniers@google.com, gary@garyguo.net,
	rust-for-linux@vger.kernel.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: arch/um: use 'static' relocation model for uml
 modules
Message-ID: <ZtgopAHp+I2+xCIz@gpm.stappers.nl>
References: <20240903130606.292935-1-zig@iorw.io>
 <FD7D773099A0C7EC+20240903130606.292935-2-zig@iorw.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FD7D773099A0C7EC+20240903130606.292935-2-zig@iorw.io>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_023030_878131_308443FF 
X-CRM114-Status: GOOD (  13.70  )
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

On Tue, Sep 03, 2024 at 09:06:05PM +0800, Zigit Zo wrote:
> In the x86_64 UML, kernel modules compiled with Rust will currently
> generate some R_X86_64_GOTPCREL relocations, which will then be rejected
> by the kernel.
> 
> And because of the kernel modules of UML are only got handled by the UML
> itself, relocation model 'static' can work as expected other than 'pie'.
> ---
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 00b63bac5eff..b04b1d4d6dfe 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -63,7 +63,7 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
>  	-Din6addr_loopback=kernel_in6addr_loopback \
>  	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
>  
> -KBUILD_RUSTFLAGS += -Crelocation-model=pie
> +KBUILD_RUSTFLAGS_KERNEL += -Crelocation-model=pie
>  
>  KBUILD_AFLAGS += $(ARCH_INCLUDE)
>  
> -- 

I failed to match the actual change with the commit message.  Consider
that ignorance on my side.

I see a problem in just renaming a variable, might be my problem.  Thing
is that removal of 'KBUILD_RUSTFLAG += ' feels wrong, hence this posting.



Groeten
Geert Stappers
-- 
Silence is hard to parse

