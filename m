Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lzS1N-004C43-OX
 for linux-um@lists.infradead.org; Fri, 02 Jul 2021 22:52:31 +0000
Received: by mail-pf1-x430.google.com with SMTP id f20so2553064pfa.1
 for <linux-um@lists.infradead.org>; Fri, 02 Jul 2021 15:52:29 -0700 (PDT)
Date: Fri, 2 Jul 2021 15:48:53 -0700
From: Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Message-ID: <YN+X1QKWQOKekK4E@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
 <CAG48ez37ZUNvWy1eOvrW13kFRM-_ZW175x99Nyjq43w4Qz1qJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG48ez37ZUNvWy1eOvrW13kFRM-_ZW175x99Nyjq43w4Qz1qJQ@mail.gmail.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jann Horn <jannh@google.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Jul 02, 2021 at 10:56:38PM +0200, Jann Horn wrote:
> On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:
> > This change introduces the new system call:
> > process_vm_exec(pid_t pid, struct sigcontext *uctx, unsigned long flags,
> >                 siginfo_t * uinfo, sigset_t *sigmask, size_t sizemask)
> >
> > process_vm_exec allows to execute the current process in an address
> > space of another process.
> >
> > process_vm_exec swaps the current address space with an address space of
> > a specified process, sets a state from sigcontex and resumes the process.
> > When a process receives a signal or calls a system call,
> > process_vm_exec saves the process state back to sigcontext, restores the
> > origin address space, restores the origin process state, and returns to
> > userspace.
> >
> > If it was interrupted by a signal and the signal is in the user_mask,
> > the signal is dequeued and information about it is saved in uinfo.
> > If process_vm_exec is interrupted by a system call, a synthetic siginfo
> > for the SIGSYS signal is generated.
> >
> > The behavior of this system call is similar to PTRACE_SYSEMU but
> > everything is happing in the context of one process, so
> > process_vm_exec shows a better performance.
> >
> > PTRACE_SYSEMU is primarily used to implement sandboxes (application
> > kernels) like User-mode Linux or gVisor. These type of sandboxes
> > intercepts applications system calls and acts as the guest kernel.
> > A simple benchmark, where a "tracee" process executes systems calls in a
> > loop and a "tracer" process traps syscalls and handles them just
> > incrementing the tracee instruction pointer to skip the syscall
> > instruction shows that process_vm_exec works more than 5 times faster
> > than PTRACE_SYSEMU.
> [...]
> > +long swap_vm_exec_context(struct sigcontext __user *uctx)
> > +{
> > +       struct sigcontext ctx = {};
> > +       sigset_t set = {};
> > +
> > +
> > +       if (copy_from_user(&ctx, uctx, CONTEXT_COPY_SIZE))
> > +               return -EFAULT;
> > +       /* A floating point state is managed from user-space. */
> > +       if (ctx.fpstate != 0)
> > +               return -EINVAL;
> > +       if (!user_access_begin(uctx, sizeof(*uctx)))
> > +               return -EFAULT;
> > +       unsafe_put_sigcontext(uctx, NULL, current_pt_regs(), (&set), Efault);
> > +       user_access_end();
> > +
> > +       if (__restore_sigcontext(current_pt_regs(), &ctx, 0))
> > +               goto badframe;
> > +
> > +       return 0;
> > +Efault:
> > +       user_access_end();
> > +badframe:
> > +       signal_fault(current_pt_regs(), uctx, "swap_vm_exec_context");
> > +       return -EFAULT;
> > +}
> 
> Comparing the pieces of context that restore_sigcontext() restores
> with what a normal task switch does (see __switch_to() and callees), I
> noticed: On CPUs with FSGSBASE support, I think sandboxed code could
> overwrite FSBASE/GSBASE using the WRFSBASE/WRGSBASE instructions,
> causing the supervisor to access attacker-controlled addresses when it
> tries to access a thread-local variable like "errno"? Signal handling
> saves the segment registers, but not the FS/GS base addresses.
> 
> 
> jannh@laptop:~/test$ cat signal_gsbase.c
> // compile with -mfsgsbase
> #include <stdio.h>
> #include <signal.h>
> #include <immintrin.h>
> 
> void signal_handler(int sig, siginfo_t *info, void *ucontext_) {
>   puts("signal handler");
>   _writegsbase_u64(0x12345678);
> }
> 
> int main(void) {
>   struct sigaction new_act = {
>     .sa_sigaction = signal_handler,
>     .sa_flags = SA_SIGINFO
>   };
>   sigaction(SIGUSR1, &new_act, NULL);
> 
>   printf("original gsbase is 0x%lx\n", _readgsbase_u64());
>   raise(SIGUSR1);
>   printf("post-signal gsbase is 0x%lx\n", _readgsbase_u64());
> }
> jannh@laptop:~/test$ gcc -o signal_gsbase signal_gsbase.c -mfsgsbase
> jannh@laptop:~/test$ ./signal_gsbase
> original gsbase is 0x0
> signal handler
> post-signal gsbase is 0x12345678
> jannh@laptop:~/test$
> 
> 
> So to make this usable for a sandboxing usecase, you'd also have to
> save and restore FSBASE/GSBASE, just like __switch_to().

You are right. I've found this too when I implemented the gviosr user-space
part.

Here is the tree whether this problem has been fixed:
https://github.com/avagin/linux-task-diag/commits/wip/gvisor-5.10


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

