Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAqWY-0003uS-2h for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2005 06:26:26 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAqWV-0003Tg-Fy for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2005 06:26:25 -0800
Message-Id: <200503141613.j2EGDqFF002836@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [patch] Fixing the stdio console stuttering. 
In-Reply-To: Your message of "Mon, 14 Mar 2005 00:43:49 EST."
	<200503140043.50163.rob@landley.net> 
References: <200503140043.50163.rob@landley.net> 
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
Date: Mon, 14 Mar 2005 11:13:52 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

rob@landley.net said:
> I spent far too much of the weekend tracking this sucker down through
> the guts of the tty code.  The problem turns out to be that drivers/
> char/n_tty.c has a write_chan that does buffering and retransmitting
> data, and arch/um/drivers/chan_kern.c ALSO has a write_chan that
> buffers and retransmits data, and the first calls the second but the
> second doesn't always return correct status information for the
> -EAGAIN case.


Excellent, thanks.

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
