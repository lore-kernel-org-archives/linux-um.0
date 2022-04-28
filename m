Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk2BI-006Uxn-Ag
 for linux-um@lists.infradead.org; Thu, 28 Apr 2022 11:19:34 +0000
Date: Thu, 28 Apr 2022 13:19:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 7/9] ptrace: Simplify the wait_task_inactive call in
 ptrace_check_attach
Message-ID: <20220428111911.GA3804@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-7-ebiederm@xmission.com>
 <20220427151455.GE17421@redhat.com>
 <Ympvf1Pam1ckX+EA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ympvf1Pam1ckX+EA@hirez.programming.kicks-ass.net>
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
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>

On 04/28, Peter Zijlstra wrote:
>
> On Wed, Apr 27, 2022 at 05:14:57PM +0200, Oleg Nesterov wrote:
> > On 04/26, Eric W. Biederman wrote:
> > >
> > > Asking wait_task_inactive to verify that tsk->__state == __TASK_TRACED
> > > was needed to detect the when ptrace_stop would decide not to stop
> > > after calling "set_special_state(TASK_TRACED)".  With the recent
> > > cleanups ptrace_stop will always stop after calling set_special_state.
> > >
> > > Take advatnage of this by no longer asking wait_task_inactive to
> > > verify the state.  If a bug is hit and wait_task_inactive does not
> > > succeed warn and return -ESRCH.
> >
> > ACK, but I think that the changelog is wrong.
> >
> > We could do this right after may_ptrace_stop() has gone. This doesn't
> > depend on the previous changes in this series.
>
> It very much does rely on there not being any blocking between
> set_special_state() and schedule() tho. So all those PREEMPT_RT
> spinlock->rt_mutex things need to be gone.

Yes sure. But this patch doesn't add the new problems, imo.

Yes we can hit the WARN_ON_ONCE(!wait_task_inactive()), but this is
correct in that it should not fail, and this is what we need to fix.

> That is also the reason I couldn't do wait_task_inactive(task, 0)

Ah, I din't notice this patch uses wait_task_inactive(child, 0),
I think it should do wait_task_inactive(child, __TASK_TRACED).

Oleg.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

