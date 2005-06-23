Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlGMY-0004TA-LL	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Jun 2005 18:18:38 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DlGMY-0002RJ-2T	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Jun 2005 18:18:38 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050623011255.GB15548@ccure.user-mode-linux.org>
References: <200506230238.35960.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506230238.35960.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Skas0 general testing?
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
Date: Wed, 22 Jun 2005 21:12:55 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jun 23, 2005 at 02:38:35AM +0200, Blaisorblade wrote:
> Would you start preparing a SKAS0 patch-set that I can merge into -bs for 
> general testing and that can be merged into -mm at least?

I'm working on it.  skas0 and skas0-clone are the first to go.  I just
"fixed" skas0 so it gets mm->nr_ptes right without the change to
exit_mmap that used to be there.  I'm banging on that patch now.

The rest still need work.  The setup patches (where we make proc_mm et
al settable on the command line and all combinations will work) are
probably OK.

Some of the later ones are pretty sad.  The ldt patches are probably
not too hard to clean up, but things like add-gate-vma are horrible.

I'm not planning on having a whole good set before starting to send
them to Andrew.  I'll send the ones I'm happiest about, and clean up
the rest, sending them in during the course of 2.6.13.

> I'd like it to be verifiably "don't touch" about SKAS3 working (i.e. no 
> "little changes which won't hurt"). As I already said, I don't mean from the 
> "code" viewpoint but from the "what's actually done" viewpoint (in terms of 
> strace output, if you want so).

That's a good goal, but we can't let it get in the way of keeping the
code clean.  Certainly, anything which touches skas3 should be
carefully looked at, but I don't want to state that we will not touch
any skas3 code.  Bodo's patches which make any combination of
PTRACE_LDT, PTRACE_FAULTINFO, and /proc/mm work are a good example.  I
think that's a worthwhile patch, but it does touch skas3 code.

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
