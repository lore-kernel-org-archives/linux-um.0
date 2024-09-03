Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D30FCD37AB
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 17:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0DofYcV1Ki+ENSwTIpZw+asSjmZojx2JbABHePOoO20=; b=rGECCu2B9nSen3XSjURCQZMZdt
	7H84NTzW7i5DXc/x3KvigNzZ1VxKaJf54MtekLGumkmCQZgAH4qROsGUaURoD51XCpOus+OoCbVit
	MwRA2ndu9UeygWwdYCUoqPoqz4J9xzYs0VxSmcJuAbQHNc3d0tN9ZEl8gK4oQruIxXrWKsgAAXloM
	zvLuum6tWxP7jZ+nNmrXFybV9eY4UjH4kKgHl2zrEq1jedp/IIVv1pOetSFE9TSytK+A3Kj31W1dA
	1x1WXEZCyLL3GTkGWykyLk2LWacb8p0Didy0sAnXlc21u6d8Z/hoJdSEDqMfzatUrsebphBQOdstu
	owyB8jQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXc0-00000001Lxw-0MN6;
	Tue, 03 Sep 2024 17:46:40 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slXay-00000001LSI-0eLV
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 17:45:37 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2d871bd95ffso387042a91.2
        for <linux-um@lists.infradead.org>; Tue, 03 Sep 2024 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725385535; x=1725990335; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DofYcV1Ki+ENSwTIpZw+asSjmZojx2JbABHePOoO20=;
        b=WaqVwoRMTQiFzJJLYV+kcdWPmTd04uJ3Oj3xjsgFTAKgz1tAcr4/50sr3zXdFmkLmh
         N/dYN+RYvjTzGroydADo2HxxQJnlJuE65ef37uRRr575BvszTWG87mNajLyj8no8Vy5P
         W6xXmuU7/2v+0EPUpnpl7xBvs3dG7qF5JY1Fbb8ZDnf1v2T55HtuGiMI5QmInRZlwB83
         ycmpWMqmD3S0gkSadXFjuG7M+njvJOOE0FABzt01dvkFp4iiPkpFgwTm2sG3FlFBB6rh
         pSyyfGnRhXzr1mnGSLo3O3OskUhI+uY3wu7f6B3y+WtrHy7170CY2mBFCkObBj6UdDck
         mJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725385535; x=1725990335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DofYcV1Ki+ENSwTIpZw+asSjmZojx2JbABHePOoO20=;
        b=Y/SHZH7ZZGdUeH/PB3b/4xeI/wZ9KjSswGtMJEBn6ad3fyrPTYN7gmInSXr/UUD/Ow
         rnAh3jQDpgMClrTkWrNcdS3xSYrIFB6eJdPOe5MA/OFdg0qFt+3YXKersTQVM2PpcX1o
         X+cnhrpz0RNVPmm9/8J+OFlNqkYu5hGNXiwBX/m9rvDLBTKO9vPTlK4DjWUQ8UWQ+I9e
         Y9GVdHsC1zf0ySwaCwJ//o6j2fe6ieJFkbek3MFpgR6eOKfubjQyMbHsg8pxwXDkpnQj
         3gd62+iQqAKpK2xD708HJ7jbrcO68yBSuuZvqIGIYynnpOh9d+hsvg6jtoGRvSUPo6ve
         D89Q==
X-Forwarded-Encrypted: i=1; AJvYcCW927EaLKl/HPsoTAwiamRMNzcPVdLANjR9ygSx3sDPSyDBAHNYadUNig1ZUzDM8d0M8DhXgGZdyQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxgS9SkG3pGc64spdrIKPx+QetW9+Wq7/ICSHL4XBTJKZydy+uG
	spoU2PoktqqAdRdXn7XNn/+5Oj9R6gVlFMQSjpnWst8SEro7WVlsJ2rdwTYDkXjjPRN+twN8fAl
	6XkZgiaBzcPRXGhZrHCQ+hNbtegI=
X-Google-Smtp-Source: AGHT+IGSJaGwOM9WSS6C4CfJ5n+iQPEV9+ern3LlVZwrkMxCoO8ICwpxdMLXqIAiQmi7uSiY7KxVOTk+pY+MMkXUU6k=
X-Received: by 2002:a17:90b:207:b0:2d8:792e:9b22 with SMTP id
 98e67ed59e1d1-2d8792e9cc0mr7985254a91.0.1725385535089; Tue, 03 Sep 2024
 10:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com>
In-Reply-To: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Sep 2024 19:45:22 +0200
Message-ID: <CANiq72nG-7Zbd11S=VkMdhpSON8vJOpDe4qhGy3czrKgrJ0DXA@mail.gmail.com>
Subject: Re: [PATCH 0/3] rust: Initial MIPS support
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
X-CRM114-CacheID: sfid-20240903_104536_217411_5EDA62D3 
X-CRM114-Status: GOOD (  10.78  )
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

On Tue, Sep 3, 2024 at 7:14=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.com=
> wrote:
>
> This series added MIPS arch support to rust for linux,
> hopefully MIPS is not too late to the party :-)

Definitely not late :)

> Sample rust module tested on R4000(el),mips32,mips32r2el,mips64,
> mips64r2el,mips64r6el.

That is great, thanks for this!

Cheers,
Miguel

