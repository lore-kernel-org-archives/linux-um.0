Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070D4C46CD2
	for <linux-um@archiver.kernel.org>; Sat, 27 Jan 2024 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H1JFQuW7EupHOnFVPOKBJiDh0b1TZN/s6jsrNot8dxU=; b=2mI7Vznft2DNifSpFW9VxMDUaf
	5QSdq9RjgN9WFC9qQvpJOOEKP/7FHXA+omKZqF6AcRlqMiyVYBBUluqyz7mwOFVzXPfTYklJE68B5
	YVp+gO3nOuTkxWK1nROdi/dljhB9VuQxfPVEP51wkprqT8qFU07rXFS2W7GCyxyYPjM20GyY7TWKo
	1GKw4viTyWZuDOgOEbjQvU13guHk4329PT1BYufQ+OtfBZ6Y+kVLL7fiStO+M4HF8NbiuWnGHXNRB
	1/UjXBIHWcMN4W/qRmHsmqYH6rOSjnWcAjHv/XxrSorD65IJhGxpS8Ei9HwJXPX5oK8/u5GLrIfbt
	zyOJoILg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTkwY-00000007hi6-0pOS;
	Sat, 27 Jan 2024 15:50:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTkwV-00000007hhf-3ULw
	for linux-um@lists.infradead.org;
	Sat, 27 Jan 2024 15:50:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A9E7C6108C
	for <linux-um@lists.infradead.org>; Sat, 27 Jan 2024 15:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A26C43390
	for <linux-um@lists.infradead.org>; Sat, 27 Jan 2024 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706370602;
	bh=xMum1nfS4Zw0xeihyEQn0dWh29rgau+LhppkJ/8YUbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d/djCDMNQTvN99njEZJfMV+GQJck3sqJIB5bHMhAmH04k+W+AV3NKVZ0UBUg16qtf
	 9i3EmWQWwr4Oza332PQLzoAWfA671swctuiq+SVz58JOZ+6sjpWr1UMRVorjnt8t1z
	 eELiPvi7w9PXHRjwiKU0ddy5c9TOn8fiWCS/f9a4IRufWhRNZZfN//05APyRUP8wa4
	 vDkXHdnA0X05xIDcPgGU6lehHN3HK+rVADqF9NaKj1vshWO1vf8zat+JYMnmkgtUOP
	 TonIhpn4i0KsR7JaUZq93JUBkgQNze5haPFDtkdbCWkf125m6TlSqQzERpUft5MmcF
	 Z5oDLHuBsNyOQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-206689895bfso894928fac.1
        for <linux-um@lists.infradead.org>; Sat, 27 Jan 2024 07:50:02 -0800 (PST)
X-Gm-Message-State: AOJu0YwvYJ+dyb/51WEs5W9sQIowaLQBOur8qMLLFmSvpOOLiOJYz5Q9
	AfAmr0153a1Fu6i0BXix3Eu1BrcJlClPSZfF5Djo0BibD0qGycx5fMcycXavW6kQJp3DXFY2fPh
	pRte6YA0bcwKft936KJb497N+kfQ=
X-Google-Smtp-Source: AGHT+IFDy5SBpxGVQFs+UrOt0sr31INoe6WBxhB+4rEP6q675XfByIgB8DlqySVkP1CSlylWjc+vunEaHrVRYvYBUow=
X-Received: by 2002:a05:6870:d208:b0:206:8e1b:3948 with SMTP id
 g8-20020a056870d20800b002068e1b3948mr1044837oac.25.1706370601678; Sat, 27 Jan
 2024 07:50:01 -0800 (PST)
MIME-Version: 1.0
References: <20240123-fix-uml-clang-18-v1-0-efc095519cf9@kernel.org> <20240123-fix-uml-clang-18-v1-2-efc095519cf9@kernel.org>
In-Reply-To: <20240123-fix-uml-clang-18-v1-2-efc095519cf9@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 28 Jan 2024 00:49:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWAXwcHtzsW1vex6kuL7Jf+M2HiBhTGhHYfKnAoMqvPA@mail.gmail.com>
Message-ID: <CAK7LNASWAXwcHtzsW1vex6kuL7Jf+M2HiBhTGhHYfKnAoMqvPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS
To: Nathan Chancellor <nathan@kernel.org>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	nicolas@fjasle.eu, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, linux-um@lists.infradead.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_075003_982553_D79A9E96 
X-CRM114-Status: GOOD (  21.23  )
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
> After the linked LLVM change, building ARCH=3Dum defconfig results in a
> segmentation fault in modpost.

Yeah, this is a mistake in my commits.
The NULL pointer access should be fixed, but that is a separate issue.

Anyway, I applied this patch.



> Prior to commit a23e7584ecf3 ("modpost:
> unify 'sym' and 'to' in default_mismatch_handler()"), there was a
> warning:
>
>   WARNING: modpost: vmlinux.o(__ex_table+0x88): Section mismatch in refer=
ence to the .ltext:(unknown)
>   WARNING: modpost: The relocation at __ex_table+0x88 references
>   section ".ltext" which is not in the list of
>   authorized sections.  If you're adding a new section
>   and/or if this reference is valid, add ".ltext" to the
>   list of authorized sections to jump to on fault.
>   This can be achieved by adding ".ltext" to
>   OTHER_TEXT_SECTIONS in scripts/mod/modpost.c.
>
> The linked LLVM change moves global objects to the '.ltext' (and
> '.ltext.*' with '-ffunction-sections') sections with '-mcmodel=3Dlarge',
> which ARCH=3Dum uses. These sections should be handled just as '.text'
> and '.text.*' are, so add them to TEXT_SECTIONS.
>
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1981
> Link: https://github.com/llvm/llvm-project/commit/4bf8a688956a759b7b6b8d9=
4f42d25c13c7af130
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  scripts/mod/modpost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index cb6406f485a9..f7c4d3fe4381 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -807,7 +807,8 @@ static void check_section(const char *modname, struct=
 elf_info *elf,
>
>  #define DATA_SECTIONS ".data", ".data.rel"
>  #define TEXT_SECTIONS ".text", ".text.*", ".sched.text", \
> -               ".kprobes.text", ".cpuidle.text", ".noinstr.text"
> +               ".kprobes.text", ".cpuidle.text", ".noinstr.text", \
> +               ".ltext", ".ltext.*"
>  #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text",=
 \
>                 ".fixup", ".entry.text", ".exception.text", \
>                 ".coldtext", ".softirqentry.text"
>
> --
> 2.43.0
>


--=20
Best Regards
Masahiro Yamada

