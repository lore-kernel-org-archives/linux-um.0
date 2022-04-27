Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njjAJ-001tqd-7F
 for linux-um@lists.infradead.org; Wed, 27 Apr 2022 15:01:16 +0000
Date: Wed, 27 Apr 2022 17:00:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
Message-ID: <20220427150053.GD17421@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-6-ebiederm@xmission.com>
 <20220427145646.GC17421@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220427145646.GC17421@redhat.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>

On 04/27, Oleg Nesterov wrote:
>
> On 04/26, Eric W. Biederman wrote:
> >
> > @@ -2209,6 +2213,34 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
> >  		spin_lock_irq(&current->sighand->siglock);
> >  	}
> >
> > +	/* Don't stop if current is not ptraced */
> > +	if (unlikely(!current->ptrace))
> > +		return (clear_code) ? 0 : exit_code;
> > +
> > +	/*
> > +	 * If @why is CLD_STOPPED, we're trapping to participate in a group
> > +	 * stop.  Do the bookkeeping.  Note that if SIGCONT was delievered
> > +	 * across siglock relocks since INTERRUPT was scheduled, PENDING
> > +	 * could be clear now.  We act as if SIGCONT is received after
> > +	 * TASK_TRACED is entered - ignore it.
> > +	 */
> > +	if (why == CLD_STOPPED && (current->jobctl & JOBCTL_STOP_PENDING))
> > +		gstop_done = task_participate_group_stop(current);
> > +
> > +	/*
> > +	 * Notify parents of the stop.
> > +	 *
> > +	 * While ptraced, there are two parents - the ptracer and
> > +	 * the real_parent of the group_leader.  The ptracer should
> > +	 * know about every stop while the real parent is only
> > +	 * interested in the completion of group stop.  The states
> > +	 * for the two don't interact with each other.  Notify
> > +	 * separately unless they're gonna be duplicates.
> > +	 */
> > +	do_notify_parent_cldstop(current, true, why);
> > +	if (gstop_done && ptrace_reparented(current))
> > +		do_notify_parent_cldstop(current, false, why);
>
> This doesn't look right too. The parent should be notified only after
> we set __state = TASK_TRACED and ->exit code.
>
> Suppose that debugger sleeps in do_wait(). do_notify_parent_cldstop()
> wakes it up, debugger calls wait_task_stopped() and then it will sleep
> again, task_stopped_code() returns 0.
>
> This can be probably fixed if you remove the lockless (fast path)
> task_stopped_code() check in wait_task_stopped(), but this is not
> nice performance-wise...

On the other hand, I don't understand why did you move the callsite
of do_notify_parent_cldstop() up... just don't do this?

Oleg.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

