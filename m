Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCjF9-0007k7-2E for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2005 11:04:15 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DCjF6-0004b6-V9 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2005 11:04:14 -0800
Message-Id: <200503191957.j2JJvWxo002621@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Getting fault address from a SIGSEGV 
In-Reply-To: Your message of "Sat, 19 Mar 2005 14:44:44 +0100."
	<423C2CCC.9040809@cs.unibo.it> 
References: <423C2CCC.9040809@cs.unibo.it> 
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
Date: Sat, 19 Mar 2005 14:57:32 -0500
To: Mattia Belletti <mbellett@cs.unibo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

mbellett@cs.unibo.it said:
> but I don't know where  in the code such status is filled, and so
> where such information is  taken from :-)

On x86 (and x86_64), the fault address is sigcontext.cr2, the access type is
stored in .err, and the CPU fault type is in .trapno.

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
