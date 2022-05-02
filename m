Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlYGg-001all-Fz
 for linux-um@lists.infradead.org; Mon, 02 May 2022 15:47:26 +0000
Date: Mon, 2 May 2022 17:47:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 07/12] ptrace: Don't change __state
Message-ID: <20220502154708.GE17276@redhat.com>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <20220429214837.386518-7-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220429214837.386518-7-ebiederm@xmission.com>
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
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org

On 04/29, Eric W. Biederman wrote:
>
>  static void ptrace_unfreeze_traced(struct task_struct *task)
>  {
> -	if (READ_ONCE(task->__state) != __TASK_TRACED)
> -		return;
> -
> -	WARN_ON(!task->ptrace || task->parent != current);
> +	unsigned long flags;
>
>  	/*
> -	 * PTRACE_LISTEN can allow ptrace_trap_notify to wake us up remotely.
> -	 * Recheck state under the lock to close this race.
> +	 * The child may be awake and may have cleared
> +	 * JOBCTL_PTRACE_FROZEN (see ptrace_resume).  The child will
> +	 * not set JOBCTL_PTRACE_FROZEN or enter __TASK_TRACED anew.
>  	 */
> -	spin_lock_irq(&task->sighand->siglock);
> -	if (READ_ONCE(task->__state) == __TASK_TRACED) {
> +	if (lock_task_sighand(task, &flags)) {
> +		task->jobctl &= ~JOBCTL_PTRACE_FROZEN;

Well, I think that the fast-path

	if (!(task->jobctl & JOBCTL_PTRACE_FROZEN))
		return;

at the start makes sense, we can avoid lock_task_sighand() if the tracee
was resumed.

Oleg.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

