Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <renzo@cs.unibo.it>) id 1SyQi6-0005xj-Fv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Aug 2012 17:03:18 +0000
Received: from leb.cs.unibo.it ([130.136.1.102])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SyQi4-0001eU-5L
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Aug 2012 17:03:18 +0000
Date: Mon, 6 Aug 2012 19:03:10 +0200
From: Renzo Davoli <renzo@cs.unibo.it>
Message-ID: <20120806170309.GD25078@cs.unibo.it>
References: <20120806153728.GC25078@cs.unibo.it> <501FEB4A.3060909@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <501FEB4A.3060909@nod.at>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [patch] 3.6rc1 tracehook
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Aug 06, 2012 at 06:05:30PM +0200, Richard Weinberger wrote:
> Hmm, is it a good idea to call syscall_trace_leave() in any case?
> E.g. if syscall_trace_enter() fails for whatever reason...

I have replicated the behavior of other architectures.
For example in x86/32 a.k.a. i386:
arch/x86/kernel/entry_32.S:

 489 ENTRY(system_call)
 490   RING0_INT_FRAME     # can't unwind into user space anyway
 491   pushl_cfi %eax      # save orig_eax
 492   SAVE_ALL
 493   GET_THREAD_INFO(%ebp)
 494           # system call tracing in operation / emulation
 495   testl $_TIF_WORK_SYSCALL_ENTRY,TI_flags(%ebp)
 496   jnz syscall_trace_entry
 497   cmpl $(NR_syscalls), %eax
 498   jae syscall_badsys
 499 syscall_call:
 500   call *sys_call_table(,%eax,4)
 501   movl %eax,PT_EAX(%esp)    # store the return value
 502 syscall_exit:
 503   LOCKDEP_SYS_EXIT
 504   DISABLE_INTERRUPTS(CLBR_ANY)  # make sure we don't miss an interrupt
 505           # setting need_resched or sigpending
 506           # between sampling and the iret
 507   TRACE_IRQS_OFF
 508   movl TI_flags(%ebp), %ecx
 509   testl $_TIF_ALLWORK_MASK, %ecx  # current->work
 510   jne syscall_exit_work
....
 647 syscall_trace_entry:
 648   movl $-ENOSYS,PT_EAX(%esp)
 649   movl %esp, %eax
 650   call syscall_trace_enter
 651   /* What it returned is what we'll actually use.  */
 652   cmpl $(NR_syscalls), %eax
 653   jnae syscall_call
 654   jmp syscall_exit
 655 END(syscall_trace_entry)
....
 659 syscall_exit_work:
 660   testl $_TIF_WORK_SYSCALL_EXIT, %ecx
 661   jz work_pending
 662   TRACE_IRQS_ON
 663   ENABLE_INTERRUPTS(CLBR_ANY) # could let syscall_trace_leave() call
 664           # schedule() instead
 665   movl %esp, %eax
 666   call syscall_trace_leave
 667   jmp resume_userspace

as you can see:
if the process is traced line 496 jumps to syscall_trace_entry:
if syscall_trace_entry returns nonzero (line 652-654) jumps to syscall_exit (skipping the 
system call) otherwise returns to syscall_call.
whatever is the return value of syscall_trace_enter, if the process is traced 
(line 510: it jumps to syscall_exit_work) and then it will call syscall_trace_leave.

So I think we must replicate the same beavior for user-mode linux, too.

	renzo

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

