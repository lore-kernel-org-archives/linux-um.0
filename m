Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4LRR-0004VN-UR for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Feb 2005 08:02:17 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D4LRQ-0001n1-9t for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Feb 2005 08:02:17 -0800
Message-Id: <200502241736.j1OHaFha003688@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] UML startup -- segfault with no mm 
In-Reply-To: Your message of "Wed, 23 Feb 2005 23:36:21 EST."
	<421D59C5.9020003@enterasys.com> 
References: <421D59C5.9020003@enterasys.com> 
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
Date: Thu, 24 Feb 2005 12:36:14 -0500
To: "D. Bahi" <dbahi@enterasys.com>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

dbahi@enterasys.com said:
> here's a wonderfully infrequent but nagging startup failure that
> usually has a useless (no stack depth, or just corrupt) backtrace... 

You need the uml-enable-the-timer-after-the-timer-handler.patch patch:

	http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm1/broken-out/uml-enable-the-timer-after-the-timer-handler.patch

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
