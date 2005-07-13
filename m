Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DsgF0-0000WC-6M	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 05:21:30 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DsgEx-00059N-Mk	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 05:21:30 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Am I doing something wrong with -skas0?
Message-ID: <20050713121520.GA4460@ccure.user-mode-linux.org>
References: <200507122346.40320.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507122346.40320.rob@landley.net>
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
Date: Wed, 13 Jul 2005 08:15:20 -0400
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Jul 12, 2005 at 11:46:40PM -0500, Rob Landley wrote:
> VFS: Mounted root (hostfs filesystem) readonly.
> Kernel panic - not syncing: get_skas_faultinfo : failed to wait for 
> SIGUSR1/SIGTRAP, pid = 7944, n = 7944, errno = 0, status = 0xb

A bunch of people are seeing this.  What's supposed to happen when the 
segfault hits is that it's supposed to continue into the segfault handler.

The fact that it is terminating with SIGSEGV immediately after stopping with
SIGSEGV means that the signal handler couldn't be delivered for some reason.

Either the signal stack or handler aren't present, or the stack isn't writable.

So, maybe the stubs aren't being set up properly.  Can you gdb the thing, put
a breakpoint in get_skas_faultinfo, and look at /proc/<pid>/maps, where
pid is the pid being ptraced?

The last two pages, at 0x7fffe000 and 7ffff000 are the stubs.  The first
should be mapped in from the temp VM file with permissions r-x, and the
second should be anonymous with permissions rwx.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
