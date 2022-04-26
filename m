Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njUgc-00GgU0-Fe
 for linux-um@lists.infradead.org; Tue, 26 Apr 2022 23:33:39 +0000
Received: by mail-ej1-x62b.google.com with SMTP id j6so57668ejc.13
 for <linux-um@lists.infradead.org>; Tue, 26 Apr 2022 16:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-4-ebiederm@xmission.com>
In-Reply-To: <20220426225211.308418-4-ebiederm@xmission.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 26 Apr 2022 16:33:24 -0700
Message-ID: <CAMo8BfJdDJ2tWPp0vNZ0SF2HkRGsytoVhnsnRMDcbSmGByH8zA@mail.gmail.com>
Subject: Re: [PATCH 4/9] ptrace/xtensa: Replace PT_SINGLESTEP with
 TIF_SINGLESTEP
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
Cc: LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>, mgorman@suse.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>

On Tue, Apr 26, 2022 at 3:52 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> xtensa is the last user of the PT_SINGLESTEP flag.  Changing tsk->ptrace in
> user_enable_single_step and user_disable_single_step without locking could
> potentiallly cause problems.
>
> So use a thread info flag instead of a flag in tsk->ptrace.  Use TIF_SINGLESTEP
> that xtensa already had defined but unused.
>
> Remove the definitions of PT_SINGLESTEP and PT_BLOCKSTEP as they have no more users.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/xtensa/kernel/ptrace.c | 4 ++--
>  arch/xtensa/kernel/signal.c | 4 ++--
>  include/linux/ptrace.h      | 6 ------
>  3 files changed, 4 insertions(+), 10 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

