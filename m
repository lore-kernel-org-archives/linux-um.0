Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8RIo-0000GG-AC for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 15:06:18 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8RIm-0000ID-Ob for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 15:06:18 -0800
Message-Id: <200503080001.j2800Wbc005246@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Sun, 06 Mar 2005 19:49:03 +0100."
	<200503061949.03819.blaisorblade@yahoo.it> 
References: <200503061949.03819.blaisorblade@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: SKAS leftovers: having fun with old code relicts (aka
	PTRACE_SIGPENDING)
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
Date: Mon, 07 Mar 2005 19:00:32 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade@yahoo.it said:
> After this story, we come to the question: Jeff, what I missed (apart
> that  probably it was used in releases before SKAS3)?

I don't think it was ever used.  The thinking was race avoidance - if a
signal hit the process at the same time that it started a system call, or two
signals came in at the same time, UML would handle the first, then 
PTRACE_SIGPENDING to see if there were any more that needed handling.  However,
the userspace process doesn't receive any signals apart from SIGVTALRM, so
this is somewhat moot.

If the userspace process did receive important signals (like SIGIO), then not
using this could lead to situations where the one running process sleeps for
a long time, leaving a SIGIO trapped on the userspace process.  And this
could lead to deadlocks when the SIGIO was for the I/O that the process was
sleeping on.

> Could I delete PTRACE_SIGPENDING from the SKAS patch? 

Yup.

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
