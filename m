Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAx4w-000265-56 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2005 13:26:22 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAx4u-000176-Jl for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2005 13:26:22 -0800
Message-Id: <200503142219.j2EMJfFF010069@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Fixing the __gcov_init problem 
In-Reply-To: Your message of "Mon, 14 Mar 2005 20:16:00 +0100."
	<200503142016.00634.blaisorblade@yahoo.it> 
References: <200503130654.j2D6rrAM005199@ccure.user-mode-linux.org>
	<200503142016.00634.blaisorblade@yahoo.it> 
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
Date: Mon, 14 Mar 2005 17:19:41 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>

blaisorblade@yahoo.it said:
> The obtained code by this patch is a bit of a mess... plus there is a
> bunch of  other problems (I've posted another mail with the
> description of the  problems). The patch below is a partial solution
> to all them... 

Sigh.  OK, I'll drop that in my tree for now in place of mine, but won't send
it anywhere until we think it is roughly right.

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
