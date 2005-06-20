Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkOjc-0003nu-OE	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 09:02:52 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DkOja-0001Sc-RM
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 09:02:52 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1DkOjV-0006rl-MU	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 09:02:48 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Recent patches of note
Message-ID: <20050620145320.GB5530@ccure.user-mode-linux.org>
References: <s2b19c99.097@ORANGE.OUS.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s2b19c99.097@ORANGE.OUS.EDU>
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
Date: Mon, 20 Jun 2005 10:53:20 -0400
To: Anthony Brock <Anthony_Brock@ous.edu>
Cc: wstearns@pobox.com, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jun 16, 2005 at 03:36:24PM -0700, Anthony Brock wrote:
> Second, I'm once again enountering problems with launch the UML instance. It likes to hang at:
> 
> 
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Checking if syscall restart handling in host can be skipped...OK
> Checking for the skas3 patch in the host:
>   - /proc/mm...found
>   - PTRACE_FAULTINFO...found
>   - PTRACE_LDT...found
> Checking PROT_EXEC mmap in /tmp...OK

I remembered what this was about.  Disable CONFIG_I8042, under -
	UML-specific options
	Input device support
	Hardware I/O ports
	i8042 PC Keyboard controller

This is a UML bug which I haven't tracked down yet.

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
