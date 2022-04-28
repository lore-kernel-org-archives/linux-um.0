Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 28 Apr 2022 12:07:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/9] ptrace: cleaning up ptrace_stop
Message-ID: <YmpnaNIzudsk7JLI@hirez.programming.kicks-ass.net>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
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
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>

On Tue, Apr 26, 2022 at 05:50:21PM -0500, Eric W. Biederman wrote:
> ....  Peter Zijlstra has
> been rewriting the classic freezer and in earlier parts of this
> discussion so I presume it is also a problem for PREEMPT_RT.

Ah, the freezer thing is in fact a sched/arm64 issue, the common issue
between these two issues is ptrace though.

Specifically, on recent arm64 chips only a subset of CPUs can execute
arm32 code and 32bit processes are restricted to that subset. If by some
mishap you try and execute a 32bit task on a non-capable CPU it gets
terminated without prejudice.

Now, the current freezer has this problem that tasks can spuriously thaw
too soon (where too soon is before SMP is restored) which leads to these
32bit tasks being killed dead.

That, and it was a good excuse to fix up the current freezer :-)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

