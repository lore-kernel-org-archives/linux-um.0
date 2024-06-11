Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3572C27C65
	for <linux-um@archiver.kernel.org>; Tue, 11 Jun 2024 20:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B0rl8Td1i4C9v40xEQ0LWotvAtfVKB9RrCYRfWasDSk=; b=h7tHfDXjal8MuV8rpQrACatlCX
	TWmgKuZEJpdNrDLoyP/gKMIJJhfZMj5jkkp81EkTvU7kxOCR//vS1ffPdsRyMhfwtzFJto3IG5cSE
	u/PFNKyHUfzp+MaoDS+cOR57ux1/CeUWh8EonJj0fZnhbLM3pbI9XisJmUZao1Wv6BQiVHThXLpG7
	7QMthdcmiyqZ9WYGiEzFZ0VrNFoAxBiKK6jMIo1caPgnaDugjeGzEORRIL/RM56DyuS6S/8Ho7t0i
	gdoQJry0xn2jHW9raiKVw8RrsJQydxd4PKNEyCR9pSXmwxVep6x2nWfo41MvKKbFfaVZt5PBN0eLy
	ahHIBaSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH7xW-0000000A9TA-1vux;
	Tue, 11 Jun 2024 20:19:10 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH7xS-0000000A9Rj-3r8M
	for linux-um@lists.infradead.org;
	Tue, 11 Jun 2024 20:19:08 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id AF47061966B5;
	Tue, 11 Jun 2024 22:19:03 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id X-qeMHHyOscx; Tue, 11 Jun 2024 22:19:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C464D61966BF;
	Tue, 11 Jun 2024 22:19:02 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y9093tRPmx8Q; Tue, 11 Jun 2024 22:19:02 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id A1B3F61966B8;
	Tue, 11 Jun 2024 22:19:02 +0200 (CEST)
Date: Tue, 11 Jun 2024 22:19:02 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Hongbo Li <lihongbo22@huawei.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2144113714.220205.1718137142446.JavaMail.zimbra@nod.at>
In-Reply-To: <20240611-hostfs-fix-mount-api-conversion-v1-1-ef75bbc77f44@kernel.org>
References: <20240611-hostfs-fix-mount-api-conversion-v1-1-ef75bbc77f44@kernel.org>
Subject: Re: [PATCH] hostfs: Add const qualifier to host_root in
 hostfs_fill_super()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: hostfs: Add const qualifier to host_root in hostfs_fill_super()
Thread-Index: y+ZRrqRbHMaINlAXXO3Imv4O2bKOCA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_131907_168552_A9E92618 
X-CRM114-Status: UNSURE (   6.67  )
X-CRM114-Notice: Please train this message.
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

----- Urspr=C3=BCngliche Mail -----
> Von: "Nathan Chancellor" <nathan@kernel.org>
> An: "Christian Brauner" <brauner@kernel.org>
> CC: "Hongbo Li" <lihongbo22@huawei.com>, "richard" <richard@nod.at>, "ant=
on ivanov" <anton.ivanov@cambridgegreys.com>,
> "Johannes Berg" <johannes@sipsolutions.net>, "linux-um" <linux-um@lists.i=
nfradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "Nathan Chancellor" <nathan@kernel.org>
> Gesendet: Dienstag, 11. Juni 2024 21:58:41
> Betreff: [PATCH] hostfs: Add const qualifier to host_root in hostfs_fill_=
super()

> After the recent conversion to the new mount API, there is a warning
> when building hostfs (which may be upgraded to an error via
> CONFIG_WERROR=3Dy):
>=20
>  fs/hostfs/hostfs_kern.c: In function 'hostfs_fill_super':
>  fs/hostfs/hostfs_kern.c:942:27: warning: initialization discards 'const'
>  qualifier from pointer target type [-Wdiscarded-qualifiers]
>    942 |         char *host_root =3D fc->source;
>        |                           ^~
>=20
> Add the 'const' qualifier, as host_root will not be modified after its
> assignment. Move the assignment to keep the existing reverse Christmas
> tree order intact.
>=20
> Fixes: cd140ce9f611 ("hostfs: convert hostfs to use the new mount API")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

