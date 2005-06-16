Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dj2r2-0000zQ-Ar	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 15:28:56 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Dj2r0-00053c-JO	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 15:28:56 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Recent patches of note
Message-ID: <20050616222340.GF9792@ccure.user-mode-linux.org>
References: <20050616160728.GA6040@ccure.user-mode-linux.org>
	<200506162041.27013.blaisorblade@yahoo.it>
	<42B1C787.6010402@fujitsu-siemens.com>
	<200506162051.21441.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506162051.21441.blaisorblade@yahoo.it>
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
Date: Thu, 16 Jun 2005 18:23:40 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Thu, Jun 16, 2005 at 08:51:20PM +0200, Blaisorblade wrote:
> > And also it makes tt a bit more removable, if Jeff decides to.
> Well, on this point I'd be cautious.
> 
> Currently there is no way to even test UML in SMP mode other than using TT 
> mode, so at least this must be solved.

Yeah, we need to provide SMP on skas.  That, and the performance of page fault
handling were the only two things stopping me from removing tt mode in favor
of skas0.

Bodo and have talked about this, and it seems that skas0 SMP is impractical
because a malicious threaded app could interfere with the stub operation.

However, skas3 SMP is quite doable, and I think an unsafe skas0 SMP mode
that you can enable with a switch might be OK, too.

I've since decided that page fault performance is not a show-stopper.  It
appears that tt mode is not supportable in recent libcs due to the errno
problem. 

We can get page fault performance back by pushing PTRACE_FAULTINFO into 
mainline, which should have been done a long time ago.  Same for sysemu, 
BTW.

At this point, I'm -><- this close to deciding to get rid of tt mode in
2.6.13 or 2.6.14.  I want skas0 in mainline early in 2.6.13 so it can
be exercised.  Getting skas SMP fixed, and PTRACE_FAULTINFO in mainline
would make me happy about trashing tt mode at some later point.

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
