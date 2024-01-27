Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2483DC46CD2
	for <linux-um@archiver.kernel.org>; Sat, 27 Jan 2024 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aTZ+4402c0HBHxOarRa3OjKtBlDuHofpwDkz2Py7qOQ=; b=dEa/nFTwQdM3ow7KL7KL2/x1sU
	Ul3dO3q659DaabKehEPdzgu2S6pMmgjpWcrhDFS62jmdUMY1G+ZL+FYRJkiVEN9hcPmw+ew8jueg9
	H3oRxW5BXwfXC8ooJj2Q1vxiVpZuWTcVaeEs1CI7vJO5fiIi/4OBMl1n7kNJHszK24asIA3N+jn1R
	vnjcxHBDa6V28dgESxgnbWrKzeRZziQkbaDQxA5qDcQ7EZeESEeAJmZJZ9Vmb2WRbG9ZADXD2F2Yy
	3Wt3693E4Hjs+ls8YWwmMftTdttOOVV68ym8JAkDSmrPVsEgKSlXiSAfihCywCCnSZ2mhHit+2PkR
	ZBm0Bqyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTkrM-00000007hCr-3LEy;
	Sat, 27 Jan 2024 15:44:44 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTkrJ-00000007hC2-2mWk
	for linux-um@lists.infradead.org;
	Sat, 27 Jan 2024 15:44:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BDF83CE0F97
	for <linux-um@lists.infradead.org>; Sat, 27 Jan 2024 15:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F73C43390
	for <linux-um@lists.infradead.org>; Sat, 27 Jan 2024 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706370276;
	bh=EELGZfz9lAK1loDeD8w+xVM+cCGtcqj7CLX+2eCWnjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LeEO5kZ96OPVbvsuqrFBY5t8/3El+/M6PFnfIKMwYu3QQubqPuJck1PyNFQ+mDkLn
	 cXuT+OAiMpWPc2E6BmL0PoKc4Wop1BgdwWd1PAu7XdHsS2cnYb5b6AT0ieUC5YMreg
	 Yb/B0XWNT2Uc0gwv+K3ZdNs+mpYbYob+VoYLH7X5KsTEjTjNpQL3VKWZDDsOBueIiZ
	 v6JgTgQS9Eiiq60v7QeL2Fd3vuyWC2/Anrc0LCZwV95zSIeuhBpU0u/CO9U1zQ0ow3
	 vUrglhgVu0IkPrZ3v5lz5jvfyGuFC87O5FP11tNPgP2JsTU5FCIPz6wjOagpSpIZPR
	 W+DbkHjXFT7Rg==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2185d5f4366so98032fac.2
        for <linux-um@lists.infradead.org>; Sat, 27 Jan 2024 07:44:36 -0800 (PST)
X-Gm-Message-State: AOJu0YyLp9tItOBjq6RcA/2poc+JrexkYymzhE91fuXfffZYKVRzUX6b
	LHjZ4TK5CIeCuhlklJv6cqVGi8qtHuuM1NSuMPQN39zFz8iW1iIAztiAFVnGAVw7DVkhhK1HbCK
	B40ZlPl1uO/Oo1jSB5xOoniCGehQ=
X-Google-Smtp-Source: AGHT+IHKu7J4sPa55OVECUcHBRCyx9ZzSiCi17gfOvi7AHAWXZs8rsCFKBZguK0vE3/J1lnVbJu5h3QeBTUduqR8Jpo=
X-Received: by 2002:a05:6871:5287:b0:214:7ef2:e8c with SMTP id
 hu7-20020a056871528700b002147ef20e8cmr1060638oac.0.1706370275802; Sat, 27 Jan
 2024 07:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20240123-fix-uml-clang-18-v1-0-efc095519cf9@kernel.org>
In-Reply-To: <20240123-fix-uml-clang-18-v1-0-efc095519cf9@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 28 Jan 2024 00:43:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ7VauHgJK+939QjtOLtOPDOyGsYfwj+9f+1-jkFdtWnQ@mail.gmail.com>
Message-ID: <CAK7LNAQ7VauHgJK+939QjtOLtOPDOyGsYfwj+9f+1-jkFdtWnQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix UML build with clang-18 and newer
To: Nathan Chancellor <nathan@kernel.org>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	nicolas@fjasle.eu, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, linux-um@lists.infradead.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_074442_078537_6F8C0333 
X-CRM114-Status: GOOD (  16.49  )
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
> Hi all,
>
> This series resolves two independent but related issues that were
> recently exposed by two LLVM changes.
>
> https://github.com/llvm/llvm-project/commit/ec92d74a0ef89b9dd46aee6ec8aca=
6bfd3c66a54
> exposes that '-no-pie' is not getting added to the linker flags with
> clang, resulting in building objects with '-fno-PIE' that are linked
> with '-pie', to which the linker rightfully errors with:
>
>   /usr/sbin/ld: init/main.o: relocation R_X86_64_32 against symbol `saved=
_command_line' can not be used when making a PIE object; recompile with -fP=
IE
>   /usr/sbin/ld: failed to set dynamic section sizes: bad value
>
> https://github.com/llvm/llvm-project/commit/4bf8a688956a759b7b6b8d94f42d2=
5c13c7af130
> adds '.ltext' (and '.ltext.*' with '-ffunction-sections') when using
> '-mcmodel=3Dlarge' (which UML does), which causes a segmentation fault
> with modpost.
>
> I have tested these patches with all supported versions of clang,
> noticing no regressions.


Both applied to linux-kbuild/fixes.

Thanks.




> ---
> Nathan Chancellor (2):
>       um: Fix adding '-no-pie' for clang
>       modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS
>
>  arch/um/Makefile      | 4 +++-
>  scripts/mod/modpost.c | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> ---
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> change-id: 20240118-fix-uml-clang-18-e365b0503a29
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>


--=20
Best Regards
Masahiro Yamada

