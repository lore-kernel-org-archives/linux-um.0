Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMCOk-0001sP-3P	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 15:33:34 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ELtXx-0005uD-Rr
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 01 Oct 2005 19:25:52 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
Message-ID: <20051002010315.GA4778@localhost.localdomain>
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	<20050928145009.GA11610@ccure.user-mode-linux.org>
	<3524bf1f0509281225180173ae@mail.gmail.com>
	<200509291409.28067.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509291409.28067.blaisorblade@yahoo.it>
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
Date: Sat, 1 Oct 2005 21:03:15 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>

On Thu, Sep 29, 2005 at 02:09:27PM +0200, Blaisorblade wrote:
> Again, that page is not bad. There is no page yet for this address, and the 
> host won't allocate one for now.

It is bad in the sense that, unless some space is freed on that mount, a 
reference to the page will always fault.

> Ok, this makes a bit of sense, even if IMHO it doesn't work, I now see your 
> point (but I still insist with what said above).

Explain why it doesn't work.

> However, even a dirtied page could be "bad", if it has been swapped. If 
> we're getting a SIGBUS, it meant that it didn't succeed in freeing any 
> memory.

No it can't.  A swapped page still counts as occupying space in the filesystem.
If a page was successfully allocated, then accesses to it will always succeed,
even if it needs to be swapped in.

> And, frankly, unless the UML ram file is kept on ramfs (which is RAM-only), 
> it can be swapped (both for disk-based filesystem and for tmpfs).
> So, I don't think what you suggest could work.

Swapping makes no difference.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
