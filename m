Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D5pnV-0004hN-9E for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Feb 2005 10:39:13 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D5pnT-0007Nw-Nn for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Feb 2005 10:39:13 -0800
Message-Id: <200502281934.j1SJYRMY003256@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] UML startup -- segfault with no mm 
In-Reply-To: Your message of "Thu, 24 Feb 2005 13:38:05 EST."
	<421E1F0D.4040108@enterasys.com> 
References: <421D59C5.9020003@enterasys.com>
	<200502241736.j1OHaFha003688@ccure.user-mode-linux.org>
	<421E1F0D.4040108@enterasys.com> 
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
Date: Mon, 28 Feb 2005 14:34:27 -0500
To: "D. Bahi" <dbahi@enterasys.com>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

dbahi@enterasys.com said:
> actually - 2.4.26-3um looks like this already. 

Yeah, if I had spent a bit more time looking at the stack, I would have noticed
that the symptom was wrong for that patch.  What's happening is that you are
taking a timer interrupt while on the initial process stack, which can't be
allowed because interrupts should only happen on a kernel stack.

Make sure your initial_thread_cb_skas (in arch/um/kernel/skas/process.c)
blocks signals like so:

	block_signals();
	if(sigsetjmp(here, 1) == 0)
		siglongjmp(initial_jmpbuf, 2);
	unblock_signals();

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
