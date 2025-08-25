Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EF2CA0FE1
	for <linux-um@archiver.kernel.org>; Mon, 25 Aug 2025 09:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1m6AUFG/wTkANLwgoSYJ+XLDqiRRBYABkW5BsmwGCXk=; b=qlUij12Y5XlsUHQX3S9SWCiP+R
	XOqLAE2sKoNk144Wu86c7RIxd7mrKJNcBp31ky+sCi90yRGelP/BwAcxk4Dd3ykGDRbIPoreILbBC
	OxzRLmv08XOZnuzp3CIvwfy7OFICYFfOuF/XOccrRrtMhcAGgHiNdU6gCJyjvF0rU8vWrwWhJufAU
	JtG/yxNmXiAg5AY0sGuuTHKKE3CudBgtZoGE/hxC4otaaz8RN4bCPbq5FZKdN4afHNSlBA+dLztP2
	TnItpzj9cS2qmP5uSkmqZSWRWXOZMgXMCLK4lzv4p7TKvHfpKkoFGBcafwlXB9kac8JL/VVc3f5Ov
	AHCsCgDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqTcZ-00000007Vv5-1VAi;
	Mon, 25 Aug 2025 09:36:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqSwh-00000007Olv-2Wyi
	for linux-um@lists.infradead.org;
	Mon, 25 Aug 2025 08:52:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1m6AUFG/wTkANLwgoSYJ+XLDqiRRBYABkW5BsmwGCXk=;
	t=1756111973; x=1757321573; b=oaLNxp0w8l49mCocCQBHusUrxwQc/ROhLFewdv/RuyU/pGf
	P50CA+OsU5iBlZsGZqmTiHNW/GRrzH1tNlIllTEeYHeeh/fZAu4cuaAT78HGrBE6ij/0avkNDBqOR
	CQqF12UWCVrsAYmUg9DNfPt7BW8udI5KtjC0rSipLd4h3wkRU+juxA7zVMf1QGapxv4XqkYFUez3r
	mSQ3sj2m56iDSA6qQFErq687yTQX0VLo4Mt5ep29YJej7lxJ8l4cJY4Kq6uNuynR5mrc70fLS6esB
	YAuJy3H0apRA0TOmB0aOcuvTCojyCBpbZeiokUJeSYvIvARrEuZkMSaYSXHm7x2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uqSwa-00000001di6-25uf;
	Mon, 25 Aug 2025 10:52:48 +0200
Message-ID: <6f08683083e113ea31b331288a50f4f2ac5e26b9.camel@sipsolutions.net>
Subject: Re: [PATCH] um: virtio_uml: Fix use-after-free after put_device in
 probe
From: Johannes Berg <johannes@sipsolutions.net>
To: Miaoqian Lin <linmq006@gmail.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, Benjamin Berg
 <benjamin.berg@intel.com>, Tiwei Bie	 <tiwei.btw@antgroup.com>,
 linux-um@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Mon, 25 Aug 2025 10:52:47 +0200
In-Reply-To: <20250804075944.3612712-1-linmq006@gmail.com>
References: <20250804075944.3612712-1-linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_015255_638472_096C89A6 
X-CRM114-Status: GOOD (  16.36  )
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

On Mon, 2025-08-04 at 11:59 +0400, Miaoqian Lin wrote:
> When register_virtio_device() fails in virtio_uml_probe(),
> the code sets vu_dev->registered =3D 1 even though
> the device was not successfully registered.
> This can lead to use-after-free or other issues.
>=20
> Fixes: 04e5b1fb0183 ("um: virtio: Remove device on disconnect")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  arch/um/drivers/virtio_uml.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index ad8d78fb1d9a..c402c4cc908a 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -1250,8 +1250,10 @@ static int virtio_uml_probe(struct platform_device=
 *pdev)
>  	device_set_wakeup_capable(&vu_dev->vdev.dev, true);
> =20
>  	rc =3D register_virtio_device(&vu_dev->vdev);
> -	if (rc)
> +	if (rc) {
>  		put_device(&vu_dev->vdev.dev);
> +		return rc;
> +	}
>  	vu_dev->registered =3D 1;
>  	return rc;
>=20
This should now statically 'return 0' at the end.

johannes

