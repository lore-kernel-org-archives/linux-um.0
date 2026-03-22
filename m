Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9081DD58CA1
	for <linux-um@archiver.kernel.org>; Sun, 22 Mar 2026 19:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kdPp+W0A0jpYkd/sH8q/7VCeNvsL6+/RsGobTkgjUSs=; b=XK/FObgLZzy854ojoq5yOqWmwl
	djbimJAvjCprBNvp2SyCqftUxCeqv5H1+KRWrmB3i/kfbAnkFwEdSSurf2o585LJNu8BNyZqJT6QG
	GDLRgrq0cZ5IsJzi2GnUl0sWDnCJQmaKW2GuijxJfJlnSfgNiGUCWEEP5xgAv6OyIKExyfpTnhM0h
	8FT4T9C/RJIkGqfeAkidcypEZEctTgKNzxB0+Z9pDcrVnP7/pw01dwqIik5hUtCmRH5voQ18B8DNe
	M1g+JSfu+9bgg99mxVoVP4O6V9Z8WYPZVLWVSgb5bgfrAwoXaJI1KsGndyPUuoYcpK6dJFAic10LF
	V4YY4hPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4Oei-0000000Fbkj-276L;
	Sun, 22 Mar 2026 19:40:12 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4Oef-0000000Fbk9-2mFz;
	Sun, 22 Mar 2026 19:40:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B5F34449F;
	Sun, 22 Mar 2026 19:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773E3C19424;
	Sun, 22 Mar 2026 19:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774208408;
	bh=LmSsPswxZJyi7uyr8x6P1FPNjN1VACNlrBgkCkSkAP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLbPcWiIbbxn7OdK2L+WCXVhbxqwQdPh2l75KmHFLZfVu+hn4dywhz3ud4tx6qJl7
	 7a/Mi90Abm1OGSp1kBwcpD9waRFSX9kZ1r9O+DIdQ+XYgcDIwgHdW68Nj9GYLyNGmf
	 I4q8LNcPUOQ+lENOSwv36knt9/YDorltIFC5qKtT/R6NhePAJsSRV3B02BJsEc1Cu4
	 S8acANr+Be+hA9NKIhNcJ5CdalqY+U8Ayjuq1iqAQTSOhugvvvb7705mNARXeJ3EvP
	 XmfSiLR6esl4sZQwU6w5jNugUfMg2qWrsNHmzi3Vd9sac20+v/tBNdVllME6U7cCHp
	 E7Z1uW68ZN+qA==
From: Miguel Ojeda <ojeda@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Jean Delvare <khali@linux-fr.org>,
	ojeda@kernel.org
Cc: linux-kernel@vger.kernel.org,
	a.hindborg@kernel.org,
	acourbot@nvidia.com,
	akpm@linux-foundation.org,
	aliceryhl@google.com,
	anton.ivanov@cambridgegreys.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	david@davidgow.net,
	gary@garyguo.net,
	johannes@sipsolutions.net,
	justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	linux-mm@kvack.org,
	linux-um@lists.infradead.org,
	linux@armlinux.org.uk,
	llvm@lists.linux.dev,
	lossin@kernel.org,
	mark.rutland@arm.com,
	mmaurer@google.com,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nicolas.schier@linux.dev,
	nsc@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	urezki@gmail.com,
	will@kernel.org
Subject: Re: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
Date: Sun, 22 Mar 2026 20:38:30 +0100
Message-ID: <20260322193830.89324-1-ojeda@kernel.org>
In-Reply-To: <20260322192159.88138-1-ojeda@kernel.org>
References: <20260322192159.88138-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260322_124009_743796_CFACC284 
X-CRM114-Status: GOOD (  16.90  )
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

On Sun, 22 Mar 2026 20:21:59 +0100 Miguel Ojeda <ojeda@kernel.org> wrote:
>
> I will reply to a couple other bindings in separate emails to avoid
> spamming people too much.

In a series of tests, in some cases, I noticed an `objtool` warning for
x86_64:

    rust/kernel.o: warning: objtool: _R..._9RegulatorNtB5_8DisabledE3get() is missing an ELF size annotation
    rust/kernel.o: warning: objtool: _R..._9RegulatorNtB5_7EnabledE3get() is missing an ELF size annotation

I noticed that it only happened when `CONFIG_REGULATOR` was disabled. It
seems that we have undefined behavior in `regulator.rs`...

We have `Regulator<Enabled/Disabled>::get()` which calls
`get_internal()` which calls the `regulator_get()` helper, which returns
`NULL` when `CONFIG_REGULATOR` is not set. Then the return value is
passed to `from_err_ptr` which checks `IS_ERR`, which returns false
(unlike `IS_ERR_OR_NULL`), and thus we return an `Ok(NULL)`, which we
then pass to `NonNull::new_unchecked`:

    // SAFETY: We can safely trust `inner` to be a pointer to a valid
    // regulator if `ERR_PTR` was not returned.
    let inner = unsafe { NonNull::new_unchecked(inner) };

So we should fix that -- it is there since its introduction in commit
9b614ceada7c ("rust: regulator: add a bare minimum regulator
abstraction"). How to fix that depends on whether the Rust abstraction
supposed to work transparently like the C API, I assume.

Now, two improvements I think we should independently do too:

  - The docs on `regulator_get()` don't say it may return `NULL`. It
    originally that case, but commit be1a50d4eba4 ("regulator: Let
    drivers know when they use the stub API") changed that without
    changing the docs.

    I mean, the "docs" are on the real function, but still, one may look
    into those and not realize the stub does something different.

    The implementation comment on the stub is also a bit contradictory.
    The original sentence (which still is there) says that nothing
    should look at the value, but then it goes onto say that drivers may
    actually look at the value.

  - On the Rust general infrastructure side, we should document more
    prominently that `from_err_ptr` may return `Ok(NULL)` just fine,
    since it calls `IS_ERR`. It may be obvious, since `NULL` is not an
    error value, but still, it could have perhaps prevented this issue.

    We should also include an example to the doctest showing and testing
    that particular case to drive the point home.

    I can add that as a "good first issue".

Cc'ing Liam, Mark, Daniel, Jean.

I hope that helps.

Cheers,
Miguel

