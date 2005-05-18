Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYQ0K-0001Um-S8	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 07:58:36 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DYQ0H-0004jL-H6	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 07:58:36 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Explaination of system call function flow in TT mode
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
	<428B0F2B.3060503@fujitsu-siemens.com>
	<3524bf1f050518062432e093d6@mail.gmail.com>
In-Reply-To: <3524bf1f050518062432e093d6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505181657.49102.blaisorblade@yahoo.it>
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
Date: Wed, 18 May 2005 16:57:47 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Wednesday 18 May 2005 15:24, Young Koh wrote:
> > > Yeah, this is reasonable.  You have to be careful that you save and
> > > restore any registers that might be used by one of the stubs, but they
> > > don't use FP.
> >
> > I also thought about not saving FP-regs on each kernel entry. But if you
> > do this optimization, you need to save / restore FP-regs on switch_to.
> > Also you need to get the FP-regs when setting up a signal-handler
> > stackframe. And they have to be restored on sys_(rt_)sigreturn from the
> > values found in the stackframe.
>
> Thanks for the replies. let me understand them. In a SKAS mode UML
> kernel, the pseudo code of a system call invocation would be like the
> following.
>
> wait4(); // wait until a user process raises a syscall
> save_registers(); // copy the user process' registers to UML kernel space
> execute_syscall(); // execute the syscall in UML kernel context
> restore_registers(); // copy the user registers back to the user process
>
> but, during execute_syscall(), even if its stubs use all the registers
> and/or it happens to invoke switch_to(), it will happen all in the UML
> kernel's context. that means the user process's context will be
> protected by host kernel's context switching mechanism. doesn't it?
> because the host kernel will automatically save/restore a process'
> registers when the process is stopped and resumed, all we care about
> in the above routine should be to get system call parameters from the
> tracee and save the return value to it. shouldn't it? (again, only for
> SKAS)

Wait a moment, we have two cases:

1) For the syscall execution, everything should be ok (apart the case the 
syscall code needs to explicitly access the guest's registers).

2) switch_to is used for process context switching, so is a different thing 
from syscall execution. It's called by schedule() (which is called, mainly, 
both by syscalls which do explicitly scheduling and by the timer tick; there 
are also some additional cases when using preemption, but UML does not use 
them; look for cond_resched() and similar things in kernel sources).

In this case, instead, for SKAS mode, we must switch the registers manually, 
since we have collapsed everything in one host process. For TT and SKAS0 
mode, instead, it's not needed, right Jeff and Bodo?
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
