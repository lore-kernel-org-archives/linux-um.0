Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATn6C-0003k5-3u
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Dec 2003 11:00:44 -0800
Received: from brown.brainfood.com ([146.82.138.61] helo=gradall.private.brainfood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATn6B-0000q7-PN
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Dec 2003 11:00:43 -0800
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] [PATCH] provide asm/ldt.h 
In-Reply-To: <Pine.LNX.4.44.0312090101020.14902-100000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.44.0312091259250.1263-100000@gradall.private.brainfood.com>
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
Date: Tue, 9 Dec 2003 13:01:01 -0600 (CST)
To: Henrik Nordstrom <hno@marasystems.com>
Cc: Jeff Dike <jdike@addtoit.com>, Steve Bennett <steveb@snapgear.com>, user-mode-linux-devel@lists.sourceforge.net

On Tue, 9 Dec 2003, Henrik Nordstrom wrote:

> On Mon, 8 Dec 2003, Jeff Dike wrote:
>
> > How are these kernel-dependent (in the sense that they have to be built against
> > a UML /usr/include/asm or they won't work under UML)?
>
> They are kernel dependent in that they need to be build to a
> /usr/src/linux/include tree matching the kernel used. The "kernel"
> headers in /usr/include/ should not be used when compiling kernel
> dependent applications, those are just there from historic reasons to make
> glibc happy.

This is not correct.

The user-side of UML should not care about the kernel version *at all*.  It
should only be concerned with the posix interface defined by the host
compiling environment, and the arch interface defined by UML.

In *all* cases where UML's userspace is including kernel headers(directly or
indirectly), the userspace is wrong, and *must* be fixed.  This means changing
the UML arch interface to hide these internal kernel apis.



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
