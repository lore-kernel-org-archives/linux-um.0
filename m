Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DChzL-000465-Gx for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2005 09:43:51 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DChzJ-0006Hi-TS for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2005 09:43:51 -0800
Message-Id: <200503192015.j2JKFexo002641@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] remap_page_range 
In-Reply-To: Your message of "Thu, 17 Mar 2005 10:40:01 EST."
	<EAC7622167479948B614F8B9AD41C505ECA8F5@MAANDMBX2.ets.enterasys.com> 
References: <EAC7622167479948B614F8B9AD41C505ECA8F5@MAANDMBX2.ets.enterasys.com>
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
Date: Sat, 19 Mar 2005 15:15:40 -0500
To: "Tsillas, Demetrios J" <jtsillas@enterasys.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

jtsillas@enterasys.com said:
> The kernel tries to read the value using the virtual address (offset
> from 0x271f0000) and gets back zeros. I've also tried look at the phys
> addr (offset from 0x1f1f0000) and that too is zeros. 

Have a look at the process /proc/<pid>/maps on the host to see what it has
mapped in at 0x404e9000.  The offset column is the offset into the VM file,
which is the physical address mapped in to that virtual address.

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
