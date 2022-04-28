Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 29 Apr 2022 00:19:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
Message-ID: <YmsS4pReIh6pVeWe@hirez.programming.kicks-ass.net>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-6-ebiederm@xmission.com>
 <20220427141018.GA17421@redhat.com>
 <874k2ea9q4.fsf@email.froward.int.ebiederm.org>
 <87zgk67fdd.fsf@email.froward.int.ebiederm.org>
 <YmrSijTc6HIv4sAG@hirez.programming.kicks-ass.net>
 <8735hxxddw.fsf@email.froward.int.ebiederm.org>
 <87ilqtvsqg.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ilqtvsqg.fsf@email.froward.int.ebiederm.org>
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
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>

On Thu, Apr 28, 2022 at 03:49:11PM -0500, Eric W. Biederman wrote:

> static void lock_parents_siglocks(bool lock_tracer)
> 	__releases(&current->sighand->siglock)
> 	__acquires(&current->sighand->siglock)
> 	__acquires(&current->real_parent->sighand->siglock)
> 	__acquires(&current->parent->sighand->siglock)
> {
> 	struct task_struct *me = current;
> 	struct sighand_struct *m_sighand = me->sighand;
> 
> 	lockdep_assert_held(&m_sighand->siglock);
> 
> 	rcu_read_lock();
> 	for (;;) {
> 		struct task_struct *parent, *tracer;
> 		struct sighand_struct *p_sighand, *t_sighand, *s1, *s2, *s3;
> 
> 		parent = me->real_parent;
> 		tracer = lock_tracer? me->parent : parent;
> 
> 		p_sighand = rcu_dereference(parent->sighand);
> 		t_sighand = rcu_dereference(tracer->sighand);
> 
> 		/* Sort the sighands so that s1 >= s2 >= s3 */
> 		s1 = m_sighand;
> 		s2 = p_sighand;
> 		s3 = t_sighand;
> 		if (s1 > s2)
> 			swap(s1, s2);
> 		if (s1 > s3)
> 			swap(s1, s3);
> 		if (s2 > s3)
> 			swap(s2, s3);
> 
> 		if (s1 != m_sighand) {
> 			spin_unlock(&m_sighand->siglock);
> 			spin_lock(&s1->siglock);
> 		}
> 
> 		if (s1 != s2)
> 			spin_lock_nested(&s2->siglock, SIGLOCK_LOCK_SECOND);
> 		if (s2 != s3)
> 			spin_lock_nested(&s3->siglock, SIGLOCK_LOCK_THIRD);
> 

Might as well just use 1 and 2 for subclass at this point, or use
SIGLOCK_LOCK_FIRST below.

> 		if (likely((me->real_parent == parent) &&
> 			   (me->parent == tracer) &&
> 			   (parent->sighand == p_sighand) &&
> 			   (tracer->sighand == t_sighand))) {
> 			break;
> 		}
> 		spin_unlock(&p_sighand->siglock);
>                 if (t_sighand != p_sighand)
> 			spin_unlock(&t_sighand->siglock);

Indent fail above ^, also you likey need this:

		/*
		 * Since [pt]_sighand will likely change if we go
		 * around, and m_sighand is the only one held, make sure
		 * it is subclass-0, since the above 's1 != m_sighand'
		 * clause very much relies on that.
		 */
		lock_set_subclass(&m_sighand->siglock, 0, _RET_IP_);

> 		continue;
> 	}
> 	rcu_read_unlock();
> }
> 
> Eric

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

