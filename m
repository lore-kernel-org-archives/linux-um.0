Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lzRak-0049Sb-Nf
 for linux-um@lists.infradead.org; Fri, 02 Jul 2021 22:25:00 +0000
Received: by mail-pf1-x42e.google.com with SMTP id w22so6732480pff.5
 for <linux-um@lists.infradead.org>; Fri, 02 Jul 2021 15:24:56 -0700 (PDT)
Date: Fri, 2 Jul 2021 15:21:22 -0700
From: Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Message-ID: <YN+RYi5honrgjFAw@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
 <YN7TgV9RDJTRaY8R@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YN7TgV9RDJTRaY8R@hirez.programming.kicks-ass.net>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Jul 02, 2021 at 10:51:13AM +0200, Peter Zijlstra wrote:
> 
> I'm terrified of all of this...
> 
> On Tue, Apr 13, 2021 at 10:52:15PM -0700, Andrei Vagin wrote:
> 
> > +long swap_vm_exec_context(struct sigcontext __user *uctx)
> > +{
> > +	struct sigcontext ctx = {};
> > +	sigset_t set = {};
> > +
> > +
> > +	if (copy_from_user(&ctx, uctx, CONTEXT_COPY_SIZE))
> > +		return -EFAULT;
> > +	/* A floating point state is managed from user-space. */
> > +	if (ctx.fpstate != 0)
> > +		return -EINVAL;

Here, we check that ctx doesn't have an FPU state.

> > +	if (!user_access_begin(uctx, sizeof(*uctx)))
> > +		return -EFAULT;
> > +	unsafe_put_sigcontext(uctx, NULL, current_pt_regs(), (&set), Efault);
> > +	user_access_end();
> 
> But here you save the sigcontext without FPU state.
> 
> > +
> > +	if (__restore_sigcontext(current_pt_regs(), &ctx, 0))
> > +		goto badframe;
> 
> And here you restore sigcontext, *with* FPU state.  At which point your
> FPU state is irrecoverably lost.

process_vm_exec doesn't change a process FPU state. Unlike signals, here
we can control it from a user-space. A process can set an FPU state
before process_vm_exec and then retore its FPU state after the
call.

This version of patches has a bug that I fixed in my tree when I
implemented the user-space part for gVisor. I didn't take into account
that restore_sigcontext(ctx) clears a process fpu state if ctx->fpstate
is zero. I moved fpu__restore_sig out from __restore_sigcontext to fix
this issue:

https://github.com/avagin/linux-task-diag/commit/55b7194d00ff

> 
> Also, I'm not at all convinced this can ever do the right thing when the
> tasks don't agree on what the FPU state is. I suppose in the best case
> the save will EFAULT.
> 
> > +
> > +	return 0;
> > +Efault:
> > +	user_access_end();
> > +badframe:
> > +	signal_fault(current_pt_regs(), uctx, "swap_vm_exec_context");
> > +	return -EFAULT;
> > +}

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

