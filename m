Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DzDGZ-0007d0-GP	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2005 05:50:07 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1DzDGZ-0007cn-AG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2005 05:50:07 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050730155454.GA4585@ccure.user-mode-linux.org>
References: <42D7D802.2080100@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D7D802.2080100@fujitsu-siemens.com>
Subject: [uml-devel] Re: Some changes in SKAS0
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
Date: Sat, 30 Jul 2005 11:54:54 -0400
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>, BlaisorBlade <blaisorblade_spam@yahoo.it>

>   Thus I added SA_NOMASK to the flags for the handler.

This patch causes sleep to hang sometimes for me.  A sleep during
shutdown reproducably hangs, as does the sleep before a reboot after a
fsck found errors.

I had to track it down by bisection.  I'm somewhat mystified by this.
The only situation where this could cause a change in behavior is one
that shouldn't happen, as far as I can see.

But it's definitely the cause.  Pop the patch, the hangs go away, push
it, they come back.  I did this a couple times to be sure.

I'll debug this and figure out what's happening.

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
