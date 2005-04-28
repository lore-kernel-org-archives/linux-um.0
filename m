Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRAwV-0008Ou-Mv for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 08:28:43 -0700
Received: from mtagate4.de.ibm.com ([195.212.29.153])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DRAwT-0001TV-LZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 08:28:43 -0700
Received: from d12nrmr1707.megacenter.de.ibm.com
	(d12nrmr1707.megacenter.de.ibm.com [9.149.167.81])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id j3SFSWWM144868
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 28 Apr 2005 15:28:32 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1707.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j3SFSWRm265518 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 28 Apr 2005 17:28:32 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	j3SFSV5l024518 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 28 Apr 2005 17:28:31 +0200
In-Reply-To: <4270E813.50706@fujitsu-siemens.com>
Reply-To: 
Message-ID: <OF39B8E361.04396517-ONC1256FF1.004C000E-C1256FF1.0054E609@de.ibm.com>
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
Date: Thu, 28 Apr 2005 17:27:19 +0200
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

Bodo Stroesser <bstroesser@fujitsu-siemens.com> wrote on 04/28/2005
03:41:39 PM:

> Martin Schwidefsky wrote:
> > So (!entryexit & regs->gprs[2] < 0) translates to the debugger changed
the guest
> > system call to something illegal on the first of the two ptrace calls.
So the
> > patch doesn't hurt for normal, non-ptraced operation but it might hurt
other
> > users of ptrace.
> I don't think, it hurts. If a debugger willingly sets the syscall number
> to -1, what would happen without the patch?
> The kernel will set the result -ENOSYS into grps[2]. So, even if trap
> still indicates a syscall and a signal is pending, no syscall restarting
> will be done.

Why should the kernel set the result to -ENOSYS? If the debugger
invalidated
the system call, entry.S will just skip the system call and gprs[2] will
keep
the value that the debugger put there. But if regs->traps still indicates a
system call and there is another signal pending do_signal will try to
restart
the system call. In case of sys_(rt_)return there is no system call anymore
because the debugger = UML took care of it. That's why UML wants to have
access to regs->traps.

> With the patch, a debugger would observe changed behavior of the kernel
> *only*, if it writes the syscall number to -1 on the first syscall
> interception and then writes the result to ERESTARTXXXXX on the second,
> while at the same time a signal is pending for the debugged process.

In theory the debugger may want to intercept specific system calls and
do magic things instead but still want to have the system call restarting
to intercept it again after the (guest) signal has been delivered. You
just don't know.

> I assumed, that non of the current users of ptrace exactly does this.
> If I'm wrong here, the patch *really* is bad.

At least strace and gdb won't do it.

> > Ok, I think I've understood the problem now. What you are basically
have is
> > a process running in a UML guest that happens to have -ERESTARTXXX in
grp2
> > when it gets interrupted. A signal is delivered and on return from that
signal
> > with sys_(rt_)sigreturn >another< signal might be pending and then
do_signal
> > gets confused because of -ERESTARTXXX in grp2.
> This other signal must be pending on the *host*, in UML, this might be
> SIGVTALRM.

Why on the host ?!? Now I'm really confused. I thought the problem is the
regs->trap value in the guest system, how can a signal pending in the host
have an effect on the guest?

> > For normal, non-uml operation
> > restore_sigregs resets regs->trap to -1 which avoids the confusion.
With UML
> > the host intercepts sys_rt_sigreturn and does whatever needs to be done
for
> > the guest >except< resetting regs->trap to -1. So the problem seems to
be
> > that you need a ptrace interface to do that. I don't think it is a good
idea
> > to kludge syscall_trace to reset regs->trap under some conditions.
> My idea was to enable the existing ptrace interface to do what UML
> needs, without changing it in a way observable to other users of ptrace.
> I expected my patch to exactly do that, but maybe I missed something.
> Any better idea is welcome.

The patch does a very specific thing that UML needs, hardcoded into the
ptrace
interface. Who knows what kind of things other user of ptrace might need?
I don't claim to know, and that is why I don't like to see this done in the
syscall_ptrace function. Perhaps via peekusr/pokeuser interface but then
trap should be a member of struct user.

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
