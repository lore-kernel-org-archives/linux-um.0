Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 2 Jul 2021 10:51:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Message-ID: <YN7TgV9RDJTRaY8R@hirez.programming.kicks-ass.net>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210414055217.543246-3-avagin@gmail.com>
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
To: Andrei Vagin <avagin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>


I'm terrified of all of this...

On Tue, Apr 13, 2021 at 10:52:15PM -0700, Andrei Vagin wrote:

> +long swap_vm_exec_context(struct sigcontext __user *uctx)
> +{
> +	struct sigcontext ctx = {};
> +	sigset_t set = {};
> +
> +
> +	if (copy_from_user(&ctx, uctx, CONTEXT_COPY_SIZE))
> +		return -EFAULT;
> +	/* A floating point state is managed from user-space. */
> +	if (ctx.fpstate != 0)
> +		return -EINVAL;
> +	if (!user_access_begin(uctx, sizeof(*uctx)))
> +		return -EFAULT;
> +	unsafe_put_sigcontext(uctx, NULL, current_pt_regs(), (&set), Efault);
> +	user_access_end();

But here you save the sigcontext without FPU state.

> +
> +	if (__restore_sigcontext(current_pt_regs(), &ctx, 0))
> +		goto badframe;

And here you restore sigcontext, *with* FPU state.  At which point your
FPU state is irrecoverably lost.

Also, I'm not at all convinced this can ever do the right thing when the
tasks don't agree on what the FPU state is. I suppose in the best case
the save will EFAULT.

> +
> +	return 0;
> +Efault:
> +	user_access_end();
> +badframe:
> +	signal_fault(current_pt_regs(), uctx, "swap_vm_exec_context");
> +	return -EFAULT;
> +}

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

