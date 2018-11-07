Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKVAQ-00037l-3s
 for linux-um@lists.infradead.org; Wed, 07 Nov 2018 21:15:14 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: Summary so far - ubd breakage in 4.20-rc1
Date: Wed, 07 Nov 2018 22:15:00 +0100
Message-ID: <2067083.opUWeOxqyK@blindfold>
In-Reply-To: <90605158-e1c8-f414-1635-72e185ca861e@kernel.dk>
References: <94397e9b-36a6-92b0-b074-ce3640cee00e@kot-begemot.co.uk>
 <1553895.q7DRUMsJH8@blindfold>
 <90605158-e1c8-f414-1635-72e185ca861e@kernel.dk>
MIME-Version: 1.0
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
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, hch@lst.de

Jens,

Am Mittwoch, 7. November 2018, 20:19:42 CET schrieb Jens Axboe:
> My guess would be that the issue of requests is no longer blocking
> interrupts, that looks like an oversight. So you could have your
> IRQ handler race with writing new requests, which would be a problem...

sounds reasonable.

> Does the below help things?
> 

It does!
Anton, please give it also a try.

> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 74c002ddc0ce..019bc4828e30 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -1341,11 +1341,14 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
>  static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
>  				 const struct blk_mq_queue_data *bd)
>  {
> +	struct ubd *ubd_dev = hctx->queue->queuedata;
>  	struct request *req = bd->rq;
>  	int ret = 0;
>  
>  	blk_mq_start_request(req);
>  
> +	spin_lock_irq(&ubd_dev->lock);
> +

BTW: Why not irq_save/restore?

Thanks,
//richard




_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

