Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6sz7-0006Zy-RC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Mar 2005 08:15:33 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D6sz5-0002MQ-Be for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Mar 2005 08:15:33 -0800
Message-Id: <200503031844.j23IhmDS003473@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Triage on the pending patches 
In-Reply-To: Your message of "Thu, 03 Mar 2005 00:08:51 EST."
	<200503030008.51336.rob@landley.net> 
References: <200503030822.j238MoBY016825@ccure.user-mode-linux.org>
	<200503030008.51336.rob@landley.net> 
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
Date: Thu, 03 Mar 2005 13:43:48 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

rob@landley.net said:
> Well, just in case your job was too easy, here's one more.  Using the
> "quiet" option shows a couple of lines being printed out by printf
> that should be printed out by printk (so they'll _shut_up_ when you
> ask it to). 

Those are printfs for a reason.  Early boot mesages (before the kernel is
actually running) won't be seen if they are printk-d and the thing crashes
before the console is initialized.  The messages will be stuck in the printk
buffer, and you will be none the wiser.

So, they can be made quiet if you really want, but that's not the way.

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
