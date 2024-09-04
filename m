Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C8ECD3431
	for <linux-um@archiver.kernel.org>; Wed,  4 Sep 2024 08:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mclf5cWZ7doo82bxSJ1tInXWyUxki/hxkifyVYswtWM=; b=SScHBvdL8I3jk01Y/eADDk+CcF
	VoIMbllWtH25k0S7MWtEhXOE9k8GQV+jJ59ayMU+brFYEL3skMDhM66S/vQuv865Si8IDsiyBUsCK
	prIWIX5Jfpv0i1tEMaRf2BAzFfTKIxI8g/qWcwKOb5kl6nhosZKA4MBpjKNkmfjWmki9al2oFNzAM
	LLLlQweZW4FzBFgoAIWCsJNx4R1gqP8TUEnyZaHic/jOZyeuQ6Kd2ajARz3M7C4SDQXLll+d70o1K
	FICnNtQ54dYHtGIUwIBB4hqzwiiCXh6bO+ZtFPkWONoVy27Y2Yyrxq0B6SRAEoFfck+agSd38vZNZ
	kP5WtxlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sll8H-00000003KUF-12ui;
	Wed, 04 Sep 2024 08:12:53 +0000
Received: from mail-yw1-f173.google.com ([209.85.128.173])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sll8E-00000003KTg-0ivA
	for linux-um@lists.infradead.org;
	Wed, 04 Sep 2024 08:12:51 +0000
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6db2a9da800so1109347b3.0
        for <linux-um@lists.infradead.org>; Wed, 04 Sep 2024 01:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725437568; x=1726042368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mclf5cWZ7doo82bxSJ1tInXWyUxki/hxkifyVYswtWM=;
        b=qnVArBDSmXiP4mC2UA+HOyqq1MRkeG6H55uob5EEQGurIREadWhKIFaHjdOKiL+XdJ
         nKrbdy9iQtkUHNYSWrsKIRDKxvFXWbYL/JM9IxhLGIBTcvNJFEcf6XyE2fj5Fp+YAtZ7
         enPZSafECG3iPjtfFnWV+t+uC+b6j47VnedZPBafIgLuVGS1w1ZkLGUkYNLuTfOmT3mp
         /JJGHb+MT+9ar7/80TfkVgW30/6xKvhs5kNqz73UkAZ6yRp1w3zLhyYsQcWMo1Kj5YIQ
         I/XPCmRlovLfrivv66pxe27qiNo5Kn50MmMsqIMzYXBue+r1JRkV7OCK7SZLt28i+pw4
         4yKA==
X-Forwarded-Encrypted: i=1; AJvYcCWo1KUcl2SrM5LMuMsKTzRWtOaL4+4g2jeS63dbfC0k7ALmOy/qFVV1l259EueHpDMCzrMUpvtfHw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzoflPCRZ93IkCQbZOri040eRjTGtZjEmUov+FefFt3AaC9CvEl
	vqemRRwbXjJIbdzZcvpHWCp4uwPRwG7QtOxrUZEB5WZ6d6/zHgl99X/Vs1fb
X-Google-Smtp-Source: AGHT+IHJkWSQJWTRW9Ls24bUgifKLUvCOl9Yu75isjc49X4JTLMazQ2jvZ8jPf/ep+nHLzCvPdm8fg==
X-Received: by 2002:a05:690c:c04:b0:65f:cdb7:46a7 with SMTP id 00721157ae682-6db2600ba38mr8385027b3.22.1725437567891;
        Wed, 04 Sep 2024 01:12:47 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d5ea58d4sm22947797b3.129.2024.09.04.01.12.46
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 01:12:47 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6cdae28014dso3826957b3.1
        for <linux-um@lists.infradead.org>; Wed, 04 Sep 2024 01:12:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaP5zzTScrj79YWu9eKS5SeKuK2BVB4PjVgB/Rmn6df0FscJg8DlPI9wzaQoEBqwS2VFnEecZ9Og==@lists.infradead.org
X-Received: by 2002:a05:690c:680b:b0:664:74cd:5548 with SMTP id
 00721157ae682-6db25f47819mr8680237b3.1.1725437566641; Wed, 04 Sep 2024
 01:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com> <20240903-mips-rust-v1-2-0fdf0b2fd58f@flygoat.com>
In-Reply-To: <20240903-mips-rust-v1-2-0fdf0b2fd58f@flygoat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 4 Sep 2024 10:12:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXC0ZBJibi=60VVG5mW1rwz=VgWxduph7SUxA4uyL5Mvw@mail.gmail.com>
Message-ID: <CAMuHMdXC0ZBJibi=60VVG5mW1rwz=VgWxduph7SUxA4uyL5Mvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: Rename mips_instruction type to workaround
 bindgen issue
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
X-CRM114-CacheID: sfid-20240904_011250_232367_DD384573 
X-CRM114-Status: GOOD (  20.02  )
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

Hi Jiaxun,

Thanks for your patch!

On Tue, Sep 3, 2024 at 7:15=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.com=
> wrote:
> We have a union and a type both named after mips_instruction,
> rust bindgen is not happy with this kind of naming alias.
>
> Given that union mips_instruction is a part of UAPI, the only
> thing we can do is to rename mips_instruction type.
>
> Rename it as mips_insn, which is not conflicting with anything
> and fits the name of header.

Nit: the header is called inst.h, not insn.h.

> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/include/asm/dsemul.h |  2 +-
>  arch/mips/include/asm/inst.h   |  6 +++---

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

