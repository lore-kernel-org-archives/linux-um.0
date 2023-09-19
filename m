Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2B8CE79AE
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 23:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cCGeR/vkuw0AeILxB8B6GpRhs9w7eERx4DGlVCV5FtA=; b=I3rNXXs7MgaKvrHhVSfhaFbUIe
	tvuD6XvAk6Fy5BpdavHAwBVan/J1knq90Z34cO9F8LP7Cl0lFJruo7Id8PPGioW2wCgZI17kpKkf9
	KdGgVbjOmTFHNs6Emkr9GIrO2niTBfVaHvcllNPnH4zdI3O5C/JjENlp+A2ApyRZBNrB6kWA6Ra6b
	P2iu5/osiYOjmiXWLQepbfvMfGfmldgT3BqmM52gxfg85+BTt25q5rt1q1po6GEjFzfkdeYrljeGv
	CZPrnnfG08VLCTq+7Ier2nrRg8LDyoHtflSkuHN9U/ixVLuSqXTJWgEZDv2r8d+Lt682fS1zlX9+U
	bJg5Ik/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qijzi-001RqD-2y;
	Tue, 19 Sep 2023 23:19:02 +0000
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3] helo=gandalf.ozlabs.org)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qijzf-001Rni-23
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 23:19:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1695165518;
	bh=xY1RGG+/0gscDLeveLulvpHm4mxxLb1AS3ZtO6C8wPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u7IryiMQCWMYh8OgqVTiLRag6b+LKE68Td/Fqt2t8ejVaZYhpSZivUyUCXZfEyUNE
	 KHYL90KSWCsmmFQmSKkU1Gn2t4Hl94ykWXllMSALprpWlo/CsAaQKep5yDwZJR8SNs
	 31VSETOISiQ4DIHaS9I0eBmunvRBq8hRym1IgApCYaGfYEHTDFpdonLS7MMMJYypJH
	 bhoPRtQIvzxG8/wMJxLKiNBQqFxsi8sivCfho6fFSOQqmfCMwDfHINpnwFKlzkObfq
	 s3ws8q7IoAhampFqNxZfHJkdb5E0WEHZZmuA1BkruLzUt38h21e05w1PZPnxb0sDtr
	 aWCVZIDgahaMg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RqyJs0gcBz4x2X;
	Wed, 20 Sep 2023 09:18:36 +1000 (AEST)
Date: Wed, 20 Sep 2023 09:18:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>,
 Mike Rapoport <rppt@kernel.org>, llvm@lists.linux.dev
Subject: Re: linux-next: Tree for Sep 19 (UML)
Message-ID: <20230920091714.10053ba5@canb.auug.org.au>
In-Reply-To: <ZQoQLJnGFxjA8p5E@google.com>
References: <20230919163728.78432283@canb.auug.org.au>
	<04b8a6de-2b20-4488-b20f-c8a8f6001fd2@infradead.org>
	<ZQoQLJnGFxjA8p5E@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_161859_841745_2FB06569 
X-CRM114-Status: GOOD (  17.29  )
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
Content-Type: multipart/mixed; boundary="===============1567156470532572252=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--===============1567156470532572252==
Content-Type: multipart/signed; boundary="Sig_/8qozy5L20AH8hxRIxoLg6wM";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8qozy5L20AH8hxRIxoLg6wM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Tue, 19 Sep 2023 14:18:36 -0700 Nick Desaulniers <ndesaulniers@google.co=
m> wrote:
>
> On Tue, Sep 19, 2023 at 08:42:07AM -0700, Randy Dunlap wrote:
> >=20
> > on i386 or x86_64:
> >=20
> > ../arch/x86/um/../kernel/module.c: In function 'execmem_arch_params':
> > ../arch/x86/um/../kernel/module.c:54:50: error: implicit declaration of=
 function 'kaslr_enabled'; did you mean 'kasan_enabled'? [-Werror=3Dimplici=
t-function-declaration]
> >    54 |         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_enabled(=
))
> >       |                                                  ^~~~~~~~~~~~~
> >       |                                                  kasan_enabled
> >=20
> >=20
> >=20
> > git blames this on:
> >=20
> > commit 12633d679796
> > Author: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date:   Tue Sep 19 15:14:03 2023 +1000
> >=20
> >     Revert "arch: make execmem setup available regardless of CONFIG_MOD=
ULES"
> >    =20
> >     This reverts commit 3300c3af20090ff5e03e5c4bf2ef2cfaa03d4e9b. =20
>=20
> Thanks for the report, FWIW, our CI is hitting this, too.
>=20
> Was 12633d679796 a pure revert, or was it manually modified?

It was a pure revert due to having to revert a previous commit to fix a
boot warning.  These reverts should not need to be in the next
linux-next as a patch has been applied to the appropriate included tree
to fix the boot warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/8qozy5L20AH8hxRIxoLg6wM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUKLEQACgkQAVBC80lX
0GxoOQf/XQ7ER7U9A6iIEj9PX4LP6EQ/HJ58Pci1hVo+3wldY5AcTdhqK6i4QXwa
xTyJfM/SDomXy+CiVDcLbl6x3Ep6xR1OKq0X1UITnkAFlzxPqpbWjDhVdWpCTNW1
It3Ollb830saEKbHXeg0yYguhXT7xnBnp18O1qqfHlzkh7RP7ZptTGySM3x/WI+J
W2ZUnsaMDBdHyApjTWvWJySVah7qzDAPugZ2AVNW0JptXNOOQFxkyOnllLAtTMcf
LhYQYK0uhbOCzQFxRCSHR9u5+aNmO4c7+ik1+GYccuUYV5jnyKBj9u89W5o48Fyz
vdzEljIWSpee4gAaGr+exX9mIDQvdg==
=1tlz
-----END PGP SIGNATURE-----

--Sig_/8qozy5L20AH8hxRIxoLg6wM--


--===============1567156470532572252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============1567156470532572252==--

