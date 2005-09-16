Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGLml-0002sy-OU	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 12:22:11 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EGLmi-0003il-6N
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 12:22:11 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: "Sleeping in atomic section" with ubd aio patch
References: <200509132001.40992.blaisorblade@yahoo.it>
	<200509142200.39886.blaisorblade@yahoo.it>
	<20050914211808.GA11567@ccure.user-mode-linux.org>
In-Reply-To: <20050914211808.GA11567@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509162120.18101.blaisorblade@yahoo.it>
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
Date: Fri, 16 Sep 2005 21:20:17 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 14 September 2005 23:18, Jeff Dike wrote:
> On Wed, Sep 14, 2005 at 10:00:39PM +0200, Blaisorblade wrote:
> > Assuming it can be done, it'd be ok.
> >
> > However, why have we already dequeued the request?
>
> It is easier than removing segments from the request and finally
> dequeueing the request when it is finally empty.
Why can't you just move that exact call later, without removing segments?

However, even if it's "easier" this way, IMHO it's still easier to defer the 
removal than to readd the thing into the queue (assuming the driver is 
supposed to do this).

Not that I've looked well at the code or at the API recently. I'm busy with 
other stuff.
> > Looking for examples, via grep blkdev_dequeue_request drivers/ide/*.c and
> > going opening drivers/ide/ide-io.c, I found blkdev_dequeue_request()
> > called *after* end_that_request_first(), while there it's called before.

> > A comment in blk_start_pre_flush() says there's some freedom, but
> > probably leaving the request in the queue would be ok....

> There is a good amount of freedom.  The driver is given a set of
> requests, and has the job of making them happen.

> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
