Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATo5T-0007kD-WA
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Dec 2003 12:04:03 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ATo5T-0008Fd-2e
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Dec 2003 12:04:03 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] [PATCH] provide asm/ldt.h 
In-Reply-To: <Pine.LNX.4.44.0312091259250.1263-100000@gradall.private.brainfood.com>
Message-ID: <Pine.LNX.4.44.0312092101350.27531-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 9 Dec 2003 21:03:42 +0100 (CET)
To: Adam Heath <adam@doogie.org>
Cc: Jeff Dike <jdike@addtoit.com>, Steve Bennett <steveb@snapgear.com>, user-mode-linux-devel@lists.sourceforge.net

On Tue, 9 Dec 2003, Adam Heath wrote:

> This is not correct.
> 
> The user-side of UML should not care about the kernel version *at all*.  It
> should only be concerned with the posix interface defined by the host
> compiling environment, and the arch interface defined by UML.

We are talkning about userspace applications which are in different ways
dependent on the kernel they run against. This includes but not limited to

  * iptables
  * strace
  * modutils

and how these should be build when using a UML kernel.

We are NOT talking about the UML kernel sources as such.

Regards
Henrik




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
