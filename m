Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB7DF4611B
	for <linux-um@archiver.kernel.org>; Mon, 23 Mar 2026 13:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wgz5UIsacYchyYn/NXziBlVur5a/20XBkzVTOVRSbZI=; b=uj3LNrUyOvDgq8t1ftH77E2ZW1
	ABXCZbtGe5MsnH//YLHlMk2ryOSp2tIPauaJUG1dORCi+MUv+TgyHbzBYj6dUZtk9ySaxyFLJhrl/
	toWnF5NrlGzJxIBataLfMY50iJ5WCcdY8mO7SnbR474Xp2yxvBy8PdYAp2aeZ+uf9rf5qMhMMv4d/
	66HLpYNZvlVzNrejmS5eV5sMYGYl/JYS/gFZcmtyLDoxENDafddoPjXH+/MqMR0JrlaJ60sDSbSqB
	Mc7WEBKjerWONpAXVmr1O8wWOc6HHIkoRXro6LpoTSXIIf0ZgqtWtAGlplwHHwHajAjFWyQVlZAKW
	pU1zy8oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4fjm-0000000GsBf-1Pi1;
	Mon, 23 Mar 2026 13:54:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4fjj-0000000GsAw-0s8Y;
	Mon, 23 Mar 2026 13:54:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EE47B44075;
	Mon, 23 Mar 2026 13:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5646BC2BC9E;
	Mon, 23 Mar 2026 13:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774274069;
	bh=2/XBTB87GrlUNJZddLpCGE+4XhXu902RPGnPRLytH2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m2j0DwAzlmvBKd4e/6HcTL2rh8800PVIc21bjtqQIikh3rCuEvv73eyHeOmtX4S+F
	 lfpQxfvR0/mQ+1I77YFM7NDAuaibxX/qHgPKB2NKhlgYJkzrO7EHvOCUcDT05WijVo
	 zUWWhC2v8glwgs2zvu4m2dJCDmg0AASkGfpkpNuOCZ3GvyzIFEJcK3D2/fgsdcgl15
	 my2EWqLPtptTIxO+td1+qfdyU9vfXS+dfjZBZa6Ts9Ro53GaqHtezbbuw/zJNUui8y
	 1ml+/hXsulQF09cSECMU3vTl0ML3XAYbEo7BN5hZCC61iDDz5Xm2NewrzMcHDcH3j6
	 gisCLKTDVfAVQ==
Date: Mon, 23 Mar 2026 13:54:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
	a.hindborg@kernel.org, acourbot@nvidia.com,
	akpm@linux-foundation.org, aliceryhl@google.com,
	anton.ivanov@cambridgegreys.com, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, dakr@kernel.org, david@davidgow.net,
	gary@garyguo.net, johannes@sipsolutions.net, justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
	linux-mm@kvack.org, linux-um@lists.infradead.org,
	linux@armlinux.org.uk, llvm@lists.linux.dev, lossin@kernel.org,
	mark.rutland@arm.com, mmaurer@google.com, morbo@google.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	nicolas.schier@linux.dev, nsc@kernel.org, peterz@infradead.org,
	richard@nod.at, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	urezki@gmail.com, will@kernel.org
Subject: Re: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
Message-ID: <4fba0163-547e-4099-8b37-5d8429bda6da@sirena.org.uk>
Mail-Followup-To: Miguel Ojeda <ojeda@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
	a.hindborg@kernel.org, acourbot@nvidia.com,
	akpm@linux-foundation.org, aliceryhl@google.com,
	anton.ivanov@cambridgegreys.com, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, dakr@kernel.org, david@davidgow.net,
	gary@garyguo.net, johannes@sipsolutions.net, justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
	linux-mm@kvack.org, linux-um@lists.infradead.org,
	linux@armlinux.org.uk, llvm@lists.linux.dev, lossin@kernel.org,
	mark.rutland@arm.com, mmaurer@google.com, morbo@google.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	nicolas.schier@linux.dev, nsc@kernel.org, peterz@infradead.org,
	richard@nod.at, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	urezki@gmail.com, will@kernel.org
References: <20260322192159.88138-1-ojeda@kernel.org>
 <20260322193830.89324-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="01f7rP5tz95f7re7"
Content-Disposition: inline
In-Reply-To: <20260322193830.89324-1-ojeda@kernel.org>
X-Cookie: Avoid gunfire in the bathroom tonight.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_065431_306334_879B9E0C 
X-CRM114-Status: GOOD (  11.54  )
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


--01f7rP5tz95f7re7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 22, 2026 at 08:38:30PM +0100, Miguel Ojeda wrote:

>   - The docs on `regulator_get()` don't say it may return `NULL`. It
>     originally that case, but commit be1a50d4eba4 ("regulator: Let
>     drivers know when they use the stub API") changed that without
>     changing the docs.

Callers should never treat NULL any differently to any other non-error
pointer, this is not a value intended for inspection by users.

>     The original sentence (which still is there) says that nothing
>     should look at the value, but then it goes onto say that drivers may
>     actually look at the value.

Having specific handling for NULLs is very much not a preferred
interface, and most things shouldn't.  The caller should probably have
it's own !CONFIG_REGULATOR checks rather than using the return value.

--01f7rP5tz95f7re7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBRgsACgkQJNaLcl1U
h9C71gf9GpM/jjG7XngTH0kbbP53phsB1+ihdqiu8gRSA2NkhE0CDNEtrjeo8HK+
YFX9N3jSxdG8Xb07O5JUW+IXTMGCeLvz1uSBXZdXIabxC9f1LMtKTabWh0ZHf713
HWaiw2tyL04gxzoGRUMOxAdjtJO/AHPk+s6yJ/mQq30LL2Ct3q4SD2EtDeCiBi24
uVumpIb9BMTfIXF2ygQqJYC2bsstGVbR9LCepYNRWzl6pJ+8qpCwRMNb90/Fc54c
L2PQmhNC1Q8X3ghZTF3R48f7nMOug5EndZ2txdR3Z3qvY7xacpJH5R55yoodXcVg
aFFTXPyWGRpSqwmfdF6DFkUEV7QZAQ==
=T4pk
-----END PGP SIGNATURE-----

--01f7rP5tz95f7re7--

