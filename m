Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A4EC5478C
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 20:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Rp5Sc9uNeMCKLWDCUqd93s9klRQ581fu8KumeyEJlk=; b=qlYJQTWNU5NaNFXmuvB7R2Dcvo
	rBL9xi2FtOWmaWKM4LArvsSXBgTerNs2J8kGbCUZkqIppFEWp2Zw9m7k8YWSCpIN9SDkmToVzMnB0
	YfMtwrWZAR14z0xY4OxbOgkEYFhQci/5mTOMhdZOkQX0CvraddnkHCsalXF920Z9wDk2jSA7Pv3Hu
	AhjPqOzSyzkXLnva1Rzh+e34j5ALCXis4Gb4m4XuvR43NlUbj8dehC/ShJU2eTDOvLGhBPoEMJgf3
	PQxhZS32GLC4O6PGeNzQh5mgmXynh+mHryvy9tjqx6CfWARwLOf8cqELYRVVWqnRLYBYBCEGC+q2+
	1P2wxxwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4Va-00000006pMc-1SjQ;
	Tue, 27 Feb 2024 20:57:02 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4VW-00000006pKh-0xHe
	for linux-um@lists.infradead.org;
	Tue, 27 Feb 2024 20:57:00 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id F1EA8626FAEB;
	Tue, 27 Feb 2024 21:56:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id RVSmNgG98wh8; Tue, 27 Feb 2024 21:56:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7C546626FAEC;
	Tue, 27 Feb 2024 21:56:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 62E8tI1qTf8e; Tue, 27 Feb 2024 21:56:56 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 62824626FAEB;
	Tue, 27 Feb 2024 21:56:56 +0100 (CET)
Date: Tue, 27 Feb 2024 21:56:56 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Message-ID: <111902167.106431.1709067416335.JavaMail.zimbra@nod.at>
In-Reply-To: <20240222072417.3773131-4-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de> <20240222072417.3773131-4-hch@lst.de>
Subject: Re: [PATCH 3/7] ubd: move setting the nonrot flag to ubd_add
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: move setting the nonrot flag to ubd_add
Thread-Index: x3CSSu93fOe0aYDkXECY8+iHhLZ0rw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_125658_447547_33866A99 
X-CRM114-Status: GOOD (  10.57  )
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
> Gesendet: Donnerstag, 22. Februar 2024 08:24:13
> Betreff: [PATCH 3/7] ubd: move setting the nonrot flag to ubd_add

> No reason to delay this until open time.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index ef05157acd6b02..9dcf41f7d49606 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -799,7 +799,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
> =09=09blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
> =09=09blk_queue_max_write_zeroes_sectors(ubd_dev->queue, UBD_MAX_REQUEST)=
;
> =09}
> -=09blk_queue_flag_set(QUEUE_FLAG_NONROT, ubd_dev->queue);
> =09return 0;
>  error:
> =09os_close_file(ubd_dev->fd);
> @@ -894,6 +893,7 @@ static int ubd_add(int n, char **error_out)
> =09}
> =09ubd_dev->queue =3D disk->queue;
>=20
> +=09blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
> =09blk_queue_write_cache(ubd_dev->queue, true, false);
> =09disk->major =3D UBD_MAJOR;
> =09disk->first_minor =3D n << UBD_SHIFT;
> --
> 2.39.2

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

