Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Axy9e-0007BK-BL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 16:53:02 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Axxxc-0006R9-Hj
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 16:40:36 -0800
Message-Id: <200403020111.i221BAM9025673@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] fix writing into /dev/kmem 
In-Reply-To: Your message of "Sun, 29 Feb 2004 17:20:19 +0100."
	<200402291720.19359.blaisorblade_spam@yahoo.it> 
References: <20040229023636.GB8272@ccure.user-mode-linux.org>
	<200402291720.19359.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 01 Mar 2004 20:11:10 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> the i386 Oopses, normally, kill only the thread which triggered the
> fault -  while instead Uml panics altogether. Cannot this be changed
> at  arch/um/kernel/trap_kern.c:segv()? 

If there's an unexplained kernel mode access fault, anything could be wrong.

I don't see that it's reasonable to just kill the process when kernel data
could be corrupted as far as we know.

I don't know why x86 thinks it can just kill the process.

> By the way: in handle_page_fault(), there is some dead code (attached
> is the  removal patch).

That shouldn't be dead code.  I think it should be attached to the VM_FAULT_OOM
case - I copied it from x86, so check there to be sure.

> I also do not understand the loop around handle_mm_fault call, but I
> could be  wrong: are you sure that after a successful handle_mm_fault
> (i.e. a major or  minor fault) pte_present(*pte) could be false? If
> handle_mm_fault is not  successful, we exit the loop anyway. 

It's possible that the page could have been swapped out between fixing the
fault and the return from handle_mm_fault.  Way back in history, I had a 
check for the same fault happening twice in a row, and panicing if it happened.
This was when UML's fault handling still needed debugging.  To prevent the
case I just mentioned from triggering that panic, I added the loop to make sure
the page was good before returning to userspace.

				Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
