Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk91d-008D4S-9a
 for linux-um@lists.infradead.org; Thu, 28 Apr 2022 18:38:02 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-6-ebiederm@xmission.com>
 <20220427141018.GA17421@redhat.com>
 <874k2ea9q4.fsf@email.froward.int.ebiederm.org>
 <87zgk67fdd.fsf@email.froward.int.ebiederm.org>
 <YmrSijTc6HIv4sAG@hirez.programming.kicks-ass.net>
Date: Thu, 28 Apr 2022 13:37:47 -0500
In-Reply-To: <YmrSijTc6HIv4sAG@hirez.programming.kicks-ass.net> (Peter
 Zijlstra's message of "Thu, 28 Apr 2022 19:44:42 +0200")
Message-ID: <8735hxxddw.fsf@email.froward.int.ebiederm.org>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Apr 27, 2022 at 09:47:10AM -0500, Eric W. Biederman wrote:
>
>> Hmm.  If we have the following process tree.
>> 
>>     A
>>      \
>>       B
>>        \
>>         C
>> 
>> Process A, B, and C are all in the same process group.
>> Process A and B are setup to receive SIGCHILD when
>> their process stops.
>> 
>> Process C traces process A.
>> 
>> When a sigstop is delivered to the group we can have:
>> 
>> Process B takes siglock(B) siglock(A) to notify the real_parent
>> Process C takes siglock(C) siglock(B) to notify the real_parent
>> Process A takes siglock(A) siglock(C) to notify the tracer
>> 
>> If they all take their local lock at the same time there is
>> a deadlock.
>> 
>> I don't think the restriction that you can never ptrace anyone
>> up the process tree is going to fly.  So it looks like I am back to the
>> drawing board for this one.
>
> I've not had time to fully appreciate the nested locking here, but if it
> is possible to rework things to always take both locks at the same time,
> then it would be possible to impose an arbitrary lock order on things
> and break the cycle that way.
>
> That is, simply order the locks by their heap address or something:
>
> static void double_siglock_irq(struct sighand *sh1, struct sighand2 *sh2)
> {
> 	if (sh1 > sh2)
> 		swap(sh1, sh2)
>
> 	spin_lock_irq(&sh1->siglock);
> 	spin_lock_nested(&sh2->siglock, SINGLE_DEPTH_NESTING);
> }

You know it might be.  Especially given that the existing code is
already dropping siglock and grabbing tasklist_lock.

It would take a potentially triple lock function to lock
the task it's real_parent and it's tracer (aka parent).

That makes this possible to consider is that notifying the ``parents''
is a fundamental part of the operation so we know we are going to
need the lock so we can move it up.

Throw in a pinch of lock_task_sighand and the triple lock function
gets quite interesting.

It is certainly worth trying, and I will.

Eric


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

