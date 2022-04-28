Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk9GY-008ETN-P8
 for linux-um@lists.infradead.org; Thu, 28 Apr 2022 18:53:28 +0000
Date: Thu, 28 Apr 2022 20:53:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 9/9] ptrace: Don't change __state
Message-ID: <20220428185311.GF15485@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-9-ebiederm@xmission.com>
 <87czh2160k.fsf@email.froward.int.ebiederm.org>
 <20220428151110.GB15485@redhat.com>
 <875ymtywxg.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <875ymtywxg.fsf@email.froward.int.ebiederm.org>
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
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>

On 04/28, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> >> The bug appears when the TRACEE makes it to schedule().  Inside
> >> schedule there is a call to signal_pending_state() which notices
> >> a SIGKILL is pending and refuses to sleep.
> >
> > And I think this is fine. This doesn't really differ from the case
> > when the tracee was killed before it takes siglock.
>
> Hmm.  Maybe.

I hope ;)

> Previously we were actually guaranteed in ptrace_check_attach that after
> ptrace_freeze_traced would succeed as any pending fatal signal would
> cause ptrace_freeze_traced to fail.  Any incoming fatal signal would not
> stop schedule from sleeping.

Yes.

So let me repeat, 7/9 "ptrace: Simplify the wait_task_inactive call in
ptrace_check_attach" looks good to me (except it should use
wait_task_inactive(__TASK_TRACED)), but it should come before other
meaningfull changes and the changelog should be updated.

And then we will probably need to reconsider this wait_task_inactive()
and WARN_ON() around it, but depends on what will we finally do.

> I think in my tired mind yesterday

I got lost too ;)

> Still I would like to be able to
> let wait_task_inactive not care about the state of the process it is
> going to sleep for.

Not sure... but to be honest I didn't really pay attention to the
wait_task_inactive(match_state => 0) part...

Oleg.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

