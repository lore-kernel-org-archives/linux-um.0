Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AttbL-0008PM-GB
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 11:12:47 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AttNo-0001FH-UW
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 10:58:49 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] 2.6.3-rc2-uml1 Kernel mode panic
Message-ID: <20040219193529.GA3644@ccure.user-mode-linux.org>
References: <Pine.LNX.4.44.0402181635060.15836-100000@sparrow> <200402191914.01209.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402191914.01209.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 19 Feb 2004 14:35:29 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, William Stearns <wstearns@pobox.com>

On Thu, Feb 19, 2004 at 07:14:01PM +0100, BlaisorBlade wrote:
> Since I'm not able to upload a kernel while you seem to have broad band, could 
> you please (if it is not already so) provide a kernel with debugging symbols 
> enabled and showing this bug to Jeff Dike, since it seems he cannot reproduce 
> the bug?

I can reproduce it fine.  The recipe that Bill provided works like a charm -
	hit it from the outside with 'ssh uml some command'
	run 'while true; do cat /dev/null; done' inside

and it will panic in 5-10 minutes in one of several ways.  The exit.c BUG
is the process returning from the schedule at the end of exit().  The 
kernel mode fault is the scheduler seeing that the runqueue bitmap says
there's a process to be scheduled waiting on a particular queue, but that
queue is empty.

Since the scheduler is involved in both of these, it's non-deterministic,
and seems to need a supply of interrupts to happen, it smells like the
scheduler is being interrupted when it shouldn't be.

				Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
