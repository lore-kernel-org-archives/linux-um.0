Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CyFc3-0005Lu-1G for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Feb 2005 12:36:03 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CyFc1-0003ZL-Dc for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Feb 2005 12:36:02 -0800
Message-Id: <200502072222.j17MMGlS004622@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Fix compilation of UML after the stack-randomization
	patches 
In-Reply-To: Your message of "Mon, 07 Feb 2005 18:33:13 +0100."
	<200502071833.13571.blaisorblade@yahoo.it> 
References: <4203CF43.20703@tuxrocks.com>
	<200502071833.13571.blaisorblade@yahoo.it> 
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
Date: Mon, 07 Feb 2005 17:22:16 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Frank Sorenson <frank@tuxrocks.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

blaisorblade@yahoo.it said:
> I've the doubt that the addition would better go under sys-i386 or
> some other  subarch-dependent directories (in a file compiled against
> kernelspace  headers, i.e. not listed in USER_OBJS in the directory
> it's contained  inside), and it'd be nice to add also the x86_64
> version. 

Yes, good point.

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
