Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47144C6FD1F
	for <linux-um@archiver.kernel.org>; Sat, 25 Mar 2023 12:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lKWr0JuxTUrbOfkTemgWQFoULqNa95oTO4ysVRh6dGY=; b=V80ddsTcWKJw2olcQLaVDIbHTi
	ktK9t1ApW2S2cjJSVwjXh05NkBP1bWkhDbdxQcnkPgAvBaEEVNZjWDASvsdVhPSbd6nK+vMjYWuyy
	szKybZuNv2kJvPvdxgCq33lszYQf5epTLArHPpKyPfptfjd1eZ0yna16O52HaytDe2lljy7cVEO5V
	/d0p/k5xqzNfmZADyjUgiRFzQFz6giZwmlGt90tkxdqH2kvGV5nmIZbLBl9oo2sBzogO3HqISbkHl
	6ajTq19iXcaRLY/G9doUHmAXfasZhooYQc74UiwYAxsApFFzCsUSr145NOxmfwrNkaSnJoABDkmpq
	lqL12niw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pg3BF-006hC4-2l;
	Sat, 25 Mar 2023 12:39:33 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pg3BD-006hBb-0s
	for linux-um@lists.infradead.org;
	Sat, 25 Mar 2023 12:39:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 411A0B8069D;
	Sat, 25 Mar 2023 12:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8455FC433D2;
	Sat, 25 Mar 2023 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679747968;
	bh=bzJOuXphixxPvR/XYoxhnmG5KfSgPy8eDYnhLSnOZO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFEsUChueDK8qoQh/M8MpJxH5+qymYzKfttjvuK4tPnEcfxjPFnNHILYE3MdHty3S
	 hWRP9LXwLS0XCRS458kAq7Cjvzj5pFm/orYfzPYW3L8MM76WzN0/f1fAOHD9/ldOoL
	 DAu2pJorZF9dGZpFPgOkUApvDg+egUMn3pkXWx2PVhWl8W7qUsxYK0YpJNLEduhKFp
	 IatxXZjyFBjN7wbWX2uy2S9rnHN0ciozlHl6NfhrOOKV/of6JlxU91GmLom4/CxSoS
	 LmFJlJOhPxvJsQ7MmBIMhobNm/iWTSnLqWsESnzUuur012/yOyXfUYBQddGSBW/c3i
	 VdF3r9dDyI6WQ==
Date: Sat, 25 Mar 2023 12:39:24 +0000
From: Mark Brown <broonie@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: Running KUnit using the wrapper script
Message-ID: <ZB7rfA2C7bSf7OlB@sirena.org.uk>
Mail-Followup-To: David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
References: <ZBumkUcw8cQfjvO7@sirena.org.uk>
 <CABVgOSk-3vSPsWDDzVO4GnzN8FAbBpx_jfKgTc9B=o7FODBhiA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABVgOSk-3vSPsWDDzVO4GnzN8FAbBpx_jfKgTc9B=o7FODBhiA@mail.gmail.com>
X-Cookie: Single tasking: Just Say No.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230325_053931_469175_B501E201 
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
Content-Type: multipart/mixed; boundary="===============3217061355376333774=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org


--===============3217061355376333774==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VNwuxaWUFVpGbLFb"
Content-Disposition: inline


--VNwuxaWUFVpGbLFb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 23, 2023 at 09:31:10AM +0800, David Gow wrote:

> The most convenient workarounds (other than having newer gcc /
> binutils) are probably to either run against a different architecture
> (e.g. --arch x86_64) or to build with clang (--make_options LLVM=1).
> Those should be a bit more stable for bisections than UML on the older
> gcc versions.

Running with --arch x86_64 or arm64 seems to work around the
problem, thanks!

--VNwuxaWUFVpGbLFb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQe63sACgkQJNaLcl1U
h9BPiAf+NPdUd1/DAJkvFCNRHrZipB3ngLkLKE6hR3/SjNEePaegpymO3HRzomYF
XR0Zv0E53X1Ll0aEioESIfqmK1NNvo5wOWy/JEbb+kPtoxItvZQXC0gVv9Mqv2YZ
5qvohsDRO6J1vrDO/9eTFjb4w0kfc8AtesPho2Za0GyRqc6OM9Hpj3x1VdVTDT3K
PLXrTrQ5mJp3G6gMCa+gDnU1qZEC3LE3pVknIuBS/IH7jp002DXPC9hf81U5NAx3
m0eSa6SwAxI3EJZqcMAumviY+O8Mp1k8KPhIE5cjghTSI5ptF1KqLaGK/qvh8pmi
E6DXujE21vrNUxIMeD1VcsiGQ+lGOg==
=Yr2e
-----END PGP SIGNATURE-----

--VNwuxaWUFVpGbLFb--


--===============3217061355376333774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============3217061355376333774==--

