Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwuPv-00016r-8L for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Feb 2004 18:41:27 -0800
Received: from externalmx.valinux.com ([198.186.202.147]
	helo=externalmx.vasoftware.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Awu0U-0000im-UN for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Feb 2004 18:15:10 -0800
Received: from mail.tor.primus.ca ([216.254.136.21]:45531 helo=notus.primus.ca)
	by externalmx.vasoftware.com with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 4.24 #1 (Debian))
	id 1AwuEq-0004OF-EK
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 27 Feb 2004 18:30:00 -0800
Message-ID: <403FFCED.7060201@users.sourceforge.net>
From: Kuas <ku4s@users.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] System Call Mechanism
References: <40352B06.3030406@users.sourceforge.net>
	<200402251652.52680.blaisorblade_spam@yahoo.it>
In-Reply-To: <200402251652.52680.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Fri, 27 Feb 2004 21:29:01 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>

Hi Blaisor,

Thanks for the response and info. I am still confused in how the system 
call arrive at process.c->userspace(). I guess the proposal in the 
presentation 
(http://user-mode-linux.sourceforge.net/slides/ols2002/img21.html), it 
said the next implementation would be to convert trap call to signal has 
never been implemented.

I checked in SKAS and TT mode, the idtr value is the same as the host 
machine and I can see from where you pointed, SKAS and TT has the same 
trap handler for system_call. But I don't really understand ptrace 
control, I am not totally sure how the system call is being intercepted 
and sent back to uml ends up in process.c->userspace(). Does every time 
interrupt is called, it will be caught by the host kernel ptrace and for 
system call (int 0x80) will be redirected back to the UML process. How 
does the information about the process that's requesting system call, 
syscall#, and arguments being passed to the UML Kernel. I understand 
since SKAS mode has collection of Virtual Address Spaces. Correct me if 
I'm wrong, will PTRACE_SWITCH_MM first change to the UML kernel process 
Address Space. But in SKAS mode, the UML kernel is also in the host 
address space (>0xc0000000), during this state we are already in the 
kernel space. So which child memory that PTRACE_SWITCH_MM switches when 
the system call? I am assuming the active Virtual Memory that's being 
replaced in UML process is the current uml process that generate the 
system call.


Kuas


BlaisorBlade wrote:

>>I seems to me the new or current implementation of system call involves
>>conversion from interupt 80 at the host OS into signals back in UML
>>kernel. Is this the same mechanism for the current TT and SKAS? Or  TT
>>mode still using ptrace thread tracing mechanism to intercept the system
>>call?
>>    
>>
>
>SKAS mode, the more modern one, still uses the same interception mechanism as 
>TT: i.e. ptraces the child, intercepts the syscall, nullifies it (i.e. the 
>host kernel receives a getpid syscall) and goes on. Look at these files:
>
>arch/um/kernel/skas/process.c: handle_trap () and userspace().
>arch/um/kernel/skas/syscall_*.c
>
>Only difference is that in SKAS mode you have one single child process being 
>ptraced, on the host; it runs the virtual processes code, and does syscall 
>with int 0x80 which are intercepted. To do a context switch, UML uses setjmp 
>and longjmp to switch the stack state and PTRACE_SWITCH_MM (implemented on 
>the host inside arch/i386/kernel/ptrace.c, read the skas patch) to switch the 
>virtual mappings of the child at once. More details about memory handling at 
>request, since you asked for one exact thing and maybe are not interested in 
>this.
>
>  
>




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
