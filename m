Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARDiu-0000iD-R0
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 08:50:04 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARDit-0001ry-34
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 08:50:03 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] iptables-restore randomly crashes under UML
In-Reply-To: <20031202164257.GA24954@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0312021737230.28431-100000@filer.marasystems.com>
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
Date: Tue, 2 Dec 2003 17:49:54 +0100 (CET)
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Tue, 2 Dec 2003, Jeff Dike wrote:

> > This applies to both tt and skas mode. 
> 
> No, it doesn't.  Those two are completely different in this case.

Not from what I can tell.. from what I can see when staring at the code
the code path for flushing the tlb is the same, and the frequency this
will happen is also the same.. in both it completely remaps the kernel vm
area on a tlb flush.

The only difference I see in this respect is that tt tries (but fails) to 
guess when the vm has not been changed and then does nothing..

How I propose this would be optimized differs slightly in tt or scas mode.  
What I propose is a page table mirror of the kernel vm area related to
each host vm used by the UML. This page table mirror is simply an array of
pte_t to the size of the kernel vm area. And only if there is any bitwise
difference between the pte in init_mm and the page table mirror is the
kernel vm page remapped and the page table mirror updated with the current
pte for that page.

Doing a lot of munmap/mmap calls is quite expensive for the host.

But as this field of the kernel is relatively new to me I suspect this
kind of optimization is actually overkill in skas mode. I suppose the
kernel vm area is meant to be unmapped when returning to user context and
in such case the number of tlb flushes compared to the total amount of 
remaps is very low..

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site=8

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
