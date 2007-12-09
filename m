Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J1TEN-00016B-Mz for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Dec 2007 12:58:31 -0800
Received: from jade.aracnet.com ([216.99.193.136])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J1TEM-0004kI-DB
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Dec 2007 12:58:31 -0800
Message-ID: <475C56F9.8040902@BitWagon.com>
Date: Sun, 09 Dec 2007 12:58:33 -0800
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
References: <475B6E19.6040200@BitWagon.com>
	<20071209151054.GA4368@c2.user-mode-linux.org>
In-Reply-To: <20071209151054.GA4368@c2.user-mode-linux.org>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Jeff Dike wrote:
> On Sat, Dec 08, 2007 at 08:24:57PM -0800, John Reiser wrote:

>>I see no os_clone(), yet the glibc clone() does the same caching of pid in
>>ThreadLocalStorage [TLS], and the TLS still may be shared.  If nobody reads
>>glibc's shared TLS slot for PID then an actual bug will be avoided.  However,
>>it is unsafe to leave such a tempting pitfall.
> 
> 
> What's the actual bug, exactly?  As long as libc's getpid gives us the
> right answer, we're happy.

The actual bug is unnecessary complexity, which slows down development.
[And glibc's getpid still may give the wrong answer.  glibc caching getpid()
requires that glibc is the only implementor of fork or clone.
(Obviously uml and/or valgrind *could* violate this assumption.)
glibc getpid() may give the wrong answer when non-glibc code does a fork() or
clone().  glibc-2.6+ getpid() also gives the wrong answer when called
from a signal handler, if the signal is delivered immediately after the
__NR_clone but before glibc updates its cache %gs:PID.  (glibc should poison
its cache before doing the __NR_clone syscall.  Yeah, it's a bug in glibc.
Section 2.4.3 of the Single UNIX Specification requires that getpid() be
async-signal-safe, which means that getpid() may be called from a signal
handler.)  A virtualizer, such as valgrind, is *likely* to trigger this race.]

The "normal" code within UML is not the only player who wants the right answer
from getpid().  Temporary debugging code also wants the right answer.  That's
still "internal" to UML, so the "BEWARE!" might excuse the fact that "getpid()"
gives the wrong answer.  But there is also valgrind in the same new process,
and "getpid()" giving the wrong answer is less excusable.  It "shouldn't happen",
but the number of different getpid() is growing, and remembering which one(s)
are unreliable (and why), and ensuring that you aren't using one of them,
becomes difficult.

> 
> 
>>Also, if you are ptrace()ing
>>through a glibc clone(), then in many cases you will see syscall(__NR_getpid)
>>*from glibc* immediately following!  There is an "extra" getpid()
>>that the tracking logic might not expect.
> 
> 
> Where do we care about how clone translates into a system call?

check_sysemu() in arch/um/os/start_up.c cares that the actual sequence of
system calls is:
	__NR_clone
	__NR_getpid  presumably from ptrace_child() calling os_getpid()
However, when using the clone() from glibc then the actual sequence is:
	__NR_clone
	[random system calls from glibc]
	__NR_getpid  from ptrace_child calling os_getpid()
Now it "accidentally" happens that "random system calls from glibc"
is at most one syscall, and if present it is '__NR_getpid', which is the
same syscall as the presumed os_getpid() from ptrace_child().  That's
a "lucky" break.

> 
> 
>>   arch/um/drivers/ubd_user.c
>>   arch/um/kernel/tt/tracer.c
>>   arch/um/os/tt.c
>>   arch/um/os/start_up.c
>>   arch/um/os/skas/process.c
> 
> 
> These guys all just want a new process - they don't care how it
> happens.

Not so.  userspace() in arch/um/os/skas/process.c relies on
stack location and signal delivery that is mediated by the combination
of clone() and ptrace().  userspace() also depends on the carry-over
of signal handlers, particularly the SIGSEGV ==> SIGUSR1 trampoline.
"Just a new process" isn't good enough.

> Is something in here causing valgrind some trouble?

Yes.  It is not simple for the current valgrind to "let go" of
a new child.  [The current valgrind knows how to "let go" only at
execve().]  The internal logic of valgrind requires that the creation
of the new process [implemented by clone(,, ~CLONE_VM & ( ),,)] must be done
with all signals blocked.  Therefore the child side must do a
sigprocmask() somewhere to unblock, and the uml ptrace()ing is not
expecting this.  I'm working on it, and moving ahead, but
progress is slow.

-- 
John Reiser, jreiser@BitWagon.com

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
