Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6a5Y-0007QR-KM for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 12:32:40 -0700
Received: from pimout2-ext.prodigy.net ([207.115.63.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C6a5X-0004dn-UD for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 12:32:40 -0700
From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [uml-devel] glibc and NPTL, problem, workarounds, etc.
Message-ID: <20040912193237.GA8253@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0409081440150.3136@sparrow>
	<200409122020.51479.blaisorblade_spam@yahoo.it>
	<20040912190258.GA7818@taniwha.stupidest.org>
	<200409122127.12738.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409122127.12738.blaisorblade_spam@yahoo.it>
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
Date: Sun, 12 Sep 2004 12:32:37 -0700
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, William Stearns <wstearns@pobox.com>

On Sun, Sep 12, 2004 at 09:27:12PM +0200, BlaisorBlade wrote:

> Are you sure? I remember that NPTL needs using some new instructions
> of i686 (maybe CMOVxx) for futexes, to be atomic.

i586 and later i486 will suffice

> However, if I'm wrong, we could even pretend to be i386.

NPTL can be made to work too there I'm told, with a little more
effort.  I'm not sure if anyone will ever bother...

> Well, you compile Gentoo for your own processor - you might maybe
> even enable -mregparm for everything (which even breaks binary
> compatibility everything).

i was thinking gentoo on a i585 would maybe build /lib/tls/i586


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
