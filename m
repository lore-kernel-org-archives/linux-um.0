Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DAECD610D
	for <linux-um@archiver.kernel.org>; Mon,  9 Oct 2023 16:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m2BHqS5caCblOV0sLw3kohxhVKIOudnW/kdvr8GsuK4=; b=Gl3M3U4o5z63we
	Oc3SAtW3a/+s5IoHAHytDyFnkh3D+iJfNvk/YRchOLlH+jp2X3oIYxQePE1+AI/rxmjCwNTuhaUEV
	zF+ZORFDW8yI0i3tjrNYt4igdi44awyJLe6M5rnNiwH7QxK7rLDRJbUN/+tF08VaW6OB0bReB4Emu
	sHOPgCqZg0K5KELwQH12nBfc83t/5eJdd10WpDEzA11KWE2xidH8wGNexoqsS4j4i+TfdqkEfEIwx
	0jwJlpBcUutCXlYNhnhmTgvo34HYx7BklM2ruMIfJryfXxLCBnQc46XA2pZjUD9oR8aMB5UpnL9EQ
	XjRfdwGpPQr3h2MuFUNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qptMw-00BDID-1C;
	Mon, 09 Oct 2023 16:44:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qptMr-00BDFm-2g;
	Mon, 09 Oct 2023 16:44:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1E71E60FA6;
	Mon,  9 Oct 2023 16:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F078CC433C9;
	Mon,  9 Oct 2023 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696869866;
	bh=hih2ojuht8Q/T9suSdsZNAYc2MUvDRpGqPW8913YgAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fv81rrzfBlhmCSyzSbFm4f8JmVVlagKhI0OSyXRpR9/9h6b+FdXcgjHwMZf+cp2su
	 mbqmY3gelrBeruWabdjhdJ7id0I+kYb4WQts1gPqLjS+3CJCbaChYfdPpuALshd0S2
	 D0ujnmXLy7Y+ZKbyA/zoyhV0p0PlZ4oe0eSIh2/bG/xa0s8wb7AWDZcGyWM51/JUlA
	 zGbn0/kqtcasGNaUv9ytjnTsHF9fztBTPtXE3lvmuDEhMnXarop6rBifKltQEQZBbh
	 6dACfPxTF0tS/Qi+1I18u2riwu+RYVcpIqDkoZorHn1XiP07DP4IBEhM9xHDO58CAb
	 sMMh+aXVY62tA==
Date: Mon, 9 Oct 2023 09:44:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
	x86@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 5/5] kbuild: unify no-compiler-targets and
 no-sync-config-targets
Message-ID: <20231009164424.GB1153868@dev-arch.thelio-3990X>
References: <20231009124210.1064021-1-masahiroy@kernel.org>
 <20231009124210.1064021-5-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231009124210.1064021-5-masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_094429_974294_C1094FE2 
X-CRM114-Status: GOOD (  14.77  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, Oct 09, 2023 at 09:42:10PM +0900, Masahiro Yamada wrote:
> Now that vdso_install does not depend on any in-tree build artifact,
> it no longer invokes a compiler, making no-compiler-targets the same
> as no-sync-config-targets.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  Makefile | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 2170d56630e8..982b1ad33287 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -277,10 +277,6 @@ no-dot-config-targets := $(clean-targets) \
>  			 $(version_h) headers headers_% archheaders archscripts \
>  			 %asm-generic kernelversion %src-pkg dt_binding_check \
>  			 outputmakefile rustavailable rustfmt rustfmtcheck
> -# Installation targets should not require compiler. Unfortunately, vdso_install
> -# is an exception where build artifacts may be updated. This must be fixed.
> -no-compiler-targets := $(no-dot-config-targets) install dtbs_install \
> -			headers_install modules_install modules_sign kernelrelease image_name
>  no-sync-config-targets := $(no-dot-config-targets) %install modules_sign kernelrelease \
>  			  image_name
>  single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.symtypes %/
> @@ -288,7 +284,6 @@ single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.symtypes %
>  config-build	:=
>  mixed-build	:=
>  need-config	:= 1
> -need-compiler	:= 1
>  may-sync-config	:= 1
>  single-build	:=
>  
> @@ -298,12 +293,6 @@ ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
>  	endif
>  endif
>  
> -ifneq ($(filter $(no-compiler-targets), $(MAKECMDGOALS)),)
> -	ifeq ($(filter-out $(no-compiler-targets), $(MAKECMDGOALS)),)
> -		need-compiler :=
> -	endif
> -endif
> -

MIPS and LoongArch seem to have grown a usage of need-compiler in
4fe4a6374c4d ("MIPS: Only fiddle with CHECKFLAGS if `need-compiler'")
and 54c2c9df083f ("LoongArch: Only fiddle with CHECKFLAGS if
`need-compiler'"). With this removal, should those be updated as well?

>  ifneq ($(filter $(no-sync-config-targets), $(MAKECMDGOALS)),)
>  	ifeq ($(filter-out $(no-sync-config-targets), $(MAKECMDGOALS)),)
>  		may-sync-config :=
> @@ -675,7 +664,7 @@ endif
>  
>  # Include this also for config targets because some architectures need
>  # cc-cross-prefix to determine CROSS_COMPILE.
> -ifdef need-compiler
> +ifdef may-sync-config
>  include $(srctree)/scripts/Makefile.compiler
>  endif
>  
> -- 
> 2.39.2
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
