Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngMMt-00FvgX-Ji
 for linux-um@lists.infradead.org; Mon, 18 Apr 2022 08:04:21 +0000
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfbP30Xfz1Rvlx
 for <linux-um@lists.infradead.org>; Mon, 18 Apr 2022 01:04:17 -0700 (PDT)
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id qnLXQsu4HVaf for <linux-um@lists.infradead.org>;
 Mon, 18 Apr 2022 01:04:16 -0700 (PDT)
Message-ID: <18032025-f1aa-2daa-d012-8996590ada6a@opensource.wdc.com>
Date: Mon, 18 Apr 2022 17:04:11 +0900
MIME-Version: 1.0
Subject: Re: [dm-devel] [PATCH 08/11] loop: remove a spurious clear of
 discard_alignment
Content-Language: en-US
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-9-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220418045314.360785-9-hch@lst.de>
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
> The loop driver never sets a discard_alignment, so it also doens't need
> to clear it to zero.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/loop.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 976cf987b3920..61b642b966a08 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -789,7 +789,6 @@ static void loop_config_discard(struct loop_device *lo)
>  		blk_queue_max_discard_sectors(q, 0);
>  		blk_queue_max_write_zeroes_sectors(q, 0);
>  	}
> -	q->limits.discard_alignment = 0;
>  }
>  
>  struct loop_worker {

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

