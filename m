Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6G5g-007dvf-MM
	for linux-um@lists.infradead.org; Tue, 28 Jun 2022 18:37:38 +0000
Date: Tue, 28 Jun 2022 20:36:53 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
Message-ID: <YrtKReO2vIiX8VVU@tuxmaker.boeblingen.de.ibm.com>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <20220505182645.497868-12-ebiederm@xmission.com>
 <YrHA5UkJLornOdCz@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <877d5ajesi.fsf@email.froward.int.ebiederm.org>
 <YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <87y1xk8zx5.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y1xk8zx5.fsf@email.froward.int.ebiederm.org>
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
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org

On Sat, Jun 25, 2022 at 11:34:46AM -0500, Eric W. Biederman wrote:
> I haven't gotten as far as reproducing this but I have started giving
> this issue some thought.
> 
> This entire thing smells like a memory barrier is missing somewhere.
> However by definition the lock implementations in linux provide all the
> needed memory barriers, and in the ptrace_stop and ptrace_check_attach
> path I don't see cases where these values are sampled outside of a lock
> except in wait_task_inactive.  Does doing that perhaps require a
> barrier? 
> 
> The two things I can think of that could shed light on what is going on
> is enabling lockdep, to enable the debug check in signal_wake_up_state
> and verifying bits of state that should be constant while the task
> is frozen for ptrace are indeed constant when task is frozen for ptrace.
> Something like my patch below.
> 
> If you could test that when you have a chance that would help narrow
> down what is going on.
> 
> Thank you,
> Eric
> 
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 156a99283b11..6467a2b1c3bc 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -268,9 +268,13 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  	}
>  	read_unlock(&tasklist_lock);
>  
> -	if (!ret && !ignore_state &&
> -	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
> +	if (!ret && !ignore_state) {
> +		WARN_ON_ONCE(!(child->jobctl & JOBCTL_PTRACE_FROZEN));
> +		WARN_ON_ONCE(!(child->joctctl & JOBCTL_TRACED));
> +		WARN_ON_ONCE(READ_ONCE(child->__state) != __TASK_TRACED);
> +		WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED));
>  		ret = -ESRCH;
> +	}
>  
>  	return ret;
>  }

I modified your chunk a bit - hope that is what you had in mind:

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 156a99283b11..f0e9a9a4d63c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -268,9 +268,19 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	}
 	read_unlock(&tasklist_lock);
 
-	if (!ret && !ignore_state &&
-	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
-		ret = -ESRCH;
+	if (!ret && !ignore_state) {
+		unsigned int __state;
+
+		WARN_ON_ONCE(!(child->jobctl & JOBCTL_PTRACE_FROZEN));
+		WARN_ON_ONCE(!(child->jobctl & JOBCTL_TRACED));
+		__state = READ_ONCE(child->__state);
+		if (__state != __TASK_TRACED) {
+			pr_err("%s(%d) __state %x", __FUNCTION__, __LINE__, __state);
+			WARN_ON_ONCE(1);
+		}
+		if (WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
+			ret = -ESRCH;
+	}
 
 	return ret;
 }


When WARN_ON_ONCE(1) hits the child __state is always zero/TASK_RUNNING,
as reported by the preceding pr_err(). Yet, in the resulting core dump
it is always __TASK_TRACED.

Removing WARN_ON_ONCE(1) while looping until (__state != __TASK_TRACED)
confirms the unexpected __state is always TASK_RUNNING. It never observed
more than one iteration and gets printed once in 30-60 mins.

So probably when the condition is entered __state is TASK_RUNNING more
often, but gets overwritten with __TASK_TRACED pretty quickly. Which kind
of consistent with my previous observation that kernel/sched/core.c:3305
is where return 0 makes wait_task_inactive() fail.

No other WARN_ON_ONCE() hit ever.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

