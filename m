Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRE67-0003uo-LT	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 11:50:51 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DRE63-0008H6-KM	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 11:50:51 -0700
Message-ID: <42713084.7070403@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <OF39B8E361.04396517-ONC1256FF1.004C000E-C1256FF1.0054E609@de.ibm.com>
In-Reply-To: <OF39B8E361.04396517-ONC1256FF1.004C000E-C1256FF1.0054E609@de.ibm.com>
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
Date: Thu, 28 Apr 2005 20:50:44 +0200
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

Martin Schwidefsky wrote:
> Bodo Stroesser <bstroesser@fujitsu-siemens.com> wrote on 04/28/2005
> 03:41:39 PM:
> 
> 
>>I don't think, it hurts. If a debugger willingly sets the syscall number
>>to -1, what would happen without the patch?
>>The kernel will set the result -ENOSYS into grps[2]. So, even if trap
>>still indicates a syscall and a signal is pending, no syscall restarting
>>will be done.
> 
> 
> Why should the kernel set the result to -ENOSYS? If the debugger
> invalidated
> the system call, entry.S will just skip the system call and gprs[2] will
> keep
> the value that the debugger put there.
You are right. I mixed it with i386, that has a separate field for the
result, which is preloaded with -ENOSYS. On s390, the -1 written as the
syscall number leads to entry.S calling nothing. If a signal is pending,
do_signal() will interprete gprs[2] as syscall's result. Since -1 is
-EPERM, no syscall restarting will be done, regardless the value of trap.

The debugger would have to write gprs[2] with -1 on the first syscall
interception *and* with ERESTARTXXXXX at the second syscall interception
to see any changed behavior.

> But if regs->traps still indicates a
> system call and there is another signal pending do_signal will try to
> restart
> the system call. In case of sys_(rt_)return there is no system call anymore
> because the debugger = UML took care of it. That's why UML wants to have
> access to regs->traps.
Yeah.

>>>A signal is delivered and on return from that
>>>signal 
>>>with sys_(rt_)sigreturn >another< signal might be pending and then
>>>do_signal 
>>>gets confused because of -ERESTARTXXX in grp2.
>>
>>This other signal must be pending on the *host*, in UML, this might be
>>SIGVTALRM.
> 
> 
> Why on the host ?!? Now I'm really confused. I thought the problem is the
> regs->trap value in the guest system, how can a signal pending in the host
> have an effect on the guest?
I think, your confusion results from the unclear terminology.
UML is a full Linux, running as some user-space processes on the host.
So, there can be signals pending in UML for the processes running in
UML, but the host won't even know about that.
On the other hand, there can be signals pending "in the host" for the
user-space processes running on the host, that make up the UML.
For example, UML intensely uses SIG(VT)ALRM as the analogue to host's
timer interrupt. UML users never will "see" these signals.
To make occur the problem, that results from host's unwanted syscall
restarting, some condition must be met:

1) A process running in UML and having ERESTARTXXXXX in its GPR2 must be
    interrupted by a signal. As GPR2 never is ERESTARTXXXXX at the end of
    a "normal" syscall, this can happen only if a "interrupt" to UML
    (SIGVTALRM, SIGIO from the host to UML) hits this situation.

2) If interrupt processing in UML results in sending a signal in UML
    to the interrupted process (e.g. alarm timeout triggered) or if
    a signal already is pending in UML, UML starts the handler for the
    signal in the interrupted process.

3) The sighandler returns by calling sys_(rt_)sigreturn.

4) The ptracing process of UML intercepts that syscall and invalidates it.
    Then it does one further PTRACE_SYSCALL and waits, until the child
    reaches the second syscall interception.

5) UML runs its own sys_(rt_)sigreturn for the process, skips its own
    syscall restart processing and writes the registers of the child with
    the values, that result from sys_(rt_)sigreturn processing. Now GPR2
    is loaded with ERESTARTXXXXXX again.

6) The child is resumed with PTRACE_SYSCALL. If a further signal is
    pending in the host for that child, the host runs do_signal().
    As regs->trap still is set for a syscall, syscall restarting is
    processed in the host, the process in UML will fail.

Obviously, this is a rare case. On i386, the syscall number is used as
trap, so -1 can be written to it at the second interception to skip
syscall restarting. Some months ago, UML/i386 did not yet use this, so
I wrote a litte program, that made the problem happen.

> 
> The patch does a very specific thing that UML needs, hardcoded into the
> ptrace
> interface. Who knows what kind of things other user of ptrace might need?
I don't *know* this, too. But I still believe, that no current user of
ptrace will see the difference, as very specific ptrace operations have
to be done to trigger the change.
If there really would be no user of ptrace doing things conflicting with
the patch yet, there would be no reason to not insert the patch. AFAICS,
the patch doesn't make any useful operation impossible. So future conflicts
can be avoided by future users of ptrace. Additionally, the -1 could be
replaced by -ENOSYS or even a special magic number.

> I don't claim to know, and that is why I don't like to see this done in the
> syscall_ptrace function. Perhaps via peekusr/pokeuser interface but then
> trap should be a member of struct user.
As trap could be added to struct user at the end of struct user only, this
would result in an additional ptrace call in UML :-(

Is it safe to increase size of struct user? What about software being
recompiled partly (e.g. using a private lib which isn't recompiled; or the
lib is recompiled, while the program isn't).
So maybe an additional ptrace operation (PTRACE_SETTRAP?) would be better,
but still we would need one more syscall in UML.

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
