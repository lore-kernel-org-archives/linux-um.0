Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J08rZ-0002vq-S2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 21:01:30 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J08rZ-0001Wj-9i
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 21:01:29 -0800
Date: Thu, 6 Dec 2007 00:01:24 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071206050124.GA12584@c2.user-mode-linux.org>
References: <4755E360.4030505@BitWagon.com>
	<20071205002223.GC10763@c2.user-mode-linux.org>
	<4755F4EC.4050902@BitWagon.com>
	<20071206021016.GB10961@c2.user-mode-linux.org>
	<47577C8A.8060104@BitWagon.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47577C8A.8060104@BitWagon.com>
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

On Wed, Dec 05, 2007 at 08:37:30PM -0800, John Reiser wrote:
> Thanks for the tip.  I was getting stuck trying to figure out the
> ptrace() shenanigans involved with the stub [skas0 mode] that turns
> SIGSEGV into SIGUSR1.  Valgrind has its own ideas about what
> should happen with signals, and the ptracing gets complicated.

I think if you just don't follow that clone, things will be better.
However, since you ask, what happens is this:
	process (at startup, in userspace_tramp) sets the handler in
the stub as its SIGSEGV handler
	process accesses memory that hasn't been mapped and segfaults
	UML kernel sees SIGSEGV and allows it to be delivered
	stub SIGSEGV handler reads page fault information out of its
sigcontext struct and puts it someplace the UML kernel can find
	handler sends itself a SIGUSR1
	SIGUSR1 is masked in this handler, so it's delivered right
after the sigreturn
	UML kernel sees SIGUSR1 and knows the page fault data is
available

> The very first thing that the skas0 stub does is field SIGSEGV because
> the page which contains the entry point of the PT_INTERP of /sbin/init
> is not present.

Right, that's the first page fault.

> The signal handler in the stub forwards this SIGSGEV
> to uml as SIGUSR1, and the ptrace()ing code inside uml "understands"
> what the child is doing.

See above, it's not really describable as forwarding.

> Perhaps valgrind could recognize the
> skas0 stub (SIGSEGV.sa_handler >= 0xbffe0000, etc.) and adapt,
> or perhaps both valgrind and uml should cooperate here.  I'm still
> puzzling over this one.

I would just let this clone escape - things should just work then.

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
