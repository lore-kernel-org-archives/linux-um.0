Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DjLsO-0008OX-EY	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Jun 2005 11:47:36 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DjLsI-0005tv-Mk	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Jun 2005 11:47:35 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Recent patches of note
References: <20050616160728.GA6040@ccure.user-mode-linux.org>
	<200506162051.21441.blaisorblade@yahoo.it>
	<20050616222340.GF9792@ccure.user-mode-linux.org>
In-Reply-To: <20050616222340.GF9792@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506172036.28664.blaisorblade@yahoo.it>
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
Date: Fri, 17 Jun 2005 20:36:27 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Friday 17 June 2005 00:23, Jeff Dike wrote:
> On Thu, Jun 16, 2005 at 08:51:20PM +0200, Blaisorblade wrote:
> > > And also it makes tt a bit more removable, if Jeff decides to.

> > Well, on this point I'd be cautious.

> > Currently there is no way to even test UML in SMP mode other than using
> > TT mode, so at least this must be solved.

> Yeah, we need to provide SMP on skas.  That, and the performance of page
> fault handling were the only two things stopping me from removing tt mode
> in favor of skas0.
Well, the stub SIGSTOPs itself when it has finished. This is a big-latency 
operation, so using futexes (or POSIX semaphores, which don't seem to be 
implemented in terms of futexes) will increase a lot the stub's speed.
> Bodo and have talked about this, and it seems that skas0 SMP is impractical
> because a malicious threaded app could interfere with the stub operation.

> However, skas3 SMP is quite doable, and I think an unsafe skas0 SMP mode
> that you can enable with a switch might be OK, too.
Yes, we must simply write some for's (I already have in my patches the fixes 
for the #warning you added), fix some semaphores (it appears that I finished 
it, and turning the winch_handler_sem into a spinlock fixed all remaining 
deadlocks with console), and finally implement IPIs, right?

It will be harder to write a SMP-safe version of copy_*_user_skas but that 
exists inside the 4G-4G patch. And at that point, we'll enable PREEMPTION.

Btw, ever tried putting preemption in, just a compile shoot? Well, I'll work 
on all this stuff starting on July (supposing I succeed).

> I've since decided that page fault performance is not a show-stopper.  It
> appears that tt mode is not supportable in recent libcs due to the errno
> problem.

No, it doesn't, I must just trick a bit with the patch to fix that, simply it 
wasn't urgent and I'm busy for other stuff (aka exams).

> We can get page fault performance back by pushing PTRACE_FAULTINFO into
> mainline, which should have been done a long time ago.  Same for sysemu,
> BTW.
Yes, but since FAULTINFO will be recoded in terms of SIGINFO, we must do a bit 
of coding, trivial but a bit lenghty (fixing all SIGSEGVs senders in host 
kernel).

Plus, sysemu is probably causing the debugger problems (a TRAP at every 
instructions) we are getting - I can't think of anything else, at least.

> At this point, I'm -><- this close to deciding to get rid of tt mode in
> 2.6.13 or 2.6.14.  I want skas0 in mainline early in 2.6.13 so it can
> be exercised.
Say 2.6.13-git1. But you must prepare a patch which does not change *at all* 
SKAS3, not in terms of code but in terms of "strace output" (not "well, we 
change this but it won't affect things").

Btw, where did you lost SA_NODEFER for SIGSEGV handling?
> Getting skas SMP fixed, and PTRACE_FAULTINFO in mainline 
> would make me happy about trashing tt mode at some later point.

Deprecating TT mode is Ok, but removing it will cause SMP to stop *compiling* 
at all after a few days of patches, and we would get more work when 
introducing SMP.

So, fir
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
