Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GeSSR-0000l6-0H for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Oct 2006 00:25:23 -0800
Received: from brick.kernel.dk ([62.242.22.158] helo=kernel.dk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GeSSO-0006Ri-EK
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Oct 2006 00:25:22 -0800
Date: Mon, 30 Oct 2006 09:26:48 +0100
From: Jens Axboe <jens.axboe@oracle.com>
Message-ID: <20061030082643.GM4563@kernel.dk>
References: <200610292023.12980.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200610292023.12980.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 06/11] uml ubd driver: ubd_io_lock usage fixup
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 29 2006, Blaisorblade wrote:
> Add some comments about requirements for ubd_io_lock and expand its use.
> 
> When an irq signals that the "controller" (i.e. another thread on the host,
> which does the actual requests and is the only one blocked on I/O on the
>  host) has done some work, we call again the request function ourselves
> (do_ubd_request).
> 
> We now do that with ubd_io_lock held - that's useful to protect against
> concurrent calls to elv_next_request and so on.

Not only useful, required, as I think I complained about a year or more
ago :-)

> XXX: Maybe we shouldn't call at all the request function. Input needed on
>  this. Are we supposed to plug and unplug the queue? That code "indirectly"
>  does that by setting a flag, called do_ubd, which makes the request function
>  return (it's a residual of 2.4 block layer interface).

Sometimes you need to. I'd probably just remove the do_ubd check and
always recall the request function when handling completions, it's
easier and safe.

-- 
Jens Axboe


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
