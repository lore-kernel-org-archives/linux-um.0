Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IzjpD-0008Aa-A3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Dec 2007 18:17:23 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IzjpB-0003F2-Oa
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Dec 2007 18:17:23 -0800
Date: Tue, 4 Dec 2007 21:17:16 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071205021716.GA11522@c2.user-mode-linux.org>
References: <4755E360.4030505@BitWagon.com>
	<20071205002223.GC10763@c2.user-mode-linux.org>
	<4755F4EC.4050902@BitWagon.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4755F4EC.4050902@BitWagon.com>
Subject: Re: [uml-devel] reading uninit memory in do_io (ubd_kern.c)
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
To: John Reiser <jreiser@BitWagon.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Dec 04, 2007 at 04:46:36PM -0800, John Reiser wrote:
> It's up to the point of user mode for process 1; see log below.
> That means much of initialization, annotating the slab allocator
> (kmalloc) enough to "hide" the allocation structures from outside access
> but allow the allocator to reference them itself, and enough changes
> to valgrind to tolerate more forms of clone() and to handle switching
> stacks via longjmp().  I sent my changes for valgrind-3.2.3 to
> valgrind-developers last weekend.

Neato, that's further than I ever managed.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
