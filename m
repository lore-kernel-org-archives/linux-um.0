Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AF3C4345F
	for <linux-um@archiver.kernel.org>; Mon, 29 Apr 2024 07:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gb5xLtWOxE9un2JnExAd6iMl7g/nevE9f6En12Sjloo=; b=t5jJ0+7DWly1J8+TC5DuwS+UCh
	13zzCPcZ4dPJQLxlmZvzYYvEfLodufRfELphtKFZe1peDdZFnlAb+EZB9ohb55RCtyQ34Gli4lr5a
	wfBggr7/8zoEf+HfuFKM3FN7jWbPHqQAa+FIB/r3vfFtfV16J3cKvufAdYtDMbNTI2WcaP6e4+RYU
	T4s6iLODcaIwteeIP4RZVG5kWewE8WJH+LEdx0spJM1++Mi2lALdgHV8YmJ9zfaKyV/U6FeRqZwQS
	S2JhdeFqjLXwaJ3xShCoNuF00BcvqM5EJukoLHQJXwY7A46GAfgUmYbQ9QAsA+Cfvp6PKL1MIIur3
	pok7JRNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1LYO-00000001qSt-28oF;
	Mon, 29 Apr 2024 07:36:00 +0000
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1LYK-00000001qRi-3i7u
	for linux-um@lists.infradead.org;
	Mon, 29 Apr 2024 07:35:58 +0000
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1LYE-0006TI-Ot; Mon, 29 Apr 2024 09:35:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1LYD-00EwBX-UZ; Mon, 29 Apr 2024 09:35:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s1LYD-00BEOz-2n;
	Mon, 29 Apr 2024 09:35:49 +0200
Date: Mon, 29 Apr 2024 09:35:49 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 0/2] um: Convert to platform remove callback returning
 void
Message-ID: <4bxrtz7jnavmzplkiwzpq62omswpfbogd2pep7ju4jlbum6ccr@xbegqcpfmnf2>
References: <cover.1710056894.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ujyffovslh4vjpsa"
Content-Disposition: inline
In-Reply-To: <cover.1710056894.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_003557_055347_D4496A4A 
X-CRM114-Status: GOOD (  13.31  )
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


--ujyffovslh4vjpsa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Richard,

On Sun, Mar 10, 2024 at 08:52:26AM +0100, Uwe Kleine-K=F6nig wrote:
> this series converts all platform drivers below arch/um to stop using
> struct platform_driver::remove(). See commit 5c5a7680e67b ("platform:
> Provide a remove callback that returns no value") for an extended
> explanation and the eventual goal.
>=20
> Both conversations are trivial, because the driver's .remove() callbacks
> returned zero unconditionally.
>=20
> There are no interdependencies between these patches, still I'd expect
> them to be picked up together.

I intend to send the change to struct platform_driver::remove() to Greg
soon after the upcoming merge window closed. It would be great if these
patches made it in before. If not, I'll ask Greg to apply these patches
together with the change to platform_driver::remove(). If that's your
preferred resolution, feel free to send an Ack for that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ujyffovslh4vjpsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYvTdQACgkQj4D7WH0S
/k7qdQf/fY9oAPw7+jEdKjMYynIfSsCVkxme8ScdvgOFT11FonWdx49jLBrah2Ox
GYnjHVOfpY5ihPtIAHSsZq2X2dS4wBwQL5Wyz0abDUTJXBZw6j9yCSDUiZo1V50v
z3j+yvomPVhXOZ/XaTUz4zSXSVh2/OZWUD8DDyV7+MoSHmySBqdcyIHM3/e3OQMy
Ix00xvb7X2Q2W4uJe8jBhvJIsWZBDK//SqVZL5pIlJ2c07h2c7Dh768YhsrtsWX6
1IAAJYlvEMzEw0YOE7+Qvf+nWwQDrf7Nw0iO7yeFTbW+NVtgQquY1MqlQyoSzUJc
MkMVfMKzTlKas0Z4HQrWzUvutP682g==
=TVE/
-----END PGP SIGNATURE-----

--ujyffovslh4vjpsa--

