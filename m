Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zogM-000595-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 19:38:10 -0700
Received: from hongkong.cs.nmsu.edu ([128.123.64.160] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zogM-0007BT-7w
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 19:38:10 -0700
From: Ross Combs <rocombs@cs.nmsu.edu>
Message-Id: <200309180237.h8I2bs7c021691@hongkong.cs.nmsu.edu>
Subject: Re: [uml-devel] Re: 2.4.22-4um race condition
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 17 Sep 2003 20:37:54 -0600
To: jdike@addtoit.com, steve_schmidtke@hotmail.com
Cc: rocombs@cs.nmsu.edu, User-mode-linux-devel@lists.sourceforge.net

Jeff Dike <jdike@addtoit.com> wrote:

> steve_schmidtke@hotmail.com said:
> > There's a few things I noticed with start_io_thread, though mostly to
> > do  with failing cleanly.  Try the attached patch for 2.4.22-4um. 
>
> I mostly like those changes, except for moving the fd assignments before
> the clone in start_io_thread.  What's up with that?  If they are only
> assigned on the success path, they will remain invalid on any error path
> since they started invalid. 

Well, blame that part on me.  Steve's patch only moved one of the assignments
before the clone.  It's true that it doesn't matter if *fd_out is assigned
in either case.  The caller shouldn't be using it on error.

But it's important that kernel_fd is assigned before the clone.  That's
the race condition I was talking about.  The loop in io_thread() sends
kernel_fd to the read system call, but there is no guarantee that the
assignment in start_io_thread() has completed unless that assignment is
before the clone() call.  It's not just theoretical... it was causing me
to see startup crashes about 50% of the time on one computer.

About the assignment of -1 on error: that was just to prevent the accidental
use of the fd by the caller on error.  It's not needed either because the
caller shouldn't use that variable on failure.  I guess it was just paranoia.


> A slightly more theoretical justification for this is that it has no business 
> deciding what the caller considers to be invalid.  So, it's best just to
> leave it alone if there's an error.

Ok, fine with me.  It should make no functional difference.


> A practical reason is that this reduces the code size because you don't have
> to remember to make them invalid on the error paths.

True.


> Except for that bit, those changes are merged.

Great!  Please make sure that kernel_fd is initialized before use in the
other thread though -- unless I misunderstood you, that part wasn't merged.

-Ross


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
