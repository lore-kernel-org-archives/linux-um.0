Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATQQH-0000hS-C6
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 10:47:57 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ATQQF-0000IA-BL
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 10:47:55 -0800
Message-Id: <200312081901.hB8J1VAv028738@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] Locking user-mode kernel RAM into host physical RAM 
In-Reply-To: Your message of "Mon, 08 Dec 2003 16:39:08 GMT."
             <200312081639.22888.matthew-list@bytemark.co.uk> 
References: <200312081639.22888.matthew-list@bytemark.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 08 Dec 2003 14:01:31 -0500
To: Matthew Bloch <matthew-list@bytemark.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

As far as I'm concerned, this is papering over the symptoms rather than fixing
a real problem.

If you're really not overselling memory, then the host should not be swapping.
If it is, then that's the problem.

> My experience with 2.4 as  a host kernel is that it will quite happily
> swap out pages from running  applications to use as disc cache; this
> is apparently alleviated with 2.6's  "swappiness" kernel parameter.

This being the case, you should maybe be looking at 2.6 as your host.

> I hope that it's obvious enough to warrant inclusion in the next
> release of  the UML patch

It's not.  Feel free to argue, but this is really the wrong thing to do, IMHO.

In any case, I have something different in the works.

First, there is ubd-mmap + /dev/anon.  ubd-mmap makes the ubd driver mmap data
from its devices into its physical memory rather than copying it.  This causes
UML to share the data with the host page cache rather than copying it into a
separate page of its own.  This by itself reduces host memory consumption,
which will alleviate the swapping problem on the host.  /dev/anon is a new
host driver which implements the munmap semantics needed by UML physical memory
(pages are release to the host when they're no longer mapped, even if they're
dirty).  My /dev/anon driver is still buggy, but it works well enough to boot
and run UML, and get memory consumption measurements.  On a simple 
boot-my-Debian-image-to-a-login-prompt test, I get ~25% reduction in host 
memory consumption and ~25% increase in the number of UMLs that run before the
host starts swapping.  Giving credit where credit is due, this is thanks to
memset, which ponied up some money to make it happen.

A happy side-effect of the infrastructure needed to make this work is that
it is now possible to plug memory in and out of UMLs dynamically.  This means
that host memory can now be managed by removing it from idle UMLs and giving
it to busy ones.  This would be implemented by a daemon on the host monitoring
the memory state of the host and UMLs.  The UML monitoring is made possible
by the mconsole proc interface which I added a while back.  The daemon would
implement whatever policy the site wants.  

A reasonable default policy is to keep the host from swapping.  So, it would
shuffle memory between UMLs subject to the constraint that the host shouldn't
swap.  So, whenever it looks like the host is running short of free memory,
it would remove some memory from a UML or two in order to alleviate the
shortage.  I'm planning on shipping such a script when I think this stuff works.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
