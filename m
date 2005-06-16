Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DiyIa-0000w8-8F	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 10:37:04 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DiyIZ-0001p7-LT	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 10:37:04 -0700
Message-ID: <42B1B8B9.7070006@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Recent patches of note
References: <20050616160728.GA6040@ccure.user-mode-linux.org>
In-Reply-To: <20050616160728.GA6040@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Thu, 16 Jun 2005 19:36:57 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> I'd like to call attention to some recent patches that may be of interest
> to people before they hit mainline.  These are all on my incremental patches
> page, http://user-mode-linux.sf.net/patches.html
> 
> First, sched-starve (http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.12-rc6-mm1/patches/sched-starve)
> 
> This fixes a timer initialization botch which resulted in soft lockup
> warnings in recent kernels, total non-responsiveness (i.e. nothing
> else would be scheduled) under any workload which avoided idling the
> kernel, and may be responsible for the load average >= 1 problem.
> 
> I don't see that last here for some reason, so I'd like some
> confirmation (or not) that this patch fixes that.
> 
> Second, I implemented soft interrupts, which reimplements interrupt
> enabling and disabling with a flag rather than with sigprocmask.  This
> cuts down hugely on the number of system calls that UML makes,
> resulting in a very noticable performance increase.  This patch, plus
> the other system call reducing patches which immediately follow it,
> speed up my kernel builds by 20-25%.  By far the largest piece of this
> is softints, although skas-no-flush-kernel also is noticable.
Great!

> 
> I'd like people to check out softints, at least, and report any
> problems.  It's running fine here, but interrupt handling is a
> sensitive area, so I'd like to know people are running it without
> problems before pushing it to mainline.
> 
> 				Jeff
Currently my time is *very* limited, so I can't test. Reading the patches
only the one that makes me worry is "dont-save-fpregs".
To not save fpregs on every syscall or interrupt is O.K.
But you also have to modify signal-handling, that currently relies on
fpregs being saved. And you have to save and restore fpregs in switch_to
for SKAS3 and also for SKAS0, if processes share the same mm.
Then, I think special handling is needed for the fpregs in copy_thread
and probably in execve also.

	Bodo


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
