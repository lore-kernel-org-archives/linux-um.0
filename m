Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A30C27C6E
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 08:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kqxKAOuAI3fFrE25fY/Of7zq7Yw1C3O8FlyYJmfwJqI=; b=CyGygvRBSRmmFlXoH5cFdxKjU0
	6xmlIZwaVMkoOkKixZ+8kQJw2DaPGeDf14cuhUeWvfsKYfTq9EHB1VMMQXp9paEIHqQuQM9ILJH5f
	z6vgzLPS+LYO4BE4iWXjVJHBaWvnqTsxXXjrGxEyPZjwWUikwfF1rpi1sFQJpvVC7so88hS7HVY1/
	Px3an+Zt/HhGWKBCsntBviUT87y2wAA64Rl15NVBZQlK9vdMXMF3l151cUfTQGNaD+qes8BT8xhd1
	7WnJwgZJ8POzojLDqWTNVSsJ6Kr7+TrAcYYTEtsmMvFogMiPNodqmAOxc3UKYaCdoNi8vj196Qol1
	UbUilzAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI1sQ-00000001tZZ-0wxs;
	Fri, 14 Jun 2024 08:01:38 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI1sN-00000001tYc-1OJM
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 08:01:36 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sI1NW-004AyG-4w; Fri, 14 Jun 2024 07:29:42 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sI1NT-000Wne-0I;
	Fri, 14 Jun 2024 08:29:41 +0100
Message-ID: <b9909e61-7fc2-4d10-8000-d23b7def93de@cambridgegreys.com>
Date: Fri, 14 Jun 2024 08:29:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] ubd: untagle discard vs write zeroes not support
 handling
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
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, Damien Le Moal <dlemoal@kernel.org>
References: <20240531074837.1648501-1-hch@lst.de>
 <20240531074837.1648501-3-hch@lst.de>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20240531074837.1648501-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_010135_394437_E8661295 
X-CRM114-Status: GOOD (  17.49  )
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
> Discard and Write Zeroes are different operation and implemented
> by different fallocate opcodes for ubd.  If one fails the other one
> can work and vice versa.
> 
> Split the code to disable the operations in ubd_handler to only
> disable the operation that actually failed.
> 
> Fixes: 50109b5a03b4 ("um: Add support for DISCARD in the UBD Driver")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>   arch/um/drivers/ubd_kern.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 0c9542d58c01b7..093c87879d08ba 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -449,10 +449,11 @@ static int bulk_req_safe_read(
>   
>   static void ubd_end_request(struct io_thread_req *io_req)
>   {
> -	if (io_req->error == BLK_STS_NOTSUPP &&
> -	    req_op(io_req->req) == REQ_OP_DISCARD) {
> -		blk_queue_max_discard_sectors(io_req->req->q, 0);
> -		blk_queue_max_write_zeroes_sectors(io_req->req->q, 0);
> +	if (io_req->error == BLK_STS_NOTSUPP) {
> +		if (req_op(io_req->req) == REQ_OP_DISCARD)
> +			blk_queue_max_discard_sectors(io_req->req->q, 0);
> +		else if (req_op(io_req->req) == REQ_OP_WRITE_ZEROES)
> +			blk_queue_max_write_zeroes_sectors(io_req->req->q, 0);
>   	}
>   	blk_mq_end_request(io_req->req, io_req->error);
>   	kfree(io_req);
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

