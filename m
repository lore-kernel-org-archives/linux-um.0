Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3d7u-0001Dn-R7	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 10:15:26 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3d7u-0005VB-CI
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 10:15:26 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050812170900.GC7448@ccure.user-mode-linux.org>
References: <42D7D802.2080100@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D7D802.2080100@fujitsu-siemens.com>
Subject: [uml-devel] Re: Some changes in SKAS0
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
Date: Fri, 12 Aug 2005 13:09:00 -0400
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>, BlaisorBlade <blaisorblade_spam@yahoo.it>

From our discussion yesterday, ...

On Fri, Jul 15, 2005 at 05:36:34PM +0200, Bodo Stroesser wrote:
> So I thought about avoiding the sigreturn at all. Working on
> this I found out some small points:

I kept this patch

> - there is a bug (typo) in wait_stub_done()

but dropped these two, plus my dont-save-fpregs patch.  Correct?

> - stopping stub_segv_handler with a "breakpoint" without
>   calling sigreturn, lets SIGSEGV being blocked after that.
>   At the next SIGSEGV, I see stub_wait_done() calling panic
>   just as with Rob's problem. And I see the child being gone!
>   I understand, that the host unblocks SIGSEGV and sets the
>   handler to SIG_DFL. But I don't understand, why the child
>   already is gone after the waitpid(), without resuming it.
>   I guess, this is the reason for Rob not being able to debug
>   the problem.
>   Thus I added SA_NOMASK to the flags for the handler.
> 
> - I changed the additional mask for the handler to be empty.
>   The only exception is x86_64, that currently must use sigreturn
>   and therefore still masks SIGUSR1 while the handler runs.
>   In skas, userspace shouldn't receive SIGIO or SIGWINCH (I hope
>   I'm right here?), SIGVTALRM already is handled by wait_stub_done.
>   Then I changed i386's stub_segv_handler to stop using "int3"
>   immediately after saving faultinfo.
>   This new method saves some syscalls on i386 and s390 and
>   simplifies s390.

				Jeff


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
