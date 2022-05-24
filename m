Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntUYL-0086Xr-4e
 for linux-um@lists.infradead.org; Tue, 24 May 2022 13:26:26 +0000
Date: Tue, 24 May 2022 15:25:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 07/16] signal: Wake up the designated parent
Message-ID: <20220524132553.GD14347@redhat.com>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <20220518225355.784371-7-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220518225355.784371-7-ebiederm@xmission.com>
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
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org, Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Douglas Miller <dougmill@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

I fail to understand this patch...

On 05/18, Eric W. Biederman wrote:
>
> Today if a process is ptraced only the ptracer will ever be woken up in
> wait

and why is this wrong?

> Fixes: 75b95953a569 ("job control: Add @for_ptrace to do_notify_parent_cldstop()")

how does this change fix 75b95953a569?

>  static int child_wait_callback(wait_queue_entry_t *wait, unsigned mode,
>  				int sync, void *key)
>  {
>  	struct wait_opts *wo = container_of(wait, struct wait_opts,
>  						child_wait);
> -	struct task_struct *p = key;
> +	struct child_wait_info *info = key;
>
> -	if (!eligible_pid(wo, p))
> +	if (!eligible_pid(wo, info->p))
>  		return 0;
>
> -	if ((wo->wo_flags & __WNOTHREAD) && wait->private != p->parent)
> -		return 0;
> +	if ((wo->wo_flags & __WNOTHREAD) && (wait->private != info->parent))
> +			return 0;

So. wait->private is the task T which sleeping on wait_chldexit.

Before the patch the logic is clear. T called do_wait(__WNOTHREAD) and
we do not need to wake it up if it is not the "actual" parent of p.

After the patch we check it T is actual to the "parent" arg passed to
__wake_up_parent(). Why??? This arg is only used to find the
->signal->wait_chldexit wait_queue_head, and this is fine.

As I said, I don't understand this patch. But at least this change is
wrong in case when __wake_up_parent() is calles by __ptrace_detach().
(you removed it in 5/16 but this looks wrong too). Sure, we can change
ptrace_detach() to use __wake_up_parent(p, p->parent), but for what?

I must have missed something.

Oleg.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

