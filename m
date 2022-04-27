Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njiXP-001lSR-2r
 for linux-um@lists.infradead.org; Wed, 27 Apr 2022 14:21:07 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-6-ebiederm@xmission.com>
 <20220427141018.GA17421@redhat.com>
Date: Wed, 27 Apr 2022 09:20:51 -0500
In-Reply-To: <20220427141018.GA17421@redhat.com> (Oleg Nesterov's message of
 "Wed, 27 Apr 2022 16:10:25 +0200")
Message-ID: <874k2ea9q4.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
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

> On 04/26, Eric W. Biederman wrote:
>>
>> @@ -2164,7 +2166,9 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
>>   	}
>>
>>  	sighand = parent->sighand;
>> -	spin_lock_irqsave(&sighand->siglock, flags);
>> +	lock = tsk->sighand != sighand;
>> +	if (lock)
>> +		spin_lock_nested(&sighand->siglock, SINGLE_DEPTH_NESTING);
>
> But why is it safe?
>
> Suppose we have two tasks, they both trace each other, both call
> ptrace_stop() at the same time. Of course this is ugly, they both
> will block.
>
> But with this patch in this case we have the trivial ABBA deadlock,
> no?

I was thinking in terms of the process tree (which is fine).

The ptrace parental relationship definitely has the potential to be a
graph with cycles.  Which as you point out is not fine.


The result is very nice and I don't want to give it up.  I suspect
something ptrace cycles are always a problem and can simply be
forbidden.  That is going to take some analsysis and some additional
code in ptrace_attach.

I will go look at that.

Eric


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

