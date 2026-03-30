Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A302410D14A6
	for <linux-um@archiver.kernel.org>; Mon, 30 Mar 2026 12:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k7JyzGDh2V9hD5ppCKHdE8lqc25UY6zaRA17P+pQPiE=; b=BVBTE9QwJFr4fssqLACQX/Hj7C
	DRvdvJ6fJy+m/W2PpPEgYhSo19fZgo/FTvxpyNWZbM52o9b4tz85BTMI+xXGnC9WBMhq+xG3bES9T
	tyG4uP2lIPHt95QauAPwNX5CwSFVFMokEvCB4PSX/ztDUkmjjcJ4Flfb5HVHDeKqJ6PaRr2k1DUY2
	yAzubTSiL9jPjFyckamfab/2toMZKXsBO36JI/SSJFHIbtHiKopu5ldYrKTa64E7YcOBUoTclpLe2
	AOAQMr+jMLDJhBZa5TnlIa3SUHOfJwaeCBGS5XPdOMb/+QQZjFSa/+ZZj8DoZcbgpiAlMtBJX3T0H
	QrCwSLUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7BLL-0000000BD9f-0H4r;
	Mon, 30 Mar 2026 12:03:43 +0000
Received: from mail-vs1-f54.google.com ([209.85.217.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7BLI-0000000BD93-1H4z
	for linux-um@lists.infradead.org;
	Mon, 30 Mar 2026 12:03:41 +0000
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-60328e74517so1308909137.1
        for <linux-um@lists.infradead.org>; Mon, 30 Mar 2026 05:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774872218; x=1775477018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7JyzGDh2V9hD5ppCKHdE8lqc25UY6zaRA17P+pQPiE=;
        b=QYQnYJ7xfoocxEbvBn+qzixvzHNU66WmPyBBmiyQkTkqAzuRx9Q0DxNaVMQOdyufP3
         xrt0vUsF+tZAc956uvMSJtFznhzkrBQp3/+A/08Sgfxvj913lSKywFsDAjcVQMHUNDlm
         83B/ZqWCJ4zBzkepEN1f0VC/OCIgDUidQuY5+Eu6sGfAZD2F1CBk/+ccGXg6T3K8913D
         40KsdK6yohjLMeErQF7SDu+I5vaBw0vYs113ck2Md1qE4KBwO7jL8dtYCXkWtE0w19jm
         ZaBIKPO+L6AQ66YxMJuROLOfcYP3Rirus1/u6ginrv2gTjf9Wyz6NM2taJJAHGrrLrSp
         jxFg==
X-Forwarded-Encrypted: i=1; AJvYcCUTpZr5016b59pjN5IHCxG5p+PvlCXa1N/CX6vF+pjfgpMgUprR/wTwO5XF5Zvpta3m2Lb9cbOVGA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzHSH5tt8EhV/R9rCLPU362J6EL20T/MBMTnhJUhXXFIc2kAXCy
	xuf2L58Geb3g5FfDoMLfb0io4joaa2xwMT/HpAtSanRgKh0SEhhMqYb4nMEa3gTM
X-Gm-Gg: ATEYQzyOgXydJTpSICg0UAabn0NJdPy48ZQ0PGvdT2ko+OEI+vdVJBVZH3g3aqKvFgX
	CvMbp/hhSUfU4rhII5dpYpVc3XhUvxtCsviDi87IT6fLXsK0wsdXbJrLsCxkaPwN6TrZOnK2MJq
	YeyOTEbbawPo1SACozy6ZWjcqUusw9DqJi7ZWp7C3sEiGViYcark98bEGwN19iJFpmj7u8gdEe5
	3lSWDr80IbGRyuLPZYXcyK/HX6QHxG/RW0E4Vio8i1fuMqkUBZ4fv5rfwgAJ5ZwjZVK8Hh9xn16
	xgYgkO76UKYvwKkQtF5Ey7cXH3sVbWjdD2gNK/bq81bRzmjjLO5vfY02DLCxDeReRaGR+OZmL8h
	XE3NKr31P0D9b0wjYUkkazRb+McisTW1kzzfkTodkjvRj5X5Ca+vQOo35RhAz18O3Ome2eRswMa
	mVuFB/cwtQPlc7ArfEWwMEyFzD2UMboKkUaaEXrCkvsau/wLJW50NfaZ5e18Pnt5b2
X-Received: by 2002:a05:6102:6049:b0:5ff:fbe4:8a4 with SMTP id ada2fe7eead31-604f925999amr3072072137.21.1774872218298;
        Mon, 30 Mar 2026 05:03:38 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-605129b8347sm8021320137.3.2026.03.30.05.03.36
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 05:03:37 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56ce5c899fcso1246993e0c.3
        for <linux-um@lists.infradead.org>; Mon, 30 Mar 2026 05:03:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV88kSYKFQL136D3DSphaeg7HzMz5+7MBgK1d994X4MjjB0pThKKxeu0XMIM2ztModrtaur2dQqTA==@lists.infradead.org
X-Received: by 2002:a05:6122:1824:b0:56a:e46f:2cfa with SMTP id
 71dfb90a1353d-56d4a5f2e5cmr4217124e0c.12.1774872216490; Mon, 30 Mar 2026
 05:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <20260323000327.111235-1-ojeda@kernel.org>
 <acEP7tl8pqFA3tK8@shell.armlinux.org.uk> <acUGAsjYvNvTEO92@google.com>
 <CANiq72mzPpkELXis1CiSbKUmBXNQYMiMmjj-7-sYiLh4T_JSOQ@mail.gmail.com>
 <9cf5a94c-0f37-446c-b63d-ddac5674d220@gmail.com> <acVOL5Psz6kHlhq2@shell.armlinux.org.uk>
 <641592e3-2354-4238-9eb8-a1f5c2a13126@app.fastmail.com> <CAMuHMdUUfVCBZFi2WoOYibJLVnyPY-joRDJDowgHwjN_DGeEzw@mail.gmail.com>
 <93439e91-cf81-477b-b880-a813bb01ad7c@app.fastmail.com>
In-Reply-To: <93439e91-cf81-477b-b880-a813bb01ad7c@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Mar 2026 14:03:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU-+dm83TVttfarT7QxE5ySpQ2LJ_k6oFKMWRcbaWcCdA@mail.gmail.com>
X-Gm-Features: AQROBzBixIQPiuCOL0pIFbgyC_M26WMZwTpKOw623Sg5KUyDyMzQqEZKs9RSoco
Message-ID: <CAMuHMdU-+dm83TVttfarT7QxE5ySpQ2LJ_k6oFKMWRcbaWcCdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, Christian Schrefl <chrisi.schrefl@gmail.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, acourbot@nvidia.com, 
	Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Danilo Krummrich <dakr@kernel.org>, David Gow <david@davidgow.net>, 
	Gary Guo <gary@garyguo.net>, Johannes Berg <johannes@sipsolutions.net>, 
	Justin Stitt <justinstitt@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-um@lists.infradead.org, llvm@lists.linux.dev, 
	Benno Lossin <lossin@kernel.org>, Mark Rutland <mark.rutland@arm.com>, mmaurer@google.com, 
	Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Nicolas Schier <nsc@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Weinberger <richard@nod.at>, rust-for-linux@vger.kernel.org, 
	Trevor Gross <tmgross@umich.edu>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260330_050340_383116_2FD0B925 
X-CRM114-Status: GOOD (  22.29  )
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

Hi Arnd,

On Fri, 27 Mar 2026 at 10:02, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Mar 27, 2026, at 08:56, Geert Uytterhoeven wrote:
> >> I noticed a similar issue with m68k-linux, which has a bitfield
> >> alignment different from anything else on gcc, but uses the normal
> >> behavior on clang.
> >
> > Ugh, I wasn't aware of that. Adrian, did you know?
>
> To clarify, this illustrates what I mean here:
>
> echo 'struct { short a : 3; short b :15; short c :14; } x; int y = sizeof(x);' | m68k-linux-gcc -xc - -S -o-
>
> this produces '4' on m68k-linux-gcc, but '6' everywhere else. I originally
> thought this was related to this 2009 change in both compilers

Oh, now I remember.  AFAIK (holding wood and a rabbit leg) we don't
have any bitfield members spanning multiple base type instances in
the kernel.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

