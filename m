Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CybU7-0005L9-Gq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 11:57:19 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CybU5-0007sl-U6 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 11:57:19 -0800
Message-Id: <200502082223.j18MMxs0013724@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Tue, 08 Feb 2005 18:37:22 +0100."
	<200502081837.22519.blaisorblade@yahoo.it> 
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
	<200502081829.j18ITAs0003968@ccure.user-mode-linux.org>
	<200502081837.22519.blaisorblade@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [BUG report] UML linux-2.6 latest BK doesn't compile
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
Date: Tue, 08 Feb 2005 17:22:59 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, lkml <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

blaisorblade@yahoo.it said:
> Why not simply disable CONFIG_GCOV for him, in this case? 

Anton presumably turned on CONFIG_GCOV because he wanted to do some profiling...

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
