Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FBCC5478C
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 21:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HQ+mHhaLMsv/MEQAB1IEDqgz7dJ8ERVc3qKvdFAqAgQ=; b=EZvji+YU5Bzj5PzyexfACpWKh9
	f7beZFLC/1d/Ajo9DKXUsHCrZPQY4+O2jyrTj+xvTTPl8OrKhODz6NMaphZFTmkLTgS8fYtwEbS/Z
	ZRVu5JjbxLFoqnzsONAjjN4pruHSOx4IZfCcWn898TgTu+NBFmibebW2qXPHNAn17lObB2cFAWLsS
	YpqQyVLOkZtGHvIuNvGgI8XAEh+PLbJoOKWtLqtNKsxDuIAIoWJ3QrHyRIkx+HvHMwnpuiKANIIEZ
	IHXR/LtBlupqPYwNt6xj9pQrbJWwJIlo1oJ/64m3XOeLQGM4a9ZOA3gEf5qPAy2MkUmnMMwH0bqhr
	DTZYG7KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4Z0-00000006q3C-3XDu;
	Tue, 27 Feb 2024 21:00:34 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4Yx-00000006q0y-3ofn
	for linux-um@lists.infradead.org;
	Tue, 27 Feb 2024 21:00:33 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9596E626FAEB;
	Tue, 27 Feb 2024 22:00:30 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id A0PH3mjREBeo; Tue, 27 Feb 2024 22:00:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7F520626FAF1;
	Tue, 27 Feb 2024 22:00:29 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id J_Ima3NF1Lb4; Tue, 27 Feb 2024 22:00:29 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5412D626FAEC;
	Tue, 27 Feb 2024 22:00:29 +0100 (CET)
Date: Tue, 27 Feb 2024 22:00:29 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Message-ID: <1952234687.106440.1709067629021.JavaMail.zimbra@nod.at>
In-Reply-To: <20240222072417.3773131-6-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de> <20240222072417.3773131-6-hch@lst.de>
Subject: Re: [PATCH 5/7] ubd: move set_disk_ro to ubd_add
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: move set_disk_ro to ubd_add
Thread-Index: FrXUZ/VQAI2jGYuAi8vt9J/4AtPUXw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_130032_116434_4DF3D2F1 
X-CRM114-Status: GOOD (  10.10  )
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
> Gesendet: Donnerstag, 22. Februar 2024 08:24:15
> Betreff: [PATCH 5/7] ubd: move set_disk_ro to ubd_add

> No need to delay this until open time.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 26bc8306356263..c5d32e75426366 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -903,6 +903,7 @@ static int ubd_add(int n, char **error_out)
> =09set_capacity(disk, ubd_dev->size / 512);
> =09sprintf(disk->disk_name, "ubd%c", 'a' + n);
> =09disk->private_data =3D ubd_dev;
> +=09set_disk_ro(disk, !ubd_dev->openflags.w);
>=20
> =09ubd_dev->pdev.id =3D n;
> =09ubd_dev->pdev.name =3D DRIVER_NAME;
> @@ -1159,7 +1160,6 @@ static int ubd_open(struct gendisk *disk, blk_mode_=
t mode)
> =09=09}
> =09}
> =09ubd_dev->count++;
> -=09set_disk_ro(disk, !ubd_dev->openflags.w);
> out:
> =09mutex_unlock(&ubd_mutex);
> =09return err;
> --
> 2.39.2

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

