Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614D6C25B74
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 17:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JSxUji88N/0NxFl9gX5AHTL6yyOqY2Ahz7gjZDA3w2s=; b=JEmJfkOzZ6wnOiQkiotV2jd4aj
	2jvQqIYXMydJA+3PG/mzL0ogRZZm02bkwJa/ttVomEsGPc3fMTwS1BXqDX49du0MfNmcNztIAkGx8
	CVA8mgEl4lSu3ziQaJEpxQZ2EHpS91359JNdLRUDYimIjW8t9+qfv/IxD/GCOhnEsKZDqnL7V54rm
	11E9qiO1edZatFtiRixdwcSM3OuyGIo8sk4XLL9SfhVSAthePsfkkEubD12SFlqmaDceHJWeic4lx
	EDxzHuJEWp/y7ib7bTeJ3n/hVyGWllP/YZDox4oZF6GLaeuXInL9bcZjeHohRo8iG7WDTpivZOIQW
	c67Q015A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCj94-00000007vNf-06tZ;
	Thu, 30 May 2024 17:00:54 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCj91-00000007vNA-1Sj9
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 17:00:52 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-794ab1bafedso74213585a.3
        for <linux-um@lists.infradead.org>; Thu, 30 May 2024 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717088448; x=1717693248; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSxUji88N/0NxFl9gX5AHTL6yyOqY2Ahz7gjZDA3w2s=;
        b=ZxVDJdIOPD0Qz+A8JCskvNPhL8GutjmhdQhCqqud88itSPgV/hwAclrBQ9K5Gdg9w4
         GAO7clYW/zevFgBmCZ7nx+IXKkKIqRbX1gwTumU7xJ0c+aZV8PkoKSFGu3+h+u4rU3QZ
         Lco/zD6rnPJPJ866ImiX9hM9yTEImKHaA9O4N1tvqX0wQDWiED40jAYUQHHMrTtTGeyO
         /gQaf4FxBWDBPyfjfQHEqUNzr5LxFFpBzi3aogw/hJGqQkrakfw+PsfZC2iNCoYK6a43
         rv0q33CVQGfuieXqKYPiFe9qeok6uN25uNwTKIXmxOxHmdcpza7Ew9rxkrLJBnaB8AP0
         qjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717088448; x=1717693248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSxUji88N/0NxFl9gX5AHTL6yyOqY2Ahz7gjZDA3w2s=;
        b=lpmPg/pqehbHXNjdf6EQm+7g8luETP1QKyN00r658OS4RxEXca9u8AS00JA0l2UCtG
         7vvBTiL66/i072cv9GOC7Y8r7FUGFkHfLaB+DM6JLAlU6QvpZ+5IgCgFaJ59aRvhui0M
         7zCTzaj4VbTgfsve9A64TgLt8+HDhpTyEKk8TtNyTrZrPe1tRYflrkdNUlTtsNIyu6w5
         LmyVLnokj+S2htPJCTmvSmRok1K3cXwqfaysyigOpvFsRNFf/JHJ/typae3Rl6YoYWZD
         l/cCqux/yj7l0S4BCHgTvly0TYbOwkqkb7yjKm/cmELeE5qAWDeyq7KF8NHKmuetMtOZ
         ZVtA==
X-Forwarded-Encrypted: i=1; AJvYcCVo809NC8CsG7TTAiN4FqkJTXxhLI9HV9zjfm5xJa/Nm65JyvgdFPw13xFtfdBGAl1r+Q2QNoF+LfN16I9bzwpnMAddqgxRJEsbBeju
X-Gm-Message-State: AOJu0Yw9+o7NnQeJJqYNpLnH/Rtnjsl8Sh3J2PQzWiO4Nn8ai3uYBfCL
	CQrMitjPxtbWMQ7CtFMS3mK6h3pbgvwQdqXfiqxiSeUjbAf8uiEA
X-Google-Smtp-Source: AGHT+IHwxOQVjX4jjMP5xINeb0ZRE7/H4u3Ev9hJuE7HJA0tJskyy/XS+vI2s8I6LF4ZaPYlPA+CLw==
X-Received: by 2002:a05:620a:210b:b0:794:99f3:d407 with SMTP id af79cd13be357-794e9da1730mr288097885a.19.1717088448277;
        Thu, 30 May 2024 10:00:48 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcd9673sm560623285a.55.2024.05.30.10.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 10:00:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E8A291200082;
	Thu, 30 May 2024 13:00:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 30 May 2024 13:00:46 -0400
X-ME-Sender: <xms:vrBYZp5KRn6Yokrmm4wUm8MbLiDC2d2vDB34oYRw-8gseOQ-u3xAQw>
    <xme:vrBYZm7VlQBIPFw_6yc8qpiFkcBDzved8K32D9x63EutaKeI3SV53a2ru7JVcWPRS
    Qe90z7fLTHh4s4gWQ>
X-ME-Received: <xmr:vrBYZgcMVfpUQ74zHxzzVgKZM5QMp_1mromfpYUDowwJWgwduOi7lGPKTTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:vrBYZiLVW2wH-IWwI4iJ3qIkVixnuJ33bEe0hbyC6OgmmnlXqQtFRg>
    <xmx:vrBYZtIPMtjYzViOTIKer1KuHoFXaKwa2EhHxeOsYUmVsp0CfdAUiA>
    <xmx:vrBYZrwEBjqOnwSGWM4O6vcH6zacpSfL_OXiVkmSfgoCmhqiN0bH1g>
    <xmx:vrBYZpJ9vvRL5BtBH6BEIfilMhuVETT94Lq5OSKBS05-3znEN6hjfQ>
    <xmx:vrBYZgZwNcEGSZh2yW_WcnB51C1Fb65gEeMQqO0a7KBH9hLGayeOq1Ye>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 13:00:45 -0400 (EDT)
Date: Thu, 30 May 2024 10:00:00 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, rust-for-linux@vger.kernel.org,
	x86@kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH] arch: um: rust: Use the generated target.json again
Message-ID: <ZliwkPY-psgVNhZY@boqun-archlinux>
References: <20240529093336.4075206-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529093336.4075206-1-davidgow@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_100051_414155_1EA182CF 
X-CRM114-Status: GOOD (  20.27  )
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

On Wed, May 29, 2024 at 05:33:35PM +0800, David Gow wrote:
> The Rust compiler can take a target config from 'target.json', which is
> generated by scripts/generate_rust_target.rs. It used to be that all
> Linux architectures used this to generate a target.json, but now
> architectures must opt-in to this, or they will default to the Rust
> compiler's built-in target definition.
> 
> This is mostly okay for (64-bit) x86 and UML, except that it can
> generate SSE instructions, which we can't use in the kernel. So
> re-instate the custom target.json, which disables SSE (and generally
> enables the 'soft-float' feature). This fixes the following compile
> error:
> 
> error: <unknown>:0:0: in function _RNvMNtCs5QSdWC790r4_4core3f32f7next_up float (float): SSE register return with SSE disabled
> 
> Fixes: f82811e22b48 ("rust: Refactor the build target to allow the use of builtin targets")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  arch/x86/Makefile.um | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
> index 2106a2bd152b..a46b1397ad01 100644
> --- a/arch/x86/Makefile.um
> +++ b/arch/x86/Makefile.um
> @@ -9,6 +9,7 @@ core-y += arch/x86/crypto/
>  #
>  ifeq ($(CONFIG_CC_IS_CLANG),y)
>  KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
> +KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
>  KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
>  endif
>  
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 

