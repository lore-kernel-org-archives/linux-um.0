Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B88DC5478C
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 21:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q9Ask/33/8BhS8tPZSxX1z3/gMbYUmr295EQwJa4S0c=; b=ZW3Czxg4q+wXNakoITa9OPFctt
	4ibTcnJbrIKB4hzVAB8dPRmXZ/whkg9gPiSefX9jGWZbLfT+l3sjYL41/Ap62wzcS508I0SMHrQ7l
	J90OTdr4fr96u9Z814r20WVOctDbHF8EEvcOykdQbzGDFC01fuHP+c+jUTFj6G3LzM2EgrmYFKna0
	MwApDd/4+oWZBls2PkzTLRuAObVkcC2x0R8vouRjkCmwllRam0iSkvC3gdsjybDh22ba3jOZS4v56
	K6DFbqBr8xxJ2gXCXh4hOFr5KzpL3X19ZAIclByOcDwsJVddagoQ/ydzLeCsNj5Z7Z2EGaUmX2Qzm
	t3sK4joQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4Yb-00000006pw2-3YQG;
	Tue, 27 Feb 2024 21:00:09 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4YZ-00000006pvM-0swK
	for linux-um@lists.infradead.org;
	Tue, 27 Feb 2024 21:00:08 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 89A4A626FAEB;
	Tue, 27 Feb 2024 22:00:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0HrLx_8q8I2T; Tue, 27 Feb 2024 22:00:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 869B7626FAEC;
	Tue, 27 Feb 2024 22:00:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qHr-r-fSkg-s; Tue, 27 Feb 2024 22:00:04 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 30846626FAEB;
	Tue, 27 Feb 2024 22:00:04 +0100 (CET)
Date: Tue, 27 Feb 2024 22:00:03 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Message-ID: <254176725.106438.1709067603867.JavaMail.zimbra@nod.at>
In-Reply-To: <20240222072417.3773131-5-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de> <20240222072417.3773131-5-hch@lst.de>
Subject: Re: [PATCH 4/7] ubd: move setting the variable queue limits to
 ubd_add
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: move setting the variable queue limits to ubd_add
Thread-Index: gszs01OAM/HMQeDXBm0jy7JIC/bqkA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_130007_458456_57D2E4AD 
X-CRM114-Status: GOOD (  10.93  )
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
> Von: "hch" <hch@lst.de>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>, "Jens Axboe" <axboe@kernel.dk>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-block" <linux-block=
@vger.kernel.org>
> Gesendet: Donnerstag, 22. Februar 2024 08:24:14
> Betreff: [PATCH 4/7] ubd: move setting the variable queue limits to ubd_a=
dd

> No reason to delay this until open time.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 9dcf41f7d49606..26bc8306356263 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -772,8 +772,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
> =09ubd_dev->fd =3D fd;
>=20
> =09if(ubd_dev->cow.file !=3D NULL){
> -=09=09blk_queue_max_hw_sectors(ubd_dev->queue, 8 * sizeof(long));
> -
> =09=09err =3D -ENOMEM;
> =09=09ubd_dev->cow.bitmap =3D vmalloc(ubd_dev->cow.bitmap_len);
> =09=09if(ubd_dev->cow.bitmap =3D=3D NULL){
> @@ -795,10 +793,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
> =09=09if(err < 0) goto error;
> =09=09ubd_dev->cow.fd =3D err;
> =09}
> -=09if (ubd_dev->no_trim =3D=3D 0) {
> -=09=09blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
> -=09=09blk_queue_max_write_zeroes_sectors(ubd_dev->queue, UBD_MAX_REQUEST=
);
> -=09}
> =09return 0;
>  error:
> =09os_close_file(ubd_dev->fd);
> @@ -867,6 +861,13 @@ static int ubd_add(int n, char **error_out)
> =09if(ubd_dev->file =3D=3D NULL)
> =09=09goto out;
>=20
> +=09if (ubd_dev->cow.file)
> +=09=09lim.max_hw_sectors =3D 8 * sizeof(long);
> +=09if (!ubd_dev->no_trim) {
> +=09=09lim.max_hw_discard_sectors =3D UBD_MAX_REQUEST;
> +=09=09lim.max_write_zeroes_sectors =3D UBD_MAX_REQUEST;
> +=09}
> +
> =09err =3D ubd_file_size(ubd_dev, &ubd_dev->size);
> =09if(err < 0){
> =09=09*error_out =3D "Couldn't determine size of device's file";
> --
> 2.39.2

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

