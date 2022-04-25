Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-7-hch@lst.de>
In-Reply-To: <20220418045314.360785-7-hch@lst.de>
From: Song Liu <song@kernel.org>
Date: Mon, 25 Apr 2022 14:08:18 -0700
Message-ID: <CAPhsuW7fpiAqAf+U491dTH4mWORZQCxfyT6zWQwN=4r5WJ429Q@mail.gmail.com>
Subject: Re: [PATCH 06/11] raid5: don't set the discard_alignment queue limit
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
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>, Josef Bacik <josef@toxicpanda.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, Mike Snitzer <snitzer@kernel.org>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-um@lists.infradead.org, linux-block@vger.kernel.org, nbd@other.debian.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-raid <linux-raid@vger.kernel.org>, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, dm-devel@redhat.com

On Sun, Apr 17, 2022 at 9:53 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The discard_alignment queue limit is named a bit misleading means the
> offset into the block device at which the discard granularity starts.
> Setting it to the discard granularity as done by raid5 is mostly
> harmless but also useless.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/raid5.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 59f91e392a2ae..39b0afdf40d0a 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7749,7 +7749,6 @@ static int raid5_run(struct mddev *mddev)
>                  */
>                 stripe = stripe * PAGE_SIZE;
>                 stripe = roundup_pow_of_two(stripe);
> -               mddev->queue->limits.discard_alignment = stripe;
>                 mddev->queue->limits.discard_granularity = stripe;
>
>                 blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
> --
> 2.30.2
>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

