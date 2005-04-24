Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPkOh-0001SA-7r for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 09:55:55 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DPkOg-0004FN-N3 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 09:55:55 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050424165112.GA4598@ccure.user-mode-linux.org>
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<20050422013246.GA19730@ccure.user-mode-linux.org>
	<200504241644.38016.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504241644.38016.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: UML-patches to prepare UML/s390
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
Date: Sun, 24 Apr 2005 12:51:12 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Apr 24, 2005 at 04:44:37PM +0200, Blaisorblade wrote:
> The patch moving add_arg() was *before* the os-* work, so you might move (if 
> needed, which I don't know) it again to os-Linux/util.c if you want (which 
> didn't exist at that time). It came from arch/um/kernel/user_util.c, in fact.

Yeah, I was thinking that maybe it belonged under os, but I decided it really
should stay in kernel.  That's the kernel's version of the command line, not
what was passed in from the host.

> Btw, many of the code movement things are just cut'n'paste things, so for them 
> there is no reason to delay them. Now we are going to merge them for 
> 2.6.13-rc1 (for .12 it's too late), but every other delay increases the 
> possibility that we fix somehow the code we are moving and forget to do the 
> same on the moved code.

Yeah, that's a concern.  I'm holding onto the code movement because I want to
look at the os interface that resulted from it, and see if it can be cleaned
up.

> Finally, about the syscall table patches for s390: I'm going to merge into -mm 
> the syscall table patches you can find in the last -devel snapshot I put on 
> my page (the uploaded ones maybe are out-of-date, but I'll cc you on 
> patches).

What patch is this?  All I see is a patch which makes some small fixes to
the sys_call_table.

> They entirely remove the UML syscall table to replace it with the $(SUBARCH) 
> one (there is some hand-work to do for each subarch but it's much less than 
> before). While doing this I also fixed various little bugs about this 
> subject.

Don't send that anywhere until I've seen it.  Your description of it makes
me nervous.

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
