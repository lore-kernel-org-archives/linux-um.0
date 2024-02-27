Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140CEC54798
	for <linux-um@archiver.kernel.org>; Tue, 27 Feb 2024 21:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZxPlIgRI1PB9QkFLAxXTa4X+ybzSAUdCMTDrA86/AZc=; b=2HZxwBl668F3E8EvdnbWRUB0Am
	rhzR5VATSm3XMyn8dSnNQJKQsGy86bF/R8iHr9EqTVu3Co04jAScMAOo1KmDFWygoa8WUla+5yD6J
	tRM2VKDiFG9kFdm/TlJ5kPZhO0TpoDUHelTQLY9ECNNsfvjdRR+LVbNkzMKWWhCpcU+AOr8D79fk6
	Q8GuQ97O5ePrWYcOxgoCwznWeJsXSMNBR48oUr11TGaR5hheICImUX6ODp4IU+ue/oH6fZYZ1UBIO
	IpLJmE93kvjxdlmXUfv+ZsXdEruEc1hjsihyMn/+LuFiDGrDX+cnAX+8Ce7lG/FOSqcf2mXQmBfmY
	zAv/6pHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4dy-00000006qvY-1c3A;
	Tue, 27 Feb 2024 21:05:42 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf4dv-00000006quv-3xRM
	for linux-um@lists.infradead.org;
	Tue, 27 Feb 2024 21:05:41 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6E45A626FAF1;
	Tue, 27 Feb 2024 22:05:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5NYJLZ7MCa07; Tue, 27 Feb 2024 22:05:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A65C7626FAED;
	Tue, 27 Feb 2024 22:05:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id U7r3dMuPsTXu; Tue, 27 Feb 2024 22:05:37 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 75234626FAEB;
	Tue, 27 Feb 2024 22:05:37 +0100 (CET)
Date: Tue, 27 Feb 2024 22:05:37 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Jens Axboe <axboe@kernel.dk>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Message-ID: <1234843955.106458.1709067937370.JavaMail.zimbra@nod.at>
In-Reply-To: <20240222072417.3773131-8-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de> <20240222072417.3773131-8-hch@lst.de>
Subject: Re: [PATCH 7/7] ubd: open the backing files in ubd_add
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: open the backing files in ubd_add
Thread-Index: T7WeHNIdjCvMp/xgr2quB8Fgwlt/Ig==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_130540_328947_CD6112CC 
X-CRM114-Status: GOOD (  18.06  )
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
> Gesendet: Donnerstag, 22. Februar 2024 08:24:17
> Betreff: [PATCH 7/7] ubd: open the backing files in ubd_add

> Opening the backing device only when the block device is opened is
> a bit weird as no one configures block devices to not use them.

Agreed. I guess this is a strange optimization from the old days.

> Opend them at add time, close them at remove time and remove the
> now superflous opened counter as remove can simply check for
> disk_openers.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 58 +++++++++++---------------------------
> 1 file changed, 16 insertions(+), 42 deletions(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 9bf1d6a88bae59..63fc062add708c 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -108,8 +108,6 @@ static inline void ubd_set_bit(__u64 bit, unsigned ch=
ar
> *data)
> static DEFINE_MUTEX(ubd_lock);
> static DEFINE_MUTEX(ubd_mutex); /* replaces BKL, might not be needed */
>=20
> -static int ubd_open(struct gendisk *disk, blk_mode_t mode);
> -static void ubd_release(struct gendisk *disk);
> static int ubd_ioctl(struct block_device *bdev, blk_mode_t mode,
> =09=09     unsigned int cmd, unsigned long arg);
> static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo)=
;
> @@ -118,8 +116,6 @@ static int ubd_getgeo(struct block_device *bdev, stru=
ct
> hd_geometry *geo);
>=20
> static const struct block_device_operations ubd_blops =3D {
>         .owner=09=09=3D THIS_MODULE,
> -        .open=09=09=3D ubd_open,
> -        .release=09=3D ubd_release,
>         .ioctl=09=09=3D ubd_ioctl,
>         .compat_ioctl=09=3D blkdev_compat_ptr_ioctl,
> =09.getgeo=09=09=3D ubd_getgeo,
> @@ -152,7 +148,6 @@ struct ubd {
> =09 * backing or the cow file. */
> =09char *file;
> =09char *serial;
> -=09int count;
> =09int fd;
> =09__u64 size;
> =09struct openflags boot_openflags;
> @@ -178,7 +173,6 @@ struct ubd {
> #define DEFAULT_UBD { \
> =09.file =3D =09=09NULL, \
> =09.serial =3D=09=09NULL, \
> -=09.count =3D=09=090, \
> =09.fd =3D=09=09=09-1, \
> =09.size =3D=09=09=09-1, \
> =09.boot_openflags =3D=09OPEN_FLAGS, \
> @@ -873,6 +867,13 @@ static int ubd_add(int n, char **error_out)
> =09=09goto out;
> =09}
>=20
> +=09err =3D ubd_open_dev(ubd_dev);
> +=09if (err) {
> +=09=09pr_err("ubd%c: Can't open \"%s\": errno =3D %d\n",
> +=09=09=09'a' + n, ubd_dev->file, -err);
> +=09=09goto out;
> +=09}
> +
> =09ubd_dev->size =3D ROUND_BLOCK(ubd_dev->size);
>=20
> =09ubd_dev->tag_set.ops =3D &ubd_mq_ops;
> @@ -884,7 +885,7 @@ static int ubd_add(int n, char **error_out)
>=20
> =09err =3D blk_mq_alloc_tag_set(&ubd_dev->tag_set);
> =09if (err)
> -=09=09goto out;
> +=09=09goto out_close;
>=20
> =09disk =3D blk_mq_alloc_disk(&ubd_dev->tag_set, &lim, ubd_dev);
> =09if (IS_ERR(disk)) {
> @@ -919,6 +920,8 @@ static int ubd_add(int n, char **error_out)
> =09put_disk(disk);
> out_cleanup_tags:
> =09blk_mq_free_tag_set(&ubd_dev->tag_set);
> +out_close:
> +=09ubd_close_dev(ubd_dev);
> out:
> =09return err;
> }
> @@ -1014,13 +1017,14 @@ static int ubd_remove(int n, char **error_out)
> =09if(ubd_dev->file =3D=3D NULL)
> =09=09goto out;
>=20
> -=09/* you cannot remove a open disk */
> -=09err =3D -EBUSY;
> -=09if(ubd_dev->count > 0)
> -=09=09goto out;
> -
> =09if (ubd_dev->disk) {
> +=09=09/* you cannot remove a open disk */
> +=09=09err =3D -EBUSY;
> +=09=09if (disk_openers(ubd_dev->disk))
> +=09=09=09goto out;
> +
> =09=09del_gendisk(ubd_dev->disk);
> +=09=09ubd_close_dev(ubd_dev);
> =09=09put_disk(ubd_dev->disk);
> =09}
>=20
> @@ -1143,36 +1147,6 @@ static int __init ubd_driver_init(void){
>=20
> device_initcall(ubd_driver_init);
>=20
> -static int ubd_open(struct gendisk *disk, blk_mode_t mode)
> -{
> -=09struct ubd *ubd_dev =3D disk->private_data;
> -=09int err =3D 0;
> -
> -=09mutex_lock(&ubd_mutex);
> -=09if(ubd_dev->count =3D=3D 0){
> -=09=09err =3D ubd_open_dev(ubd_dev);
> -=09=09if(err){
> -=09=09=09printk(KERN_ERR "%s: Can't open \"%s\": errno =3D %d\n",
> -=09=09=09       disk->disk_name, ubd_dev->file, -err);
> -=09=09=09goto out;
> -=09=09}
> -=09}
> -=09ubd_dev->count++;
> -out:
> -=09mutex_unlock(&ubd_mutex);
> -=09return err;
> -}
> -
> -static void ubd_release(struct gendisk *disk)
> -{
> -=09struct ubd *ubd_dev =3D disk->private_data;
> -
> -=09mutex_lock(&ubd_mutex);
> -=09if(--ubd_dev->count =3D=3D 0)
> -=09=09ubd_close_dev(ubd_dev);
> -=09mutex_unlock(&ubd_mutex);
> -}
> -
> static void cowify_bitmap(__u64 io_offset, int length, unsigned long *cow=
_mask,
> =09=09=09  __u64 *cow_offset, unsigned long *bitmap,
> =09=09=09  __u64 bitmap_offset, unsigned long *bitmap_words,
> --
> 2.39.2

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

