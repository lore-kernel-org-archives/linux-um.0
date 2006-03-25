Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMzHO-0004fg-RW for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 19:17:30 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMzHM-0001Ms-Cj
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 19:17:30 -0800
Received: from ccure.user-mode-linux.org (littleton.addtoit.com
	[198.99.130.129])
	by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id k2P3HQ4O016583
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 24 Mar 2006 22:17:27 -0500
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.13.6/8.13.4) with ESMTP id
	k2P3IjeR008555 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 24 Mar 2006 22:18:46 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060325031838.GA8539@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Re: Why uml-add-tls-support-debug-check-never-works is
	needed
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
Date: Fri, 24 Mar 2006 22:18:38 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Mar 25, 2006 at 12:28:09AM +0100, Blaisorblade wrote:
> BUT, this context switch at the thread born is special: the thread being 
> switched away switches to a new thread not in the body of the new thread's 
> call to switch_to_skas->switch_threads(), but in the body of thread_wait()! 
> At that point, we lose the call to arch_switch_to_skas()!

Yuck yuck yuck.  Nice spotting.

There's an obvious one-line fix for this, but I wonder if we ought to
try some restructuring to avoid this sort of thing in the future.

> Questions and notes:
> 
> *) Why does arch/um/os-Linux/skas/process.c has still one siglongjmp() call 
> and sigjmp_buf vars, and that has no comments?

I'm tempted to say that I just missed the call somehow.  I see no
reason for that to be different, especially since it's preceded by a
UML_SIGSETJMP.  As for the sigjmp_buf variables, I don't get your
point.  Those haven't changed.

> *) Also, why thread_wait and thread_switch are almost identical, yet they're 
> two different functions?

switch_threads?  In order to merge them, you'd have to pass in the 1
and the INIT_JMP_REMOVE_SIGSTACK, which I have conceptual problems
with.  First, that makes the callers know things that they probably
shouldn't.  Second, the 1 and the INIT_JMP_REMOVE_SIGSTACK have
completely different meanings.  One is a message to the initial thread
that it has to do something.  The 1 is a message to setjmp that is has
been longjmp-ed to.

> *) Btw, the naming sucks - if I find better names for new_thread, 
> new_thread_proc and such, would they be accepted?

Sure, good names are always appreciated.

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
