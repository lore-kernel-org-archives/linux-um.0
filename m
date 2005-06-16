Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Diwz0-00043S-So	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 09:12:46 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Diwz0-0007kd-9f	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 09:12:46 -0700
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.11.2) with ESMTP id j5GFHCm01018
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 16 Jun 2005 11:17:13 -0400
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	j5GG7U5H006362	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 16 Jun 2005 12:07:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050616160728.GA6040@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Recent patches of note
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
Date: Thu, 16 Jun 2005 12:07:28 -0400
To: user-mode-linux-devel@lists.sourceforge.net

I'd like to call attention to some recent patches that may be of interest
to people before they hit mainline.  These are all on my incremental patches
page, http://user-mode-linux.sf.net/patches.html

First, sched-starve (http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.12-rc6-mm1/patches/sched-starve)

This fixes a timer initialization botch which resulted in soft lockup
warnings in recent kernels, total non-responsiveness (i.e. nothing
else would be scheduled) under any workload which avoided idling the
kernel, and may be responsible for the load average >= 1 problem.

I don't see that last here for some reason, so I'd like some
confirmation (or not) that this patch fixes that.

Second, I implemented soft interrupts, which reimplements interrupt
enabling and disabling with a flag rather than with sigprocmask.  This
cuts down hugely on the number of system calls that UML makes,
resulting in a very noticable performance increase.  This patch, plus
the other system call reducing patches which immediately follow it,
speed up my kernel builds by 20-25%.  By far the largest piece of this
is softints, although skas-no-flush-kernel also is noticable.

I'd like people to check out softints, at least, and report any
problems.  It's running fine here, but interrupt handling is a
sensitive area, so I'd like to know people are running it without
problems before pushing it to mainline.

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
