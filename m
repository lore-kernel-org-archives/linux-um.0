Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B9410D14A2
	for <linux-um@archiver.kernel.org>; Mon, 30 Mar 2026 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=woUempTeRL+MJtlKxpfNaT94H+rNPuTZjIMDTveSMCs=; b=KQU4QANjrYoTcD8SNLQv1vpBp9
	vpbeYfeb+UMmU0jcAAAf3GQLco2TOwM3wr2Y0foKXHv5yNilKhA9H8lf3E02vGVGhO8S+9wOSaMBV
	Beh1n1XFNdgI8Xxul3JlohAjAJyCaO27UyA1/IwcBfUUjmBsPjVNCh6uCHRMM4PqMxMxyrAe/0en4
	WD/XMgJJ3mgmkhYuqPG0AJNqBemXb49GtVx12wtAgKiRjQ4FnzndWc1Jsl6/VRqHhsszyF+7Sxkg4
	cFid2g5m06qM8/9SZkw7VCr/8xiRLgy0t0VGldppU4UPo7VuBX6YXWjJuSUaG/TqTdADUm0Fnhv98
	/DJpPlRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7Bfn-0000000BFXs-2saF;
	Mon, 30 Mar 2026 12:24:51 +0000
Received: from mail-oo1-f47.google.com ([209.85.161.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7Bfl-0000000BFWm-1dme
	for linux-um@lists.infradead.org;
	Mon, 30 Mar 2026 12:24:50 +0000
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-662efd1bdd4so2497867eaf.0
        for <linux-um@lists.infradead.org>; Mon, 30 Mar 2026 05:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774873488; x=1775478288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woUempTeRL+MJtlKxpfNaT94H+rNPuTZjIMDTveSMCs=;
        b=cz/p0ZzIjPuo9ZtSJuLix4xxdE6dNEfA+RTkyamxZdriwhe+1T/R1uoMu3SFhccCP9
         oG6OBkjzaGKCWjOioB5cj4l3ldSmWPxd+zDq6pCBxTXHpHg0ekGgq34TUd+tM5m9Qmde
         2v8xQZGUrWM27d5HjSBZVkQ8HCXq82XCcWKk2eBGjMYcfeslfnG7941yE1YoX3b3KvkM
         Hl6WaeuiEGOycGKvJMbXGtA+qVXcMdaG5QcfK0RAeeFxVayJP2iR48nhEFsogywar1pr
         qwQlv6qAD27ABe2DrSaXW5YWBVUWKrCe6Jko6DiMBs3OF5CLL3icSExBkQijtG607MYh
         rzFg==
X-Forwarded-Encrypted: i=1; AJvYcCUzFgVcxafI5ILaYLm5/2z4CduDiyiC346QDnNv+d18h8bzleclnPqygcsTYJugblFrMwpOE+CUaw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyt8Pvb+br9WyogeC6QPbLuLJKSeosR9TTG55acdf8eAScvQvzQ
	MBZxnLr2m9T01EQw/Ir8zH6ZgZMRODNv3GMnMBDNHLjhGdJddEHFg/6v902LkLrC
X-Gm-Gg: ATEYQzzeL0zdzIUadoDTrGeIqpKvwkOALMZX9xLha33JH+2bspfvtKcuQKpVgbsxugh
	I5zXHEYKa0ssv+LVE55iGsxoSjVehzymqh3LS3K+E7010uAka6UI+Gj1fNCpHyElULmJtxyLmdA
	vqENReEGLea6dnz6hnSST7RopvKT697cmPKy5Egu+63FbuqWWaktBrIDm7+xujxJ8Iu0qd/A9t3
	+5eUGwcrVphd0Wr0CbPbjQfmMwnHr4TX/krIZ+xrDw2xFHcvgl5GNHhLb4vgXgrErozWMyUbHjh
	TeKHLyF8qcoioyDtr/USsvJgBMvfAQY/81d99Qhj3LAapGt5CwKAPTPCZsF2S8tmf8NAEZysbw2
	v1UKzMFdW2wnxSQp9L1CsfW6uzFiX+z9i6PCdspu8htQL1zkP9KMO0/s5+ZOHkagsioLiTgdY+t
	6CmpP41Nybz2Ov9yb5TAoQPtbuJ7HTqCOTfUZXDZq60TwO9eFrLkn1SBEQAsnQ
X-Received: by 2002:a05:6820:16a2:b0:67e:2013:aa10 with SMTP id 006d021491bc7-67e2013aaeamr4877230eaf.9.1774873488070;
        Mon, 30 Mar 2026 05:24:48 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e231e1329sm4859598eaf.13.2026.03.30.05.24.47
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 05:24:47 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d1872504cbso4328255a34.0
        for <linux-um@lists.infradead.org>; Mon, 30 Mar 2026 05:24:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyUbhA9QWltUN49to1rJzN74SqtX15d54Jio3V97pCNkfk/n1dbwbSnqvMd9NFeC+/JX3uhgMGUA==@lists.infradead.org
X-Received: by 2002:a05:6102:4498:b0:602:896a:84ba with SMTP id
 ada2fe7eead31-604e4df3704mr5271926137.17.1774873037674; Mon, 30 Mar 2026
 05:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <20260323000327.111235-1-ojeda@kernel.org>
 <acEP7tl8pqFA3tK8@shell.armlinux.org.uk> <acUGAsjYvNvTEO92@google.com>
 <CANiq72mzPpkELXis1CiSbKUmBXNQYMiMmjj-7-sYiLh4T_JSOQ@mail.gmail.com>
 <9cf5a94c-0f37-446c-b63d-ddac5674d220@gmail.com> <acVOL5Psz6kHlhq2@shell.armlinux.org.uk>
 <641592e3-2354-4238-9eb8-a1f5c2a13126@app.fastmail.com> <CAMuHMdUUfVCBZFi2WoOYibJLVnyPY-joRDJDowgHwjN_DGeEzw@mail.gmail.com>
 <93439e91-cf81-477b-b880-a813bb01ad7c@app.fastmail.com> <CAMuHMdU-+dm83TVttfarT7QxE5ySpQ2LJ_k6oFKMWRcbaWcCdA@mail.gmail.com>
 <26d690ab-d68f-401f-ae2d-7aa4de081bce@app.fastmail.com>
In-Reply-To: <26d690ab-d68f-401f-ae2d-7aa4de081bce@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Mar 2026 14:17:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDy9mNuzDaYfE6r+P8MSTBEGsyRzisLF_d_FWX+6qCVQ@mail.gmail.com>
X-Gm-Features: AQROBzD1En3iKQ5LsAPqOXpbj6O32MjUPo3QPwr0lgIQkMqaR2Lx1_ZSwol-K3A
Message-ID: <CAMuHMdWDy9mNuzDaYfE6r+P8MSTBEGsyRzisLF_d_FWX+6qCVQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260330_052449_429779_8F0722C5 
X-CRM114-Status: GOOD (  26.07  )
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

On Mon, 30 Mar 2026 at 14:14, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Mar 30, 2026, at 14:03, Geert Uytterhoeven wrote:
> > On Fri, 27 Mar 2026 at 10:02, Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> echo 'struct { short a : 3; short b :15; short c :14; } x; int y = sizeof(x);' | m68k-linux-gcc -xc - -S -o-
> >>
> >> this produces '4' on m68k-linux-gcc, but '6' everywhere else. I originally
> >> thought this was related to this 2009 change in both compilers
> >
> > Oh, now I remember.  AFAIK (holding wood and a rabbit leg) we don't
> > have any bitfield members spanning multiple base type instances in
> > the kernel.
>
> There are certainly very few of those, but two example I found in
> UAPI are
>
> struct dvd_layer {
>         __u8 book_version       : 4;
>         __u8 book_type          : 4;
>
>         __u8 min_rate           : 4;
>         __u8 disc_size          : 4;
>
>         __u8 layer_type         : 4;
>         __u8 track_path         : 1;
>         __u8 nlayers            : 2;
>
>         __u8 track_density      : 4; // crosses u8 boundary
>         __u8 linear_density     : 4;
>         __u8 bca                : 1;
>         __u32 start_sector;
>         __u32 end_sector;
>         __u32 end_sector_l0;
> };
>
> struct usb_raw_ep_caps {
>         __u32   type_control    : 1;
>         __u32   type_iso        : 1;
>         __u32   type_bulk       : 1;
>         __u32   type_int        : 1;
>         __u32   dir_in          : 1;
>         __u32   dir_out         : 1;
>        // 2 bit padding on m68k, 26 bits elsewhere
> };

So we just need to make padding explicit? Sounds familiar ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

