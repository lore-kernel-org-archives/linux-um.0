Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6KQv-008cz8-9J
	for linux-um@lists.infradead.org; Tue, 28 Jun 2022 23:15:51 +0000
Date: Tue, 28 Jun 2022 19:15:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
Message-ID: <20220628191541.34a073fc@gandalf.local.home>
In-Reply-To: <YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
	<20220505182645.497868-12-ebiederm@xmission.com>
	<YrHA5UkJLornOdCz@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
	<877d5ajesi.fsf@email.froward.int.ebiederm.org>
	<YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
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
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, mgorman@suse.de, bigeasy@linutronix.de, Will Deacon <will@kernel.org>, tj@kernel.org, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org

On Tue, 21 Jun 2022 17:15:47 +0200
Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> So I assume (checked actually) the return 0 below from kernel/sched/core.c:
> wait_task_inactive() is where it bails out:
> 
> 3303                 while (task_running(rq, p)) {
> 3304                         if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
> 3305                                 return 0;
> 3306                         cpu_relax();
> 3307                 }
> 
> Yet, the child task is always found in __TASK_TRACED state (as seen
> in crash dumps):
> 
> > 101447  11342  13      ce3a8100      RU   0.0   10040   4412  strace  
>   101450  101447   0      bb04b200      TR   0.0    2272   1136  kill_child
>   108261  101447   2      d0b10100      TR   0.0    2272    532  kill_child
> crash> task bb04b200 __state  
> PID: 101450  TASK: bb04b200          CPU: 0   COMMAND: "kill_child"
>   __state = 8,
> 
> crash> task d0b10100 __state  
> PID: 108261  TASK: d0b10100          CPU: 2   COMMAND: "kill_child"
>   __state = 8,

If you are using crash, can you enable all trace events?

Then you should be able to extract the ftrace ring buffer from crash using
the trace.so extend (https://github.com/fujitsu/crash-trace)

I guess it should still work with s390.

Then you can see the events that lead up to the crash.

-- Steve

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

