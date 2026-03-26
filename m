Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50072106F317
	for <linux-um@archiver.kernel.org>; Thu, 26 Mar 2026 10:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lBGicU27laianFvyzY656GHLSJPIgkYXNKTwZ0wPpek=; b=atrszXNWjsq+FyXMP7knpZdEtq
	fCsejHqZR9yKGqAeNerdVOboFuv8AtA5mIc4PBj/mTbcq6MpbgYDgn0Cbwst51l4Kwp6KVtpMwVOW
	WhonlBtbxccyyrYx++sRSfPHDNhRam6kDoskUwGKXYyXFx7a8rE4XsNO0hjnkrZRWGshbg5p5ai7v
	9g2Fq2t5jWNQOzndRsv2l9Yvy6npdF5MuCi1zojQh9dNUndNPQmuM/g1x4rxC+tC0Dbp86TUtBz8Y
	5gydUgFaXjJ4+NpB1EXTVLfxg0CnXEZu0Wsfd81Ox5fHu9F+DfIbJIRo22NNMOpnEQUFlpAIbRyXu
	qxftBFHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5hfN-00000005Eut-2k97;
	Thu, 26 Mar 2026 10:10:17 +0000
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5hfK-00000005EtS-2wKX
	for linux-um@lists.infradead.org;
	Thu, 26 Mar 2026 10:10:16 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso16128945e9.3
        for <linux-um@lists.infradead.org>; Thu, 26 Mar 2026 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774519812; x=1775124612; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBGicU27laianFvyzY656GHLSJPIgkYXNKTwZ0wPpek=;
        b=Mi7S02Yckqlk6j7gSVi4WmCMr3U1xdhtMYe4E2j8jQsTUfZ+AbDFzzLpkLBnZz96Kn
         ym3hploimaJezOaWo8ML4GV/SmqiiO8u/5Yb6YItRxc965FcA8rl7X1B531U391vLhwD
         FlyvbfJTtzfiWen/KiwIcj/c/XJGmHR4VaiHJcfIJA8+0BjvehILrApUswcvuXfrxKCZ
         CEUKOOPJCBsXD/8Y/s31/j/lTlfW8Op6ds5/aLKIp6s4CY4HPNeeB0mEWaa1HYcf8gee
         NSB2uIwiM1p500zo+8FVtUr4ZX9yzhqD50RRx9UmqzijJUn7OLI2WaYTA4tqGnX5MVgO
         tPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774519812; x=1775124612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBGicU27laianFvyzY656GHLSJPIgkYXNKTwZ0wPpek=;
        b=hvgdS0o6xBzeKrfkwNdEiAu6COM4lBkw5uPn6J98sxBwxMMMlL4dDVjD3ka4i6v4Nz
         IcNxuOdhDgKvD1EAMMwssSX/+/4qQDvKSKH3rVAvPMqXo+/ZFlTtVx0LMk2pT5SVVdmI
         KppsMKrvcMN29XcT+tqGI7ZNLpR/onmRMrzGNwkLAY2d03bB42B6WX9LMVSzVtuIX2/g
         gNwiGWORFX2NlNOKpv5M8fMIec+WcsgDFi43sPgBKio3RnolMyS4k1XsXrW1+JzElLIT
         7n/g8iGrj5Nptjs2lAQOOVO60FC1j6UZpzxQuEa4NClnllbpb7ZRGcp15rZSmfpTfCql
         odhw==
X-Forwarded-Encrypted: i=1; AJvYcCX+iwDNNzraTdj+YmJtnaLGOmqC0ZjD8V8urwc+tLU0J+SPgujS2P80pH0g0e0Nld9V2IT9E3C/eg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxTQpUc8eZkd/4fJUPLrChDfrkBqyGnkp2zBn6f6igvj8I+a3YP
	x769K8ngUroAZ2Sdnf+/5J6Hbi0Z+5vrs/0htE3gKBEd+XGckCD0j7h5FgF59vu65/yDs2+QXYH
	sFI81+LCsuUfGN9n4WQ==
X-Received: from wmoo2.prod.google.com ([2002:a05:600d:102:b0:47d:5bef:a379])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:890b:b0:485:6ec7:2df with SMTP id 5b1f17b1804b1-48715fd50abmr80350625e9.8.1774519811752;
 Thu, 26 Mar 2026 03:10:11 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:10:10 +0000
In-Reply-To: <acEP7tl8pqFA3tK8@shell.armlinux.org.uk>
Mime-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <20260323000327.111235-1-ojeda@kernel.org>
 <acEP7tl8pqFA3tK8@shell.armlinux.org.uk>
Message-ID: <acUGAsjYvNvTEO92@google.com>
Subject: Re: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
From: Alice Ryhl <aliceryhl@google.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, acourbot@nvidia.com, 
	akpm@linux-foundation.org, anton.ivanov@cambridgegreys.com, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, 
	david@davidgow.net, gary@garyguo.net, johannes@sipsolutions.net, 
	justinstitt@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-um@lists.infradead.org, llvm@lists.linux.dev, 
	lossin@kernel.org, mark.rutland@arm.com, mmaurer@google.com, morbo@google.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, nicolas.schier@linux.dev, 
	nsc@kernel.org, peterz@infradead.org, richard@nod.at, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, urezki@gmail.com, 
	will@kernel.org
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_031014_783699_A52A56B2 
X-CRM114-Status: GOOD (  20.63  )
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

On Mon, Mar 23, 2026 at 10:03:26AM +0000, Russell King (Oracle) wrote:
> On Mon, Mar 23, 2026 at 01:03:27AM +0100, Miguel Ojeda wrote:
> > On Sun, 22 Mar 2026 20:21:59 +0100 Miguel Ojeda <ojeda@kernel.org> wrote:
> > >
> > >     On the other hand, regardless of whether we fix this (and another
> > >     issue in a separate email found thanks to the UML build), we could
> > >     instead add `depends on` listing explicitly the architectures where
> > >     this is going to be actually tested. That way maintainers can decide
> > >     whether they want to support it when they are ready. Thoughts?
> > 
> > Another one for arm 32-bit:
> > 
> >       LD      .tmp_vmlinux1
> >     ld.lld: error: undefined symbol: __aeabi_read_tp
> >     >>> referenced by uaccess.rs:349 (rust/kernel/uaccess.rs:349)
> >     >>>               samples/rust/rust_misc_device.o:(<rust_misc_device::RustMiscDevice as kernel::miscdevice::MiscDevice>::ioctl) in archive vmlinux.a
> >     >>> referenced by uaccess.rs:543 (rust/kernel/uaccess.rs:543)
> >     >>>               samples/rust/rust_misc_device.o:(<rust_misc_device::RustMiscDevice as kernel::miscdevice::MiscDevice>::ioctl) in archive vmlinux.a
> >     >>> referenced by uaccess.rs:543 (rust/kernel/uaccess.rs:543)
> >     >>>               drivers/android/binder/rust_binder_main.o:(rust_binder_main::rust_binder_ioctl) in archive vmlinux.a
> >     >>> referenced 36 more times
> 
> Why is Rust generating code for userspace thread accessors for kernel
> space, where userspace threads are meaningless. This is totally wrong.
> The kernel must not reference __aeabi_read_tp().
> 
> Note: I know nothing about Rust, but I know enough to say the above is
> pointing to a fundamental issue in Rust for 32-bit ARM.

I noticed that the Makefile currently uses the arm-unknown-linux-gnueabi
target. It should probably not be -linux target to avoid this? Probably
it should just be armv7a-none-eabi, right? We gate HAVE_RUST on
CPU_32v7, so we should not need to consider the other variants.

Alice

