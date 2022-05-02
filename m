Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlXBh-001PSz-8C
 for linux-um@lists.infradead.org; Mon, 02 May 2022 14:38:13 +0000
Date: Mon, 2 May 2022 16:37:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 06/12] ptrace: Reimplement PTRACE_KILL by always
 sending SIGKILL
Message-ID: <20220502143750.GC17276@redhat.com>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <20220429214837.386518-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220429214837.386518-6-ebiederm@xmission.com>
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
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org, stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On 04/29, Eric W. Biederman wrote:
>
> Call send_sig_info in PTRACE_KILL instead of ptrace_resume.  Calling
> ptrace_resume is not safe to call if the task has not been stopped
> with ptrace_freeze_traced.

Oh, I was never, never able to understand why do we have PTRACE_KILL
and what should it actually do.

I suggested many times to simply remove it but OK, we probably can't
do this.

> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -1238,7 +1238,7 @@ int ptrace_request(struct task_struct *child, long request,
>  	case PTRACE_KILL:
>  		if (child->exit_state)	/* already dead */
>  			return 0;
> -		return ptrace_resume(child, request, SIGKILL);
> +		return send_sig_info(SIGKILL, SEND_SIG_NOINFO, child);

Note that currently ptrace(PTRACE_KILL) can never fail (yes, yes, it
is unsafe), but send_sig_info() can. If we do not remove PTRACE_KILL,
then I'd suggest

	case PTRACE_KILL:
		if (!child->exit_state)
			send_sig_info(SIGKILL);
		return 0;

to make this change a bit more compatible.

Also, please remove the note about PTRACE_KILL in set_task_blockstep().

Oleg.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

