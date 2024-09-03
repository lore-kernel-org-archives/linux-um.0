Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F59CD37AA
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fy49/AVvXvkuJP3eSVDqTTRc5F7gppOTJPxMN+eltxo=; b=EfMRiZZPja+lAc2yUoYnaO34z0
	S6lQB7R/MVIHj3/BDs72AbFkGwa2AhEgVaMRzHwSqXkloJydJFOJcxZl5+o1sgkqC1aBFVr+xHaT8
	gjE7+TBwdeD6zEp3PaYqtE4aHCftbUE6QPyMR8Dr1oDDyaQ9sYxBBruvdcIkdUAcQ6IYOcbwArJ4r
	H7SePMn1tA1/EUcoYKBsY6Zpnbq7Bq89KeUVskAJoSpvMiw+kNMu7tsz8K74wFol7GuqlKHUOnYkt
	AxGLuRECQb7rMMdzWPWnFbAJrlWQmGAOl4Pp2vv7L5zGyGUYevgShqD/g+gMijOt0MFfoP/m7gCiZ
	Q2EjboSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXZ2-00000001L1J-1Y8F;
	Tue, 03 Sep 2024 17:43:36 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXYz-00000001L0m-3IXC
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 17:43:35 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2d87182874fso147830a91.3
        for <linux-um@lists.infradead.org>; Tue, 03 Sep 2024 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725385412; x=1725990212; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fy49/AVvXvkuJP3eSVDqTTRc5F7gppOTJPxMN+eltxo=;
        b=YOzAKXczCvDargFURJjlRSibIOqB/A/0/k++WSwbhkyEbTH5FYfUNlizFl6ZATzB1N
         Y43t6i3WKEbb2Qh6U7BGtOQcdR1bYNr59v8luFcWIfC1zXeZVALqgztQt36sg9Mku9BY
         fBA2U8Ulqh5zb0rM01d3m7Sy9sLxWxiHXBkifMNCWfgKH2raO/Aom1/EeO0RPYsOv4QF
         S2LRr/nn6821JhRqqOvz1hHmjkgbMdox3JsWTwmQqEpdN530E+qhMixRMvYXddyauecc
         YPoKnDDts4couQ47QwRu3Js5B5xaJksS6Ya+oNlGlgnF+D6DkOC1NLF4FWKXEVcTUXyu
         GRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725385412; x=1725990212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fy49/AVvXvkuJP3eSVDqTTRc5F7gppOTJPxMN+eltxo=;
        b=KxhNtjB02GxuF0e2Qr6Jq2c1+lvCTsy8MBB/9nnvZTDQvvIc75j7GS4zL76qcthUVq
         4aSSzaYMPkgJP29F52Qjxxq8I/9ZJt4QHPs0sV6oI9p4G0zYDXKWUeRMUC56Z/pvYy6R
         3KA25/GRCv/qnnqv0iWzIssidtV/K51du0froqm+O9zsrtV7jKzK1400DhTvNzLZklKD
         wAE3td3B1l/W6obcLk/VXhYQBM5dWY7Npm/HbVBaKJkMiqbrv0oRdSa3rMVdn2JSuXfw
         zxSq5a8BFHxZzXde+Ll+PhRFAXuqoAoBU7vlGj3TJgB1BAG8i1uHK8KlNxpqYzscbdFa
         xPRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1bY5I5iJkN6DD99XvJLrEBP99GSdqflw2i6VhoIOShqPJDcpovuSY2qaFMpJmt2v+iHr/QdzMww==@lists.infradead.org
X-Gm-Message-State: AOJu0YynEg8OdaCuKC72XenYa1R1UIlBBSxx66ERERjzvoBtBzo2KlXV
	iRPnuy6RUat/uvOL/ZR2BC6KUeYgD/iSMPssg9X7cqbW6aQg6KrQsUwoWjHq2Es/0ESix2tirgJ
	fnydyZrJNlKprLE90+gAV5ldT9tc=
X-Google-Smtp-Source: AGHT+IEqKH0OWriiC8wInpcf2ZECoytsMPUwBDofLFkYfPN9ogN181tpD7iUm1gfTEwa1l2o3VI73EHRfYV1D0wWJPU=
X-Received: by 2002:a17:90a:ba93:b0:2d8:ca39:5972 with SMTP id
 98e67ed59e1d1-2d8ca3991a8mr4648735a91.1.1725385412437; Tue, 03 Sep 2024
 10:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com> <20240903-mips-rust-v1-1-0fdf0b2fd58f@flygoat.com>
In-Reply-To: <20240903-mips-rust-v1-1-0fdf0b2fd58f@flygoat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Sep 2024 19:43:19 +0200
Message-ID: <CANiq72kx+aJXJCGPv6PazCQ7BnSDN56WyVFj=6e0FNRYqunSfw@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: Introduce HAVE_GENERATE_RUST_TARGET config option
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_104333_848272_EB182A3A 
X-CRM114-Status: GOOD (  11.66  )
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

On Tue, Sep 3, 2024 at 7:15=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.com=
> wrote:
>
> +

Spurious line?

> +config HAVE_GENERATE_RUST_TARGET
> +       bool
> +       depends on HAVE_RUST
> +       help
> +         This symbol should be selected by an architecture if it
> +         supports generating Rust target files with
> +         scripts/generate_rust_target.rs.

It should be more like "if it needs" rather than "if it supports",
i.e. the `target.json` is something that should be avoided if
possible, since the goal is to avoid depending on it in the future.

Cheers,
Miguel

