Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 28 Apr 2022 12:38:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
Message-ID: <YmpujwzYW/l3RB6O@hirez.programming.kicks-ass.net>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220426225211.308418-6-ebiederm@xmission.com>
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
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>

On Tue, Apr 26, 2022 at 05:52:08PM -0500, Eric W. Biederman wrote:
> Now that siglock keeps tsk->parent and tsk->real_parent constant
> require that do_notify_parent_cldstop is called with tsk->siglock held
> instead of the tasklist_lock.
> 
> As all of the callers of do_notify_parent_cldstop had to drop the
> siglock and take tasklist_lock this simplifies all of it's callers.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  kernel/signal.c | 156 +++++++++++++++++-------------------------------
>  1 file changed, 55 insertions(+), 101 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 72d96614effc..584d67deb3cb 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2121,11 +2121,13 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
>  				     bool for_ptracer, int why)
>  {
>  	struct kernel_siginfo info;
> -	unsigned long flags;
>  	struct task_struct *parent;
>  	struct sighand_struct *sighand;
> +	bool lock;
>  	u64 utime, stime;
>  
> +	assert_spin_locked(&tsk->sighand->siglock);

lockdep_assert_held() please...

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

