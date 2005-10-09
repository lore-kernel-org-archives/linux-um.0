Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOkJS-0003ZF-8H	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 16:10:38 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EOkJU-0001IL-L4
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 16:10:42 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20051009224122.GA8282@ccure.user-mode-linux.org>
References: <200510092118.21032.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510092118.21032.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Uml left showstopper bugs for 2.6.14
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
Date: Sun, 9 Oct 2005 18:41:22 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Sun, Oct 09, 2005 at 09:18:20PM +0200, Blaisorblade wrote:
> 1) problems with UBD (i.e. _the_ uml block driver): this is pretty dangerous 
> and untrivial to fix, even if the code exists - so I and Jeff agreed to revert 
> the change altogether. Jeff will send the thing.

My current plan is to revert the ubd-aio patch.  I need to look at this and
run some testing on it.

> 3) SKAS0 is broken on amd64 hosts, when frame pointers are disabled. Jeff has 
> the fix, waiting end of testing.

This has been sent to Linus.

> 5) Compile-time regression with SKAS mode disabled, will fix later (I'm going 
> to have dinner now).

I looked at the patch and requested the sender forward it to Linus, with my
approval.  If he doesn't in the next day or so, then I'll send it in myself.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
