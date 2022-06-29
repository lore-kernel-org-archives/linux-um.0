Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6OZ6-009Ib6-QD
	for linux-um@lists.infradead.org; Wed, 29 Jun 2022 03:40:34 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
	<20220505182645.497868-12-ebiederm@xmission.com>
	<YrHA5UkJLornOdCz@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
	<877d5ajesi.fsf@email.froward.int.ebiederm.org>
	<YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
	<87y1xk8zx5.fsf@email.froward.int.ebiederm.org>
	<YrtKReO2vIiX8VVU@tuxmaker.boeblingen.de.ibm.com>
	<87czess94h.fsf@email.froward.int.ebiederm.org>
	<20220628184850.05f60d1e@gandalf.local.home>
Date: Tue, 28 Jun 2022 22:39:59 -0500
In-Reply-To: <20220628184850.05f60d1e@gandalf.local.home> (Steven Rostedt's
	message of "Tue, 28 Jun 2022 18:48:50 -0400")
Message-ID: <87pmisqgs0.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
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
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue, 28 Jun 2022 17:42:22 -0500
> "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>
>> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
>> index 156a99283b11..cb85bcf84640 100644
>> --- a/kernel/ptrace.c
>> +++ b/kernel/ptrace.c
>> @@ -202,6 +202,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
>>  	spin_lock_irq(&task->sighand->siglock);
>>  	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
>>  	    !__fatal_signal_pending(task)) {
>> +		smp_rmb();
>>  		task->jobctl |= JOBCTL_PTRACE_FROZEN;
>>  		ret = true;
>>  	}
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index edb1dc9b00dc..bcd576e9de66 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2233,6 +2233,7 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
>>  		return exit_code;
>>  
>>  	set_special_state(TASK_TRACED);
>> +	smp_wmb();
>>  	current->jobctl |= JOBCTL_TRACED;
>>  
>
> Are not these both done under the sighand->siglock spinlock?
>
> That is, the two paths should already be synchronized, and the memory
> barriers will not help anything inside the locks. The locking should (and
> must) handle all that.

I would presume so to.  However the READ_ONCE that is going astray
does not look like it is honoring that.

So perhaps there is a bug in the s390 spin_lock barriers?  Perhaps there
is a subtle detail in the barriers that spin locks provide that we are
overlooking?

I just know the observed behavior is:

- reading tsk->jobctl and seeing  JOBCTL_TRACED set.
- reading tsk->__state and seeing TASK_RUNNING.

So unless PREEMPT_RT is enabled on s390.  It looks like there is a
barrier problem.

Alexander do you have PREEMPT_RT enabled on s390?  I have been assuming
you don't but I figure I should ask and make certain as PREEMPT_RT can
cause this kind of failure.

Eric

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

