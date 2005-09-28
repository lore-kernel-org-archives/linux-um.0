Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKeYB-0004cr-Kg	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 09:12:55 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EKeY8-0004Ev-Ts
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 09:12:55 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
Message-ID: <20050928145009.GA11610@ccure.user-mode-linux.org>
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	<20050927172812.GA28528@ccure.user-mode-linux.org>
	<200509281359.48449.blaisorblade@yahoo.it>
	<3524bf1f05092806477e590930@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3524bf1f05092806477e590930@mail.gmail.com>
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
Date: Wed, 28 Sep 2005 10:50:09 -0400
To: Young Koh <young.koh@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Sep 28, 2005 at 09:47:41AM -0400, Young Koh wrote:
> yes, i think memory can go bad if 1) it cannot be allocated because of
> filesystem full or similar reasons as Jeff described, or 2) it was
> allocated once but could have been swapped.
> 
> in case of 1) it should be more like kernel panic rather than just a
> system call error, i think? because kernel cannot allocate any more
> memory, which kernel is supposed to use.

No, just that page is bad.  Another page could have been dirtied and thus
allocated on the host, and it would be usable.  So, it's not a fatal problem.

> in case of 2) this is a real fault, so, the seg fault handler of UML
> kernel is supposed to load the swapped page and UML kernel proceeds
> normally? (as Blaisorblade described in the other mail, by calling
> handle_page_fault()?)

Yes, this happens in the call from maybe_map.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
