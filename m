Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DR8gr-0007Ke-8L for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 06:04:25 -0700
Received: from mtagate2.de.ibm.com ([195.212.29.151])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DR8gp-0001AV-C9
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 06:04:25 -0700
Received: from d12nrmr1707.megacenter.de.ibm.com
	(d12nrmr1707.megacenter.de.ibm.com [9.149.167.81])
	by mtagate2.de.ibm.com (8.12.10/8.12.10) with ESMTP id j3SD4F5a148366
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 28 Apr 2005 13:04:15 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1707.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j3SD4FRm281288 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 28 Apr 2005 15:04:15 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	j3SD4E6b020636 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 28 Apr 2005 15:04:14 +0200
In-Reply-To: <4270B2C9.2030603@fujitsu-siemens.com>
Reply-To: 
Message-ID: <OF7DA21BA7.6A0D6C67-ONC1256FF1.003C86C5-C1256FF1.0047B648@de.ibm.com>
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
Date: Thu, 28 Apr 2005 15:03:17 +0200
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

Bodo Stroesser <bstroesser@fujitsu-siemens.com> wrote on 04/28/2005
11:54:17 AM:

> > This patch is not good. !entryexit indicates that you want to change
the trap
> > indication on the first of the two calls of syscall_trace for a system
call. The
> > second condition is gprs[2] < 0 but that can be true for a normal
system call as
> > well, like sys_exit(-1).
> Sorry, that's not right. At that point, gprs[2] holds the syscall number,
while the
> first argument of the syscall is in origgpr2. If the debugger sets the
syscall number
> to -1, which is an invalid syscall, changing trap to -1 will result in a
changed
> behavior only in case, that the debugger on the second syscall
interception also sets
> the syscall result to ERESTARTXXXXX (This again is modifying gprs[2]).
ERESTARTXXXXX
> normally would/could be handled by do_signal(), but with the patch it no
longer will.
> So, I think the patch doesn't hurt in normal cases, but does the trick
for UML.

Yes, your are right. gprs[2] holds the syscall number for the debugger to
change.
So (!entryexit & regs->gprs[2] < 0) translates to the debugger changed the
guest
system call to something illegal on the first of the two ptrace calls. So
the
patch doesn't hurt for normal, non-ptraced operation but it might hurt
other
users of ptrace.

> > Independent from that it do not understand why you need it at all. If
the
> > uml host intercepted and invalidated the guest system call the system
restart
> > indication bit _TIF_RESTART_SVC shouldn't be set because the guest
didn't
> > execute a system call.
> Let my explain a bit more. UML invalidates UML-user's syscalls on the
host, processes
> the syscall itself and inserts the result into gprs[2] on the second
syscall
> interception. For nearly all syscalls ERESTARTXXXXX is a result not
returned to user,
> but handled in UML kernel internally. But that's not true for
sys_(rt_)sigreturn.
> The "result" of those is the original contents of gpr2 of the interrupted
routine,
> which accidentally also might be ERESTARTXXXXXXX (BTW, that's the reason
for
> sys_(rt_)sigreturn setting trap to -1 also). We skip UML's syscall
restart handling
> in this case, but we need to skip it in the host, too.

Ok, I think I've understood the problem now. What you are basically have is
a process running in a UML guest that happens to have -ERESTARTXXX in grp2
when it gets interrupted. A signal is delivered and on return from that
signal
with sys_(rt_)sigreturn >another< signal might be pending and then
do_signal
gets confused because of -ERESTARTXXX in grp2. For normal, non-uml
operation
restore_sigregs resets regs->trap to -1 which avoids the confusion. With
UML
the host intercepts sys_rt_sigreturn and does whatever needs to be done for
the guest >except< resetting regs->trap to -1. So the problem seems to be
that you need a ptrace interface to do that. I don't think it is a good
idea
to kludge syscall_trace to reset regs->trap under some conditions.

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
