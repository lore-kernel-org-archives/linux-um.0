Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5JUt-0006a2-8q for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 00:37:35 -0700
Received: from ns.virtualhost.dk ([195.184.98.160] helo=virtualhost.dk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C5JUr-0003BM-NL
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 00:37:35 -0700
From: Jens Axboe <axboe@suse.de>
Message-ID: <20040909073523.GH1737@suse.de>
References: <20040908172503.384144933@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908172503.384144933@zion.localdomain>
Subject: [uml-devel] Re: [patch 1/1] uml:fix ubd deadlock on SMP
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
Date: Thu, 9 Sep 2004 09:35:23 +0200
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Sep 08 2004, blaisorblade_spam@yahoo.it wrote:
> diff -puN arch/um/drivers/ubd_kern.c~uml-fix-ubd-deadlock arch/um/drivers/ubd_kern.c
> --- uml-linux-2.6.8.1/arch/um/drivers/ubd_kern.c~uml-fix-ubd-deadlock	2004-09-08 19:04:27.662926344 +0200
> +++ uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c	2004-09-08 19:05:36.700431048 +0200
> @@ -54,6 +54,7 @@
>  #include "mem.h"
>  #include "mem_kern.h"
>  
> +/*This is the queue lock. FIXME: make it per-UBD device.*/
>  static spinlock_t ubd_io_lock = SPIN_LOCK_UNLOCKED;
>  static spinlock_t ubd_lock = SPIN_LOCK_UNLOCKED;

probably not worth it to make it per-device. doing so should be a simple
search-replace job, though.

> @@ -396,14 +397,16 @@ int thread_fd = -1;
>   */
>  int intr_count = 0;
>  
> -static void ubd_finish(struct request *req, int error)
> +static inline void __ubd_finish(struct request *req, int error, int lock)
>  {
>  	int nsect;
>  
>  	if(error){
> - 		spin_lock(&ubd_io_lock);
> +		if (lock)
> +			spin_lock(&ubd_io_lock);
>  		end_request(req, 0);
> - 		spin_unlock(&ubd_io_lock);
> +		if (lock)
> +			spin_unlock(&ubd_io_lock);

In general, doing it this way is throwned upon. Either split the
function, or just make the callers acquire the lock if they have to.

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
