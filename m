Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngMLT-00Fv9Q-Ny
 for linux-um@lists.infradead.org; Mon, 18 Apr 2022 08:02:53 +0000
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfYg1LZgz1SVpB
 for <linux-um@lists.infradead.org>; Mon, 18 Apr 2022 01:02:47 -0700 (PDT)
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id KzGws0-BrDWh for <linux-um@lists.infradead.org>;
 Mon, 18 Apr 2022 01:02:46 -0700 (PDT)
Message-ID: <1cef25df-b00d-4590-5598-555c5d97d1c1@opensource.wdc.com>
Date: Mon, 18 Apr 2022 17:02:41 +0900
MIME-Version: 1.0
Subject: Re: [dm-devel] [PATCH 10/11] rnbd-srv: use bdev_discard_alignment
Content-Language: en-US
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-11-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220418045314.360785-11-hch@lst.de>
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
> Signed-off-by: Christoph Hellwig <hch@lst.de>
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
> -	return bdev_get_queue(dev->bdev)->limits.discard_alignment;
> +	return bdev_discard_alignment(dev->bdev);
>  }
>  
>  #endif /* RNBD_SRV_DEV_H */

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

