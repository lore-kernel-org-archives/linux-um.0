Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngfqB-001UCf-Ap
 for linux-um@lists.infradead.org; Tue, 19 Apr 2022 04:51:53 +0000
Received: by mail-lf1-x129.google.com with SMTP id u7so27335606lfs.8
 for <linux-um@lists.infradead.org>; Mon, 18 Apr 2022 21:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-11-hch@lst.de>
In-Reply-To: <20220418045314.360785-11-hch@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 19 Apr 2022 06:51:12 +0200
Message-ID: <CAMGffEnxwHE_QgN2OS93BHe6U+XdYc_R5OmSROmF5F-HXK_E4A@mail.gmail.com>
Subject: Re: [PATCH 10/11] rnbd-srv: use bdev_discard_alignment
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>, Josef Bacik <josef@toxicpanda.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, Mike Snitzer <snitzer@kernel.org>, Song Liu <song@kernel.org>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-um@lists.infradead.org, linux-block@vger.kernel.org, nbd@other.debian.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, dm-devel@redhat.com

On Mon, Apr 18, 2022 at 6:53 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use bdev_discard_alignment to calculate the correct discard alignment
> offset even for partitions instead of just looking at the queue limit.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv-dev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
> index d080a0de59225..4309e52524691 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.h
> +++ b/drivers/block/rnbd/rnbd-srv-dev.h
> @@ -59,7 +59,7 @@ static inline int rnbd_dev_get_discard_granularity(const struct rnbd_dev *dev)
>
>  static inline int rnbd_dev_get_discard_alignment(const struct rnbd_dev *dev)
>  {
> -       return bdev_get_queue(dev->bdev)->limits.discard_alignment;
> +       return bdev_discard_alignment(dev->bdev);
>  }
>
>  #endif /* RNBD_SRV_DEV_H */
> --
> 2.30.2
>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

