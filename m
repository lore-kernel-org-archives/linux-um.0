Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426D8C46CD2
	for <linux-um@archiver.kernel.org>; Sat, 27 Jan 2024 15:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=00HrD1IhuQmR+EwLEjCjDLoXe3g78WYlHbV+z/4Ju2w=; b=BWEjtpkODeDsDOJKVjgGHxQleP
	GXptxP20rOSKC7lZsh/u1ZiNAt5y6sT97hg1Fs2OQo6rO5sbMUstHG4Hmas28g9g4y07yWvtCFCym
	GyFCOcxA3kTjc4x5je4944zvxpsK1sgMgEb7E7YGWljuMBVX8qgZol3zHE/7z0pOdRxhU5klMi0l/
	31Plhjzr4HhRxRL3pSGUPis5a0tsEarlO6HUMyoKaDNcOvsYnFuEsW4iiwhi1uTZc5gFJMBfe0q3f
	woPO3movwSpRVzi/8XVrWtyHQ95/6EWth17fRfAtoIPnaMPGAK9Jpou1UYoXya5OdZ6qGGZ7gB6tW
	a+1Iv3XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTkts-00000007hQL-2nNj;
	Sat, 27 Jan 2024 15:47:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTktp-00000007hPv-0Hla
	for linux-um@lists.infradead.org;
	Sat, 27 Jan 2024 15:47:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 703CD60F5D
	for <linux-um@lists.infradead.org>; Sat, 27 Jan 2024 15:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D949C433F1
	for <linux-um@lists.infradead.org>; Sat, 27 Jan 2024 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706370436;
	bh=dt9VvdF/8OYHRRdEUaG9vvg+fTbbx3DPBoW88jakmBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dl/Ea3iS1+YhJy8M1nNHmHwed/H+VotiXjE7HcenWap6W4RqdJ/2uK8u/ZSKqnWnI
	 KaOgrdrso+SaPeYUG1V3Uc7jYMVtDUEYbTHJFhSCbLnIh8kvkRDzuU8gupYjtGBVvf
	 2Cr79+KwfS6fM5MZMWHfj/o/YpeL6087dLKZAvojXPeM1KBoiDx9Fx5jQ9uH4SpeNE
	 qL5The4PQTF7CMILKG/DhmH6MhE9Fi2mqwERzOGOvkXdUfGwfe4mUkXBYxvGSlqBLw
	 If+SXbjbAmctt9ltwEyfJlE3bm1vZcn9ikFUTVGLzSYUUNpvE2f+uIY3hL3UjSJMsA
	 reS/U5gakHTtA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-204235d0913so720688fac.1
        for <linux-um@lists.infradead.org>; Sat, 27 Jan 2024 07:47:16 -0800 (PST)
X-Gm-Message-State: AOJu0Yy9UOb2/kPeQuIER7i6I+ZVJJfeDhxljLpZ6lGHXKCp7H+ZvT4V
	+nd1gloXO2NWvhGfL7cW4CViIdEWQ2eTCmyM+TD5bobVB8UuKWk7F74WYeFvebelDR1Q4OjL0zK
	NHYOZ9PLUAEohj3iPnywMBj6597Y=
X-Google-Smtp-Source: AGHT+IF9R2Ubn6ti8JRFokgpKc272W4nvEnCWGffmIJjz1OEd2Z6fjYKChcKDBZINF2k4k2UkRATWzEsr08KUIE/iYE=
X-Received: by 2002:a05:6871:609:b0:210:dc9d:5af8 with SMTP id
 w9-20020a056871060900b00210dc9d5af8mr1247515oan.37.1706370435504; Sat, 27 Jan
 2024 07:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20240123-fix-uml-clang-18-v1-0-efc095519cf9@kernel.org> <20240123-fix-uml-clang-18-v1-1-efc095519cf9@kernel.org>
In-Reply-To: <20240123-fix-uml-clang-18-v1-1-efc095519cf9@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 28 Jan 2024 00:46:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAToMq=5TT=--i=TaZX_hCNfEJLFSzLBEBAFwKFqvhBQkg@mail.gmail.com>
Message-ID: <CAK7LNAToMq=5TT=--i=TaZX_hCNfEJLFSzLBEBAFwKFqvhBQkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] um: Fix adding '-no-pie' for clang
To: Nathan Chancellor <nathan@kernel.org>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	nicolas@fjasle.eu, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, linux-um@lists.infradead.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_074717_224670_442C614D 
X-CRM114-Status: GOOD (  25.12  )
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

On Wed, Jan 24, 2024 at 8:00=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> The kernel builds with -fno-PIE, so commit 883354afbc10 ("um: link
> vmlinux with -no-pie") added the compiler linker flag '-no-pie' via
> cc-option because '-no-pie' was only supported in GCC 6.1.0 and newer.
>
> While this works for GCC, this does not work for clang because cc-option
> uses '-c', which stops the pipeline right before linking, so '-no-pie'
> is unconsumed and clang warns, causing cc-option to fail just as it
> would if the option was entirely unsupported:
>
>   $ clang -Werror -no-pie -c -o /dev/null-x c /dev/null


A nit. A missing space in-between.


I fixed "/dev/null-x" to "/dev/null -x"
when I applied the patch.






>   clang-16: error: argument unused during compilation: '-no-pie' [-Werror=
,-Wunused-command-line-argument]
>
> A recent version of clang exposes this because it generates a relocation
> under '-mcmodel=3Dlarge' that is not supported in PIE mode:
>
>   /usr/sbin/ld: init/main.o: relocation R_X86_64_32 against symbol `saved=
_command_line' can not be used when making a PIE object; recompile with -fP=
IE
>   /usr/sbin/ld: failed to set dynamic section sizes: bad value
>   clang: error: linker command failed with exit code 1 (use -v to see inv=
ocation)
>
> Remove the cc-option check altogether. It is wasteful to invoke the
> compiler to check for '-no-pie' because only one supported compiler
> version does not support it, GCC 5.x (as it is supported with the
> minimum version of clang and GCC 6.1.0+). Use a combination of the
> gcc-min-version macro and CONFIG_CC_IS_CLANG to unconditionally add
> '-no-pie' with CONFIG_LD_SCRIPT_DYN=3Dy, so that it is enabled with all
> compilers that support this. Furthermore, using gcc-min-version can help
> turn this back into
>
>   LINK-$(CONFIG_LD_SCRIPT_DYN) +=3D -no-pie
>
> when the minimum version of GCC is bumped past 6.1.0.
>
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1982
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/um/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 82f05f250634..34957dcb88b9 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -115,7 +115,9 @@ archprepare:
>         $(Q)$(MAKE) $(build)=3D$(HOST_DIR)/um include/generated/user_cons=
tants.h
>
>  LINK-$(CONFIG_LD_SCRIPT_STATIC) +=3D -static
> -LINK-$(CONFIG_LD_SCRIPT_DYN) +=3D $(call cc-option, -no-pie)
> +ifdef CONFIG_LD_SCRIPT_DYN
> +LINK-$(call gcc-min-version, 60100)$(CONFIG_CC_IS_CLANG) +=3D -no-pie
> +endif
>  LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) +=3D -Wl,-rpath,/lib
>
>  CFLAGS_NO_HARDENING :=3D $(call cc-option, -fno-PIC,) $(call cc-option, =
-fno-pic,) \
>
> --
> 2.43.0
>


--
Best Regards
Masahiro Yamada

