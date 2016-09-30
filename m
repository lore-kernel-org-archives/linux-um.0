Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1bprhA-0008B5-SB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2016 06:53:20 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92]
	helo=www.kot-begemot.co.uk)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bprh8-0007Pp-KU
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2016 06:53:20 +0000
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1bprh1-0005am-N0 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2016 06:53:12 +0000
Received: from [192.168.11.207]
	by smaug.kot-begemot.co.uk with esmtp (Exim 4.84_2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1bprh1-000765-FP
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Sep 2016 07:53:11 +0100
References: <1475181417-26010-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
	<1475181417-26010-2-git-send-email-anton.ivanov@kot-begemot.co.uk>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <2d96718b-581c-f128-931e-9fc4e26f942f@kot-begemot.co.uk>
Date: Fri, 30 Sep 2016 07:53:06 +0100
MIME-Version: 1.0
In-Reply-To: <1475181417-26010-2-git-send-email-anton.ivanov@kot-begemot.co.uk>
Subject: Re: [uml-devel] [PATCH] UBD Improvements Phase 1
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

I noticed a formatting error and a logical error in the short read 
"safety net". It is never invoked,  but none the less should be fixed.

A revised patch with fixed formatting and a fix for the logical error 
will follow shortly. Performance figures are unchanged: 30% gain to 
start off with on raw read, 17% on find /usr -exec cat {}

A.


On 29/09/16 21:36, anton.ivanov@kot-begemot.co.uk wrote:
> From: Anton Ivanov <aivanov@brocade.com>
>
> UBD at present is extremely slow because it handles only
> one request at a time in the IO thread and IRQ handler.
>
> The single request at a time is replaced by handling multiple
> requests as well as necessary workarounds for short reads/writes.
>
> Resulting performance improvement in disk IO - 30%
>
> Signed-off-by: Anton Ivanov <aivanov@brocade.com>
> ---
>   arch/um/drivers/ubd.h      |   5 ++
>   arch/um/drivers/ubd_kern.c | 161 ++++++++++++++++++++++++++++++++++++++-------
>   arch/um/drivers/ubd_user.c |  19 +++++-
>   3 files changed, 159 insertions(+), 26 deletions(-)
>
> diff --git a/arch/um/drivers/ubd.h b/arch/um/drivers/ubd.h
> index 3b48cd2..cc1cc85 100644
> --- a/arch/um/drivers/ubd.h
> +++ b/arch/um/drivers/ubd.h
> @@ -11,5 +11,10 @@ extern int start_io_thread(unsigned long sp, int *fds_out);
>   extern int io_thread(void *arg);
>   extern int kernel_fd;
>   
> +extern int ubd_read_poll(int timeout);
> +extern int ubd_write_poll(int timeout);
> +
> +#define UBD_REQ_BUFFER_SIZE 64
> +
>   #endif
>   
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index f354027..91f3354 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -1,4 +1,5 @@
>   /*
> + * Copyright (C) 2015-2016 Anton Ivanov (aivanov@brocade.com)
>    * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
>    * Licensed under the GPL
>    */
> @@ -58,6 +59,17 @@ struct io_thread_req {
>   	int error;
>   };
>   
> +
> +static struct io_thread_req*  (*irq_req_buffer) [];
> +static struct io_thread_req * irq_remainder;
> +static int irq_remainder_size;
> +
> +static struct io_thread_req*  (*io_req_buffer) [];
> +static struct io_thread_req * io_remainder;
> +static int io_remainder_size;
> +
> +
> +
>   static inline int ubd_test_bit(__u64 bit, unsigned char *data)
>   {
>   	__u64 n;
> @@ -442,29 +454,88 @@ static void do_ubd_request(struct request_queue * q);
>   static int thread_fd = -1;
>   static LIST_HEAD(restart);
>   
> -/* XXX - move this inside ubd_intr. */
> +/* Function to read several request pointers at a time
> +* handling fractional reads if (and as) needed
> +*/
> +
> +static int bulk_req_safe_read(
> +	int fd,
> +	struct io_thread_req*  (*request_buffer) [],
> +	struct io_thread_req * remainder,

This should be ** and the code modified accordingly - you need the 
pointer to the "short read" buffer, not where the short read buffer is 
pointing to as that is not relevant for what it tries to do.

> +	int * remainder_size,
> +	int max_recs
> +	)
> +{
> +	int n = 0;
> +	int res = 0;
> +
> +	if (*remainder_size > 0) {
> +		memmove(
> +			(char *) request_buffer,
> +			(char *) & remainder, * remainder_size
> +		);
> +		n = * remainder_size;
> +	}
> +
> +	res = os_read_file(
> +			fd,
> +			((char *) request_buffer) + * remainder_size,
> +			sizeof(struct io_thread_req *) * max_recs - *remainder_size
> +		);
> +	if (res > 0) {
> +		n += res;
> +		if ((n % sizeof(struct io_thread_req *)) > 0) {
> +			/*
> +			* Read somehow returned not a multiple of dword
> +			* theoretically possible, but never observed in the
> +			* wild, so read routine must be able to handle it
> +			*/
> +			*remainder_size = n % sizeof(struct io_thread_req *);
> +			memmove(
> +				& remainder,
> +				((char *) request_buffer) + n/sizeof(struct io_thread_req *),
> +				*remainder_size
> +			);
> +			n = n - *remainder_size;
> +		}
> +	} else {
> +		n = res;
> +	}
> +	return n;
> +}
> +
>   /* Called without dev->lock held, and only in interrupt context. */
>   static void ubd_handler(void)
>   {
> -	struct io_thread_req *req;
>   	struct ubd *ubd;
>   	struct list_head *list, *next_ele;
>   	unsigned long flags;
>   	int n;
> +	int count;
>   
>   	while(1){
> -		n = os_read_file(thread_fd, &req,
> -				 sizeof(struct io_thread_req *));
> -		if(n != sizeof(req)){
> +		n = bulk_req_safe_read(
> +			thread_fd,
> +			irq_req_buffer,
> +			irq_remainder,
> +			&irq_remainder_size,
> +			UBD_REQ_BUFFER_SIZE
> +		);
> +		if(n < 0){
>   			if(n == -EAGAIN)
>   				break;
>   			printk(KERN_ERR "spurious interrupt in ubd_handler, "
>   			       "err = %d\n", -n);
>   			return;
>   		}
> -
> -		blk_end_request(req->req, 0, req->length);
> -		kfree(req);
> +		for (count=0;count < n /sizeof(struct io_thread_req *);count++) {
> +			blk_end_request(
> +				(* irq_req_buffer)[count]->req,
> +				0,
> +				(* irq_req_buffer)[count]->length
> +			);
> +			kfree((* irq_req_buffer)[count]);
> +		}
>   	}
>   	reactivate_fd(thread_fd, UBD_IRQ);
>   
> @@ -1064,6 +1135,28 @@ static int __init ubd_init(void)
>   		if (register_blkdev(fake_major, "ubd"))
>   			return -1;
>   	}
> +
> +	irq_req_buffer = kmalloc(
> +			sizeof(struct io_thread_req *) * UBD_REQ_BUFFER_SIZE,
> +			GFP_KERNEL
> +		);
> +	irq_remainder = 0;
> +	
> +	if(irq_req_buffer == NULL) {
> +		printk(KERN_ERR "Failed to initialize ubd buffering\n");
> +		return -1;
> +	}
> +	io_req_buffer = kmalloc(
> +			sizeof(struct io_thread_req *) * UBD_REQ_BUFFER_SIZE,
> +			GFP_KERNEL
> +		);
> +	
> +	io_remainder = 0;
> +
> +	if(io_req_buffer == NULL) {
> +		printk(KERN_ERR "Failed to initialize ubd buffering\n");
> +		return -1;
> +	}
>   	platform_driver_register(&ubd_driver);
>   	mutex_lock(&ubd_lock);
>   	for (i = 0; i < MAX_DEV; i++){
> @@ -1458,31 +1551,49 @@ static int io_count = 0;
>   
>   int io_thread(void *arg)
>   {
> -	struct io_thread_req *req;
> -	int n;
> +	int n, count, written, res;
>   
>   	os_fix_helper_signals();
>   
>   	while(1){
> -		n = os_read_file(kernel_fd, &req,
> -				 sizeof(struct io_thread_req *));
> -		if(n != sizeof(struct io_thread_req *)){
> -			if(n < 0)
> +		n = bulk_req_safe_read(
> +			kernel_fd,
> +                        io_req_buffer,
> +                        io_remainder,
> +                        &io_remainder_size,
> +                        UBD_REQ_BUFFER_SIZE
> +                );
> +                if(n < 0){
> +                        if(n == -EAGAIN) {
> +				ubd_read_poll(-1);
> +				continue;
> +			} else {
>   				printk("io_thread - read failed, fd = %d, "
>   				       "err = %d\n", kernel_fd, -n);
> -			else {
> -				printk("io_thread - short read, fd = %d, "
> -				       "length = %d\n", kernel_fd, n);
>   			}
> -			continue;
> +                }
> +
> +                for (count=0;count < n /sizeof(struct io_thread_req *);count++) {
> +			io_count++;
> +			do_io((* io_req_buffer)[count]);
>   		}
> -		io_count++;
> -		do_io(req);
> -		n = os_write_file(kernel_fd, &req,
> -				  sizeof(struct io_thread_req *));
> -		if(n != sizeof(struct io_thread_req *))
> -			printk("io_thread - write failed, fd = %d, err = %d\n",
> -			       kernel_fd, -n);
> +
> +		written = 0;
> +
> +		do {
> +			res = os_write_file(kernel_fd, ((char *) io_req_buffer) + written, n);
> +			if (res > 0) {
> +				written += res;
> +			} else {
> +				if (res != -EAGAIN) {
> +					printk("io_thread - read failed, fd = %d, "
> +					       "err = %d\n", kernel_fd, -n);
> +				}
> +			}
> +			if (written < n) {
> +				ubd_write_poll(-1);
> +			}
> +		} while (written < n);
>   	}
>   
>   	return 0;
> diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
> index e376f9b..2a7d5b6 100644
> --- a/arch/um/drivers/ubd_user.c
> +++ b/arch/um/drivers/ubd_user.c
> @@ -1,4 +1,5 @@
> -/*
> +/*
> + * Copyright (C) 2016 Anton Ivanov (aivanov@brocade.com)
>    * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
>    * Copyright (C) 2001 Ridgerun,Inc (glonnon@ridgerun.com)
>    * Licensed under the GPL
> @@ -20,6 +21,9 @@
>   
>   #include "ubd.h"
>   #include <os.h>
> +#include <poll.h>
> +
> +struct pollfd kernel_pollfd;
>   
>   int start_io_thread(unsigned long sp, int *fd_out)
>   {
> @@ -32,9 +36,12 @@ int start_io_thread(unsigned long sp, int *fd_out)
>   	}
>   
>   	kernel_fd = fds[0];
> +	kernel_pollfd.fd = kernel_fd;
> +	kernel_pollfd.events = POLLIN;
>   	*fd_out = fds[1];
>   
>   	err = os_set_fd_block(*fd_out, 0);
> +	err = os_set_fd_block(kernel_fd, 0);
>   	if (err) {
>   		printk("start_io_thread - failed to set nonblocking I/O.\n");
>   		goto out_close;
> @@ -57,3 +64,13 @@ int start_io_thread(unsigned long sp, int *fd_out)
>    out:
>   	return err;
>   }
> +
> +int ubd_read_poll(int timeout) {
> +    kernel_pollfd.events = POLLIN;
> +    return poll(&kernel_pollfd, 1, timeout);
> +}
> +int ubd_write_poll(int timeout) {
> +    kernel_pollfd.events = POLLOUT;
> +    return poll(&kernel_pollfd, 1, timeout);
> +}
> +



------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

