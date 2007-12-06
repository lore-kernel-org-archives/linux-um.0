Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J06C1-0003Pw-G4 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 18:10:25 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J06C0-0003Yb-Hz
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Dec 2007 18:10:25 -0800
Date: Wed, 5 Dec 2007 21:10:16 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071206021016.GB10961@c2.user-mode-linux.org>
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
> and enough changes
> to valgrind to tolerate more forms of clone() 

I was going to ask whether you were treating the clone that creates
the userspace process differently from other clones, but I guess the
bit below answers that question:

> **24577** new_thread_handler  fn=0x807FD8C  arg=0x822AF48
>   [snip: panic due to SIGSEGV seen from wait_stub_done()]

And I guess it's not treated differently and valgrind continues
grinding the child, and it craps out when it unmaps everything in the
child address space except the stubs.

Whether you want the userspace process to escape valgrind or not
depends on whether you want full-system analysis (which some people
do, and cachegrind in particular would be very interesting on a full
system) or whether you want to smoke out kernel bugs (which is my main
interest here).

It'll be easier to let the userspace child escape - invent an
annotation for "don't follow this clone".

Longer-term, following this clone and allowing full-system analysis
would require some thought.  The first problem, of course, is that
about the first the stub does in the new process is unmap everything
but itself, including valgrind.

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
