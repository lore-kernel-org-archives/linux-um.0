Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARFXP-0007AZ-Ed
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 10:46:19 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ARFXN-0005HA-0T
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 10:46:17 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] iptables-restore randomly crashes under UML
Message-ID: <20031202185839.GG24954@ccure.user-mode-linux.org>
References: <20031202164257.GA24954@ccure.user-mode-linux.org> <Pine.LNX.4.44.0312021737230.28431-100000@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312021737230.28431-100000@filer.marasystems.com>
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
Date: Tue, 2 Dec 2003 13:58:39 -0500
To: Henrik Nordstrom <hno@marasystems.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Tue, Dec 02, 2003 at 05:49:54PM +0100, Henrik Nordstrom wrote:
> Not from what I can tell.. from what I can see when staring at the code
> the code path for flushing the tlb is the same, and the frequency this
> will happen is also the same.. in both it completely remaps the kernel vm
> area on a tlb flush.

Once you're in the tlb flush code, you're right.  I was talking about the
problem you're seeing, which is very tt mode-specific.

> How I propose this would be optimized differs slightly in tt or scas mode.  
> What I propose is a page table mirror of the kernel vm area related to
> each host vm used by the UML. This page table mirror is simply an array of
> pte_t to the size of the kernel vm area. And only if there is any bitwise
> difference between the pte in init_mm and the page table mirror is the
> kernel vm page remapped and the page table mirror updated with the current
> pte for that page.

I used to do that.  The problem with it is that doing lookups and updates
of the shadow page tables involves allocating memory, which can sleep.  So,
when you sleep inside schedule, you schedule again, and sleep in get_free_page
again, and that gets ugly rather quickly.

> Doing a lot of munmap/mmap calls is quite expensive for the host.

Yup.  This can be optimized somewhat by eliminating some of the munmap parts
of the munmap/mmap pairs.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site=8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
