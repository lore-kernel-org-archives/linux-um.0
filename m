Return-Path: <tglx@linutronix.de>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
In-Reply-To: <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
Date: Mon, 14 Sep 2020 23:55:24 +0200
Message-ID: <871rj4owfn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, alpha <linux-alpha@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Sep 14 2020 at 13:59, Linus Torvalds wrote:
> On Mon, Sep 14, 2020 at 1:45 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Recently merged code does:
>>
>>          gfp = preemptible() ? GFP_KERNEL : GFP_ATOMIC;
>>
>> Looks obviously correct, except for the fact that preemptible() is
>> unconditionally false for CONFIF_PREEMPT_COUNT=n, i.e. all allocations in
>> that code use GFP_ATOMIC on such kernels.
>
> I don't think this is a good reason to entirely get rid of the
> no-preempt thing.

I did not say that this is a good reason. It just illustrates the
problem.

> The above is just garbage. It's bogus. You can't do it.
>
> Blaming the no-preempt code for this bug is extremely unfair, imho.

I'm not blaming the no-preempt code. I'm blaming inconsistency and there
is no real good argument for inconsistent behaviour, TBH.

> And the no-preempt code does help make for much better code generation
> for simple spinlocks.

Yes it does generate better code, but I tried hard to spot a difference
in various metrics exposed by perf. It's all in the noise and I only
can spot a difference when the actual preemption check after the
decrement which still depends on CONFIG_PREEMPT is in place, but that's
not the case for PREEMPT_NONE or PREEMPT_VOLUNTARY kernels where the
decrement is just a decrement w/o any conditional behind it.

> Where is that horribly buggy recent code? It's not in that exact
> format, certainly, since 'grep' doesn't find it.

Bah, that was stuff in next which got dropped again.

But just look at any check which uses preemptible(), especially those
which check !preemptible():

In the X86 #GP handler we have:

	/*
	 * To be potentially processing a kprobe fault and to trust the result
	 * from kprobe_running(), we have to be non-preemptible.
	 */
	if (!preemptible() &&
	    kprobe_running() &&
	    kprobe_fault_handler(regs, X86_TRAP_GP))
		goto exit;

and a similar check in the S390 code in kprobe_exceptions_notify(). That
all magically 'works' because that code might have been actually tested
with lockdep enabled which enforces PREEMPT_COUNT...

The SG code has some interesting usage as well:

		if (miter->__flags & SG_MITER_ATOMIC) {
			WARN_ON_ONCE(preemptible());
			kunmap_atomic(miter->addr);

How is that WARN_ON_ONCE() supposed to catch anything? Especially as
calling code does:

	flags = SG_MITER_TO_SG;
	if (!preemptible())
		flags |= SG_MITER_ATOMIC;

which is equally useless on kernels which have PREEMPT_COUNT=n.

There are bugs which are related to in_atomic() or other in_***() usage
all over the place as well.

Inconsistency at the core level is a clear recipe for disaster and at
some point we have to bite the bullet and accept that consistency is
more important than the non measurable 3 cycles?

Thanks,

        tglx

