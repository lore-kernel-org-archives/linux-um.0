Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRTz9-00040M-JF	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Apr 2005 04:48:43 -0700
Received: from mtagate2.de.ibm.com ([195.212.29.151])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DRTz7-0003HF-Ix
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Apr 2005 04:48:43 -0700
Received: from d12nrmr1707.megacenter.de.ibm.com
	(d12nrmr1707.megacenter.de.ibm.com [9.149.167.81])
	by mtagate2.de.ibm.com (8.12.10/8.12.10) with ESMTP id j3TBmR5a108644
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 29 Apr 2005 11:48:27 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])id j3TBmRk4264882
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 29 Apr 2005 13:48:27 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	j3TBmQxN027380	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 29 Apr 2005 13:48:27 +0200
In-Reply-To: <42713084.7070403@fujitsu-siemens.com>
Message-ID: <OFC64AA10F.5C318C60-ONC1256FF2.003E8736-C1256FF2.0040BFA0@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: [uml-devel] Re: Again: UML on s390 (31Bit)
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
Date: Fri, 29 Apr 2005 13:47:13 +0200
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

Bodo Stroesser <bstroesser@fujitsu-siemens.com> wrote on 04/28/2005
08:50:44 PM:

> 5) UML runs its own sys_(rt_)sigreturn for the process, skips its own
>     syscall restart processing and writes the registers of the child with
>     the values, that result from sys_(rt_)sigreturn processing. Now GPR2
>     is loaded with ERESTARTXXXXXX again.
>
> 6) The child is resumed with PTRACE_SYSCALL. If a further signal is
>     pending in the host for that child, the host runs do_signal().
>     As regs->trap still is set for a syscall, syscall restarting is
>     processed in the host, the process in UML will fail.

That is what I was after, the additional signal that causes the problem
is pending for the child, not for the ptrace father process.

> Obviously, this is a rare case. On i386, the syscall number is used as
> trap, so -1 can be written to it at the second interception to skip
> syscall restarting. Some months ago, UML/i386 did not yet use this, so
> I wrote a litte program, that made the problem happen.

The rare cases are always the most complicated ones. To make UML work
reliably this needs to get fixed.

> > I don't claim to know, and that is why I don't like to see this done in the
> > syscall_ptrace function. Perhaps via peekusr/pokeuser interface but then
> > trap should be a member of struct user.
> As trap could be added to struct user at the end of struct user only, this
> would result in an additional ptrace call in UML :-(
>
> Is it safe to increase size of struct user? What about software being
> recompiled partly (e.g. using a private lib which isn't recompiled; or the
> lib is recompiled, while the program isn't).
> So maybe an additional ptrace operation (PTRACE_SETTRAP?) would be better,
> but still we would need one more syscall in UML.

Yes, it is not a really good idea to add something to struct user. That will
affect the dump format and debugging tools. So it would be an additional ptrace
command like PTRACE_SETTRAP/PTRACE_GETTRAP. The only other solution I can think
of is to be more specific about what the debugger can indicate to the debuggee
what needs to be done after the first syscall_trace invocation. At the moment
it is either
1) a valid system call number, execute the new syscall, or
2) an invalid system call number, skip the system call but don't change
   regs->traps and do system call restarting if another signal is pending
If we use more specific error codes instead of just any invalid syscall number
we could have e.g. this:
1) a vaild system call number, execute the new syscall,
2) -Exxx, skip the system call, store -1 to regs->trap and then continue
   with restarting system calls if another system call is pending.
3) -Eyyy, skip the system call but leave regs->trap intact so that a pending
   signal will restart the system call.

But we really have to be very careful not to break either strace or gdb if
we do this change. Probably it is much easier to introduce PTRACE_SET/GET_TRAP.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
