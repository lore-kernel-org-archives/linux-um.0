Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BwvXY-0003ed-O1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Aug 2004 21:25:40 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BwvXI-0005Xm-M8
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Aug 2004 21:25:40 -0700
Message-Id: <200408170526.i7H5Q9Nj018785@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: handle_trap - failed to wait at end of syscall
	[was Re: [uml- devel] debugging UML cores] 
In-Reply-To: Your message of "Mon, 16 Aug 2004 15:53:37 EDT."
	<412110C1.7080808@enterasys.com> 
References: <200408132147.i7DLlB2o003883@ccure.user-mode-linux.org>
	<4120F325.9030401@nortelnetworks.com>
	<41210A22.2080404@nortelnetworks.com>
	<412110C1.7080808@enterasys.com> 
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
Date: Tue, 17 Aug 2004 01:26:09 -0400
To: "D. Bahi" <dbahi@enterasys.com>
Cc: Joe Marzot <gmarzot@nortelnetworks.com>, user-mode-linux-devel@lists.sourceforge.net

dbahi@enterasys.com said:
> does this look familar? humm, here's 2.4.26-3um, backtrace attached. 

Not even close to the same bug.  It's segfaulting at neighbour.c, line 1341,
which is this:

  1340          ci.ndm_used = now - n->used;
  1341          ci.ndm_confirmed = now - n->confirmed;
  1342          ci.ndm_updated = now - n->updated;

This is mystifying because whatever address that line 1341 could have faulted 
on, line 1340 should have faulted.  The fault address is 61 (== 0x3d), which
I can't see in that code either.  If n were 0, then you'd get a fault on some
low address, but
	n = 0x260535a0 (and I assume you're using the new load-low option)
	n->confirmed is a 4-byte aligned field, and would not fault on an
odd address.

So, I think I don't totally trust gdb's line number reporting in this case.
What I would do is disassemble neigh_fill_info, and see what line the faulting
instruction really belongs to.

				Jeff



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
