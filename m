Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNbzj-0004BF-4r for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Mar 2006 12:37:51 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FNbzb-00009S-Qq
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Mar 2006 12:37:45 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Fwd: Re: Why
	uml-add-tls-support-debug-check-never-works is needed (was: Re:
	Fwd: Proposed additions to the ptrace(2) manpage, take 2)
Message-ID: <20060326203855.GA4549@ccure.user-mode-linux.org>
References: <200603262003.58195.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603262003.58195.blaisorblade@yahoo.it>
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
Date: Sun, 26 Mar 2006 15:38:55 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Mar 26, 2006 at 08:03:57PM +0200, Blaisorblade wrote:
> Code which two people aren't able to understand until two years later _wants_
> at least some comments and if possible restructuring. 

I'd say this is more of an oversight than obscure code that the author 
doesn't even understand.

> The problem is how, and
> I'm not looking at the code right now. Off the top of my head, I get only
> silly ideas, since we can't join the end of switch_to_skas() and
> fork_handler().

Yeah, I only got silly ideas too.  Probably the same ones :-)

> I didn't study softints, but setjmp() is supposed to use jmp_buf's, not
> sigjmp_buf's (I know they are (almost) equal in the glibc headers I've seen,
> but that equality is not guaranteed).

Yes, good point.  You didn't have to even look at libc headers - just
pointing at the man page is enough.

> If you don't pass 1 and INIT_JMP_REMOVE_SIGSTACK but two further defines like
> "JUMP_TO_INITIAL_THREAD" and "JUMP_BACK" (or actually meaningful names) the
> caller won't know more than it knows now. Or you can keep the callers intact
> - just by making switch_threads() and thread_wait() two inline
> wrappers.

Yup, that would work, though it probably wouldn't shrink the source -
the merged code will be less than the new function boilerplate and the
calls to it.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
