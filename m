Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKuS0-0000gJ-3O for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 01:07:04 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CKuRy-0004n5-7M for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 01:07:03 -0700
Message-ID: <4178C0FB.4070108@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <4177D503.2030409@fujitsu-siemens.com>
	<200410212209.i9LM92FL005362@ccure.user-mode-linux.org>
In-Reply-To: <200410212209.i9LM92FL005362@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Bad handling of invalif systemcalls
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
Date: Fri, 22 Oct 2004 10:12:43 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> bstroesser@fujitsu-siemens.com said:
> 
>>AFAICS, the only solution for this is using the PTRACE_O_TRACESYSGOOD
>>option. This option seems to be specific for linux, but the problem
>>maybe is specific for linux, too. 
> 
> 
> Another solution is to read the instruction.
It's a bit tricky to do this, if the vsyscall-page is in use. Then you also
have to know the address of the return-point for "sysenter", which the
kernel uses.
Also, the tracer thread at the moment has no access to the code of the process!
I tapped into this trap while trying to simplify the singlestepping even more by
moving the opcode-check from kernel_do_signal() to is_syscall().
So I reverted the change ...

> 
> However TRACESYSGOOD is cleaner.  My only concern is whether that limits the
> hosts that UML will run on.  If TRACESYSGOOD has been around for the 2.4
> series, then that's OK.
2.4 supports it, at least in the newer versions. I looked for it before patching.

> 
> I would be tempted to #define SIGSYSCALL (SIGTRAP + 0x80) or something just
> to make the +0x80 bit less magic-looking.
Yes. I used the 0x80, because I didn't find a definition for this in the
header files from /usr/include. So, if the host linux doesn't use a
     #define THIS_IS_A_SYSCALL_INTERCEPTION 0x80
I decided not to do it also. But feel free to change this.

> 
> 
>>For the third patch I'm quite anxious, that there could go something
>>wrong when using the debugger. I don't understand much about this.
>>Maybe someone else could look into this? 
> 
> 
>  				if(!tracing && (debugger_pid != -1)){
>  					child_signal(pid, status);
>  					continue;
>  				}
>  				tracing = 0;
> 				if(do_syscall(task, pid))
> 					sig = SIGUSR2;
> 
> OK, what this says is
> 	if we are running in the kernel, not userspace (!tracing)
> 	and we are debugging UML (debugger_pid != -1)
> 	then we fake the syscall-traced gdb into thinking the SIGTRAP was sent
> 	to the process
> 
> 	Otherwise we call do_syscall, which will check the syscall number 
> 	and return true if it thinks it's handling a syscall.  In that case,
> 	we hit the process with SUGUSR2 in order to force it into the UML
> 	syscall handler.
> 
> So, if we get SIGTRAP + 0x80, we know we have a syscall, and the debugging
> stuff can just go away.  You can look at this sort of mathematically, and
> say SIGTRAP + 0x80 => tracing, so that if(!tracing...) can just be deleted.
No. The processes in UML-TT, no matter if they run in userspace or execute the
kernel, always are ptraced processes and PTRACE_O_TRACESSYSGOOD now will be
set permanently. So, if the debugger does an syscall-trace, it will expect an
SIGTRAP, but what happens is an (SIGTRAP|0x80). Since I didn't want to change
the debugger, I masked the 0x80.
For breakpoints or singlestep-traps, the signal still will be SIGTRAP only.

Maybe it would make sense, to change the debugger-code. It could accept
(SIGTRAP|0x80) and give it to the real debugger as SIGTRAP normally. Also, it
could accept a ptrace(PTRACE_SETOTIONS,,,PTRACE_O_TRACESYSGOOD) and after this
it could relay the (SIGTRAP|0x80) without change.

> 
> Similarly, do_syscall will always return true, so you don't need to check its
> return, which you have removed.
> 
> In the SIGTRAP case, you might as well inline do_sigtrap.  One line functions
> are pretty much a waste.  In any case, I don't understand why you're doing
> that.  orig_eax should already be -1.
Yes. Inlining is a good idea.
You are right, orig_eax on the processes stack is -1. But this *has* to be saved
in the tt-regs structure for later use. What I'm doing is the same that
     UPT_SYSCALL_NR(TASK_REGS(task)) = PT_SYSCALL_NR(proc_regs);
does in the case of a systemcall. I used "-1" instead of "PT_SYSCALL_NR(proc_regs)"
because it *is* the same in this situation.
> 	
> 				Jeff
> 



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
