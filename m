Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4ygj-0003Cm-39 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 02:24:25 -0700
Received: from cantor.suse.de ([195.135.220.2])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C4ygi-0006f4-4F
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Sep 2004 02:24:24 -0700
From: Jens Axboe <axboe@suse.de>
Message-ID: <20040908092314.GE2258@suse.de>
References: <20040906174449.8CAAEBB1A@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040906174449.8CAAEBB1A@zion.localdomain>
Subject: [uml-devel] Re: [patch 2/3] uml-ubd-any-elevator
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
Date: Wed, 8 Sep 2004 11:23:14 +0200
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Sep 06 2004, blaisorblade_spam@yahoo.it wrote:
> diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-any-elevator arch/um/drivers/ubd_kern.c
> --- uml-linux-2.6.8.1/arch/um/drivers/ubd_kern.c~uml-ubd-any-elevator	2004-08-29 14:40:53.731043416 +0200
> +++ uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c	2004-08-29 14:40:53.733043112 +0200
> @@ -749,8 +749,6 @@ int ubd_init(void)
>  		return -1;
>  	}
>  		
> -	elevator_init(ubd_queue, &elevator_noop);
> -
>  	if (fake_major != MAJOR_NR) {
>  		char name[sizeof("ubd_nnn\0")];

if this is not applied, at least the file needs an elevator_exit(q);
before calling elevator_init() for the new elevator. otherwise the
original elevator data is leaked.

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
