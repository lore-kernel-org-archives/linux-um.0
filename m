Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B14C25B75
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 08:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J3LF51SA5k+UjqJHsi1H0eId7fhdxm9Fnve53rU8g1A=; b=Kj3HKSPFvutc+cBnouex6tW3pu
	F7/UsF+A9EhV0lfcJL102DaabmREpY4jCHpshsFVfvdAkaFQn1srH8ygS3MxF/oZGoA7as34O2HFP
	R1LeOragjv1nWJ4oxU3cVRBQjO+/0uhzdBB1POdlH7r5+wT26xEPN7Ew+bibb5A5sh/s4aJkrLt1M
	ylDYOdRSbP9bxVkEsuSaGT7qL9JYyULakVe1WOaxJzZpHvKpS1NzC4daY1GrMxeU0N1SPTNgnIi4H
	ZEZjGx+hsJA4KArdTKBP1PbftNaLpv5MCTwoP9vNFDiWryV0X1/M8IMhengRU/D41lk8HQVWnk1BY
	QQ7oTHfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEEm-00000003FBT-29gm;
	Wed, 29 May 2024 08:00:44 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEEi-00000003FAj-3caC
	for linux-um@lists.infradead.org;
	Wed, 29 May 2024 08:00:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8C2D6CE1676;
	Wed, 29 May 2024 08:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1365C2BD10;
	Wed, 29 May 2024 08:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716969637;
	bh=G8ukn4/ipULjaA61nZoKSh0N7cnsV0YBmRdlGxpAHeY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SuVzllmYSRfquuJcDcRWnc0GHSPtFNyp26AyBluVbJ0up4tbRtITWjDNuKs1XeKsj
	 9unRV1rYyOv2gxNp3rc+jY9sEkrRoqVZBHFucwYGOw+cZtDcO5G4HtfEKacdVyOA5g
	 6mlURbCvBUcRD04eBHxPfjMS/Igzp8+knm7PD62kn5RYL66jlTq5s1KxPqTq4ABeHL
	 J7gn1nDulWyl0ZYRxhgciUY+N6bzgokG2U4wmuyIXgq6xnWCSKMrB/TqQkHYeFuDg7
	 CGmud4af4+/jP58GUdbsQFpcZukByzTLb1+jCTWsClYve1yVdsTgRE9/fLAmqjluGl
	 t4JqpvDKBOzCw==
Message-ID: <8878dcb7-5f18-4e34-b917-ee5e1ee15cff@kernel.org>
Date: Wed, 29 May 2024 17:00:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] ubd: untagle discard vs write zeroes not support
 handling
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, Josef Bacik
 <josef@toxicpanda.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org
References: <20240529050507.1392041-1-hch@lst.de>
 <20240529050507.1392041-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240529050507.1392041-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_010041_127946_5A9DD9C4 
X-CRM114-Status: GOOD (  19.61  )
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

On 5/29/24 14:04, Christoph Hellwig wrote:
> Discard and Write Zeroes are different operation and implemented
> by different fallocate opcodes for ubd.  If one fails the other one
> can work and vice versa.
> 
> Split the code to disable the operations in ubd_handler to only
> disable the operation that actually failed.
> 
> Fixes: 50109b5a03b4 ("um: Add support for DISCARD in the UBD Driver")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/um/drivers/ubd_kern.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index ef805eaa9e013d..a79a3b7c33a647 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -471,9 +471,14 @@ static void ubd_handler(void)
>  		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
>  			struct io_thread_req *io_req = (*irq_req_buffer)[count];
>  
> -			if ((io_req->error == BLK_STS_NOTSUPP) && (req_op(io_req->req) == REQ_OP_DISCARD)) {
> -				blk_queue_max_discard_sectors(io_req->req->q, 0);
> -				blk_queue_max_write_zeroes_sectors(io_req->req->q, 0);
> +			if (io_req->error == BLK_STS_NOTSUPP) {
> +				struct request_queue *q = io_req->req->q;
> +
> +				if (req_op(io_req->req) == REQ_OP_DISCARD)
> +					blk_queue_max_discard_sectors(q, 0);
> +				if (req_op(io_req->req) == REQ_OP_WRITE_ZEROES)

Nit: this can be an "else if".

Otherwise, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +					blk_queue_max_write_zeroes_sectors(q,
> +							0);
>  			}
>  			blk_mq_end_request(io_req->req, io_req->error);
>  			kfree(io_req);

-- 
Damien Le Moal
Western Digital Research


