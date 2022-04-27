Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njjSw-001wth-0l
 for linux-um@lists.infradead.org; Wed, 27 Apr 2022 15:20:31 +0000
Date: Wed, 27 Apr 2022 17:20:18 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 8/9] ptrace: Use siglock instead of tasklist_lock in
 ptrace_check_attach
Message-ID: <20220427152016.GF17421@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-8-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220426225211.308418-8-ebiederm@xmission.com>
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

On 04/26, Eric W. Biederman wrote:
>
> +	if (lock_task_sighand(child, &flags)) {
> +		if (child->ptrace && child->parent == current) {
> +			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
> +			/*
> +			 * child->sighand can't be NULL, release_task()
> +			 * does ptrace_unlink() before __exit_signal().
> +			 */
> +			if (ignore_state || ptrace_freeze_traced(child))
> +				ret = 0;

The comment above is no longer relevant, it should be removed.

Oleg.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

