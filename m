Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB67C64ED8
	for <linux-um@archiver.kernel.org>; Wed,  8 Feb 2023 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f6HSJ5iWUZ3h9AV2nKhkRbR98C209GeDhUJdRSIActE=; b=dkaExTJaVTxM6S3ujJpO+Sx2R4
	p3/5we+FgO35KJqHXx30/GGDVEClxcNyWRFrinObzDkyJcijUY46qofW6GcHEX+R589qx96gJA3Uc
	5J0zHKoeSKlYuzfkCdwu2UBiU4ni0WohDnjkNyaaBahESZBGjj7c7hVXP6ItTGCMO7SxFd9yY9Zf5
	GsJAhDolN3t0SCJCx10B+rMlNZbfgodNoOA3O9Fij6Jczp5fLqiBk4d3qgDqTxPqyGpJcWl1BXESC
	Wz7zis4zhYXYuIHOMboUr7KXGnS6P+uzEKFov1EyjlmZwi3/kfvs7CvFvTywpupCEQoCzJ8E1R9GB
	Wtbvu+Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPnUO-00GHif-DK; Wed, 08 Feb 2023 16:40:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPnUC-00GHeG-FE; Wed, 08 Feb 2023 16:39:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DD4546172F;
	Wed,  8 Feb 2023 16:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C217C433EF;
	Wed,  8 Feb 2023 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675874394;
	bh=k2WDmJefTVbmF4UtYjVTRVt38vEfq5VHOD9s78R7eyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rm1BIDwVjM+vtyitHjo1e7C/8O3osDSw3ddUWkl4Wx2bC5t9PAYPPNOMyPOnhDGBE
	 x0/ntl8Z+mYIwUFJ4SJYgRaphWg6Yt4w739Gu/lXfntdZ6JeZX0Y+rfAbGvNs2ZHt8
	 st0eJcGbt8o4IXvW5Pd80HgnuHqj+dz7ZtRrgPBzs0UpJBQvPfkACmHMCJmVksp2u1
	 7j+OBIBzFLzMDdGcGKQCjlEbr0xBVw1CpjWop+Te/iJBfsS4i7ncKglT5iTBbI8VBo
	 HOM9qBR39AlYqQf2ZmUflFWYvSQAKch5roLODmzzrvB8D8QMKelVKI/xJc21XFfhdD
	 dus+tchf6H0SA==
Date: Wed, 8 Feb 2023 16:39:44 +0000
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>, John Hubbard <jhubbard@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@linux.ibm.com>, Yang Shi <shy828301@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, Nadav Amit <namit@vmware.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, x86@kernel.org,
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH mm-unstable v1 04/26] arm/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Message-ID: <Y+PQUMwH4AZSVpjb@sirena.org.uk>
References: <20230113171026.582290-1-david@redhat.com>
 <20230113171026.582290-5-david@redhat.com>
 <Y+GcDFMNHw2cdDN1@sirena.org.uk>
 <39fd91e3-c93b-23c6-afc6-cbe473bb0ca9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <39fd91e3-c93b-23c6-afc6-cbe473bb0ca9@redhat.com>
X-Cookie: Walk softly and carry a megawatt laser.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_083956_625416_37DF7673 
X-CRM114-Status: GOOD (  19.53  )
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
Content-Type: multipart/mixed; boundary="===============2943146016649335312=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org


--===============2943146016649335312==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W0tQR/5xWRekS1hu"
Content-Disposition: inline


--W0tQR/5xWRekS1hu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 03:12:06PM +0100, David Hildenbrand wrote:
> On 07.02.23 01:32, Mark Brown wrote:

> > Today's -next (and at least back to Friday, older logs are unclear - I
> > only noticed -next issues today) fails to NFS boot on an AT91SAM9G20-EK
> > (an old ARMv5 platform) with multi_v5_defconfig, a bisect appears to
> > point to this patch (20aae9eff5acd8f5 in today's -next) as the culprit.

> It's been in -next for quite a while, thanks for the report!

Yeah, there's been some other things obscuring the issue.

> Could you give the following a test?
>=20
>=20
> From 8c4bdbd9862f85782d5919d044c172b584063e83 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Wed, 8 Feb 2023 15:08:01 +0100
> Subject: [PATCH] arm/mm: Fix swp type masking in __swp_entry()
>=20
> We're masking with the number of type bits instead of the type mask, which
> is obviously wrong.

Tested-by: Mark Brown <broonie@kernel.org>

but note that I had to manually apply it, though it's pretty trivial so
I probably applied the right thing.

--W0tQR/5xWRekS1hu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPj0FAACgkQJNaLcl1U
h9C7hQf/VKRwP16M1jInUqUdUtyzPdvalnHTpasxKVZ8Sy0U3jwXMqNUqmnpEOSO
UB3Q8audVEzRc8pj92dk3jilZBDPHyP58UUKRsjkrZVz22Q2/R16FcjaLrdlwNlj
GWMfEWv5OKYPHaxP4W/VX0sXzS0XMTuulvAF1BOQRlOAS3L3jYsYUtzI2pkzJm1G
64ICND0ZQRerzQmdQd6oO2tVhymhv8Y1LPY4TT0HikINGVpwwCJoOiocmstgqqGW
uE+M+XJ9Lp/p78SIjfccjF1rdCWlc5MJJLS/qZzYnm6OnkKMOlBAUX9bwqvyrvE9
quDK6fshhrFo/uJ5YVAQnAEuDKLv9g==
=rC9E
-----END PGP SIGNATURE-----

--W0tQR/5xWRekS1hu--


--===============2943146016649335312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============2943146016649335312==--

