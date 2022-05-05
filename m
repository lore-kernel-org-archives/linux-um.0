Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-74.mimecast.com ([170.10.129.74])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmczh-00GWsu-HG
 for linux-um@lists.infradead.org; Thu, 05 May 2022 15:02:18 +0000
Date: Thu, 5 May 2022 17:01:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3 08/11] ptrace: Admit ptrace_stop can generate spuriuos
 SIGTRAPs
Message-ID: <20220505150158.GB13929@redhat.com>
References: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <20220504224058.476193-8-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220504224058.476193-8-ebiederm@xmission.com>
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

On 05/04, Eric W. Biederman wrote:
>
> With the removal of the incomplete detection of the tracer going away
> in ptrace_stop, ptrace_stop always sleeps in schedule after
> ptrace_freeze_traced succeeds.  Modify ptrace_check_attach to
> warn if wait_task_inactive fails.

Oh. Again, I don't understand the changelog. If we forget about RT,
ptrace_stop() will always sleep if ptrace_freeze_traced() succeeds.
may_ptrace_stop() has gone.

IOW. Lets forget about RT

> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -266,17 +266,9 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
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
> +	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
> +		ret = -ESRCH;
>
>  	return ret;
>  }

Why do you think this change would be wrong without any other changes?

Oleg.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

