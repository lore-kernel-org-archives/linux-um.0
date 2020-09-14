Return-Path: <torvalds@linuxfoundation.org>
MIME-Version: 1.0
References: <20200914204209.256266093@linutronix.de>
In-Reply-To: <20200914204209.256266093@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Sep 2020 13:59:15 -0700
Message-ID: <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Content-Type: text/plain; charset="UTF-8"
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, alpha <linux-alpha@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Sep 14, 2020 at 1:45 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Recently merged code does:
>
>          gfp = preemptible() ? GFP_KERNEL : GFP_ATOMIC;
>
> Looks obviously correct, except for the fact that preemptible() is
> unconditionally false for CONFIF_PREEMPT_COUNT=n, i.e. all allocations in
> that code use GFP_ATOMIC on such kernels.

I don't think this is a good reason to entirely get rid of the no-preempt thing.

The above is just garbage. It's bogus. You can't do it.

Blaming the no-preempt code for this bug is extremely unfair, imho.

And the no-preempt code does help make for much better code generation
for simple spinlocks.

Where is that horribly buggy recent code? It's not in that exact
format, certainly, since 'grep' doesn't find it.

             Linus

