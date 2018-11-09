Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gL98g-0004xk-2T
 for linux-um@lists.infradead.org; Fri, 09 Nov 2018 15:56:07 +0000
Received: by mail-it1-x142.google.com with SMTP id r12-v6so3659241ita.3
 for <linux-um@lists.infradead.org>; Fri, 09 Nov 2018 07:55:55 -0800 (PST)
Subject: Re: [PATCH] Add DISCARD support to UML udb driver
References: <20181109091937.25470-1-anton.ivanov@cambridgegreys.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b18e9d07-5eec-40f5-c204-bfefe51b9898@kernel.dk>
Date: Fri, 9 Nov 2018 08:55:51 -0700
MIME-Version: 1.0
In-Reply-To: <20181109091937.25470-1-anton.ivanov@cambridgegreys.com>
Content-Language: en-US
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
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at, hch@lst.de

On 11/9/18 2:19 AM, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> 1. Remove UBD specific opcode definitions and reuse the block-mq
> ones
> 2. Add DISCARD and ZERO fill support (tested with ext4).
> 3. Further cleanup on the request forming, request checking and
> handling of unexpected command codes.

When you need to make this an itemized list, it's a good hint
that these should have been separate patches!

A few comments below.

> @@ -43,11 +43,9 @@
>  #include <os.h>
>  #include "cow.h"
>  
> -enum ubd_req { UBD_READ, UBD_WRITE, UBD_FLUSH };
> -
>  struct io_thread_req {
>  	struct request *req;
> -	enum ubd_req op;
> +	int op;
>  	int fds[2];
>  	unsigned long offsets[2];
>  	unsigned long long offset;

Do we really need that? Just do req_op(io_req->req)?

> @@ -830,6 +828,10 @@ static int ubd_open_dev(struct ubd *ubd_dev)
>  		if(err < 0) goto error;
>  		ubd_dev->cow.fd = err;
>  	}
> +	ubd_dev->queue->limits.discard_granularity = 1 << 9;
> +	ubd_dev->queue->limits.discard_alignment = 1 << 9;
> +	blk_queue_max_discard_sectors(ubd_dev->queue, 8 * sizeof(long));
> +	blk_queue_flag_set(QUEUE_FLAG_DISCARD|QUEUE_FLAG_NONROT, ubd_dev->queue);

The 8 * sizeof(long) looks a bit like magic, probably add a comment.

blk_queue_flag_set() takes a bit, but a mask. You can't OR them like that,
do two separate calls.


> @@ -1307,20 +1309,21 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
>  		io_req->fds[0] = dev->fd;
>  	io_req->error = 0;
>  
> -	if (req_op(req) == REQ_OP_FLUSH) {
> -		io_req->op = UBD_FLUSH;
> -	} else {
> +	io_req->op = req_op(req);
> +
> +	if (io_req->op != REQ_OP_FLUSH) {
>  		io_req->fds[1] = dev->fd;
>  		io_req->cow_offset = -1;
>  		io_req->offset = off;
> -		io_req->length = bvec->bv_len;
> +		if ((io_req->op == REQ_OP_READ) || (io_req->op == REQ_OP_WRITE)) {
> +			io_req->length = bvec->bv_len;
> +			io_req->buffer = page_address(bvec->bv_page) + bvec->bv_offset;
> +		} else
> +			io_req->length = blk_rq_bytes(req);

Let's fully cleanup the command handling, this is not making it anymore
readable. For example, that last else. That's right now assumed to be a discard.
But I only know that because it's not a flush (first if), and it's not a read/write
(second if).

Goes in a few other places too. If you do that, I think it'll be a lot more
readable.

So please resend addressing the comments, and as a series of patches,
each just doing one thing.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

