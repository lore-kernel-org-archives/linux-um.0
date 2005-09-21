Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI9Ku-00064N-NF	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 11:28:52 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EI9Kt-0000zB-A0
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 11:28:52 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Review needed for ubd fixes
Message-ID: <20050921180436.GA7712@ccure.user-mode-linux.org>
References: <200509172245.j8HMjqJD009056@ccure.user-mode-linux.org>
	<200509201401.13750.blaisorblade@yahoo.it>
	<20050920190618.GA9417@ccure.user-mode-linux.org>
	<200509211749.46125.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509211749.46125.blaisorblade@yahoo.it>
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
Date: Wed, 21 Sep 2005 14:04:36 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Wed, Sep 21, 2005 at 05:49:43PM +0200, Blaisorblade wrote:
> Since you're going to possibly sleep, it's better to allow kmalloc to sleep in 
> first place!

WRONG!  The first request in line can't sleep, that's the whole point.

If it does, the system can deadlock.  Subsequent requests can sleep, waiting
for previous ones to finish, but there absolutely can't be any sleeping
in kmalloc.

> Is the COW bitmap mmap'ed? Because otherwise we'd need to queue up an 
> additional write request, which creates problems.

No.  That creates ordering problems which I haven't thought about yet,  It
may be worth doing, but explicit writes make ordering easier to think about.
> 
> Btw, msync() allows sync'ing only a specific region, which fsync() doesn't 
> allow. Don't know whether we need this really, however (we probably don't do 
> it, but we should).

Or, the host may just flush out the mmapped stuff on its own.  This is my 
concern about ordering.

> Also, I kept forgetting to mention one thing: Device mapper has the support 
> for COW volumes, like we do. E.g. when you create a snapshot, it is not a 
> static immutable copy of the original, it's writable too!

Yeah, that's something to think about.

> Don't think it's reasonable to expect this. I think that filesystems like ext2 
> will never produce write barriers - they are needed for journaled FS's.

I thought your point was to rely on the block layer to order overlapping
writes for us.

It sounded reasonable to me :-)

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
