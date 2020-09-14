Return-Path: <torvalds@linuxfoundation.org>
MIME-Version: 1.0
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rj4owfn.fsf@nanos.tec.linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Sep 2020 15:24:52 -0700
Message-ID: <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Content-Type: text/plain; charset="UTF-8"
To: Thomas Gleixner <tglx@linutronix.de>, Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, alpha <linux-alpha@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Sep 14, 2020 at 2:55 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Yes it does generate better code, but I tried hard to spot a difference
> in various metrics exposed by perf. It's all in the noise and I only
> can spot a difference when the actual preemption check after the
> decrement

I'm somewhat more worried about the small-device case.

That said, the diffstat certainly has its very clear charm, and I do
agree that it makes things simpler.

I'm just not convinced people should ever EVER do things like that "if
(preemptible())" garbage. It sounds like somebody is doing seriously
bad things.

The chacha20poly1305 code does look fundamentally broken. But no, the
fix is not to make "preemptible" work with spinlocks, the fix is to
not *do* that kind of broken things.

Those things would be broken even if you changed the semantics of
preemptible. There's no way that it's valid to say "use this debug
flag to decide if we should do atomic allocations or not".

It smells like "I got a debug failure, so I'm papering it over by
checking the thing the debug code checks for".

The debug check is to catch the obvious bad cases. It's not the _only_
bad cases, so copying the debug check test is just completely wrong.

Ard and Herbert added to participants: see
chacha20poly1305_crypt_sg_inplace(), which does

        flags = SG_MITER_TO_SG;
        if (!preemptible())
                flags |= SG_MITER_ATOMIC;

introduced in commit d95312a3ccc0 ("crypto: lib/chacha20poly1305 -
reimplement crypt_from_sg() routine").

You *fundamentally* cannot do that. Seriously. It's completely wrong.
Pick one or the other, or have the caller *tell* you what the context
is.

                Linus

