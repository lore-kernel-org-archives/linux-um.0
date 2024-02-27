Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020CDC54E41
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 20:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aUquLlW0AITQ80jfbVkD6Bw5E1g69IurU+CVZBc41Ew=; b=ie7No68TRC9+ZX/sslRNGKDCgS
	1QOU9EX/1+jmo3VmL2Iyj9OCKrlo5+dhugSjcMjhyfzPRY4cb6iJZ/gxNmd+EM6C/WWkdhEifKvgL
	Bb8m0YeXxEpf/N13a6kwBLpRzyU1KVIH6WvCdiEM76ORpPvAB7A89xtglm6Me4ZHmdD9pN22665QD
	9JJP6f91TRMLiTSQ/HaIsMsx6lzd+NoP3be5EYosM49VR/ZjQjpjHl8LyrqeIFcTodk3dyEB0pxNS
	Gp5+HBZmRB5+pdXbmLRAcWJlGfUkc+SvtRhKTxG8wk/sORlJsQt0QGacyNwaCdNwayMkKKdsTkdNT
	alg+7MwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4RT-00000006oCr-0Knj;
	Tue, 27 Feb 2024 20:52:47 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4RP-00000006oAM-1HGB
	for linux-um@lists.infradead.org;
	Tue, 27 Feb 2024 20:52:45 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 19047626FAEB;
	Tue, 27 Feb 2024 21:52:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id xm0VuJW7DFlB; Tue, 27 Feb 2024 21:52:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6036C626FAEC;
	Tue, 27 Feb 2024 21:52:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ggZPpoQ8IXPq; Tue, 27 Feb 2024 21:52:37 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 31C89626FAEB;
	Tue, 27 Feb 2024 21:52:37 +0100 (CET)
Date: Tue, 27 Feb 2024 21:52:37 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Message-ID: <1749218520.106417.1709067157062.JavaMail.zimbra@nod.at>
In-Reply-To: <20240222072417.3773131-2-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de> <20240222072417.3773131-2-hch@lst.de>
Subject: Re: [PATCH 1/7] ubd: remove the ubd_gendisk array
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove the ubd_gendisk array
Thread-Index: cQzJaZjzWfjjT+4tdF6umrFdswpj1g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_125243_686621_CEF1AECC 
X-CRM114-Status: GOOD (  12.79  )
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
> Gesendet: Donnerstag, 22. Februar 2024 08:24:11
> Betreff: [PATCH 1/7] ubd: remove the ubd_gendisk array

> And add a disk pointer to the ubd structure instead to keep all
> the per-device information together.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 13 ++++---------
> 1 file changed, 4 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 48e11f073551b4..b203ebb1785125 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -125,9 +125,6 @@ static const struct block_device_operations ubd_blops=
 =3D {
> =09.getgeo=09=09=3D ubd_getgeo,
> };
>=20
> -/* Protected by ubd_lock */
> -static struct gendisk *ubd_gendisk[MAX_DEV];
> -
> #ifdef CONFIG_BLK_DEV_UBD_SYNC
> #define OPEN_FLAGS ((struct openflags) { .r =3D 1, .w =3D 1, .s =3D 1, .c=
 =3D 0, \
> =09=09=09=09=09 .cl =3D 1 })
> @@ -165,6 +162,7 @@ struct ubd {
> =09unsigned no_trim:1;
> =09struct cow cow;
> =09struct platform_device pdev;
> +=09struct gendisk *disk;
> =09struct request_queue *queue;
> =09struct blk_mq_tag_set tag_set;
> =09spinlock_t lock;
> @@ -922,7 +920,6 @@ static int ubd_add(int n, char **error_out)
> =09if (err)
> =09=09goto out_cleanup_disk;
>=20
> -=09ubd_gendisk[n] =3D disk;
> =09return 0;
>=20
> out_cleanup_disk:
> @@ -1014,7 +1011,6 @@ static int ubd_id(char **str, int *start_out, int
> *end_out)
>=20
> static int ubd_remove(int n, char **error_out)
> {
> -=09struct gendisk *disk =3D ubd_gendisk[n];
> =09struct ubd *ubd_dev;
> =09int err =3D -ENODEV;
>=20
> @@ -1030,10 +1026,9 @@ static int ubd_remove(int n, char **error_out)
> =09if(ubd_dev->count > 0)
> =09=09goto out;
>=20
> -=09ubd_gendisk[n] =3D NULL;
> -=09if(disk !=3D NULL){
> -=09=09del_gendisk(disk);
> -=09=09put_disk(disk);
> +=09if (ubd_dev->disk) {
> +=09=09del_gendisk(ubd_dev->disk);
> +=09=09put_disk(ubd_dev->disk);
> =09}

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

