Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BACC282EC
	for <linux-um@archiver.kernel.org>; Tue, 18 Mar 2025 10:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=puwZpc9fnpT0SxWUpm3PdjIjszBtFGfGzbiYPyhX6wQ=; b=zApDF8OBoNAJZVm5cPiQ0Q/YVf
	7TBHPWCe2dibhqDXOAIOkgIO+qQIv0nXTtWhv4K11Ar6KYlvi9oKDQHf7JPJwblFp9GmjK9UXE1H5
	33JpY8Ftw9cUvTDCe4zO6BS+XI5nGFg5XeRHAl2GkJYV+uSA1CtYFYiIxpsz1+Y6mgyy28YQu+ie8
	s3EYBdyQ6czClxMEZGaEsRduU4O53ejPT89fS1j0AOCX1bmdTMs1+DK60DOGx5a+vZ+4ziQioUruC
	PYjXeaDFtMFmkopF+mv7VxKOtuMJY8mNddn79vtb0S3j8cZV5GHHbpk4bPSGNkpoX4qrmeplZ9z/i
	yopkOxWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuTuh-00000005Rm5-1zxB;
	Tue, 18 Mar 2025 10:11:11 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuTub-00000005Rk0-262Z
	for linux-um@lists.infradead.org;
	Tue, 18 Mar 2025 10:11:10 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2ff62f9b6e4so811412a91.0
        for <linux-um@lists.infradead.org>; Tue, 18 Mar 2025 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742292664; x=1742897464; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puwZpc9fnpT0SxWUpm3PdjIjszBtFGfGzbiYPyhX6wQ=;
        b=llbOvEZWP+wutCIljATsJP1oxpiwJyXi4xqrz9ovgGM9xMaClIoMtLjsTBf2pU5CBo
         PR7V1d9waMvNN7Ofu+5EdyYPkQtVo40VI+8Wq88vHuxP5hCE564T2Eq76itFnaK/bVUa
         ZjtEc06//e4tsEU0JtSqCJ4y3eq15t/PUW3N3OnZ/p8x6uq58gN2JfzlWitJF5fN7f/s
         sTumKk9V7i3escMFIq6ttFsBQIrypi5yG8dsAcHwc4Ox3o2P8r7fAcvtjiE6Q5bdqwDC
         wxY7D6JgCQhDY31ZizMbBkvFzXtIB9/CcAvDjQ+y6fX4EpNhld6d5tN8HEGgunikt0A2
         g+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742292664; x=1742897464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puwZpc9fnpT0SxWUpm3PdjIjszBtFGfGzbiYPyhX6wQ=;
        b=w4sQP3RvU9p4pPHdCI/UdLjtc1R1G5etUq2fMWKQq32voj4BxsnIt13AdPEpni8RWm
         urQwdkLv2+pnJ42Jg0bXpVXoPP/wwwmCT+fsWKkDEy9iMgYUQjIYI7kPOFohW2yrtiko
         ToLIPD8azrIuC/mMBjqLS7FDoXkU2zrXlkWSX6npx/Vtvd8/HR94gbX5NqlVBCRz+ohJ
         OYusWnVFMQ0oF9WoQqcNLiHkBuK9FQAC1EV5Fuw16IkNy8la4Xjy0l0dFhv1vTuyP8FM
         erOJvWzd6WVrq4W/usmwEOiwbR3zCoqUSYNsKviMrChC+a3En0H/lrZxP121CZ3o/Hyi
         6oTA==
X-Forwarded-Encrypted: i=1; AJvYcCV0RutrdgNHw/sB0w9UM7qngf3du4c1+vOGvpo3s0ghqbvwzXzodTDylCFDNKUyOe/TkZOmVW8KwA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzFMC9VAczqMtGJgvLaaGLiK2xPkhS5gMITishp/3ndxBFEGYsY
	TDees5o0n0ygLm4FAePUrpSXE7jRXBhWXX1hDLh6r+kWNhZ7tDtwkB/ZFJjCgMr4r+qucurU7Yd
	+dyYKgt00fQHXaQHWLI0OSxwQ09g=
X-Gm-Gg: ASbGncuFUyheGMzbyLuJzdg00kx45cdtjS39AJH0DTICThHm0EzEHy/viudnSk0hxEm
	CNYyjNsk2i6bopzArdpOmQhOgpdwxA0ESPEgGduA4QHx0zT/tvMGv7TU5aIZNAv23zMpoWX1OXn
	eUQ+qVWvbVav/Dnrez85XhY3PzL8g4hSJACdEx
X-Google-Smtp-Source: AGHT+IGB4pLNiuryWOPuCO6MoIuBuFy1ozidD17nVmrb8yE9r7RMjTngizHJUOGCma5BGINdrBLFwwq4ZGQsKrsA1Os=
X-Received: by 2002:a17:90b:314b:b0:2ff:78dd:2875 with SMTP id
 98e67ed59e1d1-30151d89050mr7818390a91.5.1742292664500; Tue, 18 Mar 2025
 03:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250208-rust-kunit-v1-0-94a026be6d72@weissschuh.net>
 <20250208-rust-kunit-v1-1-94a026be6d72@weissschuh.net> <CABVgOSnwkDihbRzYF3uh3At_x0MgOB42_E8sUAD8moKwx+zjRw@mail.gmail.com>
In-Reply-To: <CABVgOSnwkDihbRzYF3uh3At_x0MgOB42_E8sUAD8moKwx+zjRw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Mar 2025 11:10:52 +0100
X-Gm-Features: AQ5f1Jq3f-pICr0X9p55_4vrGdEv6uxkF7XdN3Ns9pEmybRWGVbLLKT6D5l6wa8
Message-ID: <CANiq72nnwopFAdETMhgkCfN9dj+JJZQ=K1BKz_A_xUViis7Avg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: pass correct target to bindgen on Usermode Linux
To: David Gow <davidgow@google.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
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
X-CRM114-CacheID: sfid-20250318_031105_540036_309DFD86 
X-CRM114-Status: GOOD (  10.46  )
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

On Tue, Mar 18, 2025 at 9:07=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> Is there anything holding this up for the upcoming merge window?
>
> Miguel: I'm assuming you'd rather take this (and possibly [1] as well)
> via Rust, but if it goes in via the uml tree, that'd be fine by me,
> too.

We try to get arch maintainers involved (and everyone else, of
course), i.e. it is up to them. But I see only the list was Cc'd, not
them directly, for some reason -- doing it here.

Ideally, maintainers get involved and pick their own Rust-related
patches, but I can also do so with an Acked-by from them, which would
be nice.

If they don't say anything, then since you have tested it (and you are
a main um user due to KUnit), that should be enough, but then I would
suggest we do it after -rc1 to give them time to react.

Thanks!

Cheers,
Miguel

