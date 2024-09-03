Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2F8CD37AA
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 17:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gi+yu/z+/Fjxnn4wuJ/sFP88katAdvUnvWOv4IPfnOI=; b=427hDHAtxv1rQFCm6HGuiPd9aY
	6sg8oUBXHy6V/hlCi73jDt49F/Dmmgih+VnkewksAFjH8TORWxma1Oq933QTZAGmybHwecEJg9wEG
	/i1T/Rma0guJ7Jl+hv7hQwnsgwH1WxknkcIsiMqqXjsGtvJUu0Po9GMyYVyuyCJ2wKYFqb6fAUCkl
	JD0J5/oCqj54MR37NXbJLS+QYvhJ724XXA1NC872NL3dRhXz27TtE1yVZ2Kq6yk2FXNjnRa6L4pMw
	+iGR70Y6pTRGYDCwGjIkopHLbK4Qj0CYl951wq+i5vJNg8e6BiJ4Pk4ReDqQTZZdEVbwXtQebLji1
	7Cwk92fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXZT-00000001L8B-2iOV;
	Tue, 03 Sep 2024 17:44:03 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXZP-00000001L76-3bSl
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 17:44:01 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-71447da79e1so308366b3a.0
        for <linux-um@lists.infradead.org>; Tue, 03 Sep 2024 10:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725385439; x=1725990239; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gi+yu/z+/Fjxnn4wuJ/sFP88katAdvUnvWOv4IPfnOI=;
        b=OgNYQ3tB/I8C24lQCllKl+6ZoifQ9r7Tm9Upkefmw8QEfLDcbAoUigBs+Ah34r7LEA
         zires32hYA1BvhZU+eSpk5W5utOfYo+G3KzR/gURtGCLPywnaXYxjUDQEGIT91erCj3T
         uVk1ZOfxRp7Koyjh5ISnYgoCHsLsD8RiBPw0ANsuFaf/lrQ5JSMqo53IHR5BsUt5C1tu
         4OHp13ZEapnLE4BAaLvfPZqaX4ph+v8E+56RYk3S6JJHhROM69hswAQ0yk6x2d3Cd3d3
         E5gchHgcsCTh150+3zlia791zRdVtLm/VQL4k3WgMn8bqoPblNH+fe8SptNtHke3qTG7
         20Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725385439; x=1725990239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gi+yu/z+/Fjxnn4wuJ/sFP88katAdvUnvWOv4IPfnOI=;
        b=ZREzB8mIMkXmUBlhYOiVSeiCpWslEAqmCT0FKaug3x05Mou5RVlgyOcRxqpU2LVi8x
         3oKXlIsnWlDBawtylnuR0vVndr+Vkx7souJkm8F2jvNw5YlwAUcqGKs4Rp5JhTr41qGG
         dHzxGl4r2DAIIWSpSrk2U8EI5oDUH3L5pbwdMA/tg3NnfC8Sq8q8mR33rFr3KbFI3cS0
         EV6CMPtw4Vzyg/XveeTzk4QNKQOgkp4XGPTIsxCtI00wmdkfxcBR1zLAofdH9MdI8+1t
         u6S28vB+Vqg+r8e8/L0tpLCxqUdmASEXBPuZBZ9xAZgq9CFAgtqQ+FJPRWAYa/VVc/cf
         wdfw==
X-Forwarded-Encrypted: i=1; AJvYcCUGTamt6E7OUgzgfx1vbXyZQ0LtWGbRvhjHbdql7GzcurCCXO5ZhQbqUtzyVGxG0tLrq6uvS0gBcw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9C5vHqBjh7HCzRfcUWgMWcqFyRnQgU4P+SUmDg2r4ZhPGqRcg
	39NWGOCWur3DtlNQXTMSOlP7uAmxrIluOqiRPrEicwQF9KdGkYE/QeXLNWYFxoR/AIXJ9ZUyEDs
	NDNKmudb3uqrPJYiNZ3owKy8P7jk=
X-Google-Smtp-Source: AGHT+IGOit+pKE1XEmbe1GmHAZjGSQFBSI/2mJn7mS7tx95JcJrV9hAXdxD2z8nbCI3vzg90VuXd/BAf95vimO+HTSw=
X-Received: by 2002:a05:6a20:c513:b0:1ce:f7fe:83ba with SMTP id
 adf61e73a8af0-1cef7fe848cmr1647514637.4.1725385438739; Tue, 03 Sep 2024
 10:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com> <20240903-mips-rust-v1-2-0fdf0b2fd58f@flygoat.com>
In-Reply-To: <20240903-mips-rust-v1-2-0fdf0b2fd58f@flygoat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Sep 2024 19:43:46 +0200
Message-ID: <CANiq72mKZukJ+V_fXtvfBxN-WVBBOr1pZJ3iKrWgagTrJC4pdg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240903_104359_920257_3AAAD181 
X-CRM114-Status: GOOD (  10.87  )
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
> We have a union and a type both named after mips_instruction,
> rust bindgen is not happy with this kind of naming alias.

For this sort of thing, you may be able to add it to the block list at
`rust/bindgen_parameters`, so that you don't need to change any C
code.

I hope that helps!

Cheers,
Miguel

