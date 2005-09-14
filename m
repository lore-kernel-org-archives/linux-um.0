Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFf3V-00038W-4P	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 14:44:37 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFf3S-00015F-Ob
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 14:44:37 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: "Sleeping in atomic section" with ubd aio patch
Message-ID: <20050914211808.GA11567@ccure.user-mode-linux.org>
References: <200509132001.40992.blaisorblade@yahoo.it>
	<20050914192230.GC9001@ccure.user-mode-linux.org>
	<200509142200.39886.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509142200.39886.blaisorblade@yahoo.it>
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
Date: Wed, 14 Sep 2005 17:18:08 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Sep 14, 2005 at 10:00:39PM +0200, Blaisorblade wrote:
> Assuming it can be done, it'd be ok.
> 
> However, why have we already dequeued the request?

It is easier than removing segments from the request and finally
dequeueing the request when it is finally empty.

> Looking for examples, via grep blkdev_dequeue_request drivers/ide/*.c and 
> going opening drivers/ide/ide-io.c, I found blkdev_dequeue_request() called 
> *after* end_that_request_first(), while there it's called before.
> 
> A comment in blk_start_pre_flush() says there's some freedom, but probably 
> leaving the request in the queue would be ok....

There is a good amount of freedom.  The driver is given a set of
requests, and has the job of making them happen.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
