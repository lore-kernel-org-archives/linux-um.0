Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARIDS-0001kZ-TT
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 13:37:54 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ARIDS-0007k1-6X
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 13:37:54 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] iptables-restore randomly crashes under UML
In-Reply-To: <20031202185839.GG24954@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0312022225020.30614-100000@filer.marasystems.com>
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
Date: Tue, 2 Dec 2003 22:37:46 +0100 (CET)
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Tue, 2 Dec 2003, Jeff Dike wrote:

> I used to do that.  The problem with it is that doing lookups and updates
> of the shadow page tables involves allocating memory, which can sleep.  So,
> when you sleep inside schedule, you schedule again, and sleep in get_free_page
> again, and that gets ugly rather quickly.

Right.

> Yup.  This can be optimized somewhat by eliminating some of the munmap parts
> of the munmap/mmap pairs.

Accorting to my stats about 99% of the kernel vm mmap/munmap is in vain,
at least in TT mode.. and this was observed with the mm_seq optimization
enabled. But to optimize these away one needs to know what have changed..

What I also noticed was that there seems to be a lot of vm_seq updates
even without any kernel vm area modifications (at leas not any I could
notice). So not only did this miss updates on vfree() it also triggered 
a flush even if there was no updates.

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
