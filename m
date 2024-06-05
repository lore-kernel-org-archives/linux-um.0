Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA22EC25B76
	for <linux-um@archiver.kernel.org>; Wed,  5 Jun 2024 17:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eQbNsyJiikEHg1WAvMk51avkm7xFjcGfWfmf/iI4yfE=; b=Tje2fq1glazYiEOgjnGJOto/Jl
	wY3TI8YdCHBXQ/9MhiYHTIGr8R8I0S6W2tSFrLtLe1f1ZVk78hnDeestNhFa/oBMLKBvuXE5q6WSL
	li1/nW1dIs9bgyjvMvoxjPdHoRiIV54SOCCA6qh+LUdFCasrbpDg4VKOzPS8D6No7DAw4+zNncVNe
	UzTtHyti7uv4f1AF3K8CajX1bi1h3mE3xiAAqzCBJ2wgocE4OysAOMDRVL3uRZAxz7C66njCDpJM5
	/s3KxCUfUXw2O2z1Bp8s6NTHBK69Rl7XnsIKIpXC8eahV5dHak76u0gZTqhF58aaxi2aFIQcErFwq
	xukxx1zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEuvT-0000000735M-28Xc;
	Wed, 05 Jun 2024 17:59:55 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEuvQ-0000000734Q-1ZtZ
	for linux-um@lists.infradead.org;
	Wed, 05 Jun 2024 17:59:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 08BDF61A14
	for <linux-um@lists.infradead.org>; Wed,  5 Jun 2024 17:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59504C4AF13
	for <linux-um@lists.infradead.org>; Wed,  5 Jun 2024 17:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717610390;
	bh=yw1xSaxn6SgH1smEJJVuV2PYZu8dfMQrURfJ9oM9Uw4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g0dwlGsgP0RR33Xs1FRfDlQdXQ80HHsGV9fi89xOToyKjifhEB2XNqE2zJ0PKnq1o
	 TTfrY8IGrAinvQzVHqYIh9OC4XrlHB394ar51+IydvSV6VcAUtRfaL1KYkMgWQA+Zi
	 77AlIof90PBZqrHU1JO4UYdiBhC4+AhjhhqWWGWBJysWp++wXIjMiHwvQw/DQSxIc6
	 iotfxeKJBJniLVdy8Mri15mfZ5k9+O+ADb7eHqzy5AgdSsXB5pI2+0CAX2lbhpEiEs
	 RyBCS4EgD24lGQUBNMBpttirmeQw14rrRReRedjyfj7YxhsbPQX/3+ycxEb65sB5y3
	 3VFaGxRpylD6g==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eaa80cb550so1463661fa.0
        for <linux-um@lists.infradead.org>; Wed, 05 Jun 2024 10:59:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVT6T0KcdO7711b5nWs135bQP7udxzsddyTl/63E/pEdvi8Gg9Q6WIWcniC+F4pcjEc1mz89PqHuYmIo0SQ4J/wRCKt1UQkQEtZnjDa
X-Gm-Message-State: AOJu0Yx6SZKZSNNJqbRCD+eNgCtVQt75Q0sZyykEsAzt4NcncW0TXAQX
	vz1xMtCqjHSdRAR1JPkJq6qle1QC7mn/JVTAlSao+pYxCwwJbPNkBCjH7El58ZEAzTc5Y6hHJrb
	y+xl/g+zAi3JaslENqkjc+NhnYyo=
X-Google-Smtp-Source: AGHT+IFwBnLbnAG8I3smJgMOrt7te2f6atLyRhMLLdUqm6LmCqUyYx2JWPcNd6bDR47zihsBK0o3CdEIxKpfBWUbCug=
X-Received: by 2002:a2e:3509:0:b0:2ea:8d54:4530 with SMTP id
 38308e7fff4ca-2eac7a22291mr18413131fa.28.1717610388337; Wed, 05 Jun 2024
 10:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240604224052.3138504-1-davidgow@google.com> <20240605062234.GE279426@thelio-3990X>
In-Reply-To: <20240605062234.GE279426@thelio-3990X>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 5 Jun 2024 19:59:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHa58Zcq3extXw4VXGnpVHbd5urzCGnh_oCo-BLMxMrJQ@mail.gmail.com>
Message-ID: <CAMj1kXHa58Zcq3extXw4VXGnpVHbd5urzCGnh_oCo-BLMxMrJQ@mail.gmail.com>
Subject: Re: [PATCH] arch: um: rust: Add i386 support for Rust
To: Nathan Chancellor <nathan@kernel.org>
Cc: David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, x86@kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_105952_565219_B2AF9352 
X-CRM114-Status: GOOD (  22.71  )
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

On Wed, 5 Jun 2024 at 08:22, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi David,
>
> Just a fly by comment on style, I don't have much to say content :)
>
> On Wed, Jun 05, 2024 at 06:40:50AM +0800, David Gow wrote:
> > At present, Rust in the kernel only supports 64-bit x86, so UML has
> > followed suit. However, it's significantly easier to support 32-bit i386
> > on UML than on bare metal, as UML does not use the -mregparm option
> > (which alters the ABI), which is not yet supported by rustc[1].
> >
> > Add support for CONFIG_RUST on um/i386, by adding a new target config to
> > generate_rust_target, and replacing various checks on CONFIG_X86_64 to
> > also probably like  support CONFIG_X86_32.
> >
> > We still use generate_rust_target, rather than a built-in rustc target,
> > in oPrder to match x86_64, provide a future place for -mregparm, and more
> > easily disable floating point instructions.
> >
> > With these changes, the KUnit tests pass with:
> > kunit.py run --make_options LLVM=1 --kconfig_add CONFIG_RUST=y
> > --kconfig_add CONFIG_64BIT=n --kconfig_add CONFIG_FORTIFY_SOURCE=n
> >
> > An earlier version of these changes was proposed on the Rust-for-Linux
> > github[2].
> >
> > [1]: https://github.com/rust-lang/rust/issues/116972
> > [2]: https://github.com/Rust-for-Linux/linux/pull/966
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> ...
> > -ifdef CONFIG_X86_64
> > +ifneq ($(or $(CONFIG_X86_64),$(CONFIG_X86_32)),)
>
> These configurations are mutually exclusive, so would it look more
> readable to have it be:
>
>
> ifeq ($(CONFIG_X86_32)$(CONFIG_X86_64),y)
>

Or simply

ifdef CONFIG_X86

