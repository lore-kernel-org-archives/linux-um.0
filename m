Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4cVF-0001bX-MB for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 02:43:05 -0700
Received: from ns.virtualhost.dk ([195.184.98.160] helo=virtualhost.dk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C4cVE-0006j3-VG
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 02:43:05 -0700
From: Jens Axboe <axboe@suse.de>
Message-ID: <20040907093559.GL6323@suse.de>
References: <20040906174447.238788D1E@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906174447.238788D1E@zion.localdomain>
Subject: [uml-devel] Re: [patch 1/3] uml-ubd-no-empty-queue
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 7 Sep 2004 11:35:59 +0200
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Sep 06 2004, blaisorblade_spam@yahoo.it wrote:
> 
> Avoid using, in the UBD driver, the elv_queue_empty function. It's for
> the block layer only; in fact, the Anticipatory Scheduler can return NULL
> with elv_next_request() even if the queue is not empty, because it waits
> for the process to send another request before seeking on the disk.
> 
> In fact, if (with uml-ubd-any-elevator) we let UBD use any scheduler,
> elevator=as will make the UBD driver Oops, if we don't have this patch.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
> ---
> 
>  uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-no-empty-queue arch/um/drivers/ubd_kern.c
> --- uml-linux-2.6.8.1/arch/um/drivers/ubd_kern.c~uml-ubd-no-empty-queue	2004-08-29 14:40:51.313410952 +0200
> +++ uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c	2004-08-29 14:40:51.315410648 +0200
> @@ -1038,8 +1038,7 @@ static void do_ubd_request(request_queue
>  	int err, n;
>  
>  	if(thread_fd == -1){
> -		while(!elv_queue_empty(q)){
> -			req = elv_next_request(q);
> +		while((req = elv_next_request(q)) != NULL){
>  			err = prepare_request(req, &io_req);
>  			if(!err){
>  				do_io(&io_req);
> @@ -1048,9 +1047,8 @@ static void do_ubd_request(request_queue
>  		}
>  	}
>  	else {
> -		if(do_ubd || elv_queue_empty(q))
> +		if(do_ubd || (req = elv_next_request(q)) == NULL)
>  			return;
> -		req = elv_next_request(q);
>  		err = prepare_request(req, &io_req);
>  		if(!err){
>  			do_ubd = ubd_handler;

Patch is correct.

-- 
Jens Axboe



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
