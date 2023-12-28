Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0D3C47073
	for <linux-um@archiver.kernel.org>; Thu, 28 Dec 2023 11:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YhJrxSJPaLNGOZQuTfjICDYE4GYEVTF46abv2j2QwUA=; b=IMXMsOaokzjyA78osRYodv0ywE
	Gsw2dKnk9dAuQuqIMTVJFjg+l05srlSkyuAveSvIGKMxAqkEk1SUzVf8/mkmn8bDRPDM3I5HDiDYo
	a8217ZYwEOmo/7xjlubiTrTACBHJRnEqxVL8Qn1Lj084l0cA/Mgat7iKXb3b2K29nGSqRbOPLFTc7
	TkoU+w11bEf9hvxUm0/MZUPo+uPifCFIzHoceIKzfBjSbpstn9o8+Ti/DqQr4wmaQrPKoOhG5jh2E
	Af2hPfBFgBd8nFgcailWnnKUAgThZ66p3iX4lnt74hChoscNFupdayrpHaFLrWVg9m+vrJkFSLILX
	JQXrkvhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIoGs-00Gdk8-1m;
	Thu, 28 Dec 2023 11:09:50 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIoGo-00GdjF-15;
	Thu, 28 Dec 2023 11:09:48 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 64FC36343B34;
	Thu, 28 Dec 2023 12:09:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id QLKAjcGqlAWB; Thu, 28 Dec 2023 12:09:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 83EF66343B4D;
	Thu, 28 Dec 2023 12:09:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ho9bqT-b41NN; Thu, 28 Dec 2023 12:09:38 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 498246343B34;
	Thu, 28 Dec 2023 12:09:38 +0100 (CET)
Date: Thu, 28 Dec 2023 12:09:38 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Josef Bacik <josef@toxicpanda.com>, Minchan Kim <minchan@kernel.org>, 
	senozhatsky <senozhatsky@chromium.org>, Coly Li <colyli@suse.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>, nbd@other.debian.org, 
	linux-bcache <linux-bcache@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <651248504.172152.1703761778190.JavaMail.zimbra@nod.at>
In-Reply-To: <20231228075545.362768-10-hch@lst.de>
References: <20231228075545.362768-1-hch@lst.de> <20231228075545.362768-10-hch@lst.de>
Subject: Re: [PATCH 9/9] mtd_blkdevs: use the default discard granularity
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: mtd_blkdevs: use the default discard granularity
Thread-Index: qBzbN7jF6yK+/MNDxaXtjyFFzypHWw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231228_030946_565391_38F7B65E 
X-CRM114-Status: UNSURE (   9.30  )
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
> Von: "hch" <hch@lst.de>
> An: "Jens Axboe" <axboe@kernel.dk>
> CC: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Josef Bacik" <josef@toxicpanda.com>,
> "Minchan Kim" <minchan@kernel.org>, "senozhatsky" <senozhatsky@chromium.o=
rg>, "Coly Li" <colyli@suse.de>, "Miquel
> Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.c=
om>, "linux-um"
> <linux-um@lists.infradead.org>, "linux-block" <linux-block@vger.kernel.or=
g>, nbd@other.debian.org, "linux-bcache"
> <linux-bcache@vger.kernel.org>, "linux-mtd" <linux-mtd@lists.infradead.or=
g>
> Gesendet: Donnerstag, 28. Dezember 2023 08:55:45
> Betreff: [PATCH 9/9] mtd_blkdevs: use the default discard granularity

> The discard granularity now defaults to a single sector, so don't set
> that value explicitly.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> drivers/mtd/mtd_blkdevs.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index ff18636e088973..0da7b33849471a 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -376,10 +376,8 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *ne=
w)
> =09blk_queue_flag_set(QUEUE_FLAG_NONROT, new->rq);
> =09blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, new->rq);
>=20
> -=09if (tr->discard) {
> +=09if (tr->discard)
> =09=09blk_queue_max_discard_sectors(new->rq, UINT_MAX);
> -=09=09new->rq->limits.discard_granularity =3D tr->blksize;
> -=09}

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

