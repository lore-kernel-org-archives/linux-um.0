Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050707115908.GA6043@ccure.user-mode-linux.org>
References: <1119527920.4679.15.camel@FC3-bernhard-1.acousta.local>
	<1119614544.4643.9.camel@FC3-bernhard-1.acousta.local>
	<20050624134118.GA4117@ccure.user-mode-linux.org>
	<200507041853.13469.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507041853.13469.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Problems about fork-not-clone (was: Re: [uml-user]
	UML exits after "tracing thread pid")
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
Date: Thu, 7 Jul 2005 07:59:08 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

> Ok, can you describe it a bit more detailedly?
> 
> Also, are you going to drop this patch (or allow me to do this) for now? 
> Since it isn't getting fixed, it seems me a good idea.

I still think the patch is correct.  Ben LaHaise sent me a UML binary
which crashes, which I can send you if you want to look at it.

This thing was looking at errno after the first call to fork even if
it succeeded.  This leads me to believe that this is a compiler oddity
rather than a compiler bug, and that this is causing UML to hit the
tt-specific errno crash with recent libcs.  You understand that
problem more than I do.

So, I would say that skas0 is more a fix for this problem than
reverting the fork-not-clone patch is.

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
