Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986C6C27C77
	for <linux-um@archiver.kernel.org>; Tue, 11 Jun 2024 22:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xDAi/LehtiGuKcebgCW9P5JNBdnm/nWvTWG7gETgqwU=; b=jbBgKu0T2XHQjFm/56/hVtT5jD
	5dF+ZnmiADAc3Dd54ME4nB2kFw6FZhGqItCGMDhrPVjgCbDhZdySU2BdClSi50la9W2JbspNWQ+FI
	FK7kavrSK7LFTAXRrWiWNksYaRd1aPEPuKVI3I50vaWbnhwrDJOLJDIMitcfE2+yl6XxtPEavbtcd
	Q/VV8v19GCtQVd1DFy7H8I7mHtzRVuk203w4CYsL31xKQUcFK6+z2Mr8a2bdbZuBDS6OvX8rrwMnI
	EuLsjUsY2tlHvNpJXFzoN5DeRAnu9rzC68WDPPo1wGTt5K+hGv5Re/jhxSPKDl7wrbhYSz4P7jcXB
	irmsq0Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH9fc-0000000AMv5-42bS;
	Tue, 11 Jun 2024 22:08:48 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH9fa-0000000AMuN-0onU
	for linux-um@lists.infradead.org;
	Tue, 11 Jun 2024 22:08:47 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2c2e0ca8f90so3013325a91.0
        for <linux-um@lists.infradead.org>; Tue, 11 Jun 2024 15:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718143723; x=1718748523; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDAi/LehtiGuKcebgCW9P5JNBdnm/nWvTWG7gETgqwU=;
        b=QhvWbpuqzHwefoiS6AJfzfyLcb9BPJt51fakPoke9Qmz1EyBXN7Xs/WvVXf3AJ9+LQ
         K4I9aKxX1Ccw99vvG2/lCkNlFMO6pAm2QCGOrBTEPDfyEj3r9hdEAMMxHmh8WuuTa6RY
         wHWand07hoP4Rb9EK68Ve6gEimSonI9iGaGhjP9pYCXbmzmc3QlWQ1GjpLiFxVeYXUI7
         0RLaCtRWbXcLSKuKJOkTNqBDAhDtjbJnFjbEsDBPvdNpj2bf0GcR43IM7XOkkq13GVjO
         77mVYx52VtUA2Kta18kiLikkWKlQVB70osLiO2BKgWAKPWc4rtqBQcMFAdPPvkB4Qro/
         w91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718143723; x=1718748523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDAi/LehtiGuKcebgCW9P5JNBdnm/nWvTWG7gETgqwU=;
        b=qzafJOgHj25qv7YP14/8tM8kPlZ2dWnLyrxixWXgVdzrcS1NHr2VRmtdZSU+fLYWlP
         Ce2Y86MkjgKVjExjK6eUSJFqNOZrVzPrmmAnvJQ6h43GjhtApvof2+RwfUks5UB6yfUL
         UCRZoaNAAEja7f0xZMBBn3azjqbJdvFPjxKOSIRqCgvQNNpPnpOraF3orUKZ5gbZxzsh
         GRdBBPfnQea6Hm1V4inKONt9t955ogasO6rUuuEdN0ADKVb0+UEbaEzD2CDg5hK3zkrP
         IEDAbq4MMg19ffe3GGefT7zTphx/PDh5b1gSDVRRBSOMgDGAmp2Ehm+2y4s9k0GfSuFz
         tW9g==
X-Forwarded-Encrypted: i=1; AJvYcCUWuI0CgGPN7dzvKQdHiWARyTkxiL+JLz0LxWj5DXiwsEJRf4TCHK4itqrgsvXix/7TKkPH9XqCXESs9iBG8RyBaVkmx17KR43fLCrc
X-Gm-Message-State: AOJu0YySeSEcLHzktgS7q7tDLVDgpzARj14RcL72rejN9dqJp3/KnHdC
	xgcwjQjCd0qBw0LnkH+lEZTGfZFl+IDsksNt+1a+PxaA6X5fXYljVMTyu/to2Fx2wt3lHGmvOzy
	1QyjACmqEz7aRw3POxMU+n6bSI48=
X-Google-Smtp-Source: AGHT+IFBHffem54xLZczBJ5Xe/oS4MPcXIdYx89tohNq89Cp7pMB4O45YjeNBKL1s1OfEMOCHqgJQtN9Pa89PVrrbZU=
X-Received: by 2002:a17:90b:b06:b0:2bd:8378:af81 with SMTP id
 98e67ed59e1d1-2c4a7602018mr213853a91.4.1718143723147; Tue, 11 Jun 2024
 15:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240529093336.4075206-1-davidgow@google.com>
In-Reply-To: <20240529093336.4075206-1-davidgow@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Jun 2024 00:08:30 +0200
Message-ID: <CANiq72mXWERtFSqQRtcgP28aLokwZmXaBiqcrn_zoASawjfdsQ@mail.gmail.com>
Subject: Re: [PATCH] arch: um: rust: Use the generated target.json again
To: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, x86@kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_150846_274437_655D74F3 
X-CRM114-Status: GOOD (  15.34  )
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

On Wed, May 29, 2024 at 11:33=E2=80=AFAM David Gow <davidgow@google.com> wr=
ote:
>
> The Rust compiler can take a target config from 'target.json', which is
> generated by scripts/generate_rust_target.rs. It used to be that all
> Linux architectures used this to generate a target.json, but now
> architectures must opt-in to this, or they will default to the Rust
> compiler's built-in target definition.
>
> This is mostly okay for (64-bit) x86 and UML, except that it can
> generate SSE instructions, which we can't use in the kernel. So
> re-instate the custom target.json, which disables SSE (and generally
> enables the 'soft-float' feature). This fixes the following compile
> error:
>
> error: <unknown>:0:0: in function _RNvMNtCs5QSdWC790r4_4core3f32f7next_up=
 float (float): SSE register return with SSE disabled
>
> Fixes: f82811e22b48 ("rust: Refactor the build target to allow the use of=
 builtin targets")
> Signed-off-by: David Gow <davidgow@google.com>

I guess this should go through UML, but please let me know otherwise
(I don't see it in next).

Tested-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Should this have a

Cc: stable@vger.kernel.org

too?

Thanks!

Cheers,
Miguel

