Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3eTZ-0006Fx-39	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:41:53 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E3eTY-0006N2-G4
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:41:53 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Segmentation fault with kernel thread in UML-2.6.7 TT
	mode
References: <000901c58aa4$86288800$9eb3c68a@SHZ.ST.COM>
In-Reply-To: <000901c58aa4$86288800$9eb3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200508122038.10641.blaisorblade@yahoo.it>
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
Date: Fri, 12 Aug 2005 20:38:10 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alex LIU <alex.liu@st.com>

On Sunday 17 July 2005 09:52, Alex LIU wrote:
> On 16 July 2005, Blaisorblade wrote:
> > Hmm, but where's the caller to return? In most cases it won't exist. I
> > don't understand what's your purpose, and the behaviour you'd want to
> > reproduce. Sorry, but *which* userspace should it go to? What you're
> > modifying is the execution path of kernel_thread.

> The reason why Bproc create it's own bproc_kernel_thread function is below:
> ------------------------------------------------------
...
> -----------------------------------------------------
Ok, that is done on BPROC_MOVE, right?
> The Bproc's own kernel thread function(for i386) is below:
>
> ---------------------------------------------
> /*
>  * 1 - it does not force a CLONE_VM on you
>  * 2 - it simulates syscall entry on the child by setting
>  *     aside room for a struct pt_regs.  A pointer to this is
>  *     the first argument to the child.  This way, the child can
>  *     fill in the regs and "return" to user space if it wants to.
>  */
>
> /*
>  * This gets run with %ebx containing the
>  * function to call, and %edx containing
>  * the "args".
>  */
> void bproc_kernel_thread_helper(void);
> __asm__(
> ".align 4\n"
> "bproc_kernel_thread_helper:\n"
>
> /* Move our stack pointer so that we have a struct pt_regs on the
>  * stack and nothing else.
>  *
>  * 8132 = 8k (stack size) - 60 (struct pt_regs size)
>  */
> "    movl  %esp, %eax                            \n"
> "    andl $-"__stringify(THREAD_SIZE)",   %eax   \n"
> "    addl $"__stringify(THREAD_SIZE)"-60, %eax   \n"
> "    movl  %eax, %esp                            \n"
>
> "    pushl %edx             \n" /* arg2 = user pointer */
> "    pushl %eax             \n" /* arg1 = pointer to regs */
> "    call *%ebx             \n" /* call func */
> "    addl  $8, %esp         \n" /* pop args */
>
> "    movl  %esp, %ebx       \n" /* Store EAX to return to user space */
> "    movl  %eax, 0x18(%ebx) \n" /* Set EAX to return to process */
>
> /* syscall_exit requires thread_info pointer in ebp */
> "    movl  %esp, %ebp                            \n"
> "    andl $-"__stringify(THREAD_SIZE)", %ebp     \n"
> "    jmp syscall_exit                            \n"
Note here syscall_exit takes the place of ret_from_fork.
>
> /*
>  * Create a kernel thread
>  */
> int bproc_kernel_thread(int (*fn)(struct pt_regs *, void *),
>                         void * arg, unsigned long flags)
> {
>         struct pt_regs regs;
>
>         memset(&regs, 0, sizeof(regs));
>
>         regs.ebx = (unsigned long) fn;
>         regs.edx = (unsigned long) arg;
>         regs.ecx = flags;
>
>         regs.xds = __USER_DS;
>         regs.xes = __USER_DS;
>         regs.orig_eax = -1;
>         regs.eip = (unsigned long) bproc_kernel_thread_helper;
>         regs.xcs = __KERNEL_CS;
>         regs.eflags = 0x286;
You should also decode the reason for eflags being 0x286 - that seems a 
strange hack.
>         /* Ok, create the new process.. */
>         return do_fork(flags, 0, &regs, 0, NULL, NULL);
> }
> -------------------------------------------------

> I know in UML tt mode, process fork/clone and kernel thread are handled
> differently. In copy_thread_tt, I found process forking will call
> fork_tramp and finish_fork_handler while kernel thread will call
> new_thread_proc and new_thread_handler.

> In UML, I think the forked child process will also return to user space
> like in i386 ret_from_fork.
More or less... remember UML is like a debugger, since it's using ptrace, so 
you don't have kernel and userspace on the "same stack" directly. Actually, 
the kernel code for syscalls is run inside a signal handler (for SIGUSR2) in 
the traced process, so you end up with a similar situation. An important 
difference is that on i386 the kernel part of the stack is *identical*, you 
must only change the EAX register (which contains the return value). While on 
UML the kernel stack contents are completely different.

> So I used finish_fork_handler for reference and 
> modified new_thread_handler to create the bproc_new_thread_handler.

> My 
> purpose is that in bproc_new_thread_handler the new created kernel thread
> will return to the user space rather than exit.

> In UML,I found in finish_fork_handler, set_user_mode is called at last. I
> think it's purpose is to let the new forked process go to the user space
> like ret_from_fork in i386.
Yes and no, and no for your purpose, you should be careful. Look at the code 
in set_user_mode and at OP_TRACE_ON implementation in tracer() (and 
do_proc_op()). When the executed code is the userspace one, the tracing 
thread (which always runs tracer()) must nullify syscalls and handle them in 
UML, while on kernel code it must let them go, so tracer has two different 
operating modes, and chooses between them based on the value of the "tracing" 
variable. set_user_mode() causes it to change. Stop. So  it's not enough.

Then, the finish_fork_handler code (which is the SIGUSR1 handler) returns, and 
then the UML code (which is in SIGUSR2 handler, since it is syscall execution 
code) returns to the userspace stack. Since the userspace stack is identical 
for both threads, and only EAX differs, things work. But you don't have a 
userspace stack, unless you have already setup it!

Bproc probably marks the page as missing and handles the faults, and you could 
do the same.

I think that there's no problem for the kernel stack, it is a different one 
like on i386 (see the call to 
init_new_thread_stack->set_sigstack->...->sigaltstack()).


> So I add the set_user_mode in 
> bproc_new_thread_handler after run_kernel_thread to let the kernel thread
> also go to the user space.

> I Also create the sigcontext for the bproc 
> kernel thread like forking in copy_thread_tt.
It should be rather unlike the source, since the registers you are copying 
should not be taken from another process, but from the data Bproc got from 
the network. Otherwise yes, it's correct...
But (I assume your email is misleading) this should be done after return, 
right?

Actually, however, I think it may be simpler to implement that more like how 
"exec" is handled, than how "fork" is handled, at least for UML specific 
details. Yes, this has a performance cost, and the problems may lay 
elsewhere.

> But currently there is the segmentation fault problem as I mentioned in my
> last mail.
In particular: since it's testing VMA_GROWSDOWN, it means that the only VMA 
(which is the kernel recorded image of a mmap() call, either explicitly done, 
or auto-done by ELF startup code) which it found covers a range *above* the 
fault address, and that the VMA is not a "stack-like" one (the stack VMA 
expands down automatically as needed. This can mean two things:
* either the address is a stack one and the VMA was not set up correctly (but 
that wouldn't be likely your code's fault) or
* more likely, the mappings haven't been setup correctly.

And -14 is -EFAULT (as you can easily check).
> Any ideas? Thanks a lot! 
Surely there's something wrong in the userspace setup. I mean, you must alter 
registers of the userspace thread (done in copy_thread_tt), and its memory 
mappings, to create a process image to return to.

Also, this probably involves creating a userspace context; for instance, a 
kernel thread has current->mm == NULL, and Bproc surely handles that somehow.
> Alex

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
