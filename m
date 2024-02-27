Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F6CC5478C
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 20:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5kBPUco8et2qXrdl08UdbDHl94VMhSWoc88u/fhvDrk=; b=xM3ZvErZurxAHigVD80BjYOgaN
	ulQboSVs0Pr/Kb6Hm8arHrxRidZP+TIn7kWh5dlDVkiSHuFT7uESPqR6jDXYfeC6ay4s0adVN3bOY
	PTgfGQcekgfpPdKW84S3LJi7xYeXEbhNMm1A0pnfZ38t8tD24xoK95toHIH7pNeQmWAD9QH0clrNp
	WmN8LieEo/ChKPOiodmZLjv8LnMIDiNLW9MHirg14g8TnOCDLHr8KWUkYqCBtQG8dCQbAKcLp4UbH
	zTAMxlZvLfO2TXJUIXOLGpOWbsXzeOMnTNx8Ypwhf3xm2ooEVR5BEwnTQQC7ftI6iemFQzGp7qnK/
	353WP1NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4V4-00000006pD7-3Le5;
	Tue, 27 Feb 2024 20:56:30 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4V2-00000006pCR-35NW
	for linux-um@lists.infradead.org;
	Tue, 27 Feb 2024 20:56:30 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6A8CF626FAEC;
	Tue, 27 Feb 2024 21:56:27 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id dtcQozzQnhL2; Tue, 27 Feb 2024 21:56:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9C9D0626FAED;
	Tue, 27 Feb 2024 21:56:26 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SqyNk_nJrkyY; Tue, 27 Feb 2024 21:56:26 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 77208626FAEB;
	Tue, 27 Feb 2024 21:56:26 +0100 (CET)
Date: Tue, 27 Feb 2024 21:56:26 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Message-ID: <306297747.106429.1709067386425.JavaMail.zimbra@nod.at>
In-Reply-To: <20240222072417.3773131-3-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de> <20240222072417.3773131-3-hch@lst.de>
Subject: Re: [PATCH 2/7] ubd: remove ubd_disk_register
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove ubd_disk_register
Thread-Index: rutuY9luSWaac74DXZFMS4wfUpai5g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_125629_096988_E23913F7 
X-CRM114-Status: GOOD (  10.91  )
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
> Gesendet: Donnerstag, 22. Februar 2024 08:24:12
> Betreff: [PATCH 2/7] ubd: remove ubd_disk_register

> Fold it into the only caller to remove lots of references to the
> global ubd_devs array.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 37 +++++++++++++++----------------------
> 1 file changed, 15 insertions(+), 22 deletions(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index b203ebb1785125..ef05157acd6b02 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -849,27 +849,6 @@ static const struct attribute_group *ubd_attr_groups=
[] =3D {
> =09NULL,
> };
>=20
> -static int ubd_disk_register(int major, u64 size, int unit,
> -=09=09=09     struct gendisk *disk)
> -{
> -=09disk->major =3D major;
> -=09disk->first_minor =3D unit << UBD_SHIFT;
> -=09disk->minors =3D 1 << UBD_SHIFT;
> -=09disk->fops =3D &ubd_blops;
> -=09set_capacity(disk, size / 512);
> -=09sprintf(disk->disk_name, "ubd%c", 'a' + unit);
> -
> -=09ubd_devs[unit].pdev.id   =3D unit;
> -=09ubd_devs[unit].pdev.name =3D DRIVER_NAME;
> -=09ubd_devs[unit].pdev.dev.release =3D ubd_device_release;
> -=09dev_set_drvdata(&ubd_devs[unit].pdev.dev, &ubd_devs[unit]);
> -=09platform_device_register(&ubd_devs[unit].pdev);
> -
> -=09disk->private_data =3D &ubd_devs[unit];
> -=09disk->queue =3D ubd_devs[unit].queue;
> -=09return device_add_disk(&ubd_devs[unit].pdev.dev, disk, ubd_attr_group=
s);
> -}
> -
> #define ROUND_BLOCK(n) ((n + (SECTOR_SIZE - 1)) & (-SECTOR_SIZE))
>=20
> static const struct blk_mq_ops ubd_mq_ops =3D {
> @@ -916,7 +895,21 @@ static int ubd_add(int n, char **error_out)
> =09ubd_dev->queue =3D disk->queue;
>=20
> =09blk_queue_write_cache(ubd_dev->queue, true, false);
> -=09err =3D ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, disk);
> +=09disk->major =3D UBD_MAJOR;
> +=09disk->first_minor =3D n << UBD_SHIFT;
> +=09disk->minors =3D 1 << UBD_SHIFT;
> +=09disk->fops =3D &ubd_blops;
> +=09set_capacity(disk, ubd_dev->size / 512);
> +=09sprintf(disk->disk_name, "ubd%c", 'a' + n);
> +=09disk->private_data =3D ubd_dev;
> +
> +=09ubd_dev->pdev.id =3D n;
> +=09ubd_dev->pdev.name =3D DRIVER_NAME;
> +=09ubd_dev->pdev.dev.release =3D ubd_device_release;
> +=09dev_set_drvdata(&ubd_dev->pdev.dev, ubd_dev);
> +=09platform_device_register(&ubd_dev->pdev);
> +
> +=09err =3D device_add_disk(&ubd_dev->pdev.dev, disk, ubd_attr_groups);
> =09if (err)
> =09=09goto out_cleanup_disk;
>=20
> --
> 2.39.2

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

