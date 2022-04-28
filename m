Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 28 Apr 2022 12:27:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/9] signal: Rename send_signal send_signal_locked
Message-ID: <Ympr/+PX4XgT/UKU@hirez.programming.kicks-ass.net>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220426225211.308418-1-ebiederm@xmission.com>
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

On Tue, Apr 26, 2022 at 05:52:03PM -0500, Eric W. Biederman wrote:
> Rename send_signal send_signal_locked and make to make
> it usable outside of signal.c.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  include/linux/signal.h |  2 ++
>  kernel/signal.c        | 24 ++++++++++++------------
>  2 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index a6db6f2ae113..55605bdf5ce9 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -283,6 +283,8 @@ extern int do_send_sig_info(int sig, struct kernel_siginfo *info,
>  extern int group_send_sig_info(int sig, struct kernel_siginfo *info,
>  			       struct task_struct *p, enum pid_type type);
>  extern int __group_send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
> +extern int send_signal_locked(int sig, struct kernel_siginfo *info,
> +			      struct task_struct *p, enum pid_type type);
>  extern int sigprocmask(int, sigset_t *, sigset_t *);
>  extern void set_current_blocked(sigset_t *);
>  extern void __set_current_blocked(const sigset_t *);
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 30cd1ca43bcd..b0403197b0ad 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1071,8 +1071,8 @@ static inline bool legacy_queue(struct sigpending *signals, int sig)
>  	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
>  }
>  
> -static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struct *t,
> -			enum pid_type type, bool force)
> +static int __send_signal_locked(int sig, struct kernel_siginfo *info,
> +				struct task_struct *t, enum pid_type type, bool force)
>  {
>  	struct sigpending *pending;
>  	struct sigqueue *q;

While there, could you please replace that assert_spin_locked() with
lockdep_assert_held(&t->sighand->siglock) ?

The distinction being that assert_spin_locked() checks if the lock is
held *by*anyone* whereas lockdep_assert_held() asserts the current
context holds the lock.  Also, the check goes away if you build without
lockdep.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

