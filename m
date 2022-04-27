Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njlJK-002bZg-1w
 for linux-um@lists.infradead.org; Wed, 27 Apr 2022 17:18:44 +0000
Date: Wed, 27 Apr 2022 19:18:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 9/9] ptrace: Don't change __state
Message-ID: <20220427171829.GJ17421@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-9-ebiederm@xmission.com>
 <20220427160901.GI17421@redhat.com>
 <87o80m7afv.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87o80m7afv.fsf@email.froward.int.ebiederm.org>
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
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>

On 04/27, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > On 04/26, Eric W. Biederman wrote:
> >>
> >> @@ -253,7 +252,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
> >>  	 */
> >>  	if (lock_task_sighand(child, &flags)) {
> >>  		if (child->ptrace && child->parent == current) {
> >> -			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
> >> +			WARN_ON(child->jobctl & JOBCTL_DELAY_WAKEKILL);
> >
> > This WARN_ON() doesn't look right.
> >
> > It is possible that this child was traced by another task and PTRACE_DETACH'ed,
> > but it didn't clear DELAY_WAKEKILL.
>
> That would be a bug.  That would mean that PTRACE_DETACHED process can
> not be SIGKILL'd.

Why? The tracee will take siglock, clear JOBCTL_DELAY_WAKEKILL and notice
SIGKILL after that.

Oleg.

> > If the new debugger attaches and calls ptrace() before the child takes siglock
> > ptrace_freeze_traced() will fail, but we can hit this WARN_ON().
> 
> Eric
> 


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

