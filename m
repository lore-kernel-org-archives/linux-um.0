Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DoULn-0005tT-TO	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Jul 2005 15:51:11 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DoULl-0002ya-54	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Jul 2005 15:51:11 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Skas0 general testing?
References: <200506230238.35960.blaisorblade@yahoo.it>
	<200506301714.42462.blaisorblade@yahoo.it>
	<20050630160907.GA6364@ccure.user-mode-linux.org>
In-Reply-To: <20050630160907.GA6364@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200507020056.56524.blaisorblade@yahoo.it>
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
Date: Sat, 2 Jul 2005 00:56:55 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Thursday 30 June 2005 18:09, Jeff Dike wrote:
> On Thu, Jun 30, 2005 at 05:14:41PM +0200, Blaisorblade wrote:
> > Interesting, you'll tell the world how you deleted all the junk out of
> > this... (possibly on the Wiki but email is ok).

> grep -v sigprocmask
Hmm, interesting...
> > Yes, I'm fine. Send it for -mm now
>
> OK.

> > I'd also like to ship it against 2.6.12 for wider testing.
> > And the open question is: we (actually you) tested the whole patchset; is
> > there any known bug (for skas0) fixed only by patches we are leaving out?
>
> Until the ldt patches go in, this won't boot some newer filesystems.  My
> Debian 3.0 filesystem, with just skas0 gives me this:
>
> 	VFS: Mounted root (ext2 filesystem) readonly.
> 	cannot set up thread-local storage: cannot set up LDT for thread-local
> storage
>
> 	Kernel panic - not syncing: Attempted to kill init!

> skas0-clone is also needed to get LDT for children processes correct.  I'm
> not sure how much that matters.  I don't remember that ever biting me.

Will hurt for heavily multithreaded apps... Java, Apache, ssh or MySQL would 
be good tests (those are the ones failing with TLS or with the 2.6.9-bb3 
patches for security fixes, until Bodo's fix).

Ok, until that's only for SKAS0, for me it's no problem.
> 				Jeff

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
