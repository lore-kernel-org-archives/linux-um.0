Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIBEW-0004TH-QQ	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 13:30:24 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1EIBEV-0007IF-Hz
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 13:30:24 -0700
From: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050921124957.437cf069.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0509211328150.2553@g5.osdl.org>
References: <200509211923.21861.blaisorblade@yahoo.it>
	<20050921124957.437cf069.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: [PATCH 07/10] uml: avoid fixing faults while atomic
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
Date: Wed, 21 Sep 2005 13:29:59 -0700 (PDT)
To: Andrew Morton <akpm@osdl.org>
Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org



On Wed, 21 Sep 2005, Andrew Morton wrote:
>
> There's an extremely special-case in the pagefault handlers where we fail
> the fault if in_atomic().  It's unrelated to spinlocks (spinlocks don't
> even cause in_atomic() to become true if !CONFIG_PREEMPT).

There's a few other places where we use those semantics, though.

Like "get_futex_value_locked()".

> So I think this change is only needed if UML implements kmap_atomic, as in
> arch/i386/mm/highmem.c, which it surely does not do?

No. Every architecture needs to honor it, or they are screwed.

		Linus


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
