Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1c4Vcr-0001eP-Uj
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2016 16:21:25 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92]
	helo=www.kot-begemot.co.uk)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1c4Vcq-000866-I2
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2016 16:21:25 +0000
References: <1478680606-476779-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
	<CY4PR10MB1960E4B5113ADDFD5739EC1BE2B90@CY4PR10MB1960.namprd10.prod.outlook.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <0a052230-3390-2e40-53a1-57ea91203a16@kot-begemot.co.uk>
Date: Wed, 9 Nov 2016 16:21:07 +0000
MIME-Version: 1.0
In-Reply-To: <CY4PR10MB1960E4B5113ADDFD5739EC1BE2B90@CY4PR10MB1960.namprd10.prod.outlook.com>
Subject: Re: [uml-devel] [PATCH v3] UBD Improvements Phase 1
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
To: James McMechan <james_mcmechan@hotmail.com>, "anton.ivanov@kot-begemot.co.uk" <anton.ivanov@kot-begemot.co.uk>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
Cc: "richard@nod.at" <richard@nod.at>



On 09/11/16 16:08, James McMechan wrote:
> Hi
>
> I am not clear on the remainder/remainder_size would not a single offset parameter work? rather than copying it off and back?

Possible.

The other alternative is to copy the remainder (if it exists) to the 
beginning of the buffer at the end of a read and keep only the offset 
around instead of keeping two params around.

You can no longer reuse the whole read function in both the interrupt 
handler and the io thread though.

The reason is that you can copy the remainder to the beginning of the 
buffer (so you can use only offset as a single param) only after you 
have "consumed" all the records.

> also max_recs does not seem to used except to calculate max buffer size so would not using a buffer size be easier?
> something like bulk_req_read( int fd, struct io_thread_req *buf, size_t len, size_t *offset)
>
> +static int bulk_req_safe_read(
> +       int fd,
> +       struct io_thread_req * (*request_buffer)[],
> +       struct io_thread_req **remainder,
> +       int *remainder_size,
> +       int max_recs
> +       )
> +{
> +       int n = 0;
> +       int res = 0;
> +
> +       if (*remainder_size > 0) {
> +               memmove(
> +                       (char *) request_buffer,
> +                       (char *) remainder, *remainder_size
> +               );
> +               n = *remainder_size;
> +       }
> +
> +       res = os_read_file(
> +                       fd,
> +                       ((char *) request_buffer) + *remainder_size,
> +                       sizeof(struct io_thread_req *)*max_recs
> +                               - *remainder_size
>
> then here it would be
> res = os_read_file(fd, buf+*offset,len-*offset)
> Note that if this is ever multithreaded buf and offset or request_buffer/remainder/remainder_size need to be kept separate

This is executed only in the single IO thread.

>
> +               );
> +       if (res > 0) {
> +               n += res;
> +               if ((n % sizeof(struct io_thread_req *)) > 0) {
> +                       /*
> +                       * Read somehow returned not a multiple of dword
> +                       * theoretically possible, but never observed in the
> +                       * wild, so read routine must be able to handle it
> +                       */
>
> maybe this should have a WARN_ON since it should never occur?

Fair point.

>
> +                       *remainder_size = n % sizeof(struct io_thread_req *);
> +                       memmove(
> +                               remainder,
> +                               ((char *) request_buffer) +
> +                                       n/sizeof(struct io_thread_req *),
> +                               *remainder_size
>
> I am pretty sure the 2nd parameter is off. I think it should be:
> ((char *) request_buffer) +(n/sizeof(struct io_thread_req *))*sizeof(struct io_thread_req *)
> also copying it off to a shared static buffer?

Well spotted.

>
> +                       );
> +                       n = n - *remainder_size;
> +               }
> +       } else {
> +               n = res;
> +       }
> +       return n;
> +}
> +
>   /* Called without dev->lock held, and only in interrupt context. */
>   static void ubd_handler(void)
>   {
> -       struct io_thread_req *req;
>           struct ubd *ubd;
>           struct list_head *list, *next_ele;
>           unsigned long flags;
>           int n;
> +       int count;
>   
>           while(1){
> -               n = os_read_file(thread_fd, &req,
> -                                sizeof(struct io_thread_req *));
> -               if(n != sizeof(req)){
>
> if it is being rewritten n could just be the number of complete buffers for the for loop below

That will make it more readable. Agree.

>
> +               n = bulk_req_safe_read(
> +                       thread_fd,
> +                       irq_req_buffer,
> +                       &irq_remainder,
> +                       &irq_remainder_size,
> +                       UBD_REQ_BUFFER_SIZE
> +               );
> +               if (n < 0) {
>                           if(n == -EAGAIN)
>                                   break;
>                           printk(KERN_ERR "spurious interrupt in ubd_handler, "
>                                  "err = %d\n", -n);
>                           return;
>                   }
> -
> -               blk_end_request(req->req, 0, req->length);
> -               kfree(req);
> +               for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
> +                       blk_end_request(
> +                               (*irq_req_buffer)[count]->req,
> +                               0,
> +                               (*irq_req_buffer)[count]->length
> +                       );
> +                       kfree((*irq_req_buffer)[count]);
> +               }
>           }
>           reactivate_fd(thread_fd, UBD_IRQ);
>   
> @@ -1064,6 +1137,28 @@ static int __init ubd_init(void)
>                   if (register_blkdev(fake_major, "ubd"))
>                           return -1;
>           }
> +
> +       irq_req_buffer = kmalloc(
> +                       sizeof(struct io_thread_req *) * UBD_REQ_BUFFER_SIZE,
> +                       GFP_KERNEL
> +               );
> +       irq_remainder = 0;
> +
> +       if (irq_req_buffer == NULL) {
> +               printk(KERN_ERR "Failed to initialize ubd buffering\n");
> +               return -1;
> +       }
>
> Ok, I am really not tracking this, the same buffer allocated twice?

One for the irq handler called irq_req_buffer - above.

One for the io thread called io_req_buffer - below.

Both reuse the same function 100% - this is why it is written this way 
using two params for "remainder/offset" instead of a single offset.

If I use just the offset I cannot reuse the code 100% in both sides of 
the io (the irq and the io thread).

>
> +       io_req_buffer = kmalloc(
> +                       sizeof(struct io_thread_req *) * UBD_REQ_BUFFER_SIZE,
> +                       GFP_KERNEL
> +               );
> +
> +       io_remainder = 0;
> +
> +       if (io_req_buffer == NULL) {
> +               printk(KERN_ERR "Failed to initialize ubd buffering\n");
> +               return -1;
> +       }
>           platform_driver_register(&ubd_driver);
>           mutex_lock(&ubd_lock);
>           for (i = 0; i < MAX_DEV; i++){
>
>
>
> Sorry of the poor email I am using a web interface and it keeps dropping chars...

No worries.

A.

>
> Jim


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

