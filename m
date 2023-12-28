Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BACC3DA6E
	for <linux-um@archiver.kernel.org>; Thu, 28 Dec 2023 11:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TW/A0qwKVNBUgfZq2S5GA4aBo4jMyarvOHxv5dX0uX0=; b=wRWyg5hgTZYFJTSX7RwH6xZbGh
	TR7dI8H6zXEkcow9rrLV9Hy6Cc9baShfvZSfOOxi5NrukS8O+nelGOHMf7wxtlPxngLY0jXxLEGLX
	rvZoBszAY7PSh/0Ta2NFwscTriuwvQlg9ht/XJ9zWX52yqsN1MkoKk+u7Hmb7tD0H0POJXuy7+MOp
	fWN0NTlsLHQGjmq+ccVhyBdxUArJEfvaoMnKGT5rUTjf7l7VSePL8fYPfP+THMdiA6OiRM60OYNGh
	fwt7HorzJq43aKQigDUdZyX0T7j1KYd2n4+LWyBEYjfeP2QnRZKj7aUamG9WGWrjTLvOsNGJ7ohAr
	zswX5w1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIoHJ-00Gdo3-0C;
	Thu, 28 Dec 2023 11:10:17 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIoHF-00GdnF-31;
	Thu, 28 Dec 2023 11:10:15 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 991F66343B3D;
	Thu, 28 Dec 2023 12:10:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Ha9HAdblf5Fu; Thu, 28 Dec 2023 12:10:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0F9C76343B4E;
	Thu, 28 Dec 2023 12:10:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jBjqUGApe4hb; Thu, 28 Dec 2023 12:10:11 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id CF83F6343B3D;
	Thu, 28 Dec 2023 12:10:11 +0100 (CET)
Date: Thu, 28 Dec 2023 12:10:11 +0100 (CET)
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
Message-ID: <1544995699.172154.1703761811676.JavaMail.zimbra@nod.at>
In-Reply-To: <20231228075545.362768-5-hch@lst.de>
References: <20231228075545.362768-1-hch@lst.de> <20231228075545.362768-5-hch@lst.de>
Subject: Re: [PATCH 4/9] ubd: use the default discard granularity
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: use the default discard granularity
Thread-Index: kk75ae1xWs0+YtjBcgdOSaDYaxww3w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231228_031014_127356_829E10A0 
X-CRM114-Status: GOOD (  10.27  )
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
> Gesendet: Donnerstag, 28. Dezember 2023 08:55:40
> Betreff: [PATCH 4/9] ubd: use the default discard granularity

> The discard granularity now defaults to a single sector, so don't set
> that value explicitly.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 50206feac577d5..92ee2697ff3984 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -798,7 +798,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
> =09=09ubd_dev->cow.fd =3D err;
> =09}
> =09if (ubd_dev->no_trim =3D=3D 0) {
> -=09=09ubd_dev->queue->limits.discard_granularity =3D SECTOR_SIZE;
> =09=09blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
> =09=09blk_queue_max_write_zeroes_sectors(ubd_dev->queue, UBD_MAX_REQUEST)=
;
> =09}

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

