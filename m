Return-Path: <linux-pm-owner@vger.kernel.org>
Date: Wed, 27 Apr 2022 18:09:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 9/9] ptrace: Don't change __state
Message-ID: <20220427160901.GI17421@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-9-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426225211.308418-9-ebiederm@xmission.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
List-ID: <linux-um.lists.infradead.org>

On 04/26, Eric W. Biederman wrote:
>
> @@ -253,7 +252,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  	 */
>  	if (lock_task_sighand(child, &flags)) {
>  		if (child->ptrace && child->parent == current) {
> -			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
> +			WARN_ON(child->jobctl & JOBCTL_DELAY_WAKEKILL);

This WARN_ON() doesn't look right.

It is possible that this child was traced by another task and PTRACE_DETACH'ed,
but it didn't clear DELAY_WAKEKILL.

If the new debugger attaches and calls ptrace() before the child takes siglock
ptrace_freeze_traced() will fail, but we can hit this WARN_ON().

Oleg.


