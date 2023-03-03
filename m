Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC39DC678D4
	for <linux-um@archiver.kernel.org>; Fri,  3 Mar 2023 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nUBlR3fX/OCyYn8UNXWfJJA/hZKQxcIoVlATWCaFR7U=; b=HWP84dSQtI6bjgqjoTg8CAwT9M
	EEzJq8j41+1KOmfmdefVrpvEXAWN4aSP5jZuEN4iSwSGW4mLV/ky3w74PkcCDxBL4VTEjVl9U/yAK
	phE3QCDilI0jFK4AO4FwZ7bjPcEVoqdE9/OKShgVbdkl37/zjhnfZCoXeOFAsUCn5hVwam0vynyT8
	Jzrxhkev2K4zkx0IkIu78nn+anZYz6TdjD3sFqs9H5Gk/BeTUfv0gH3YbQjeAZRchRXGX7OKV4VSq
	4y6t1cFUAEwzYF4XjA6du5ey2bQjGnJAmdiwK1O4GgSmeMNmuLp5ZjgsG0rrJiYyALK/thE74WXWx
	S7LhB0gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY6YU-006cgs-Nb; Fri, 03 Mar 2023 14:38:42 +0000
Received: from new1-smtp.messagingengine.com ([66.111.4.221])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY6YQ-006cgJ-Lh
	for linux-um@lists.infradead.org; Fri, 03 Mar 2023 14:38:39 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.nyi.internal (Postfix) with ESMTP id E05FF58209F;
	Fri,  3 Mar 2023 09:38:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 03 Mar 2023 09:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1677854317; x=1677861517; bh=fE
	NpqGS/+8eA5DI/UUI0vpXheU20dTSblaG27LRs1wM=; b=TMhMKykfeOcON4SmqH
	CiYcR4MIZ49Z7wHVFPQNZj3iGkQl9Ekns63B0lEoL+meNxR+1YZlErUd72YNzWtc
	Tc3ckFkvLMeh9z5LY4PAFBAmSGhVbQXp133+eiQ6TbSr8c0f+rN06dClkyxbipje
	G99ggeGVGmhkM+vYhAS0iTVg1hZFSEFrqGP0d9QqHjS8ElbKXMyT/CaVXWnxeQKB
	/7z5ZnS1fBdEZ8W9XD7NfqLT4E50Bhdgu3yHMLuWpcq1zHML7Xkl6vuvxxwWr/x4
	kTDHrA9LQ5EfKoXkh3mlh09MDR4S8hkgaXi2RK52pdw166eV5NR15Pqw78vYO19m
	5pnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1677854317; x=1677861517; bh=fENpqGS/+8eA5
	DI/UUI0vpXheU20dTSblaG27LRs1wM=; b=S5/UuJmbtsS/NWyXg3Ps3ypf5/t2J
	P263Lmin6EpwJeGdsXY7ll3SIMZ13M5mt47W1zamhNF1Za+SwrlDllq7hyfWwIJF
	E0BALtrYPdg8Wv2JEv+lAFvDlUAVZSUieuhgvoqF6K/ORnQdbKnsVLBgOQyVKQ/a
	1bRA8NkMejJ9bonI4XKeyEv4VEZ41/TS2ho+dfe4t7NIkfh7iQQqDRSgiIxIFf3n
	bEhBuSvaJ2jJnfAd1mf7eTwFir4izLMxvO6ovQo7kuJIcXJXDbPbT17X6F4IdV5F
	eOuCDvuhjDUvFXQRMxhiGcGpV9+x4iWQj01t/RarVARG5rhzaclijqE5Q==
X-ME-Sender: <xms:bQYCZBqQ_OWB-XfeAkakbJrvkOlAPPrdrOfjnoXZNzAAbN2ysnU5_g>
    <xme:bQYCZDrT7oGvvXps_IIKr4EyvuOtztAVxEjjLij73_GjNwXm2pjPb8clAUw7L-et6
    THtA9aJSxq4Fthg0Rc>
X-ME-Received: <xmr:bQYCZONjTuFbLn6b407OWCuogFfuUAkjkP7v-oYKOzKLTSWSB0h0NQ7KAgDn2usbc1W11_Ho64ar_UqZQMVs_dWdJ1SZ2Tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelledgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:bQYCZM7lRZBpN1iCDRWpa8RRIEzCmsRX5qOpjq_60GBkK-GZLyuuIA>
    <xmx:bQYCZA6xZfTwaBxJlNayuRLhTYG2SBHDQ-3PlQ-sVrUwaNBFfq_FGA>
    <xmx:bQYCZEiTLUpDKCmsz6nBVCy-qKZZKeYrjzBlgrYQuNET0iH3p73yMg>
    <xmx:bQYCZDPi_FBzF2yyIJcOR5G-ya25UwN715kOJpXal74DI6neV3tjeA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Mar 2023 09:38:36 -0500 (EST)
Date: Fri, 3 Mar 2023 15:38:35 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-um@lists.infradead.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Message-ID: <20230303143835.hxvkujrdxh7345ah@houat>
References: <20230302013822.1808711-1-sboyd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230302013822.1808711-1-sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_063838_820207_109FCF27 
X-CRM114-Status: GOOD (  20.14  )
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
Content-Type: multipart/mixed; boundary="===============8564824947888441883=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org


--===============8564824947888441883==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxhsbaoummc7j6bf"
Content-Disposition: inline


--zxhsbaoummc7j6bf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 01, 2023 at 05:38:13PM -0800, Stephen Boyd wrote:
> This patch series adds unit tests for the clk fixed rate basic type and
> the clk registration functions that use struct clk_parent_data. To get
> there, we add support for loading a DTB into the UML kernel that's
> running the unit tests along with probing platform drivers to bind to
> device nodes specified in DT.
>=20
> With this series, we're able to exercise some of the code in the common
> clk framework that uses devicetree lookups to find parents and the fixed
> rate clk code that scans devicetree directly and creates clks. Please
> review.
>=20
> I Cced everyone to all the patches so they get the full context. I'm
> hoping I can take the whole pile through the clk tree as they almost all
> depend on each other. In the future I imagine it will be easy to add
> more test nodes to the clk.dtsi file and not need to go across various
> maintainer trees like this series does.

That's really great, thanks!

I wanted to have a look at how we could possibly do this for DRM, I
guess I have a starting point now :)

Maxime

--zxhsbaoummc7j6bf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZAIGawAKCRDj7w1vZxhR
xS33AQD23xSdqBXlBOhJsMv6KYIZ12jQ2GO9rfSeTnQ8xbOokQD/bAnk3DyP7XE/
fGO0wD2U0Tkw7bdC9RO2kuSjjCSIvgk=
=gx7K
-----END PGP SIGNATURE-----

--zxhsbaoummc7j6bf--


--===============8564824947888441883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============8564824947888441883==--

