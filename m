Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njhvw-001dEd-0I
 for linux-um@lists.infradead.org; Wed, 27 Apr 2022 13:42:21 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-7-ebiederm@xmission.com>
Date: Wed, 27 Apr 2022 08:42:05 -0500
In-Reply-To: <20220426225211.308418-7-ebiederm@xmission.com> (Eric
 W. Biederman's message of "Tue, 26 Apr 2022 17:52:09 -0500")
Message-ID: <87a6c6bq36.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 7/9] ptrace: Simplify the wait_task_inactive call in
 ptrace_check_attach
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

> Asking wait_task_inactive to verify that tsk->__state == __TASK_TRACED
> was needed to detect the when ptrace_stop would decide not to stop
> after calling "set_special_state(TASK_TRACED)".  With the recent
> cleanups ptrace_stop will always stop after calling set_special_state.
>
> Take advatnage of this by no longer asking wait_task_inactive to
> verify the state.  If a bug is hit and wait_task_inactive does not
> succeed warn and return -ESRCH.

As Oleg noticed upthread there are more reasons than simply
!current->ptrace for wait_task_inactive to fail.  In particular a fatal
signal can be received any time before JOBCTL_DELAY_SIGKILL.

So this change is not safe.  I will respin this one.

Eric


> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/ptrace.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 16d1a84a2cae..0634da7ac685 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -265,17 +265,9 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  	}
>  	read_unlock(&tasklist_lock);
>  
> -	if (!ret && !ignore_state) {
> -		if (!wait_task_inactive(child, __TASK_TRACED)) {
> -			/*
> -			 * This can only happen if may_ptrace_stop() fails and
> -			 * ptrace_stop() changes ->state back to TASK_RUNNING,
> -			 * so we should not worry about leaking __TASK_TRACED.
> -			 */
> -			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
> -			ret = -ESRCH;
> -		}
> -	}
> +	if (!ret && !ignore_state &&
> +	    WARN_ON_ONCE(!wait_task_inactive(child, 0)))
> +		ret = -ESRCH;
>  
>  	return ret;
>  }

Eric

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

