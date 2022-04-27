Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njjnu-0022vW-6t
 for linux-um@lists.infradead.org; Wed, 27 Apr 2022 15:42:14 +0000
Date: Wed, 27 Apr 2022 17:41:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 9/9] ptrace: Don't change __state
Message-ID: <20220427154158.GG17421@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-9-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220426225211.308418-9-ebiederm@xmission.com>
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

On 04/26, Eric W. Biederman wrote:
>
>  static void ptrace_unfreeze_traced(struct task_struct *task)
>  {
> -	if (READ_ONCE(task->__state) != __TASK_TRACED)
> +	if (!(READ_ONCE(task->jobctl) & JOBCTL_DELAY_WAKEKILL))
>  		return;
>
>  	WARN_ON(!task->ptrace || task->parent != current);
> @@ -213,11 +213,10 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
>  	 * Recheck state under the lock to close this race.
>  	 */
>  	spin_lock_irq(&task->sighand->siglock);

Now that we do not check __state = __TASK_TRACED, we need lock_task_sighand().
The tracee can be already woken up by ptrace_resume(), but it is possible that
it didn't clear DELAY_WAKEKILL yet.

Now, before we take ->siglock, the tracee can exit and another thread can do
wait() and reap this task.

Also, I think the comment above should be updated. I agree, it makes sense to
re-check JOBCTL_DELAY_WAKEKILL under siglock just for clarity, but we no longer
need to do this to close the race; jobctl &= ~JOBCTL_DELAY_WAKEKILL and
wake_up_state() are safe even if JOBCTL_DELAY_WAKEKILL was already cleared.

> @@ -2307,6 +2307,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>
>  	/* LISTENING can be set only during STOP traps, clear it */
>  	current->jobctl &= ~JOBCTL_LISTENING;
> +	current->jobctl &= ~JOBCTL_DELAY_WAKEKILL;

minor, but

	current->jobctl &= ~(JOBCTL_LISTENING | JOBCTL_DELAY_WAKEKILL);

looks better.

Oleg.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

