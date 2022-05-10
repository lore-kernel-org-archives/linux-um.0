Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noQaQ-002Rta-5z
 for linux-um@lists.infradead.org; Tue, 10 May 2022 14:11:39 +0000
Date: Tue, 10 May 2022 16:11:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v4 0/12] ptrace: cleaning up ptrace_stop
Message-ID: <20220510141119.GA23277@redhat.com>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
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
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org

On 05/05, Eric W. Biederman wrote:
>
> Eric W. Biederman (11):
>       signal: Rename send_signal send_signal_locked
>       signal: Replace __group_send_sig_info with send_signal_locked
>       ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP
>       ptrace/xtensa: Replace PT_SINGLESTEP with TIF_SINGLESTEP
>       ptrace: Remove arch_ptrace_attach
>       signal: Use lockdep_assert_held instead of assert_spin_locked
>       ptrace: Reimplement PTRACE_KILL by always sending SIGKILL
>       ptrace: Document that wait_task_inactive can't fail
>       ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs
>       ptrace: Don't change __state
>       ptrace: Always take siglock in ptrace_resume
>
> Peter Zijlstra (1):
>       sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state

OK, lgtm.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


I still dislike you removed TASK_WAKEKILL from TASK_TRACED, but I can't
find a good argument against it ;) and yes, this is subjective.

Oleg.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

