Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFdBU-0005uU-Pa	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 12:44:44 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFdBR-0003Pw-94
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 12:44:44 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050914192230.GC9001@ccure.user-mode-linux.org>
References: <200509132001.40992.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509132001.40992.blaisorblade@yahoo.it>
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
Date: Wed, 14 Sep 2005 15:22:30 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Sep 13, 2005 at 08:01:40PM +0200, Blaisorblade wrote:
> It's just because things are called under spinlocks and GFP_KERNEL is used - 
> but if possible, it'd be better to use something better than GFP_ATOMIC 
> (since this is performance critical).

This would be ubd_io_lock, which is taken for us by the block layer before 
entering do_ubd_request.  We could make that a GFP_ATOMIC allocation, except
that we have already dequeued the request, so would need to do
something with it if the allocation failed.

I'm wondering if we can drop the lock before do_io and pick it up
afterwards.  The bitmap argument is a global, which is a problem.  Two
racing requests could result in one writing out a bitmap which is
either too old or too new.

So, I'm not sure how to handle this.  We could requeue what's left of
the request if an allocation failure happens.  We could drop the lock
and pick it up later, but we have to be careful to write out the
current bitmap, not one which we saved earlier or one which has been
updated to reflect a racing request which is coming through later.

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
