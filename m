Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88DFC27C7B
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 08:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ClSwtKOKOpw2Oh3wmC/41F4gMOxRui0diNCkNVaVFU=; b=CxpeQY+2OC3r61h6jvBmCFd4Ni
	llsUIb5en+fB7aFIPGAxJupijrdQeqBwEF79zeM1xTHRWZ6e0QBKAXWGPp534zZznjDb5IjTFNd0I
	HxN8dAbbbKUlZTlPS3g1ub/fiapxgQanzYbYpvm38U4Jgq9XoTyDyw9bsBfDgT7lTHfcyP66dcMD6
	wB8dZJFaMwY3MJESi4LDllsORO594CjUyIgs4c0Eq7Otrp2zHbmZrJCduN7vI6E6wHN3Z7AdJmr9P
	IG45mpHhY72Wh0zZOh1Ea+9MN8hODdMLRS3kQQTHRysQlFhRruQPG3Do1TuA1xBaduMZoW/f9kpDQ
	9klXXoGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI1sS-00000001taQ-2fZ3;
	Fri, 14 Jun 2024 08:01:40 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI1sQ-00000001tZV-1Lul
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 08:01:39 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sI1MY-004Axd-Js; Fri, 14 Jun 2024 07:28:42 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sI1MU-000Wne-1M;
	Fri, 14 Jun 2024 08:28:42 +0100
Message-ID: <b15de345-838b-4cbb-a156-22b527ed03b6@cambridgegreys.com>
Date: Fri, 14 Jun 2024 08:28:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] ubd: refactor the interrupt handler
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>, Josef Bacik
 <josef@toxicpanda.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org
References: <20240531074837.1648501-1-hch@lst.de>
 <20240531074837.1648501-2-hch@lst.de>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20240531074837.1648501-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_010138_400003_3B964209 
X-CRM114-Status: GOOD (  20.44  )
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



On 31/05/2024 08:47, Christoph Hellwig wrote:
> Instead of a separate handler function that leaves no work in the
> interrupt hanler itself, split out a per-request end I/O helper and
> clean up the coding style and variable naming while we're at it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>   arch/um/drivers/ubd_kern.c | 49 ++++++++++++++------------------------
>   1 file changed, 18 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index ef805eaa9e013d..0c9542d58c01b7 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -447,43 +447,30 @@ static int bulk_req_safe_read(
>   	return n;
>   }
>   
> -/* Called without dev->lock held, and only in interrupt context. */
> -static void ubd_handler(void)
> +static void ubd_end_request(struct io_thread_req *io_req)
>   {
> -	int n;
> -	int count;
> -
> -	while(1){
> -		n = bulk_req_safe_read(
> -			thread_fd,
> -			irq_req_buffer,
> -			&irq_remainder,
> -			&irq_remainder_size,
> -			UBD_REQ_BUFFER_SIZE
> -		);
> -		if (n < 0) {
> -			if(n == -EAGAIN)
> -				break;
> -			printk(KERN_ERR "spurious interrupt in ubd_handler, "
> -			       "err = %d\n", -n);
> -			return;
> -		}
> -		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
> -			struct io_thread_req *io_req = (*irq_req_buffer)[count];
> -
> -			if ((io_req->error == BLK_STS_NOTSUPP) && (req_op(io_req->req) == REQ_OP_DISCARD)) {
> -				blk_queue_max_discard_sectors(io_req->req->q, 0);
> -				blk_queue_max_write_zeroes_sectors(io_req->req->q, 0);
> -			}
> -			blk_mq_end_request(io_req->req, io_req->error);
> -			kfree(io_req);
> -		}
> +	if (io_req->error == BLK_STS_NOTSUPP &&
> +	    req_op(io_req->req) == REQ_OP_DISCARD) {
> +		blk_queue_max_discard_sectors(io_req->req->q, 0);
> +		blk_queue_max_write_zeroes_sectors(io_req->req->q, 0);
>   	}
> +	blk_mq_end_request(io_req->req, io_req->error);
> +	kfree(io_req);
>   }
>   
>   static irqreturn_t ubd_intr(int irq, void *dev)
>   {
> -	ubd_handler();
> +	int len, i;
> +
> +	while ((len = bulk_req_safe_read(thread_fd, irq_req_buffer,
> +			&irq_remainder, &irq_remainder_size,
> +			UBD_REQ_BUFFER_SIZE)) >= 0) {
> +		for (i = 0; i < len / sizeof(struct io_thread_req *); i++)
> +			ubd_end_request((*irq_req_buffer)[i]);
> +	}
> +
> +	if (len < 0 && len != -EAGAIN)
> +		pr_err("spurious interrupt in %s, err = %d\n", __func__, len);
>   	return IRQ_HANDLED;
>   }
>   
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

