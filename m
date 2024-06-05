Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE04C25B76
	for <linux-um@archiver.kernel.org>; Wed,  5 Jun 2024 06:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nJm/hiwq3LyM7HzkaXHiUtUL0ydAgPipUMAjXzNNlms=; b=eIjQl/gXWewswXVD5JNoXj2Ap4
	41ZoyZx2Uv8OU3EtYIDQ3c/8nDoquR4vjqU9RVqOe674foAqH3zMF0sIYnZZsY6FlK7046bhlNYlY
	4/n55C8DSOK4aOwBeVLzFrI0W+iM+pRq/6i9w5BfGtqU7xi7Mq4yAWfuL+u7KIYb48VbWGsELa+rT
	iAJH/sVESj9HwGvvyJKXbWZ+DCIwx3oE9FKCExHH7qUtg4YcAtu7POvDUK+vJ9P2kZUXxWb8mVeJD
	P57uLLmILCpy83s3IwMVeqsUMcex8tCAYMDFm89uAumKAunaXJUkiF/1QB+tdjJy7ypJgBd209XAI
	z9qfrOsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEk2l-00000004lEK-2bXC;
	Wed, 05 Jun 2024 06:22:43 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEk2i-00000004lDL-0pIQ
	for linux-um@lists.infradead.org;
	Wed, 05 Jun 2024 06:22:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 37135CE13BA;
	Wed,  5 Jun 2024 06:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA3CC3277B;
	Wed,  5 Jun 2024 06:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717568557;
	bh=22vGbdo3lcoqgtt6iTgodLgKpeC1H2mmwljTBZUWyNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuiuKYoVXSbCm1Dbvh0V60xcmtNnwomS1+agdGXYtSH5RlrxJbcdXsIy1lqp5wItG
	 JJyN5q3EzSLIvKCXaYZzkbTVItVxMxvBWyqXCcRFhXNDfq7MFeCHslkWNW9Sao3nLj
	 jNn/BbgErH5YpRHQIJ3pAF94KPw8WHbwel+G3StODSKyFX38S4hfpQC6O5crO6uFn8
	 b6xfpTP1idOJvxSjt5esKEXWgS7Hk6s2UujbwBliTpEhdDIoHyLKAaQWyJYJKAFx9E
	 mbEcmRhEGOU/o4xFSZxyQp1k1cqmH7XBpuHaF8vuA25/uRVG0SkaSJOftyk7bgCnxI
	 XFYJoiZO2IcMQ==
Date: Tue, 4 Jun 2024 23:22:34 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, rust-for-linux@vger.kernel.org,
	x86@kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] arch: um: rust: Add i386 support for Rust
Message-ID: <20240605062234.GE279426@thelio-3990X>
References: <20240604224052.3138504-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604224052.3138504-1-davidgow@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_232240_659592_E54D683E 
X-CRM114-Status: GOOD (  17.58  )
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

Hi David,

Just a fly by comment on style, I don't have much to say content :)

On Wed, Jun 05, 2024 at 06:40:50AM +0800, David Gow wrote:
> At present, Rust in the kernel only supports 64-bit x86, so UML has
> followed suit. However, it's significantly easier to support 32-bit i386
> on UML than on bare metal, as UML does not use the -mregparm option
> (which alters the ABI), which is not yet supported by rustc[1].
> 
> Add support for CONFIG_RUST on um/i386, by adding a new target config to
> generate_rust_target, and replacing various checks on CONFIG_X86_64 to
> also probably like  support CONFIG_X86_32.
> 
> We still use generate_rust_target, rather than a built-in rustc target,
> in oPrder to match x86_64, provide a future place for -mregparm, and more
> easily disable floating point instructions.
> 
> With these changes, the KUnit tests pass with:
> kunit.py run --make_options LLVM=1 --kconfig_add CONFIG_RUST=y
> --kconfig_add CONFIG_64BIT=n --kconfig_add CONFIG_FORTIFY_SOURCE=n
> 
> An earlier version of these changes was proposed on the Rust-for-Linux
> github[2].
> 
> [1]: https://github.com/rust-lang/rust/issues/116972
> [2]: https://github.com/Rust-for-Linux/linux/pull/966
> 
> Signed-off-by: David Gow <davidgow@google.com>
...
> -ifdef CONFIG_X86_64
> +ifneq ($(or $(CONFIG_X86_64),$(CONFIG_X86_32)),)

These configurations are mutually exclusive, so would it look more
readable to have it be:


ifeq ($(CONFIG_X86_32)$(CONFIG_X86_64),y)

?

Cheers.
Nathan

