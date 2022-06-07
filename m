Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyb79-008HIi-4E
	for linux-um@lists.infradead.org; Tue, 07 Jun 2022 15:27:28 +0000
Date: Tue, 7 Jun 2022 17:26:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 07/16] signal: Wake up the designated parent
Message-ID: <20220607152627.GA10192@redhat.com>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <20220518225355.784371-7-ebiederm@xmission.com>
 <20220524132553.GD14347@redhat.com>
 <20220524162808.GF14347@redhat.com>
 <20220525142845.GA2687@redhat.com>
 <87a6ap30lh.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a6ap30lh.fsf@email.froward.int.ebiederm.org>
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

On 06/06, Eric W. Biederman wrote:
>
> Which if I have had enough sleep reduces this patch to just:
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index f072959fcab7..c8156366b722 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1431,8 +1431,10 @@ static int child_wait_callback(wait_queue_entry_t *wait, unsigned mode,
>         if (!eligible_pid(wo, p))
>                 return 0;
>
> -       if ((wo->wo_flags & __WNOTHREAD) && wait->private != p->parent)
> -               return 0;
> +       if ((wo->wo_flags & __WNOTHREAD) &&
> +           (wait->private != p->parent) &&
> +           (wait->private != p->real_parent))
> +                       return 0;
>
>         return default_wake_function(wait, mode, sync, key);
>  }
>
>
> I think that solves the issue without missing wake-ups without adding
> any more.

Agreed, and looks much simpler.

> For the same set of reasons it looks like the __wake_up_parent in
> __ptrace_detach is just simply dead code.  I don't think there is a case
> where when !ptrace_reparented the thread that is the real_parent can
> sleep in do_wait when the thread that was calling ptrace could not.

Yes... this doesn't really differ from the case when one thread reaps
a natural child and another thread sleep in do_wait().

> That needs a very close look to confirm.

Yes.

Oleg.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

