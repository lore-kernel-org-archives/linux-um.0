Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076B2C0219D
	for <linux-um@archiver.kernel.org>; Mon, 10 Feb 2025 11:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7PP3w+vTVYydNJ1RlabO4o815qYqNgmeRSTRCNdNosM=; b=evqY/97Od7xQ1E+e7/Xn0h4iKr
	GtZVpWGq26NproATpZpn00DPG82lQjJr3kAnLNd9c7sgIx4rn0hszeZ5wGnbcbVOQpmt6JkbOVewO
	1elMWwS5wjfc2uRvFoWjulMajFhv3f5fOfOJ4eUZV47UwwrzZObyKL3qDRiqqDvr1+Q63l17G+DSb
	gptztZiOx/Xj0iQETHQom49D+3soYaT9KpmUBXGo0AO+EC5ORfcJ+pm61V5NTzBpB4sysdSIA+h5A
	n2d+SRFGVfGXuISFafaczjEs0HLJACgpBYiWxkdi9eDYSjUV+uhwMsVkPUpfqXPzZ6rlvTbcpz+5/
	EmGgKA2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thRoQ-0000000HBkF-3C6v;
	Mon, 10 Feb 2025 11:18:50 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thRSH-0000000H6bL-0lNW
	for linux-um@lists.infradead.org;
	Mon, 10 Feb 2025 10:56:00 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6dd049b5428so34311336d6.2
        for <linux-um@lists.infradead.org>; Mon, 10 Feb 2025 02:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739184955; x=1739789755; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PP3w+vTVYydNJ1RlabO4o815qYqNgmeRSTRCNdNosM=;
        b=MCR2igv5xE9z2nfEhqShHmrNjeU08taO99IogHW22ivM17+WyqaoSqWVY92S97GWw1
         x//V6bsZgMoNGg25Lr4dAc32ehQ5nhLgcS3A+5VdKtoBaJAfpvelO1+diKc8ZpHMiwZm
         ODFhSrDmylfbItPKxHyu54pp0B0KpsLFCjrOrIXiEEqZPuheh0VFA+uRE+Gg+ret1qJ2
         8weXQ0im3ma2WLdM986n73+bchqhS4SRmfvCXRHoZ3q9FdDIib4KWlm7XkTPNZkvWcKd
         ld8V1B2tRV9aZzik2WlFBnotPCWfXmSjrat96Xn2kzp/rrwGm0w8/dWk4QnUVHTuR3RH
         rM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739184955; x=1739789755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PP3w+vTVYydNJ1RlabO4o815qYqNgmeRSTRCNdNosM=;
        b=jA0RnAuRWX7fEa0Y3o94m3KPJ325t40EaNHx5pUZoV6XriX1lVOtFYh5QCa5sm+z9b
         4L3DZ5NdCBjaVhPlLM1JjyDf8cVIeAG57l2hijUlFgb5nOfKbAS4Zir6en8gifOD2ZZ/
         u1Ci7pdZQYvX+eJCQSsV4ZFLZJvH7JxKQSZgU5P5iMf9Hj5ohbmMH6ja+KVKG4E1PpC7
         1WDX3WJJ3p61R9YrZ7SqwxfeD6kWJUYJFywiO2D3PtuwVwXzqiGBKrQ4riwFACjrJJpj
         ydCxHj+gHxKA0TgqcgNxoXFKRECuihcGUKzLRZYTuWIIUYMo70e+NMWM1uDABIguIJuM
         UYNw==
X-Forwarded-Encrypted: i=1; AJvYcCUK69qEEjZcQQhhvb/nzmNPZiBzptmVNC557/PDW5wcfoCHCXKpIDRTQJOwK/F7CrxWPK0Rso4bfg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxu7NJLW/rMGWjV0nJRJpvHdkzH0wjoV0GiIRQYxW/Q20XMG2K9
	Nq2CfRJfFKrqey7jgIPKwqCQO2cU1rcSuEK4GnT33+N3cG4EvC7j4nfVVk5kiAvgbSjGjCo53+Q
	Jnu6amECS3OTMQ4soGvTg3AXKXtY8FsgYvn1R
X-Gm-Gg: ASbGncvYgtaLviH0hWQvJX2nOuMFb/BjIrN9wTgBSnk5WZqbJN/GqBtNfwyK9mxuzBQ
	esew+wddx9BIvEiVxcexR8xA6BcsDpfkMuvqL12HiQ1bVwH6yNSBBB+n5RqfZwUCaovBQBQoX8w
	==
X-Google-Smtp-Source: AGHT+IGbyeQ6k7fTxoDJJzi7UjIgV6Ed+wDw9pNMs0X4k3lIOqkog+znGoY1veJl/t7QLUdG1EyukBv6t6QGtJ4uJ3I=
X-Received: by 2002:a05:6214:240b:b0:6d8:890c:1f08 with SMTP id
 6a1803df08f44-6e44569d333mr178824946d6.26.1739184955157; Mon, 10 Feb 2025
 02:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20250208-rust-kunit-v1-0-94a026be6d72@weissschuh.net> <20250208-rust-kunit-v1-1-94a026be6d72@weissschuh.net>
In-Reply-To: <20250208-rust-kunit-v1-1-94a026be6d72@weissschuh.net>
From: David Gow <davidgow@google.com>
Date: Mon, 10 Feb 2025 18:55:42 +0800
X-Gm-Features: AWEUYZnLrdE820e1YCxGYIPmD7_zxAEMVcFxHPATm37BvJ0XwCqWLuIDtdgVRBk
Message-ID: <CABVgOSmZEowbLCJepA0bkTHMnt5xhXE5sHoQz2kNhmMo3N9vwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: pass correct target to bindgen on Usermode Linux
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_025557_225903_E3171C98 
X-CRM114-Status: GOOD (  17.68  )
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

On Sat, 8 Feb 2025 at 21:32, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> w=
rote:
>
> Usermode Linux uses "um" as primary architecture name and the underlying
> physical architecture is provided in "SUBARCH".
> Resolve the target architecture flags through that underlying architectur=
e.
> This is the same pattern as used by scripts/Makefile.clang from which
> the bindgen flags are derived.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---

(+cc linux-um, but I assume this will probably go in via the Rust tree, any=
way.)

Thanks very much: this is enough to get Rust-for-Linux working with
gcc under 64-bit UML on my system.

However, this is actually a bit of a coincidence -- and there are
still some issues with 32-bit UML -- as the UML Rust flags are
currently conditionally set if CC_IS_CLANG. This is my fault (it was
to work around some bugs with older gcc), and I've sent a patch[1] to
fix it. (Though note that 32-bit UML/Rust still hits issues with
atomics in the block driver, so you'll need to disable that for now.)

Regardless, this is a significant improvement, thanks!

Reviewed-by: David Gow <davidgow@googl.ecom>

Thanks,
-- David

[1]: https://lore.kernel.org/rust-for-linux/20250210105353.2238769-2-davidg=
ow@google.com/


>  rust/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 8fcfd60447bc89ba2c66a4f341288db2387b0956..a94fafb91d7d743c6c1b22484=
79c0d723964e5c4 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -245,6 +245,7 @@ bindgen_skip_c_flags :=3D -mno-fp-ret-in-387 -mprefer=
red-stack-boundary=3D% \
>  # Derived from `scripts/Makefile.clang`.
>  BINDGEN_TARGET_x86     :=3D x86_64-linux-gnu
>  BINDGEN_TARGET_arm64   :=3D aarch64-linux-gnu
> +BINDGEN_TARGET_um      :=3D $(BINDGEN_TARGET_$(SUBARCH))
>  BINDGEN_TARGET         :=3D $(BINDGEN_TARGET_$(SRCARCH))
>
>  # All warnings are inhibited since GCC builds are very experimental,
>
> --
> 2.48.1
>
>

