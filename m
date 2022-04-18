Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngMJo-00FukJ-NW
 for linux-um@lists.infradead.org; Mon, 18 Apr 2022 08:01:10 +0000
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfWj3snLz1SVp2
 for <linux-um@lists.infradead.org>; Mon, 18 Apr 2022 01:01:05 -0700 (PDT)
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 0As0If17tLiN for <linux-um@lists.infradead.org>;
 Mon, 18 Apr 2022 01:01:04 -0700 (PDT)
Message-ID: <fb5baf81-fa19-bb48-865c-e13277a0952a@opensource.wdc.com>
Date: Mon, 18 Apr 2022 17:01:00 +0900
MIME-Version: 1.0
Subject: Re: [dm-devel] [PATCH 03/11] null_blk: don't set the
 discard_alignment queue limit
Content-Language: en-US
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-4-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220418045314.360785-4-hch@lst.de>
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
> The discard_alignment queue limit is named a bit misleading means the
> offset into the block device at which the discard granularity starts.
> Setting it to the discard granularity as done by null_blk is mostly
> harmless but also useless.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/null_blk/main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 5cb4c92cdffea..a521e914a9843 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1765,7 +1765,6 @@ static void null_config_discard(struct nullb *nullb)
>  	}
>  
>  	nullb->q->limits.discard_granularity = nullb->dev->blocksize;
> -	nullb->q->limits.discard_alignment = nullb->dev->blocksize;
>  	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
>  }
>  

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

