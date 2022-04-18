Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngMMN-00FvRn-4d
 for linux-um@lists.infradead.org; Mon, 18 Apr 2022 08:03:48 +0000
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfZl4cmyz1SVp7
 for <linux-um@lists.infradead.org>; Mon, 18 Apr 2022 01:03:43 -0700 (PDT)
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id et7z_T9r9_KA for <linux-um@lists.infradead.org>;
 Mon, 18 Apr 2022 01:03:42 -0700 (PDT)
Message-ID: <034efb57-9e1d-41ed-1855-e2b057b03ea7@opensource.wdc.com>
Date: Mon, 18 Apr 2022 17:03:38 +0900
MIME-Version: 1.0
Subject: Re: [dm-devel] [PATCH 11/11] xen-blkback: use bdev_discard_alignment
Content-Language: en-US
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-12-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220418045314.360785-12-hch@lst.de>
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
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org, Song Liu <song@kernel.org>, dm-devel@redhat.com, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, linux-s390@vger.kernel.org, Richard Weinberger <richard@nod.at>, xen-devel@lists.xenproject.org, linux-um@lists.infradead.org, Mike Snitzer <snitzer@kernel.org>, Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org, linux-block@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>, linux-raid@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, Johannes Berg <johannes@sipsolutions.net>, =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>

On 4/18/22 13:53, Christoph Hellwig wrote:
> Use bdev_discard_alignment to calculate the correct discard alignment
> offset even for partitions instead of just looking at the queue limit.
> 
> Also switch to use bdev_discard_granularity to get rid of the last direct
> queue reference in xen_blkbk_discard.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/xen-blkback/xenbus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index b21bffc9c50bc..04c90cb8955f6 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -583,14 +583,14 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
>  	if (bdev_max_discard_sectors(bdev)) {
>  		err = xenbus_printf(xbt, dev->nodename,
>  			"discard-granularity", "%u",
> -			q->limits.discard_granularity);
> +			bdev_discard_granularity(bdev));
>  		if (err) {
>  			dev_warn(&dev->dev, "writing discard-granularity (%d)", err);
>  			return;
>  		}
>  		err = xenbus_printf(xbt, dev->nodename,
>  			"discard-alignment", "%u",
> -			q->limits.discard_alignment);
> +			bdev_discard_alignment(bdev));
>  		if (err) {
>  			dev_warn(&dev->dev, "writing discard-alignment (%d)", err);
>  			return;

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

