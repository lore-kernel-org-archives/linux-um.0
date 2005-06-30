Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.91] (helo=sc8-sf-mx1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Do2B9-0006yI-SM	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Jun 2005 09:46:19 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1-new.sourceforge.net with esmtp (Exim 4.44)
	id 1Do2B8-0004LC-Ko	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Jun 2005 09:46:20 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: Skas0 general testing?
Message-ID: <20050630160907.GA6364@ccure.user-mode-linux.org>
References: <200506230238.35960.blaisorblade@yahoo.it>
	<200506230336.28927.blaisorblade@yahoo.it>
	<20050630143119.GA4337@ccure.user-mode-linux.org>
	<200506301714.42462.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506301714.42462.blaisorblade@yahoo.it>
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
Date: Thu, 30 Jun 2005 12:09:07 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Thu, Jun 30, 2005 at 05:14:41PM +0200, Blaisorblade wrote:
> Interesting, you'll tell the world how you deleted all the junk out of this... 
> (possibly on the Wiki but email is ok).

grep -v sigprocmask

> Yes, I'm fine. Send it for -mm now

OK.

> I'd also like to ship it against 2.6.12 for wider testing.
> And the open question is: we (actually you) tested the whole patchset; is 
> there any known bug (for skas0) fixed only by patches we are leaving out?

Until the ldt patches go in, this won't boot some newer filesystems.  My 
Debian 3.0 filesystem, with just skas0 gives me this:

	VFS: Mounted root (ext2 filesystem) readonly.
	cannot set up thread-local storage: cannot set up LDT for thread-local storage

	Kernel panic - not syncing: Attempted to kill init!
 
skas0-clone is also needed to get LDT for children processes correct.  I'm not
sure how much that matters.  I don't remember that ever biting me.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
