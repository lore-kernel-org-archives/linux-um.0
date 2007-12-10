Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J1m8O-0001U6-SU for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Dec 2007 09:09:37 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J1m8J-00022R-Mr
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Dec 2007 09:09:34 -0800
Date: Mon, 10 Dec 2007 12:09:25 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071210170925.GA7582@c2.user-mode-linux.org>
References: <475B6E19.6040200@BitWagon.com>
	<20071209151054.GA4368@c2.user-mode-linux.org>
	<475C56F9.8040902@BitWagon.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <475C56F9.8040902@BitWagon.com>
Subject: Re: [uml-devel] should there be os_clone() analogous to os_getpid() ?
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

On Sun, Dec 09, 2007 at 12:58:33PM -0800, John Reiser wrote:
> The actual bug is unnecessary complexity, which slows down development.

We live in an imperfect world.  I'd like to be able to call getpid and
know that I'm always going to get the right answer.  However, I don't
want to have to debug the cases where it doesn't, so the current code
seems like the best arrangement.

> > Where do we care about how clone translates into a system call?
> 
> check_sysemu() in arch/um/os/start_up.c cares that the actual sequence of
> system calls is:
> 	__NR_clone
> 	__NR_getpid  presumably from ptrace_child() calling os_getpid()
> However, when using the clone() from glibc then the actual sequence is:
> 	__NR_clone
> 	[random system calls from glibc]
> 	__NR_getpid  from ptrace_child calling os_getpid()

No, it doesn't.  The only thing is cares about is that the system call
following the kill(pid, SIGSTOP) in ptrace_child is a getpid.  It
cares not at all about the details of the clone.

> > These guys all just want a new process - they don't care how it
> > happens.
> 
> Not so.  userspace() in arch/um/os/skas/process.c relies on
> stack location and signal delivery that is mediated by the combination
> of clone() and ptrace().  userspace() also depends on the carry-over
> of signal handlers, particularly the SIGSEGV ==> SIGUSR1 trampoline.

No, it doesn't.  userspace_tramp sets up its own handlers after the
clone - it doesn't rely on inheriting them, and in fact it can't,
since the stub's SEGV handler makes no sense in the UML kernel.  It
may inherit a signal mask, but as far as I'm concerned, that's a bug.
As far as a stack location goes, that's part of the interface, so
that's just part of creating a new process.

> > Is something in here causing valgrind some trouble?
> 
> Yes.  It is not simple for the current valgrind to "let go" of
> a new child.  [The current valgrind knows how to "let go" only at
> execve().]  The internal logic of valgrind requires that the creation
> of the new process [implemented by clone(,, ~CLONE_VM & ( ),,)] must be done
> with all signals blocked.  Therefore the child side must do a
> sigprocmask() somewhere to unblock, and the uml ptrace()ing is not
> expecting this.

I don't see how this can be causing problems.  If the child side of
valgrind makes some extra system calls before allowing the child to
run, I don't see UML caring about that at all.

Any system call tracing is done only after seeing the child hit itself
with a signal.  Any extra system calls in libc's clone or the child
side valgrind are long over by this point.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
