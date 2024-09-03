Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F728CD37AA
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 18:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iCRq6ERVuiYfqPwMIYcT8lbPZnFxke33M5BuFbK5HIg=; b=OMP7XgIJeW0GDjb9q5Bqf4aeR/
	SoaU4Q8RamOz0x9UjGAnHXUD731s/F8cgtUc1ZAVYcQ/Jnib11lLFEsv2nrbhWylimX+yDojGBnws
	ElMlBLSbZS6Actwl4t8HSac8dTsJJ3HxwDfdeooRxVhorGa9jwfr7toNkQ2yT24rqLwB8/SmFp5h3
	MmTDr8cP2qwahTO5mbysdWAp2R6hioqBMWgsqdGXvL3DYvUIpXOk9iVnMoyHVKaceFi3SVWIki6uV
	Rgdwo8PZ5RtRD4Ms4M2tbS1fNqXNMrWgKbdSX3vfEVP2s5+Ba/i5H0pf7tJ9mTmBBvEiPdLvqAQKw
	eMpOolvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slY5h-00000001Qx3-1RGH;
	Tue, 03 Sep 2024 18:17:21 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slY5e-00000001QwJ-1oOh
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 18:17:20 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2d877d937efso290024a91.3
        for <linux-um@lists.infradead.org>; Tue, 03 Sep 2024 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725387437; x=1725992237; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCRq6ERVuiYfqPwMIYcT8lbPZnFxke33M5BuFbK5HIg=;
        b=U+lOBSOUECeru4VCNj60vtRk9e7Siy/dZS09C0bdfvjXixcRs5q7brCBy64OKiY3vP
         ikq5cP/f9urqNhiHYE9Jq4c3IMN01HRF+ObjF/+X+VNMtLBMtBha2Rh/NNFj4y2mYLfj
         Q2mRAP/Nrs+yyt6PEFNQpZZP/LPHCOhNpLsFTafRduP22obRKGOzevoFdxuFGGLub56p
         08DfCvyufxZ8eFTWKfUqDKfmTtLPOtCOP5ZMtLgPrmddOxStrzFiVs+6aJd0lTe+4I2u
         MG8t7jkkV1HeKnkj+TkzYs+sbuinNr/Dxs14OoBZywFX80wWUlH6aqrVZLH6/jVxNstL
         rg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725387437; x=1725992237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCRq6ERVuiYfqPwMIYcT8lbPZnFxke33M5BuFbK5HIg=;
        b=XQfkeFK7IHV1lpMh7k3XoJ7hOuYTA5w648WLjPnfCOyprT27dwHXO7G9dxOnqQZgQu
         SquHfXjo5FDdJBufGmyfhRoQvTysgqpK7nbooVAxoyowYBqKc1VSE4m3tnDG1geDfb4A
         RmKwRBRHV7iuzaV1WqYyoju0EttlKpnMKUysOwzTP8nhmE7NbmHDBzpXZjcvyaoFJLBl
         KEdnxJqihKqVrCYJyrB2epiSCXk2kmL9HvugZfliKMgD9Xn5EqeHKZCO+fL4PfykGUSz
         zhnXJbf4CW8CyBg+tsjSHdInPXc1fPoEruf3C8iN62Lo7OJU4vdITZTiUHTRpsS++GTk
         glRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+yOscQeNaoCCtij0GZ+yoTp/k1b80Cl8EvmVcL4Fm40zMCGW5z4NHCR4bfZUxo2gZCBBSRdFMUA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyOMVA1NZQ1jWzCwt/w53P9D9QL5TJVmDEKvXE9H7dJsEP3L7NJ
	fOpO8sBEQb6C3xoyRkq0TM+ivdzNletG1UywpRmiHrd+X5SqBqnH0Rrcm8qmaLcrnHrEaNxeynd
	prAx50iYfRnMeDRu2odAHCPYaBuI=
X-Google-Smtp-Source: AGHT+IG32aDLtHKi6AhxBeXK5jquJ2AWi/0PseceBjRwkozuKShq4rru0SzsbIiSg4LmaHN2BLYJYbySTLJ6lDehrcs=
X-Received: by 2002:a17:90a:ee8f:b0:2da:5aa5:5d5b with SMTP id
 98e67ed59e1d1-2da5aa560f4mr2043322a91.3.1725387436834; Tue, 03 Sep 2024
 11:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com>
 <20240903-mips-rust-v1-3-0fdf0b2fd58f@flygoat.com> <CANiq72=z1yJm-B_ie=GfueOF1qksaSD9txgFU1YQo2tZx0qQPg@mail.gmail.com>
 <d9591a84-9a0f-4046-9b2a-437061f6882b@app.fastmail.com>
In-Reply-To: <d9591a84-9a0f-4046-9b2a-437061f6882b@app.fastmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Sep 2024 20:17:04 +0200
Message-ID: <CANiq72m5iFcqRU_qdUCZkoV8ayPhtQQq3TTEDRUYfMEsnNqTDg@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: Enable for MIPS
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
	rust-for-linux@vger.kernel.org, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_111718_494823_19F8F2F2 
X-CRM114-Status: GOOD (  15.65  )
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

On Tue, Sep 3, 2024 at 7:53=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.com=
> wrote:
>
> Thanks for your review!

You're welcome!

> Triples defined for MIPS bare-metal target is surprisingly lacking, we do=
 have
> little-endian 32-bit bare-metal target mipsel-unknown-none but big-endian=
 and
> 64 bit variants are missing.

Hmm... Sorry if this may be too naive, since I have no expertise on
MIPS, but I see some triples that match the LLVM ones you specify in
the patch:

    rustc --print target-list | grep mips

> Also, those triples all assumed +mips32r2 as baseline ISA, but kernel act=
ually needs
> some other ISA variant features.

I guess you mean you are getting the warning about the
unknown/unstable feature passed to the backend? i.e. `rustc` knows
about those LLVM ones and forwards them when enabled via
`-Ctarget-feature` (with a warning):

    rustc --target mips64-unknown-linux-gnuabi64 --print target-features

So they would need to be added to the list at [1] (or targeted flags create=
d).

Until those do not emit a warning, it is fine using the `target.json`,
but I wanted to understand if there is something else you may need,
since we will need to eventually avoid the `target.json`, so it is
best asking upstream as soon as possible.

Thanks!

[1] https://github.com/rust-lang/rust/blob/d6c8169c186ab16a3404cd0d08666740=
18e8a19e/compiler/rustc_target/src/target_features.rs#L368

Cheers,
Miguel

