Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1759817AbZCWQDu@vger.kernel.org>
Date: Mon, 23 Mar 2009 16:53:03 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch] fix ptrace slowness
Message-ID: <20090323155303.GA5528@redhat.com>
References: <E1LllkK-0000zF-1h@pomaz-ex.szeredi.hu> <20090323151954.GC21267@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090323151954.GC21267@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, peterz@infradead.org, roland@redhat.com, efault@gmx.de, rjw@sisk.pl, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, torvalds@linux-foundation.org, akpm@linux-foundation.org, stable@kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 03/23, Ingo Molnar wrote:
>
> There's an alternative patch
> below. Would you mind to give it a test? Chances are that it will
> make UML even faster than your fix.
>
> 	Ingo
>
> diff --git a/kernel/sched.c b/kernel/sched.c
> index 3e827b8..2d60f23 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -2119,7 +2119,8 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
>  		 * yield - it could be a while.
>  		 */
>  		if (unlikely(on_rq)) {
> -			schedule_timeout_uninterruptible(1);
> +			cpu_relax();
> +			cond_resched();

What if the caller is a realtime task? We can spin "forever", no?

Oleg.

