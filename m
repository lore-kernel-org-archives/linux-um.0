Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFdbe-00074j-Ev	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 13:11:46 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EFdbY-0000AM-Pd
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 13:11:46 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <200509132001.40992.blaisorblade@yahoo.it>
	<20050914192230.GC9001@ccure.user-mode-linux.org>
In-Reply-To: <20050914192230.GC9001@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509142200.39886.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: "Sleeping in atomic section" with ubd aio patch
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
Date: Wed, 14 Sep 2005 22:00:39 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 14 September 2005 21:22, Jeff Dike wrote:
> On Tue, Sep 13, 2005 at 08:01:40PM +0200, Blaisorblade wrote:
> > It's just because things are called under spinlocks and GFP_KERNEL is
> > used - but if possible, it'd be better to use something better than
> > GFP_ATOMIC (since this is performance critical).

> This would be ubd_io_lock, which is taken for us by the block layer before
> entering do_ubd_request.  We could make that a GFP_ATOMIC allocation,
> except that we have already dequeued the request, so would need to do
> something with it if the allocation failed.

> I'm wondering if we can drop the lock before do_io and pick it up
> afterwards.  The bitmap argument
the COW bitmap, right?
> is a global, which is a problem.  Two 
> racing requests could result in one writing out a bitmap which is
> either too old or too new.

> So, I'm not sure how to handle this.  We could requeue what's left of
> the request if an allocation failure happens.
Assuming it can be done, it'd be ok.

However, why have we already dequeued the request?

Looking for examples, via grep blkdev_dequeue_request drivers/ide/*.c and 
going opening drivers/ide/ide-io.c, I found blkdev_dequeue_request() called 
*after* end_that_request_first(), while there it's called before.

A comment in blk_start_pre_flush() says there's some freedom, but probably 
leaving the request in the queue would be ok....
> We could drop the lock 
> and pick it up later, but we have to be careful to write out the
> current bitmap, not one which we saved earlier or one which has been
> updated to reflect a racing request which is coming through later.
If you work on the second, be also sure to ask Jens Axboe (see MAINTAINERS for 
email) whether it's legal for the block layer.

CC'ing him on the change in first place would not have been a bad idea, either 
(IMHO).
> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
