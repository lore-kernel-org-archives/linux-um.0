Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njU1V-00GWL5-A7
 for linux-um@lists.infradead.org; Tue, 26 Apr 2022 22:51:10 +0000
From: "Eric W. Biederman" <ebiederm@xmission.com>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
Date: Tue, 26 Apr 2022 17:50:21 -0500
In-Reply-To: <87czhap9dy.fsf@email.froward.int.ebiederm.org> (Eric
 W. Biederman's message of "Thu, 21 Apr 2022 13:40:57 -0500")
Message-ID: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Subject: [PATCH 0/9] ptrace: cleaning up ptrace_stop
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
Cc: rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>


While looking at how ptrace is broken on PREEMPT_RT I realized
that ptrace_stop would be much simpler and more maintainable
if tsk->ptrace, tsk->parent, and tsk->real_parent were protected
by siglock.  Most of the changes are general cleanups in support
of this locking change.

While making the necessary changes to protect tsk->ptrace with
siglock I discovered we have two architectures xtensa and um
that were using tsk->ptrace for what most other architectures
use TIF_SIGPENDING for and not protecting tsk->ptrace with any lock.

By the end of this series ptrace should work on PREEMPT_RT with the
CONFIG_FREEZER and CONFIG_CGROUPS disabled, by the simple fact that the
ptrace_stop code becomes less special.  The function cgroup_enter_frozen
because it takes a lock which is a sleeping lock on PREEMPT_RT with
preemption disabled definitely remains a problem.  Peter Zijlstra has
been rewriting the classic freezer and in earlier parts of this
discussion so I presume it is also a problem for PREEMPT_RT.

Peter's series rewriting the freezer[1] should work on top of this
series with minimal changes and patch 2/5 removed.

Eric W. Biederman (9):
      signal: Rename send_signal send_signal_locked
      signal: Replace __group_send_sig_info with send_signal_locked
      ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP
      ptrace/xtensa: Replace PT_SINGLESTEP with TIF_SINGLESTEP
      signal: Protect parent child relationships by childs siglock
      signal: Always call do_notify_parent_cldstop with siglock held
      ptrace: Simplify the wait_task_inactive call in ptrace_check_attach
      ptrace: Use siglock instead of tasklist_lock in ptrace_check_attach
      ptrace: Don't change __state

 arch/um/include/asm/thread_info.h |   2 +
 arch/um/kernel/exec.c             |   2 +-
 arch/um/kernel/process.c          |   2 +-
 arch/um/kernel/ptrace.c           |   8 +-
 arch/um/kernel/signal.c           |   4 +-
 arch/xtensa/kernel/ptrace.c       |   4 +-
 arch/xtensa/kernel/signal.c       |   4 +-
 drivers/tty/tty_jobctrl.c         |   4 +-
 include/linux/ptrace.h            |   7 --
 include/linux/sched/jobctl.h      |   2 +
 include/linux/sched/signal.h      |   3 +-
 include/linux/signal.h            |   3 +-
 kernel/exit.c                     |   4 +
 kernel/fork.c                     |  12 +--
 kernel/ptrace.c                   |  61 ++++++-------
 kernel/signal.c                   | 187 ++++++++++++++------------------------
 kernel/time/posix-cpu-timers.c    |   6 +-
 17 files changed, 131 insertions(+), 184 deletions(-)

[1] https://lkml.kernel.org/r/20220421150248.667412396@infradead.org

Eric

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

