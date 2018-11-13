Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMYvu-0001LA-J7
 for linux-um@lists.infradead.org; Tue, 13 Nov 2018 13:40:47 +0000
Received: by mail-pf1-x444.google.com with SMTP id e22-v6so6069025pfn.8
 for <linux-um@lists.infradead.org>; Tue, 13 Nov 2018 05:40:36 -0800 (PST)
Subject: Re: [PATCH 4/4] um: Add support for DISCARD in the UBD Driver
References: <20181113115947.19290-1-anton.ivanov@cambridgegreys.com>
 <20181113115947.19290-5-anton.ivanov@cambridgegreys.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <699c4f90-4f77-bf9c-d613-1294fe9c8cdc@kernel.dk>
Date: Tue, 13 Nov 2018 06:40:32 -0700
MIME-Version: 1.0
In-Reply-To: <20181113115947.19290-5-anton.ivanov@cambridgegreys.com>
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

On 11/13/18 4:59 AM, anton.ivanov@cambridgegreys.com wrote:
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index 2b1aaf7755aa..e817fd4a4c30 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -1,4 +1,25 @@
>  # SPDX-License-Identifier: GPL-2.0
> +menu "UML Block Devices"
> +
> +config BLK_DEV_UBD
> +	bool "UBD Block Device"
> +	default y
> +	help
> +          User Mode Linux virtual block device driver
> +
> +config BLK_DEV_UBD_SYNC
> +	bool "Use Synchronous mode for UBD"
> +	default n
> +	help
> +          Perform all disk operations synchronously (extremely slow).
> +
> +config BLK_DEV_UBD_DISCARD
> +	bool "Enable DISCARD/TRIM support in UBD"
> +	default y
> +	help
> +          Enable discard/trim support. Requires host kernel 3.x or above and
> +	  may not be supported on all host filesystems.
> +endmenu

kconfig entries are horrible ways to manage this. A module parameter
would be better. The latter also gets rid of the various ifdefs.

> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index e78f27f5ce88..4fd4cb68f033 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -513,9 +513,13 @@ static void ubd_handler(void)
>  		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
>  			struct io_thread_req *io_req = (*irq_req_buffer)[count];
>  
> -			if (!blk_update_request(io_req->req, io_req->error, io_req->length))
> -				__blk_mq_end_request(io_req->req, io_req->error);
> -
> +			if ((io_req->error) || (io_req->buffer == NULL)) {
> +				blk_mq_end_request(io_req->req, io_req->error);
> +			} else {
> +				if (!blk_update_request(io_req->req, io_req->error, io_req->length)) {
> +					__blk_mq_end_request(io_req->req, io_req->error);
> +				}
> +			}
>  			kfree(io_req);

This looks odd, why is this change necessary? Also a lot of unneeded
parentheses.

>  		}
>  	}
> @@ -775,6 +779,7 @@ static int ubd_open_dev(struct ubd *ubd_dev)
>  	char **back_ptr;
>  	int err, create_cow, *create_ptr;
>  	int fd;
> +	int data;
>  
>  	ubd_dev->openflags = ubd_dev->boot_openflags;
>  	create_cow = 0;
> @@ -829,6 +834,23 @@ static int ubd_open_dev(struct ubd *ubd_dev)
>  		if(err < 0) goto error;
>  		ubd_dev->cow.fd = err;
>  	}
> +#ifdef CONFIG_BLK_DEV_UBD_DISCARD
> +	if (ubd_dev->cow.file != NULL)
> +		fd = ubd_dev->cow.fd;
> +	else
> +		fd = ubd_dev->fd;
> +	err = os_pread_file(fd, &data, sizeof(int), 0);
> +	if (err == sizeof(int)) {
> +		err = os_falloc_punch(fd, 0, sizeof(int));
> +		if (err == 0) {

It's not clear to me how it's safe to punch a 4-byte hole in the file as
a test?


-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

