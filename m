Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC76AC5478C
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 21:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eNHvNTPjAf2BcKVNlj1XiUAeeg+PuV9WuAs0hX5itZU=; b=Qh+vLjghLial26i9P6ECiohr2P
	lgkcanUer+RGp3AmvQ4/v1GUWgj15aFxK5aOJ45ZGrZ2Osnh0s0BkHBwAaKVkcxDFw2DlmC83eY6+
	YtDPdtMKIMiqblU5S5Ch+owYtm1ifz6QpQm2FOsPX0EI0iCFziUeuL2EmPt/XTenI97Esxj/q2p+7
	WCtrPHZHaW3vwxnQFC8umWuVbvau8DCLCfwIfBWiIKPXDiyjCeYtWD4tjNAtk0a3blKbWa2DHiKOB
	r1VIFHtf1zM8eTnGQCv1OF2QNy1b8RJj3EcDoWi4K7aWrU5r1la5khV8PU1pEx8oGpf2CPmFwXQPZ
	SiAky5MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4ZY-00000006qDs-1z3n;
	Tue, 27 Feb 2024 21:01:08 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4ZV-00000006qBW-28FI
	for linux-um@lists.infradead.org;
	Tue, 27 Feb 2024 21:01:06 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 49F98626FAED;
	Tue, 27 Feb 2024 22:01:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id haZ2ZmOR4y2P; Tue, 27 Feb 2024 22:01:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D30E2626FAEC;
	Tue, 27 Feb 2024 22:01:01 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wFPCRLT6xrlv; Tue, 27 Feb 2024 22:01:01 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id B700A626FAEB;
	Tue, 27 Feb 2024 22:01:01 +0100 (CET)
Date: Tue, 27 Feb 2024 22:01:01 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Message-ID: <1568393451.106442.1709067661698.JavaMail.zimbra@nod.at>
In-Reply-To: <20240222072417.3773131-7-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de> <20240222072417.3773131-7-hch@lst.de>
Subject: Re: [PATCH 6/7] ubd: remove the queue pointer in struct ubd
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove the queue pointer in struct ubd
Thread-Index: PfkHaHr5LY6oKbXnCFFct3EjiOb5Ew==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_130105_757898_D00F89DA 
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
> Gesendet: Donnerstag, 22. Februar 2024 08:24:16
> Betreff: [PATCH 6/7] ubd: remove the queue pointer in struct ubd

> No need for it now, everything goes through the gendisk.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index c5d32e75426366..9bf1d6a88bae59 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -163,7 +163,6 @@ struct ubd {
> =09struct cow cow;
> =09struct platform_device pdev;
> =09struct gendisk *disk;
> -=09struct request_queue *queue;
> =09struct blk_mq_tag_set tag_set;
> =09spinlock_t lock;
> };
> @@ -892,10 +891,9 @@ static int ubd_add(int n, char **error_out)
> =09=09err =3D PTR_ERR(disk);
> =09=09goto out_cleanup_tags;
> =09}
> -=09ubd_dev->queue =3D disk->queue;
>=20
> =09blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
> -=09blk_queue_write_cache(ubd_dev->queue, true, false);
> +=09blk_queue_write_cache(disk->queue, true, false);
> =09disk->major =3D UBD_MAJOR;
> =09disk->first_minor =3D n << UBD_SHIFT;
> =09disk->minors =3D 1 << UBD_SHIFT;
> --
> 2.39.2

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

