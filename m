Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 6 Jul 2022 10:59:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
Message-ID: <YsVO1NU3bXGg9YJ3@worktop.programming.kicks-ass.net>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <20220505182645.497868-12-ebiederm@xmission.com>
 <YrHA5UkJLornOdCz@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <877d5ajesi.fsf@email.froward.int.ebiederm.org>
 <YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <20220628191541.34a073fc@gandalf.local.home>
 <yt9d5ykbekn3.fsf@linux.ibm.com>
 <yt9dpmijcvu6.fsf@linux.ibm.com>
 <YsSQRmCZSIQ1ewzo@worktop.programming.kicks-ass.net>
 <yt9dsfneaczk.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <yt9dsfneaczk.fsf@linux.ibm.com>
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
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexander Gordeev <agordeev@linux.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org

On Wed, Jul 06, 2022 at 09:58:55AM +0200, Sven Schnelle wrote:

> >> [   86.218551] kill_chi-343805    6d.... 79990141us : ptrace_stop: JOBCTL_TRACED already set, state=0 <------ valid combination of flags?
> >
> > Yeah, that's not supposed to be so. JOBCTL_TRACED is supposed to follow
> > __TASK_TRACED for now. Set when __TASK_TRACED, cleared when
> > TASK_RUNNING.
> >
> > Specifically {ptrace_,}signal_wake_up() in signal.h clear JOBCTL_TRACED
> > when they would wake a __TASK_TRACED task.
> 
> try_to_wake_up() clears TASK_TRACED in this case because a signal
> (SIGKILL) has to be delivered. As a test I put the following change
> on top, and it "fixes" the problem:
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index da0bf6fe9ecd..f2e0f5e70e77 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4141,6 +4149,9 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>          * TASK_WAKING such that we can unlock p->pi_lock before doing the
>          * enqueue, such as ttwu_queue_wakelist().
>          */
> +       if (p->__state & TASK_TRACED)
> +               trace_printk("clearing TASK_TRACED 2\n");
> +       p->jobctl &= ~JOBCTL_TRACED;
>         WRITE_ONCE(p->__state, TASK_WAKING);
> 
>         /*
> 
> There are several places where the state is changed from TASK_TRACED to
> something else without clearing JOBCTL_TRACED.

I'm having difficulty spotting them; I find:

TASK_WAKEKILL: signal_wake_up()
__TASK_TRACED: ptrace_signal_wake_up(), ptrace_unfreeze_traced(), ptrace_resume()

And all those sites dutifully clear JOBCTL_TRACED.

I'd be most interested in the calstack for the 'clearing TASK_TRACED 2'
events to see where we miss a spot.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

