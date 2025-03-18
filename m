Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C897C282EC
	for <linux-um@archiver.kernel.org>; Tue, 18 Mar 2025 10:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NgqBeCgacXz6i48arteRrLxAM0fCi4tfMNMBJPzxya8=; b=iqwxnV8Q49chtlEaaiHbzoV5FE
	KYVwtfCnkgxC3VVAQenA36CP7U21W0mgmaA5lTe4wrUbs2WOIxgnC2Uu6qGuGxHR79JFW3ApUeiqQ
	INy0o5RoO0nr41wD+FZC4A/R9mTjC/NRmN7FMEowKSK0s6EpxgsbqwR6prarPGc5hC9H18VeRa4Bt
	wWWl3+/6XOtEmqqa89xaD/VXKMQvamG4jL6oLAuhbBwroB8JW9HSFeeJf3xRLr9az4a9g1dWQP+nV
	J3qHPnwE85RLwOgM0eMy0RlzeqQ1kaOQq9Hx1v+thzhp8EitfhvcvLCB7bJNJpv24Gm5jeETlFuoO
	VpIt1/bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUIE-00000005WqS-0VC9;
	Tue, 18 Mar 2025 10:35:30 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuUHE-00000005Wcw-3ICc
	for linux-um@lists.infradead.org;
	Tue, 18 Mar 2025 10:34:30 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5499ba72f0fso624766e87.3
        for <linux-um@lists.infradead.org>; Tue, 18 Mar 2025 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742294067; x=1742898867; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgqBeCgacXz6i48arteRrLxAM0fCi4tfMNMBJPzxya8=;
        b=kxrhKRqG/hOIi3m9uHZ2kpGIBKn70JAZqZRRHIOTEG9V0Ev4X6luv+F/h3JRCmc5fq
         gGDo3m9G1EvF0vFuB4nRLs798yLPJXFLbbhlIO9EITPFJuxWnoZH38/ZGqRvjPzm37Fk
         rpAZQMQgAyFiDCtEoHPOSPKcmTX7Zqnw3lBSE8fzWCO8XqcAM+davMBcZPyhefJwlKhL
         McG7yp6d/3F5OOPJatZ4e62UgVkl/PS7cihTX71xUKdpzyAI1r3oT7nUdOvr0PTdgD3X
         Jceavuoe9wvPut6hgCwlSMnS2E9NQNFBH10t8janYLWzv2zicpqTNA9RCsQ3X2zod1x4
         mcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742294067; x=1742898867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgqBeCgacXz6i48arteRrLxAM0fCi4tfMNMBJPzxya8=;
        b=IelVxiCHN1l/lF4C5T1Gk0x9OckPFJ0I9FjhSDoDE4D1l/B6/h8b9OgnvRI7mdKNOM
         G9IsZTnlgLvNecCt5HWWRrSd6HJ02J68BpQVyT8i0ARS93ZeDPp3nJLA2GSD7B6kl0aK
         u9KM7IqXe0D9shjM713XO02IBMY/tiyCh7iOvr4RJy7s6PFfsJUz1FNScV0LH3A3iht2
         0W02LmN/ryQ6vBSBksJCLoAD3LYIzKWTAHeSwrvE3RKfIh8hneyRITHkOqgInWdOEjda
         8+nhcXdOXkyYkBnXbmkhJ9/619on3f5yEGkklmI5tPn4eQRTTo9oXdoF60NRAtAZiKjM
         nucA==
X-Forwarded-Encrypted: i=1; AJvYcCVsbu+JlHfYbYF/Z8urgX5KHpma0p6H7kksW6NiTN41f5vDOFnrhyvemtmt6dZKK/0Ydt1EX1e3UQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywr0QX4SSGMSlUVimAj8LnG+/WyTmqiBMdKu7n9Kn8oVJltK4uR
	EVhkJ4SL7+FOzsVZrDe5f/v6pM318e0FteKAOgosL/BDRP+3/Hyz+2Xu14HCOhzo9ZZ26l0md12
	IkJ7eK2mxdTcCShr+Vh4iiUC/nLI=
X-Gm-Gg: ASbGncvgUKRw+EJTO+O8k1ELjPzSAonxTP34OkW2NQ19/iSIe75Lsi0FVt+XiLZIo2r
	xkAkq8o6v4PyvgFxQg+Ym5mNpQ3iOsBlkHsoXgw7jmdR0nARCmvwSmOkAAH8dWDStt8okqrtRss
	w0+PCq50yekEiLsLrUQK+pKzN/dQ==
X-Google-Smtp-Source: AGHT+IHxAhk+yKtdKU5nIrrl6uVR6NufpxuMU8l75CVlABdoajg3N6hAhmBjCkoaytwWq5YHlhBoF04wjjcy3rVu/NI=
X-Received: by 2002:a05:6512:3e18:b0:546:2f7a:38a9 with SMTP id
 2adb3069b0e04-549c38d5eddmr3549957e87.3.1742294066844; Tue, 18 Mar 2025
 03:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250208-rust-kunit-v1-0-94a026be6d72@weissschuh.net>
 <20250208-rust-kunit-v1-1-94a026be6d72@weissschuh.net> <CABVgOSnwkDihbRzYF3uh3At_x0MgOB42_E8sUAD8moKwx+zjRw@mail.gmail.com>
 <CANiq72nnwopFAdETMhgkCfN9dj+JJZQ=K1BKz_A_xUViis7Avg@mail.gmail.com> <1a1ea09ae8cd82db0b8c3205bfd179bacfce4700.camel@sipsolutions.net>
In-Reply-To: <1a1ea09ae8cd82db0b8c3205bfd179bacfce4700.camel@sipsolutions.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Mar 2025 11:34:08 +0100
X-Gm-Features: AQ5f1Jp9OwqriR53SJxEyK9ZWTkGMjnsXOLnics89veDT3az8A-65eRFKbZHjyU
Message-ID: <CANiq72=8PHXBf3QuCmKwvZxtm6XbVd0qwDq=gaNRYRHojrmYtA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: pass correct target to bindgen on Usermode Linux
To: Johannes Berg <johannes@sipsolutions.net>
Cc: David Gow <davidgow@google.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_033428_825090_0A0F44C0 
X-CRM114-Status: GOOD (  12.41  )
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

On Tue, Mar 18, 2025 at 11:14=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> The list is fine, but the patch wasn't even CC'ed there, so we don't
> have it in our patchwork:
> https://patchwork.ozlabs.org/project/linux-um/list/

Ah, right, David added it.

> I was just picking up um patches, but given that it was a series, and
> changes rust/ rather than arch/um/, I think it's probably better if you
> do it, so:
>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>

Thanks for the very quick reply!

I guess they could be picked independently, but I am happy to pick both.

Cheers,
Miguel

