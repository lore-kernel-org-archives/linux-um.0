Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njlVa-002gNn-4d
 for linux-um@lists.infradead.org; Wed, 27 Apr 2022 17:31:23 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-9-ebiederm@xmission.com>
 <20220427160901.GI17421@redhat.com>
 <87o80m7afv.fsf@email.froward.int.ebiederm.org>
 <20220427171829.GJ17421@redhat.com>
 <20220427172109.GK17421@redhat.com>
Date: Wed, 27 Apr 2022 12:31:09 -0500
In-Reply-To: <20220427172109.GK17421@redhat.com> (Oleg Nesterov's message of
 "Wed, 27 Apr 2022 19:21:10 +0200")
Message-ID: <87wnfa5t7m.fsf@email.froward.int.ebiederm.org>
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
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/27, Oleg Nesterov wrote:
>>
>> On 04/27, Eric W. Biederman wrote:
>> >
>> > Oleg Nesterov <oleg@redhat.com> writes:
>> >
>> > > On 04/26, Eric W. Biederman wrote:
>> > >>
>> > >> @@ -253,7 +252,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>> > >>  	 */
>> > >>  	if (lock_task_sighand(child, &flags)) {
>> > >>  		if (child->ptrace && child->parent == current) {
>> > >> -			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
>> > >> +			WARN_ON(child->jobctl & JOBCTL_DELAY_WAKEKILL);
>> > >
>> > > This WARN_ON() doesn't look right.
>> > >
>> > > It is possible that this child was traced by another task and PTRACE_DETACH'ed,
>> > > but it didn't clear DELAY_WAKEKILL.
>> >
>> > That would be a bug.  That would mean that PTRACE_DETACHED process can
>> > not be SIGKILL'd.
>>
>> Why? The tracee will take siglock, clear JOBCTL_DELAY_WAKEKILL and notice
>> SIGKILL after that.
>
> Not to mention that the tracee is TASK_RUNNING after PTRACE_DETACH wakes it
> up, so the pending JOBCTL_DELAY_WAKEKILL simply has no effect.

Oh.  You are talking about the window when between clearing the
traced state and when tracee resumes executing and clears
JOBCTL_DELAY_WAKEKILL.

I thought you were thinking about JOBCTL_DELAY_WAKEKILL being leaked.

That requires both ptrace_attach and ptrace_check_attach for the new
tracer to happen before the tracee is scheduled to run.

I agree.  I think the WARN_ON could reasonably be moved a bit later,
but I don't know that the WARN_ON is important. I simply kept it because
it seemed to make sense.

Eric

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

