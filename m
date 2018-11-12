Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMGKl-0002aJ-TD
 for linux-um@lists.infradead.org; Mon, 12 Nov 2018 17:49:13 +0000
Received: by mail-pf1-x444.google.com with SMTP id b81-v6so4164507pfe.11
 for <linux-um@lists.infradead.org>; Mon, 12 Nov 2018 09:49:01 -0800 (PST)
Subject: Re: [PATCH 1/3] um: Switch to block-mq constants in the UML UBD driver
References: <20181112174201.12290-1-anton.ivanov@cambridgegreys.com>
 <20181112174201.12290-2-anton.ivanov@cambridgegreys.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <75a2f8a9-ffd8-5d6a-ffb5-a4ab280337fb@kernel.dk>
Date: Mon, 12 Nov 2018 10:48:57 -0700
MIME-Version: 1.0
In-Reply-To: <20181112174201.12290-2-anton.ivanov@cambridgegreys.com>
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

On 11/12/18 10:41 AM, anton.ivanov@cambridgegreys.com wrote:
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 28c40624bcb6..76cd21baac2b 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -43,11 +43,13 @@
>  #include <os.h>
>  #include "cow.h"
>  
> -enum ubd_req { UBD_READ, UBD_WRITE, UBD_FLUSH };
> +#define UBD_SECTOR_SIZE (1 << 9)
> +/* Max request size is determined by sector mask - 32K */
> +#define UBD_MAX_REQUEST (8 * sizeof(long))
>  
>  struct io_thread_req {
>  	struct request *req;
> -	enum ubd_req op;
> +	int op;

You're still adding an op field, even though you did take the suggestion
to use req_op(io_req->req) instead?

> @@ -511,16 +513,13 @@ static void ubd_handler(void)
>  		}
>  		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
>  			struct io_thread_req *io_req = (*irq_req_buffer)[count];
> -			int err = io_req->error ? BLK_STS_IOERR : BLK_STS_OK;
>  
> -			if (!blk_update_request(io_req->req, err, io_req->length))
> -				__blk_mq_end_request(io_req->req, err);
> +			if (!blk_update_request(io_req->req, io_req->error, io_req->length))
> +				__blk_mq_end_request(io_req->req, io_req->error);
>  
>  			kfree(io_req);
>  		}
>  	}
> -
> -	reactivate_fd(thread_fd, UBD_IRQ);
>  }

That last change looks unrelated. It may make sense, but it should not be
mixed in with this patch.

> @@ -1413,22 +1410,37 @@ static int ubd_ioctl(struct block_device *bdev, fmode_t mode,
>  	return -EINVAL;
>  }
>  
> +static int map_error(int error_code)
> +{
> +	switch (error_code) {
> +	case 0:
> +		return BLK_STS_OK;
> +	case EOPNOTSUPP:
> +		return BLK_STS_NOTSUPP;
> +	case EPERM:
> +		return BLK_STS_PROTECTION;
> +	case ENOSPC:
> +		return BLK_STS_NOSPC;
> +	}
> +	return BLK_STS_IOERR;
> +}
> +

BLK_STS_PROTECTION is not the right one to use here, that's for data
integrity issues related to DIF/DIX.


-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

