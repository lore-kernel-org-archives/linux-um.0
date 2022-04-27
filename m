Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njqjQ-003u0A-4M
 for linux-um@lists.infradead.org; Wed, 27 Apr 2022 23:06:02 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-9-ebiederm@xmission.com>
Date: Wed, 27 Apr 2022 18:05:47 -0500
In-Reply-To: <20220426225211.308418-9-ebiederm@xmission.com> (Eric
 W. Biederman's message of "Tue, 26 Apr 2022 17:52:11 -0500")
Message-ID: <87czh2160k.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 9/9] ptrace: Don't change __state
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
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 3c8b34876744..1947c85aa9d9 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -437,7 +437,8 @@ extern void signal_wake_up_state(struct task_struct *t, unsigned int state);
>  
>  static inline void signal_wake_up(struct task_struct *t, bool resume)
>  {
> -	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
> +	bool wakekill = resume && !(t->jobctl & JOBCTL_DELAY_WAKEKILL);
> +	signal_wake_up_state(t, wakekill ? TASK_WAKEKILL : 0);
>  }
>  static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
>  {

Grrr.  While looking through everything today I have realized that there
is a bug.

Suppose we have 3 processes: TRACER, TRACEE, KILLER.

Meanwhile TRACEE is in the middle of ptrace_stop, just after siglock has
been dropped.

The TRACER process has performed ptrace_attach on TRACEE and is in the
middle of a ptrace operation and has just set JOBCTL_DELAY_WAKEKILL.

Then comes in the KILLER process and sends the TRACEE a SIGKILL.
The TRACEE __state remains TASK_TRACED, as designed.

The bug appears when the TRACEE makes it to schedule().  Inside
schedule there is a call to signal_pending_state() which notices
a SIGKILL is pending and refuses to sleep.

I could avoid setting TIF_SIGPENDING in signal_wake_up but that
is insufficient as another signal may be pending.

I could avoid marking the task as __fatal_signal_pending but then
where would the information that the task needs to become
__fatal_signal_pending go.

Hmm.

This looks like I need my other pending cleanup which introduces a
helper to get this idea to work.

Eric


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

