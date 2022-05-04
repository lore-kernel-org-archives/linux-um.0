Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmNfv-00D6H1-G7
 for linux-um@lists.infradead.org; Wed, 04 May 2022 22:40:52 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
Date: Wed, 04 May 2022 17:39:33 -0500
In-Reply-To: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org> (Eric
 W. Biederman's message of "Fri, 29 Apr 2022 16:46:59 -0500")
Message-ID: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Subject: [PATCH v3 0/11] ptrace: cleaning up ptrace_stop
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
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org


The states TASK_STOPPED and TASK_TRACE are special in they can not
handle spurious wake-ups.  This plus actively depending upon and
changing the value of tsk->__state causes problems for PREEMPT_RT and
Peter's freezer rewrite.

There are a lot of details we have to get right to sort out the
technical challenges and this is my parred back version of the changes
that contains just those problems I see good solutions to that I believe
are ready.

A couple of issues have been pointed but I think this parred back set of
changes is still on the right track.  The biggest change in v3 is that
instead of trying to prevent sending a spurious SIGTRAP when the tracer
dies with the tracee in ptrace_report_syscall, I have modified the code
to just stop trying.  While I still have taken TASK_WAKEKILL out of
TASK_TRACED I have implemented simpler logic in signal_wake_up.  Further
I have followed Oleg's advice and exit early from ptrace_stop if a fatal
signal is pending.

This set of changes should support Peter's freezer rewrite, and with the
addition of changing wait_task_inactive(TASK_TRACED) to be
wait_task_inactive(0) in ptrace_check_attach I don't think there are any
races or issues to be concerned about from the ptrace side.

More work is needed to support PREEMPT_RT, but these changes get things
closer.

I believe this set of changes will provide a firm foundation for solving
the PREEMPT_RT and freezer challenges.

With fewer lines added and more lines removed this set of changes looks
like it is moving in a good direction.

Eric W. Biederman (10):
      signal: Rename send_signal send_signal_locked
      signal: Replace __group_send_sig_info with send_signal_locked
      ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP
      ptrace/xtensa: Replace PT_SINGLESTEP with TIF_SINGLESTEP
      ptrace: Remove arch_ptrace_attach
      signal: Use lockdep_assert_held instead of assert_spin_locked
      ptrace: Reimplement PTRACE_KILL by always sending SIGKILL
      ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs
      ptrace: Don't change __state
      ptrace: Always take siglock in ptrace_resume

Peter Zijlstra (1):
      sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state

 arch/ia64/include/asm/ptrace.h    |   4 --
 arch/ia64/kernel/ptrace.c         |  57 ----------------
 arch/um/include/asm/thread_info.h |   2 +
 arch/um/kernel/exec.c             |   2 +-
 arch/um/kernel/process.c          |   2 +-
 arch/um/kernel/ptrace.c           |   8 +--
 arch/um/kernel/signal.c           |   4 +-
 arch/x86/kernel/step.c            |   3 +-
 arch/xtensa/kernel/ptrace.c       |   4 +-
 arch/xtensa/kernel/signal.c       |   4 +-
 drivers/tty/tty_jobctrl.c         |   4 +-
 include/linux/ptrace.h            |   7 --
 include/linux/sched.h             |  10 ++-
 include/linux/sched/jobctl.h      |   8 +++
 include/linux/sched/signal.h      |  20 ++++--
 include/linux/signal.h            |   3 +-
 kernel/ptrace.c                   |  87 ++++++++----------------
 kernel/sched/core.c               |   5 +-
 kernel/signal.c                   | 135 +++++++++++++++++---------------------
 kernel/time/posix-cpu-timers.c    |   6 +-
 20 files changed, 138 insertions(+), 237 deletions(-)

Eric

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

