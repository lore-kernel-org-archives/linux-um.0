Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKedv-00055D-6W	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 09:18:51 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EKedu-0005eC-G6
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 09:18:50 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Review needed for ubd fixes
Message-ID: <20050928155405.GA12888@ccure.user-mode-linux.org>
References: <200509172245.j8HMjqJD009056@ccure.user-mode-linux.org>
	<200509222251.31918.blaisorblade@yahoo.it>
	<20050927181218.GA28937@ccure.user-mode-linux.org>
	<200509281414.32622.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509281414.32622.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 11:54:05 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Wed, Sep 28, 2005 at 02:14:32PM +0200, Blaisorblade wrote:
> Very, very nice.
> 
> What about the early removal of the request from the queue, before being sure 
> we can complete it (sorry for not reading carefully everything below, I'm 
> going to have lunch and afterwards back to study).

I think that doesn't matter too much.  I have to get the sg information out
of it, and store that, plus the current position within the sg array if
we couldn't send it all to the host.  So, I don't refer to the request after
I get the sg information out of it, so I might as well remove it from the
queue.

> Reorder o_direct at the end - no time to read them yet, but guess that more 
> intrusive goes at the end. And I'm not sure whether merging o_direct so late 
> in 2.6.14 is nice (even if you've tested the full patch set, and without 
> o_direct the thing makes less sense).

Yeah, I wasn't planning on sending that for 2.6.14.  It was just part of that
set of patches.

> Let's hope for the better, but next time the debug should be done *before* 
> merging, ok? Even because, for instance, if (say) the patch was ready for 
> 2.6.14 and merged into 2.6.15, I could have released a test tree against 
> 2.6.14 (maybe I could do this now).

I thought I did.  AIO had been in my tree forever with no apparent problems.
I recently started running 24 hour/day stress tests on UML, and that turned
up some problems.  People turning on spinlock debugging turned up the sleeping
while atomic problem.  And me staring at the code as a result of that turned
up the possible deadlock.

> Please, send them to Andrew for -mm, and say "2.6.14 can't go without them, 
> but they might need further review".
> 
> And ask Jens Axboe if it can give a look to them (this time it's less 
> necessary, since there are less dirty tricks).

Yeah.  This still needs some work.  I need to deal with the bitmap array
properly.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
