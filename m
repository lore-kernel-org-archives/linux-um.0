Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5m9M-0003mm-21 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 10:26:53 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I5m9K-0006OM-ED
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 10:26:52 -0700
Date: Tue, 3 Jul 2007 13:26:38 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070703172638.GA31640@c2.user-mode-linux.org>
References: <20070614202655.GA9647@c2.user-mode-linux.org>
	<20070627233701.8e53f3cb.akpm@linux-foundation.org>
	<200707031728.36472.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200707031728.36472.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 4/5] UML - Simplify helper stack handling
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Tue, Jul 03, 2007 at 05:28:30PM +0200, Blaisorblade wrote:
> > fchown01 used greatest stack depth: 4892 bytes left
> 
> > That's the sum of process stack and interrupt stack, but I doubt if this
> > little box is using much interrupt stack space.
> >
> > No wonder people are still getting stack overflows with 4k stacks...
> 
> First, those numbers pretend to be _unused_ stack space.

But on an 8K stack.  If you pretend to be on a 4K stack, and take 4K
away from that, those numbers are 100s of bytes away from eating the
stack.

> Well, UML tends to use more stack space than the rest of
> kernel. Apart it has a bit more layering (even if less than in the
> past), we must use libc's function too, and they're not written to
> be executed on an 8k stack.

We don't use very much of libc on kernel stacks.  Also, various things
have been done to reduce stack usage.  We no longer initialize kernel
stacks with a signal frame on them.  We now have IRQ stacks.  I've
also done some amount of general stack usage reduction.  I haven't
seen anything come very close to running out of stack.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
