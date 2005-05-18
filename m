Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYQEX-0002qw-UY	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 08:13:17 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYQEW-0002y3-1U	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 08:13:17 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] copy_from_user in SKAS mode
Message-ID: <20050518150802.GB18740@ccure.user-mode-linux.org>
References: <3524bf1f0505171633edddc7@mail.gmail.com>
	<20050518011827.GA13287@ccure.user-mode-linux.org>
	<3524bf1f05051806474362d786@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3524bf1f05051806474362d786@mail.gmail.com>
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
Date: Wed, 18 May 2005 11:08:02 -0400
To: Young Koh <young.koh@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, May 18, 2005 at 09:47:37AM -0400, Young Koh wrote:
> you mean "physical" to the UML kernel? 

Yes.  To the host, it's just normal process virtual memory, but to UML, 
that's its physical memory.

> Because the UML kernel cannot
> know about the real physical pages in the host kernel,  do you mean
> the UML kernel finds out which its (virtual) address maps to the same
> real physical page that the user process's address maps to? but the
> UML kernel and the user process would have different mappings and
> cannot know about each other (if so, its a protection violation
> between processes) Could you explain a bit more? Thanks a lot!!!

It's exactly the same as the host.  There is physical memory mapped into
its address space, and pages from that area are allocated and mapped into
process address spaces as needed.  In skas mode, UML has no direct access
to the process address spaces (like the x86 4G/4G split), so it has to
translate the process virtual address into a UML physical address, to which
it does have access, and can copy the data.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
