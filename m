Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8PxW-0003dU-E1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 13:40:14 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8PxU-00049w-SF for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 13:40:14 -0800
Message-Id: <200503080010.j280ABbc005264@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: Partial fix! - Was: Re: [BUG report] UML
	linux-2.6 latest BK doesn't compile 
In-Reply-To: Your message of "Mon, 07 Mar 2005 20:44:48 +0100."
	<200503072044.49206.blaisorblade@yahoo.it> 
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
	<1108380903.22656.9.camel@imp.csi.cam.ac.uk>
	<200503051945.j25JjIB5003539@ccure.user-mode-linux.org>
	<200503072044.49206.blaisorblade@yahoo.it> 
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
Date: Mon, 07 Mar 2005 19:10:11 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Anton Altaparmakov <aia21@cam.ac.uk>, lkml <linux-kernel@vger.kernel.org>

blaisorblade@yahoo.it said:
> a) wrong because you say __GNUC_PATCHLEVEL__ > 4 rather than >= 

Correct, this is now fixed.

> b) wrong because for he the link failed on __bb_init_func at the
> beginning. So  in the case you need to export BOTH symbols. 

Incorrect, the link failure was caused by trying to export __bb_init_func,
which makes a reference to it, which was subsequently not being resolved.

You can't export a symbol which doesn't exist.

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
