Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRUuU-0007Im-9C	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Apr 2005 05:47:58 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DRUuS-0002Pp-D9	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Apr 2005 05:47:58 -0700
Message-ID: <42722CF7.4000005@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <OFC64AA10F.5C318C60-ONC1256FF2.003E8736-C1256FF2.0040BFA0@de.ibm.com>
In-Reply-To: <OFC64AA10F.5C318C60-ONC1256FF2.003E8736-C1256FF2.0040BFA0@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Fri, 29 Apr 2005 14:47:51 +0200
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

Martin Schwidefsky wrote:
> Yes, it is not a really good idea to add something to struct user. That will
> affect the dump format and debugging tools. So it would be an additional ptrace
> command like PTRACE_SETTRAP/PTRACE_GETTRAP. The only other solution I can think
> of is to be more specific about what the debugger can indicate to the debuggee
> what needs to be done after the first syscall_trace invocation. At the moment
> it is either
> 1) a valid system call number, execute the new syscall, or
> 2) an invalid system call number, skip the system call but don't change
>    regs->traps and do system call restarting if another signal is pending
> If we use more specific error codes instead of just any invalid syscall number
> we could have e.g. this:
> 1) a vaild system call number, execute the new syscall,
> 2) -Exxx, skip the system call, store -1 to regs->trap and then continue
>    with restarting system calls if another system call is pending.
Typo with<->without?

Yes. That's what I suggested as a "special magic number". Only if that magic
is written as syscall number at the first interception, syscall_trace() would
modify regs->trap to -1.
Currently my patch uses -1 as the magic number, but there might be better
choices.

> 3) -Eyyy, skip the system call but leave regs->trap intact so that a pending
>    signal will restart the system call.
Not only -Eyyy, but all values unequal to "special magic number" could leave
regs->trap intact.

> 
> But we really have to be very careful not to break either strace or gdb if
> we do this change. Probably it is much easier to introduce PTRACE_SET/GET_TRAP.
It's easier for s390-kernel, but from UML's point of view, the magic number
solution would be better.
Anyway, if you decide not to allow the magic number, we have to find a way
to use PTRACE_SETTRAP in UML without having to call it too often (Performance).
Because of UML's splitting in kernel-obj and user-obj, this might be a bit
tricky.

BTW: I see no reason to implement PTRACE_GETTRAP, as
PTRACE_SETOPTIONS/PTRACE_TRACESYSGOOD give us a way to distinguish between
syscall interceptions and other SIGTRAPs.

Regards, Bodo


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
