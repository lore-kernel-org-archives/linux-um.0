Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94803C54E5D
	for <linux-um@archiver.kernel.org>; Tue, 12 Mar 2024 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8h4RdBG4H4wo3dPKJ/gxdCxliuUCqdaNqph0X0M6bTU=; b=froQe7MbCfpXAOcg6/isdDpwPG
	LDfw+by9JqiLYr3+w3gR/ZRuDQcUD5rmBz02TCGk8vCfVeWiwmHqsaC2pm8ukktWqXwG7SjYGz6SF
	baQrbzQ0vt93egY+uz2XSaOvdO/WEGbKIAMuA3opzdcAe8dMmbewVryO3yFt/w+L7oicWuyuq/RS0
	odF4dV5QpaGElyv+ILUWFvyEaOCPvH/wv+L22xJe6rNvyl00TYKH6Nr0/w6EEoJdp/x2F9PA2Y5ZG
	4prE99eaJ0Q3XQwzALpBozsDCvVKM4coLh+TEPVnF8ThzpBJX8JRgXLlOICiwUqChv6UXVQS5HkLV
	Ml1sa8KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Ml-00000006BkH-2Srs;
	Tue, 12 Mar 2024 14:44:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Mh-00000006BiO-2o6z;
	Tue, 12 Mar 2024 14:44:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 798706120A;
	Tue, 12 Mar 2024 14:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9E7C433C7;
	Tue, 12 Mar 2024 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710254666;
	bh=Dy35dwPt2qxF2qUUrlFwaycsRiwdy9dn4pHsT5ZLSGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aukJ/eNkN+YxIpLAdDkVRaOAwmdrbNrNZgs82sjROJOwJ1cRhWzZAp3hKMU0o6by+
	 ClTlHTyUvbdjvyY4/G74hRToq/cZ9BrgDhaB+HPsKPBThz5V0mnvS4Q4WgBQvcptpR
	 04z6b6XP7us+6me/XmilaA8rQnRctidem5GuYEJRvHPnybkiiNXO4JEYbRUM4OiaPY
	 UFJRlCI98zvgAzsZLe3qUDx3DzX1Q/Ugn7gqlwF7kxh6x+dvQaqjTZDbJmQj3umXD3
	 1PXAX/9vH+gF3+GRdcEgLVCtkdJFbDDShjF9MVbGV0IHrKEFATopahqSygkBb4KvY3
	 s3KPe9CIlkidg==
Date: Tue, 12 Mar 2024 14:44:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	"Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: Re: [PATCH 2/7] of: Create of_root if no dtb provided by firmware
Message-ID: <e83b606a-e34e-423f-b26b-df745052d06b@sirena.org.uk>
References: <20240217060843.GA16460@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAL_Jsq+Feu9NnzTNx=XU5vgHhibGAQXvkuTeWbpu8gJ3rVrzcw@mail.gmail.com>
 <CAMuHMdUKa-KdWfYswEpFvj3RjQPM+ThhU85myfBGVkXxZqbHWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A8PYQDEZ5U6Pm1op"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUKa-KdWfYswEpFvj3RjQPM+ThhU85myfBGVkXxZqbHWw@mail.gmail.com>
X-Cookie: Oh, so there you are!
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_074427_775835_5A5470AE 
X-CRM114-Status: GOOD (  13.32  )
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


--A8PYQDEZ5U6Pm1op
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 03:41:32PM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 21, 2024 at 3:06=E2=80=AFPM Rob Herring <robh+dt@kernel.org> =
wrote:

>     static int __init regulator_init_complete(void)
>     {
>             /*
>              * Since DT doesn't provide an idiomatic mechanism for
>              * enabling full constraints and since it's much more natural
>              * with DT to provide them just assume that a DT enabled
>              * system has full constraints.
>              */
>             if (of_have_populated_dt())
>                     has_full_constraints =3D true;
>=20
>             ...
>     }
>     late_initcall_sync(regulator_init_complete);

> (The latter looks a bit futile, as have_full_constraints() already
>  contains a check for of_have_populated_dt()?)

Yes, it's duplicated and we should remove it.

--A8PYQDEZ5U6Pm1op
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXwakIACgkQJNaLcl1U
h9A8ewf+MxFaGvrtn8DK977EqCU2BEx8094DvO7eMo0nyAJUm2gxwqKrhgdxDEFY
I0g6tj4LKJmyrLH4jH1T84U85aVm9il1PX4OUNyIHtHqrTvZuxonx1hbMfHWnq4d
varya5+YeCMfo3B8heD4RSSmX4ewG6Jgb+IeDl/Jn8On2Pys75Sh1Bk8mbbunG+H
pOK8gTFj5jOaR6JoX/gsoYsifocZ0s96AqUqmk+i7zxdX6qJhGDaD7azW/qhJAUv
+E/x/KzOuerVx8mX2drUIR9jk/s1+t3mgTJZKAYoGUDW2PwG9wPb8tqtofX2ghXU
ZgSshLDLKjTalXEyonUkGEadKnNxmA==
=/ZcU
-----END PGP SIGNATURE-----

--A8PYQDEZ5U6Pm1op--

