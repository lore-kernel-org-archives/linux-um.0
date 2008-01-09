Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCj7W-00055f-N7 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 14:09:58 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JCj7V-0007uZ-R2
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 14:09:58 -0800
Received: from c2.user-mode-linux.org (littleton.addtoit.com [198.99.130.129])
	by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id m09M9nPx000385
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 9 Jan 2008 17:09:51 -0500
Received: from c2.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by c2.user-mode-linux.org (8.14.1/8.13.8) with ESMTP id m09M9nNq009289
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 9 Jan 2008 17:09:49 -0500
Date: Wed, 9 Jan 2008 17:09:49 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080109220949.GA9185@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 0/9] SKAS4
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

These patches implement host and guest SKAS4 support for both 32- and
64-bit x86.

I think the new interfaces here are much more acceptable, so I'm going
to push this to mainline.

What's new:
    two new system calls -
	new_mm - creates a new address space and returns a file
descriptor referencing it
	switch_mm - moves the calling process to the address space
referenced by the file descriptor passed to it
	/proc/<pid>/mm - opening this gives you a file descriptor
referencing the address space occupied by the given pid - this
descriptor can be given to switch_mm just as a new_mm descriptor can

    siginfo_t extensions - siginfo_t always contained the faulting
address in the SIGSEGV case.  However, for it to be useful to UML, it
needs the CPU trap number and error code.  There already was
conditional support for the trap number, which x86 didn't implement.
This is enabled, and support for passing out the error code is added.

How this compares to skas3:

Creating a new address space:
    skas3 - open /proc/mm
    skas4 - new_mm()

Remapping pages within another address space
    skas3 - write a structure desribing the change to a /proc/mm
descriptor
    skas4 - switch_mm to the address space, run the necessary system
calls directly, switch_mm back to the UML kernel address space

Getting page fault information from a process
    skas3 - PTRACE_FAULTINFO
    skas4 - PTRACE_GETSIGINFO

This patchset contains 9 patches.  Four of them contain the siginfo
extension, guest siginfo support, host new_mm/switch_mm support, and
guest new_mm/switch_mm support.  The rest are preparation patches
which shouldn't change anything functionally, but which make the four
functional patches smaller and easier to read.

These are against 2.6.24-rc7.  Build both host and guest from the same
tree.  I will be tweaking the interfaces in incompatible ways, so if
you play with future versions of this patchset, throw this one out.
Definitely don't try to boot a guest built from one version on a host
built from another.  It will work, but likely you'll get skas0, as
there will likely be some interface change which causes the host skas4
checks to fail.

This is very experimental at this point.  Don't let it near anything
resembling a production system.

				Jeff


-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
